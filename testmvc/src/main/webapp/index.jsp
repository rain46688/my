<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%
	Integer requestCount = (Integer) request.getAttribute("likeCount");
%>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스프링 삽질</title>
<style>
#profile {
	witdh:60px;
	height:60px;
	border-radius: 70%;
	border:2px solid black;
	margin-right:5px;
}
</style>

</head>
<body>

	<h1>스프링 삽질 index.jsp</h1>
	<p>구글 로그인 닉네임 : ${gname}</p>
	<c:if test="${(!empty gprofile)}">
	구글 프로필 : <img id="profile" alt="구글 프로필" src="${gprofile}"><br>
	</c:if>
	<p>세션 : ${loginnedMember.memberId}</p>
	<p>쿠키 : ${cookie['saveId'].value}</p>
<%-- 	<p>map.get('TRADE_STAGE') : ${map.get('TRADE_STAGE') }</p>
	<p>map.get('WRITER_USID') : ${map.get('WRITER_USID') }</p> --%>
	<p>세션 닉네임 : ${loginnedMember.nickname}</p>
	<p>세션 USID : ${loginnedMember.usid}</p>
<img alt="고양이" src="${path }/resources/profilePic/img1.daumcdn.gif">
	<br>
	<br>
	<a href="${path}/noticeTest" class="btn btn-outline-success my-2 my-sm-0">공지사항</a>
	<a href="${path}/loginPage" class="btn btn-outline-success my-2 my-sm-0">로그인 페이지</a>
	<a href="${path}/joinPage" class="btn btn-outline-success my-2 my-sm-0">회원가입 페이지</a>
	<a href="${path}/board?boardTitle=애완용품" class="btn btn-outline-success my-2 my-sm-0">게시판</a>
	<a href="${path}/webrtc" class="btn btn-outline-success my-2 my-sm-0">RTC 소켓 테스트</a>
	<a href="${path}/webrtc2" class="btn btn-outline-success my-2 my-sm-0">RTC 소켓 테스트2</a>
	<a href="${path}/webrtc3" class="btn btn-outline-success my-2 my-sm-0">RTC 소켓 테스트3</a>
	<a href="${path}/webrtc4" class="btn btn-outline-success my-2 my-sm-0">RTC 소켓 테스트4</a>

</body>
</html>