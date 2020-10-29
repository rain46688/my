<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
#content {
	margin: 5em;
}

label, input {
	max-width:200px;
}
</style>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RTC 삽질</title>
</head>
<body>
<section id="content">
	<label class="input-group-text" >방번호 </label><input type="input" name="room" class="form-control short" /><br>
	<button class="btn btn-outline-success" onclick="click2('create');">방 생성</button>
	<br>
	<button class="btn btn-outline-success" onclick="click2('join');">방 참여</button>
	<br>



</section>
<script>
	function click2(e){
		console.log('클릭');
		location.href="${path}/webrtc4Set?flag="+e+"&room="+$('input[name=room]').val();
	};

</script>
</body>
</html>