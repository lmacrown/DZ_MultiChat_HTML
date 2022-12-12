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
<body class="sidebar-dark">
	<%
	ChattingDAO chattingDAO = new ChattingDAO();
	List<ChattingBean> list = chattingDAO.listChatting();
	request.setAttribute("chatList", list);
	%>
	<div class="main-wrapper">
		<nav class="sidebar">
			<div class="sidebar-header">
				<a href="#" class="sidebar-brand"> DZ<span>CHAT</span>
				</a>
				<div class="sidebar-toggler not-active">
					<span></span> <span></span> <span></span>
				</div>
			</div>
			<div class="sidebar-body">
				<ul class="nav">

					<!-- <li class="nav-item"><a
						href="/multichat/jsp/member/memberUpdate.jsp" class="nav-link">
							<i class="link-icon" data-feather="box"></i> <span
							class="link-title">회원정보수정</span>
					</a></li> -->
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
					<li class="nav-item"><a class="nav-link" href="login.jsp">
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

										<li class="nav-item"><a class="nav-link" href="login.jsp"
											class="nav-link"> <i data-feather="log-out"></i> <span>Log
													Out</span>
										</a></li>
									</ul>
								</div>
							</div></li>
					</ul>
				</div>
				<a href="#" class="sidebar-toggler"> <i data-feather="menu"></i>
				</a>
				<div class="navbar-content">

					<div class="page-content">
						<div class="card" style="width: 70%">
							<div style="margin-bottom: 0px"
								class="d-flex justify-content-between align-items-center flex-wrap grid-margin">
								<div>
									<h4 class="mb-3 mb-md-0"
										style="margin-left: 10px; margin-top: 10px;">채팅방 목록</h4>
								</div>

								<div class="d-flex align-items-center flex-wrap text-nowrap">
									<div class="form-group" style="margin-top: 20%">
										<input type="text" id="title" name="title">
										<button type="button" id="createChat"
											style="margin-left: 10%;"
											class="btn btn-outline-info btn-icon-text mr-2 d-none d-md-block">
											<i class="btn-icon-prepend" data-feather="message-circle"></i>
											채팅방 생성
										</button>
									</div>
								</div>
							</div>
							<div class="row" style="margin-left: auto; margin-right: auto;">
								<div style="margin-left: 20px; width: 40%;">
									<table class="table table-hover mb-0" style="width: 40%">
										<thead>
											<tr style="height: 20px; text-align: center;">
												<th style="width: 40%">방 이름</th>
												<th style="width: 40%">생성 일자</th>
												<th style="width: 40%">인원수</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="chattingDAO" items="${chatList}">
												<tr>
													<td style="width: 40%"><a href='#'
														onclick="location.href='/multichat/chatting/chatroom?title=${chattingDAO.title}'">${chattingDAO.title}</a></td>
													<td style="width: 40%">${chattingDAO.createDate}</td>
													<td style="width: 40%">${chattingDAO.users}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</nav>
		</div>
	</div>
	<script type="text/javascript">
	 let createChatBT = document.querySelector("#createChat");
		 createChatBT.onclick = () => {
	    	createChat();
	    } 
		 async function createChat(){
	    	let response =  await fetch('/multichat/chatting/insert?title=' + title.value);

	    	let jsonResult =  await response.json();

	    	if (jsonResult.status == true) {
	    		alert("채팅방 생성완료");
	    		location.href = jsonResult.url;
	    	}
		}
	</script>
	<script src="assets/vendors/core/core.js"></script>

	<script src="assets/vendors/chartjs/Chart.min.js"></script>
	<script src="assets/vendors/jquery.flot/jquery.flot.js"></script>
	<script src="assets/vendors/jquery.flot/jquery.flot.resize.js"></script>
	<script
		src="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
	<script src="assets/vendors/apexcharts/apexcharts.min.js"></script>
	<script src="assets/vendors/progressbar.js/progressbar.min.js"></script>
	<!-- end plugin js for this page -->
	<!-- inject:js -->
	<script src="assets/vendors/feather-icons/feather.min.js"></script>
	<script src="assets/js/template.js"></script>
	<!-- endinject -->
	<!-- custom js for this page -->
	<script src="assets/js/dashboard.js"></script>
	<script src="assets/js/datepicker.js"></script>
	<!-- end custom js for this page -->
</body>
</html>
