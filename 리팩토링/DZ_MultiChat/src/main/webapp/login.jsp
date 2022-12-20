<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>DZ Chat 로그인창</title>
<!-- core:css -->
<link rel="stylesheet" href="assets/vendors/core/core.css">
<!-- endinject -->
<!-- plugin css for this page -->
<!-- end plugin css for this page -->
<!-- inject:css -->
<link rel="stylesheet" href="assets/fonts/feather-font/css/iconfont.css">
<link rel="stylesheet"
	href="assets/vendors/flag-icon-css/css/flag-icon.min.css">
<!-- endinject -->
<!-- Layout styles -->
<link rel="stylesheet" href="assets/css/demo_1/style.css">
<!-- End layout styles -->
<link rel="shortcut icon" href="assets/images/favicon.png" />
</head>
<body class="sidebar-dark">
	<div class="main-wrapper">
		<div class="page-wrapper full-page">
			<div
				class="page-content d-flex align-items-center justify-content-center">

				<div class="row w-100 mx-0 auth-page">
					<div class="col-md-8 col-xl-6 mx-auto">
						<div class="card">
							<div class="row">
								<div class="col-md-8 pl-md-0">
									<div class="auth-form-wrapper px-4 py-5">
										<a href="#" class="noble-ui-logo d-block mb-2">DZ<span>Chat</span></a>
										<form method="post" name="loginForm" id="loginForm" class="forms-sample">
											<div class="form-group">
												<label for="exampleInputEmail1" style="padding-right: 30px;">아이디</label>
												<input type="text" id="uid" name="uid">
											</div>
											<div class="form-group">
												<label for="exampleInputPassword1"
													style="padding-right: 13px;">Password</label> <input
													type="password" id="pwd" name="pwd">
											</div>
											<div class="mt-3">
												<input type="submit" value="로그인" id="loginCheck">
											</div>
										</form>
										<form>
											<a href="/DZ_MultiChat/Member/findUserId.do">아이디 찾기/</a> <a
												href="/DZ_MultiChat/Member/findUserPw.do">비밀번호 찾기</a>
											<div>
												<a href="/DZ_MultiChat/Member/registerForm.do">회원 가입</a>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- 	아이디 :
	<input type="text" id="uid" name="uid"> 비밀번호 :
	<input type="password" id="pwd" name="pwd">
	<br />
	<input type="button" value="로그인" id="loginCheck">

	<form>
		<a href="member/findUserId.jsp">아이디 찾기</a> <a
			href="member/findUserPw.jsp">비밀번호 찾기</a> <a
			href="member/register.jsp">회원 가입</a>
	</form> -->
	<script type="text/javascript">
	//로그인 체크
	let loginCheck = document.querySelector("#loginForm");
	loginCheck.addEventListener("submit", (e) => {
		e.preventDefault();
		
		fetch('/DZ_MultiChat/Member/loginCheck.do', {		
			method : 'POST',
		    cache: 'no-cache',
			body: new FormData(loginForm)		
		})
		.then(response => response.json())
		.then(jsonResult => {
			alert(jsonResult.message);
			if (jsonResult.status == true) {
				location.href = jsonResult.url;
			}
		});
	});
</script>
	<!-- core:js -->
	<script src="assets/vendors/core/core.js"></script>
	<!-- endinject -->
	<!-- plugin js for this page -->
	<!-- end plugin js for this page -->
	<!-- inject:js -->
	<script src="assets/vendors/feather-icons/feather.min.js"></script>
	<script src="assets/js/template.js"></script>
	<!-- endinject -->
	<!-- custom js for this page -->
	<!-- end custom js for this page -->

	<script src="assets/vendors/chartjs/Chart.min.js"></script>
	<script src="assets/vendors/jquery.flot/jquery.flot.js"></script>
	<script src="assets/vendors/jquery.flot/jquery.flot.resize.js"></script>
	<script
		src="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
	<script src="assets/vendors/apexcharts/apexcharts.min.js"></script>
	<script src="assets/vendors/progressbar.js/progressbar.min.js"></script>
	<!-- end plugin js for this page -->
	<!-- inject:js -->
	<!-- endinject -->
	<!-- custom js for this page -->
	<script src="assets/js/dashboard.js"></script>
	<script src="assets/js/datepicker.js"></script>
	<!-- end custom js for this page -->

</body>
</html>