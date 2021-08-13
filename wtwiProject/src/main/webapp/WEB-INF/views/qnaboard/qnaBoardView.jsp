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

		li{
            list-style: none;
		}

        summary li {
            width: 100%;
            height: 100%;
            float: left;
        }

        summary li a {
            color: black;
            font-weight: bold;
        }

        ul li a:hover {
            color: orange;
            cursor:pointer;
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
            width: 250px;
            height: 100%;
            float: left;

        }

        #writer-modify-area {
            width: 250px;
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
            	<c:if test="${board.nextNo != 0}">
                <a class="btn btn-primary float-right" id="nextBtn" href="${board.nextNo}?cp=${pagination.currentPage}${searchStr}">다음글</a>
            	</c:if>
            	<c:if test="${board.preNo != 0}">
                <a class="btn btn-primary float-right mr-2" id="preBtn" href="${board.preNo}?cp=${pagination.currentPage}${searchStr}">이전글</a>
            	</c:if>
            </div>


        </div>

        <hr>

        <div id="content-area1">

            <div id="category-area">
                <!-- Category -->
                <h6 name="qnaCategoryNo" style="line-height: 35px;">[${board.qnaCategoryNm}]</h6>
            </div>

            <div id="content-title-area">
                <h6 style="line-height: 35px;">${board.qnaTitle}</h6>
            </div>

			<c:if test="${loginMember.memberNo == board.memberNo }">
            <div id="more-area">
                <details>
                    <summary>더보기</summary>
                    <ul>
                        <li id="update"><a href="#" onclick="fnRequest('updateForm')">수정</a></li>
                        <li id="delete"><a href="#" onclick="deleteAlert();">삭제</a></li>
                    </ul>
                </details>
            </div>
			</c:if>
        </div>

        <div id="content-area2">

            <div id="writer-area">
                <!-- 회원이 글 쓴 내용 -->
  
                <i class="bi bi-person-circle" style="line-height: 35px;">${board.memberNick}</i>
            </div>

            <div id="view-count-area" style="display: flex;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="35" fill="currentColor" class="bi bi-eye"
                    viewBox="0 0 16 16">
                    <path
                        d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z" />
                    <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z" />
                </svg>
                &nbsp;
                <h6 style="line-height: 35px;">${board.qnaReadCount}</h6>
            </div>

            <div id="write-date-area">
                <fmt:formatDate var="qnaCreateDt" value="${board.qnaCreateDt}" pattern="yyyy-MM-dd"/>
               	<fmt:formatDate var="qnaModifyDt" value="${board.qnaModifyDt}" pattern="yyyy-MM-dd"/>
		        <fmt:formatDate var="today" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>
		        <c:choose>
		        	<c:when test="${qnaCreatedt!=today}">
  		              <h6 style="line-height: 35px;">작성일 : ${qnaCreateDt}</h6>
		        	</c:when>
		        	<c:otherwise>
  		              <h6 style="line-height: 35px;">작성일 : <fmt:formatDate value="${qnaCreateDt}" pattern="yyyy-MM-dd (HH:mm)"/></h6>
		        	</c:otherwise>
		        </c:choose>
            </div>

            <div id="writer-modify-area">
	            <c:choose>
			        	<c:when test="${qnaModifydt!=today}">
			                <h6 style="line-height: 35px;">수정일 : ${qnaModifyDt}</h6>
			        	</c:when>
			        	<c:otherwise>
			                <h6 style="line-height: 35px;">수정일 : <fmt:formatDate value="${qnaModifyDt}" pattern="yyyy-MM-dd (HH:mm)"/></h6>
			        	</c:otherwise>
			        </c:choose>
            </div>

            <div id="writer-visible-area">
                <c:set var="qnaStatus" value="${board.qnaStatus}"/>
		        	<c:if test="${qnaStatus == 'Y'}">
		                <span class="bi bi-unlock-fill" style="line-height: 35px; font-weight: bold;">공개</span>
		        	</c:if>
		        	<c:if test="${qnaStatus == 'S'}">
		                <span class="fas fa-lock" style="line-height: 35px;">비공개</span>
		        	</c:if>
            </div>


        </div>

		<hr>
        <br>


        <!-- 관리자가 글 쓴 내용  -->

        <div id="content-box">
            <span id="member-content-detail">${board.qnaContent}</span>
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
		
				<%-- 로그인 되어 있을 경우에만 글쓰기 버튼 노출 --%>
		<c:if test="${loginMember.memberGrade=='A'}"> 
			<%-- <button type="button" class="btn btn-primary float-right" id="insertBtn"
				 onclick="location.href='../board2/insertForm?type=${pagination.boardType}';">글쓰기</button> --%>
			<a class="btn btn-primary float-right" id="insertBtn" href='${contextPath}/qnaboard/insertFormRE?qnaPno=${board.qnaNo}&qnaCategoryNo=${board.qnaCategoryNo}'>답글달기</a>
		 </c:if> 

		<br>
		<br>
        <hr>


		<jsp:include page="qnaReply.jsp"></jsp:include> 



        <hr>


				<%-- 검색 상태 유지를 위한 쿼리스트링용 변수 선언 --%>
					<c:if test="${!empty param.sk && !empty param.sv }">
						<%-- 검색은  게시글 목록 조회에 단순히 sk, sv 파라미터를 추가한 것
								-> 목록 조회 결과 화면을 만들기 위해 boardList.jsp로 요청 위임 되기 때문에
									 request객체가 유지되고, 파라미터도 유지된다.
						--%>
						
					<c:set var="searchStr" 
							value="&sk=${param.sk}&sv=${param.sv}"  />
					</c:if>
					

        <div class=text-left>
            <a href="${contextPath}/qnaboard/list?cp=${param.cp}${searchStr}" class="btn btn-primary">목록으로</a>
        </div>


    </div>
	
	
	<form action="#" method="POST" name="requestForm">
		<input type="hidden" name="qnaNo" value="${board.qnaNo}">
		<input type="hidden" name="cp" value="${param.cp}">
	</form>
	
	
	<script>
		function fnRequest(addr){
			// 현재 문서 내부에 name속성 값이 requestForm인 요소의 action 속성 값을 변경
			document.requestForm.action = addr;
			// 현재 문서 내부에 name속성 값이 requestForm인 요소를 제출해라
			document.requestForm.submit();
		}
		// 삭제시 알림창 띄우기
		function deleteAlert(){
			swal({
				icon: "warning",
				title: "게시글을 삭제하시겠습니까?",
				buttons: ["취소", "삭제"],
				dangerMode: true,
			}).then((willDelete) => {
				if (willDelete) {
					onclick=fnRequest("delete");
				} 
			});
		}
		
		
	</script>
	
	
	
</body>
</html>
