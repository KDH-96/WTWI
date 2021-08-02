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
        a{
            color: black;
            text-decoration: none;
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
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-three-dots" viewBox="0 0 16 16">
                        <path d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/></svg>
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
               		<c:when test="${createDate!=today}"><span class="col-2 divide">작성 ${createDate}</span></c:when>
               		<c:otherwise><span class="col-2 divide">작성 <fmt:formatDate value="${board.freeCreateDate}" pattern="HH:mm"/></span></c:otherwise>
               	</c:choose>
                <c:choose>
                	<c:when test="${createDate!=modifyDate}">
		               	<c:choose>
		               		<c:when test="${modifyDate!=today}"><span class="col-2 divide">수정 ${modifyDate}</span></c:when>
		               		<c:otherwise><span class="col-2 divide">수정 <fmt:formatDate value="${board.freeModifyDate}" pattern="HH:mm"/></span></c:otherwise>
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
                        <i><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                        <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/></svg></i>
                    </a>
                    <span class="mr-4">${board.likeCount}</span>
                    <a class="mr-2" href="#">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat" viewBox="0 0 16 16">
                        <path d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z"/></svg>
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
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-three-dots" viewBox="0 0 16 16">
                        <path d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/></svg>
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