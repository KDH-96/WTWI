<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<title>신고</title>
<style>
.report-body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.report-main {
	width: 50%;
}

.report-container {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.report-title {
	margin-bottom: 20px;
}

.report-pageArea {
	margin-bottom: 20px;
}

.report-form {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 60%;
	margin-top: 20px;
}

.report-input {
	display: flex;
	justify-content: center;
	width: 100%;
}

.report-input label {
	width: 100px;
}

.report-btnArea {
	display: flex;
	flex-direction: column;
	margin-top: 20px;
}

.report-btnArea {
	width: 60%;
}

.report-btnArea button:first-child {
	margin-bottom: 10px;
}
</style>
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<body class="report-body">

	<main class="report-main">

		<div class="report-container">

			<div class="report-title">
				<h2>신고</h2>
			</div>
			<form action="${contextPath }/reportBoard/reportAction" method="POST" onsubmit="return validate();">
				<div>
					<input type="radio" name="reportCategoryNo" value="1" autocomplete="off" checked> 
					<label for="4">도배글</label>
				</div>
				<div>
					<input type="radio" name="reportCategoryNo" value="2" autocomplete="off"> 
					<label for="5">광고/홍보</label>
				</div>
				<div>
					<input type="radio" name="reportCategoryNo" value="3" autocomplete="off"> 
					<label for="6">저작권법위반</label>
				</div>
				<div>
					<input type="radio" name="reportCategoryNo" value="4" autocomplete="off"> 
					<label for="7">성희롱/욕설/비방</label>
				</div>

				<div class="form-group">
					<label for="reportTitle">신고제목</label> <input type="text"
						class="form-control" id="reportTitle" name="reportTitle">
				</div>
				<div class="form-group">
					<label for="reportContent">신고내용</label> <input type="text"
						class="form-control" id="reportContent" name="reportContent">
				</div>
				<div class="report-btnArea">
					<button type="submit" class="btn btn-primary" id="report">신고
						제출</button>
					<a type="button" class="btn btn-primary" href="${contextPath}">취소</a>
				</div>
				<input type="hidden" name="reportType" value="${type }">
				<input type="hidden" name="reportTypeNo" value="${freeNo }">
			</form>

		</div>

	</main>


</body>

<script>
function validate() {

	const title = $("#reportTitle").val().trim();
	const content = $("#reportContent").val().trim();
	
	if (title == "" || content == "") {
		swal("신고 실패", "신고 작성폼 입력을 완료해주세요.", "error");
		return false;
	}
}

</script>
</html>