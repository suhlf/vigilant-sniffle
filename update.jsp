<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.io.PrintWriter" %>
<%@page import = "bbs.Bbs" %>
<%@page import = "bbs.BbsDAO" %>
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
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	int bbsID = 0;
	if(request.getParameter("bbsID") !=null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID ==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");	//bbsID 빡난거 잡기
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if(!userID.equals(bbs.getUserID())){ //글을 작성한 사람과 맞는지 확인
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
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
	</div>
</nav>
<div class = "container">
<div class = "row">
	<form method = "post" action = "updateAction.jsp?bbsID=<%= bbsID%>"><!-- 따로 업데이트 액션을 처리하는 페이지 -->
	<table class = "table class = table-striped" style = "text-align : center; border : 1px solid #dddddd"><%--색상이 홀짝수가 번갈아서 나와 더 가독성 높여줌 --%>
		<thead><%--테이블 가장 위ㅉ쪽 --%>
			<tr>
				<th colspan = "2" style = "background-color : #eeeeee; text-align: center;">게시판 글수정 양식 </th>
			</tr>		
		</thead>
		<tbody>
			<tr>
				<td><input type = "text" class = "form-control" placeholder = "글 제목"  name = "bbsTitle" maxlength = "50" value="<%=bbs.getBbsTitle()%>"></td>	
				<!-- 게시판 수정하기전의 내용을 볼 수 있게해준다. 밑의 content도 마찬가지로 들어갔을때 자신이 작성한 것이 그대로 적혀져 있는 것!!!! 중요(편의, 일반적)-->
			</tr>
			<tr>
				<td><textarea class = "form-control" placeholder = "글 내용" name ="bbsContent" style = "height:350px;" maxlength="2048" ><%=bbs.getBbsContent()%></textarea></td>
			</tr>
			
		</tbody>
		
		</table>
		<input type ="submit" class = "btn btn-primary pull-right" value = "글수정">
		</form>
	</div>
</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>﻿<%--애니메이션 담당 --%>
	<script src = "js/bootstrap.js"></script>
	
</body>
</html>