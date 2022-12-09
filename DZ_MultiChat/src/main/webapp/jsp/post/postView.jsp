<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/multichat/jsp/assets/css/demo_1/style.css">
<link rel="shortcut icon" href="/multichat/jsp/assets/images/favicon.png" />
<title>DZ_MultiChat 게시글</title>
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
						href="../login.jsp"> <i class="link-icon"
							data-feather="log-out"></i> <span class="link-title">로그아웃</span>
					</a></li>
				</ul>
			</div>
		</nav>
		<div class="page-wrapper">
			<div class="col-md-12 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<div class="px-4 py-5" style="width: 100%">
							<h1 class="card-title" style="margin-left:10px ">${post.title}</h1>
							<form style="width: 90%; margin-left: 10px">
								<div class="form-group">
									<label>작성자 : ${post.id}</label>
									<label style="float: right; margin-right: 10%">작성일 : ${post.registDate}</label>
								</div>
								<label>조회수 : ${post.views }</label> 
								<div>
									<label for="content">Content</label>
								</div>
								<div>
									<label for="contents" style="width: 90%; min-height:450px; border: 1px solid; ">${post.content}</label> 
								<!-- 	<input type="text"
										oninput="btn_status()" class="form-control"
										style="height: 450px;" id="content" name="content"> -->
								</div>
								<div class="row1">
									<div style="width: 300px; justify-content: space-between;">
									
										<a href="postfix.jsp"
											class="btn btn-primary text-white mr-2 mb-2 mb-md-0">수정</a>
										<!-- disabled=""disabled" -->
									
										<a href="/multichat/jsp/post/post.jsp"
											class="btn btn-primary text-white mr-2 mb-2 mb-md-0">뒤로가기</a>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<script src="/multichat/jsp/assets/vendors/core/core.js"></script>

	<script src="/multichat/jsp/assets/vendors/chartjs/Chart.min.js"></script>
	<script src="/multichat/jsp/assets/vendors/jquery.flot/jquery.flot.js"></script>
	<script src="/multichat/jsp/assets/vendors/jquery.flot/jquery.flot.resize.js"></script>
	<script
		src="/multichat/jsp/assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
	<script src="/multichat/jsp/assets/vendors/apexcharts/apexcharts.min.js"></script>
	<script src="/multichat/jsp/assets/vendors/progressbar.js/progressbar.min.js"></script>
	<!-- end plugin js for this page -->
	<!-- inject:js -->
	<script src="/multichat/jsp/assets/vendors/feather-icons/feather.min.js"></script>
	<script src="/multichat/jsp/assets/js/template.js"></script>
	<!-- endinject -->
	<!-- custom js for this page -->
	<script src="/multichat/jsp/assets/js/dashboard.js"></script>
	<script src="/multichat/jsp/assets/js/datepicker.js"></script>
	<!-- end custom js for this page -->
</body>
</html>