<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
      <div id="contentArea">
			<jsp:include page="boardSelect.jsp"></jsp:include>
         
            <!-- 위 select-option에 따라서 보여지는 테이블이 다름 -->

            <!-- 자유게시판 테이블 -->
          <table class="table">
            <thead class="thead-dark">
              <tr>
                  <th scope="col">글번호</th>
                  <th scope="col">말머리</th>
                  <th scope="col">제목</th>
                  <th scope="col">작성자</th>
                  <th scope="col">작성일</th>
                  <th scope="col">조회수</th>
                  <th scope="col">상태</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${boardList}" var="b">
              <tr>
                <th scope="row">${b.freeNo}</th>
                <td>${b.freeCategoryName}</td>
                <td><a id="linkA" href="#">${b.freeTitle}</a></td>
                <td>${b.memberNick}</td>
                <td><fmt:formatDate value="${b.freeCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>${b.freeReadCount}</td>
                <td>
                  <form action="changeFreeStatus" method="POST">
                  <select name="freeStatus">
                  	<c:choose>
                  	  <c:when test="${b.freeStatus=='Y'}">
	                    <option value="Y" selected>등록</option>
	                    <option value="N">삭제</option>
                  	  </c:when>
                  	  <c:otherwise>
	                    <option value="Y">등록</option>
	                    <option value="N" selected>삭제</option>
                  	  </c:otherwise>
                  	</c:choose>
                  </select>
                  <input type="hidden" name="freeNo" value="${b.freeNo}">
                  <button>변경</button>
                  </form>
                </td>
              </tr>
			</c:forEach>
            </tbody>
          </table>
      </div>
         <!----------------------------------------------------------------------------------------------  content end -->

         <!----------------------------------------------------------------------------------------------  Pagination start -->
         <!-- 페이징 처리 시 주소를 쉽게 작성할 수 있도록 필요한 변수를 미리 선언 -->
		<c:set var="pageURL" value="list"/>
		<c:set var="prev" value="${pageURL}?cp=${pagination.prevPage}${searchString}"/>
		<c:set var="next" value="${pageURL}?cp=${pagination.nextPage}${searchString}"/>
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
							<li class="page-item"><a class="page-link" style="color:black" href="${pageURL}?cp=${p}${searchString}">${p}</a></li>
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

         <!----------------------------------------------------------------------------------------------  Pagination end -->

         <!-- 검색창 -->
         <div class="my-2">
            <form action="#" method="GET" class="text-center" id="searchForm">
               <div class="container2">
                  <div class="row">
                     <div class="col-sm" >

                      <select name="sk" class="form-control" style="width: 200px; display: inline-block; ">
                        <option value="nick">닉네임으로 검색</option>
                        <option value="content">닉네임으로 검색</option>
                        <option value="writer">아이디로 검색</option>
                     </select>

                     </div>
                     <div class="col-sm">
                        <input type="text" name="sv" class="form-control" style="width: 50%; display: inline-block;">
                     </div>
                     <div class="col-sm">
                        <button class="form-control btn btn-primary"
                        style="width:100px; display: inline-block; background-color: black; border: black;">검색</button>
                     </div>
                  </div>
               </div>
            </form>
         </div>
      </div>


   <!-- ===============================영역구분선=============================== -->
   <%-- <jsp:include page="../common/footer.jsp" /> --%>


   <script>

   </script>
