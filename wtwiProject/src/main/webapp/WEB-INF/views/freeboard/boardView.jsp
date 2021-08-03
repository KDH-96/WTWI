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
<jsp:include page="../common/header.jsp" />
    <div class="container">
        <h3 class="my-4 font-weight-bold">자유게시판</h3>
        <div class="free-view">
            <div class="row mt-2 mb-2 col-12">
                <div class="badge badge-dark free-category col-1">${board.freeCategoryName}</div>
                <div class="col-10">${board.freeTitle}</div>
                <div class="free-menu col-1">
                    <a href="#">
                    	<i class="bi bi-three-dots"></i>
                    </a>
                </div>
            </div>
            <div class="row mb-4 col-12 free-info2">
                <span class="col-2">작성자 ${board.memberNick}</span>
                <span class="col-2 divide">조회수 ${board.freeReadCount}</span>
               	<fmt:formatDate var="createDate" value="${board.freeCreateDate}" pattern="yyyy-MM-dd"/>
               	<fmt:formatDate var="modifyDate" value="${board.freeModifyDate}" pattern="yyyy-MM-dd"/>
		        <fmt:formatDate var="today" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>
               	<c:choose>
               		<c:when test="${createDate!=today}"><span class="col-2 divide">작성일 ${createDate}</span></c:when>
               		<c:otherwise><span class="col-2 divide">작성일 <fmt:formatDate value="${board.freeCreateDate}" pattern="HH:mm"/></span></c:otherwise>
               	</c:choose>
                <c:choose>
                	<c:when test="${createDate!=modifyDate}">
		               	<c:choose>
		               		<c:when test="${modifyDate!=today}"><span class="col-2 divide">수정일 ${modifyDate}</span></c:when>
		               		<c:otherwise><span class="col-2 divide">수정일 <fmt:formatDate value="${board.freeModifyDate}" pattern="HH:mm"/></span></c:otherwise>
		               	</c:choose>
                	</c:when>
                	<c:otherwise>
                		<span class="col-2 divide">수정일 -</span>
                	</c:otherwise>
                </c:choose>
            </div>
            <div class="col-md-4">
                <div class="row mb-2 col-12 free-content">
                    <p>${board.freeContent}</p>
                </div>
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
                    <a href="#">
                    	<i class="bi bi-three-dots"></i>
                    </a>
                </div>
            </div>
            <div class="input-group mt-4 mb-2 col-12 free-new-reply">
                <textarea class="form-control" rows="3"></textarea>
                <button class="btn btn-outline-secondary" onclick="">작성</button>
            </div>
        </div>
        <button class="btn btn-outline-secondary mt-2" onclick="">이전 목록</button>
    </div>
</body>
</html>