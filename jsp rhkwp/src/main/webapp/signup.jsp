<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        .container {
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="password"], input[type="email"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .submit-btn {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            
            if(password !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>회원가입</h2>
        <form action="signup" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" required>
            </div>
            <button type="submit" class="submit-btn">가입하기</button>
        </form>
    </div>
</body>
</html>