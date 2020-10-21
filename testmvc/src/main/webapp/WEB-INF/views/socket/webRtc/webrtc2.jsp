<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link href="${path }/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="${path }/resources/js/jquery-3.5.1.min.js"></script>
<script src="${path }/resources/js/bootstrap.bundle.min.js"></script>
<script src="${path }/resources/js/bootstrap.min.js"></script>
<style>
video{
	width:300px;
	height:300px;
	border:1px solid black;
}

</style>
<section id="content">

<video autoplay playsinline></video>


<button id="button">버튼</button>

</section>

<script>

$(function() {
	  navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;

	  /**
	   * getUserMedia 성공
	   * @param stream
	   */
	  function success(stream) {
	    console.log('success', arguments);

	    // 비디오 테그에 stream 바인딩
	    document.querySelector('video').srcObject = stream;

	    // do something...
	  }

	  /**
	   * getUserMedia 실패
	   * @param error
	   */
	  function error(error) {
	    console.log('error', arguments);

	    alert('카메라와 마이크를 허용해주세요');
	  }

	  /**
	   * 이벤트 바인딩
	   */
	  $('#button').click(function() {
	    navigator.getUserMedia({ audio: true, video: true }, success, error);
	  });
	});

</script>