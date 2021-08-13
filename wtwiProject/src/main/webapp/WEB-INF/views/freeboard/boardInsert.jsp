<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판</title>

</head>
<body>
<jsp:include page="../common/header.jsp" />
    <div class="container">
        <h3 class="my-4 font-weight-bold">자유게시판</h3>
        <form action="insert" method="POST" id="insertForm">
            <div class="row mb-3">
	            <div class="col-2">
	                <select class="form-control" id="freeCategory" name="freeCategoryNo">
		                <c:forEach items="${category}" var="c">
		                	<option value="${c.freeCategoryNo}">${c.freeCategoryName}</option>
		                </c:forEach>
	                </select>
	            </div>
	            <div class="col-10">
	                <input type="text" class="form-control" placeholder="제목을 입력하세요." id="freeTitle" name="freeTitle">
	            </div>
            </div>
            <div class="mb-3">
                <textarea id="summernote" name="editordata"></textarea>
            </div>
            <input type="hidden" name="imgs" id="imgs">
            <button type="button" class="btn btn-outline-secondary" onclick="location.href='list';">취소</button>
            <button type="submit" class="btn btn-secondary float-right">등록</button>
        </form>
    </div>
</body>
<script>
var imgs = [];

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
				//console.log(fileName);
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
	
	// 유효성 검사
	$("#insertForm").on("submit", function(){
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
	});
});
</script>
</html>