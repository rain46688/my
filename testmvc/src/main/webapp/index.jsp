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
	<p>map.get('TRADE_STAGE') : ${map.get('TRADE_STAGE') }</p>
	<p>map.get('WRITER_USID') : ${map.get('WRITER_USID') }</p>
	<p>세션 닉네임 : ${loginnedMember.nickname}</p>
	<p>세션 USID : ${loginnedMember.usid}</p>

	<a href="${path}/noticeTest">공지사항</a>
	<a href="${path}/loginPage">로그인 페이지</a>
	<a href="${path}/joinPage">회원가입 페이지</a>
	<a href="${path}/board?boardTitle=애완용품">게시판</a>
	
		<p>likeCount : ${likeCount}</p>
		<p>maxmems : ${map.get('MAX_MEMS') }</p>
		<p>연산 : ${(likeCount/map.get('MAX_MEMS'))*100}</p>
	<fmt:formatNumber value="999"  type="number" var="s" />
	<p>stage1percent : ${s}</p>
	
	
	<!-- 
		int maxMems = c.getCardBoard().getMaxMems();
	int stage1percent = Math.round(((requestCount/(float)c.getCardBoard().getMaxMems())*100));
	int stage2percent = Math.round(((paidUsers.size()/(float)c.getCardBoard().getMaxMems())*100));
	int stage3percent = Math.round(((deliveryUsers.size()/(float)c.getCardBoard().getMaxMems())*100));
	int stage1target = maxMems - requestCount;
	int stage2target = maxMems - paidUsers.size();
	int stage3target = maxMems - deliveryUsers.size();
	
	 -->

</body>
</html>