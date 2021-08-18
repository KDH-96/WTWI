<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
      <div id="contentArea">
			<jsp:include page="boardSelect.jsp"></jsp:include>
			
            <!-- 위 select-option에 따라서 보여지는 테이블이 다름 -->

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

	         <div class="row d-flex justify-content-end mr-2 mb-2">
				 <a class="btn btn-primary" style="background-color: black; border: black; width: 100px" href="${contextPath}/admin/freeboard/insertForm">글작성</a>
	         </div>

            <!-- 자유게시판 테이블 -->
          <table class="table">
            <thead class="thead-dark">
              <tr>
                  <th class="text-center" scope="col">글번호</th>
                  <th class="text-center" scope="col">말머리</th>
                  <th class="text-center" scope="col">제목</th>
                  <th class="text-center" scope="col">작성자</th>
                  <th class="text-center" scope="col">작성일</th>
                  <th class="text-center" scope="col">조회수</th>
                  <th class="text-center" scope="col">상태</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${boardList}" var="b">
              <tr>
                <th scope="row">${b.freeNo}</th>
                <td>${b.freeCategoryName}</td>
                <td><a id="linkA" href="${b.freeNo}?cp=${pagination.currentPage}${searchString}&bo=freeboard">${b.freeTitle}</a></td>
                <td>${b.memberNick}</td>
                <td><fmt:formatDate value="${b.freeCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>${b.freeReadCount}</td>
                <td>
                  <form action="changeFreeStatus" method="POST" id="changeFreeStatus">
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
                  <input type="hidden" name="bo" value="${param.bo}">
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
		<c:set var="prev" value="${pageURL}?cp=${pagination.prevPage}${searchString}&bo=freeboard"/>
		<c:set var="next" value="${pageURL}?cp=${pagination.nextPage}${searchString}&bo=freeboard"/>
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
							<li class="page-item"><a class="page-link" style="color:black" href="${pageURL}?cp=${p}${searchString}&bo=freeboard">${p}</a></li>
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
         <div class="my-2 row d-flex justify-content-center">
            <form action="list" method="GET" class="text-center" id="searchForm">
               <div class="container2 p-0 m-0">
                  <div class="input-group mb-3">
                      <select name="sk" class="form-control col-4" id="formKey">
                    	<option value="ticontent">제목+내용</option>
                    	<option value="title">제목</option>
                    	<option value="content">내용</option>
                    	<option value="author">작성자</option>
                    	<option value="category">카테고리</option>
                    	<option value="reply">댓글</option>
                     </select>
                      <select name="sc" class="form-control col-2 ml-1" style="display: none; " id="formCategory">
                   		<option value="1">잡담</option>
                   		<option value="2">추천</option>
                   		<option value="3">궁금</option>
                   		<option value="4">같이</option>
                   		<option value="5">기타</option>
                     </select>
                        <input type="text" name="sv" class="form-control col-6 ml-1" style="" id="formValue">
                        <input type="hidden" name="bo" value="${param.bo}">
                        <button class="form-control btn btn-primary ml-1"
                        style="background-color: black; border: black;">검색</button>
                  </div>
               </div>
            </form>
         </div>
      </div>


   <!-- ===============================영역구분선=============================== -->
   <%-- <jsp:include page="../common/footer.jsp" /> --%>


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
				$("#formCategory").attr("style", "width:150px;");
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
