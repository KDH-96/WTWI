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
                <th scope="col" class="fb-category">카테고리</th>
                <th scope="col">제목</th>
                <th scope="col" class="fb-author">작성자</th>
                <th scope="col" class="fb-date">작성일자
                    <span><a href="#"><i class="bi bi-caret-down-fill"></i></a></span>
                </th>
                <th scope="col" class="fb-count">조회수</th>
                <th scope="col" class="fb-like">좋아요
                    <span><a href="#"><i class="bi bi-caret-down-fill"></i></a></span>
                </th>
            </tr>
            </thead>
            
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
            
            <%-- 게시글 목록 --%>
            <tbody>
            <c:choose>
	            <c:when test="${empty boardList}">
	            	<tr><td colspan="7">작성된 게시글이 없습니다.</td></tr>
	            </c:when>
            	<c:otherwise>
            		<c:forEach items="${boardList}" var="b">
			            <tr>
			                <td>${b.freeNo}</td>
			                <td>${b.freeCategoryName}</td>
			                <td class="fb-title">
			                	<a href="${b.freeNo}?cp=${pagination.currentPage}${searchString}">${b.freeTitle}</a>
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
        	<c:if test="${!empty loginMember}">
            	<a class="btn btn-outline-secondary" href="${contextPath}/freeboard/insertForm">글작성</a>
            </c:if>
        </div>
        <%-- 페이지네이션 --%>
        <c:set var="pageURL" value="list"/>
		<c:set var="prev" value="${pageURL}?cp=${pagination.prevPage}${searchString}"/>
		<c:set var="next" value="${pageURL}?cp=${pagination.nextPage}${searchString}"/>
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
								<li class="page-item"><a class="page-link" href="${pageURL}?cp=${p}${searchString}">${p}</a></li>
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
        <!-- 검색 -->
        <div class="row d-flex justify-content-center">
            <form action="list" method="GET" id="searchForm">
                <div class="input-group mb-3">
                    <select class="form-control col-4" id="formKey" name="sk">
                    	<option value="ticontent">제목+내용</option>
                    	<option value="title">제목</option>
                    	<option value="content">내용</option>
                    	<option value="author">작성자</option>
                    	<option value="category">카테고리</option>
                    </select>
                   	<select class="form-control col-2 ml-1" id="formCategory" name="sc" style="display:none;">
                   		<option value="1">잡담</option>
                   		<option value="2">추천</option>
                   		<option value="3">궁금</option>
                   		<option value="4">같이</option>
                   		<option value="5">기타</option>
                   	</select>
                    <input type="text" class="form-control col-6 ml-1" placeholder="검색어를 입력하세요." id="formValue" name="sv">
                    <button class="btn btn-outline-secondary">검색</button>
                </div>
              </form>
        </div>
    </div>
<!-- footer include -->
<script>
keepSearch();

// 검색 내용 유지
function keepSearch(){
	var searchKey = "${param.sk}";
	var searchVal = "${param.sv}";
	var searchCat = "${param.sc}";
	
	// 검색 조건(key)
	$("select[name=sk] > option").each(function(index, item){
		if($(item).val()==searchKey){
		   $(item).prop("selected", true)
		   
			if($(item).val()=="category"){
				$("#formCategory").attr("style", "");
				$("#formCategory > option").each(function(intex, item){
					if($(item).val()==searchCat){
					   $(item).prop("selected", true);
					}
				});
			}
		}
	});
	
	// 검색 내용(value)
	$("input[name=sv]").val(searchVal);
}

$(document).ready(function(){
	
	// sk 카테고리 선택 시 카테고리 선택 메뉴 생성
	$("#formKey").on("change", function(){
		var element = $("#formKey option:selected").val();
		if(element == "category"){
			$("#formCategory").attr("style", "");
		} else {
			$("#formCategory").attr("style", "display:none;");
		}
	});
	
	$("#searchForm").on("submit", function(){
		if($("#formValue").val().trim().length==0){
			if($("#formKey").val()!="category"){
				swal({
					icon: "warning",
					title: "검색어를 입력해주세요."
				});
				return false;
			} else{
				$("#formValue").attr("name", "");
			}
		}
	})
});
</script>
</body>
</html>