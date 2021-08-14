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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/FortAwesome/Font-Awesome@5.14.0/css/all.min.css"> 

    <title>마이페이지 - 사이드바</title>
    <style>
      .myPage-sideBar {
            display: flex;
            flex-direction: column;
        }
    </style>
</head>

<body class="myPage-body">

     <div class="myPage-sideBar col-sm-2 ">
        <ul class="list-group">
            <li class="list-group-item list-group-item-action"><a href="${contextPath }/myPage/main">내 정보</a></li>
       		<c:if test="${loginMember.memberGrade != 'M'}">
	            <li class="list-group-item list-group-item-action"><a href="${contextPath }/member/update">내 정보 수정</a></li>            
       		</c:if>
       		<c:if test="${loginMember.memberGrade == 'B'}">
	            <li class="list-group-item list-group-item-action"><a href="${contextPath }/member/changePwd">비밀번호 변경</a></li>
       		</c:if>
            <li class="list-group-item list-group-item-action"><a href="${contextPath }/myPage/post">내가 쓴 글</a></li>
            <li class="list-group-item list-group-item-action"><a href="${contextPath }/myPage/reply">내가 쓴 댓글</a></li>
            <li class="list-group-item list-group-item-action"><a href="${contextPath }/myPage/report">신고내역</a></li>
            <li class="list-group-item list-group-item-action"><a href="${contextPath }/myPage/chat">1:1 문의내역</a></li>
            <li class="list-group-item list-group-item-action"><a href="${contextPath }/member/secession">회원탈퇴</a></li>
        </ul>
    </div>
    <%-- 로그인 실패와 같은 메세지가 서버로 부터 전달되어 온 경우 출력 --%>
	<c:if test="${!empty title }">
		<script>
			swal({
				"icon"  : "${icon}",
				"title" : "${title}",
				"text"  : "${text}"
			});
			
		</script>
		
	</c:if>

</body>
</html>