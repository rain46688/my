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
	border-radius:8px;
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
</style>

<body>
	<section>
		<section class="container">
			<h3>ME</h3>
			<video id="video1" autoplay playsinline controls preload="metadata"></video>
			<h3>Another</h3>
			<video id="video2" autoplay playsinline controls preload="metadata"></video>
			<br>
			<br>
			<button type="button" class="btn btn-outline-success my-2 my-sm-0" onclick='connection();'>연결</button>
			<button type="button" class="btn btn-outline-success my-2 my-sm-0" onclick='exit();'>연결 끊기</button>
		</section>
	<script>
	
	'use strict';

	//---------------------------- signaling 서버 -------------------------------------
	
/* 	var conn = new WebSocket('ws://192.168.219.100:9090/socketrtc'); */

const conn = new WebSocket('wss://192.168.219.105:8443/socketrtc');

	conn.onopen = function() {
		console.log("onopen => signaling server 연결");
	};

	conn.onmessage = function(msg) {
		console.log("onmessage => 메세지 출력 : "+msg);
		let content = JSON.parse(msg.data);
		console.log("content.type : "+content.type);
		if(content.type === 'host'){
			console.log(" === 분기 host === ");
			console.log("방을 처음 만든사람");
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
		conn.send(JSON.stringify(message));
	};
	
	//---------------------------- 설정 -------------------------------------
	
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

	
	//---------------------------- 비디오 -------------------------------------
	
	
	const constraints = {
			  video: {width: {exact: 1280}, height: {exact: 720}},
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
			 console.log('stream 함수 => 스트림 요청 성공');
			localStream = stream;
			video1.srcObject = stream;
			sendMessage({type:'host'});
			if(isInitiator){
				console.log("gotStream 함수 => start 실행");
				start();
			}
	};
	
	
	//---------------------------- P2P 연결 로직 -------------------------------------
	
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
			//STUN : Session Traversal Utilities for NAT의 약자로 자신의 공인 아이피를 알아오기위해 STUN 서버에 요청하고 STUN 서버는 공인 IP주소를 응답함.
			//TURN : Traversal Using Relays around NAT 의 약자 NAT 또는 방화벽에서 보조하는 프로토콜. 클라이언트는 직접 서버와 통신 하지않고 TURN 서버를 경유함.
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
	//ICE : Interactive Connectivity Establishment의 약자로 두 단말이 서로 통신할수 있는 최적의 경로를 찾을수있도록 도와주는 프레임워크임.
	function handleIceCandidate(event) {
		  console.log('icecandidate 실행 event : '+ event);
		  if (event.candidate) {
			  console.log('icecandidate 응답 보내기 ');
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
			console.log("setLocalAndSendMessage 응답 보내기 : "+sessionDescription);
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
			function exit() {
				/* conn.close(); */
				  stop();
				  console.log('연결 종료 응답 보내기 ');
				  sendMessage({type:'bye'});
				};
		
			function stop() {
				  console.log('연결 종료');
				  isStarted = false;
				  pc.close();
				  pc = null;
				};
				
	//---------------------------- 에러 -------------------------------------

		function handleCreateOfferError(event) {
					console.log('Offer부분 생성 에러 error: ', event);
			};	
				
		function onCreateSessionDescriptionError(error) {
				trace('onCreateSessionDescriptionError 에러 : ' + error.toString());
			}
		
	/* 	window.onunload = window.onbeforeunload = (function(){myFunction()})
		
		function myFunction(){
			exit();
		};
		 */
		
	</script>
</body>
</html>