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

    <title>비밀번호 찾기</title>
    <style>
        .searchPw-body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .searchPw-main {
            display: flex;
			width: 70%;
			height: 60vh;
        }
        .searchPw-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .searchPw-title {
            margin-bottom: 20px;
        }

        .searchPw-pageArea {
            margin-bottom: 20px;
        }
        .searchPw-form {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 60%;
        }
        .searchPw-input {
            display: flex;
            width: 100%;
        }

        .searchPw-input label {
        	margin-top: 10px;
            width: 150px;
        }

        .searchPw-phoneArea {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 100%;
        }

        .searchPw-phoneArea div:first-child{
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .searchPw-phoneArea div:last-child {
            width: 100%;
        }

        .searchPw-phoneArea div:last-child button{
            width: 100%;
            margin-top: 5px;
        }

        .searchPw-phoneArea select {
            width: 33.3%;
        }
        .searchPw-phoneArea input {
            width: 33.3%;
            margin-left: 2px;
        }

        .searchPw-checkArea {
            width: 100%;
        }
        .searchPw-checkArea div:last-child button {
            width: 100%;
            margin-top: 5px;
        }
        .searchPw-btnArea {
            display: flex;
            flex-direction: column;
            margin-top: 20px;
        }

        .searchPw-btnArea {
            width: 60%;
        }

        .searchPw-btnArea a:first-child {
            margin-bottom: 10px;
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
    </style>
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<body class="searchPw-body">

    <main class="searchPw-main">
    	<div class="img-container">
			<div class="loginImg-container"></div>
		</div>

        <div class="searchPw-container">

            <div class="searchPw-title">
                <h2>비밀번호 찾기</h2>
            </div>

            <div class="searchPw-pageArea">
                <a class="btn btn-secondary" href="${contextPath}/member/searchIdForm"">아이디 찾기</a>
                <a class="btn btn-secondary" href="${contextPath}/member/searchPwForm"">비밀번호 찾기</a>
            </div>

            <form action="#" class="searchPw-form">
                <div class="searchPw-input form-group">
                    <label for="exampleInputEmail1">아이디</label>
                    <input type="text" class="form-control" id="memberId" aria-describedby="emailHelp">
                </div>
                
                <!-- 인증문자 전송 -->
                <div class="searchPw-input form-group">
                    <label for="phone1">전화번호</label>
                    <div class="searchPw-phoneArea">
                        <div>
                            <select class="custom-select" id="phone1" name="phone" required>
                                <option>010</option>
                                <option>011</option>
                                <option>016</option>
                                <option>017</option>
                                <option>019</option>
                            </select>
                            <input type="number" class="form-control phone" id="phone2" name="phone" required>
                            <input type="number" class="form-control phone" id="phone3" name="phone" required>
                        </div>
                        <div>
                            <button type="button" class="btn btn-light" id="smsSend">인증번호 전송</button>
                        </div>
                    </div>
                </div>
                
                <!-- 인증번호 확인 -->
                <div class="searchPw-input form-group">
                    <label for="exampleInputEmail1">인증번호 확인</label>
                    <div class="searchPw-checkArea">
                        <div>
                            <input type="text" class="form-control" id="smsNum">
                        </div>
                        <div>
                            <button type="button" class="btn btn-light" id="smsCheck">확인</button>
                        </div>
                    </div>
                </div>
                
                  <div class="searchPw-btnArea">
                      <a type="submit" class="btn btn-primary" href="${contextPath}/member/login"">로그인하기</a>
                      <a type="button" class="btn btn-primary" href="${contextPath}">메인으로</a>
                  </div>
            </form>

        </div>

    </main>
    
    <script type="text/javascript">
    
 	// 전화번호 인증번호 발신
    $("#smsSend").on("click", function(){
    const phone = $("[name='phone']");
    const memberPhone = $(phone[0]).val() + "-" + $(phone[1]).val() + "-" + $(phone[2]).val();
    const memberId = $("#memberId").val();
		if(memberPhone == "" || memberId == ""){
	 		swal("인증 실패", "회원 정보를 기입해주세요", "error");
	 	} else {
	        $.ajax({
	            url : "${contextPath}/coolSMS/searchPw",  // 요청 주소(필수로 작성!)
	            data : {"memberPhone" : memberPhone,
	            		"memberId" : memberId}, // 전달하려는 값(파라미터)
	            type : "post",
	            success : function(result){
	            	if(result == 1) {
		                swal("인증 실패", "번호 인증을 다시 시도해주세요.", "error");
	                } else if(result == 2){
		                swal("인증 실패", "입력한 회원정보가 올바르지 않습니다.", "error");
	                } else{
		                swal("인증번호 전송 완료", "문자를 확인하고 인증번호를 입력해주세요.", "success");
		                $("#smsCheck").on("click", function(event){
		                	
		                    if(result == $("#smsNum").val().trim()){
		                   		$.ajax({
			                   		 url : "${contextPath}/coolSMS/sendPw",  // 요청 주소(필수로 작성!)
			                         data : {"memberPhone" : memberPhone,
			                         		"memberId" : memberId}, // 전달하려는 값(파라미터)
			                         type : "post",
			                         success : function(result){
			                        	 if(result > 0){
			     			                swal("인증 성공!", "문자로 임시비밀번호를 전송하였습니다.", "success");
			                        	 } else {
			     			                swal("인증 실패", "문제가 계속될 시 대표전화로 문의주세요.", "error");
			                        	 }
			                    
			                         }, 
			                         error: function(e){
			                        	 console.log("ajax 통신 실패");
			                             console.log(e);
			                         }
		                   		})
							    
		                    	
				                
		                    } else {
				                swal("인증 실패", "잘못된 인증번호입니다.", "error");
		                    	
		                    }
		                    
		                })
	                }
	                	
	            },// 비동기 통신 성공 시 동작 
	            error: function(e){
	                // 매개변수 e : 예외 발생 시 Exception 객체를 전달 받을 변수
	                console.log("ajax 통신 실패");
	                console.log(e);
	            } // 비동기 통신 실패 시 동작
	        })
	 		
	 	}
    })
    </script>
    <script src="${contextPath}/resources/js/member/member.js"></script>
</body>
</html>