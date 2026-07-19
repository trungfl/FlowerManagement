package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Flower;
import utils.DBCPUtils;

public class FlowerDAO {
    
    // 1. Tìm kiếm và Phân trang
public List<Flower> searchFlowers(String keyword, int page, int pageSize) {
    List<Flower> list = new ArrayList<>();
    // Thêm AND Status != 'Deleted' vào đây
    String sql = "SELECT * FROM Flowers WHERE Name LIKE ? AND Status != 'Deleted' ORDER BY FlowerID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    try (Connection conn = DBCPUtils.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, "%" + keyword + "%");
        ps.setInt(2, (page - 1) * pageSize);
        ps.setInt(3, pageSize);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Flower(rs.getInt("FlowerID"), rs.getString("Name"), rs.getInt("CategoryID"),
                        rs.getString("Description"), rs.getDouble("Price"), rs.getInt("Quantity"),
                        rs.getString("Status"), rs.getString("ImageURL")));
            }
        }
    } catch (SQLException e) { e.printStackTrace(); }
    return list;
}

    // 2. Đếm tổng số hoa
   public int countTotalFlowers(String keyword) {
    String sql = "SELECT COUNT(*) FROM Flowers WHERE Name LIKE ? AND Status != 'Deleted'";
        try (Connection conn = DBCPUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // 3. Lấy hoa theo ID
    public Flower getFlowerById(int id) {
        String sql = "SELECT * FROM Flowers WHERE FlowerID = ?";
        try (Connection conn = DBCPUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return new Flower(rs.getInt("FlowerID"), rs.getString("Name"), rs.getInt("CategoryID"),
                        rs.getString("Description"), rs.getDouble("Price"), rs.getInt("Quantity"),
                        rs.getString("Status"), rs.getString("ImageURL"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // 4. Trừ kho (Export)
    public boolean deductQuantity(int flowerId, int quantityBought) {
        String sql = "UPDATE Flowers SET Quantity = Quantity - ? WHERE FlowerID = ? AND Quantity >= ?";
        try (Connection conn = DBCPUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantityBought); ps.setInt(2, flowerId); ps.setInt(3, quantityBought);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); } return false;
    }

    // 5. Cộng kho (Import)
    public boolean addQuantity(int flowerId, int quantityAdded) {
        String sql = "UPDATE Flowers SET Quantity = Quantity + ? WHERE FlowerID = ?";
        try (Connection conn = DBCPUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantityAdded);
            ps.setInt(2, flowerId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // 6. Thêm hoa mới
    public boolean addFlower(Flower f) {
        String sql = "INSERT INTO Flowers (Name, CategoryID, Description, Price, Quantity, Status, ImageURL) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBCPUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, f.getName());
            ps.setInt(2, f.getCategoryId());
            ps.setString(3, f.getDescription());
            ps.setDouble(4, f.getPrice());
            ps.setInt(5, f.getQuantity());
            ps.setString(6, f.getStatus()); 
            ps.setString(7, f.getImageURL());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // 7. Cập nhật hoa
public boolean updateFlower(Flower flower) {
    String sql = "UPDATE Flowers SET Name = ?, CategoryID = ?, Description = ?, Price = ?, Quantity = ?, Status = ?, ImageURL = ? WHERE FlowerID = ?";
    try (java.sql.Connection conn = utils.DBCPUtils.getConnection();
         java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
         
        ps.setString(1, flower.getName());
        ps.setInt(2, flower.getCategoryId());
        ps.setString(3, flower.getDescription());
        ps.setDouble(4, flower.getPrice());
        ps.setInt(5, flower.getQuantity());
        ps.setString(6, flower.getStatus());
        ps.setString(7, flower.getImageURL());
        ps.setInt(8, flower.getFlowerId());
        
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    
    public List<Flower> getLowStockFlowers() {
        List<Flower> list = new ArrayList<>();
        
        String sql = "SELECT * FROM Flowers WHERE ISNULL(Quantity, 0) < 5 AND Status LIKE '%Available%'";
        
        try (Connection conn = DBCPUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                list.add(new Flower(
                    rs.getInt("FlowerID"), 
                    rs.getString("Name"), 
                    rs.getInt("CategoryID"),
                    rs.getString("Description"), 
                    rs.getDouble("Price"), 
                    rs.getInt("Quantity"), 
                    rs.getString("Status"), 
                    rs.getString("ImageURL")
                ));
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }
    public java.util.List<model.Flower> getAllFlowers() {
    java.util.List<model.Flower> list = new java.util.ArrayList<>();
    String sql = "SELECT * FROM Flowers"; 
    
    try (java.sql.Connection conn = utils.DBCPUtils.getConnection();
         java.sql.PreparedStatement ps = conn.prepareStatement(sql);
         java.sql.ResultSet rs = ps.executeQuery()) {
         
        while (rs.next()) {
            list.add(new model.Flower(
                rs.getInt("flowerId"), 
                rs.getString("name"), 
                rs.getInt("categoryId"),
                rs.getString("description"),
                rs.getDouble("price"), 
                rs.getInt("quantity"),
                rs.getString("status"),
                rs.getString("imageURL")
            ));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
public boolean softDeleteFlower(int id) {
    String sql = "UPDATE Flowers SET Status = 'Deleted' WHERE FlowerID = ?";
    try (java.sql.Connection conn = utils.DBCPUtils.getConnection();
         java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

public List<Flower> getFlowersForHome() {
    List<Flower> list = new ArrayList<>();
    String sql = "SELECT * FROM Flowers WHERE Status != 'Deleted'";
    try (java.sql.Connection conn = utils.DBCPUtils.getConnection();
         java.sql.PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            list.add(new Flower(
                rs.getInt("FlowerID"), rs.getString("Name"), rs.getInt("CategoryID"),
                rs.getString("Description"), rs.getDouble("Price"), rs.getInt("Quantity"),
                rs.getString("Status"), rs.getString("ImageURL")
            ));
        }
    } catch (Exception e) { e.printStackTrace(); }
    return list;
}
}