<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RTC 삽질</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<style>
.container {
	border: 1px solid black;
	border-radius: 8px;
	margin: 50px auto;
	max-width: 80%;
	text-align: center;
	padding: 2%;
}

video {
	width: 40%;
	height: 50%;
	float: center;
}

#text {
	margin-top: 2em;
	width: 100%;
	height: 200px;
	color: white;
	text-align: center;
	font-size: 20px;
}

#board {
	border: 1px solid gray;
	background-color: rgb(200, 200, 200);
	width: 100%;
	height: 1000px;
	overflow-x: hidden;
	-ms-overflow-style: none;
}

#board>div {
	font-size: 20px;
	color: yellow;
	font-weight: bold;
}
/* 스크롤 바 투명하게 만들기 */
::-webkit-scrollbar {
	display: none;
}
</style>

<body>
	<section>
		<section class="container">
			<video id="video1" autoplay playsinline controls preload="metadata"></video>
			<br> <br>
			<!-- <button type="button" class="btn btn-outline-success my-2 my-sm-0" onclick='host();'>방송시작</button> -->
			<!-- <button type="button" class="btn btn-outline-success my-2 my-sm-0" onclick='exit();'>연결 끊기</button> -->
		<br>
			<br>
			<div id="board"></div>
		</section>
		<script>
	
	'use strict';
	
	//---------------------------- 설정 -------------------------------------
	
	//마이크 비디오 설정
	const video1 = document.getElementById('video1');
	let pc;
	let localStream;
	let remoteStream;
	const configuration = {
			  'iceServers': [
				    {
				      url: 'stun:stun.l.google.com:19302'
				    },
				    {
				    	url: 'turn:numb.viagenie.ca',
				    	credential: 'muazkh',
				    	username: 'webrtc@live.com'
				    }
				  ]
		};


	//---------------------------- signaling 서버 -------------------------------------


const conn = new WebSocket('wss://localhost:8443/socketrtc');

	conn.onopen = function() {
		console.log("signaling server 연결");
		printdiv("signaling server 연결");
		start();
	};

	conn.onmessage = function(msg) {
		if (!pc){
		    start();
		    printdiv("onmessage start()");
		}
		
		let content = JSON.parse(msg.data);
		
		if(content.sdp){
			printdiv("sdp");
			pc.setRemoteDescription(new RTCSessionDescription(content.sdp), function () {
			      if (pc.remoteDescription.type == 'offer')
			        pc.createAnswer(localDescCreated, logError);
			    }, logError);
		}else{
			printdiv("!sdp"+msg);
			 pc.addIceCandidate(new RTCIceCandidate(content.candidate));
		}
	};
	
	conn.onclose = function() {
		console.log('onclose 실행');
	};

	function sendMessage(message) {
		conn.send(JSON.stringify(message));
		console.log("메세지 보내는 함수 sendMessage");
	};
	
	
	//---------------------------- P2P 연결 로직 -------------------------------------
	
	function start(){
		printdiv("start()");
		pc = new RTCPeerConnection(configuration);
		 pc.onicecandidate = function (evt) {
		    	printdiv("pc.onicecandidate");
			    if (evt.candidate){
			    	sendMessage({
			    		  'candidate': evt.candidate
			    	});
			    }
			};
		 
	 pc.onnegotiationneeded = function () {
		 printdiv("pc.onnegotiationneeded");
			    pc.createOffer(localDescCreated, logError);
			};

	 pc.onaddstream = function (evt) {
		 printdiv("pc.onaddstream");
		 //video1.src = URL.createObjectURL(evt.stream);
		 video1.srcObject = evt.stream;
		 };
	
	  navigator.getUserMedia({
					    'audio': true,
					    'video': true
					  }, function (stream) {
						  printdiv("스트림 얻기");
						 // video1.src = URL.createObjectURL(stream);
						 video1.srcObject =stream;
					    pc.addStream(stream);
					  }, logError);
					};
					
	function localDescCreated(desc) {
		  pc.setLocalDescription(desc, function () {
			  printdiv("pc.setLocalDescription");
			  sendMessage({
				  'sdp': pc.localDescription
	    	});
		  }, logError);
		};

		
		//---------------------------- 에러 -------------------------------------
		
		function logError(error) {
			  console.log(error.name + ': ' + error.message);
			  $("#board").append("<div>"+error.name + ': ' + error.message+"</div>");
			}
		
		function printdiv(msg){
			$("#board").append("<div>"+msg+"</div>");
		}
		
	</script>
</body>
</html>