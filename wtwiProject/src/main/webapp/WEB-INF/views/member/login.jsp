<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 배포된 웹 애플리케이션의 최상위 주소를 간단히 얻어올 수 있도록 
     application 범위로 변수를 하나 생성 --%>
<c:set var="contextPath" scope="application"
	value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- RSA 암호화 -->
<script src="${contextPath}/resources/js/rsa/rsa.js"></script>
<script src="${contextPath}/resources/js/rsa/jsbn.js"></script>
<script src="${contextPath}/resources/js/rsa/prng4.js"></script>
<script src="${contextPath}/resources/js/rsa/rng.js"></script>

<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>로그인</title>
<style>
.login-body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.login-main {
	display: flex;
	width: 70%;
	height: 80%;
}

.login-container {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 50%;
}

.login-title {
	margin-bottom: 50px;
}

.login-pageArea {
	margin-bottom: 20px;
}

.login-form {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 60%;
}

.login-input {
	display: flex;
	width: 100%;
}

.login-input label {
	width: 100px;
}

.login-btnArea {
	display: flex;
	flex-direction: column;
	margin-top: 20px;
	width: 100%;
}


.login-btnArea button:first-child {
	margin-bottom: 10px;
}

.socialLogin-area {
	display: flex;
	align-items: center;
	margin-top: 60px;
}

.socialLogin-area a{
	margin-right: 15px;
}

.img-container {
	height: 100%;
	width: 50%;
}

.loginImg-container {
	height: 100%;
	width: 100%;
	background-image:url("https://source.unsplash.com/featured/?scenery");
	background-size: cover;
	border-top-left-radius: 70px;
	border-bottom-left-radius: 70px;	
}

.socialLogin-area img{
	width: 40%;
}

.btn-social-login {
  transition: all .2s;
  outline: 0;
  border: 1px solid transparent;
  padding: .5rem !important;
  border-radius: 50%;
  color: #fff;
}
.btn-social-login:focus {
  box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);
}
.text-dark { color: #343a40!important; }
a{
	text-decoration: none !important;

}
.btn-social-login:hover {
	text-decoration: none !important;
	color: white !important;
}


</style>
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<body class="login-body">

	<main class="login-main">
		<div class="img-container">
			<div class="loginImg-container"></div>
		</div>

		<div class="login-container">

			<div class="login-title">
				<h2>로그인</h2>
			</div>

			<form action="loginAction" class="login-form" id="loginForm"
				method="POST">
				<div class="login-input form-group">
				<label for="memberId">아이디</label> 
					<input name="memberId" type="text" class="form-control" id="memberId" value="${cookie.saveId.value}">
				</div>
				<div class="login-input form-group">
					<label for="memberPw">비밀번호</label> <input name="memberPw" type="password" class="form-control" id="memberPw">
				</div>
				<%-- 이전에 저장해둔 아이디가 존재한다면 --%>
				<c:if test="${ !empty cookie.saveId.value }">
					<c:set var="ch" value="checked" />
				</c:if>


				<!-------------------------- 아이디 저장 ---------------------------------
				<div class="mb-3">
					<label> 
					  <input type="checkbox" name="save" id="save" ${ch}> 아이디 저장
					</label>
				</div> 
				------------------------------------------------------------------------->
				
				
				<div class="login-btnArea">
					<button type="submit" class="btn btn-dark">로그인</button>
					<button type="button" class="btn btn-dark"
						onclick="location.href='${contextPath }/member/signUp'">회원가입</button>
				</div>
			</form>
			
			<%-- 소셜 로그인 버튼  --%>
			<div class="socialLogin-area">		
				<a href="${google_url}" class='btn-social-login' style='background:#D93025'><i class="xi-3x xi-google"></i></a>
				<a href="${facebook_url}" class='btn-social-login' style='background:#4267B2'><i class="xi-3x xi-facebook"></i></a>
				<a href="${naver_url}" class='btn-social-login' style='background:#1FC700'><i class="xi-3x xi-naver"></i></a>
				<a href="${kakao_url}" class='btn-social-login' style='background:#FFEB00'><i class="xi-3x xi-kakaotalk text-dark"></i></a>
			</div>

		</div>

	</main>

	<!-- 실제 서버로 전송되는 form -->
	<form action="loginAction" method="post" id="hiddenForm">
		<fieldset>
			<input type="hidden" name="memberId" /> <input type="hidden"
				name="memberPw" />
		</fieldset>
	</form>

	<!-- 유저 입력 form의 submit event 재정의 -->
	<script>
		var $memberId = $("#hiddenForm input[name='memberId']");
		var $memberPw = $("#hiddenForm input[name='memberPw']");

		// Server로부터 받은 공개키 입력
		var rsa = new RSAKey();
		rsa.setPublic("${modulus}", "${exponent}");

		$("#loginForm").submit(function(e) {
			// 실제 유저 입력 form은 event 취소
			// javascript가 작동되지 않는 환경에서는 유저 입력 form이 submit 됨
			// -> Server 측에서 검증되므로 로그인 불가
			e.preventDefault();

			// 아이디/비밀번호 암호화 후 hidden form으로 submit
			var memberId = $(this).find("#memberId").val();
			var memberPw = $(this).find("#memberPw").val();

			$memberId.val(rsa.encrypt(memberId)); // 아이디 암호화
			$memberPw.val(rsa.encrypt(memberPw)); // 비밀번호 암호화

			$("#hiddenForm").submit();
		});
	</script>


</body>
</html>