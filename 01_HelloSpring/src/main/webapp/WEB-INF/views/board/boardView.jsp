<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp" >
<jsp:param name="title" value=" "/>
</jsp:include>

<section id="content">
 <div id="board-container">
        <input type="text" class="form-control" value="${board.boardTitle }" placeholder="제목" name="boardTitle" id="boardTitle"  required>
        <input type="text" class="form-control" name="boardWriter"  value="${board.boardWriter }" readonly required>
	<c:forEach items="${attachments }" var="a" varStatus="vs">
                    <button type="button" 
                    class="btn btn-outline-success btn-block"
                    onclick="fileDownload('${a.originalFileName}','${a.renamedFileName }');">
                    <c:out value="첨부파일 ${vs.count } - ${a.originalFileName }"/>
            </button>
        </c:forEach>
        
        <textarea class="form-control" name="boardContent" placeholder="내용" required>${board.boardContent }</textarea>
        <button class="btn btn-outline-success">수정</button>
        <button class="btn btn-outline-success">삭제</button>
    </div>

     <style>
    div#board-container{width:400px; margin:0 auto; text-align:center;}
    div#board-container input,div#board-container button{margin-bottom:15px;}
    div#board-container label.custom-file-label{text-align:left;}
    </style>
</section>
<script>

function fileDownload(oriName, reName){
	//원본명에 한글이 있을쉬있으니 인코딩처리를 직접해서 전달
	oriName=encodeURIComponent(oriName);
	location.href="${path}/board/fileDown.do?oriName="+oriName+"&reName="+reName;
	
}

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />