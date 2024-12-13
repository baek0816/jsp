<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
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
        .edit-form {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        .form-title {
            font-size: 24px;
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
            color: #555;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
        }
        .readonly-field {
            background-color: #f8f9fa;
            cursor: not-allowed;
        }
        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.2s;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
        }
        .btn-cancel:hover {
            background-color: #5a6268;
        }
        .password-info {
            font-size: 13px;
            color: #666;
            margin-top: 5px;
        }
        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: none;
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
        <form class="edit-form" action="user/update" method="post" onsubmit="return validateForm()">
            <div class="form-header">
                <h1 class="form-title">회원정보 수정</h1>
            </div>
            
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" value="<%=user.getUsername()%>" class="readonly-field" readonly>
            </div>
            
            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" value="<%=user.getNickname()%>" required>
                <div id="nicknameError" class="error-message">닉네임은 2-10자 사이여야 합니다.</div>
            </div>
            
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" value="<%=user.getEmail()%>" required>
                <div id="emailError" class="error-message">올바른 이메일 형식이 아닙니다.</div>
            </div>
            
            <div class="form-group">
                <label for="currentPassword">현재 비밀번호</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
            </div>
            
            <div class="form-group">
                <label for="newPassword">새 비밀번호 (변경시에만 입력)</label>
                <input type="password" id="newPassword" name="newPassword">
                <p class="password-info">8자 이상, 영문/숫자/특수문자 포함</p>
                <div id="passwordError" class="error-message">비밀번호는 8자 이상이며 영문, 숫자, 특수문자를 포함해야 합니다.</div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">새 비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword">
                <div id="confirmError" class="error-message">비밀번호가 일치하지 않습니다.</div>
            </div>
            
            <div class="btn-group">
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                <button type="submit" class="btn btn-primary">수정하기</button>
            </div>
        </form>
    </div>
    
    <script>
        function validateForm() {
            let isValid = true;
            
            // 닉네임 검증
            const nickname = document.getElementById('nickname').value;
            const nicknameError = document.getElementById('nicknameError');
            if(nickname.length < 2 || nickname.length > 10) {
                nicknameError.style.display = 'block';
                isValid = false;
            } else {
                nicknameError.style.display = 'none';
            }
            
            // 이메일 검증
            const email = document.getElementById('email').value;
            const emailError = document.getElementById('emailError');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if(!emailRegex.test(email)) {
                emailError.style.display = 'block';
                isValid = false;
            } else {
                emailError.style.display = 'none';
            }
            
            // 새 비밀번호 검증 (입력된 경우에만)
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const passwordError = document.getElementById('passwordError');
            const confirmError = document.getElementById('confirmError');
            
            if(newPassword) {
                const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
                if(!passwordRegex.test(newPassword)) {
                    passwordError.style.display = 'block';
                    isValid = false;
                } else {
                    passwordError.style.display = 'none';
                }
                
                if(newPassword !== confirmPassword) {
                    confirmError.style.display = 'block';
                    isValid = false;
                } else {
                    confirmError.style.display = 'none';
                }
            }
            
            return isValid;
        }
    </script>
</body>
</html>