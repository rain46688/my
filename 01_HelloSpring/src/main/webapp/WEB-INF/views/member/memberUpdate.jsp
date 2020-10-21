<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kh.spring.member.model.vo.Member"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%
/* 특이한 방법으로 넣음 아래에서 리스트 컨테인스로 비교함 */
String[] hobby = ((Member)request.getAttribute("member")).getHobby();
List<String> list = new ArrayList();
if(hobby != null){
	list=Arrays.asList(hobby);
}

%>

<jsp:include page="/WEB-INF/views/common/header.jsp" >
<jsp:param name="title" value=" "/>
</jsp:include>

	<style>
		div#enroll-container{width:400px; margin:0 auto; text-align:center;}
		div#enroll-container input, div#enroll-container select {margin-bottom:10px;}
	</style>

<section id="content">
	<div id="enroll-container">
			<form name="memberEnrollFrm" action="${path }/member/memberUpdateEnd.do" method="post">
				<input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="userId" id="userId_"  value="${member.userId }" readOnly required>
				
			<!-- 	<input type="password" class="form-control" placeholder="비밀번호" name="password" id="password_" required>
				<input type="password" class="form-control" placeholder="비밀번호확인" id="password2" required> -->
				
				<input type="text" class="form-control" placeholder="이름" name="userName" id="userName" value="${member.userName }" required>
				<input type="number" class="form-control" placeholder="나이" name="age" id="age" value="${member.age }">
				<input type="email" class="form-control" placeholder="이메일" name="email" id="email" value="${member.email }" required>
				<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="phone" id="phone" maxlength="11" value="${member.phone }" required>
				<input type="text" class="form-control" placeholder="주소" name="address" id="address" value="${member.address }">
				<select class="form-control" name="gender" required>
					<option value="" disabled selected>성별</option>
					<option value="M" ${member.gender == 'M' ? "selected":"" }>남</option>
					<option value="F" ${member.gender == 'F' ? "selected":""}>여</option>
				</select>
				<div class="form-check-inline form-check">
					취미 : &nbsp; 
					<!-- 특이한 방법으로 넣음 맨위에 스크립틀릿으로 리스트 선언함 -->
					<input type="checkbox" class="form-check-input" name="hobby" id="hobby0" value="운동" <%=list.contains("운동") ?  "checked":"" %>><label for="hobby0" class="form-check-label">운동</label>&nbsp;
					<input type="checkbox" class="form-check-input" name="hobby" id="hobby1" value="등산" <%=list.contains("등산") ?  "checked":"" %>><label for="hobby1" class="form-check-label">등산</label>&nbsp;
					<input type="checkbox" class="form-check-input" name="hobby" id="hobby2" value="독서" <%=list.contains("독서") ?  "checked":"" %>><label for="hobby2" class="form-check-label">독서</label>&nbsp;
					<input type="checkbox" class="form-check-input" name="hobby" id="hobby3" value="게임" <%=list.contains("게임") ?  "checked":"" %>><label for="hobby3" class="form-check-label">게임</label>&nbsp;
					<input type="checkbox" class="form-check-input" name="hobby" id="hobby4" value="여행" <%=list.contains("여행") ?  "checked":"" %>><label for="hobby4" class="form-check-label">여행</label>&nbsp;
				</div>
				<br />
				<input type="submit" class="btn btn-outline-success" value="수정" >&nbsp;
				<input type="reset" class="btn btn-outline-success" value="취소">&nbsp;
				<input type="button" class="btn btn-outline-success" value="회원탈퇴">&nbsp;
			</form>
			</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />