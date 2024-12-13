<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 정보</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Noto Sans KR', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
        }
        .profile-card {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        .profile-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }
        .info-group {
            margin-bottom: 20px;
        }
        .info-label {
            font-weight: 500;
            color: #666;
            margin-bottom: 5px;
        }
        .info-value {
            font-size: 16px;
            padding: 8px;
            background-color: #f8f9fa;
            border-radius: 4px;
        }
        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        .btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }
        .btn-edit {
            background-color: #28a745;
            color: white;
        }
        .btn-edit:hover {
            background-color: #218838;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
        }
        .btn-back:hover {
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
        <div class="profile-card">
            <div class="profile-header">
                <h1 class="profile-title">내 정보</h1>
            </div>
            
            <div class="info-group">
                <div class="info-label">아이디</div>
                <div class="info-value"><%=user.getUsername()%></div>
            </div>
            
            <div class="info-group">
                <div class="info-label">닉네임</div>
                <div class="info-value"><%=user.getNickname()%></div>
            </div>
            
            <div class="info-group">
                <div class="info-label">이메일</div>
                <div class="info-value"><%=user.getEmail()%></div>
            </div>
            
            <div class="info-group">
                <div class="info-label">가입일</div>
                <div class="info-value"><%=user.getRegDate()%></div>
            </div>
            
            <div class="btn-group">
                <a href="index.jsp" class="btn btn-back">돌아가기</a>
                <a href="edit-profile.jsp" class="btn btn-edit">정보 수정</a>
                <button onclick="confirmDelete()" class="btn btn-delete">회원 탈퇴</button>
            </div>
        </div>
    </div>
    
    <script>
        function confirmDelete() {
            if(confirm('정말로 탈퇴하시겠습니까?\n탈퇴한 계정은 복구할 수 없습니다.')) {
                location.href = 'user/delete';
            }
        }
    </script>
</body>
</html>