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
<link rel="shortcut icon"
	href="/multichat/jsp/assets/images/favicon.png" />
<title>DZ_MultiChat 회원정보</title>
<style>
#container {
	width: 600px;
	margin: 10px auto;
}

label {
	padding-right: 75px;
}
</style>
</head>
<body class="sidebar-dark">
	<%
	MemberBean memberBean = (MemberBean) request.getAttribute("memberBean");
	request.setAttribute("memberBean", memberBean);
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
										<li class="nav-item"><a
											href="/multichat/member/view"
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
				<div
					style="border: 1px solid; text-align: center; width: 600px; margin-left: auto; margin-right: auto;">
					<h1 style="text-align: center; margin-top: 40px;">회원 정보</h1>
					<form style="width: 400px; margin-left: 30%">
						<fieldset>
							<ul>
								<li><label for="uid" id="uid" style="margin-left: -50%;">아이디</label> ${uid}</li>
								<li><label for="pwd" id="pwd" style="margin-left: -57%; margin-right: -11px">비밀번호</label>${memberBean.pwd}</li>
								<li><label for="nickname" style="margin-left: -57%;">닉네임</label> ${memberBean.name}</li>
								<li><label for="email" style="margin-left: -36%;">이메일</label> ${memberBean.email}</li>
							</ul>

							<input type="button" value="수정하기" onclick="location.href='/multichat/jsp/member/memberUpdate.jsp'" > 
							<input type="submit" value="탈퇴하기" id="deleteButton">
							<button type="button"
								onClick="location.href='/multichat/jsp/home.jsp'">취소</button>

						</fieldset>
					</form>
				</div>
			</nav>

		</div>
	</div>
	<script type="text/javascript">
    
   
    let deleteButton = document.querySelector("#deleteButton");
    deleteButton.onclick = () => {
    	delete1();
    } 

    
   
	function delete1(){
		 if (confirm("정말 삭제하시겠습니까?") == true){
			 fetch('/multichat/member/delete')
				.then(response => response.json())
				.then(jsonResult => {
					alert(jsonResult.message);
					if (jsonResult.status == true) {
						//성공시 이동할 페이지로 이동한다  
						location.href = jsonResult.url;
					}
				});
		 }else{
		     return false;
		 }
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