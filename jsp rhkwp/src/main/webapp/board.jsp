<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="model.BoardDAO" %>
<%@ page import="model.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Noto Sans KR', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
        }
        .board-table {
            width: 100%;
            background: white;
            border-collapse: collapse;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        .board-table th,
        .board-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .board-table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        .board-table tr:hover {
            background-color: #f8f9fa;
        }
        .title-link {
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }
        .title-link:hover {
            color: #007bff;
        }
        .write-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 20px;
            float: right;
        }
        .write-btn:hover {
            background-color: #0056b3;
        }
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            margin-top: 20px;
        }
        .pagination a {
            display: inline-block;
            padding: 8px 16px;
            text-decoration: none;
            color: #007bff;
            margin: 0 4px;
            border-radius: 4px;
        }
        .pagination a:hover {
            background-color: #007bff;
            color: white;
        }
        .pagination .active {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            UserDTO user = (UserDTO) session.getAttribute("user");
            if(user != null) {
        %>
            <a href="write.jsp" class="write-btn">글쓰기</a>
        <%
            }
        %>
        
        <table class="board-table">
            <thead>
                <tr>
                    <th width="10%">번호</th>
                    <th width="50%">제목</th>
                    <th width="15%">작성자</th>
                    <th width="15%">작성일</th>
                    <th width="10%">조회</th>
                </tr>
            </thead>
            <tbody>
                <%
                    BoardDAO boardDAO = new BoardDAO();
                    int pageNumber = 1;
                    if(request.getParameter("page") != null) {
                        pageNumber = Integer.parseInt(request.getParameter("page"));
                    }
                    
                    ArrayList<BoardDTO> list = boardDAO.getList(pageNumber);
                    for(BoardDTO board : list) {
                %>
                <tr>
                    <td><%=board.getPostId()%></td>
                    <td>
                        <a href="view.jsp?id=<%=board.getPostId()%>" class="title-link">
                            <%=board.getTitle()%>
                        </a>
                    </td>
                    <td><%=board.getWriter()%></td>
                    <td><%=board.getCreatedAt()%></td>
                    <td><%=board.getViewCount()%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        
        <div class="pagination">
            <%
                int totalPages = 5; // 실제로는 전체 게시글 수를 기반으로 계산해야 함
                for(int i = 1; i <= totalPages; i++) {
            %>
                <a href="?page=<%=i%>" <%= pageNumber == i ? "class='active'" : "" %>><%=i%></a>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>