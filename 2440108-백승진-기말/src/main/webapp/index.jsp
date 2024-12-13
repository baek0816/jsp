<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.UserDTO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            line-height: 1.6;
            color: #333;
        }

        .header {
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            text-decoration: none;
        }

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 2rem;
            align-items: center;
        }

        .nav-menu a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-menu a:hover {
            color: #007bff;
        }

        .auth-buttons {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
        }

        .btn-login {
            background-color: #007bff;
            color: white;
        }

        .btn-login:hover {
            background-color: #0056b3;
        }

        .btn-signup {
            background-color: #28a745;
            color: white;
        }

        .btn-signup:hover {
            background-color: #218838;
        }

        .btn-logout {
            background-color: #dc3545;
            color: white;
        }

        .btn-logout:hover {
            background-color: #c82333;
        }
        
        .btn-mypage {
            background-color: #17a2b8;
            color: white;
            margin-right: 10px;
        }
        
        .btn-mypage:hover {
            background-color: #138496;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-nickname {
            font-weight: 500;
            color: #333;
        }

        .main-container {
            max-width: 1200px;
            margin: 100px auto 40px;
            padding: 0 20px;
        }

        .board-section {
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #007bff;
        }

        .board-list {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .board-item {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .board-item:last-child {
            border-bottom: none;
        }

        .post-title {
            color: #333;
            text-decoration: none;
            flex-grow: 1;
        }

        .post-title:hover {
            color: #007bff;
        }

        .post-info {
            color: #666;
            font-size: 0.9rem;
            min-width: 200px;
            text-align: right;
        }

        .footer {
            background-color: #f8f9fa;
            padding: 2rem 0;
            margin-top: 4rem;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
            color: #666;
        }
    </style>
</head>
<body>
    <header class="header">
        <nav class="nav-container">
            <a href="index.jsp" class="logo">커뮤니티</a>
            <ul class="nav-menu">
                <li><a href="index.jsp">홈</a></li>
                <li><a href="board.jsp">게시판</a></li>
                <li><a href="#">갤러리</a></li>
                <li><a href="#">공지사항</a></li>
                
                <!-- 로그인 상태에 따른 버튼 표시 -->
                <%
                    UserDTO user = (UserDTO) session.getAttribute("user");
                    if(user == null) {
                %>
                    <li class="auth-buttons">
                        <a href="login.jsp" class="btn btn-login">로그인</a>
                        <a href="signup.jsp" class="btn btn-signup">회원가입</a>
                    </li>
                <%
                    } else {
                %>
                    <li class="user-info">
                        <span class="user-nickname"><%=user.getNickname()%>님</span>
                        <a href="mypage.jsp" class="btn btn-mypage">내정보</a>
                        <form action="user/logout" method="post" style="display: inline;">
                            <button type="submit" class="btn btn-logout">로그아웃</button>
                        </form>
                    </li>
                <%
                    }
                %>
            </ul>
        </nav>
    </header>

    <main class="main-container">
        <section class="board-section">
            <h2 class="section-title">공지사항</h2>
            <div class="board-list">
                <div class="board-item">
                    <a href="#" class="post-title">[공지] 커뮤니티 이용 규칙 안내</a>
                    <div class="post-info">관리자 | 2024.12.09</div>
                </div>
                <div class="board-item">
                    <a href="#" class="post-title">[안내] 12월 정기 점검 안내</a>
                    <div class="post-info">관리자 | 2024.12.08</div>
                </div>
            </div>
        </section>

        <section class="board-section">
            <h2 class="section-title">인기 게시글</h2>
            <div class="board-list">
                <div class="board-item">
                    <a href="#" class="post-title">겨울 여행 추천 장소</a>
                    <div class="post-info">여행러 | 조회 238</div>
                </div>
                <div class="board-item">
                    <a href="#" class="post-title">연말 모임 장소 추천해주세요</a>
                    <div class="post-info">맛집탐험가 | 조회 156</div>
                </div>
                <div class="board-item">
                    <a href="#" class="post-title">12월 독서 모임 후기</a>
                    <div class="post-info">책벌레 | 조회 142</div>
                </div>
            </div>
        </section>
    </main>

    <footer class="footer">
        <div class="footer-content">
            <p>&copy; 2024 커뮤니티. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>