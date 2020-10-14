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
<title>nbbang</title>
<script src="${path}/resources/js/jquery-3.5.1.min.js"></script>
<link href="${path}/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="${path}/resources/js/bootstrap.bundle.min.js"></script>
<link href="${path}/resources/css/section.css" rel="stylesheet">
<link href="${path}/resources/css/header.css" rel="stylesheet">
<link href="${path}/resources/css/footer.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
</head>

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

					<c:if test="${(empty loginnedMember.memberId)}">
						<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/loginPage'">로그인</button>
						<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/joinPage">회원가입</button>
						<button type="button" class="btn btn-outline-primary" style="font-size: 20px;" onclick="location.href='${path}/member/myPage'">마이페이지</button>
					</c:if>

					<c:if test="${!(empty loginnedMember.memberId)}">
						<button type="button" class="btn btn-outline-primary" style="font-size: 20px;"
							onclick="location.href='${path}/logout'">로그아웃</button>
						<c:if test="${loginnedMember.memberId == 'admin'}">
							<button type="button" class="btn btn-outline-primary" style="font-size: 20px;"
								onclick="location.href='${path}/customer/customerQnA'">고객센터</button>
						</c:if>
						<c:if test="${loginnedMember.memberId != 'admin'}">
							<button type="button" class="btn btn-outline-primary" style="font-size: 20px;"
								onclick="location.href='${path}/notice/noticeList'">고객센터</button>
						</c:if>
					</c:if>

					<c:if test="${!(empty loginnedMember.memberId)}">
						<c:if test="${loginnedMember.memberId == 'admin'}">
							<button type="button" class="btn btn-outline-primary" style="font-size: 20px;"
								onclick="location.href='${path}/admin/adminPage?usid='">관리자페이지</button>
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
	</script>