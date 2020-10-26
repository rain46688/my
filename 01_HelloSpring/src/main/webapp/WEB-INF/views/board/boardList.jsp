<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" " />
</jsp:include>
<style>

    button#btn-add{float:right; margin:0 0 15px;}
</style>
<section id="board-container" class="container">
	<p>총 ${totalCount }건의 게시물이 있습니다.</p>
	<button type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="location.href='${path}/board/boardForm.do'" >글쓰기</button>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${list }" var="m">
			<tr>
				<td><c:out value="${m.BOARDNO }" /></td>
				<td><c:out value="${m.BOARDTITLE }" /></td>
				<td><c:out value="${m.BOARDWRITER }" /></td>
				<td><c:out value="${m.BOARDDATE }" /></td>
				<td><c:if test="${empty (m.FILECOUNT)}">
							&nbsp;없음
						</c:if> <c:if test="${(m.FILECOUNT > 0)}">
						&nbsp;<img alt="file" src="${path }/resources/images/file.png">
					</c:if></td>
				<td><c:out value="${m.BOARDREADCOUNT }" /></td>
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

<jsp:include page="/WEB-INF/views/common/footer.jsp" />