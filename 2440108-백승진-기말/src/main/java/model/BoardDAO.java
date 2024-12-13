package model;

import java.sql.*;
import java.util.ArrayList;
import util.DatabaseUtil;

public class BoardDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    // 게시글 작성
    public boolean writePost(BoardDTO board) {
        String SQL = "INSERT INTO posts (user_id, title, content, writer) VALUES (?, ?, ?, ?)";
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, board.getUserId());
            pstmt.setString(2, board.getTitle());
            pstmt.setString(3, board.getContent());
            pstmt.setString(4, board.getWriter());
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return false;
    }
    
    // 게시글 목록 조회
    public ArrayList<BoardDTO> getList(int page) {
        String SQL = "SELECT * FROM posts WHERE is_deleted = false ORDER BY post_id DESC LIMIT ?, 10";
        ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, (page - 1) * 10);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                BoardDTO board = new BoardDTO();
                board.setPostId(rs.getInt("post_id"));
                board.setUserId(rs.getInt("user_id"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setViewCount(rs.getInt("view_count"));
                board.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(board);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }
    
    // 게시글 상세 조회
    public BoardDTO getPost(int postId) {
        String SQL = "SELECT * FROM posts WHERE post_id = ? AND is_deleted = false";
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, postId);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                BoardDTO board = new BoardDTO();
                board.setPostId(rs.getInt("post_id"));
                board.setUserId(rs.getInt("user_id"));
                board.setTitle(rs.getString("title"));
                board.setContent(rs.getString("content"));
                board.setWriter(rs.getString("writer"));
                board.setViewCount(rs.getInt("view_count"));
                board.setCreatedAt(rs.getTimestamp("created_at"));
                board.setUpdatedAt(rs.getTimestamp("updated_at"));
                return board;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return null;
    }
    
    // 게시글 수정
    public boolean updatePost(BoardDTO board) {
        String SQL = "UPDATE posts SET title = ?, content = ?, updated_at = CURRENT_TIMESTAMP WHERE post_id = ? AND user_id = ?";
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, board.getTitle());
            pstmt.setString(2, board.getContent());
            pstmt.setInt(3, board.getPostId());
            pstmt.setInt(4, board.getUserId());
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return false;
    }
    
    // 게시글 삭제
    public boolean deletePost(int postId, int userId) {
        String SQL = "UPDATE posts SET is_deleted = true WHERE post_id = ? AND user_id = ?";
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, postId);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return false;
    }
    
    // 조회수 증가
    public void increaseViewCount(int postId) {
        String SQL = "UPDATE posts SET view_count = view_count + 1 WHERE post_id = ?";
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, postId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }
    
    private void close() {
        try { if(rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if(pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if(conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
}