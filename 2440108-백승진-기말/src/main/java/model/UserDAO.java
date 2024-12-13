package model;

import java.sql.*;
import util.DatabaseUtil;

public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    // 회원가입
    public boolean signup(UserDTO user) {
        String SQL = "INSERT INTO users (username, password, email, nickname) VALUES (?, ?, ?, ?)";
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword()); // 실제 구현시 암호화 필요
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getNickname());
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return false;
    }
    
    // 로그인
    public UserDTO login(String username, String password) {
        String SQL = "SELECT * FROM users WHERE username = ? AND password = ? AND status = 'active'";
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, username);
            pstmt.setString(2, password); // 실제 구현시 암호화 확인 필요
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setNickname(rs.getString("nickname"));
                user.setRegDate(rs.getString("reg_date"));
                user.setAdmin(rs.getBoolean("is_admin"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return null;
    }
    
    // 회원 삭제 (상태 변경)
    public boolean deleteAccount(int userId) {
        String SQL = "UPDATE users SET status = 'withdrawn' WHERE user_id = ?";
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return false;
    }
    
    // 비밀번호 확인
    public boolean verifyPassword(int userId, String password) {
        String SQL = "SELECT password FROM users WHERE user_id = ?";
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                return rs.getString("password").equals(password); // 실제 구현시 암호화된 비밀번호 비교 필요
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return false;
    }
    
    // 회원정보 수정
    public boolean updateUser(UserDTO user) {
        String SQL = "UPDATE users SET nickname = ?, email = ?";
        // 비밀번호가 변경되는 경우에만 비밀번호 업데이트
        if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
            SQL += ", password = ?";
        }
        SQL += " WHERE user_id = ?";
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getNickname());
            pstmt.setString(2, user.getEmail());
            
            if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
                pstmt.setString(3, user.getPassword()); // 실제 구현시 암호화 필요
                pstmt.setInt(4, user.getUserId());
            } else {
                pstmt.setInt(3, user.getUserId());
            }
            
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return false;
    }

    // 자원 해제를 위한 메소드
    private void close() {
        if (rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
    }
}