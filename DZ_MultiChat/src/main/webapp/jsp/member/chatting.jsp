<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Douzone Chat</title>
<link rel="stylesheet" href="assets/css/demo_1/style.css">
<link rel="shortcut icon" href="assets/images/favicon.png" />
</head>
<body>
	<%
	ChattingDAO chattingDAO = new ChattingDAO();
	String title = (String) request.getSession().getAttribute("title");
	List<ChattingBean> list = chattingDAO.searchChat(title);
	request.setAttribute("chatList", list);
	%>
	<div>
		<form>
			사용자명 : <input readonly id="user" value=${uid}>
			<!-- 송신 메시지를 작성하는 텍스트 박스 -->
			<input id="textMessage" type="text" placeholder="메시지를 입력하세요">
			<!-- 메시지 송신을 하는 버튼 -->
			<input onclick="sendMessage()" value="전송" type="button">
			<!-- WebSocket 접속 종료하는 버튼 -->
			<input onclick="disconnect()" value="연결해제" type="button">
		</form>
		<table>
		<tbody style="border: solid 1px;">
			<c:forEach var="chattingDAO" items="${chatList}">
				<tr>
					<td style="width: 40%">${chattingDAO.id}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<!-- 콘솔 메시지의 역할을 하는 로그 텍스트 에리어.(수신 메시지도 표시한다.) -->
	<textarea id="messageTextArea" rows="10" cols="50"></textarea>
	<!-- <textarea  style="text-align: end" id="myTextArea" rows="10" cols="50"></textarea>
     -->
	<br />
	<script>
		// 「WebSocketEx」는 프로젝트 명
		// 「websocket」는 호스트 명
		// WebSocket 오브젝트 생성 (자동으로 접속 시작한다. - onopen 함수 호출)
		var list = (String)request.getSession().getAttribute("chatList");
		alert("채팅");
		for(var i in list){
			if(i.equals){
				var webSocket = new WebSocket("ws://localhost:8880/pro00/websocket");
		
				// 콘솔 텍스트 에리어 오브젝트
				var messageTextArea = document.getElementById("messageTextArea");
				//myMessage.style.textAlign = "end";
		
				// WebSocket 서버와 접속이 되면 호출되는 함수
				webSocket.onopen = function(message) {
					// 콘솔 텍스트에 메시지를 출력한다.
					messageTextArea.value += "Server connect...\n";
				};
				// WebSocket 서버와 접속이 끊기면 호출되는 함수
				webSocket.onclose = function(message) {
					// 콘솔 텍스트에 메시지를 출력한다.
					messageTextArea.value += "Server Disconnect...\n";
				};
				// WebSocket 서버와 통신 중에 에러가 발생하면 요청되는 함수
				webSocket.onerror = function(message) {
					// 콘솔 텍스트에 메시지를 출력한다.
					messageTextArea.value += "error...\n";
				};
		
				// WebSocket 서버로 부터 메시지가 오면 호출되는 함수
				webSocket.onmessage = function(message) {
					// 콘솔 텍스트에 메시지를 출력한다.
		
					messageTextArea.value += "me : "
					message.data + "\n";
				};
				// Send 버튼을 누르면 호출되는 함수
				function sendMessage() {
					// 유저명 텍스트 박스 오브젝트를 취득
					var user = document.getElementById("user");
		
					// 송신 메시지를 작성하는 텍스트 박스 오브젝트를 취득한다.
					var message = document.getElementById("textMessage");
					// 콘솔 텍스트에 메시지를 출력한다.
					messageTextArea.value += message.value + "\n";
					//json 객체를 생성한다
					let jsonObject = {
						userName : user.value,
						message : message.value
					};
					//WebSocket 서버에  json 문자열을 전송한다 
					webSocket.send(JSON.stringify(jsonObject));
					// 송신 메시지를 작성하는 텍스트 박스를 초기화한다.
					message.value = "";
				}
				// Disconnect 버튼을 누르면 호출되는 함수
				function disconnect() {
					webSocket.close();
					alert("퇴장 실행");
					fetch('/multichat/chatting/exitUser')
			   	 	.then(response => response.json())
			    	.then(jsonResult => {
			    		if (jsonResult.status == true) {
			    			//성공시 이동할 페이지로 이동한다  
			    			location.href = jsonResult.url;
			    		}
			    	});
				} 
			}
		}
	</script>
</body>
</html>