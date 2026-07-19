package model;
import java.util.Date;

public class Order {
    private int orderId;
    private String username;
    private String fullName;
    private String phone;
    private String address;
    private String paymentMethod;
    private double totalAmount;
    private Date orderDate;
    private String status;
    private String employeeUsername;
    private java.sql.Timestamp receivedDate;

    public Order() {}
    public Order(int orderId, String username, String fullName, String phone, String address, String paymentMethod, double totalAmount, Date orderDate, String status) {
        this.orderId = orderId; this.username = username; this.fullName = fullName;
        this.phone = phone; this.address = address; this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount; this.orderDate = orderDate; this.status = status;
    }
    // Getters and Setters
    public int getOrderId() { return orderId; } public void setOrderId(int orderId) { this.orderId = orderId; }
    public String getUsername() { return username; } public void setUsername(String username) { this.username = username; }
    public String getFullName() { return fullName; } public void setFullName(String fullName) { this.fullName = fullName; }
    public String getPhone() { return phone; } public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; } public void setAddress(String address) { this.address = address; }
    public String getPaymentMethod() { return paymentMethod; } public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public double getTotalAmount() { return totalAmount; } public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public Date getOrderDate() { return orderDate; } public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
    public String getStatus() { return status; } public void setStatus(String status) { this.status = status; }
    public String getEmployeeUsername() { return employeeUsername; }
    public void setEmployeeUsername(String employeeUsername) { this.employeeUsername = employeeUsername; }
    public java.sql.Timestamp getReceivedDate() { return receivedDate; }
    public void setReceivedDate(java.sql.Timestamp receivedDate) { this.receivedDate = receivedDate; }
}