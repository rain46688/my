<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스프링 삽질</title>
</head>
<body>

	<h1>스프링 삽질 index.jsp</h1>
	<p>세션 : ${loginnedMember.memberId}</p>
	<p>쿠키 : ${cookie['saveId'].value}</p>

	<a href="${path}/noticeTest">공지사항</a>
	<a href="${path}/loginPage">로그인 페이지</a>
	<a href="${path}/joinPage">회원가입 페이지</a>
	<a href="${path}/board?boardTitle=애완용품">게시판</a>
	
</body>
</html>