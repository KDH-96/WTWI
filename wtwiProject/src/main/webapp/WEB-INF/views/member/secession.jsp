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
       
    </style>
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/myPage/sideBar.jsp"></jsp:include>

<body class="myPage-body">


    <main class="myPage-main">

        <h2>회원 탈퇴</h2>
        <form action="${contextPath }/member/secessionAction" class="myPage-secession__form"" method="POST" >
            <div class="row mb-3 form-row">
            	<c:if test="${loginMember.memberGrade == 'B' }">
	                <div class="col-md-3">
	                    <label for="currentPwd">현재 비밀번호</label>
	                </div>
	                <div class="col-md-6">
	                    <input type="password" class="form-control" id="currentPwd" name="currentPwd" required>
	                </div>
            	</c:if>
            </div>
            <div class="secession-btnArea">
                <button class="btn btn-primary btn-md " type="button"  onclick="deleteRequest();">회원탈퇴 신청</button>
            </div>
        </form>
    </main>

    <script>
        // 탈퇴여부 확인 swal창
        function deleteRequest(){
			var result = false;
			swal({
				  title: "정말 탈퇴하시겠습니까?",
                  text: "회원 복구는 대표전화 문의를 통해 가능합니다",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then(function(willDelete) { // <=== Only change is here
					if (willDelete) {
						// 현재 문서 내부에  name 속성값이 requestForm인 요소를 submit
						$(".myPage-secession__form").submit();
					}
				});
		}
    </script>
</body>
</html>