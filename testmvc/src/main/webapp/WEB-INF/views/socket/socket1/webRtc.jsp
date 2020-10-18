<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebRTC demo</title>
<!--Bootstrap only for styling-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<!--Bootstrap only for styling-->
</head>
<style>
.container {
	background: rgb(148, 144, 144);
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
</style>

<body>

	<div class="container">
		<h1>A Demo for messaging in WebRTC</h1>

		<h3>
			Run two instances of this webpage along with the server to test this application.<br> Create an offer, and then send the message. <br>Check
			the browser console to see the output.
		</h3>

		<!--WebRTC related code-->
		<button type="button" class="btn btn-primary" onclick='createOffer()'>Create Offer</button>
		<input id="messageInput" type="text" class="form-control" placeholder="message">
		<button type="button" class="btn btn-primary" onclick='sendMessage()'>SEND</button>
		<%-- <script src="<%=request.getContextPath()%>/resources/clients.js"></script> --%>
		<!--WebRTC related code-->

	</div>
	<div class="footer">This application is intentionally made simple to avoid cluttering with non WebRTC related code.</div>
	<script>
		//connecting to our signaling server 
		var conn = new WebSocket('ws://localhost:9090/socket');

		conn.onopen = function() {
			console.log("Connected to the signaling server");
			initialize();
		};

		conn.onmessage = function(msg) {
			console.log("Got message", msg.data);
			var content = JSON.parse(msg.data);
			var data = content.data;
			switch (content.event) {
			// when somebody wants to call us
			case "offer":
				handleOffer(data);
				break;
			case "answer":
				handleAnswer(data);
				break;
			// when a remote peer sends an ice candidate to us
			case "candidate":
				handleCandidate(data);
				break;
			default:
				break;
			}
		};

		function send(message) {
			conn.send(JSON.stringify(message));
		}

		var peerConnection;
		var dataChannel;
		var input = document.getElementById("messageInput");

		function initialize() {
			var configuration = null;

			peerConnection = new RTCPeerConnection(configuration, {
				optional : [ {
					RtpDataChannels : true
				} ]
			});

			// Setup ice handling
			peerConnection.onicecandidate = function(event) {
				if (event.candidate) {
					send({
						event : "candidate",
						data : event.candidate
					});
				}
			};

			// creating data channel
			dataChannel = peerConnection.createDataChannel("dataChannel", {
				reliable : true
			});

			dataChannel.onerror = function(error) {
				console.log("Error occured on datachannel:", error);
			};

			// when we receive a message from the other peer, printing it on the console
			dataChannel.onmessage = function(event) {
				console.log("message:", event.data);
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
				alert("Error creating an offer");
			});
		}

		function handleOffer(offer) {
			peerConnection
					.setRemoteDescription(new RTCSessionDescription(offer));

			// create and send an answer to an offer
			peerConnection.createAnswer(function(answer) {
				peerConnection.setLocalDescription(answer);
				send({
					event : "answer",
					data : answer
				});
			}, function(error) {
				alert("Error creating an answer");
			});

		};

		function handleCandidate(candidate) {
			peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
		};

		function handleAnswer(answer) {
			peerConnection.setRemoteDescription(new RTCSessionDescription(
					answer));
			console.log("connection established successfully!!");
		};

		function sendMessage() {
			dataChannel.send(input.value);
			input.value = "";
		};

	
		
	</script>
</body>
</html>