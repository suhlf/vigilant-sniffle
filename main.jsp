<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name = "viewport" content = "width=device-width" initial-scale = "1">
<link rel="stylesheet" href = "css/bootstrap.css">
<link rel="stylesheet" href = "css/custom.css">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
<%
	String userID = null;
	if (session.getAttribute("userID")!=null)
	{
		userID = (String) session.getAttribute("userID");
	}
%>
<nav class = "navbar navbar-default"> <%--홈페이지의 전반적 주석 --%>
	<div class = "navbar-header"><%--홈페이지의 로고 담는 것  --%>
		<button type = "button" class = "navbar-toggle collapsed"
			data-toggle="collapse" data-target ="#bs-example-navbar-collapse-1"
			aria-expanded ="false">
			<span class = "icon-bar"></span><%--icon-bar가 메뉴의 하나의 작대기 --%>
			<span class = "icon-bar"></span>
			<span class = "icon-bar"></span>
			
			</button>
			<a class = "navbar-brand" href = "main.jsp">JSP 게시판 웹사이트</a><%--로고같은 것을 넣는것 --%>
	</div>
	<div class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
		<ul class = "nav navbar-nav">
			<li class = "active"><a href = "main.jsp">메인</a></li>
			<li><a href = "bbs.jsp">게시판</a></li>
		</ul>
		<%
			if(userID ==null){
				
			
		%>
			<ul class = "nav navbar-nav navbar-right">
			<li class = "dropdown">
			<%-- href #은 아무것도 링크타지 않는다는 뜻 --%>
			<a href ="#" class = "dropdown-toggle"
			data-toggle = "dropdown" role = "button" aria-haspopup = "true"
			aria-expanded = "false">접속하기<span class= "caret"></span></a>
			<ul class = "dropdown-menu">
			<li class = "active"><a href = "login.jsp">로그인</a></li>
			<li><a href = "join.jsp">회원가입</a></li>
			</ul>
			</li>
		</ul>
		<%
			} else{
		%>
			<ul class = "nav navbar-nav navber-right">
				<li class = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup = "true"
						aria-expanded = "false">회원관리<span class = "caret"></span></a>
						<ul class = "dropdown-menu">
						<li><a href = "logoutAction.jsp">로그아웃</a></li>
						</ul>
				</li>
			</ul>
		<%
			}
		%>
	
	</div>
</nav>
	<div class="container">
		<div class="jumbotron">
			<h1>웹 사이트 소개</h1>
			<p>이 웹 사이트는 부트스트랩으로 만든 JSP 웹 사이트입니다. 최소한의 로직을 사용하여 간단한 동작을 하는 게시판 서버입니다.</p>
			<p><a class ="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a> 
		</div>
	</div>
	<div class="container">
		<div id="myCarousel" class ="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators"> <!-- 위와 동일한 아이디가 다들 들어가야한다. #myCarousel -->
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1" ></li>
				<li data-target="#myCarousel" data-slide-to="2" ></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/캡처.PNG">
				</div>
				<div class="item">
					<img src="images/캡처2.PNG">
				</div>
				<div class="item">
					<img src="images/캡처3.PNG">
				</div>
				</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
			<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>﻿<%--애니메이션 담당 --%>
	<script src = "js/bootstrap.js"></script>
	
</body>
</html>