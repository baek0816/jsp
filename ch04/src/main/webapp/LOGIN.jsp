<%@ page contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.util.Date" %>
<% 
	String uid = request.getParameter("id");
	String res = "<h1>사용자 아이디: " + uid + "</h1>";
	out.print(res);
	String date = (new Date()).toString();
%>	
로그인 시간: <%= date %>