<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의게시판</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/FortAwesome/Font-Awesome@5.14.0/css/all.min.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">


<style>
.container {
	animation: slide_right 1s linear forwards;
}

@
keyframes slide_right { 0% {
	transform: translateY(100px);
	opacity: 0;
}

100




%
{
transform




:




translateY


(




0px




)


;
opacity




:




1


;
}
}

/* 게시글 목록 내부 td 태그 */
#list-table td {
	padding: 0; /* td 태그 padding을 없앰 */
	vertical-align: middle; /* td태그 내부 세로 가운데 정렬*/
	/* vertical-align : inline, inline-block 요소에만 적용 가능(td는 inline-block)*/
}

/* 컬럼명 가운데 정렬 */
#list-table th {
	text-align: center;
}

/* 게시글 제목을 제외한 나머지 가운데 정렬 */
#list-table td:not(:nth-of-type(3)) {
	text-align: center;
}

.list-wrapper {
	min-height: 350px;
}

#list-table th:nth-child(3) {
	width: 30%;
	text-align : left;
}
#list-table th:nth-child(4) {
	width: 15%;
}
#list-table th:nth-child(6) {
	width: 15%;
}
/* 글 제목 영역의 너비를 table의 50% 넓게 설정*/
#list-table td:nth-child(3) {
	width: 30%;
}

/* 제목 a태그 색 변경 */
#list-table td:nth-child(3)>a {
	color: black;
}

.pagination {
	justify-content: center;
}

#searchForm {
	position: relative;
}

#searchForm>* {
	top: 0;
}

</style>

