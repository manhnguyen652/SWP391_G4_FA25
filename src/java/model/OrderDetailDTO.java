package model;

public class OrderDetailDTO {
    private String productName;
    private int quantity;
    private double pricePerItem;
    private double totalItemPrice;

    public OrderDetailDTO() {
    }

    // Getters and Setters
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPricePerItem() {
        return pricePerItem;
    }

    public void setPricePerItem(double pricePerItem) {
        this.pricePerItem = pricePerItem;
    }

    public double getTotalItemPrice() {
        // Tính tổng tiền cho mục này
        return this.quantity * this.pricePerItem;
    }
    
    // Setter này có thể không cần nếu bạn tính toán động
    public void setTotalItemPrice(double totalItemPrice) {
        this.totalItemPrice = totalItemPrice;
    }
}