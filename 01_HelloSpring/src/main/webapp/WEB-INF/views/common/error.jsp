<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp" >
<jsp:param name="title" value="에러발생!"/>
</jsp:include>

<section id="content">

<h1>에러발생!</h1>
<%-- <h3 style="color:red;">${exception.messge }</h3> --%>
<!-- 에러는 el로 불러올수없다!!  -->
<h3 style="color:red;"><%= exception.getMessage()%></h3>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />