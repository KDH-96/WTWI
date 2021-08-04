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

    <title>내 정보</title>
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
        .searchId-body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .searchId-main {
            width: 50%;
        }
        .searchId-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
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
    </style>
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/myPage/sideBar.jsp"></jsp:include>

<body class="myPage-body">

    <main class="myPage-main">
        <div class="myPage-main__list">
            <h2>내 정보</h2>
            <c:if test="${loginMember.memberGrade == 'B'}">
	            <div>
	                <span>아이디</span>
	                <span>${loginMember.memberId }</span>
	            </div>                        
            </c:if>
            <div>
                <span>닉네임</span>
                <span>${loginMember.memberNick }</span>
            </div>
            <div>
                <span>이메일</span>
                <span>${loginMember.memberEmail }</span>
            </div>
            <c:if test="${loginMember.memberGrade == 'B'}">
	            <div>
	                <span>휴대폰 번호</span>
	                <span>${loginMember.memberPhone }</span>
	            </div>
            </c:if>
            <div class="myPage-main__btnArea">
                <a class="btn btn-primary" href="${contextPath }/member/update">내 정보 수정</a>
            </div>
        </div>
    </main>
</body>
</html>