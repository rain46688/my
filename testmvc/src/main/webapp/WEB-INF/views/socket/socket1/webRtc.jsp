<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RTC 삽질</title>
<!--Bootstrap only for styling-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<!--Bootstrap only for styling-->
</head>
<style>
.container {
	background: rgb(200, 200, 200);
	margin: 50px auto;
	max-width: 80%;
	text-align: center;
	padding: 2%;
}

button {
	margin: 1em;
}

input {
	margin-top: 1em;
}

.footer {
	background: rgb(148, 144, 144);
	text-align: center;
	padding: 2%;
	position: absolute;
	bottom: 0;
	width: 100%;
}

video {
	width: 40%;
	height: 300px;
	border: 1px solid black;
	float: center;
}

#text{
	margin-top:2em;
	background: rgb(50, 50, 50);
	width:100%;
	height:200px;
	color:white;
	text-align:center;
	font-size:20px;
}
</style>

<body>
	<div class="container">
		<video id="video1" autoplay playsinline></video>
		<video id="video2" autoplay playsinline></video>
		<br>
		<button type="button" class="btn btn-primary" onclick='createOffer()'>영상</button>
		<input id="messageInput" type="text" class="form-control" placeholder="message">
		<button type="button" class="btn btn-primary" onclick='sendMessage()'>메세지 보내기</button>
		<div id="text">
		</div>
	</div>
	<script>
	
	//마이크 비디오 설정
	const video1 = document.getElementById('video1');
	const video2 = document.getElementById('video2');

	const constraints = {
		    video: true,
		    audio : true
		};
	
	navigator.mediaDevices.getUserMedia(constraints).
	  then(function(stream) { 
		  console.log("비디오 : "+video1);
		  console.log("비디오2 : "+video2);
		  console.log('success', arguments);
		  video1.srcObject = stream;
		  peerConnection.addStream(stream);
		  
			peerConnection.onaddstream = function(event) {
				console.log(" === onaddstream === ")
				video2.srcObject = event.stream;
			};
	  }).catch(function(err) { 
	        console.log('error', arguments);
		    alert('카메라와 마이크를 허용해주세요');
	    });

	//--------------------------------------------------------------------------
	
		//signaling 서버
		var conn = new WebSocket('ws://localhost:9090/socketrtc');

		conn.onopen = function() {
			console.log("signaling server 연결");
			start();
		};

		conn.onmessage = function(msg) {
			console.log("메세지 출력 : ", msg.data);
			var content = JSON.parse(msg.data);
			var data = content.data;
			switch (content.event) {
			case "offer":
				handleOffer(data);
				break;
			case "answer":
				handleAnswer(data);
				break;
			// ice candidate 즉 상대의 ip와 port를 탐색함
			case "candidate":
				handleCandidate(data);
				break;
			default:
				break;
			}
		};

		function send(message) {
			console.log("send : "+message);
			conn.send(JSON.stringify(message));
		}
		
		var peerConnection;
		var dataChannel;
		var input = document.getElementById("messageInput");
		
		//TURN & STUN 서버 등록
		var configuration = {
				  'iceServers': [
					    {
					      'urls': 'stun:stun.l.google.com:19302'
					    },
					    {
					      'urls': 'turn:13.250.13.83:3478?transport=udp',
					      'credential': 'YzYNCouZM1mhqhmseWk6',
					      'username': 'YzYNCouZM1mhqhmseWk6'
					    },
					    {
					    	'url': 'turn:numb.viagenie.ca',
					    	'credential': 'muazkh',
					    	'username': 'webrtc@live.com'
					    }
					  ]
			};
		
		function start() {

			peerConnection = new RTCPeerConnection(configuration, {
				optional : [ {
					//RtpDataChannels : false
					RtpDataChannels : true
				} ]
			});

			// 핸들러를 통해 현재 내 클라이언트의 ICE Candidate(네트워크 정보)가 확보되면 실행될 Callback을 전달함.
			peerConnection.onicecandidate = function(event) {
				if (event.candidate) {
					send({
						event : "candidate",
						data : event.candidate
					}); 
				}
			};

			// 데이터 채널 개설
			dataChannel = peerConnection.createDataChannel("dataChannel", {
				reliable : true
			});

			dataChannel.onerror = function(error) {
				console.log("Error occured on datachannel:", error);
			};

			// 다른 세션에서 전달받은 메세지를 보여줌
			dataChannel.onmessage = function(event) {
				console.log("message:", event.data);
				$('#text').append("<p>"+event.data+"</p>");
			};

			dataChannel.onclose = function() {
				console.log("data channel is closed");
			};
		}

		function createOffer() {
			peerConnection.createOffer(function(offer) {
				send({
					event : "offer",
					data : offer
				});
				peerConnection.setLocalDescription(offer);
			}, function(error) {
				alert("에러 : Offer");
			});
		}

		//핸들러 제안
		function handleOffer(offer) {
			peerConnection
					.setRemoteDescription(new RTCSessionDescription(offer));

			//제안에 대한 응답을 생성하여서 발송.
			peerConnection.createAnswer(function(answer) {
				peerConnection.setLocalDescription(answer);
				send({
					event : "answer",
					data : answer
				});
			}, function(error) {
				alert("에러 : answer");
			});

		};

		//핸들러 후보 상대방 탐색
		function handleCandidate(candidate) {
			peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
		};

		//핸들러 응답
		function handleAnswer(answer) {
			peerConnection.setRemoteDescription(new RTCSessionDescription(
					answer));
			console.log("두 세션 연결 완료");
		};

		//메세지 발송
		function sendMessage() {
			console.log("메세지 발송"+input.value)
			dataChannel.send(input.value);
			input.value = "";
		};
		
	</script>
</body>
</html>