<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 작성</title>
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
        .write-form {
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
            background-color: #007bff;
            color: white;
        }
        .btn-submit:hover {
            background-color: #0056b3;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
        }
        .btn-cancel:hover {
            background-color: #5a6268;
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
    %>
    <div class="container">
        <form class="write-form" action="board/write" method="post">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" required></textarea>
            </div>
            <input type="hidden" name="userId" value="<%=user.getUserId()%>">
            <input type="hidden" name="writer" value="<%=user.getNickname()%>">
            <div class="btn-group">
                <button type="button" class="btn btn-cancel" onclick="location.href='board.jsp'">취소</button>
                <button type="submit" class="btn btn-submit">등록</button>
            </div>
        </form>
    </div>
    <script>
        // 폼 제출 전 확인
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