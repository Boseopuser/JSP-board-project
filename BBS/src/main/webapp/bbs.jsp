<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!-- BbsDAO 함수를 사용하기때문에 가져오기 -->
<%@ page import="bbs.BbsDAO" %>
<!-- DAO쪽을 사용하면 당연히 javaBeans도 사용되니 들고온다.-->
<%@ page import="bbs.Bbs" %>
<!-- ArrayList같은 경우는 게시판의 목록을 가져오기위해 필요한 것 -->
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
<style type = "text/css">
</style>
</head>
<body>
<%	
//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    String userID = null;
    if (session.getAttribute("userID") != null)
    {
        userID = (String)session.getAttribute("userID");
    }
 //기본적으로 페이지 1부터선언
    int pageNumber = 1; 
	 //만약에 파라미터로 pageNumber가 넘어왔다면 해당 파라미터의 값을 넣어주도록 한다.
    if (request.getParameter("pageNumber") != null)
    {
    	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
%>
	<!-- 웹사이트 공통메뉴 -->
    <nav class ="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span><!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">JSP게시판 포트폴리오</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <!-- 현재의 게시판 화면이라는 것을 사용자에게 보여주는 부분 -->
                <li class="active"><a href="bbs.jsp">게시판</a></li>
                <li><a href="searchkakao.jsp">지도검색</a></li>
				<li><a href="chat.jsp">채팅</a>
            </ul>
            <%
            // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
                if(userID == null)
                {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
            // 로그인이 되어있는 사람만 볼수 있는 화면
                } else {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">회원관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="loginAction.jsp">로그아웃</a></li>
                        <li><a href="userUpdate.jsp">내 정보</a></li>
                        <li><a href="CalendarExam2.jsp">캘린더</a>
                    </ul>
                </li>
            </ul>
            <%
                }
            %>
        </div>
        <!-- 공통메뉴 끝 -->
    </nav>
    
    <% 
    	BbsDAO bbs = new BbsDAO();
    %>
    
    <div class="container">
		<div class="row">
			<form method="post" name="search" action="searchbbs.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="bbsTitle">제목</option>
								<option value="userID">작성자</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>

				</table>
			</form>
		</div>
	</div>
    
    <!-- 특정한 내용들을 담을 공간을 확보 해준다.-->
    <div class="container">
        <!-- 테이블이 들어갈 수 있는 공간 구현 -->
        <div class="row">
         	<!-- striped는 게시판 글목록을 홀수와 짝수로 번갈아가며 색이 변하게 해주는 하나의 요소  -->
            <table class="active table table-striped" style="text-align:center; border:1px solid #dddddd">
                <!-- thead는 테이블의 제목부분에 해당함 -->
                <thead>
                	<!-- 테이블의 하나의 행을 말함(한 줄)-->
                    <tr>
                    	<!-- 게시판의 속성을 하나씩 명시 해준다. -->
                        <th style="background-color:#eeeeee; text-align:center;">번호</th>
                        <th style="background-color:#eeeeee; text-align:center;">제목</th>
                        <th style="background-color:#eeeeee; text-align:center;">작성자</th>
                        <th style="background-color:#eeeeee; text-align:center;">작성일</th>
                        <th style="background-color:#eeeeee; text-align: center;">조회수</th>
						<th style="background-color:#eeeeee; text-align: center;">추천수👍</th>
                    </tr>
                </thead>
                <!-- tbody 같은 경우는 위에 지정해준 속성 아래에 하나씩 출력해주는 역할 -->
                <tbody>
                <%
                	//게시글을 담을 인스턴스
                    BbsDAO bbsDAO = new BbsDAO();
                	//list 생성 그 값은 현재의 페이지에서 가져온 리스트 게시글목록
                    ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                    //가져온 목록을 하나씩 출력하도록 선언한다..
                	for(int i = 0; i < list.size(); i++)
                    {
                %>
                <!-- 실제 데이터를 사용자에게 보여주는 부분 -->
                    <tr>
                    	<!-- 현재의 게시글에 대한 정보를 하나씩 데이터를 데이터베이스에서 불러와서 보여준다. -->
                        <td><%=list.get(i).getBbsID() %></td>
                        <!-- 제목을 눌렀을때는 해당 게시글의 내용을 보여주는 페이지로 이동해야하기때문에
                         view.jsp페이지로 해당 게시글번호를 매개변수로 보내서 처리한다. href="주소?변수명 = 값! 이런식으로 처리를 해준다.-->
                        <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
                        <td><%=list.get(i).getUserID() %></td>
                        <!--날짜 데이터를 가져오는것은 substring(index,index) 함수는 DB내부에서 필요한 정보만 잘라서 들고오게 해 주는 함수-->
                        <td><%=list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11, 13) + "시" 
                        + list.get(i).getBbsDate().substring(14,16) + "분" %></td>
                        <td><%=list.get(i).getBbsCount()%></td>
                        <td><%=list.get(i).getLikeCount()%></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
          <div class=container style="text-align: center">
				<%
					if (pageNumber != 1) {//이전페이지로
				%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>">◀ 이전</a>
				<%
					}
				%>
					<%
						int n = (int) (bbsDAO.getCount() / 10 + 1);
						for (int i = 1; i <= n; i++) {
					%>	
					<a href="bbs.jsp?pageNumber=<%=i%>">|<%=i%>|
					</a>
					<%
						}
					%>
				<%
					if (bbsDAO.nextPage(pageNumber + 1)) {//다음페이지가 존재하는ㄱ ㅏ
				%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>">다음 ▶</a>
				<%
					}
				%>
				<a href="write.jsp" class="btn btn-success pull-right">글쓰기</a>
			</div>
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