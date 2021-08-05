<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판</title>
    <style>
        .free-view{
            width: 1200px;
            border-top: 1px solid rgb(222, 226, 230);
        }
        .free-category, .free-info2>span{
            font-size: 14px;
        }
        .free-menu{
            text-align: end;
        }
        .divide{
            border-left: 1px solid rgb(222, 226, 230);
        }
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
    <div class="container">
        <h3 class="my-4 font-weight-bold">자유게시판</h3>
        <div class="free-view">
            <div class="row mt-2 mb-2 col-12">
                <div class="badge badge-dark free-category col-1">${board.freeCategoryName}</div>
                <div class="col-10">${board.freeTitle}</div>
                <div class="free-menu col-1">
                	<c:if test="${!empty loginMember }">
	                    <a class="dropdown-toggle" type="button" id="dropdownMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                    	<i class="bi bi-three-dots"></i>
	                    </a>
                    </c:if>
					<div class="dropdown-menu" aria-labelledby="dropdownMenu">
						<c:choose>
							<c:when test="${board.memberNo == loginMember.memberNo }">
								<button class="dropdown-item" type="button" onclick="fnRequest('updateForm');">수정</button>
								<button class="dropdown-item" type="button" onclick="deleteAlert();">삭제</button>
							</c:when>
							<c:otherwise>
								<button class="dropdown-item" type="button">신고</button>
							</c:otherwise>
						</c:choose>
					</div>
                </div>
            </div>
            <div class="row mb-4 col-12 free-info2">
                <span class="col-2"><i class="bi bi-person-circle"> </i> ${board.memberNick}</span>
                <span class="col-2 divide"><i class="bi bi-eye"> </i> ${board.freeReadCount}</span>
               	<fmt:formatDate var="createDate" value="${board.freeCreateDate}" pattern="yyyy-MM-dd"/>
               	<fmt:formatDate var="modifyDate" value="${board.freeModifyDate}" pattern="yyyy-MM-dd"/>
		        <fmt:formatDate var="today" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>
               	<c:choose>
               		<c:when test="${createDate!=today}"><span class="col-2 divide">작성일  ${createDate}</span></c:when>
               		<c:otherwise><span class="col-2 divide">작성일  <fmt:formatDate value="${board.freeCreateDate}" pattern="HH:mm"/></span></c:otherwise>
               	</c:choose>
                <c:choose>
                	<c:when test="${createDate!=modifyDate}">
		               	<c:choose>
		               		<c:when test="${modifyDate!=today}"><span class="col-2 divide">수정일  ${modifyDate}</span></c:when>
		               		<c:otherwise><span class="col-2 divide">수정일  <fmt:formatDate value="${board.freeModifyDate}" pattern="HH:mm"/></span></c:otherwise>
		               	</c:choose>
                	</c:when>
                	<c:otherwise>
                		<span class="col-2 divide">수정일  -</span>
                	</c:otherwise>
                </c:choose>
            </div>
            <div class="row mb-2 col-12 free-content">
                <p class="w-100">${board.freeContent}</p>
            </div>
            <div class="col-md-4">
                <div class="row mb-2 col-12">
                    <a class="mr-2" href="#">
                    	<i class="bi bi-heart"></i>
                    </a>
                    <span class="mr-4">${board.likeCount}</span>
                    <a class="mr-2" href="#">
                    	<i class="bi bi-chat"></i>
                    </a>
                    <span>${board.replyCount}</span>
                </div>
            </div>
        </div>
		<jsp:include page="../freeboard/reply.jsp" />
        <button class="btn btn-outline-secondary mt-2" onclick="">이전 목록</button>
    </div>
<!-- footer include -->
<form action="#" method="POST" name="requestForm">
	<input type="hidden" name="freeNo" value="${board.freeNo}">
	<input type="hidden" name="cp" value="${param.cp}">
</form>
<script>
function fnRequest(addr){
	document.requestForm.action = addr;
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