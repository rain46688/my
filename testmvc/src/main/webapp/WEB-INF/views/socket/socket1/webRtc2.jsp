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

#board{
	border: 1px solid gray;
	background-color:rgb(200,200,200);
	width:100%;
	height:1000px;
	overflow-x: hidden;
	-ms-overflow-style: none;
}
#board>div{
	font-size:20px;
	color:yellow;
	font-weight:bold;
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
			<button type="button" class="btn btn-outline-success my-2 my-sm-0" onclick='host();'>방송시작</button>
			<button type="button" class="btn btn-outline-success my-2 my-sm-0" onclick='exit();'>연결 끊기</button>
			<br><br>
			<div id="board"></div>
		</section>
		<script>
	
	'use strict';

	//---------------------------- signaling 서버 -------------------------------------


const conn = new WebSocket('wss://localhost:8443/socketrtc');

	conn.onopen = function() {
		console.log("onopen => signaling server 연결");
		printdiv("signaling server 연결");
		gotStream();
	};

	conn.onmessage = function(msg) {
		console.log("onmessage => 메세지 출력 : "+msg);
		let content = JSON.parse(msg.data);
		console.log("content.type : "+content.type);
		printdiv(content.type);
		 if(content.type  === 'offer'){
			 console.log("offer");
			 createPeerConnection();
			 console.log("pc : "+pc);
			 pc.setRemoteDescription(new RTCSessionDescription(content));
			 doAnswer();
		 }else if(content.type  === 'answer'){
			 console.log("answer");
			 console.log("pc : "+pc);
			 pc.setRemoteDescription(new RTCSessionDescription(content));
		 }else if(content.type  === 'candidate'){
			 console.log("candidate");
			 console.log("pc : "+pc);
			  var candidate = new RTCIceCandidate({
			        sdpMLineIndex: content.label,
			        candidate: content.candidate
			      });
			      pc.addIceCandidate(candidate);
		 }else if(content.type  === 'bye'){
			 console.log("bye");
		     handleRemoteHangup();
		 }
	};
	
	conn.onclose = function() {
		console.log('onclose 실행');
	};

	function sendMessage(message) {
		conn.send(JSON.stringify(message));
		console.log("메세지 보내는 함수 sendMessage");
	};
	
	//---------------------------- 설정 -------------------------------------
	
	//마이크 비디오 설정
	const video1 = document.getElementById('video1');
	const video2 = document.getElementById('video2');
	let pc;
	let localStream;
	let remoteStream;
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
	
	function gotStream(stream){
	console.log('미디어 불러오기');

	navigator.mediaDevices.getUserMedia(constraints)
	.then(function(stream){
		//스트림 요청 성공
		printdiv("스트림 획득 성공");
		localStream = stream;
		console.log("localStream : "+localStream);
	})
	  //스트림 요청 실패
	  .catch(function(e) { 
			printdiv("스트림 획득 실패");
		    alert('카메라와 마이크를 허용해주세요 / 에러 : '+e.name);
	    });
	};
	
	
	//---------------------------- P2P 연결 로직 -------------------------------------
	
	function host(){
		video1.srcObject = localStream;
		createPeerConnection();
		pc.addStream(localStream);
		doCall();
	};
	

	function createPeerConnection(){
		console.log("createPeerConnection 실행");
		printdiv("createPeerConnection 실행");
		try{
			pc = new RTCPeerConnection(configuration);
			 
			printdiv("PC 객체 생성");
			pc.onicecandidate = handleIceCandidate;
			pc.onaddstream = handleRemoteStreamAdded;
			//pc.onremovestream = handleRemoteStreamRemoved;
			console.log(" RTCPeerConnection 생성 완료 ");
		}catch(e){
			console.log(" RTCPeerConnection 생성 에러발생 : "+e.message);
			alert("RTCPeerConnection 에러");
			return;
		}
	};
	
	function handleIceCandidate(event) {
		printdiv("handleIceCandidate 실행");
		  console.log('icecandidate 실행 event : '+ event);
		  if (event.candidate) {
			  console.log('icecandidate 응답 보내기 ');
				printdiv("event.candidate 분기문 진입");
		    sendMessage({
		      type: 'candidate',
		      label: event.candidate.sdpMLineIndex,
		      id: event.candidate.sdpMid,
		      candidate: event.candidate.candidate
		    });
		  } else {
		    console.log('handleIceCandidate 탐색 종료 ');
			printdiv("handleIceCandidate 탐색 종료");
		  }
	};
	
	function handleRemoteStreamAdded(event){
		console.log("RemoteStream 추가됨");
		//원격 스트림에 스트림을 넣어줌
		remoteStream = event.stream;
		video1.srcObject = remoteStream;
		printdiv("스트림 받아와서 VIDEO에 넣음");
	};
	
	function handleRemoteStreamRemoved(event) {
	 	 console.log('원격 스트림 삭제됨 Event : '+event);
	 	printdiv("handleRemoteStreamRemoved 실행");
	};
	
	function doCall(){
		console.log("createOff 함수를 통해서 통신 요청");
		printdiv("doCall 실행");
		pc.createOffer(setLocalAndSendMessage, handleCreateOfferError);
	};
	
	function doAnswer() {
		printdiv("doAnswer 실행");
		  console.log('peer에게 응답 보내기.');
		  pc.createAnswer().then(
		    setLocalAndSendMessage,
		    onCreateSessionDescriptionError
		  );
		};
	
	function setLocalAndSendMessage(sessionDescription) {
		printdiv("setLocalAndSendMessage 실행");
		  pc.setLocalDescription(sessionDescription);
		console.log("setLocalAndSendMessage 응답 보내기 : "+sessionDescription);
		  sendMessage(sessionDescription);
		};
	
		
		//연결 끊기
		
			function handleRemoteHangup() {
				  console.log('Session 종료.');
				  stop();
				  isInitiator = false;
				};
				
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
			
			function printdiv(msg){
				$("#board").append("<div>"+msg+"</div>");
			}
		//---------------------------- 에러 -------------------------------------

		function handleCreateOfferError(event) {
					console.log('Offer부분 생성 에러 error: ', event);
			};	
				
		function onCreateSessionDescriptionError(error) {
				trace('onCreateSessionDescriptionError 에러 : ' + error.toString());
			}
		
	
		
	</script>
</body>
</html>