<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.BoardDTO" %>
<%@ page import="model.BoardDAO" %>
<%@ page import="model.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>
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
        .edit-form {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        textarea {
            height: 300px;
            resize: vertical;
        }
        .btn-group {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
        }
        .btn-submit {
            background-color: #28a745;
            color: white;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
        }
        .btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <%
        UserDTO user = (UserDTO) session.getAttribute("user");
        if(user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int postId = Integer.parseInt(request.getParameter("id"));
        BoardDAO boardDAO = new BoardDAO();
        BoardDTO post = boardDAO.getPost(postId);
        
        if(post == null || post.getUserId() != user.getUserId()) {
            response.sendRedirect("board.jsp");
            return;
        }
    %>
    <div class="container">
        <form class="edit-form" action="board/edit" method="post">
            <input type="hidden" name="postId" value="<%=post.getPostId()%>">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" value="<%=post.getTitle()%>" required>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" required><%=post.getContent()%></textarea>
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                <button type="submit" class="btn btn-submit">수정</button>
            </div>
        </form>
    </div>
    <script>
        document.querySelector('form').onsubmit = function(e) {
            var title = document.getElementById('title').value.trim();
            var content = document.getElementById('content').value.trim();
            
            if(title === '') {
                alert('제목을 입력해주세요.');
                e.preventDefault();
                return false;
            }
            if(content === '') {
                alert('내용을 입력해주세요.');
                e.preventDefault();
                return false;
            }
            return true;
        };
    </script>
</body>
</html>