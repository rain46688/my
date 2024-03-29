<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title>멀티 RTC 삽질</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
<script src="https://rtcmulticonnection.herokuapp.com/dist/RTCMultiConnection.min.js"></script>
<script src="${path }/resources/js/adapter.js"></script>
<script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>
<link rel="stylesheet" href="${path }/resources/js/getHTMLMediaElement.css">
<script src="${path }/resources/js/getHTMLMediaElement.js"></script>
<style>
label, input {
	max-width: 300px;
}

.make-center {
	padding: 5em;
}
</style>
</head>
<body>
	<section class="make-center">
		<input type="text" id="room-id" value="abcdef" autocorrect=off autocapitalize=off size=20 class="form-control short">
		<button id="open-room" class="btn btn-outline-success">방 만들기</button>
		<button id="join-room" class="btn btn-outline-success">방 참여</button>
		<button id="open-or-join-room" class="btn btn-outline-success">방만들면서 참여하기</button>
		<div id="videos-container" style="margin: 20px;"></div>
		<div id="room-urls"
			style="text-align: center; display: none; background: #F1EDED; margin: 15px -10px; border: 1px solid rgb(189, 189, 189); border-left: 0; border-right: 0;"></div>
	</section>
	<script>
		document.getElementById('open-room').onclick = function() {
			disableInputButtons();
			connection.open(document.getElementById('room-id').value,
					function() {
						showRoomURL(connection.sessionid);
					});
		};

		document.getElementById('join-room').onclick = function() {
			disableInputButtons();

			connection.sdpConstraints.mandatory = {
				OfferToReceiveAudio : true,
				OfferToReceiveVideo : true
			};
			connection.join(document.getElementById('room-id').value);
		};

		document.getElementById('open-or-join-room').onclick = function() {
			disableInputButtons();
			connection.openOrJoin(document.getElementById('room-id').value,
					function(isRoomExist, roomid) {
						if (isRoomExist === false
								&& connection.isInitiator === true) {
							showRoomURL(roomid);
						}

						if (isRoomExist) {
							connection.sdpConstraints.mandatory = {
								OfferToReceiveAudio : true,
								OfferToReceiveVideo : true
							};
						}
					});
		};

		var connection = new RTCMultiConnection();

		connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';

		connection.socketMessageEvent = 'video-broadcast-demo';

		connection.session = {
			audio : true,
			video : true,
			oneway : true
		};

		connection.sdpConstraints.mandatory = {
			OfferToReceiveAudio : false,
			OfferToReceiveVideo : false
		};

		connection.iceServers = [ {
			'urls' : [ 'stun:stun.l.google.com:19302',
					'stun:stun1.l.google.com:19302',
					'stun:stun2.l.google.com:19302',
					'stun:stun.l.google.com:19302?transport=udp', ]
		} ];

		connection.videosContainer = document
				.getElementById('videos-container');
		connection.onstream = function(event) {
			var existing = document.getElementById(event.streamid);
			if (existing && existing.parentNode) {
				existing.parentNode.removeChild(existing);
			}

			event.mediaElement.removeAttribute('src');
			event.mediaElement.removeAttribute('srcObject');
			event.mediaElement.muted = true;
			event.mediaElement.volume = 0;

			var video = document.createElement('video');

			try {
				video.setAttributeNode(document.createAttribute('autoplay'));
				video.setAttributeNode(document.createAttribute('playsinline'));
			} catch (e) {
				video.setAttribute('autoplay', true);
				video.setAttribute('playsinline', true);
			}

			if (event.type === 'local') {
				video.volume = 0;
				try {
					video.setAttributeNode(document.createAttribute('muted'));
				} catch (e) {
					video.setAttribute('muted', true);
				}
			}
			video.srcObject = event.stream;

			var width = parseInt(connection.videosContainer.clientWidth / 3) - 20;
			var mediaElement = getHTMLMediaElement(video, {
				title : event.userid,
				buttons : [ 'full-screen' ],
				width : width,
				showOnMouseEnter : false
			});

			connection.videosContainer.appendChild(mediaElement);

			setTimeout(function() {
				mediaElement.media.play();
			}, 5000);

			mediaElement.id = event.streamid;
		};

		connection.onstreamended = function(event) {
			var mediaElement = document.getElementById(event.streamid);
			if (mediaElement) {
				mediaElement.parentNode.removeChild(mediaElement);

				if (event.userid === connection.sessionid
						&& !connection.isInitiator) {
					alert('Broadcast is ended. We will reload this page to clear the cache.');
					location.reload();
				}
			}
		};

		connection.onMediaError = function(e) {
			if (e.message === 'Concurrent mic process limit.') {
				if (DetectRTC.audioInputDevices.length <= 1) {
					alert('Please select external microphone. Check github issue number 483.');
					return;
				}

				var secondaryMic = DetectRTC.audioInputDevices[1].deviceId;
				connection.mediaConstraints.audio = {
					deviceId : secondaryMic
				};

				connection.join(connection.sessionid);
			}
		};

		function disableInputButtons() {
			document.getElementById('room-id').onkeyup();

			document.getElementById('open-or-join-room').disabled = true;
			document.getElementById('open-room').disabled = true;
			document.getElementById('join-room').disabled = true;
			document.getElementById('room-id').disabled = true;
		}

		function showRoomURL(roomid) {

		}

		(function() {
			var params = {}, r = /([^&=]+)=?([^&]*)/g;

			function d(s) {
				return decodeURIComponent(s.replace(/\+/g, ' '));
			}
			var match, search = window.location.search;
			while (match = r.exec(search.substring(1)))
				params[d(match[1])] = d(match[2]);
			window.params = params;
		})();

		var roomid = '';
		if (localStorage.getItem(connection.socketMessageEvent)) {
			roomid = localStorage.getItem(connection.socketMessageEvent);
		} else {
			roomid = connection.token();
		}
		document.getElementById('room-id').value = roomid;
		document.getElementById('room-id').onkeyup = function() {
			localStorage.setItem(connection.socketMessageEvent, document
					.getElementById('room-id').value);
		};

		var hashString = location.hash.replace('#', '');
		if (hashString.length && hashString.indexOf('comment-') == 0) {
			hashString = '';
		}

		var roomid = params.roomid;
		if (!roomid && hashString.length) {
			roomid = hashString;
		}

		if (roomid && roomid.length) {
			document.getElementById('room-id').value = roomid;
			localStorage.setItem(connection.socketMessageEvent, roomid);

			// auto-join-room
			(function reCheckRoomPresence() {
				connection.checkPresence(roomid, function(isRoomExist) {
					if (isRoomExist) {
						connection.join(roomid);
						return;
					}

					setTimeout(reCheckRoomPresence, 5000);
				});
			})();

			disableInputButtons();
		}

		// detect 2G
		if (navigator.connection && navigator.connection.type === 'cellular'
				&& navigator.connection.downlinkMax <= 0.115) {
			alert('2G is not supported. Please use a better internet service.');
		}
	</script>
</body>
</html>
