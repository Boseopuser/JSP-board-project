<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Script문장을 실행 할 수 있도록 PrintWriter 라이브러리를 불러온다. -->
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 내가 만든 글짜를 적용시키기 위한 custom.css참조!  -->
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String userID = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<!-- 홈페이지의 로고 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expand="false">
				<span class="icon-bar"></span>
				<!-- 줄였을때 옆에 짝대기 -->
				<span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP게시판 포트폴리오</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<!-- 현재 페이지가 메인이기 때문에 active를 달아주고, 현재 접속한 페이지가 메인페이지인걸 사용자에게 알려준다. -->
				<li class="active"><a href="main.jsp">메인</a></li>
				<!-- 클릭 시 bbs.jsp로 보내준다. -->
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="searchkakao.jsp">지도검색</a></li>
				<li><a href="chat.jsp">채팅</a>
				
			</ul>
			<%
				// 접속하기는 로그인이 되어있지 않은 경우만 나오게한다.
			if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
						<li><a href="CalendarExam2.jsp">캘린더</a>
					</ul></li>
			</ul>
			<%
				// 로그인이 되어있는 사람만 볼수 있는 화면
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
					<!-- 해당 페이지로 이동 후 세션해지 후 main화면으로 링크 -->
						<li><a href="logoutAction.jsp">로그아웃</a></li>
						<li><a href="userUpdate.jsp">내 정보</a></li>
						<li><a href="CalendarExam2.jsp">캘린더</a>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	<!-- 이런식으로 세션 관리를 해서 회원 상태에 따라서 보여줄것과 안보여줄것을 분리 할 수있다. -->
	</nav>
	<!-- 꾸며줄 공간의 div태그를 하나 구현해 준다. -->
	<div class="container">
		<!-- 일반적으로 웹사이트를 소개하는 영역이 있는데 그것을 바로 jumbotron이라고 부른다, bootstrap에서 제공하는 요소이다. -->
		<div class="jumbotron">
			<!-- 공간의 제목 -->
			<h1>시그널 동행찾기 게시판</h1>
			<!-- 내용 -->
			<p>여행시그널만의 동행찾기 커뮤니티를 통해 손쉽게 일정부터 동행여행까지 게시판을 통해서 쉽게 구해보세요!</p>
			<!-- p태그로 감싸서 a태그로 디자인용 button을 하나만든다. 하나쯤 있는게 이쁘기때문에. -->
			<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
		</div>
	</div>
	<!-- 사진을 넣을 공간을 div로 구현해 준다. -->
	<div class="container">
		<!-- 공간의id는 myCarousel = 사진첩이라고 할 수 있다. -->
		<div id="myCarousel" class="carousel slide" data-rid="carousel">
			<!-- ol태그는 번호를 앞에 붙여 목록을 만드는 형식이다. 지시자를 구현해 준다.-->
			<ol class="carousel-indicators">
				<!-- 넣을 이미지가 3개 이기때문에, 3개를 넣어주고 맨 처음보여줄 부분에 active를 붙여준다. -->
				<li data-target="#myCarousel" data-slice-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slice-to="1"></li>
				<li data-target="#myCarousel" data-slice-to="2"></li>
			</ol>
			<!-- 실질적으로 이미지가 들어 갈 수있는 부분을 구현해 준다.  -->
			  <div class="carousel-inner"> -->
				<!-- 현재 선택이 되어있는 사진을 보여준다, -->
				<div class="item active">
					<!-- images파일 안에있는 1이라는 사진을 가져온다 -->
					<img src="images/1.jpg">
				</div>
				<div class="item">
					<img src="images/2.jpg">
				</div>
				<div class="item">
					<img src="images/3.jpg">
				</div>
			</div> 
			<!-- 이제 사진을 양 옆으로 넘길 수 있는 버튼을 구현 해준다. -->
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<!-- 버튼 내에 이모티콘을 구현해 준다. -->
				<span class="glyphicon glyphicon-chevron-left"></span>
			<!-- 이러면 아이콘으로 된 버튼의 왼쪽으로 옮기는 버튼 구현이 끝났다. -->
			</a> 
			<a class="right carousel-control" href="#myCarousel" data-slide="next"> 
			<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script>
        (function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.")}var ch=function(){ch.c(arguments)};ch.q=[];ch.c=function(args){ch.q.push(args)};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x)}}if(document.readyState==="complete"){l()}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l)}})();
      
        ChannelIO('boot', {
          "pluginKey": "13bd2f67-0a0e-4d9a-a3df-1ecfa17056cf"
        });
      </script>
</body>
</html>