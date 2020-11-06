<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="${path}/resources/images/logo.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="google-signin-client_id" content="109451624786-3quf002c334a2alg5u0cu3prcu5593hh.apps.googleusercontent.com">
<title>nbbang</title>
<script src="${path}/resources/js/jquery-3.5.1.min.js"></script>
<link href="${path}/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="${path}/resources/js/bootstrap.bundle.min.js"></script>
<link href="${path}/resources/css/section.css" rel="stylesheet">
<link href="${path}/resources/css/header.css" rel="stylesheet">
<link href="${path}/resources/css/footer.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
</head>

<style>
#profile {
	witdh: 60px;
	height: 60px;
	border-radius: 70%;
	border: 2px solid black;
	margin-right: 5px;
}

#al {
	width: 35px;
	height: 35px;
	/* border: 1px solid black; */
	display: inline-block;
	color: yellow;
	background-color: red;
	border-radius: 70%;
	font-weight: bold;
	font-size: 30px;
	position: relative;
	z-index: 2;
	top: 20px;
	left: -2px;
	right: 4px;
	text-align: center;
	font-size: 25px;
	 box-shadow: 1px 1px 1px 1px gray;
}

#bell {
	z-index: 1;
	left: 30px;
}
.bell2{
	position: relative;
}
</style>

<body>
	<div id="container">
		<header>
			<div id="topField">
				<div id="logoContainer">
					<a href="${path}/"> <img src="${path}/resources/images/logoTitle.png" id="logoTitle" alt="logoTitle">
					</a>
				</div>
				<div id="searchSection">
					<input type="text" name="searchKeyword" id="searchKeyword" onkeypress="enterkey();">
					<div id="searchImage" onclick="fn_search('overall');">
						<img src="${path}/resources/images/search.png" alt="" width="30px" height="30px">
					</div>
				</div>
				<div id="topBtn">
					<c:if test="${loginnedMember.usid != null}">
						<a id="bell" class="bell2" href="/alarmList?usid=${loginnedMember.usid }"><img src="${path }/resources/images/bell.png" style="width: 60px; height: 60px;"></a>
						<c:if test="${loginnedMember.usid != null}">
						<a id="number" href="/alarmList?usid=${loginnedMember.usid }"></a>
						</c:if>
					</c:if>
					<c:if test="${(empty loginnedMember.memberId) && (empty gprofile)}">
						<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/loginPage'">로그인</button>
						<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/joinPage">회원가입</button>
						<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/member/myPage'">마이페이지</button>
					</c:if>

					<c:if test="${!(empty gprofile)}">
						<img id="profile" alt="구글 프로필" src="${gprofile}">
					</c:if>

					<c:if test="${!(empty loginnedMember.memberId) || !(empty gprofile)}">
						<c:if test="${!(empty gprofile)}">
							<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="signOut();">로그아웃</button>
						</c:if>
						<c:if test="${(empty gprofile)}">
							<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/logout'">로그아웃</button>
						</c:if>
						<c:if test="${loginnedMember.memberId == 'admin'}">
							<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/customer/customerQnA'">고객센터</button>
						</c:if>
						<c:if test="${loginnedMember.memberId != 'admin'}">
							<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/notice/noticeList'">고객센터</button>
						</c:if>
					</c:if>

					<c:if test="${!(empty loginnedMember.memberId)}">
						<c:if test="${loginnedMember.memberId == 'admin'}">
							<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/admin/adminPage?usid='">관리자페이지</button>
						</c:if>
						<c:if test="${loginnedMember.memberId != 'admin'}">
							<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/member/myPage?usid=1">마이페이지</button>
						</c:if>
					</c:if>

				</div>
			</div>
			<nav>
				<ul class="nav justify-content-center">
					<li class="nav-item"><a class="nav-link" href="${path}/boSpecialList">특가</a></li>
					<li class="nav-item"><a class="nav-link" href="${path}/board?boardTitle=식품">식품</a></li>
					<li class="nav-item"><a class="nav-link" href="${path}/board?boardTitle=패션잡화">패션잡화</a></li>
					<li class="nav-item"><a class="nav-link" href="${path}/board?boardTitle=취미-문구">취미-문구</a></li>
					<li class="nav-item"><a class="nav-link" href="${path}/board?boardTitle=티켓">티켓</a></li>
					<li class="nav-item"><a class="nav-link" href="${path}/board?boardTitle=애완용품">애완용품</a></li>
				</ul>
			</nav>
		</header>
		<script>
		
		let num = 1;
		
		function alarmPrint(){
			if("${loginnedMember.usid}" != ""){
			$.ajax({
			    type: "GET",
			    data: {
			      "usid": "${loginnedMember.usid}"
			    },
			      dataType: "json",
			      url: "${path}/alarmCount",
			    success: function (data) {
			    	console.log("data : "+data);
			    	num = data;
					if(num > 0){
						console.log("0보다 큼")
						$("#number").append("<div id='al'>"+num+"</div>");
					}else{
						console.log("0보다 안큼")
						$("#bell").removeClass('bell2');
					}
			    }
			  });
			}else{
				console.log("로그인이 안되있습니다.");
			}
		};
		alarmPrint();
		
		const socket = new WebSocket("wss://192.168.219.105/socketa");
		
		
		socket.onopen = function(){
		}
		
		socket.onmessage = function(msg){
			console.log("msg 콘솔 : "+msg);
			console.log("num : "+num++);
			console.log("num2 : "+num);
			$("#number").html("");
			$("#number").append("<div id='al'>"+num+"</div>");
			$("#bell").addClass('bell2');
		};
		
		socket.onclose = function(){
		};
		
		function sendMessage(msg){
			socket.send(JSON.stringify(new Alarm("${loginnedMember.usid}",msg,"alarm","하이하이","${loginnedMember.nickname}")));
		};
		
		function Alarm(send_mem_usid,receive_mem_usid,type,alarm_content,send_mem_nickname){
			this.send_mem_usid = send_mem_usid;
			this.receive_mem_usid = receive_mem_usid;
			this.type = type;
			this.alarm_content = alarm_content;
			this.send_mem_nickname = send_mem_nickname;
		};
		
		//---------------------------- 
		
		function enterkey(){
			if(window.event.keyCode == 13) {
				fn_search('overall');
			}
			return false;
		}

		function fn_search(category){
			let keyword = document.getElementById('searchKeyword').value;
			if(category=='overall') {
			if(keyword==""){
				alert("검색어를 입력해주세요.")
			}else {
				location.assign("${path}/boListSearch?keyword="+keyword +"&category="+category);
			}}else {
				keyword = document.getElementById('searchInHere').value;
				location.assign("${path}/boListSearch?keyword="+keyword +"&category="+category);
			}
		}
		
	/* 	function signOut() {
			var auth2 = gapi.auth2.getAuthInstance();
			auth2.signOut().then(function() {
				console.log('User signed out.');
				location.replace('${path}/glogout');
			});
			auth2.disconnect();
		};

		function onLoad() {
			gapi.load('auth2', function() {
				gapi.auth2.init();
			});
		}; */
		
	</script>
		<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>