</head>
<body>
	<jsp:include page="../common/header.jsp"></jsp:include>
	<div class="container my-5">

		<div class="qna-header">
			<div style="float: left;">
			<i class="fas fa-question fa-2x" style="margin: 25px 10px"></i>
			</div>
			<div style="float: left;">
			<h3 class="my-4 font-weight-bold">문의게시판</h1>
			</div>
		</div>
		<div class="list-wrapper">
			<table class="table table-hover table-striped my-5" id="list-table">
				<thead>
					<tr>
						<th scope="col" class="qb-no">글번호</th>
						<th scope="col" class="qb-category">말머리</th>
						<th scope="col">제목</th>
						<th scope="col" class="qb-writer">작성자</th>
						<th scope="col" class="qb-count">조회수</th>
						<th scope="col" class="qb-date">작성일</th>
						<th scope="col" class="qb-status">공개여부</th>
					</tr>
				</thead>


				<%-- 검색 상태 유지를 위한 쿼리스트링용 변수 선언 --%>
				<c:if test="${!empty param.sk && !empty param.sv }">
					<%-- 검색은  게시글 목록 조회에 단순히 sk, sv 파라미터를 추가한 것
								-> 목록 조회 결과 화면을 만들기 위해 boardList.jsp로 요청 위임 되기 때문에
									 request객체가 유지되고, 파라미터도 유지된다.
						--%>

					<c:set var="searchStr" value="&sk=${param.sk}&sv=${param.sv}" />
				</c:if>


				<%-- 게시글 목록 출력 --%>
				<tbody>

					<c:choose>

						<%-- 조회된 게시글 목록이 없는 경우 --%>
						<c:when test="${empty boardList}">
							<tr>
								<td colspan="7">게시글이 존재하지 않습니다.</td>
							</tr>
						</c:when>


						<%-- 조회된 게시글 목록이 있을 경우 --%>
						<c:otherwise>

							<c:forEach items="${boardList}" var="qnaBoard">
								<c:set var="qnaPno" value="${qnaBoard.qnaPno}"/>
								<c:set var="qnaNo" value="${qnaBoard.qnaNo}"/>
								<tr>
									<%-- 글 번호 --%>
									<td>
									<c:if test="${qnaPno > 0}"></c:if>
									<c:if test="${qnaPno == 0}">${qnaBoard.qnaNo}</c:if>
									</td>

									<%-- 카테고리 --%>
									<td>
									<c:if test="${qnaPno > 0}"></c:if>
									<c:if test="${qnaPno == 0}">${qnaBoard.qnaCategoryNm}</c:if>
									</td>

									<%-- 글 제목 --%>
									<td class="boardTitle">
									
									<a href="${qnaBoard.qnaNo}?cp=${pagination.currentPage}${searchStr}">
									<c:if test="${qnaPno > 0}"> &nbsp;&nbsp;&nbsp; -> [답글] ${qnaBoard.qnaTitle}</c:if>
									<c:if test="${qnaPno == 0}">${qnaBoard.qnaTitle}</c:if>
									</a>
									
									</td>

									<%-- 작성자 --%>
									<td>${qnaBoard.memberNick}</td>

									<%-- 조회수 --%>
									<td>${qnaBoard.qnaReadCount}</td>

									<%-- 작성일 --%>
									<td>
									<fmt:formatDate var="createDate" value="${qnaBoard.qnaCreateDt}" pattern="yyyy-MM-dd" />
									<fmt:formatDate var="today" value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" />
										<c:choose>
											<%-- 글 작성일이 오늘이 아닐 경우 --%>
											<c:when test="${createDate != today}">${createDate}</c:when>
											<%-- 글 작성일이 오늘일 경우 --%>
											<c:otherwise><fmt:formatDate value="${qnaBoard.qnaCreateDt}" pattern="HH:mm" /></c:otherwise>
										</c:choose>
									</td>
									<%-- 공개여부 --%>
									<td>
									<c:set var="qnaStatus" value="${qnaBoard.qnaStatus}"/>
									<c:if test="${qnaStatus == 'Y'}">공개</c:if>
									<c:if test="${qnaStatus == 'S'}">비공개</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>


				</tbody>
			</table>
		</div>
			

		<%-- 로그인 되어 있을 경우에만 글쓰기 버튼 노출 --%>
		<c:if test="${!empty loginMember }"> 
			<%-- <button type="button" class="btn btn-primary float-right" id="insertBtn"
				 onclick="location.href='../board2/insertForm?type=${pagination.boardType}';">글쓰기</button> --%>
			<a class="btn btn-primary float-right" id="insertBtn" href='${contextPath}/qnaboard/insertForm'>글쓰기</a>
		 </c:if> 


		<%---------------------- Pagination start----------------------%>
		<%-- 페이징 처리 시 주소를 쉽게 작성할 수 있도록 필요한 변수를 미리 선언 --%>

		<c:set var="pageURL" value="list" />

		<c:set var="prev"
			value="${pageURL}?cp=${pagination.prevPage}${searchStr}" />
		<c:set var="next"
			value="${pageURL}?cp=${pagination.nextPage}${searchStr}" />


		<div class="my-5">
			<ul class="pagination">

				<%-- 현재 페이지가 10페이지 초과인 경우 --%>
				<c:if test="${pagination.currentPage > pagination.pageSize }">
					<li><a class="page-link" href="${prev}">&lt;&lt;</a></li>
				</c:if>

				<%-- 현재 페이지가 2페이지 초과인 경우 --%>
				<c:if test="${pagination.currentPage > 2 }">
					<li><a class="page-link"
						href="${pageURL}?cp=${pagination.currentPage - 1}${searchStr}">&lt;</a></li>
				</c:if>



				<%-- 페이지 목록 --%>
				<c:forEach var="p" begin="${pagination.startPage}"
					end="${pagination.endPage}">

					<c:choose>
						<c:when test="${p == pagination.currentPage }">
							<li class="page-item active"><a class="page-link">${p}</a></li>
						</c:when>

						<c:otherwise>
							<li><a class="page-link"
								href="${pageURL}?cp=${p}${searchStr}">${p}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<%-- 현재 페이지가 마지막 페이지 미만인 경우 --%>
				<c:if test="${pagination.currentPage < pagination.maxPage }">
					<li><a class="page-link"
						href="${pageURL}?cp=${pagination.currentPage + 1}${searchStr}">&gt;</a></li>
				</c:if>

				<%-- 현재 페이지가 마지막 페이지가 아닌 경우 --%>
				<c:if
					test="${pagination.currentPage - pagination.maxPage + pagination.pageSize < 0}">
					<li><a class="page-link" href="${next}">&gt;&gt;</a></li>
				</c:if>

			</ul>
		</div>
		<%---------------------- Pagination end----------------------%>




		<!-- 검색창 -->
		<div class="row d-flex justify-content-center">
			<form action="list" method="GET" class="text-center" id="searchForm">
				<div class="input-group mb-3">
					<select name="sk" class="form-control col-4" id="formKey" ">
						<option value="title">글제목</option>
						<option value="content">내용</option>
						<option value="titcont">제목+내용</option>
						<option value="writer">작성자</option>
						<option value="category">카테고리</option>
					</select>
					&nbsp;
					<select name="sc" class="form-control col-4" id="formCategory" style="display:none;">
						<option value="1">명소 정보</option>
						<option value="2">시스템</option>
						<option value="3">기타</option>
					</select>
					&nbsp;
					<input type="text" name="sv" class="form-control col-6">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
	</div>



	<script>
		// 검색 내용이 있을 경우 검색창에 해당 내용을 작성해두는 기능
		(function() {
			var searchKey = "${param.sk}";
			// 파라미터 중 sk가 있을 경우   ex)  "abc"
			// 파라미터 중 sk가 없을 경우   ex)  ""
			var searchValue = "${param.sv}";
			var searchCategory = "${param.sc}";

			// 검색창 select의 option을 반복 접근
			$("select[name=sk] > option").each(function(index, item) {
				// index : 현재 접근중인 요소의 인덱스
				// item : 현재 접근중인 요소
				// content            content
				if ($(item).val() == searchKey) {
					$(item).prop("selected", true);
					
						if($(item).val()=="category"){
							$("#formCategory").attr("style","");
							
							$("#formCategory > option").each(function(index,item){
								if($(item).val()==searchCategory){
									$(item).prop("selected",true);
								}
							});
						}
				}
			});

			// 검색어 입력창에 searcValue 값 출력
			$("input[name=sv]").val(searchValue);
		})();
		
		$(document).ready(function(){
			
			$("#formKey").on("change", function(){
				var element = $("#formKey option:selected").val();
				if(element == "category"){
					$("#formCategory").attr("style", "");
				} else {
					$("#formCategory").attr("style", "display:none;");
				}
			});
			
		});
		
	</script>

</body>
</html>
