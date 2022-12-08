<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%!// 변수 선언
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

DataSource dataFactory;%>
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
try {
Context context = new InitialContext();
Context envContext = (Context) context.lookup("java:/comp/env");
dataFactory = (DataSource) envContext.lookup("jdbc/pro05DB");
// 데이터베이스에 연결하는 작업 수행
Connection conn = dataFactory.getConnection();
// 쿼리를 생성할 객체 생성
Statement stmt = conn.createStatement();
// 쿼리 생성
ResultSet rs = stmt.executeQuery("select * from chattingroom");
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

					<li class="nav-item"><a
						href="/multichat/jsp/member/memberUpdate.jsp" class="nav-link">
							<i class="link-icon" data-feather="box"></i> <span
							class="link-title">회원정보수정</span>
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
					<li class="nav-item"><a class="nav-link"
						href="login.jsp"> <i class="link-icon"
							data-feather="log-out"></i> <span class="link-title">로그아웃</span>
					</a></li>
				</ul>
			</div>
		</nav>

		<div class="page-wrapper">
			<a href="#" class="sidebar-toggler"> <i data-feather="menu"></i>
			</a>
			<div class="navbar-content">

				<div class="page-content">
					<div class="card" style="width: 50%">
						<div
							class="d-flex justify-content-between align-items-center flex-wrap grid-margin">
							<div>
								<h4 class="mb-3 mb-md-0" style="margin-left: 10px; margin-top: 10px;">채팅방 목록</h4>
							</div>
							<div class="d-flex align-items-center flex-wrap text-nowrap">
								<button type="button" id="createChat" style="margin-top: 10px;"
									class="btn btn-outline-info btn-icon-text mr-2 d-none d-md-block">
									<i class="btn-icon-prepend" data-feather="message-circle"></i> 채팅방 생성
								</button> 
							</div>
						</div>

						<div class="row">
							<div class="col-lg-7 col-xl-8 stretch-card">
								<div class="table-responsive">
									<table class="table table-hover mb-0">
										<thead>
											<tr>
												<th style="height: 20px">방 이름</th>
												<th style="height: 20px">생성 일자</th>
											</tr>
										</thead>
										<tbody>

<%
	while (rs.next()) {
%>
<script type="text/javascript">
async function chatting(event, dan) {
	event.preventDefault();
	
	let danDiv = document.querySelector("#dan_" + dan);
	if (danDiv != null) {
		let response = await fetch('/pro00/dan?dan=' + dan);
		let json = await response.json();
		if (json.status) {
			let result = json.result;
			let text = "";
			for (i=0;i<result.length;i++) {
				text += dan + '*' + result[i].i + '=' + result[i].rst + "<br/>"; 
			}
			danDiv.innerHTML = text;
		} else {
			alert(json.message);
		}
	}
	return false;
}
</script>
<%

	}
	}
 catch (Exception e) {
e.printStackTrace();
} finally {
try {
if (rs != null) {
rs.close();
}
if (stmt != null) {
stmt.close();
}
if (conn != null) {
conn.close();
}
} catch (Exception e) {
e.printStackTrace();
}
}

%>
									
									</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
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
