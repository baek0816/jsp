// UserServlet.java
package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDAO;
import model.UserDTO;

@WebServlet("/user/*")
public class UserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String pathInfo = request.getPathInfo();
        
        switch(pathInfo) {
            case "/signup":
                handleSignup(request, response);
                break;
            case "/login":
                handleLogin(request, response);
                break;
            case "/logout":
                handleLogout(request, response);
                break;
            case "/delete":
                handleDelete(request, response);
                break;
        }
    }
    
    private void handleSignup(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        UserDTO user = new UserDTO();
        user.setUsername(request.getParameter("username"));
        user.setPassword(request.getParameter("password"));
        user.setEmail(request.getParameter("email"));
        user.setNickname(request.getParameter("nickname"));
        
        if(userDAO.signup(user)) {
            response.sendRedirect("/login.jsp?success=true");
        } else {
            response.sendRedirect("/signup.jsp?error=true");
        }
    }
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        UserDTO user = userDAO.login(username, password);
        if(user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("/index.jsp");
        } else {
            response.sendRedirect("/login.jsp?error=true");
        }
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session != null) {
            session.invalidate();
        }
        response.sendRedirect("/index.jsp");
    }
    
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session != null && session.getAttribute("user") != null) {
            UserDTO user = (UserDTO) session.getAttribute("user");
            String currentPassword = request.getParameter("currentPassword");
            
            // 현재 비밀번호 확인
            if(userDAO.verifyPassword(user.getUserId(), currentPassword)) {
                user.setNickname(request.getParameter("nickname"));
                user.setEmail(request.getParameter("email"));
                
                String newPassword = request.getParameter("newPassword");
                if(newPassword != null && !newPassword.trim().isEmpty()) {
                    user.setPassword(newPassword);
                }
                
                if(userDAO.updateUser(user)) {
                    session.setAttribute("user", user);
                    response.sendRedirect("/mypage.jsp?success=true");
                } else {
                    response.sendRedirect("/edit-profile.jsp?error=update");
                }
            } else {
                response.sendRedirect("/edit-profile.jsp?error=password");
            }
        } else {
            response.sendRedirect("/login.jsp");
        }
    }
    
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session != null && session.getAttribute("user") != null) {
            UserDTO user = (UserDTO) session.getAttribute("user");
            if(userDAO.deleteAccount(user.getUserId())) {
                session.invalidate();
                response.sendRedirect("/index.jsp?deleted=true");
            } else {
                response.sendRedirect("/mypage.jsp?error=true");
            }
        } else {
            response.sendRedirect("/login.jsp");
        }
    }
}