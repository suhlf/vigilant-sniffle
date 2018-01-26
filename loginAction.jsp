<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "user.UserDAO" %>
<%@page import = "java.io.PrintWriter" %><!-- 자바스크립트 문장작성 위한것 -->
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/><!-- jsp usebean사용. 사용 범위 page안 -->
<jsp:setProperty property="userID" name="user" />
<jsp:setProperty property="userPassword" name="user"/><!-- login.jsp파일에서 설정한 이름 사용. -->

<!-- 실질적으로 로그인을 처리하는 페이지  DAO를 이용-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String)session.getAttribute("userID");
	}
	if(userID !=null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location href = 'main.jsp'");
		script.println("</script>");
	}
		UserDAO userDAO = new UserDAO();	
	int result = userDAO.login(user.getUserID(),user.getUserPassword());
		if(result == 1){
			session.setAttribute("userID",user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()"); //뒤로 되돌리는 것. 
			script.println("</script>");
		}
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("데이터 베이스 오류가 발생하였습니다.");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>