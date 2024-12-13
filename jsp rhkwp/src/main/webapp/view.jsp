<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.BoardDTO" %>
<%@ page import="model.BoardDAO" %>
<%@ page import="model.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Noto Sans KR', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
        }
        .post-view {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .post-header {
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        .post-title {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .post-info {
            color: #666;
            font-size: 14px;
            display: flex;
            justify-content: space-between;
        }
        .post-content {
            min-height: 200px;
            margin-bottom: 30px;
            line-height: 1.8;
        }
        .btn-group {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
        }
        .btn-list {
            background-color: #6c757d;
            color: white;
        }
        .btn-edit {
            background-color: #28a745;
            color: white;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        .btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <%
        int postId = Integer.parseInt(request.getParameter("id"));
        BoardDAO boardDAO = new BoardDAO();
        BoardDTO post = boardDAO.getPost(postId);
        
        if(post == null) {
            response.sendRedirect("board.jsp");
            return;
        }
        
        // 조회수 증가
        boardDAO.increaseViewCount(postId);
        
        UserDTO user = (UserDTO) session.getAttribute("user");
    %>
    <div class="container">
        <div class="post-view">
            <div class="post-header">
                <h1 class="post-title"><%=post.getTitle()%></h1>
                <div class="post-info">
                    <span>작성자: <%=post.getWriter()%></span>
                    <span>작성일: <%=post.getCreatedAt()%></span>
                    <span>조회수: <%=post.getViewCount()%></span>
                </div>
            </div>
            <div class="post-content">
                <%=post.getContent().replace("\n", "<br>")%>
            </div>
            <div class="btn-group">
                <a href="board.jsp" class="btn btn-list">목록</a>
                <% if(user != null && user.getUserId() == post.getUserId()) { %>
                    <a href="edit.jsp?id=<%=post.getPostId()%>" class="btn btn-edit">수정</a>
                    <button onclick="deletePost(<%=post.getPostId()%>)" class="btn btn-delete">삭제</button>
                <% } %>
            </div>
        </div>
    </div>
    <script>
        function deletePost(postId) {
            if(confirm('정말 삭제하시겠습니까?')) {
                location.href = 'board/delete?id=' + postId;
            }
        }
    </script>
</body>
</html>