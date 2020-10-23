<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" " />
</jsp:include>

<style>
div#memo-container {
	width: 60%;
	margin: 0 auto;
}
</style>

<section id="content">

	<div id="memo-container">
		<form action="${path }/memo/memoinsert.do" class="form-inline" method="post">
			<input type="text" class="form-control col-sm-6" name="memo" placeholder="메모" required />&nbsp; <input type="password"
				class="form-control col-sm-2" name="password" maxlength="4" placeholder="비밀번호" required />&nbsp;
			<button class="btn btn-outline-success" type="submit">저장</button>
		</form>
	</div>
	<!-- 입력하는것까지 만들기 -->
	<br />
	<!-- 메모목록 -->
	<table class="table">
		<tr>
			<th scope="col">번호</th>
			<th scope="col">메모</th>
			<th scope="col">날짜</th>
			<th scope="col">삭제</th>
		</tr>
		<c:forEach items="${list }" var="m">
		<tr>
		<td><c:out value="${m.MEMONO }"/></td>
		<td><c:out value="${m.MEMO }"/></td>
		<td><c:out value="${m.MEMODATE }"/></td>
		<td><button class="btn btn-outline-danger" onclick="memoDel('${m.MEMONO}');">삭제</button></td>		
		</tr>
		</c:forEach>
	</table>
	
	<c:set var="cPage" value="${(empty param.cPage)?1:param.cPage}" />
	<c:set var="pageNo" value="${cPage - (cPage - 1)%5}" />
	<fmt:parseNumber var="pageEnd" value="${Math.ceil(totalCount/numPerPage)}" integerOnly="true" />

	<nav aria-lable="Page navigation" id="pagebar">
		<ul class="pagination justify-content-center">
			<c:if test="${pageNo > 1}">
				<li class="page-item"><a class="page-link" href="?cPage=${pageNo-1}" tabindex="-1" aria-disabled="true">이전</a></li>
			</c:if>
			<c:if test="${pageNo <= 1}">
				<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">이전</a></li>
			</c:if>
				<c:forEach var="i" begin="0" end="${numPerPage - 1 }">
				<c:choose>
					<c:when test="${pageNo+i eq cPage}">
						<li class="page-item disabled"><a href="?cPage=${pageNo+i}" class="page-link">${pageNo+i}</a></li>
					</c:when>
					<c:otherwise>
						<c:if test="${(pageNo+i) <= pageEnd}">
							<li class="page-item"><a href="?cPage=${pageNo+i}" class="page-link">${pageNo+i}</a></li>
						</c:if>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${pageNo < pageEnd-4}">
				<li class="page-item"><a class="page-link" href="?cPage=${pageNo+5}" tabindex="-1" aria-disabled="true">다음</a></li>
			</c:if>
			<c:if test="${pageNo >= pageEnd-4}">
				<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">다음</a></li>
			</c:if>
		</ul>
	</nav>
	
</section>

<script>

function memoDel(no){
	console.log("no : "+no);
	location.replace('${path}/memo/memodel.do?no='+no);
};


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />