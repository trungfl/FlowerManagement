package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import utils.DBCPUtils;

public class OrderDAO {
    
    public int createOrder(Order order) {
        String sql = "INSERT INTO Orders (Username, FullName, Phone, Address, PaymentMethod, TotalAmount, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, order.getUsername()); ps.setString(2, order.getFullName());
            ps.setString(3, order.getPhone()); ps.setString(4, order.getAddress());
            ps.setString(5, order.getPaymentMethod()); ps.setDouble(6, order.getTotalAmount());
            ps.setString(7, "Processing");
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) { if (rs.next()) return rs.getInt(1); }
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    public void createOrderDetail(int orderId, int flowerId, int quantity, double price) {
        String sql = "INSERT INTO OrderDetails (OrderID, FlowerID, Quantity, Price) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId); ps.setInt(2, flowerId); ps.setInt(3, quantity); ps.setDouble(4, price);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Order> getOrdersByUsername(String username) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE Username = ? ORDER BY OrderDate DESC";
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order(rs.getInt("OrderID"), rs.getString("Username"), rs.getString("FullName"), rs.getString("Phone"), rs.getString("Address"), rs.getString("PaymentMethod"), rs.getDouble("TotalAmount"), rs.getTimestamp("OrderDate"), rs.getString("Status"));
                    o.setEmployeeUsername(rs.getString("EmployeeUsername"));
                    o.setReceivedDate(rs.getTimestamp("ReceivedDate"));
                    list.add(o);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
        // Đã thêm conn. vào trước prepareStatement
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status); 
            ps.setInt(2, orderId); 
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
        } 
        return false;
    }

    // ====== EMPLOYEE & ADMIN AREA ======
    
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY OrderDate DESC";
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = new Order(rs.getInt("OrderID"), rs.getString("Username"), rs.getString("FullName"), rs.getString("Phone"), rs.getString("Address"), rs.getString("PaymentMethod"), rs.getDouble("TotalAmount"), rs.getTimestamp("OrderDate"), rs.getString("Status"));
                o.setEmployeeUsername(rs.getString("EmployeeUsername"));
                o.setReceivedDate(rs.getTimestamp("ReceivedDate"));
                list.add(o);
            }
        } catch (SQLException e) { e.printStackTrace(); } return list;
    }

    public String getOrderItemsText(int orderId) {
        StringBuilder sb = new StringBuilder();
        String sql = "SELECT f.Name, od.Quantity FROM OrderDetails od JOIN Flowers f ON od.FlowerID = f.FlowerID WHERE od.OrderID = ?";
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while(rs.next()) { sb.append("<b class='text-primary'>").append(rs.getInt("Quantity")).append("x</b> ").append(rs.getString("Name")).append("<br>"); }
            }
        } catch(SQLException e) { e.printStackTrace(); }
        return sb.toString();
    }

    public void takeOrder(int orderId, String empUsername) {
        String sql = "UPDATE Orders SET EmployeeUsername = ? WHERE OrderID = ? AND EmployeeUsername IS NULL";
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, empUsername); ps.setInt(2, orderId);
            if(ps.executeUpdate() > 0) new UserDAO().addOrderLog(empUsername, "Took order #" + orderId);
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void updateOrderStatusLogged(int orderId, String status, String empUsername) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ? AND EmployeeUsername = ?";
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status); ps.setInt(2, orderId); ps.setString(3, empUsername);
            if(ps.executeUpdate() > 0) new UserDAO().addOrderLog(empUsername, "Updated order #" + orderId + " to: " + status);
        } catch (SQLException e) { e.printStackTrace(); }
    }

public double getMonthlyRevenue() {
        String sql = "SELECT SUM(TotalAmount) FROM Orders WHERE MONTH(OrderDate) = MONTH(GETDATE()) AND YEAR(OrderDate) = YEAR(GETDATE()) AND Status = 'Completed'";
        try (java.sql.Connection conn = utils.DBCPUtils.getConnection(); 
             java.sql.PreparedStatement ps = conn.prepareStatement(sql); 
             java.sql.ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (java.sql.SQLException e) { 
            e.printStackTrace(); 
        } 
        return 0;
    }
    public int getMonthlyTotalOrders() {
        String sql = "SELECT COUNT(*) FROM Orders WHERE MONTH(OrderDate) = MONTH(GETDATE()) AND YEAR(OrderDate) = YEAR(GETDATE())";
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); } return 0;
    }
    public int getTotalCustomers() {
        String sql = "SELECT COUNT(*) FROM Users WHERE RoleID = 3";
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); } return 0;
    }
    public boolean markOrderCompleted(int orderId) {
        String sql = "UPDATE Orders SET Status = 'Completed', ReceivedDate = GETDATE() WHERE OrderID = ?";
        try (java.sql.Connection conn = utils.DBCPUtils.getConnection(); 
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId); 
            return ps.executeUpdate() > 0;
        } catch (java.sql.SQLException e) { 
            e.printStackTrace(); 
        } 
        return false;
    }
}