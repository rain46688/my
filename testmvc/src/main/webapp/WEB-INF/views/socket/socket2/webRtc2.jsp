<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!DOCTYPE html>
<html>
<head>
    <title>NextRTC Example Webapp</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
</head>
<body>
<div id="container" class="jumbotron">
</div> 
<div>
    Conversation id:<input id="convId" type="text"/>
    <button onclick="window.app.createConversation()">Create</button>
    <button onclick="window.app.createBroadcastConversation()">Create broadcast</button>
    <button onclick="window.app.joinConversation()">Join</button>
    <button onclick="window.app.leaveConversation()">Leave</button>
    <button onclick="window.app.upperCase()">UpperCase</button>
</div>
<div>
    <ul id="log">

    </ul>
</div>
<div>
    <video id="template" width="320" height="240" autoplay controls></video>
</div>
<script src="<%=request.getContextPath()%>/resources/bundle.js"></script>
</body>
</html>