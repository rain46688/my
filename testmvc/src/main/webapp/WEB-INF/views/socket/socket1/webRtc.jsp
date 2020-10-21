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
/* 	background: rgb(200, 200, 200); */
	border: 1px solid black; 
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

#text {
	margin-top: 2em;
	/* background: rgb(50, 50, 50); */
	width: 100%;
	height: 200px;
	color: white;
	text-align: center;
	font-size: 20px;
}
</style>

<body>
	<div class="container">
		<video id="video1" autoplay playsinline constrols preload="metadata"></video>
		<video id="video2" autoplay playsinline constrols preload="metadata"></video>
		<br>
		<button type="button" class="btn btn-primary" onclick='connection();'>연결</button>
		<!-- <input id="messageInput" type="text" class="form-control" placeholder="message"> -->
		<button type="button" class="btn btn-primary" onclick='hangup();'>연결 끊기</button>
		<!-- <div id="text"></div> -->
	</div>
	<script>
	
	'use strict';
	
	//signaling 서버
	var conn = new WebSocket('ws://localhost:9090/socketrtc');

	conn.onopen = function() {
		console.log("onopen => signaling server 연결");
	};

	conn.onmessage = function(msg) {
		console.log("onmessage => 메세지 출력 : "+msg);
		let content = JSON.parse(msg.data);
		console.log("메세지 타입 : "+content);
		console.log("컨텐드 타입 : "+content.type);
		if(content.type === 'gotmedia'){
			console.log(" === 분기 gotmedia === ");
			console.log("방을 처음 만든사람")
			start();
		}else if(content.type  === 'offer'){
			console.log(" === 분기 offer === ");
			if(!isInitiator && !isStarted){
				console.log(" === 분기 offer 2 === ");
				start();
			}
			pc.setRemoteDescription(new RTCSessionDescription(content));
			 doAnswer();
		} else if (content.type  === 'answer' && isStarted) {
			console.log(" === 분기 answer === ");
			 pc.setRemoteDescription(new RTCSessionDescription(content));
		} else if (content.type  === 'candidate' && isStarted) {
			console.log(" === 분기 candidate === ");
		    var candidate = new RTCIceCandidate({
		        sdpMLineIndex: content.label,
		        candidate: content.candidate
		      });
		      pc.addIceCandidate(candidate);
		    } else if (content.type  === 'bye' && isStarted) {
				console.log(" === 분기 bye === ");
		      handleRemoteHangup();
		    }
	};
	
	conn.onclose = function() {
		console.log('onclose 실행');
	};

	function sendMessage(message) {
		console.log("send : "+message);
		conn.send(JSON.stringify(message));
	}
	
	//-------------------------------------------------------------
	
	//마이크 비디오 설정
	const video1 = document.getElementById('video1');
	const video2 = document.getElementById('video2');
	let isStarted = false;
	let pc;
	let isInitiator = false;//방이 열려있는지 여부, 일단 열려있다 치자
	let localStream;
	let remoteStream;
	let isChannelReady = true;
	
	//TURN & STUN 서버 등록
	var configuration = {
			  'iceServers': [
				    {
				      'urls': 'stun:stun.l.google.com:19302'
				    },
				    {
				    	'url': 'turn:numb.viagenie.ca',
				    	'credential': 'muazkh',
				    	'username': 'webrtc@live.com'
				    }
				  ]
		};

	const constraints = {
		    video: true,
		    audio : true
		};
	
	navigator.mediaDevices.getUserMedia(constraints)
	.then(gotStream)
	  //스트림 요청 실패
	  .catch(function(e) { 
		    alert('카메라와 마이크를 허용해주세요 / 에러 : '+e.name);
	    });
	
	function gotStream(stream){
			//스트림 요청 성공
			 console.log('스트림 요청 성공');
			localStream = stream;
			video1.srcObject = stream;
			sendMessage({type:'gotmedia'});
			//sendMessage('gotmedia');
			if(isInitiator){
				console.log("gotStream 부분 start 실행");
				start();
			}
		
	};
	
	function start(){
		console.log("start 함수 실행 : "+!isStarted+", "+(typeof localStream !== 'undefined')+", "+(isChannelReady));
		
		if(!isStarted && typeof localStream !== 'undefined' && isChannelReady){
			console.log("peer 연결 부분 분기 진입");
			createPeerConnection();
			pc.addStream(localStream);
			console.log("isStarted 트루");
			isStarted = true;
			console.log("isInitiator : "+isInitiator);
			if(isInitiator){
				doCall();
			}
		}
		
	};
	
	function createPeerConnection(){
		console.log("createPeerConnection 실행");
		try{
			//configuration에는 STUN & TURN 서버가 있음
			//통신이 중단됬을때 사용되는 임시서버라 개념이라함.
			pc = new RTCPeerConnection(configuration);
			pc.onicecandidate = handleIceCandidate;
			pc.onaddstream = handleRemoteStreamAdded;
			pc.onremovestream = handleRemoteStreamRemoved;
			console.log(" RTCPeerConnection 생성 완료 ");
		}catch(e){
			console.log(" RTCPeerConnection 생성 에러발생 : "+e.message);
			alert("RTCPeerConnection 에러");
			return;
		}
		
	};
	
	function handleRemoteStreamAdded(event){
		console.log("RemoteStream 추가됨");
		//원격 스트림에 스트림을 넣어줌
		remoteStream = event.stream;
		video2.srcObject = remoteStream;
	};
	
	function doCall(){
		console.log("createOff 함수를 통해서 통신 요청");
		pc.createOffer(setLocalAndSendMessage, handleCreateOfferError);
	};
	
	function doAnswer() {
		  console.log('peer에게 응답 보내기.');
		  pc.createAnswer().then(
		    setLocalAndSendMessage,
		    onCreateSessionDescriptionError
		  );
		};
	
	//핸들러 후보 상대방 탐색
	function handleIceCandidate(event) {
		  console.log('icecandidate 실행 event : '+ event);
		  if (event.candidate) {
		    sendMessage({
		      type: 'candidate',
		      label: event.candidate.sdpMLineIndex,
		      id: event.candidate.sdpMid,
		      candidate: event.candidate.candidate
		    });
		  } else {
		    console.log(' handleIceCandidate 탐색 종료 ');
		  }
	};
	
	function handleRemoteStreamRemoved(event) {
		 	 console.log('원격 스트림 삭제됨 Event : '+event);
		};
		
		function setLocalAndSendMessage(sessionDescription) {
			  pc.setLocalDescription(sessionDescription);
			console.log("setLocalAndSendMessage 실행 : "+sessionDescription);
			  sendMessage(sessionDescription);
			};
		
			function handleRemoteHangup() {
				  console.log('Session 종료.');
				  stop();
				  isInitiator = false;
				};
				
			function connection(){
				isInitiator = true;
				start();
			}
					
			//연결 끊기
			function hangup() {
				  stop();
				  sendMessage({type:'bye'});
				};
		
			function stop() {
				  console.log('연결 종료');
				  isStarted = false;
				  pc.close();
				  pc = null;
				};
				
		//-------------------------------------------------------------

		function handleCreateOfferError(event) {
					console.log('Offer부분 생성 에러 error: ', event);
			};	
				
		function onCreateSessionDescriptionError(error) {
				trace('onCreateSessionDescriptionError 에러 : ' + error.toString());
			}
				
				
				
		
	</script>
</body>
</html>