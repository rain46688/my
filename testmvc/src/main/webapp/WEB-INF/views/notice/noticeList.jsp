<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#writecontainer {
	text-align: center;
	border-radius: 5px;
	margin: 5% atuo;
	height: auto;
	width: 100%;
	border-radius: 5px;
	height: auto;
}

.divList {
	display: table;
	width: 100%;
	height: 150px;
	text-align: center;
}

.divRow {
	display: table-row;
}

.divRowTitle {
	display: table-row;
	font-size: 15px;
	font-weight: bold;
	text-shadow: -1px 0 #BFBFBF, 0 0.5px #BFBFBF, 0.5px 0 #BFBFBF, 0 -1px #BFBFBF;
	width: 100%;
}

h2 {
	font-weight: bold;
	text-shadow: -1px 0 #BFBFBF, 0 0.5px #BFBFBF, 0.5px 0 #BFBFBF, 0 -1px #BFBFBF;
	margin: 15px 0 10px 0;
}

.active {
	font-weight: bold;
	text-shadow: -1px 0 #BFBFBF, 0 0.5px #BFBFBF, 0.5px 0 #BFBFBF, 0 -1px #BFBFBF;
}

.divCell, .divTableHead {
	border-bottom: 1px #DEE2E6 solid;
	display: table-cell;
	padding: 25px 10px;
	width: 16.67%;
	font-size: 15px;
}

.divListBody {
	display: table-row-group;
}

#n_btn {
	float: right;
	margin: 0 10px 10px 0;
}

.noti {
	width: 133%;
	margin: 0px;
	height: 200px;
	display: inline-block;
}

.noContent {
	margin-top: 20px;
	margin-bottom: 15px;
	margin-left: 100%;
	font-size: 15px;
	font-weight: bold;
	width: 100%;
}

.empty {
	margin-top: 20px;
	font-weight: bold;
	margin-top: 15px;
	margin-left: 150%;
	width: 100%;
	font-size: 15px;
}

#container {
	margin-left: auto;
	margin-right: auto;
}
</style>


<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div id="writecontainer" class="container">
	<div class="form-group">
		<h2>스프링 공지 사항</h2>
	</div>
	<div class="divList">
		<div class="divListBody">

			<div class="divRowTitle shadow p-3 mb-5 bg-white rounded">
				<div class="divCell">공지 ID</div>
				<div class="divCell">관리자명</div>
				<div class="divCell">제목</div>
				<div class="divCell">등록 날짜</div>
			</div>

			<c:choose>
				<c:when test="${fn:length(list) > 0}">
					<c:forEach items="${list }" var="n">
						<div class="divRow shadow p-3 mb-5 bg-white rounded" style="cursor: pointer">
							<div class="divCell">${n.NOTICE_ID}</div>
							<div class="divCell">${n.NOTICE_WRITE_NICKNAME}</div>
							<div class="divCell">${n.NOTICE_TITLE}</div>
							<div class="divCell">${n.NOTICE_DATE}</div>
						</div>
						<div class="noti">
							<div class="noContent">${n.NOTICE_CONTENT}</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="empty">등록된 공지 글이 없습니다.</div>
				</c:otherwise>
			</c:choose>
			<br>
		</div>
	</div>
	
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
				<c:if test="${(pageNo+i) <= pageEnd}">
					<li class="page-item"><a href="?cPage=${pageNo+i}" class="page-link">${pageNo+i}</a></li>
				</c:if>
			</c:forEach>


			<c:if test="${pageNo < pageEnd-4}">
				<li class="page-item"><a class="page-link" href="?cPage=${pageNo+5}" tabindex="-1" aria-disabled="true">다음</a></li>
			</c:if>
			<c:if test="${pageNo >= pageEnd-4}">
				<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">다음</a></li>
			</c:if>
		</ul>
	</nav>

</div>

<script>

$(function(){
	$(".noti").slideToggle('fast', function() {
	     });
})
	
$(".divRow").click(e=>{
   $(e.target).parent().next().slideToggle('slow', function() {
     });
   $(this).removeClass( 'shadow p-3 mb-5 bg-white rounded' );
})


   $('.divRow').hover(function(){
        $(this).css('color','#FFC107');
        $(this).removeClass( 'shadow p-3 mb-5 bg-white rounded' );
    }, function() {
        $(this).css('color','black');
        $(this).addClass( 'shadow p-3 mb-5 bg-white rounded' );
    });
	
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>

