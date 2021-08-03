<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <title>로그인</title>
    <style>
        .login-body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-main {
            width: 50%;
        }
        .login-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .login-title {
            margin-bottom: 20px;
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
        }

        .login-btnArea {
            width: 60%;
        }

        .login-btnArea button:first-child {
            margin-bottom: 10px;
        }

    </style>
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<body class="login-body">

    <main class="login-main">

        <div class="login-container">

            <div class="login-title">
                <h2>로그인</h2>
            </div>

            <form action="loginAction" class="login-form" id="loginForm">
                <div class="login-input form-group">
                    <label for="memberId">아이디</label>
                    <input name="memberId" type="text" class="form-control" id="memberId">
                  </div>
                  <div class="login-input form-group">
                    <label for="memberPw">비밀번호</label>
                    <input name="memberPw" type="password" class="form-control" id="memberPw">
                  </div>
                  <%-- 이전에 저장해둔 아이디가 존재한다면 --%>
				  <c:if test="${ !empty cookie.saveId.value }">
					  <c:set var="ch" value="checked" />
				  </c:if>

				  <div class="checkbox mb-3">
					  <label> 
						  <input type="checkbox" name="save" id="save" ${ch}> 아이디 저장
					  </label>
				  </div>
                  <div class="login-btnArea">
                      <button type="submit" class="btn btn-primary">로그인</button>
                      <button type="button" class="btn btn-primary" onclick ="location.href='${contextPath }/member/signUp'">회원가입</button>
                  </div>
            </form>
			  <%-- 소셜 로그인 버튼  --%>
			  <a href="${naver_url }">네이버 로그인"</a>
			  <a href="${google_url }">구글 로그인</a>
			  <a href="${kakao_url}">카카오 로그인</a>

        </div>

    </main>
    
    <!-- 실제 서버로 전송되는 form -->
	<form action="loginAction" method="post" id="hiddenForm">
	    <fieldset>
	        <input type="hidden" name="memberId" />
	        <input type="hidden" name="memberPw" />
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