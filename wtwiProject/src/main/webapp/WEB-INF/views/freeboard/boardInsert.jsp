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
        <form class="form-write" id="form-write" action="#" method="POST">
            <div class="row">
              <div class="col-2">
                <div class="mb-3">
                  <select class="form-control">
                    <option value="" selected>카테고리 선택</option>
                    <c:forEach items="${category}" var="c">
	                    <option value="${c.freeCategoryNo}">${c.freeCategoryName}</option>
                    </c:forEach>
                  </select>
                </div>
              </div>
              <div class="col-10">
                <div class="mb-3">
                  <input type="text" class="form-control" placeholder="제목을 입력하세요.">
                </div>
              </div>
            </div>
            <div class="mb-3">
                <textarea id="summernote" name="editordata"></textarea>
            </div>
            <button type="button" class="btn btn-outline-secondary" onclick="">취소</button>
            <button type="submit" class="btn btn-secondary float-right">등록</button>
        </form>
    </div>
</body>
<script>
	// summernote 기본 화면 
    $(document).ready(function() {
        $('#summernote').summernote({
            height: 500,
            minHeight: null,
            maxHeight: null,
            focus: false,
            lang: "ko-KR",
            placeholder: '내용을 입력해주세요.'
        });
    });
</script>
</html>