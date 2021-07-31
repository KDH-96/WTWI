<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
    <style>
        .free-board-list{
            width: 1200px;
            font-size: 14px;
            border-bottom: 1px solid rgb(222, 226, 230);
        }
        th, td{
            text-align: center;
        }
        .fb-title{
            text-align: left;
        }
        .fb-no, .fb-count{
            width: 8%;
        }
        .fb-like{
            width: 10%;
        }
        .fb-category, .fb-author, .fb-date{
            width: 12%;
        }
        .input-value{
            width: 50px;
        }
        a{
            color: black;
            text-decoration: none;
        }
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
    <div class="container">
        <h3 class="my-4 font-weight-bold">자유게시판</h3>
        <table class="table table-hover free-board-list">
            <thead>
            <tr>
                <th scope="col" class="fb-no">글번호</th>
                <th scope="col" class="fb-category">말머리</th>
                <th scope="col">제목</th>
                <th scope="col" class="fb-author">작성자</th>
                <th scope="col" class="fb-date">작성일자
                    <span>
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
                            <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/></svg>
                        </a>
                    </span>
                </th>
                <th scope="col" class="fb-count">조회수</th>
                <th scope="col" class="fb-like">좋아요
                    <span>
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
                            <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/></svg>
                        </a>
                    </span>
                </th>
            </tr>
            </thead>
            <%-- 게시글 목록 --%>
            <tbody>
            <c:choose>
	            <c:when test="${empty boardList}">
	            	<tr>
	            		<td colspan="7">작성된 게시글이 없습니다.</td>
	            	</tr>
	            </c:when>
            	<c:otherwise>
            		<c:forEach items="${boardList}" var="b">
			            <tr>
			                <td>${b.freeNo}</td>
			                <td>${b.freeCategoryName}</td>
			                <td class="fb-title">
			                	<a href="${b.freeNo}?cp=${pagination.currentPage}">${b.freeTitle}</a>
			                	<c:if test="${b.replyCount!=0}">
			                		<span>[${b.replyCount}]</span>
			                	</c:if>
			                </td>
			                <td>${b.memberNick}</td>
			                <td>
			                	<fmt:formatDate var="createDate" value="${b.freeCreateDate}" pattern="yyyy-MM-dd"/>
			                	<fmt:formatDate var="today" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>
			                	<c:choose>
									<c:when test="${createDate!=today}">${createDate}</c:when>			                	
									<c:otherwise><fmt:formatDate value="${b.freeCreateDate}" pattern="HH:mm"/></c:otherwise>
			                	</c:choose>
			                </td>
			                <td>${b.freeReadCount}</td>
			                <td>${b.likeCount}</td>
			            </tr>
			    	</c:forEach>
	            </c:otherwise>
            </c:choose>
            </tbody>
        </table>
        <div class="row d-flex justify-content-end">
            <button type="button" class="btn btn-outline-secondary">글작성</button>
        </div>
        <%-- 페이지네이션 --%>
        <c:set var="pageURL" value="list"/>
		<c:set var="prev" value="${pageURL}?cp=${pagination.prevPage}"/>
		<c:set var="next" value="${pageURL}?cp=${pagination.nextPage}"/>
        <div class="row d-flex justify-content-center">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                	<%-- 현재 페이지가 5 페이지 이하일 시 --%>
                	<c:if test="${pagination.currentPage <= pagination.pageSize}">
                		<li class="page-item disabled">
                			<a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
                		</li>
                	</c:if>
                	<%-- 현재 페이지가 5 페이지 초과일 시 --%>
                	<c:if test="${pagination.currentPage > pagination.pageSize}">
                		<li class="page-item">
                			<a class="page-link" href="${prev}" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
                		</li>
                	</c:if>
                	<%-- 페이지 --%>
					<c:forEach var="p" begin="${pagination.startPage}" end="${pagination.endPage}">
						<c:choose>
							<c:when test="${p==pagination.currentPage}">
								<li class="page-item active"><a class="page-link">${p}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="${pageURL}?cp=${p}">${p}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<%-- 현재 페이지가 마지막 페이지 목록이 아닌 경우 --%>
					<c:if test="${pagination.endPage < pagination.maxPage}">
						<li class="page-item">
							<a class="page-link" href="${next}" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
						</li> 
					</c:if>
                </ul>
            </nav>
        </div>
        <div class="row d-flex justify-content-center">
            <form action="" method="">
                <div class="input-group mb-3">
                    <select class="form-control col-4">
                      <option value="" selected>검색 조건</option>
                      <option value="">카테고리</option>
                      <option value="">제목</option>
                      <option value="">제목+내용</option>
                      <option value="">작성자</option>
                    </select>
                    <input type="text" class="form-control col-6" placeholder="검색어를 입력하세요.">
                    <button class="btn btn-outline-secondary">검색</button>
                </div>
              </form>
        </div>
    </div>
</body>
</html>