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
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
	
	<!-- Bootstrap core JS -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
	
	<!-- sweetalert API 추가 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>비밀번호 변경</title>
    <style>
        .myPage-body {
            display: flex;
            align-items: center;
            height: 100vh;
        }
        .myPage-main {
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .myPage-main h2{
            margin-bottom: 30px;
            text-align: center;
        }

        .myPage-pwUpdate__form {
            width: 60%;
        }
        .myPage-pwUpdate__form div{
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .placeholder{
            font-size: 11px;
        }

        .update-btnArea button{
            width: 40%;
            margin: 0px 3px;
        }
        .checkArea {
        	display: flex;
        	justify-content: flex-start;
        	margin-top: 5px;
        	padding-right: 3px;
        }
       
    </style>
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/myPage/sideBar.jsp"></jsp:include>

<body class="myPage-body">

    <main class="myPage-main">
        <h2>비밀번호 변경</h2>
        <form action="changePwdAction" class="myPage-pwUpdate__form" method="POST" onsubmit="return pwdValidate();">
            <div class="row mb-3 form-row">
                <div class="col-md-3">
                    <label for="name">현재 비밀번호</label>
                </div>
                <div class="col-md-6">
                    <input type="password" class="form-control" id="currentPwd" name="currentPwd" required>
                </div>
            </div>
            <div class="row mb-3 form-row">
                <div class="col-md-3">
                    <label for="name">새 비밀번호</label>
                </div>
                <div class="col-md-6">
                    <input type="password" class="placeholder form-control" id="newPwd1" name="newPwd1" 
                    placeholder="영어 대소문자, 숫자, 특수문자(선택) 조합 8자 이상" required>
                </div>

            </div>
            <div class="row mb-3 form-row">
                <div class="col-md-3">
                    <label for="name">새 비밀번호 확인</label>
                </div>
                <div class="col-md-6">
                    <input type="password" class="form-control" id="newPwd2" name="newPwd2" 
                    placeholder="영어 대소문자, 숫자, 특수문자(선택) 조합 8자 이상" required>
                </div>
                <div class="col-md-6 offset-md-3 checkArea">
					<span id="checkPwd2">&nbsp;</span>
				</div>
            </div>
            <div class="update-btnArea">
                <button class="btn btn-dark btn-md " type="submit">비밀번호 수정</button>
            </div>
        </form>
    </main>
    
    
    <script>
	// 비밀번호 유효성 검사
	 function pwdValidate() {
		 
		const regExp = /^[a-zA-Z\d\_\#\-]{8,20}$/; 
		const newPwd1 = $("#newPwd1").val().trim();
		const newPwd2 = $("#newPwd2").val().trim();
		 
		// 새 비밀번호가 유효하지 않거나  
		// 새 비밀번호, 새 비밀번호 확인이 같지 않은 경우 
		 if(!regExp.test(newPwd1) || (newPwd1 != newPwd2)){
			 swal({
				"icon" : "error", 
				"title" : "비밀번호가 유효하지 않습니다."
			 });
			 
			return false;
		 } 
		
		 
		 
	 }
	
	 $("#newPwd1, #newPwd2").on("input", function() {
		    const pwd1 = $("#newPwd1").val();
		    const pwd2 = $("#newPwd2").val();
		    
		    const regExp = /^[a-zA-Z\d\_\#\-]{8,20}$/; 
			const newPwd1 = $("#newPwd1").val().trim();
			const newPwd2 = $("#newPwd2").val().trim();
			 
			 if(!regExp.test(newPwd1)){
		         $("#checkPwd2").text("유효한 형식의 비밀번호를 입력해주세요.").css("color", "red");
			 }  else{
				 
			    if(pwd1.trim() == "" && pwd2.trim() == "") {
			        $("#checkPwd1").html("&nbsp;");
			        $("#checkPwd2").html("&nbsp;");
			    } else if(pwd1 == pwd2){
			    
			         $("#checkPwd2").text("새 비밀번호가 일치합니다. 변경을 진행해주세요.").css("color", "green");
			    } else{
			         $("#checkPwd2").text("새 비밀번호가 일치하지 않습니다. 확인 후 이용해주세요.").css("color", "red");
			    }
				 
			 }
		    


		})
	</script>
</body>
</html>