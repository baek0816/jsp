<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // 세션을 가져와서 초기화
    HttpSession session = request.getSession(false);
    if (session != null) {
        session.invalidate(); // 세션 무효화
    }
    // main.jsp로 리다이렉트
    response.sendRedirect("main.jsp");
%>
