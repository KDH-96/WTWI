<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>

#weather-info-area {
	left: 0;
	top: 75px;
	position: absolute;
	z-index: 2;
	padding: 0;
	height: 100vh;
}
 
#weather-info {
	margin: auto;
	opacity: 90%;
	width: 300px;
	height: 100px;
	padding: 8px;
	display: inline-block;
}

</style>

<body>
	<div id="weather-info-area">
		<div class="card" id="weather-info">
		</div>
	</div>
</body>