<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" " />
</jsp:include>

<style>
table#tbl-dev {
	margin: 0 auto;
	width: 50%;
}
</style>
<section id="content">
	<h3>
		session 값 :
		<c:out value="${sessionScope.userId }" />
	</h3>
	<table class="table" id="tbl-dev">
		<tr>
			<th scope="col">이름</th>
			<td>${demo.devName}</td>
		</tr>
		<tr>
			<th scope="col">나이</th>
			<td>${demo.devAge}</td>
		</tr>
		<tr>
			<th scope="col">이메일</th>
			<td>${demo.devEmail}</td>
		</tr>
		<tr>
			<th scope="col">성별</th>
			<td>${demo.devGender=="M"?"남":"여"}</td>
		</tr>
		<tr>
			<th scope="col">개발가능언어</th>
			<td>
			<c:forEach items="${demo.devLang}" var="l" varStatus="s">
					<c:if test="${not s.first or s.last }">
						<c:out value=", "/>
					</c:if>
						<c:out value="${l }"/>
				</c:forEach>
		<%-- 	<c:forEach items="${demo.devLang}" var="lang" varStatus="vs">
				${vs.index!=0?",":""} ${lang}
				</c:forEach> --%>
				</td>
		</tr>
	</table>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />