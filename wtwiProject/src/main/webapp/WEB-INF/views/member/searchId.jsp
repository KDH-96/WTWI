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

    <title>아이디 찾기</title>
    <style>
        .searchId-body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .searchId-main {
            display: flex;
			width: 70%;
			height: 60vh;
        }
        .searchId-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 50%;
        }

        .searchId-title {
            margin-bottom: 20px;
        }

        .searchId-pageArea {
            margin-bottom: 20px;
        }
        .searchId-form {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 60%;
            margin-top: 20px;
        }

        .searchId-input {
            display: flex;
            justify-content: center;
            width: 100%;
        }

        .searchId-input label {
        	margin-top: 10px;
            width: 100px;
        }
        .searchId-btnArea {
            display: flex;
            flex-direction: column;
            margin-top: 20px;
        }

        .searchId-btnArea {
            width: 60%;
        }

        .searchId-btnArea button:first-child {
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

<body class="searchId-body">

    <main class="searchId-main">
		<div class="img-container">
			<div class="loginImg-container"></div>
		</div>
        <div class="searchId-container">

            <div class="searchId-title">
                <h2>아이디 찾기</h2>
            </div>

            <div class="searchId-pageArea">
                <a class="btn btn-secondary" href="${contextPath}/member/searchIdForm"">아이디 찾기</a>
                <a class="btn btn-secondary" href="${contextPath}/member/searchPwForm"">비밀번호 찾기</a>
            </div>

            <div class="searchId-form">
                  <div class="searchId-input form-group">
                    <label for="exampleInputPassword1">이메일</label>
                    <input type="email" class="form-control" id="email" name="memberEmail">
                  </div>
                  <div class="searchId-btnArea">
                      <button type="button" class="btn btn-primary" id="searchId">아이디 찾기</button>
                      <a type="button" class="btn btn-primary" href="${contextPath}">메인으로</a>
                  </div>
            </div>

        </div>

    </main>
    
    <script type="text/javascript">
    
    var memberPhone1 = "";

    $("#searchId").on("click", function(){
    const memberEmail = $("#email").val();
    
        $.ajax({
            url : "${contextPath}/member/searchId",  // 요청 주소(필수로 작성!)
            data : {"memberEmail" : memberEmail,}, // 전달하려는 값(파라미터)
            type : "post",
            success : function(id){
            	if(id == ""){
            		swal("아이디 찾기 실패", "기입한 이메일에 해당하는 아이디가 없습니다.", "error");
            	} else {
	            	console.log(id);
            		$(".searchId-input").html(""); 
            		var inputArea = $("<div>").addClass(['searchId-input', 'form-group']);
            		var result = $("<span>").text("회원가입 시 사용한 아이디는 [ "+id+" ] 입니다.");
				    inputArea.append(result);
            		$(".searchId-form").prepend(inputArea);
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
</body>
</html>