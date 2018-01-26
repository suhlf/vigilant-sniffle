<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "java.util.ArrayList" %>
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
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
			<li><a href = "main.jsp">메인</a></li>
			<li class = "active"><a href = "bbs.jsp">게시판</a></li>
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
<div class = "container">
<div class = "row">
	<table class = "table class = table-striped" style = "text-align : center; border : 1px solid #dddddd"><%--색상이 홀짝수가 번갈아서 나와 더 가독성 높여줌 --%>
		<thead><%--테이블 가장 위ㅉ쪽 --%>
			<tr>
				<th style = "background-color : #eeeeee; text-align : center;">번호</th><%--속성을 넣는것 --%>
				<th style = "background-color : #eeeeee; text-align : center;">제목</th>
				<th style = "background-color : #eeeeee; text-align : center;">작성자</th>
				<th style = "background-color : #eeeeee; text-align : center;">작성일</th>
			</tr>		
		</thead>
		<tbody>
			<%
				BbsDAO bbsDAO = new BbsDAO();
				ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
				for(int i = 0; i < list.size(); i++){
			%>
		</tbody>
		<tr>
			<td><%= list.get(i).getBbsID() %></td>
			<td><a href = "view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle() %></a></td>	
			<td><%=list.get(i).getUserID() %></td>
			<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13)+"시 "+list.get(i).getBbsDate().substring(14,16)+"분"%></td>	
		</tr>
		<%} %>
		</table>
		<%
			if(pageNumber != 1) {
		%>
			<a href = "bbs.jsp?pageNumber=<%=pageNumber - 1 %>" class = "btn btn-success btn-arrow-left">이전</a>
		<%
			} if(bbsDAO.nextPage(pageNumber + 1)){ //다음페이지가 존재하는지 물어봐야하므로 pageNumber+1
		%>
			<a href = "bbs.jsp?pageNumber=<%=pageNumber + 1 %>" class = "btn btn-success btn-arrow-left">다음</a>
		<%
			}
		%>
		<a href = "write.jsp" class = "btn btn-primary pull-right">글쓰기</a><%--오른쪽으로 고정 --%>
	</div>
</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>﻿<%--애니메이션 담당 --%>
	<script src = "js/bootstrap.js"></script>
	
</body>
</html>