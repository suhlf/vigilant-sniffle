<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "user.UserDAO" %>
<%@page import = "java.io.PrintWriter" %><!-- 자바스크립트 문장작성 위한것 -->
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/><!-- jsp usebean사용. 사용 범위 page안 -->
<jsp:setProperty property="userID" name="user" />
<jsp:setProperty property="userPassword" name="user"/><!-- login.jsp파일에서 설정한 이름 사용. -->
<jsp:setProperty property="userName" name="user" />
<jsp:setProperty property="userGender" name="user"/>
<jsp:setProperty property="userEmail" name="user" />
<!-- 실질적으로 로그인을 처리하는 페이지  DAO를 이용-->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		if(user.getUserID()==null||user.getUserPassword()==null||user.getUserGender()==null||
		user.getUserGender()==null||user.getUserEmail()==null){
			
		
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
		}
			else{
				UserDAO userDAO = new UserDAO();
				int result = userDAO.join(user);
				if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('아이디가 존재합니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
				else{
					session.setAttribute("userID",user.getUserID());
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
				
		}
			
	%>
</body>
</html>