<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" scope="application"
	   value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/FortAwesome/Font-Awesome@5.14.0/css/all.min.css"> 
<style>
	.content {		
       	virtical-align: middle;
       	overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
       }
       .myPage-pagination {
		display: flex;
		justify-content: center;
		align-items: center;
		list-style: none;
		width: 100%;
		padding: 0px;
	}
	
	.myPage-pagination a {
		border: 1px solid rgba(0, 0, 0, 0.3);
		padding: 5px 13px;
		margin: 0px 2px;
		border-radius: 5px;
	}
	.search-container {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.sv {
	 	width: 100%;
	}
</style>
      <div id="contentArea">
			<jsp:include page="boardSelect.jsp"></jsp:include>
         
            <!-- 위 select-option에 따라서 보여지는 테이블이 다름 -->
            <%-- 검색 상태 유지를 위한 쿼리스트링용 변수 --%>
            <c:if test="${!empty param.sv }">
				<c:set var="searchValue" value="&sv=${param.sv} "/>
				<c:set var="searchStr" value="&sc=${param.sc}&sk=${param.sk}${searchValue }"  />
			</c:if>

            
         <!-- 리뷰 테이블 -->
         <table class="table">
        	<colgroup>
									 <col width="5%"/>
                   <col width="5%"/>
                   <col width="35%"/>
                   <col width="6%"/>
                   <col width="10%"/>
                   <col width="5%"/>
                   <col width="10%"/>
			</colgroup>
            <thead class="thead-dark">
               <tr>
                  <th scope="col">번호</th>
                  <th scope="col">명소id</th>
                  <th scope="col">리뷰내용</th>
                  <th scope="col">작성자</th>
                  <th scope="col">작성일</th>
                  <th scope="col">별점</th>                  
                  <th scope="col">상태</th>
               </tr>
            </thead>
            <tbody>
	            <c:choose>
					<c:when test="${empty reviewBoardList }">

						<!-- 작성한 게시글이 없을 때 -->
						<tr>
							<td colspan="6">리뷰가 없습니다.</td>
						</tr>

					</c:when>
					<c:otherwise>

						 <c:forEach items="${reviewBoardList}" var="review" varStatus="b">
			               <tr>
			                  <th scope="row">${review.reviewNo} </th>
			                  <th scope="row">${review.attractionNo} </th>
			                  <th scope="row">${review.reviewContent} </th>
			                  <th scope="row">${review.memberNo} </th>
			                  <th scope="row">${review.reviewCreateDt} </th>
			                  <th scope="row">${review.reviewPoint} ${review.reviewStatus}</th>
			                  <td>
			                  	<form action="changeReviewStatus" method="POST" id="status">
				                  <select name="reviewStatus">
				                  	<c:choose>
				                  	  <c:when test="${review.reviewStatus=='Y'}">
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
				                  <input type="hidden" name="reviewNo" value="${review.reviewNo}">
			                  	  <button type="submit">변경</button>
			                  	</form>
			                  </td>
			               </tr>
	               		</c:forEach>
	
					</c:otherwise>
	
				</c:choose>

            </tbody>
         </table>
      </div>
         <!----------------------------------------------------------------------------------------------  content end -->

			<%---------------------- Pagination start----------------------%>
			<%-- 페이징 처리 시 주소를 쉽게 작성할 수 있도록 필요한 변수를 미리 선언 --%>
			
			<c:set var="pageURL" value="list"  />
			
			<c:set var="prev" value="${pageURL}?cp=${pagination.prevPage}${searchStr}" />
			<c:set var="next" value="${pageURL}?cp=${pagination.nextPage}${searchStr}" />
			
			
			<div class="my-5">
				<ul class="pagination">
				
					<%-- 현재 페이지가 10페이지 초과인 경우 --%>
					<c:if test="${pagination.currentPage > pagination.pageSize }">
						<li><a class="page-link" href="${prev}">&lt;&lt;</a></li>
					</c:if>
					
					<%-- 현재 페이지가 2페이지 초과인 경우 --%>
					<c:if test="${pagination.currentPage > 2 }">
						<li><a class="page-link" href="${pageURL}?cp=${pagination.currentPage - 1}${searchStr}">&lt;</a></li>
					</c:if>
					
					
				
					<%-- 페이지 목록 --%>
					<c:forEach var="p" begin="${pagination.startPage}" end="${pagination.endPage}">
						
							<c:choose>
								<c:when test="${p == pagination.currentPage }">
									<li class="page-item active"><a class="page-link">${p}</a></li>
								</c:when>
								
								<c:otherwise>
									<li><a class="page-link" href="${pageURL}?cp=${p}${searchStr}">${p}</a></li>
								</c:otherwise>
							</c:choose>						
					</c:forEach>
					
					<%-- 현재 페이지가 마지막 페이지 미만인 경우 --%>
					<c:if test="${pagination.currentPage < pagination.maxPage }">
						<li><a class="page-link" href="${pageURL}?cp=${pagination.currentPage + 1}${searchStr}">&gt;</a></li>
					</c:if>
					
					<%-- 현재 페이지가 마지막 페이지가 아닌 경우 --%>
					<c:if test="${pagination.currentPage - pagination.maxPage + pagination.pageSize < 0}">
						<li><a class="page-link" href="${next}">&gt;&gt;</a></li>
					</c:if>

				</ul>
			</div>
			<%---------------------- Pagination end----------------------%>


         <!-- 검색창 -->
         <div class="my-2">
            <form action="list" method="GET" class="text-center" id="searchForm">
               <div class="container2">
                  <div class="search-container">
                     <div>
                      <select name="sk" class="form-control" style="width: 200px; display: inline-block; ">
                        <option value="title">명소이름</option>
                        <option value="content">리뷰내용</option>
                     </select>

                     </div>
                     <div>
                        <input type="text" name="sv" class="form-control sv" style="width: 92%; display: inline-block;">
                     </div>
                     <div>
                        <button class="form-control btn btn-primary"
                        style="width:100px; display: inline-block; background-color: black; border: black;">검색</button>
                     </div>
                  </div>
               </div>
            </form>
         </div>
     


   <!-- ===============================영역구분선=============================== -->
   <%-- <jsp:include page="../common/footer.jsp" /> --%>


   <script>
		// 검색 내용이 있을 경우 검색창에 해당 내용을 작성해두는 기능
		(function(){
			var searchKey = "${param.sk}"; 
			var searchValue = "${param.sv}";
				
			
			$("select[name=sk] > option").each(function(index, item){
				// index : 현재 접근중인 요소의 인덱스
				// item : 현재 접근중인 요소
							// content            content
				if( $(item).val() == searchKey  ){
					$(item).prop("selected", true);
				}
			});		
			
			// 검색어 입력창에 searcValue 값 출력
			$("input[name=sv]").val(searchValue);
			
		})();
		
		function validate(){
			
			const sv = $("#sv").val().trim();
			if(sv == ""){
				swal("검색 실패", "검색 내용을 입력해주세요.", "error");
				return false;
			}
		}
			
	</script>
