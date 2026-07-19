package dao;

import model.User;
import utils.DBCPUtils;
import java.sql.*;

public class UserDAO {
    public User checkLogin(String username, String password) {
        // Use LTRIM and RTRIM in SQL to completely eliminate hidden space errors
        String sql = "SELECT UserID, Username, FullName, RoleID, Status FROM Users WHERE LTRIM(RTRIM(Username))=? AND LTRIM(RTRIM(Password))=?";
        
        try (Connection conn = DBCPUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, username.trim());
            ps.setString(2, password.trim());
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("UserID"), 
                    rs.getString("Username"), 
                    rs.getString("FullName"), 
                    rs.getInt("RoleID"), 
                    rs.getBoolean("Status")
                );
            }
        } catch (SQLException e) { 
            // Print exact error to NetBeans Output console for debugging
            System.out.println("SQL ERROR IN USERDAO: " + e.getMessage());
            e.printStackTrace(); 
        }
        return null;
    }
    public boolean registerCustomer(String username, String password, String fullName) {
        // Mặc định RoleID = 3 (Customer) và Status = 1 (Active)
        String sql = "INSERT INTO Users(Username, Password, FullName, RoleID, Status) VALUES (?, ?, ?, 3, 1)";
        try (Connection conn = DBCPUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username.trim());
            ps.setString(2, password.trim());
            ps.setString(3, fullName.trim());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    // Hàm ghi lại hành động của nhân viên
    public void saveLog(String username, String action) {
        String sql = "INSERT INTO OrderLogs (Username, ActionDesc) VALUES (?, ?)";
        try (Connection conn = DBCPUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, action);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Hàm lấy danh sách Log cho Admin xem
    public java.util.List<String> getRecentLogs() {
        java.util.List<String> logs = new java.util.ArrayList<>();
        String sql = "SELECT Username, ActionDesc, LogTime FROM SystemLogs ORDER BY LogTime DESC";
        try (Connection conn = DBCPUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                logs.add(rs.getString("LogTime") + " | User: " + rs.getString("Username") + " | " + rs.getString("ActionDesc"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return logs;
    }
// 1. Ghi log vào bảng OrderLogs mới
    public void addOrderLog(String username, String action) {
        String sql = "INSERT INTO OrderLogs (Username, Action) VALUES (?, ?)";
        try (java.sql.Connection conn = utils.DBCPUtils.getConnection(); 
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, action);
            ps.executeUpdate();
        } catch (java.sql.SQLException e) { e.printStackTrace(); }
    }

    // 2. Lấy log từ bảng OrderLogs
    public java.util.List<String> getOrderLogs() {
        java.util.List<String> list = new java.util.ArrayList<>();
        String sql = "SELECT TOP 50 * FROM OrderLogs ORDER BY LogDate DESC";
        try (java.sql.Connection conn = utils.DBCPUtils.getConnection(); 
             java.sql.PreparedStatement ps = conn.prepareStatement(sql); 
             java.sql.ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getTimestamp("LogDate") + " | " + rs.getString("Username") + " ➡️ " + rs.getString("Action"));
            }
        } catch (java.sql.SQLException e) { e.printStackTrace(); }
        return list;
    }
}