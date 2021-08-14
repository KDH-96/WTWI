<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
<style>
	.pagination{
		justify-content: center;
	}
</style>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container">
         <div class="h-div">
         	<h2><span id="listTitle">게시글 조회</span>
         	<span><button class="float-right" onclick="fnRequest('updateForm');">수정</button></span></h2>
         </div>
         <!-- 명소 상세 정보를 감싸는 div -->
         <div id="attractionArea">
            <table class="table">
               <thead class="thead-dark">
                 <tr>
                     <th scope="col">구분</th>
                     <th scope="col">내용</th>
                 </tr>
               </thead>
               <tbody>
                 <tr>
                   <th>글번호</th>
                   <td>${board.freeNo}</td>
                 </tr>
                 <tr>
                  <th>카테고리</th>
                  <td>${board.freeCategoryName}</td>
                </tr>
                <tr>
                  <th>제목</th>
                  <td>${board.freeTitle}</td>
                </tr>
                <tr>
                  <th>작성자(회원번호)</th>
                  <td>${board.memberNick}(${board.memberNo})</td>
                </tr>
               	<fmt:formatDate var="createDate" value="${board.freeCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
               	<fmt:formatDate var="modifyDate" value="${board.freeModifyDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
		        <fmt:formatDate var="today" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd HH:mm:ss"/>
                <tr>
                  <th>작성일</th>
                  <td>${createDate}</td>
                </tr>
                <tr>
                  <th>수정일</th>
                  <td>
                  	<c:if test="${modifyDate==today}">
                  		-
                  	</c:if>
                  	<c:if test="${modifyDate!=today}">
                  		${modifyDate}
                  	</c:if>
                  </td>
                </tr>
                <tr>
                  <th>좋아요 수</th>
                  <td>${board.likeCount}</td>
                </tr>
                <tr>
                  <th>댓글 수</th>
                  <td>${board.replyCount}</td>
                </tr>
                <tr>
                  <th>상태</th>
                  <td>
	                  <form action="changeFreeStatus" method="POST" id="changeFreeStatus">
	                  <select name="freeStatus">
	                  	<c:choose>
	                  	  <c:when test="${board.freeStatus=='Y'}">
		                    <option value="Y" selected>등록</option>
		                    <option value="N">삭제</option>
	                  	  </c:when>
	                  	  <c:otherwise>
		                    <option value="Y">등록</option>
		                    <option value="N" selected>삭제</option>
	                  	  </c:otherwise>
	                  	</c:choose>
	                  </select>
	                  <input type="hidden" name="bo" value="${param.bo}">
	                  <input type="hidden" name="view" value="view">
	                  <input type="hidden" name="freeNo" value="${board.freeNo}">
	                  <button>변경</button>
	                  </form>
                  </td>
                </tr>
               </tbody>
             </table>
         </div>
         <div>
            <p class="w-100">${board.freeContent}</p>
         </div>

         <div class="h-div"><h2><span id="listTitle">댓글 조회</span></h2></div>
         <div class="list-wrapper">
          <table class="table">
            <thead class="thead-dark">
              <tr>
                  <th scope="col">댓글번호</th>
                  <th scope="col">작성자(회원번호)</th>
                  <th scope="col">내용</th>
                  <th scope="col">작성일</th>
                  <th scope="col">상위댓글번호</th>
                  <th scope="col">상태</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${replyList}">
              <tr>
                <td>${r.freeReplyNo}</td>
                <td>${r.memberNick}(${r.memberNo})</td>
                <td>${r.freeReplyContent}</td>
                <fmt:formatDate var="replyCreateDate" value="${r.freeReplyCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                <td>${replyCreateDate}</td>
                <td>${r.parentReplyNo}</td>
                <td>
                  <form action="changeFreeReplyStatus" method="POST" id="changeFreeReplyStatus">
                  <select name="freeReplyStatus">
	                <c:choose>
	                  <c:when test="${r.freeReplyStatus=='Y'}">
		                  <option value="Y" selected>등록</option>
		                  <option value="N">삭제</option>
		                  <option value="M">수정</option>
	                  </c:when>
	                  <c:when test="${r.freeReplyStatus=='N'}">
		                  <option value="Y">등록</option>
		                  <option value="N" selected>삭제</option>
		                  <option value="M">수정</option>
	                  </c:when>
	                  <c:otherwise>
		                  <option value="Y">등록</option>
		                  <option value="N">삭제</option>
		                  <option value="M" selected>수정</option>
	                  </c:otherwise>
	                </c:choose>
                  </select>
                  <input type="hidden" name="bo" value="${param.bo}">
                  <input type="hidden" name="freeNo" value="${board.freeNo}">
                  <input type="hidden" name="freeReplyNo" value="${r.freeReplyNo}">
                  <button>변경</button>
                  </form>
                </td>
              </tr>
			</c:forEach>
            </tbody>
          </table>
            
         </div>
         <!----------------------------------------------------------------------------------------------  content end -->
         
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

         <!----------------------------------------------------------------------------------------------  Pagination start -->
         <!-- 페이징 처리 시 주소를 쉽게 작성할 수 있도록 필요한 변수를 미리 선언 -->
		<c:set var="pageURL" value="${board.freeNo}"/>
		<c:set var="prev" value="${pageURL}?cp=${pagination.prevPage}${searchString}&bo=${param.bo}"/>
		<c:set var="next" value="${pageURL}?cp=${pagination.nextPage}${searchString}&bo=${param.bo}"/>
         <div class="my-2">
          <nav aria-label="Page navigation">
            <ul class="pagination">
            	<c:if test="${pagination.currentPage <= pagination.pageSize}">
            		<li class="page-item disabled">
            			<a class="page-link" href="#" aria-label="Previous" ><span aria-hidden="true" style="color:black">&laquo;</span></a>
            		</li>
            	</c:if>
               	<c:if test="${pagination.currentPage > pagination.pageSize}">
               		<li class="page-item">
               			<a class="page-link" href="${prev}" aria-label="Previous"><span aria-hidden="true" style="color:black">&laquo;</span></a>
               		</li>
               	</c:if>
				<c:forEach var="p" begin="${pagination.startPage}" end="${pagination.endPage}">
					<c:choose>
						<c:when test="${p==pagination.currentPage}">
							<li class="page-item active"><a class="page-link" style="color:black">${p}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" style="color:black" href="${pageURL}?cp=${p}${searchString}&bo=${param.bo}">${p}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${pagination.endPage < pagination.maxPage}">
					<li class="page-item">
						<a class="page-link" href="${next}" aria-label="Next"><span aria-hidden="true" style="color:black">&raquo;</span></a>
					</li> 
				</c:if>
            </ul>
          </nav>
         </div>
         <c:if test="${!empty param.bo}">
	         <a href="list?cp=${param.cp}${searchString}&bo=${param.bo}" type="button" class="btn btn-primary ml-1" style="background-color: black; border: black;">뒤로가기</a>
         </c:if>
         <c:if test="${empty param.bo}">
	         <a href="list?bo=freeboard" type="button" class="btn btn-primary ml-1" style="background-color: black; border: black;">뒤로가기</a>
         </c:if>
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


</script>