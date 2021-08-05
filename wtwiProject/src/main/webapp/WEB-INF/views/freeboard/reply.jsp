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
        .free-reply{
            width: 1200px;
            border-bottom: 1px solid rgb(222, 226, 230);
        }
        .free-reply-date{
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="container">
	    <div class="free-reply mt-4">
		    <div class="row mb-2 col-12 free-reply-content">
		        <div class="col-1">
		            <div class="row-6">{닉네임}</div>
		            <div class="row-6 free-reply-date">{작성일}</div>
		        </div>
		        <div class="col-10">
		            <p>{댓글 내용}</p>
		        </div>
		        <div class="free-menu col-1">
                	<c:if test="${!empty loginMember }">
	                    <a href="#" class="btn dropdown-toggle" type="button" id="dropdownMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                    	<i class="bi bi-three-dots"></i>
	                    </a>
                    </c:if>
					<div class="dropdown-menu" aria-labelledby="dropdownMenu">
						<c:choose>
							<c:when test="${board.memberNo == loginMember.memberNo }">
								<button class="dropdown-item" type="button">수정</button>
								<button class="dropdown-item" type="button">삭제</button>
							</c:when>
							<c:otherwise>
								<button class="dropdown-item" type="button">신고</button>
							</c:otherwise>
						</c:choose>
					</div>
		        </div>
		    </div>
		    <div class="input-group mt-4 mb-2 col-12 free-new-reply">
		        <textarea class="form-control" rows="3"></textarea>
		        <button class="btn btn-outline-secondary" onclick="">작성</button>
		    </div>
	    </div>
    </div>
</body>
</html>