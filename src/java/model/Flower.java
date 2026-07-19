package model;

public class Flower {
    private int flowerId;
    private String name;
    private int categoryId;
    private String description;
    private double price;
    private int quantity;
    private String status; // Changed to String for Pre-order, Available, etc.
    private String imageURL;

    public Flower() {}

    public Flower(int flowerId, String name, int categoryId, String description, double price, int quantity, String status, String imageURL) {
        this.flowerId = flowerId;
        this.name = name;
        this.categoryId = categoryId;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
        this.imageURL = imageURL;
    }

    public int getFlowerId() { return flowerId; }
    public void setFlowerId(int flowerId) { this.flowerId = flowerId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getImageURL() { return imageURL; }
    public void setImageURL(String imageURL) { this.imageURL = imageURL; }
}