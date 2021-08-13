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

            

         <!-- 신고 테이블 -->
         <table class="table">
        	<colgroup>
				<col width="5%"/>
                   <col width="5%"/>
                   <col width="8%"/>
                   <col width="13%"/>
                   <col width="20%"/>
                   <col width="15%"/>
                   <col width="20%"/>
                   <col width="15%"/>
			</colgroup>
            <thead class="thead-dark">
               <tr>
                  <th scope="col">번호</th>
                  <th scope="col">확인</th>
                  <th scope="col">신고유형</th>
                  <th scope="col">신고카테고리</th>
                  <th scope="col">신고제목</th>
                  <th scope="col">신고내용</th>                  
                  <th scope="col">신고처리</th>
               </tr>
            </thead>
            <tbody>
	            <c:choose>
					<c:when test="${empty reportBoardList }">

						<!-- 작성한 게시글이 없을 때 -->
						<tr>
							<td colspan="6">신고 내역이 없습니다.</td>
						</tr>

					</c:when>
					<c:otherwise>

						 <c:forEach items="${reportBoardList }" var="board" varStatus="b">
			               <tr>
			                  <th scope="row">${board.reportNo} </th>
			                  <td><a id="linkA" href="${contextPath }/freeboard/${board.reportTypeNo }"><i class="far fa-file-alt"></i></a></td>
			                  <td>
			                  	<c:choose>
			                  		<c:when test="${board.reportType == 1 }">게시글</c:when>
			                  		<c:otherwise>댓글</c:otherwise>
			                  	</c:choose>
			                  </td>
			                  <td>${board.reportCategoryNm }</td>
			                  <td class="content">${board.reportTitle }</td>
			                  <td class="content">${board.reportContent }</td>
			                  <td>
			                  	<form action="changeReportStatus" method="POST" id="status">
				                  <select name="reportStatus">
				                  	<c:choose>
				                  	  <c:when test="${board.reportStatus=='Y'}">
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
				                  <input type="hidden" name="reportNo" value="${board.reportNo}">
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

         <!----------------------------------------------------------------------------------------------  Pagination start -->
         <!-- 페이징 처리 시 주소를 쉽게 작성할 수 있도록 필요한 변수를 미리 선언 -->

         
			<c:set var="pageURL" value="list"></c:set>
			<c:set var="prev" value="${pageURL}?cp=${pagination.prevPage }${searchStr}"></c:set>
			<!-- 다음페이지 시작주소 -->
			<c:set var="next" value="${pageURL}?cp=${pagination.nextPage }${searchStr}"></c:set>

			<div class="my-5">
				<ul class="myPage-pagination">

					<!-- 현재 페이지가 페이지사이즈 초과인 경우 -->
					<c:if test="${pagination.currentPage > pagination.pageSize }">
						<li><a href="${prev }"><i
								class="fas fa-caret-square-left"></i></a></li>
					</c:if>

					<!-- 현재 페이지가 10페이지 초과인 경우 -->
					<c:if test="${pagination.currentPage > pagination.pageSize }">
						<li><a href="${pageURL}?cp=${pagination.currentPage-1}"><i
								class="fas fa-caret-left"></i></a></li>
					</c:if>



					<!-- 페이지 목록 -->
					<c:forEach var="p" begin="${pagination.startPage}"
						end="${pagination.endPage}">

						<c:choose>
							<c:when test="${p == pagination.currentPage }">
								<li><a class="focus-page">${p }</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageURL}?cp=${p}${searchStr}&bo=reportboard">${p}</a></li>
							</c:otherwise>
						</c:choose>

					</c:forEach>






					<!-- 현재 페이지가 마지막 페이지 미만인 경우 -->
					<c:if test="${pagination.currentPage < pagination.maxPage }">
						<li><a href="${pageURL}?cp=${pagination.currentPage+1}${searchStr}""><i
								class="fas fa-caret-right"></i></a></li>
					</c:if>

					<!-- 현재 페이지가 마지막 페이지 미만인 경우 -->
					<c:if
						test="${pagination.currentPage - pagination.maxPage + pagination.pageSize < 0 }">
						<li><a href="${next}"><i
								class="fas fa-caret-square-right"></i></a></li>
					</c:if>

				</ul>
			</div>
			
         <!----------------------------------------------------------------------------------------------  Pagination end -->

         <!-- 검색창 -->
         <div class="my-2">
            <form action="list" method="GET" class="text-center" id="searchForm">
               <div class="container2">
                  <div class="search-container">
                     <div>

                      <select name="sc" class="form-control" style="width: 200px; display: inline-block; ">
                        <option value="0">전체 카테고리</option>
                        <option value="1">도배글</option>
                        <option value="2">광고/홍보</option>
                        <option value="3">저작권법위반</option>
                        <option value="4">성희롱</option>
                        <option value="5">욕설/비방</option>
                     </select>
                      <select name="sk" class="form-control" style="width: 200px; display: inline-block; ">
                        <option value="title">신고제목</option>
                        <option value="content">신고내용</option>
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
      </div>


   <!-- ===============================영역구분선=============================== -->
   <%-- <jsp:include page="../common/footer.jsp" /> --%>


   <script>
		// 검색 내용이 있을 경우 검색창에 해당 내용을 작성해두는 기능
		(function(){
			var searchCategory = "${param.sc}";
			var searchKey = "${param.sk}"; 
			var searchValue = "${param.sv}";
			
			// 검색창 select의 option을 반복 접근
			$("select[name=sc] > option").each(function(index, item){
				// index : 현재 접근중인 요소의 인덱스
				// item : 현재 접근중인 요소
							// content            content
				if( $(item).val() == searchCategory  ){
					$(item).prop("selected", true);
				}
			});		
			
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
