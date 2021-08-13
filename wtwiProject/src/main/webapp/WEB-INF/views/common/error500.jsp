<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR</title>
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
	
	<!-- Bootstrap core JS -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
	
	<link href="${contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
  <div class="container">
    <div class="err-div">
      <div class="mb-3">
        <img src="${ contextPath }/resources/images/error.png" class="mx-auto d-block">
      </div>
      <div class="mb-4 err-msg">
        <h1 align="center">500</h1>
        <h3 align="center">내부 서버 오류</h3>
      </div>
      <div align="center">
        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="history.back();">이전 페이지로</button>
        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='${ contextPath }';">메인 페이지로</button>
      </div>
    </div>
  </div>
</body>
</html>