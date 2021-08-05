<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
    integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
    crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
    crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
    integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">


  <style>



    /* 일정작성 제목  */
    #content-title-box {
      width: 200px;
      height: 50px;
    }

    /* 일정 선택 박스 */
    #setDate-area {
      width: 400px;
      height: 40px;
    }


    /* 카테고리 선택 영역 */
    #category-pick-area {
      width: 300px;
      height: 30px;
    }



    /* 제목 입력 영역 시작 */
    #input-title-area {
      width: 1100px;
      height: 45px;
    }

    #title-box {
      width: 6%;
      height: 100%;
      text-align: left;
    }

    #inputGroup {
      width: 100%;
      height: 100%;
      font-weight: bold;
    }

    #input-title-box {
      width: 50%;
      height: 100%;
    }

    /* 제목 입력 영역 끝 */


    /* 공개 비공개 checkbox 시작 */
    input[type="checkbox"] {
      display: none;
    }


    .label__on-off {
      overflow: hidden;
      position: relative;
      display: inline-block;
      width: 75px;
      height: 40px;
      -webkit-border-radius: 13px;
      -moz-border-radius: 13px;
      border-radius: 25px;
      background-color: grey;
      color: #fff;
      font-weight: bold;
      cursor: pointer;
      -webkit-transition: all .3s;
      -moz-transition: all .3s;
      -ms-transition: all .3s;
      -o-transition: all .3s;
      transition: all .3s;
    }

    .label__on-off>* {
      vertical-align: middle;
      -webkit-transition: all .3s;
      -moz-transition: all .3s;
      -ms-transition: all .3s;
      -o-transition: all .3s;
      transition: all .3s;
      font-size: 15px;
    }

    .label__on-off .marble {
      position: absolute;
      top: 0px;
      left: 0px;
      display: block;
      width: 40px;
      height: 40px;
      background-color: #fff;
      -webkit-border-radius: 50%;
      -moz-border-radius: 50%;
      border-radius: 50%;
      -webkit-box-shadow: 0 0 10px rgba(0, 0, 0, .3);
      -moz-box-shadow: 0 0 10px rgba(0, 0, 0, .3);
      box-shadow: 0 0 10px rgba(0, 0, 0, .3);
    }

    .label__on-off .on {
      display: none;
      padding-left: 12px;
      line-height: 40px;
    }

    .label__on-off .off {
      padding-left: 45px;
      line-height: 40px;
    }

    .input__on-off:checked+.label__on-off {
      background-color: #0bba82;
    }

    .input__on-off:checked+.label__on-off .on {
      display: inline-block;
    }

    .input__on-off:checked+.label__on-off .off {
      display: none;
    }

    .input__on-off:checked+.label__on-off .marble {
      left: 35px;
    }


    /* 공개 비공개 checkbox 끝 */






    /* 내용 영역 시작 */

    #content-title {
      width: 1000px;
      background-color: grey;
      color: white;
    }

    /* 내용 영역 끝 */




    /* 취소/작성완료 영역 시작*/
    #cancel-enroll-btn-area {
      width: 100%;
      height: 40px;
    }

    #cancel-enroll-btn-box {
      width: 150px;
      height: 40px;
      text-align: center;
      margin-left: auto;
    }

    /* 취소/작성완료 영역 끝*/
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"></jsp:include>

	<div class="container my-5">

		<h3>답글 등록</h3>
		<hr>
		<form action="insertFormRE" method="post" role="form"  onsubmit="return boardValidate();">
			
			<div class="form-inline mb-2">
					<label class="input-group-addon mr-3 insert-label"><h5>To.</h5></label>
			<h5 class="my-0" id="writer">${loginMember.memberNick}</h5>
			</div>
			
			<hr>

			<!-- 게시글 제목 입력 칸 -->
			<div class="input-group mb-3" id="input-title-area">

				<div class="input-group-prepend" id="title-box">
					<span class="input-group-text" id="inputGroup">제목</span>
				</div>
				
				<div id="input-title-box">
					<input type="text" class="form-control"  id="boardTitle" aria-label="Sizing example input"
					aria-describedby="inputGroup-sizing-default" name="qnaTitle" placeholder="제목을 입력해주세요.">
				</div>

				<div class="custom-control custom-switch" style="margin-left: auto;">
					
					<div id="show-ask-area" style="float: left; height: 100%; line-height: 35px;">
						<label for="checkbox" id="show-ask">공개</label>
					</div>
					
					<input type="checkbox" id="switch1" name="qnaStatus" class="input__on-off"> 
					
					<label for="switch1" class="label__on-off"> <span class="marble"></span>
					<span class="on" value="S">on</span>
					<span class="off" value="Y">off</span>
					</label>

				</div>

			</div>


			<hr>

			<!-- 게시글 내용 작성 영역 -->

			<div class="form-group" id="content-title" style="width: 1100px;">
				<label for="exampleFormControlTextarea1">내용</label>
				<textarea class="form-control" id="exampleFormControlTextarea1" name="qnaContent" rows="20" style="resize: none; width: 1100px;"></textarea>
			</div>



			<!-- 취소/등록 버튼 영역-->
			<div id="cancel-enroll-btn-area">
				<div id="cancel-enroll-btn-box">

					<!-- Button trigger modal -->
					<button type="button" class="btn btn-primary mr-2" id="btn-cancel"
						data-toggle="modal" data-target="#staticBackdrop">취소</button>
					<button type="submit" class="btn btn-primary">등록</button>

				</div>
			</div>
			<input type="hidden" name="qnaPno" value="${param.qnaPno}">
			<input type="hidden" name="qnaCategoryNo" value="${param.qnaCategoryNo}">
		</form>




		<!-- Modal -->
		<div class="modal fade" id="staticBackdrop" data-backdrop="static"
			data-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">취소하시겠습니까?</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">취소 버튼을 누르시면 작성한 내용이 삭제되고 목록으로 돌아갑니다.</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" id="btn-commit" onclick="location.href='${contextPath}/qnaboard/list'">확인</button>
					</div>
				</div>
			</div>
		</div>



	</div>



	<script>

		// 유효성 검사 
		function boardValidate() {
			if ($("#boardTitle").val().trim().length == 0) {
				alert("제목을 입력해 주세요.");
				$("#title").focus();
				return false;
			}

			if ($("#exampleFormControlTextarea1").val().trim().length == 0) {
				alert("내용을 입력해 주세요.");
				$("#content").focus();
				return false;
			}
		}
		
		// 공개/비공개
        $(document).ready(function () {
        	  
            $("#switch1").click(function () {
    
              if ($("#switch1").prop("checked")) {
                $("#show-ask").text("비공개");
    
              } else {
                $("#show-ask").text("공개");
              }
    
            });
          });
		
		
		
	</script>
</body>
</html>
