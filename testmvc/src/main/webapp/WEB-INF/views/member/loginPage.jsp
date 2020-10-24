<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="google-signin-client_id" content="109451624786-3quf002c334a2alg5u0cu3prcu5593hh.apps.googleusercontent.com">
<title>nbbang</title>
<link href="${path}/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="${path}/resources/js/jquery-3.5.1.min.js"></script>
<link href="${path}/resources/css/header.css" rel="stylesheet">
<link rel="icon" type="image/png" href="${path}/resources/images/logo.png">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<style>
#error {
	font-size: 15px;
	font-weifht: bold;
	color: red;
}

.g-signin2 {
	display: inline-block;
	margin: 0px auto;
}
</style>

</head>
<body>
	<section>
		<div id="loginBox">
			<div id="loginField">
				<a href="${path}/"> <img src="${path}/resources/images/logo.png" alt="">
				</a>

				<div class="panel-body">
					<form:form action="loginPage" method="post" modelAttribute="login">
						<fieldset>
							<div class="form-group">
								<form:input type="text" class="input" placeholder="아이디" path="memberId" id="memberId" />
							</div>
							<div class="form-group">
								<form:password class="input" placeholder="비밀번호" path="memberPw" id="memberPwd" />
							</div>
							<form:checkbox path="rememberMe" id="saveId" />
							아이디 저장하기<br> <br>
							<form:errors path="memberPw" id="error" />
							<br>
							<button type="submit" onclick="return fn_login_validate()">로그인</button>
							<br> <br>
							<div class="g-signin2" data-onsuccess="onSignIn"></div>
							<br> <br>
						</fieldset>
						<div id="loginSearchField">
							<span id="findId" class="loginSearch" onclick="fn_findId();">아이디찾기</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="findPw" class="loginSearch"
								onclick="fn_findPw();">비밀번호찾기</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="signIn" class="loginSearch"
								onclick="location.href='${path}/enrollMember'">회원가입</span>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</section>


	<script>
	
		function onSignIn(googleUser) {
			var profile = googleUser.getBasicProfile();
			console.log('ID: ' + profile.getId());
			console.log('Name: ' + profile.getName());
			console.log('Image URL: ' + profile.getImageUrl());
			console.log('Email: ' + profile.getEmail());.
			var id_token = googleUser.getAuthResponse().id_token;
			console.log("ID Token: " + id_token);

			if (name != null) {
				var form = document.createElement("form");
				form.setAttribute("charset", "UTF-8");
				form.setAttribute("method", "Post");
				form.setAttribute("action", "/glogin");
				var hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "gname");
				hiddenField.setAttribute("value", profile.getName());
				form.appendChild(hiddenField);
				var hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "gprofile");
				hiddenField.setAttribute("value", profile.getImageUrl());
				form.appendChild(hiddenField);
				document.body.appendChild(form);
				form.submit();
			}
		}
		
	</script>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>