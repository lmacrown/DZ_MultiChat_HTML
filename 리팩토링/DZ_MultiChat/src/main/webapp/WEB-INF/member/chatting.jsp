<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="Chatting.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Douzone Chat</title>
<link rel="stylesheet" href="/multichat/jsp/assets/css/demo_1/style.css">
<link rel="shortcut icon"
	href="/multichat/jsp/assets/images/favicon.png" />
<style type="text/css">
table, th, td, tr {
background-color:yellow;
  border:1px solid #00FFFF;  /* 표 테두리 */
  border-collapse: collapse;  /* 테두리 1줄만 표시 */ 
}</style>
</head>
<body class="sidebar-dark">
	<%
	ChattingDAO chattingDAO = new ChattingDAO();
	String title = (String) request.getSession().getAttribute("title");
	List<ChattingBean> list = chattingDAO.searchChat(title);
	request.setAttribute("chatList", list);
	%>
	<div class="main-wrapper">
		<nav class="sidebar">
			<div class="sidebar-header">
				<a href="#" class="sidebar-brand"> DZ<span>CHAT</span>
				</a>
				<div class="sidebar-toggler active">
					<span></span> <span></span> <span></span>
				</div>
			</div>
			<div class="sidebar-body">
				<ul class="nav">

					<li class="nav-item"><a href="/multichat/jsp/home.jsp"
						class="nav-link"> <i class="link-icon" data-feather="box"></i>
							<span class="link-title">홈</span>
					</a></li>

					<li class="nav-item nav-category">게시글</li>

					<li class="nav-item"><a class="nav-link"
						href="/multichat/jsp/post/notice.jsp"> <i class="link-icon"
							data-feather="feather"></i> <span class="link-title">공지 사항</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/multichat/jsp/post/post.jsp"> <i class="link-icon"
							data-feather="anchor"></i> <span class="link-title">일반 게시판</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/multichat/jsp/post/QnA.jsp"> <i class="link-icon"
							data-feather="inbox"></i> <span class="link-title">QnA</span>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="../login.jsp">
							<i class="link-icon" data-feather="log-out"></i> <span
							class="link-title">로그아웃</span>
					</a></li>
				</ul>
			</div>
		</nav>

		<div class="page-wrapper">
			<nav class="navbar">
				<div class="navbar-content">
					<ul class="navbar-nav">
						<li class="nav-item dropdown nav-profile"><a
							class="nav-link dropdown-toggle" href="#" id="profileDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <img
								src="https://via.placeholder.com/30x30" alt="userr">
						</a>
							<div class="dropdown-menu" aria-labelledby="profileDropdown">
								<div
									class="dropdown-header d-flex flex-column align-items-center">
									<div class="figure mb-3">
										<img src="https://via.placeholder.com/80x80" alt="">
									</div>
									<div class="info text-center">
										<p class="name font-weight-bold mb-0">${uid}</p>
									</div>
								</div>
								<div class="dropdown-body">
									<ul class="profile-nav p-0 pt-3">
										<li class="nav-item"><a href="/multichat/member/view"
											class="nav-link"> <i data-feather="user"></i> <span>Profile</span>
										</a></li>
										<li class="nav-item"><a
											href="/multichat/jsp/member/memberUpdate.jsp"
											class="nav-link"> <i data-feather="edit"></i> <span>Edit
													Profile</span>
										</a></li>
										<li class="nav-item"><a class="nav-link"
											href="../login.jsp"> <i data-feather="log-out"></i> <span>LogOut</span>
										</a></li>
									</ul>
								</div>
							</div></li>
					</ul>
				</div>
				<div>
					<form>
						사용자명 : <input readonly id="user" value=${uid}>
						<!-- 송신 메시지를 작성하는 텍스트 박스 -->
						<input id="textMessage" type="text" placeholder="메시지를 입력하세요">
						<!-- 메시지 송신을 하는 버튼 -->
						<input onclick="sendMessage()" value="전송" type="button">
						<!-- WebSocket 접속 종료하는 버튼 -->
						<input type="button" value="연결해제" id="exitUser">
					</form>
					<!-- 콘솔 메시지의 역할을 하는 로그 텍스트 에리어.(수신 메시지도 표시한다.) -->
					<textarea style="margin-left: 80px; margin-top: 30px"
						id="messageTextArea" rows="10" cols="50"></textarea>
					<br />
				</div>
				<table>
					<tbody>
					<thead>
						<tr style="height: 20px; text-align: center;">
							<th style="width: 40%">유저목록</th>
						</tr>
					</thead>
					<c:forEach var="chattingDAO" items="${chatList}">
						<tr>
							<td style="width: 40%">${chattingDAO.id}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</nav>
		</div>
	</div>

	<script type="text/javascript">
      // 「WebSocketEx」는 프로젝트 명
      // 「websocket」는 호스트 명
      // WebSocket 오브젝트 생성 (자동으로 접속 시작한다. - onopen 함수 호출)
      var webSocket = new WebSocket("ws://localhost:8880/multichat/websocket");
      
      // 콘솔 텍스트 에리어 오브젝트
      var messageTextArea = document.getElementById("messageTextArea");
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
        messageTextArea.value += message.data+"\n";
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
				let exitUserBT = document.querySelector("#exitUser");
				exitUserBT.onclick = () => {
					exitUser();
				}
				function exitUser() {
					 fetch('/multichat/chatting/exitUser')
						.then(response => response.json())
						.then(jsonResult => {
							if (jsonResult.status == true) {
								location.href = jsonResult.url;
							}
						});
				}
	</script>
	<script src="/multichat/jsp/assets/vendors/core/core.js"></script>

	<script src="/multichat/jsp/assets/vendors/chartjs/Chart.min.js"></script>
	<script src="/multichat/jsp/assets/vendors/jquery.flot/jquery.flot.js"></script>
	<script
		src="/multichat/jsp/assets/vendors/jquery.flot/jquery.flot.resize.js"></script>
	<script
		src="/multichat/jsp/assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
	<script
		src="/multichat/jsp/assets/vendors/apexcharts/apexcharts.min.js"></script>
	<script
		src="/multichat/jsp/assets/vendors/progressbar.js/progressbar.min.js"></script>
	<!-- end plugin js for this page -->
	<!-- inject:js -->
	<script
		src="/multichat/jsp/assets/vendors/feather-icons/feather.min.js"></script>
	<script src="/multichat/jsp/assets/js/template.js"></script>
	<!-- endinject -->
	<!-- custom js for this page -->
	<script src="/multichat/jsp/assets/js/dashboard.js"></script>
	<script src="/multichat/jsp/assets/js/datepicker.js"></script>
	<!-- end custom js for this page -->
</body>
</html>