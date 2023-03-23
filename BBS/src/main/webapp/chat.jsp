<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Document</title>
</head>
<body>
    <div class="container">
        <h4>궁금한 점을 실시간으로 물어보세요</h4>
        <iframe src="https://service.dongledongle.com/gksmf3428" frameborder="0" width="100%" height="800vh"></iframe>
        <!-- HTML5 기반의 API 연동 채팅 기능구현 -->
        <input type="submit" id="btnBack" value="뒤로가기" onClick="history.back()">
        <input type="button" id="btnJoin" value="회원가입" onclick="location.href='../UsersJoin/index.jsp'">
        
        </div>
</body>
</html>