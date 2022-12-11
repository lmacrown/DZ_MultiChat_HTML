<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../assets/css/demo_1/style.css">
<link rel="shortcut icon" href="../assets/images/favicon.png" />
<title>DZ_MultiChat 공지사항</title>
<style>
table, th, td, tr {
  border:1px solid #222;  /* 표 테두리 */
  border-collapse: collapse;  /* 테두리 1줄만 표시 */ 
}
table{
  margin-left: auto;
  margin-right: auto;
}
tr{
text-align: center;
}
</style>
</head>
<body class="sidebar-dark">
<%
PostDAO postDAO = new PostDAO();
List<PostBean> list = postDAO.listNotices();
request.setAttribute("list",list);
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

					<li class="nav-item"><a
						href="/multichat/jsp/home.jsp" class="nav-link">
							<i class="link-icon" data-feather="box"></i> <span
							class="link-title">홈</span>
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
						href="../login.jsp"> <i class="link-icon"
							data-feather="log-out"></i> <span class="link-title">로그아웃</span>
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
										<p class="name font-weight-bold mb-0">Amiah Burton</p>
										<p class="email text-muted mb-3">amiahburton@gmail.com</p>
									</div>
								</div>
								<div class="dropdown-body">
									<ul class="profile-nav p-0 pt-3">
										<li class="nav-item"><a
											href="/multichat/member/view"
											class="nav-link"> <i data-feather="user"></i> <span>Profile</span>
										</a></li>
										<li class="nav-item"><a
											href="/multichat/jsp/member/memberUpdate.jsp"
											class="nav-link"> <i data-feather="edit"></i> <span>Edit
													Profile</span>
										</a></li>
										<li class="nav-item">
										<a class="nav-link" href="../login.jsp"> 
										<i data-feather="log-out"></i> 
										<span>LogOut</span>
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
					<div class="card">
						<div
							class="d-flex justify-content-between align-items-center flex-wrap grid-margin">
							<div>
								<h4 class="mb-3 mb-md-0" style="margin-left: auto;margin-right: auto; margin-top: 10px; text-align: center;">공지사항</h4>
							</div>
							<div class="d-flex align-items-center flex-wrap text-nowrap">
							<!-- 	<button type="button" id="createChat" style="margin-top: 10px;"
									class="btn btn-outline-info btn-icon-text mr-2 d-none d-md-block">
									<i class="btn-icon-prepend" data-feather="download"></i> 채팅방 생성
								</button>  -->
							</div>
						</div>

						<div class="row">
							<div class="col-lg-7 col-xl-8 stretch-card">
								<div class="table-responsive">
									<table class="table table-hover mb-0" style="margin-left: auto;margin-right: auto;">
										<thead>
											<tr>
												<th style="height: 20px">공지 제목</th>
												<!-- <th style="height: 20px">공지 내용</th> -->
												<th style="height: 20px">생성일</th>
												<th style="height: 20px">조회수</th>
											</tr>
										</thead>
										<tbody>
		
							<c:forEach var="postDAO" items="${list}">
										<tr>
											<td><a href='#' onclick="location.href='/multichat/post/noticeCheck?title=${postDAO.title}'">${postDAO.title} </a></td>
											<%-- <td>${postDAO.content} </td> --%>
											<%-- <td><input type="button" value="삭제" 
											onclick="location.href='/multichat/member/delete?id=${memberDAO.id}'"> --%>
											<td>${postDAO.registDate} </td>
											<td>${postDAO.views} </td>
										</tr>
							</c:forEach>
						</tbody>	
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</nav>
		</div>
	</div>
	<script src="../assets/vendors/core/core.js"></script>

	<script src="../assets/vendors/chartjs/Chart.min.js"></script>
	<script src="../assets/vendors/jquery.flot/jquery.flot.js"></script>
	<script src="../assets/vendors/jquery.flot/jquery.flot.resize.js"></script>
	<script
		src="../assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
	<script src="../assets/vendors/apexcharts/apexcharts.min.js"></script>
	<script src="../assets/vendors/progressbar.js/progressbar.min.js"></script>
	<!-- end plugin js for this page -->
	<!-- inject:js -->
	<script src="../assets/vendors/feather-icons/feather.min.js"></script>
	<script src="../assets/js/template.js"></script>
	<!-- endinject -->
	<!-- custom js for this page -->
	<script src="../assets/js/dashboard.js"></script>
	<script src="../assets/js/datepicker.js"></script>
	<!-- end custom js for this page -->
</body>
</html>