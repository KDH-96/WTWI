<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .free-view{
        width: 1200px;
        border-top: 1px solid rgb(222, 226, 230);
        border-bottom: 1px solid rgb(222, 226, 230);
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
<jsp:include page="../common/header.jsp" />
    <div class="container">
        <h3 class="my-4 font-weight-bold">자유게시판</h3>
        <div class="free-view">
            <div class="row mt-2 mb-2 col-12">
                <div class="badge badge-dark free-category col-1">${board.freeCategoryName}</div>
                <div class="col-10">${board.freeTitle}</div>
                <div class="free-menu col-1">
                	<c:if test="${!empty loginMember}">
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
                    <a class="mr-2 btn btn-sm" id="likeBtn">
                    	<i class="bi bi-heart"></i>
                    </a>
                    <span class="mr-4" id="likeCount">${board.likeCount}</span>
                    <a class="mr-2 btn btn-sm" id="replyBtn">
                    	<i class="bi bi-chat"></i>
                    </a>
                    <span>${board.replyCount}</span>
                </div>
            </div>
		<jsp:include page="../freeboard/reply.jsp" />
        </div>
		<%-- 검색 상태 유지를 위한 쿼리스트링용 변수 --%>
        <c:if test="${!empty param.sk}">
        	<c:if test="${param.sk=='category' && !empty param.sc}">
        		<c:set var="searchCategory" value="&sc=${param.sc}"/>
        	</c:if>
        	<c:if test="${!empty param.sv && param.sv!=''}">
        		<c:set var="searchValue" value="&sv=${param.sv}"/>
        	</c:if>
        	<c:set var="searchString" value="&sk=${param.sk}${searchCategory}${searchValue}"/>
        </c:if>
        <button class="btn btn-outline-secondary mt-2" onclick="location.href='list?cp=${param.cp}${searchString}';">이전 목록</button>
    </div>
<!-- footer include -->
<form action="#" method="POST" name="requestForm">
	<input type="hidden" name="freeNo" value="${board.freeNo}">
	<input type="hidden" name="cp" value="${param.cp}">
</form>

<script src="${contextPath}/resources/js/freeboard/boardView.js"></script>

<script>
const freeNo = ${board.freeNo};
const memberNo = "${loginMember.memberNo}";

likeCheck();

//좋아요 여부 체크해서 표시하기
function likeCheck(){
	$.ajax({
		url : "likeCheck",
		data : {"freeNo": freeNo},
		type : "POST",
		
		success : function(flag){
			
			if(flag){
				$("#likeBtn").html("");
				var i = $("<i>").addClass("bi bi-heart-fill");
				$("#likeBtn").append(i);
			}
		},
		error : function(e){
			console.log(e);
		}
	});
}

// 좋아요 기능
$("#likeBtn").on("click", function(){
	
	if(memberNo==""){
		swal({
			icon : "warning",
			title : "회원만 이용 가능합니다."
		});
		return false;
		
	} else{
		$.ajax({
			url : "like",
			data : {"freeNo": freeNo},
			type : "POST",
			
			success : function(result){
				
				if(result==1){
					$("#likeBtn").html("");
					var i = $("<i>").addClass("bi bi-heart-fill");
					$("#likeBtn").append(i);
					
				} else if(result==0){
					$("#likeBtn").html("");
					var i = $("<i>").addClass("bi bi-heart");
					$("#likeBtn").append(i);
				} 
				likeCount();
			},
			error : function(e){
				console.log(e);
			}
		});
	}
});

function likeCount(){
	
	$.ajax({
		url : "likeCount",
		data : {"freeNo": freeNo},
		type : "POST",
		
		success : function(likeCount){
			$("#likeCount").text(likeCount);
		},
		error : function(e){
			console.log(e);
		}
	});
}
</script>