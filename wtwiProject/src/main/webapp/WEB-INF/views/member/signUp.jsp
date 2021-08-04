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

    <title>회원가입</title>
    <style>
        .signUp-body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;

        }
        .signUp-main {
            width: 70%;
            height: 80%;;
        }
        .signUp-input {
            display: flex;
        }
        .signUp-input div:first-child{
            padding-left: 0;
        }
        .signUp-phoneArea {
            display: flex;
            flex-direction: column;
        }
        .signUp-phoneArea div:first-child{
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .signUp-phoneArea select {
            width: 33.3%;
        }
        .signUp-phoneArea input {
            width: 33.3%;
            margin-left: 2px;
        }
        .signUp-phoneArea div:last-child button{
            width: 100%;
            margin-top: 5px;
        }
        .signUp-btnArea {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .signUp-btnArea button{
            width: 45%;
            margin: 0px 3px;
        }
        .placeholder{
            font-size: 11px;
        }
    </style>
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<body class="signUp-body">

    <main class="signUp-main">
        <div class="py-5 text-center">
            <h2>회원 가입</h2>
        </div>
    
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <form method="POST" action="${contextPath }/member/signUpAction" class="needs-validation" name="signUpForm" onsubmit="return validate();">
    
    
    
                    <div class="row mb-3 form-row">
                        <div class="col-md-3">
                            <label for="id">* 아이디</label>
                        </div>
                        <div class="col-md-9">
                            <input type="text" class="placeholder form-control" name="memberId" id="id" maxlength="12" placeholder="아이디를 입력하세요" autocomplete="off" required>
                        </div>
                    </div>
                    <div class="col-md-6 offset-md-3">
							<span id="checkId">&nbsp;</span>
					</div>
    
    
                    <!-- 비밀번호 -->
                    <div class="row mb-3 form-row">
                        <div class="col-md-3">
                            <label for="pwd1">* 비밀번호</label>
                        </div>
                        <div class="col-md-9">
                            <input type="password" class="placeholder form-control" id="pwd1" name="memberPw" 
                            placeholder="영어 대소문자, 숫자, 특수문자(선택) 조합 8자 이상" maxlength="20" placeholder="비밀번호를 입력하세요" required>
                        </div>
                        <div class="col-md-6 offset-md-3">
							<span id="checkPwd1">&nbsp;</span>
						</div>

                    </div>
    
                    <!-- 비밀번호 확인 -->
                    <div class="row mb-3 form-row">
                        <div class="col-md-3">
                            <label for="pwd2">* 비밀번호 확인</label>
                        </div>
                        <div class="col-md-9">
                            <input type="password" class="placeholder form-control" id="pwd2" 
                            placeholder="영어 대소문자, 숫자, 특수문자(선택) 조합 8자 이상" maxlength="20" placeholder="비밀번호 확인" required>
                        </div>
                        <div class="col-md-6 offset-md-3">
							<span id="checkPwd2">&nbsp;</span>
						</div>
                    </div>
    
                    <!-- 닉네임 -->
                    <div class="row mb-3 form-row">
                        <div class="col-md-3">
                            <label for="nickName">* 닉네임</label>
                        </div>
                        <div class="col-md-9">
                            <input type="text" class="form-control" id="nickName" name="memberNick" required>
                        </div>
                        <div class="col-md-6 offset-md-3">
							<span id="checkNickName">&nbsp;</span>
						</div>
                    </div>

                    <!-- 이메일 -->
                    <div class="row mb-3 form-row">
                        <div class="col-md-3">
                            <label for="email">* Email</label>
                        </div>
                        <div class="col-md-9">
                            <input type="email" class="form-control" id="email" name="memberEmail" autocomplete="off" required>
                        </div>
                    </div>
    
                    <!-- 전화번호 -->
                    <div class="signUp-input form-group">
                        <div class="col-md-3">
							<label for="phone1">* 전화번호</label>
						</div>
                        <div class="signUp-phoneArea">
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
                    <!--전화번호 인증확인-->
                    <div class="row mb-3 form-row">
                        <div class="col-md-3">
                            <label for="smsCheck">* 번호인증</label>
                        </div>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="smsNum" name="smsNum" autocomplete="off" required>
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-light" id="smsCheck">인증 확인</button>
                        </div>
                    </div>
    
    
                    <hr class="mb-4">
                    <div class="signUp-btnArea">
                        <button class="btn btn-secondary btn-md " type="submit">메인으로 돌아가기</button>
                        <button class="btn btn-primary btn-md " type="submit">가입하기</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
    
    <script type="text/javascript">
    
 	// 전화번호 인증번호 발신
    var memberPhone1 = "";

    $("#smsSend").on("click", function(){
    const phone = $("[name='phone']");
    var memberPhone1 = $(phone[0]).val() + "-" + $(phone[1]).val() + "-" + $(phone[2]).val();

        $.ajax({
            url : "${contextPath}/coolSMS/send",  // 요청 주소(필수로 작성!)
            data : {"memberPhone" : memberPhone1,}, // 전달하려는 값(파라미터)
            type : "post",
            dataType : "JSON",
            success : function(result){
            	if(result == 1) {
                	checkObj.smsCheck = false;
	                swal("인증 실패", "번호 인증을 다시 시도해주세요.", "error");
                } else if(result == 2){
                	checkObj.smsCheck = false;
	                swal("인증 실패", "이미 가입되어 있는 번호입니다.", "error");
                } else{
	                swal("인증번호 전송 완료", "문자를 확인하고 인증번호를 입력해주세요.", "success");

	                $("#smsCheck").on("click", function(event){
	                	
	                    if(result == $("#smsNum").val().trim()){
	                    	
						    const inputPhone = $("<input>", {type:"hidden", name:"memberPhone1", value:memberPhone1})
						    $("form[name='signUpForm']").append(inputPhone);
						    
	                    	checkObj.smsCheck = true;
			                swal("인증 성공!", "회원가입을 진행해주세요.", "success");
			                
	                    } else {
	                    	checkObj.smsCheck = false;
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
    })
    </script>
    <script src="${contextPath}/resources/js/member/member.js"></script>
</body>
</html>