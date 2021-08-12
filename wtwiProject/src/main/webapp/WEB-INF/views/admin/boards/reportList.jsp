<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

   
      <div id="contentArea">
			<jsp:include page="boardSelect.jsp"></jsp:include>
         
            <!-- 위 select-option에 따라서 보여지는 테이블이 다름 -->

         <!-- 신고 테이블 -->
         <table class="table">
            <thead class="thead-dark">
               <tr>
                  <th scope="col">신고번호</th>
                  <th scope="col">신고자</th>
                  <th scope="col">신고게시글</th>
                  <th scope="col">신고대상</th>
                  <th scope="col">신고일</th>
                  <th scope="col">신고처리</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <th scope="row">REPORT_NO</th>
                  <td>MEMBER_NM</td>
                  <td><a id="linkA" href="#">REPORT_TITLE</a></td>
                  <td>REPORT_TYPE_NO</td>
                  <td>REPORT_CREATE_DT</td>
                  <td>
                     REPORT_STATUS
                  <select>
                     <option>Y</option>
                     <option>N</option>
                  </select>
                  <button>변경</button>
                  </td>
               </tr>

            </tbody>
         </table>
      </div>
         <!----------------------------------------------------------------------------------------------  content end -->

         <!----------------------------------------------------------------------------------------------  Pagination start -->
         <!-- 페이징 처리 시 주소를 쉽게 작성할 수 있도록 필요한 변수를 미리 선언 -->

         <div class="my-2">
          <nav aria-label="Page navigation example">
            <ul class="pagination">
              <li class="page-item">
                <a class="page-link" href="#" aria-label="Previous">
                  <span aria-hidden="true" style="color:black">&laquo;</span>
                </a>
              </li>
              <li class="page-item"><a class="page-link" href="#" style="color:black">1</a></li>
              <li class="page-item"><a class="page-link" href="#" style="color:black">2</a></li>
              <li class="page-item"><a class="page-link" href="#" style="color:black">3</a></li>
              <li class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                  <span aria-hidden="true" style="color:black">&raquo;</span>
                </a>
              </li>
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
