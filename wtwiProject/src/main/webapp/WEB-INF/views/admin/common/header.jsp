<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" scope="application" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Admin</title>
   
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
	
	<!-- Bootstrap core JS -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
	
	<!-- sweetalert API 추가 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
   <style>
      @font-face {
         font-family: 'NEXON Lv1 Gothic OTF';
         src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv1 Gothic OTF.woff') format('woff');
         font-weight: normal;
         font-style: normal;
      }
      body * {
         font-family: 'NEXON Lv1 Gothic OTF';
      }
      .header {
         /* background-color: red; */
         width: 1200px;
         height: 80px;
         box-sizing: border-box;
         text-align: left;
         line-height: 70px;
         border-bottom: 1px solid lightgray;
         margin-bottom : 30px;
         margin-left: auto;
         margin-right: auto;
      }
      /* 로고박스 */
      .header-logobox {
         width: 10%;
         height: 100%;
         box-sizing: border-box;
         float: left;
      }

      /* 로고 */
      #header-logo {
         width: 100%;
         height: 90%;

      }
      /* 버튼박스 */
      .header-buttonbox {
         width: 30%;
         height: 100%;
         text-align: center;
         box-sizing: border-box;
         margin: auto;
         float: right;
      }
      .navi-li a:hover {
         color: pink;
      }
      .navi-a{
         text-decoration: none;
         color : black;
         display: inline-block;
      }
      .navi-li{
         text-align: center;
         float:left;
         margin-left : 50px;
         margin-right: 50px
      }
      .navi-ul{
         list-style-type: none;
      }
   </style>
</head>

<body>

    <!-- header -->
    <div class="header">
        <div class="header-logobox">
            <a href="${contextPath}">
                <img src="파이널 로고22psd.jpg" id="header-logo">
            </a>
        </div>
        <div class="header-rightside">
            <div class="header-buttonbox">
                <button type="button" class="btn btn-dark">memberId</button>
                <button type="button" class="btn btn-dark" id="logout-btn">logout</button>
            </div>
            <div class="header-navibox">
                <ul class="navi-ul">
                    <li class="navi-li"><a class="navi-a" href="${contextPath}/admin/main/mainConfiguration">Main</a></li>
                    <li class="navi-li"><a class="navi-a" href="${contextPath}/admin/attraction/attractionList">Attraction</a></li>
                    <li class="navi-li"><a class="navi-a" href="${contextPath}/admin/member/memberList">Members</a></li>
                    <li class="navi-li"><a class="navi-a" href="${contextPath}/admin/boards"> Boards </a></li>
                 </ul>
            </div>
        </div>
    </div>

   <!-- ===============================영역구분선=============================== -->
      
   	<script>
		document.getElementById("logout-btn").addEventListener("click",function() {
			swal("로그아웃 하시겠습니까?", "", {
				"buttons" : {
					"cancel" : "아니오",
					"catch" : {
						"text" : "네",
						"value" : "yes",
					},
				},
			})
					.then(
							function(value) {
								if (value == "yes") {

									window.location.href = "${contextPath}/admin/logout";
								}
							});
		});
		
		
	</script>
	<c:if test="${ !empty title }">
	<script>
		swal({
			"icon" : "${ icon }",
			"title": "${ title }",
			"text" : "${ text }"
		});
	</script>
	</c:if>

</body>

</html>