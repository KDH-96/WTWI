<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
<style>
</style>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container">
         <div class="h-div">
         	<h2><span id="listTitle">게시글 수정</span></h2>
         </div>
         <!-- 명소 상세 정보를 감싸는 div -->
         <form action="update" method="POST" id="updateForm">
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
                  <th>카테고리</th>
                  <td>
	                <select id="freeCategory" name="freeCategoryNo">
		                <c:forEach items="${category}" var="c">
		                	<option value="${c.freeCategoryNo}">${c.freeCategoryName}</option>
		                </c:forEach>
	                </select>
				  </td>
                </tr>
                <tr>
                  <th>제목</th>
                  <td>
					<input type="text" value="${board.freeTitle}" id="freeTitle" name="freeTitle" style="width: 100%;">
				  </td>
                </tr>
               </tbody>
             </table>
         </div>
         <div>
            <textarea id="summernote" name="editordata">${board.freeContent}</textarea>
         </div>
         	<input type="hidden" name="imgs" id="imgs">
            <input type="hidden" name="deleteImgs" id="deleteImgs">
            <input type="hidden" name="freeNo" value="${board.freeNo}">
            <button type="button" class="btn btn-outline-secondary mt-2" onclick="location.href='${board.freeNo}';">취소</button>
            <button type="submit" class="btn btn-secondary float-right mt-2">수정</button>
         </form>
            
         <!----------------------------------------------------------------------------------------------  content end -->
         
</div>
<!-- footer -->

<script>
var imgs = [];
var deleteImgs = [];

$(document).ready(function() {
	$('#summernote').summernote({
		height: 500,
		minHeight: null,
		maxHeight: null,
		focus: false,
		lang: "ko-KR",
		placeholder: '내용을 입력하세요.',
		toolbar: [
			['fontname', ['fontname']],
			['fontsize', ['fontsize']],
			['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			['color', ['forecolor','color']],
			['table', ['table']],
			['para', ['ul', 'ol']],
			['height', ['height']],
			['insert',['picture','link']],
			['view', ['codeview']]
		],
		popover: {
			  image: [
			    ['remove', ['removeMedia']]
			  ]
			},
		callbacks: {
			// summernote가 지원하는 callbacks함수 중 
			// onImageUpload : 이미지를 업로드했을 때 동작(이미지를 첨부할 때마다 files에 이미지가 들어오고 콜백 함수가 호출됨)
			onImageUpload: function(files, editor, welEditable){
				for(var i=files.length-1; i>=0; i--){
					uploadFile(files[i], this);
				}
			},
			
			onMediaDelete: function(target){
				//console.log(target[0].src);
				deleteFile(target[0].src);
			}
		}
	});
	
	// summernote에서는 enter 를 할 때마다 작성한 문자들이 <p> 태그로 감싸지게 되고
	// 일반적인 줄바꿈(<br>)은 shift+enter로 동작한다. <p> 태그로 감싸지는 것을 바꿔줌
	$("#summernote").on("summernote.enter", function(we, e) {
	     $(this).summernote("pasteHTML", "<br>&zwnj;");
	     e.preventDefault();
	});
       
	function uploadFile(file, el){
		data = new FormData();
		data.append("file", file);
		$.ajax({
			url : "${contextPath}/freeboard/image",
			type : "POST",
			data : data,
			cache: false,
			contentType: false,
			enctype: 'multipart/form-data',
			processData: false,
           	
			success: function(fileName) {
				console.log(fileName);
				imgs.push(fileName);
				var image = "${contextPath}/"+fileName;
				$(el).summernote('editor.insertImage', image, function($image){
					var width = $image.prop('naturalWidth');
					var height = $image.prop('naturalHeight');
					if(width>1088){
						width = 1088;
						height = 'auto';
					}
					$image.css('width', width);
					$image.css('height', height);
				});
			},
           	
			error: function(e){
				console.log(e);
			}
		});
	}
	
	function deleteFile(src){
		$.ajax({
			url : "${contextPath}/freeboard/deleteImage",
			type : "POST",
			data : {"src" : src},
			cache: false,
	        
			success: function(fileName){
				deleteImgs.push(fileName);
			},
			
			error: function(e){
				console.log(e);
			}
		});
	}
	
	// 유효성 검사
	$("#updateForm").on("submit", function(){
		if($("#freeTitle").val().trim().length==0){
			swal({
				icon:"warning",
				title:"제목을 입력해주세요."
			});
			$("#freeTitle").focus();
			return false;
		}
		if($("#summernote").val().trim().length==0){
			swal({
				icon:"warning",
				title:"내용을 입력해주세요."
			});
			$("#freeContent").focus();
			return false;
		}
		$("#imgs").val(imgs);
		$("#deleteImgs").val(deleteImgs);
	});
	
	// 카테고리 선택
	const freeCategoryName = "${board.freeCategoryName}";
	$("#freeCategory > option").each(function(index, item){
		if($(item).text()==freeCategoryName){
			$(item).prop("selected", true);
		}
	});
	
});
</script>