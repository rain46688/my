<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="DemoList" />
</jsp:include>

<style>
td {
	width: 200px;
	height: 100px;
}
</style>

<section id="content">
<form action='${path}/updateDev.do' method='post'>
	<table>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">이름</th>
			<th scope="col">나이</th>
			<th scope="col">이메일</th>
			<th scope="col">성별</th>
			<th scope="col">개발가능언어</th>
		</tr>
		<c:forEach items="${list }" var="d">
			<tr>
				<td><c:out value="${d.devNo}" /></td>
				<td><c:out value="${d.devName}" /></td>
				<td><c:out value="${d.devAge}" /></td>
				<td><c:out value="${d.devEmail}" /></td>
				<td><c:out value="${d.devGender}" /></td>
				<td><c:forEach items="${d.devLang}" var="l" varStatus="vs">
						<c:out value="${vs.index != 0?',':''}${l}" />
					</c:forEach></td>
				<td>
					<button type="button" class="btn btn-outline-light" onclick="updateDev(event);">수정</button>
					<button type="button" class="btn btn-outline-light" onclick="deleteDev(event);">삭제</button>
				</td>
			</tr>
		</c:forEach>
	</table>
				</form>
</section>

<script>
	function updateDev(event) {
		var dno = $(event.target).parent().parent().children('td:eq(0)').html();
		 let html = "<td>"+ dno + "</td><td><input type='text' class='form-control' id='upName' name='devName'></td><td><input type='text' class='form-control' id='upAge' name='devAge'></td><td><input type='text' class='form-control' id='upEmail' name='devEmail'></td>";
		html += "<td><div class='col-sm-10'>";
		html += "<div class='form-check form-check-inline'><input class='upradio form-check-input' type='radio' name='devGender' id='devGender0' value='M'> <label class='form-check-label' for='devGender0'>남</label></div>";
		html += "<div class='form-check form-check-inline'><input class='upradio form-check-input' type='radio' name='devGender' id='devGender1' value='F'> <label class='form-check-label' for='devGender1'>여</label></div></div></td>";
		html += "<td><div class='col-sm-10'>";
		html += "<div class='form-check form-check-inline'>";
		html += "<input class='upcheck form-check-input' type='checkbox' name='devLang' id='devLang0' value='Java'> <label class='form-check-label' for='devLang0'>Java</label></div>";
		html += "<div class='form-check form-check-inline'>";
		html += "<input class='upcheck form-check-input' type='checkbox' name='devLang' id='devLang1' value='C'> <label class='form-check-label' for='devLang1'>C</label></div>";
		html += "<div class='form-check form-check-inline'>";
		html += "<input class='upcheck form-check-input' type='checkbox' name='devLang' id='devLang2' value='JavaScript'> <label class='form-check-label' for='devLang2'>JavaScript</label></div>";
		html += "</div><td><button type='button' class='btn btn-outline-light' onclick='updateEnd("+dno+");''>수정 완료</button>";
		html += "<button type='button' class='btn btn-outline-light' onclick='updateCancel();''>취소</button></td>"; 
		$(event.target).parent().parent().html(html);
	}
	
	function updateEnd(dno){
		console.log(dno+" "+$('#upName').val()+" "+$('#upAge').val()+" "+$('#upEmail').val());
		let gender ='';
		let lang ='';
		$(".upradio").each(function() {
			if(this.checked == true){
				console.log("값 : "+this.value);
				gender=this.value;
			}
		});
		$(".upcheck").each(function() {
			if(this.checked == true){
				console.log("값 : "+this.value);
				lang+=this.value+",";
			}
		}); 
		location.replace('${path}/updateDev.do?devNo='+dno+'&devName='+$('#upName').val()+'&devAge='+$('#upAge').val()+'&devEmail='+$('#upEmail').val()+'&devGender='+gender+'&devLang='+lang);
	}

	function updateCancel(){
		location.reload();
	}
	
	function deleteDev(event) {
		var dno = $(event.target).parent().parent().children('td:eq(0)').html();
		location.replace('${path}/deleteDev.do?dno=' + dno);
	}
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />