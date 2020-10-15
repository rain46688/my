<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Date enrollDate = (Date) request.getAttribute("date");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm");
String newDate = sdf.format(enrollDate);

List<Integer> tradeUserList = new ArrayList<Integer>();
List<Integer> paidUsers = new ArrayList<Integer>();
List<Integer> deliveryUsers = new ArrayList<Integer>();
if (request.getAttribute("tradeUserList") != null) {
	tradeUserList = (List<Integer>) request.getAttribute("tradeUserList");
}
if (request.getAttribute("paidUsers") != null) {
	paidUsers = (List<Integer>) request.getAttribute("paidUsers");
}
if (request.getAttribute("deliveryUsers") != null) {
	deliveryUsers = (List<Integer>) request.getAttribute("deliveryUsers");
}

int requestCount = Integer.parseInt(String.valueOf(request.getAttribute("likeCount")));
int maxMems = Integer.parseInt(String.valueOf(request.getAttribute("max")));
int stage1percent = Math.round((requestCount / (float) maxMems * 100));
int stage2percent = Math.round((paidUsers.size() / (float) maxMems * 100));
int stage3percent = Math.round((deliveryUsers.size() / (float) maxMems * 100));
int stage1target = maxMems - requestCount;
int stage2target = maxMems - paidUsers.size();
int stage3target = maxMems - deliveryUsers.size();

String reply = new String();
if(request.getAttribute("reply")!=null){
	reply = (String)request.getAttribute("reply");
}

%>




<style>
#wrapper {
	margin: 0 auto;
	margin-top: 5em;
	padding-top: 1em;
	width: 45em;
	text-align: center;
	align-items: center;
	margin-bottom: 3em;
	border: 0.5px solid rgb(224, 224, 224);
	border-radius: 1em;
	overflow: auto;
}

#imageWrapper {
	margin-bottom: 2em;
}

#imageWrapper>img {
	border-radius: 1em;
}

#userInfo {
	margin: 0 auto;
	width: 34em;
	text-align: left;
	font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
	font-size: large;
}

#userInfo>#level {
	float: right;
	margin-top: 0.5em;
}

.content {
	width: 40em;
	margin: 0 auto;
	padding: 0.5em;
	overflow: auto;
}

#title {
	text-align: left;
	width: 100%;
	overflow: auto;
	font-weight: bolder;
	font-size: 1.7em;
}

#priceAndLikeBtn {
	text-align: left;
	padding-top: 0.5em;
	overflow: auto;
}

#contentText {
	float: left;
	text-align: left;
	position: relative;
	width: 100%;
	margin-bottom: 2.5em;
}

#etcInfo {
	text-align: left;
	font-size: small;
}

#commentSection {
	text-align: left;
	margin: 0 auto;
	width: 38em;
	padding-left: 0.5em;
	padding-right: 0.5em;
	margin-bottom: 2em;
}

#commentInsert {
	width: fluid;
	margin: 0 auto;
	text-align: center;
	height: 2em;
	overflow: auto;
}

#commentInsert2 {
	width: fluid;
	margin: 0 auto;
	margin-top: 10px;
	text-align: left;
	overflow: auto;
}

#Comments {
	width: 100%;
}

#Comments>ul {
	padding-left: 0.5em;
	list-style: none;
	margin: 0 auto;
	overflow: auto;
}

.comment_area2 {
	width: 100%;
	overflow: auto;
	padding-left: 2em;
	margin-top: 1em;
	margin-bottom: 1em;
}

.comment_area {
	padding-top: 0.5em;
	width: 100%;
	overflow: auto;
}

.comment_thumb {
	text-align: center;
	position: relative;
	width: 5em;
	float: left;
}

.comment_box {
	word-break: break-all;
	width: 29em;
	float: left;
	position: relative;
}

.comment_id {
	font-size: small;
	font-weight: bold;
}

.comment_text {
	font-size: 16px;
}

.comment_info {
	font-size: small;
	color: darkgray;
	margin-top: 0.25em;
}

#userThumb {
	float: left;
	margin-right: 4px;
}

#userIdAndAddress {
	float: left;
}

#userId {
	font-size: 18px;
	font-weight: bold;
}

#userAddress {
	font-size: 16px;
}

#date {
	text-align: left;
	color: darkgray;
	overflow: auto;
}

#date p {
	color: darkgreen;
	font-weight: bold;
}

#etcInfo a {
	color: black;
}

#titleContent {
	width: 17em;
	height: 2em;
	float: left;
}

#titleContent>p {
	font-size: 25px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

#startBtn {
	margin-left: 2.5px;
	float: left;
	font-size: 18px;
}

.turnRed {
	background-color: red;
}

#userThumb>img {
	border-radius: 70%;
}

#comment_thumb>img {
	border-radius: 70%;
}

#funcBtns {
	padding-top: 0.5em;
	padding-bottom: 0px;
	padding-left: 0em;
	font-size: 12px;
}

#funcBtns>ul {
	padding-left: 0.25em;
	list-style: none;
	text-align: left;
}

#funcBtns>ul>li {
	display: inline-block;
	text-align: center;
	margin-left: 0.5em;
	margin-right: 0.5em;
	padding-bottom: 0px;
	height: 4.5em;
}

#funcBtns>ul div {
	cursor: pointer;
}

#funcBtns>ul div:hover {
	transform: scale(1.1);
	font-weight: bold;
}

#btnForWriter {
	margin: 0 auto;
	margin-top: 3em;
	margin-bottom: 5px;
	text-align: right;
	width: 45em;
	font-family: 'Do Hyeon', sans-serif;
}

#btnForWriter>button {
	height: 2em;
	width: 5em;
	font-size: 20px;
}

#btnForWriter>button:hover {
	border: 2px black solid;
}

.addToReple {
	text-decoration: none;
	color: gray;
}

.confirm {
	font-family: 'Do Hyeon', sans-serif;
}

.chart {
	width: 33.33%;
	margin-left: 26em;
	text-align: center;
}

.chart span.title {
	position: relative;
	display: block;
	width: 100%;
	text-align: center;
	top: 130px;
}

span.title {
	font-family: 'Do Hyeon', sans-serif;
	font-size: 16px;
}

.card-img-top {
	width: 100%;
	height: 35vw;
	object-fit: cover;
}

#urlh {
	text-decoration: none;
	color: darkgray;
}
</style>
<section>
	<c:if test="${ loginnedMember.usid eq map.get('WRITER_USID') && map.get('TRADE_STAGE') eq 1}">
		<div id="btnForWriter">
			<button onclick="fn_modifyBoard();">수정하기</button>
			<button onclick="fn_deleteBoard();">삭제하기</button>
		</div>
	</c:if>

	<c:if test="${loginnedMember.usid eq 9999}">
		<div id="btnForWriter">
			<button onclick="fn_deleteBoard();">삭제하기</button>
		</div>
	</c:if>


	<div id="wrapper">
		<div id="imageWrapper">
			<div id="carouselField" name="carouselField">
				<div id="carouselNB" class="carousel slide " data-ride="carousel" data-interval="false">
					<ol class="carousel-indicators">
						<!-- 잘되는듯함 아래 주석하고 확인해봤음 -->
						<c:forTokens items="${map.get('FILE_NAME')}" delims="," varStatus="status">
							<c:if test="${status.first}">
								<li data-target="#carouselInhee" data-slide-to="${status.index}" class="active"></li>
							</c:if>
							<c:if test="${!(status.first)}">
								<li data-target="#carouselInhee" data-slide-to="${status.index}"></li>
							</c:if>
						</c:forTokens>


					</ol>
					<div class="carousel-inner" role="listbox">
						<c:forTokens items="${map.get('FILE_NAME')}" delims="," varStatus="status">
							<c:if test="${status.first}">
								<div class="carousel-item active">
									<img src="${path}/resources/images/${status.current}" class="d-block w-90 card-img-top" alt="..." width="600em" height="500em">
								</div>
							</c:if>
							<c:if test="${!(status.first)}">
								<div class="carousel-item">
									<img src="${path}/resources/images/${status.current}" class="d-block w-90 card-img-top" alt="..." width="600em" height="500em">
								</div>
							</c:if>
						</c:forTokens>
					</div>

					<a class="carousel-control-prev" href="#carouselNB" role="button" data-slide="prev"> <span class="carousel-control-prev-icon"
						aria-hidden="true"></span> <span class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselNB" role="button" data-slide="next"> <span class="carousel-control-next-icon"
						aria-hidden="true"></span> <span class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</div>
		<div id="userInfo">
			<hr>
			<div id="userThumb">
				<img src="${path}/resources/profilePic/${map.get('MEMBER_PICTURE')}" alt="" width="40px" height="40px">
			</div>
			<div id="userIdAndAddress">
				<div id="userId">${map.get('WRITER_NICKNAME')}</div>
				<div id="userAddress">${map.get('TRADE_AREA')}</div>
			</div>
			<!-- 프로필 사진 + id -->
			<h5 id="level"></h5>
		</div>
		<div class="content">
			<hr>
			<div id="title">
				<div id="titleContent">
					<p>${map.get('BOARD_TITLE')}</p>
				</div>
			</div>

			<div id="date"><%=newDate%>
				&nbsp&nbsp 관심 ${map.get('LIKE_COUNT')} 조회수 ${map.get('HIT')}
				<p>
					<c:if test="${map.get('TRADE_STAGE') eq 1 ||  map.get('TRADE_STAGE') eq 2 || map.get('TRADE_STAGE') eq 3}">
						<c:forEach var="item" items="${tradeUserList}">
							<c:if test="${item eq map.get('USID')}">
						현재 참여중인 N빵입니다.
						</c:if>
						</c:forEach>
					</c:if>





				</p>
			</div>
			<!-- 가격 -->
			<div id="priceAndLikeBtn">
				<h5>${map.get('PRODUCT_PRICE')}원</h5>
			</div>
			<div id="contentText">${map.get('CONTENT')}</div>
			<!-- 프로그래스바 -->
			<c:if test="${map.get('TRADE_STAGE') eq 1}">
				<div class="chart chart1" data-percent="<%=stage1percent%>">
					<span class="title">N빵 완성까지 <br><%=stage1target%>명!
					</span>
				</div>
			</c:if>
			<c:if test="${map.get('TRADE_STAGE') eq 2}">
				<div class="chart chart2" data-percent="<%=stage2percent%>">
					<span class="title">결제 완료까지 <br><%=stage2target%>명!
					</span>
				</div>
			</c:if>
			<c:if test="${map.get('TRADE_STAGE') eq 3}">
				<div class="chart chart3" data-percent="<%=stage3percent%>">
					<span class="title">물품수령 완료까지 <br><%=stage3target%>명!
					</span>
				</div>
			</c:if>
			<c:if test="${map.get('TRADE_STAGE') eq 4}">
				<div class="chart chart4" data-percent="100">
					<span class="title">종료된 N빵입니다.<br></span>
				</div>
			</c:if>
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
			<script src="${path }/resources/js/easy-pie/dist/easypiechart.js"></script>
			<script src="${path }/resources/js/easy-pie/dist/jquery.easypiechart.js"></script>
			<script>
				$('.chart1').easyPieChart({
					barColor : '#f16529',
					trackColor : '#ccc',
					scaleColor : '#fff',
					lineCap : 'butt',
					lineWidth : 30,
					size : 200,
					animate : 1000,
					onStart : $.noop,
					onStop : $.noop
				});
				$('.chart2').easyPieChart({
					barColor : 'green',
					trackColor : '#ccc',
					scaleColor : '#fff',
					lineCap : 'butt',
					lineWidth : 30,
					size : 200,
					animate : 1000,
					onStart : $.noop,
					onStop : $.noop
				});
				$('.chart3').easyPieChart({
					barColor : 'skyblue',
					trackColor : '#ccc',
					scaleColor : '#fff',
					lineCap : 'butt',
					lineWidth : 30,
					size : 200,
					animate : 1000,
					onStart : $.noop,
					onStop : $.noop
				});
				$('.chart4').easyPieChart({
					barColor : 'gray',
					trackColor : '#ccc',
					scaleColor : '#fff',
					lineCap : 'butt',
					lineWidth : 30,
					size : 200,
					animate : 1000,
					onStart : $.noop,
					onStop : $.noop
				});
			</script>
			<div id="etcInfo">
				<a href="${path }/member/report?userId=${loginnedMember.usid}&boardId=${map.get('BOARD_ID')}&writerUsid=${map.get('WRITER_USID')}">신고하기</a>
				<c:if test="${!empty (map.get('PRODUCT_URL'))}">
					<a id="urlh" href="http://${map.get('PRODUCT_URL')}" target="_blank">제품 페이지</a>
				</c:if>
				<c:if test="${empty (map.get('PRODUCT_URL'))}">
					제품 페이지
				</c:if>
			</div>
			<hr>
			<div id="funcBtns">
				<ul>
					<form style="display: none;" name="form">
						<input type="hidden" name="boardId" value="${map.get('BOARD_ID')}"> <input type="hidden" name="maxMems" value="${map.get('MAX_MEMS')}">
						<input type="hidden" name="tradeStage" value="${map.get('TRADE_STAGE')}"> <input type="hidden" name="writerUsid"
							value="${map.get('USID')}"> <input type="hidden" name="memberPicture" value="${map.get('MEMBER_PICTURE')}"> <input
							type="hidden" name="boardTitle" value="${map.get('BOARD_TITLE')}">

						<button id="hiddenEnterBtn" onclick="nbbang(this.form)">채팅방 접속하기</button>
					</form>
					<li>
					<div id="likeFunc">
							<c:forEach var="item" items="${likelist}">
							<!-- 여기 왜 안나옴??? ㄷ -->
								<c:if test="${item == map.get('BOARD_ID')}">
									<img src="${path }/resources/images/fullheart.png" width="40px" height="40px">
								</c:if>
								<c:if test="${item != map.get('BOARD_ID')}">
									<img src="${path }/resources/images/heart.png" width="40px" height="40px">
								</c:if>
							</c:forEach>
							<p>찜하기</p>
						</div>
						</li>


					<c:if test="${map.get('TRADE_STAGE') eq 1}">
						<c:if test="${map.get('WRITER_USID') ne loginnedMember.usid}">
							<li><div id="startFuncBtn" onclick="fun_decidebuy();">
									<c:forEach var="item" items="${tradeUserList}">
										<c:if test="${item eq loginnedMember.usid}">
											<img src="${path }/resources/images/cancel.png" width="40px" height="40px">
											<p>N빵취소</p>
								</div></li>
						</c:if>
						<c:if test="${item ne loginnedMember.usid}">
							<img src="${path }/resources/images/onebyn.png" width="40px" height="40px">
							<p>N빵신청</p>
			</div>
			</li>
			</c:if>
			</c:forEach>
			</c:if>
			</c:if>

			<c:forEach var="item" items="${tradeUserList}">
				<c:if test="${item eq loginnedMember.usid && map.get('TRADE_STAGE') > 1}">
					<li><div id="enterFuncBtn" onclick="fn_enterBtn();">
							<img src="${path }/resources/images/enter.png" width="40px" height="40px">
							<p>채팅방접속</p>
						</div></li>
				</c:if>
			</c:forEach>


			<c:if test="${map.get('WRITER_USID') ne loginnedMember.usid}">
				<c:forEach var="item" items="${tradeUserList}">
					<c:if test="${item eq loginnedMember.usid && map.get('TRADE_STAGE') == 2}">
						<c:forEach var="item2" items="${paidUsers}">
							<c:if test="${item2 ne loginnedMember.usid && !(empty paidUsers)}">
								<li><div id="openFuncBtn" onclick="fn_pay();">
										<img src="${path }/resources/images/dollar.png" width="40px" height="40px">
										<p>결제하기</p>
									</div></li>
							</c:if>
						</c:forEach>
					</c:if>
				</c:forEach>
			</c:if>



			<c:if test="${map.get('TRADE_STAGE') eq 2}">
				<c:if test="${map.get('WRITER_USID') eq loginnedMember.usid}">
					<li><div onclick="fn_shipping();">
							<img src="${path }/resources/images/shipping.png" width="40px" height="40px">
							<p>배송시작하기</p>
						</div></li>
				</c:if>
			</c:if>


			<c:if test="${map.get('TRADE_STAGE') eq 3}">
				<c:forEach var="item" items="${deliveryUsers}">
					<c:if test="${item eq loginnedMember.usid && map.get('WRITER_USID') ne loginnedMember.usid}">
						<li><div onclick="fn_delivery();">
								<img src="${path }/resources/images/box.png" width="40px" height="40px">
								<p>수령확인</p>
							</div></li>
					</c:if>
				</c:forEach>
			</c:if>


			<c:if test="${map.get('TRADE_STAGE') eq 1}">
				<c:if test="${map.get('WRITER_USID') eq loginnedMember.usid}">
					<li><div id="openFuncBtn" onclick="fun_createroom();">
							<img src="${path }/resources/images/open.png" width="40px" height="40px">
							<p>방열기</p>
						</div></li>
				</c:if>
			</c:if>


			<c:if test="${map.get('TRADE_STAGE') eq 3}">
				<c:if test="${map.get('WRITER_USID') eq loginnedMember.usid}">
					<li><div onclick="fn_end();">
							<img src="${path }/resources/images/end.png" width="40px" height="40px">
							<p>N빵종료하기</p>
						</div></li>
				</c:if>
			</c:if>


			</ul>
		</div>
		<hr>
	</div>
	<div id="commentSection">
		<div id="commentInsert">
			<select name="commentTo" id="commentTo">
				<option value="openComment" selected>전체댓글</option>
				<option value="secretComment">비밀댓글</option>
			</select> <input type="text" name="commentContent" class="commentContent" id="commentContent" size="48"> <input type="hidden" name="commentLevel"
				id="commentLevel" value="1">
			<button class="commentInsertBtn" id="commentInsertBtn">댓글입력</button>
		</div>
		<div id="Comments">
			<ul class="comment_list">
				<!-- 댓글이 들어갈 곳 -->
			</ul>
		</div>
	</div>
	</div>



	<!--  -->
	<!--  -->
</section>
 <script>
<% if(reply.equals("success")) { %>
  function autoReple() {
    $("#commentContent").val("<p class='confirm'>결제했습니다.</p>");
    $("#commentInsertBtn").click();
    $("#commentContent").val("");
  }
  <% } %>
  <% if(reply.equals("delivery")) { %>
  function autoReple() {
    $("#commentContent").val("<p class='confirm'>물건받았습니다.</p>");
    $("#commentInsertBtn").click();
    $("#commentContent").val("");
  }
  <% } %>
function fn_replyToReply(comId){
  let html = "";
  html += "<div id=\"commentInsert2\">";
  html += "<input type=\"text\" name='commentContent' class='commentContent' id=\"commentContent\" size=\"46\">";
  html += "<input type=\"hidden\" name='commentLevel' id=\"commentLevel\" value=\"2\">";
  html += "<input type=\"hidden\" name='com_ref' id=\"com_ref\" value="+comId+">";
  html += "<button class=\"commentInsertBtn\">댓글입력</button>";
  html += "</div>";
  $(event.target).parent().parent().children('.replereple').html(html);
}

function fn_modifyBoard(){
  location.href = "${path}/board/boardModify?boardId=${map.get('BOARD_ID')}";
}

function fn_deleteBoard(){
  if(confirm('게시물을 삭제하시겠습니까?')){
  location.href = "${path}/board/boardDelete?boardId=${map.get('BOARD_ID')}&category=${map.get('PRODUCT_CATEGORY')}";
  }
}

function fn_pay(){//결제기능
  if(confirm('결제를 진행하시겠습니까?')) {
    location.href="${path}/board/boardPay?buyerUsid=${loginnedMember.usid}&boardId=${map.get('BOARD_ID')}&productPrice=${map.get('PRODUCT_PRICE')}&writerUsid=${map.get('WRITER_USID')}";
  }
}

function fn_shipping(){//배송시작기능
  if(confirm('배송을 진행하시겠습니까?')) {
		if("${fn:length(paidUsers)}" != "${map.get('MAX_MEMS')}") {
			alert("결제 인원이 부족합니다.");
		}else {
	    location.href="${path}/board/boardShipStart?boardId=${map.get('BOARD_ID')}&writerUsid=${map.get('WRITER_USID')}";
		}
	}
}

function fn_delivery(){
	if(confirm('물품을 배송받으셨나요?')) {
    	location.href="${path}/board/boardDelivery?buyerUsid=${loginnedMember.usid}&boardId=${map.get('BOARD_ID')}&writerUsid=${map.get('WRITER_USID')}";
  }
}

function fn_end(){
	if(confirm('N빵을 끝내시겠습니까?')) {
		if("${fn:length(deliveryUsers)}" != "${map.get('MAX_MEMS')}") {
			alert("아직 배송 받지 못한 분이 있습니다.");
		}else {
	    	location.href="${path}/board/boardEnd?boardId=${map.get('BOARD_ID')}&writerUsid=${map.get('WRITER_USID')}";
		}
	}
}

function fn_enterBtn(){
  $("#hiddenEnterBtn").click();
}

var pop;
window.onunload = function() { 
	pop.close(); 
  
}

/*  채팅창 관련 로직  */
function nbbang(f){
	var x = 600;
	var y = 800;
	var cx = (window.screen.width / 2) - (x / 2);
	var cy= (window.screen.height / 2) - (y / 2);

	var url    ="${path}/chat/chatRoom";
	var title  = "chat";
	var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width="+x+", height="+y+", top="+cy+",left="+cx;
	pop =  window.open("", title,status);
	f.target = title;
	f.action = url;
	f.method = "post";
	f.submit();    
}

function fun_createroom() {

$.ajax({
    type: "GET",
    /* "boardId":"2" 부분 게시판 id값을 객체로 받아와서 넣기로 변경해야됨 */
    data: {
      "boardId": "${map.get('BOARD_ID')}"
    },
      dataType: "json",
      url: "${path}/chat/createRoom",
    success: function (data) {
      if (data == 1) {
          //방의 상태를 바꿔야되니 ajax로 갔따오자 방의 상태를 2로 변경함
          alert('채팅방이 생성되었습니다.');
          location.reload();
      } else {
          alert('N빵 인원이 다 체워지지 않았습니다.');
      }
    }
  })
}

function fun_decidebuy(){
	/* 컨트롤 f주의 여기 틀어짐 컨텍스트 부분 */
  if($("#startFuncBtn>img").attr("src")=="${path}/resources/images/onebyn.png") {
	$.ajax({
		type: "GET",
		/* "boardId":"2" 부분 게시판 id값을 객체로 받아와서 넣기로 변경해야됨 */
		data: {usid : "${loginnedMember.usid}",nickname : "${loginnedMember.nickname}","boardId":"${map.get('BOARD_ID')}","flag":"1"},
		url: "${path}/chat/decidebuy",
			success : function(data) {
        if(data == 0){
         alert("현재 n빵 참여가 실패하였습니다.");
        }else if(data == 1){
         alert("n빵 참여에 성공했습니다.");
        $("#startFuncBtn>img").attr("src","${path}/resources/images/cancel.png");
        $("#startFuncBtn>p").text("N빵취소");
        $("#date p").text("현재 참여중인 N빵입니다.");
         location.reload();
        }else if(data == 2){
         alert("현재 n빵에 이미 참여하셨습니다.");
        }else{
         //data 4 넘어옴
         alert("현재 n빵 최대인원을 초과하였습니다.");
        }
      }
		}) 	
	}else {
    $.ajax({
		/* "boardId":"2" 부분 게시판 id값을 객체로 받아와서 넣기로 변경해야됨 */
		data: {usid : "${loginnedMember.usid}",nickname : "${loginnedMember.nickname}","boardId":"${map.get('BOARD_ID')}","flag":"2"},
		url: "${path}/chat/decidebuy",
			success : function(data) {
        if(data == 0){
         alert("현재 n빵 취소에 실패하였습니다.");
        }else{
          //data 3 넘어옴
          alert("현재 n빵 참여가 취소되었습니다.");
          $("#startFuncBtn>img").attr("src","${path}/resources/images/onebyn.png");
          $("#startFuncBtn>p").text("N빵신청");
          $("#date p").text("");
        }
			}
		})
  }
}

//취소할때
function fun_cancelbuy() {
	$.ajax({
		/* "boardId":"2" 부분 게시판 id값을 객체로 받아와서 넣기로 변경해야됨 */
		data: {usid : "${loginnedMember.usid}",nickname : "${loginnedMember.nickname}","boardId":"${map.get('BOARD_ID')}","flag":"2"},
		url: "${path}/chat/decidebuy",
			success : function(data) {
				location.reload();
			}
		})
  }

$(document).on('click', '.repleDelete', function(e){
  let comId = $(e.target).parent().parent().children('.comId').val();
  if(confirm('댓글을 삭제하시겠습니까?')) {
    $.ajax({
        url: "${path}/board/commentDelete",
        type: "post",
        dataType: "text",
        data: {
            "comId":$(e.target).parent().parent().children('.comId').val()
        },
        success: function (data) {
          if (data != "success") {
            alert("댓글 삭제에 실패했습니다.");
          }
          fn_commentList(data);
        }
      })
    }
  })

$(document).on('click', '.repleModify',function(e){
  let value = $(e.target).parent().parent().children('.comment_text').text();
  let comId = $(e.target).parent().parent().children('.comId').val();
  let html = "";
  html += "<div id=\"commentInsert2\">";
  html += "<input type=\"text\" name='commentContent' class='commentModify' id=\"commentContent\" value='"+value+"' size=\"46\">";
  html += "<input type=\"hidden\" name='comId' class=\"comId\" value=\""+comId+"\">";
  html += "<button class=\"commentModifyBtn\">댓글입력</button>";
  html += "</div>";
  $(e.target).parent().parent().children('.comment_text').html(html);
})

$(document).on('keypress', '.commentModify', function(e){
  if(e.keyCode == 13) {
    $(e.target).parent().children('.commentModifyBtn').click();
    $(e.target).val("");
    return false;
  }
});

$(document).on('click','.commentModifyBtn',function(e){
  $.ajax({
    url: "${path}/board/commentModify",
    type: "post",
    dataType: "text",
    data: {
      "comId":$(e.target).parent().children('.comId').val(),
      "content":$(e.target).parent().children('.commentModify').val()
    },
    success: function (data) {
      if (data != "success") {
          alert("댓글 작성에 실패했습니다.");
      }
      fn_commentList(data);
    }
  })
})

  //같은 이름을 가진 모든 클래스에 Func적용
$(document).on('keypress', '.commentContent', function(e){
  if(e.keyCode == 13) {
    $(e.target).parent().children('.commentInsertBtn').click();
    $(e.target).val("");
    return false;
  }
});

$(document).on('click','.commentInsertBtn',function (e){
  if ($(e.target).parent().children('.commentContent').val() != null) {
    if($(e.target).parent().children('input[name=commentLevel]').val()==1) {
      $.ajax({
        url: "${path}/board/commentInsert",
        type: "post",
        dataType: "text",
        data: {
          "cBoardId": "${map.get('BOARD_ID')}",
          "content": $(e.target).parent().children('input[name=commentContent]').val(),
          "secret": $(e.target).parent().children('select[name=commentTo]').val(),
          "cWriterNickname": "${loginnedMember.nickname}",
          "comLayer": $(e.target).parent().children('input[name=commentLevel]').val(),
          "comProfile": "${map.get('MEMBER_PICTURE')}"
        },
        success: function (data) {
          if (data != "success") {
              alert("댓글 작성에 실패했습니다.");
          }
          $(e.target).parent().children('input[name=commentContent]').val("");
          fn_commentList(data);
        }
      })
    }else {
      $.ajax({
        url: "${path}/board/commentInsert",
        type: "post",
        dataType: "text",
        data: {
          "cBoardId": "${map.get('BOARD_ID')}",
          "content": $(e.target).parent().children('input[name=commentContent]').val(),
          "cWriterNickname": "${loginnedMember.nickname}",
          "comLayer": $(e.target).parent().children('input[name=commentLevel]').val(),
          "comProfile": "${map.get('MEMBER_PICTURE')}",
          "com_ref" : $(e.target).parent().children('input[name=com_ref]').val()
        },
        success: function (data) {
          if (data != "success") {
              alert("댓글 작성에 실패했습니다.");
          }
          $(e.target).parent().children('input[name=commentContent]').val("");
          fn_commentList(data);
        }
      })
    }
  }
})

$(document).ready(function () {
fn_commentList();
<% if(reply.equals("success")) { %>
autoReple();
<% } %>
$("#hideButton").hide();
$("#likeFunc").click(function (e) {
    if ($("#likeFunc>img").attr("src") == "${path}/resources/images/heart.png") {
      $.ajax({
        url: "${path}/board/boardLike?key=insert",
        type: "post",
        dataType: "text",
        data: {
          'userUsid': '${loginnedMember.usid}',
          'boardId': "${map.get('BOARD_ID')}"
        },
        success: function (data) {
            $("#likeFunc>img").attr("src", "${path}/resources/images/fullheart.png");
        }
      })
    } else {
      $.ajax({
        url: "${path}/board/boardLike?key=delete",
        type: "post",
        dataType: "text",
        data: {
          'userUsid': '${loginnedMember.usid}',
          'boardId': "${map.get('BOARD_ID')}"
        },
        success: function (data) {
            $("#likeFunc>img").attr("src", "${path}/resources/images/heart.png");
        }
      })
    }
  })
})

    

