<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 첫 스프링 페이지</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="container">
		<header>
			<div id="header-container">
				<h2><c:out value="${param.title }"/></h2>
			</div>
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<a class="navbar-brand" href="#">
					<img src="${pageContext.request.contextPath }/resources/images/logo-spring.png"
					alt="스프링로고" width="50px">
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item">
							<a class="nav-link" href="${path }">home</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="${path }/board/boardList.do">게시판</a>
						</li>
								<li class="nav-item">
							<a class="nav-link" href="${path }/memo/memo.do">메모</a>
						</li>
						<!-- 추가메뉴구성하기 -->
						<%-- <li class="nav-item">
							<a class="nav-link" href="${path }/demo/demo.do">demo</a>
						</li> --%>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#"
							id="navbarDropdown" role="button" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false">demo</a>
							
							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<a class="dropdown-item" href="${path }/demo/demo.do">Demo등록</a>
								<a class="dropdown-item" href="${path }/demo/demoList.do">Demo목록</a>
							</div>
						</li>
					</ul>
					<c:if test="${loginMember == null }">
					<button class="btn btn-outline-success my-2 my-sm-0"
					type="button" data-toggle="modal" data-target="#loginModal">로그인</button>
					&nbsp;&nbsp;
					<button class="btn btn-outline-success my-2 my-sm-0"
					type="button" onclick="location.href='${path}/member/memberEnroll.do'">
					회원가입</button>
					<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">로그인</h5>
									<button type="button" class="close"
										data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<form action="${path }/member/memberLogin.do" method="post">
									<div class="modal-body">
										<input type="text" class="form-control" name="userId"
										placeholder="아이디" required/><br/>
										<input type="password" class="form-control" name="password"
										placeholder="비밀번호" required/>
									</div>
									<div class="modal-footer">
										<button type="submit" class="btn btn-outline-success">
										로그인</button>
										<button type="button" class="btn btn-outline-success"
										data-dismiss="modal">
										취소</button>
									</div>
								</form>
							</div>						
						</div>
					</div>
					</c:if>
					<c:if test="${loginMember != null }">
					<span><a href="${path }/member/memberUpade.do">${loginMember.userName}</a>님, 안녕하세요</span>
					&nbsp;
					<button class="btn btn-outline-success" type="button" onclick="location.replace('${path}/member/memberLogout.do');">로그아웃</button>
					</c:if>
				</div>
			</nav>
		</header>

		