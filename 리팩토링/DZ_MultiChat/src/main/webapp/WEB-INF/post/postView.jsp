<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../assets/css/demo_1/style.css">
<link rel="shortcut icon" href="../assets/images/favicon.png" />
<title>DZ_MultiChat 게시글</title>
<style>
table, th, td, tr {
	border: 1px solid #222; /* 표 테두리 */
	border-collapse: collapse; /* 테두리 1줄만 표시 */
}

table {
	margin-left: auto;
	margin-right: auto;
}

tr {
	text-align: center;
}
</style>
</head>
<body class="sidebar-dark">
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
											href="/multichat/jsp/login.jsp"> <i
												data-feather="log-out"></i> <span>Log Out</span>
										</a></li>
									</ul>
								</div>
							</div></li>
					</ul>
				</div>
				<div class="col-md-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body">
							<div class="px-4 py-5" style="width: 100%;height:400px; overflow: scroll ">
								<c:set var="i" >1</c:set>
								<c:forEach var="viewBoard" items="${viewBoard}" >
									<h1 class="card-title" style="margin-left: 10px">${viewBoard.title}</h1>
									<form style="width: 90%; margin-left: 10px">
										<div class="form-group">
											<label>작성자 : ${viewBoard.writeId}</label> <label
												style="float: right; margin-right: 10%">작성일 :
												${viewBoard.writeDate}</label>
										</div>
										<label>조회수 : ${viewBoard.viewCount}</label>
										<div>
											<label for="content">Content</label>
										</div>
										<div>
											<label for="contents"
												style="width: 90%; min-height: 100px; border: 1px solid;">${viewBoard.content}</label>
										</div>
										<div class="row1">
											<div style="width: 300px; justify-content: space-between;">
												<c:if test="${uid eq viewBoard.writeId}">
													<a href="postFix.jsp"
														class="btn btn-primary text-white mr-2 mb-2 mb-md-0">수정</a>
													<a href="postFix.jsp"
														class="btn btn-primary text-white mr-2 mb-2 mb-md-0">삭제</a>

													<!-- disabled=""disabled" -->

												</c:if>
												<c:if test="${i eq 1}">
													<a href="<c:url value='/post/replyForm.do?number=${viewBoard.number}'/>"
														class="btn btn-primary text-white mr-2 mb-2 mb-md-0">답글</a>
												</c:if>
												<c:set var="i">${i+1}</c:set>
											</div>
										</div>
										<div>
											</br>
										</div>
									</form>
								</c:forEach>
								<a href="/multichat/jsp/post/post.jsp"
									class="btn btn-primary text-white mr-2 mb-2 mb-md-0">뒤로가기</a>
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