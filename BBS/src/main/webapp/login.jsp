<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--기본적으로 부트스트랩은 컴퓨터 or 핸드폰 어떤device로 접속하더라도 해상도에 맞게 알아서 설정되는 탬플릿이다. 따라서 간단하게 반응형 웹에 사용되는 메타 태그를 작성해준다.-->
<meta name="viewport" content="width=device-width" , inital-scale="1">
<!--link 태그를 이용해서, stylesheet를 참조선언 해주고, 링크로 css폴더안에 있는 bootstrap.css를 사용해 준다고 명시해준다. jSP내의 디자인 담당-->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<!-- 네비게이션 구현 네비게이션이라는 것은 하나의 웹사이트의 전반적인 구성을 보여주는 역할 -->
	<nav class="navbar navbar-default">
		<!-- header부분을 먼저 구현해 주는데 홈페이지의 로고같은것을 담는 영역이라고 할 수 있다. -->
		<div class="navbar-header">
			<!-- <1>웹사이트 외형 상의 제일 좌측 버튼을 생성해준다. data-target= 타겟명을 지정해주고-->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-exmaple="false">
		<!-- 이건 모바일 화면으로 볼때, 요약된 메뉴 목록에 줄을 그려주는부분 그림에서 설명 *1* 별건없고 단지 꾸며주는 용도-->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 여긴 웹페이지의 로고 글자를 지정해준다. 클릭 시 main.jsp로 이동하게 해주는게 국룰 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<!-- 여기서 <1>에만든 버튼 내부의 데이터 타겟과 div id가 일치해야한다. -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- div 내부에 ul은 하나의 어떠한 리스트를 보여줄때 사용 -->
			<ul class="nav navbar-nav">
				<!-- 리스트 내부에 li로 원소를 구현 메인으로 이동하게만들고-->
				<li><a href="main.jsp">메인</a></li>
				<!-- 게시판으로 이동하게 만든다. -->
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<!-- 리스트 하나 더 생성 웹페이지 화면에서 우측 부분-->
			<ul class="nav navbar-nav navbar-right">
				<!-- 원소를 하나 구현해 준다. 네비게이션 우측 슬라이드메뉴 구현  -->
				<li class="dropdown">
					<!-- 안에 a태그를 하나 삽입한다. href="#"은 링크없음을 표시한다. -->
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기
						<!-- 이건 하나의 아이콘 같은것 a태그 내부 삽입-->
						<span class="caret"></span></a>
					<!--접속하기 아래에 드랍다운메뉴 생성  -->
					<ul class="dropdown-menu">
						<!-- li class="active" 현재 선택된 홈페이지를 표시해 주게만든다. -->
						<li class="active"><a href="login.jsp">로그인</a></li>
						<!-- active는 한 개만 선언 -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>	
		</div>
		<!-- 네비게이션 바 구성 끝 -->
	</nav>
	
	<!--<2> 여기서 부터 로그인 양식 <div>컨테이너 하나의 컨테이너처럼 감싸주는 역할 -->
	<div class="container"> 
		<!-- 이건 왜 넣어주는걸까 -->
		<div class="col-lg-4"></div>
		<!-- 로그인 폼 작성 -->
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<!-- 양식 삽입 post는 회원가입이나 로그인같이 어떠한 정보값을 숨기면서 보내는 메소드/ 로그인 Action페이지로 정보를보내겠다-->
				<form method="post" action="loginAction.jsp">
					<!-- 로그인 페이지 내부의 문장 가운데 정렬로 삽입 -->
					<h3 style="text-align: center;">로그인 화면</h3>
					<!-- 아이디 입력 공간 구현 -->
					<div class="form-group">
						<!-- name="userID"쪽은 나중에 서버프로그램을 작성할때 사용하기때문에 대소문자구별 -->
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<!-- 패스워드 입력 공간 구현 -->
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<label for="remember-check">
                <input type="checkbox" id="remember-check">아이디 저장하기
            	</label>
            	
            		<div class="form-group">
					<!-- 로그인 버튼 구현 -->
					<input type="submit" class="btn btn-primary form-control" value="로그인">
					</div>
					<!-- 카카오 소셜로그인 API 연동 기능구현 -->
					<div class="form-group">
					<body style="margin:0; padding:0;">
					<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
  							integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous"></script>
					<script>
  							Kakao.init('JavaScript key'); // 사용하려는 앱의 JavaScript 키 입력
					</script>
							<a id="custom-login-btn" href="javascript:loginWithKakao()"><img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222"/>
							<p id="token-result"></p>
					<script type="text/javascript">
	// 웹 플랫폼 도메인 등 초기화한 앱의 설정이 그대로 적용됩니다.
	// 초기화한 앱에 현재 도메인이 등록되지 않은 경우 에러가 발생합니다.
	Kakao.init('c089c8172def97eb00c07217cae17495');
	function loginWithKakao() {
		Kakao.Auth.authorize({
			// 초기화한 앱의 로그인 Redirect URI에 등록된 URI여야 합니다.
			redirectUri: 'https://developers.kakao.com/tool/demo/oauth'
		});
	}
	// 아래는 데모를 위한 UI 코드입니다.
	getToken()
	function getToken() {
		const token = getCookie('authorize-access-token')
		if(token) {
			Kakao.Auth.setAccessToken(token)
			document.getElementById('token-result').innerText = 'login success. token: ' + Kakao.Auth.getAccessToken()
		}
	}
	function getCookie(name) {
		const value = "; " + document.cookie;
		const parts = value.split("; " + name + "=");
		if (parts.length === 2) {
			return parts.pop().split(";").shift();
		}
	}
	</script>
</body>

<script>
  function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'https://developers.kakao.com/tool/demo/oauth',
    });
  }

  // 아래는 데모를 위한 UI 코드입니다.
  displayToken()
  function displayToken() {
    var token = getCookie('authorize-access-token');

    if(token) {
      Kakao.Auth.setAccessToken(token);
      Kakao.Auth.getStatusInfo()
        .then(function(res) {
          if (res.status === 'connected') {
            document.getElementById('token-result').innerText
              = 'login success, token: ' + Kakao.Auth.getAccessToken();
          }
        })
        .catch(function(err) {
          Kakao.Auth.setAccessToken(null);
        });
    }
  }

  function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length === 2) { return parts[1].split(';')[0]; }
  }
</script>
				
					</div>
					
					<div class="form-group">
  <%
    String clientId = "클라이언트 ";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8080/naver.Login", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
         + "&client_id=" + clientId
         + "&redirect_uri=" + redirectURI
         + "&state=" + state;
    session.setAttribute("state", state);
 %>
  <a href="<%=apiURL%>"><img height="50" width="222" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
</div>
					
				</form>	
			</div>	
		</div>
		<div class="col-lg-4"></div>
	</div>
	<!--이 파일의 애니메이션을 담당할 자바스크립트 참조선언 jquery를 특정 홈페이지에서 호출 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!--js폴더 안에있는 bootstrap.js를 사용선언  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>
