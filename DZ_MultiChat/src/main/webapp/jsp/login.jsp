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
	<title>DZ Chat 로그인창</title>
	<!-- core:css -->
	<link rel="stylesheet" href="assets/vendors/core/core.css">
	<!-- endinject -->
  <!-- plugin css for this page -->
	<!-- end plugin css for this page -->
	<!-- inject:css -->
	<link rel="stylesheet" href="assets/fonts/feather-font/css/iconfont.css">
	<link rel="stylesheet" href="assets/vendors/flag-icon-css/css/flag-icon.min.css">
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
										<form class="forms-sample">
											<div class="form-group">
												<label for="exampleInputEmail1" style="padding-right: 30px;">아이디</label> <input
													type="text"  id="uid" name="uid">
											</div>
											<div class="form-group">
												<label for="exampleInputPassword1" style="padding-right: 13px;">Password</label> <input
													type="password" id="pwd" name="pwd">
											</div>
											<div class="mt-3">
												<input type="button" value="로그인" id="loginCheck">
											</div>
										</form>
										<form>
											<a href="member/findUserId.jsp">아이디 찾기/</a> <a
												href="member/findUserPw.jsp">비밀번호 찾기</a> 
												<div> <a  href="member/register.jsp">회원 가입</a></div>
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
let loginButton = document.querySelector("#loginCheck");
loginButton.onclick = () => {
	loginCheck();
}
async function loginCheck() {

	let response = await fetch('/multichat/member/loginCheck?uid=' + uid.value
			+'&pwd='+pwd.value);

	let jsonResult = await response.json();

	if (jsonResult.status == false) {
		alert("아이디 또는 비밀번호가 다릅니다");
	}else if(jsonResult.status == "invalid"){
		alert("휴면 계정입니다");
	}else{
		location.href = jsonResult.url;
		alert("로그인 성공");
	}
}
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