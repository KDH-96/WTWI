<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- fmt 태그 : 문자열, 날짜, 숫자의 형식(모양)을 지정하는 태그 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글</title>

    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/FortAwesome/Font-Awesome@5.14.0/css/all.min.css">


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
        integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <!-- Bootstrap core JS -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
        crossorigin="anonymous"></script>

    <!-- sweetalert API 추가 -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
        .container{
            animation: slide_right 1s linear forwards;
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




        .event-header {
            width: 100%;
            height: 60px;
        }

        #inquiry-title-area {
            width: 300px;
            height: 100%;
            float: left;
        }

        .listBtnArea {
            width: 200px;
            height: 100%;
            text-align: right;
            float: right;
        }

        #content-area1 {
            width: 100%;
            height: 40px;
        }

        #category-area {
            width: 20%;
            height: 100%;
            float: left;
        }

        #content-title-area {
            width: 40%;
            height: 100%;
            float: left;
        }

        #more-area {
            width: 9%;
            height: 100%;
            text-align: center;
            float: right;
        }


        /* 더보기 */


        #more-area {
            border: 1px black;
        }

        details[open]>summary~* {
            animation: reveal 0.5s;
        }

        summary {
            width: 100%;
            height: 100%;
            line-height: 40px;
        }

        summary:hover {
            background-color: lightgray;
            transition: 0.3s;
        }

        @keyframes reveal {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        li {
            width: 100%;
            height: 100%;
            float: left;
            list-style: none;
        }

        li a {
            color: black;
            font-weight: bold;
        }

        ul li a:hover {
            color: orange;
            text-decoration: none;
        }










        #content-area2 {
            width: 100%;
            height: 40px;
        }

        #writer-area {
            width: 150px;
            height: 100%;
            line-height: 20px;
            float: left;
        }

        #view-count-area {
            width: 150px;
            height: 100%;
            float: left;

        }

        #write-date-area {
            width: 200px;
            height: 100%;
            float: left;

        }

        #writer-modify-area {
            width: 200px;
            height: 100%;
            float: left;

        }

        #writer-visible-area {
            display: flex;
            width: 150px;
            height: 100%;
            float: left;

        }

</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"></jsp:include>
	
 <div class="container shadow p-3 mb-5 bg-white rounded">


        <div class="event-header">
            <div id="inquiry-title-area">
                <h1>문의게시판</h1>
            </div>

            <div class="listBtnArea">
                <button class="btn btn-primary btn-sm ml-1" id="previous" onclick="">이전</button>
                <button class="btn btn-primary btn-sm ml-1" id="next" onclick="">다음</button>
            </div>


        </div>

        <hr>

        <div id="content-area1">

            <div id="category-area">
                <!-- Category -->
                <h6 style="line-height: 35px;">[말머리]</h6>
            </div>

            <div id="content-title-area">
                <h6 style="line-height: 35px;">제목</h6>
            </div>

            <div id="more-area">
                <details>
                    <summary>더보기</summary>
                    <ul>
                        <li><a href="#">수정</a></li>
                        <li><a href="#">삭제</a></li>
                    </ul>
                </details>
            </div>

        </div>

        <div id="content-area2">

            <div id="writer-area">
                <!-- 회원이 글 쓴 내용 -->
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                    class="bi bi-person-circle" viewBox="0 0 16 16">
                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
                    <path fill-rule="evenodd"
                        d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z" />
                </svg>
                <i class="bi bi-person-circle" style="line-height: 35px;">작성자</i>
            </div>

            <div id="view-count-area" style="display: flex;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="35" fill="currentColor" class="bi bi-eye"
                    viewBox="0 0 16 16">
                    <path
                        d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z" />
                    <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z" />
                </svg>
                &nbsp;
                <h6 style="line-height: 35px;">조회수</h6>
            </div>

            <div id="write-date-area">
                <h6 style="line-height: 35px;">작성일 :</h6>
            </div>

            <div id="writer-modify-area">
                <h6 style="line-height: 35px;">수정일 : </h6>
            </div>

            <div id="writer-visible-area">
                <i class="fas fa-lock" style="line-height: 35px;"></i>
                &nbsp;
                &nbsp;
                <h6 style="line-height: 35px;">공개/비공개</h6>
            </div>


        </div>

        <br>


        <!-- 관리자가 글 쓴 내용  -->

        <div id="content-box">
            <span id="member-content-detail">글쓴 내용</span>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
        </div>


        <hr>





        <hr>




        <div class=text-left>
            <a href="inquiry-board-list.html" class="btn btn-primary">목록으로</a>
        </div>


    </div>
	
	
	<form action="#" method="POST" name="requestForm">
		<input type="hidden" name="boardNo" value="${board.boardNo}">
		<input type="hidden" name="cp" value="${param.cp}">
	</form>
	
	
	<script>
		function fnRequest(addr){
			
			// 현재 문서 내부에 name속성 값이 requestForm인 요소의 action 속성 값을 변경
			document.requestForm.action = addr;
			
			// 현재 문서 내부에 name속성 값이 requestForm인 요소를 제출해라
			document.requestForm.submit();
			
		}
		
	</script>
	
	
	
</body>
</html>
