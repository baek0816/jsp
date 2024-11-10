<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Page</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <div class="inner">
            <h1><a href="#">DCODLAB</a></h1>
            <ul id="gnb">
                <li><a href="#">DEPARTMENT</a></li>
                <li><a href="#">GALLERY</a></li>
                <li><a href="#">YOUTUBE</a></li>
                <li><a href="#">COMMUNITY</a></li>
                <li><a href="#">LOCATION</a></li>
            </ul>
            <ul class="util">
                <%
                    HttpSession session = request.getSession(false);
                    String username = (session != null) ? (String) session.getAttribute("username") : null;

                    if (username != null) {
                %>
                    <li><a href="#">안녕하세요, <%= username %>님</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                <% } else { %>
                    <li><a href="login.html">Login</a></li>
                    <li><a href="signup.html">Join</a></li>
                <% } %>
                <li><a href="#">Sitemap</a></li>
            </ul>
        </div>
    </header>
    <h1>메인 페이지</h1>
</body>
</html>
