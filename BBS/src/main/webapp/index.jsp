<!-- 기본적인 웹사이트 틀을 잡아주는 부분 charset="언어" -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<!-- 1.body tag 내에 script tag 생성 -->
	<script>
			//웹페이지에 접속 시에 강제로 로그인 화면으로 이동 시켜주는 소스 작성
			location.href = 'login.jsp';
	</script>
</body>
</html>