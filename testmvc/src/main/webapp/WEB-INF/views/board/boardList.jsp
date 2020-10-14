<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<style>
.card-wrapper {
	padding-top: 3rem;
	padding-left: 5rem;
	padding-right: 9rem;
	margin: 0 auto;
	width: 80em;
}

.card-img-top {
	width: 100%;
	height: 10vw;
	object-fit: cover;
}

.pagination>li>a {
	color: black;
}

.card-price {
	float: right;
	margin-top: 0;
}

.card-body {
	padding: 0.5em;
}

.card-wrapper h1 {
	font-family: 'Do Hyeon', sans-serif;
}

#writeBoard {
	text-align: right;
	padding-right: 1em;
	font-family: 'Do Hyeon', sans-serif;
	height: 3em;
}

#writeBoard>#writeBtn {
	height: 2em;
	width: 5em;
	font-size: 20px;
}

#writeBoard>button:hover {
	border: 2px black solid;
}

#interest {
	font-size: 15px;
	color: gray;
}

.card {
	border: 1px white solid;
}

.card-title {
	width: 9.5em;
	height: 1em;
}

.card-title>p {
	font-size: 20px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

#searchInHere {
	font-family: Arial, Helvetica, sans-serif;
	border: 2px gray solid;
	padding-left: 4px;
	height: 2.55em;
}

#searchInHere:focus {
	outline: none;
	margin-bottom: -1px;
}

#searchInHereBtn {
	height: 2em;
	width: 3em;
	font-size: 20px;
}
</style>
<section>
	<div class="card-wrapper">
		<div id="boardTitle">
			<h1>${boardTitle }</h1>
		</div>
		<div id="writeBoard">
			<c:if test="${!(empty oriCategory)}">
				<c:if test="${oriCategory ne 'overall'}">
					<input id="searchInHere" onkeypress="searchEnter();" type="text" placeholder="게시판 내에서 검색">
					<button id="searchInHereBtn" onclick="fn_search('${oriCategory}');">검색</button>
				</c:if>
			</c:if>
			<c:if test="${(empty oriCategory)}">
				<input id="searchInHere" onkeypress="searchEnter();" type="text" placeholder="게시판 내에서 검색">
				<button id="searchInHereBtn" onclick="fn_search('${category}');">검색</button>
			</c:if>
			<c:if test="${(category eq '특가')}">
				<c:if test="${(empty loginnedMember && loginnedMember.nickname eq 'ADMIN')}">
					<button id="writeBtn" onclick="fn_boWrite();">글쓰기</button>
				</c:if>
			</c:if>
			<c:if test="${(category ne '특가')}">
				<button id="writeBtn" onclick="fn_boWrite();">글쓰기</button>
			</c:if>
		</div>








		<c:choose>
			<c:when test="${fn:length(list) > 0}">
				<c:forEach items="${list}" var="b">
					<div class="card" onclick="location.href='${path}/boardPage?boardId=${b.BOARD_ID}&writerUsid=${b.WRITER_USID}'"
						style="width: 15rem; cursor: pointer; padding: 0px">
						<!-- file의 갯수 분기처리 -->
						<div class="image-wrapper">
							<img src="${path}/resources/images/${b.FILE_NAME}" class="card-img-top" alt="제품이미지" width="120em" height="200em">
						</div>
						<div class="card-body">
							<input type="hidden" value="${b.BOARD_ID }">
							<h4 class="card-title">
								<p>${b.BOARD_TITLE }</p>
							</h4>
							<p>${b.TRADE_AREA }</p>
							<p id="interest">${b.LIKE_COUNT}관심 ${b.HIT} 조회</p>
							<h4 class="card-price">
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${b.PRODUCT_PRICE }"></fmt:formatNumber>
								원
							</h4>
						</div>
						<br>
						<hr>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="empty">등록된 게시글이 없습니다.</div>
			</c:otherwise>
		</c:choose>







	</div>
	<br>


	<c:set var="cPage" value="${(empty param.cPage)?1:param.cPage}" />
	<c:set var="pageNo" value="${cPage - (cPage - 1)%5}" />
	<fmt:parseNumber var="pageEnd" value="${Math.ceil(totalData/numPerPage)}" integerOnly="true" />

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


	<br>







</section>
<script>
	function searchEnter() {
		if(window.event.keyCode==13) {
			$("#searchInHereBtn").click();
		}
		return false;
	}
	function fn_boWrite(){
		location.assign("${path}/board/boWrite?category=${category}")%>
	");
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
