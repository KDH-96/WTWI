<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 배포된 웹 애플리케이션의 최상위 주소를 간단히 얻어올 수 있도록 
     application 범위로 변수를 하나 생성 --%>
<c:set var="contextPath" scope="application"
	value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>1:1 문의내역</title>
<style>
a {
	text-decoration: none;
	color: inherit;
}

a:hover {
	text-decoration: none;
	color: inherit;
	font-weight: bold;
}

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

.myPage-main h2 {
	margin-bottom: 30px;
}

.myPage-main>div {
	width: 90%;
}

.myPage-postBtnArea {
	margin-bottom: 20px;
}

.myPage-main table {
	text-align: center;
}

.myPage-sideBar {
	display: flex;
	flex-direction: column;
}

.myPage-pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	list-style: none;
	width: 100%;
	padding: 0px;
}

.myPage-pagination a {
	border: 1px solid rgba(0, 0, 0, 0.3);
	padding: 5px 13px;
	margin: 0px 2px;
	border-radius: 5px;
}

.focus-page {
	font-weight: bold;
}
</style>
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/myPage/sideBar.jsp"></jsp:include>

<body class="myPage-body">

	<%-- 검색 상태 유지를 위한 쿼리스트링용 변수 선언 --%>
	<c:if test="${!empty param.sv }">
		<c:set var="searchStr" value="&sv=${param.sv}"  />
	</c:if>

	<main class="myPage-main">
		<h2>1:1 문의내역</h2>

		<div>
			<table class="table">
				<colgroup>
					<col width="5%"/>
                    <col width="30%"/>
                    <col width="50%"/>
                    <col width="15%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col"></th>
						<th scope="col">담당자</th>
						<th scope="col">내용</th>
						<th scope="col">일시</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty chatList }">

							<!-- 작성한 게시글이 없을 때 -->
							<tr>
								<td colspan="6">문의 내역이 없습니다.</td>
							</tr>

						</c:when>
						<c:otherwise>

							<c:forEach items="${chatList }" var="board" varStatus="b">

								<tr>
									<!-- 글번호 -->
									<th scope="row">0</th>

									<%-- 담당자 --%>
									<td>${board.attractionNm}</td>

									<!-- 내용 -->
									<td class="boardTitle">
									<a href="${contextPath}/?cp=${pagination.currentPage}">${board.chatContent}</a>
									</td>
									<%-- 작성일자 --%>
									<td><fmt:formatDate var="createDate"
											value="${board.chatCreateDt}" pattern="yyyy-MM-dd" /> <fmt:formatDate
											var="today" value="<%=new java.util.Date()%>"
											pattern="yyyy-MM-dd" /> <c:choose>
											<%-- 글 작성일이 오늘이 아닐 경우 --%>
											<c:when test="${createDate != today}">
												${createDate}
											</c:when>

											<%-- 글 작성일이 오늘일 경우 --%>
											<c:otherwise>
												<fmt:formatDate value="${board.chatCreateDt}"
													pattern="HH:mm" />
											</c:otherwise>
										</c:choose></td>

								</tr>

							</c:forEach>

						</c:otherwise>

					</c:choose>


				</tbody>
			</table>


			<!---------------------- Pagination start---------------------->
			<!-- 페이징 처리 시 주소를 쉽게 작성할 수 있도록 필요한 변수를 미리 선언 -->


			<c:set var="pageURL" value="chat"></c:set>
	

			<c:set var="prev" value="${pageURL}?cp=${pagination.prevPage }${searchStr}"></c:set>
			<!-- 다음페이지 시작주소 -->
			<c:set var="next" value="${pageURL}?cp=${pagination.nextPage }${searchStr}"></c:set>

			<div class="my-5">
				<ul class="myPage-pagination">

					<!-- 현재 페이지가 페이지사이즈 초과인 경우 -->
					<c:if test="${pagination.currentPage > pagination.pageSize }">
						<li><a href="${prev }"><i
								class="fas fa-caret-square-left"></i></a></li>
					</c:if>

					<!-- 현재 페이지가 10페이지 초과인 경우 -->
					<c:if test="${pagination.currentPage > pagination.pageSize }">
						<li><a href="${pageURL}?cp=${pagination.currentPage-1}"><i
								class="fas fa-caret-left"></i></a></li>
					</c:if>



					<!-- 페이지 목록 -->
					<c:forEach var="p" begin="${pagination.startPage}"
						end="${pagination.endPage}">

						<c:choose>
							<c:when test="${p == pagination.currentPage }">
								<li><a class="focus-page">${p }</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageURL}?cp=${p}${searchStr}"">${p}</a></li>
							</c:otherwise>
						</c:choose>

					</c:forEach>






					<!-- 현재 페이지가 마지막 페이지 미만인 경우 -->
					<c:if test="${pagination.currentPage < pagination.maxPage }">
						<li><a href="${pageURL}?cp=${pagination.currentPage+1}${searchStr}""><i
								class="fas fa-caret-right"></i></a></li>
					</c:if>

					<!-- 현재 페이지가 마지막 페이지 미만인 경우 -->
					<c:if
						test="${pagination.currentPage - pagination.maxPage + pagination.pageSize < 0 }">
						<li><a href="${next}"><i
								class="fas fa-caret-square-right"></i></a></li>
					</c:if>

				</ul>
			</div>
			<!---------------------- Pagination end---------------------->
		</div>
		<!-- 검색창 -->
		<div class="my-5">
			<form action="chat" method="GET" class="text-center" id="searchForm" onsubmit="return validate();">
				<span>명소 이름</span>
				<input type="text" id="sv" name="sv" class="form-control" style="width: 25%; display: inline-block;">
				<button class="form-control btn btn-primary" style="width: 100px; display: inline-block;">검색</button>
			</form>
		</div>

	</main>
	<script>
		// 검색 내용이 있을 경우 검색창에 해당 내용을 작성해두는 기능
		(function(){
			var searchValue = "${param.sv}";
			
			// 검색어 입력창에 searcValue 값 출력
			$("input[name=sv]").val(searchValue);
			
			
		})();
		
		function validate(){
			
			const sv = $("#sv").val().trim();
			if(sv == ""){
				swal("검색 실패", "검색 내용를 입력해주세요.", "error");
				return false;
			}
		}
			
	</script>
</body>
</html>