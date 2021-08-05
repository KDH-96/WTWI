<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" scope="application" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WTWI header</title>
	
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
	
	<!-- Bootstrap core JS -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
	
	<!-- sweetalert API 추가 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	<!-- summernote -->
	<script src="${contextPath}/resources/js/summernote/summernote-lite.js"></script>
	<script src="${contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="${contextPath}/resources/css/summernote/summernote-lite.css">
	
	<link href="${contextPath}/resources/css/style.css" rel="stylesheet">
	
	<!-- jQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	
    <style>
        /* 헤더 영역 시작 */
        header {
            height: 150px;
            background-color: white;
            animation: slide_right 1.2s linear forwards;
        } 

        #logo-area {
            margin-left: 60%;
            width: 150px;
            height: 100%;
            box-sizing: border-box;
        }

        @keyframes slide_right {
            0% {
                transform: translateY(100px);
                opacity: 0;
            }

            100% {
                transform: translateY(0px);
                opacity: 1;
            }
        }

        /* 헤더 영역 끝 */


        .col-3 button {
            margin: 0 5px;
        }


        /* 네비 바 영역 시작 */
        .nav-scroller {
            height: 50px;
            background-color: white;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.6);
            animation: slide_right 1.2s linear forwards;
        }

        .nav li {
            margin: 0 30px;
        }

        .nav li a {
            color: black;
            font-size: 20px;
            font-weight: bold;
            text-decoration: none;
            position: relative;
            animation: slide_right 0.5s linear forwards;
        }

        @keyframes slide_right {
            0% {
                transform: translateY(100px);
                opacity: 0;
            }

            100% {
                transform: translateY(0px);
                opacity: 1;
            }
        }

        @media screen and (max-width: 1000px) {
            .flex-nowrap{
                flex-direction: column;
                height: inherit;
            }
            .search-box{
                flex-direction: column;
                height: inherit;
                text-align: center;
            }
            .form-control{
                text-align: center;
            }
            
            .nav {
                flex-direction: column;
            }

            .nav-scroller {
                height: inherit;
            }
            
            .nav li {
                flex-direction: column;
                text-align: center;
                padding : 8px 24px;
                width: 100%;
            }
            .justify-content-end{
                flex-direction: column;
                text-align: center;
                padding : 8px 24px;
                height: inherit;
            }
            
            
        }

        .nav li a:hover {
            color: orange;
        }

        .nav li a:before {
            content: '';
            background-color: orange;
            width: 0;
            height: 2px;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: 0;
            transition: 0.5s;
        }

        .nav li a:hover::before {
            width: 100%;
        }



        /* 네비 바 영역 끝 */

        img {
            width: 100%;
            height: 100%;
        }



        body {
            margin-top: 210px;
        }
    </style>


</head>

<body>
    <div class="fixed-top" id="header-area">

        <header class="row flex-nowrap justify-content-between align-items-center">
            <div class="col-4 pt-1">
                <div id="logo-area">
                    <a href="#"><img src="img/파이널 로고22psd.jpg"></a>
                </div>
            </div>


            <div class="col-4 pt-1 search-box" id="header2" >

                <select class="form-control" name="" id="" style="width: 150px; float: left;">
                    <option value="오늘의 날씨" style="height: 100%;">오늘의 날씨</option>
                    <option value="오늘의 날씨" style="height: 100%;">오늘의 날씨</option>
                    <option value="오늘의 날씨" style="height: 100%;">오늘의 날씨</option>
                </select>

                <input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
                    type="text" style="width: 300px; float: left;">

                <div class="input-group-prepend" style="width: 45px; height: 35px; float: left;">
                    <button type="button" class="btn btn-secondary" style="width: 100%; height: 100%;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="26" fill="currentColor"
                            class="bi bi-search" viewBox="0 0 20 25">
                            <path
                                d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                        </svg>
                    </button>
                </div>

            </div>


			<c:choose>
				<c:when test="${empty loginMember }">				
		            <div class="col-4 d-flex justify-content-end align-items-center">
		                <a class="btn btn-dark mr-2" href="${contextPath}/member/searchIdForm"">ID/PW찾기</a>
		                <a class="btn btn-dark mr-2" href="${contextPath}/member/login"">로그인</a>
		            </div>
				</c:when>
				<c:otherwise>
					<div class="col-4 d-flex justify-content-end align-items-center">
						<a class="btn btn-dark mr-3" href="${contextPath}/member/myPage"">${loginMember.memberNick }</a>
						<a class="btn btn-dark mr-3" href="${contextPath}/member/logout"">로그아웃</a>
					</div>
				</c:otherwise>
			</c:choose>


        </header>





        <div class="nav-scroller py-1 mb-2">
            <nav class="nav d-flex justify-content-center">

                    <li><a class="p-2" href="#">오늘의 날씨</a></li>
                    <li><a class="p-2" href="${contextPath}/attraction/list">명소</a></li>
                    <li><a class="p-2" href="${contextPath}/freeboard/list">자유게시판</a></li>
                    <li><a class="p-2" href="${contextPath}/qnaboard/list">문의게시판</a></li>
            </nav>
        </div>

    </div>








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