function fn_commentList() {
  $.ajax({
      url: "${path}/board/commentList",
      type: "post",
      dataType: "json",
      data: {
          "cBoardId": "${map.get('BOARD_ID')}"
      },
      success: function (data) {
        let html = "";
        $.each(data, function (index, item) {
          let date = new Date(Date.parse(item.cenrollDate));
          let repleDate = date.format('yyyy-MM-dd(KS) HH:mm:ss');
          if("${loginnedMember.usid}"!="${map.get('WRITER_USID')}"){
            if(item.comLayer==1){
              if(item.cwriterNickname=="${loginnedMember.nickname}") {
                html += "<li class='comment_item'>";
                html += "<hr>";
                html += "<div class='comment_area'>";
                html += "<div class='comment_thumb'>";
                html += "<img src='${path}/resources/images/"+ item.comProfile +"' alt='' width='30px'" +
                        " height='30px' style='border-radius: 70%'>";
                html += "</div>";
                html += "<div class='comment_box'>";
                html += "<div class='comment_id'>";
                html += item.cwriterNickname;
                html += "</div>";
                html += "<input type='hidden' class='comId' value='" + item.comId + "'>";
                html += "<div class='comment_text'>";
                html += item.content + "</div>";
                html += "<div class='comment_info'>";
                html += repleDate + " <a class='addToReple' style='cursor:pointer' onclick='fn_replyToReply("+item.comId+");'>답글쓰기</a> <a class='addToReple repleModify' style='cursor:pointer'>수정</a> <a class='addToReple repleDelete' style='cursor:pointer' >삭제</a>";
                html += "</div>";
                html += "<div class='replereple'></div>";
                html += "</div></div></li>";
              }else {
                if(!item.secret){
                html += "<li class='comment_item'>";
                html += "<hr>";
                html += "<div class='comment_area'>";
                html += "<div class='comment_thumb'>";
                html += "<img src='${path}/resources/images/"+ item.comProfile +"' alt='' width='30px'" +
                        " height='30px' style='border-radius: 70%'>";
                html += "</div>";
                html += "<div class='comment_box'>";
                html += "<div class='comment_id'>";
                html += item.cwriterNickname;
                html += "</div>";
                html += "<input type='hidden' class='comId' value='" + item.comId + "'>";
                html += "<div class='comment_text'>";
                html += item.content + "</div>";
                html += "<div class='comment_info'>";
                html += repleDate + " <a class='addToReple' style='cursor:pointer' onclick='fn_replyToReply("+item.comId+");'>답글쓰기</a>";
                html += "</div>";
                html += "<div class='replereple'></div>";
                html += "</div></div></li>";
                }else {
                  html += "<li class='comment_item'>";
                html += "<hr>";
                html += "<div class='comment_area'>";
                html += "<div class='comment_thumb'>";
                html += "<img src='${path}/resources/images/"+ item.comProfile +"' alt='' width='30px'" +
                        " height='30px' style='border-radius: 70%'>";
                html += "</div>";
                html += "<div class='comment_box'>";
                html += "<div class='comment_id'>";
                html += item.cwriterNickname;
                html += "</div>";
                html += "<input type='hidden' class='comId' value='" + item.comId + "'>";
                html += "<div class='comment_text'>";
                html += "비밀댓글입니다." + "</div>";
                html += "<div class='comment_info'>";
                html += repleDate + " <a class='addToReple' style='cursor:pointer' onclick='fn_replyToReply("+item.comId+");'>답글쓰기</a>";
                html += "</div>";
                html += "<div class='replereple'></div>";
                html += "</div></div></li>";
                }
              }
            }else {
              if(item.cwriterNickname=="${loginnedMember.nickname}") {
                html += "<li class='comment_item'>";
                // html += "<hr>";
                html += "<div class='comment_area2'>";
                html += "<div class='comment_thumb'>";
                html += "<img src='${path}/resources/images/"+ item.comProfile +"' alt='' width='30px'" +
                        " height='30px' style='border-radius: 70%'>";
                html += "</div>";
                html += "<div class='comment_box'>";
                html += "<div class='comment_id'>";
                html += item.cwriterNickname;
                html += "</div>";
                html += "<input type='hidden' class='comId' value='" + item.comId + "'>";
                html += "<div class='comment_text'>";
                html += item.content + "</div>";
                html += "<div class='comment_info'>";
                html += repleDate + "  <a class='addToReple repleModify' style='cursor:pointer'>수정</a> <a class='addToReple repleDelete' style='cursor:pointer' >삭제</a>";
                html += "</div>";
                html += "<div class='replereple'></div>";
                html += "</div></div></li>";
              }else {
                html += "<li class='comment_item'>";
                // html += "<hr>";
                html += "<div class='comment_area2'>";
                html += "<div class='comment_thumb'>";
                html += "<img src='${path}/resources/images/"+ item.comProfile +"' alt='' width='30px'" +
                        " height='30px' style='border-radius: 70%'>";
                html += "</div>";
                html += "<div class='comment_box'>";
                html += "<div class='comment_id'>";
                html += item.cwriterNickname;
                html += "</div>";
                html += "<input type='hidden' class='comId' value='" + item.comId + "'>";
                html += "<div class='comment_text'>";
                html += item.content + "</div>";
                html += "<div class='comment_info'>";
                html += repleDate;
                html += "</div>";
                html += "<div class='replereple'></div>";
                html += "</div></div></li>";
              }
            }
          }else {
            if(item.comLayer==1){
              if(item.cwriterNickname=="${loginnedMember.nickname}") {
                html += "<li class='comment_item'>";
                html += "<hr>";
                html += "<div class='comment_area'>";
                html += "<div class='comment_thumb'>";
                html += "<img src='${path}/resources/images/"+ item.comProfile +"' alt='' width='30px'" +
                        " height='30px' style='border-radius: 70%'>";
                html += "</div>";
                html += "<div class='comment_box'>";
                html += "<div class='comment_id'>";
                html += item.cwriterNickname;
                html += "</div>";
                html += "<input type='hidden' class='comId' value='" + item.comId + "'>";
                html += "<div class='comment_text'>";
                html += item.content + "</div>";
                html += "<div class='comment_info'>";
                html += repleDate + " <a class='addToReple' style='cursor:pointer' onclick='fn_replyToReply("+item.comId+");'>답글쓰기</a> <a class='addToReple repleModify' style='cursor:pointer'>수정</a> <a class='addToReple repleDelete' style='cursor:pointer' >삭제</a>";
                html += "</div>";
                html += "<div class='replereple'></div>";
                html += "</div></div></li>";
              }else {
                if(!item.secret){
                html += "<li class='comment_item'>";
                html += "<hr>";
                html += "<div class='comment_area'>";
                html += "<div class='comment_thumb'>";
                html += "<img src='${path}/resources/images/"+ item.comProfile +"' alt='' width='30px'" +
                        " height='30px' style='border-radius: 70%'>";
                html += "</div>";
                html += "<div class='comment_box'>";
                html += "<div class='comment_id'>";
                html += item.cwriterNickname;
                html += "</div>";
                html += "<input type='hidden' class='comId' value='" + item.comId + "'>";
                html += "<div class='comment_text'>";
                html += item.content + "</div>";
                html += "<div class='comment_info'>";
                html += repleDate + " <a class='addToReple' style='cursor:pointer' onclick='fn_replyToReply("+item.comId+");'>답글쓰기</a>";
                html += "</div>";
                html += "<div class='replereple'></div>";
                html += "</div></div></li>";
                }else {
                  html += "<li class='comment_item'>";
                html += "<hr>";
                html += "<div class='comment_area'>";
                html += "<div class='comment_thumb'>";
                html += "<img src='${path}/resources/images/"+ item.comProfile +"' alt='' width='30px'" +
                        " height='30px' style='border-radius: 70%'>";
                html += "</div>";
                html += "<div class='comment_box'>";
                html += "<div class='comment_id'>";
                html += item.cwriterNickname;
                html += "</div>";
                html += "<input type='hidden' class='comId' value='" + item.comId + "'>";
                html += "<div class='comment_text'>";
                html += item.content + "</div>";
                html += "<div class='comment_info'>";
                html += repleDate + " <a class='addToReple' style='cursor:pointer' onclick='fn_replyToReply("+item.comId+");'>답글쓰기</a>";
                html += "</div>";
                html += "<div class='replereple'></div>";
                html += "</div></div></li>";
                }
              }
            }else {
              if(item.cwriterNickname=="${loginnedMember.nickname}") {
                html += "<li class='comment_item'>";
                // html += "<hr>";
                html += "<div class='comment_area2'>";
                html += "<div class='comment_thumb'>";
                html += "<img src='${path}/resources/images/"+ item.comProfile +"' alt='' width='30px'" +
                        " height='30px' style='border-radius: 70%'>";
                html += "</div>";
                html += "<div class='comment_box'>";
                html += "<div class='comment_id'>";
                html += item.cwriterNickname;
                html += "</div>";
                html += "<input type='hidden' class='comId' value='" + item.comId + "'>";
                html += "<div class='comment_text'>";
                html += item.content + "</div>";
                html += "<div class='comment_info'>";
                html += repleDate + "  <a class='addToReple repleModify' style='cursor:pointer'>수정</a> <a class='addToReple repleDelete' style='cursor:pointer' >삭제</a>";
                html += "</div>";
                html += "<div class='replereple'></div>";
                html += "</div></div></li>";
              }else {
                html += "<li class='comment_item'>";
                // html += "<hr>";
                html += "<div class='comment_area2'>";
                html += "<div class='comment_thumb'>";
                html += "<img src='${path}/resources/images/"+ item.comProfile +"' alt='' width='30px'" +
                        " height='30px' style='border-radius: 70%'>";
                html += "</div>";
                html += "<div class='comment_box'>";
                html += "<div class='comment_id'>";
                html += item.cwriterNickname;
                html += "</div>";
                html += "<input type='hidden' class='comId' value='" + item.comId + "'>";
                html += "<div class='comment_text'>";
                html += item.content + "</div>";
                html += "<div class='comment_info'>";
                html += repleDate;
                html += "</div>";
                html += "<div class='replereple'></div>";
                html += "</div></div></li>";
              }
            }
          }
        });
      $(".comment_list").html(html);
    }
  })
}
Date.prototype.format = function (f) {

if (!this.valueOf()) return " ";



var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];

var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];

var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

var d = this;



return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {

    switch ($1) {

        case "yyyy": return d.getFullYear(); // 년 (4자리)

        case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)

        case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)

        case "dd": return d.getDate().zf(2); // 일 (2자리)

        case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)

        case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)

        case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)

        case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)

        case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)

        case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)

        case "mm": return d.getMinutes().zf(2); // 분 (2자리)

        case "ss": return d.getSeconds().zf(2); // 초 (2자리)

        case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분

        default: return $1;

    }

});

};



String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };

String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };

Number.prototype.zf = function (len) { return this.toString().zf(len); };
</script> 
<%@ include file="/WEB-INF/views/common/footer.jsp"%>