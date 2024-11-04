<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<% 
	session.invalidate();
	out.print("로그아웃 하였습니다.");

%>
