package model;

import java.sql.Timestamp;

public class Refund {
    private int id;
    private int orderId;
    private int userId;
    private double amount;
    private String reason;
    private String status; // PENDING, APPROVED, REJECTED, COMPLETED
    private Timestamp requestDate;
    private Timestamp processDate;
    private String processedBy;
    private String notes;
    private String customerName;
    private String customerEmail;
    private double orderAmount;
    private Timestamp orderDate;
    
    // Constructors
    public Refund() {
    }
    
    public Refund(int orderId, int userId, double amount, String reason) {
        this.orderId = orderId;
        this.userId = userId;
        this.amount = amount;
        this.reason = reason;
        this.status = "PENDING";
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
    }
    
    public String getReason() {
        return reason;
    }
    
    public void setReason(String reason) {
        this.reason = reason;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getRequestDate() {
        return requestDate;
    }
    
    public void setRequestDate(Timestamp requestDate) {
        this.requestDate = requestDate;
    }
    
    public Timestamp getProcessDate() {
        return processDate;
    }
    
    public void setProcessDate(Timestamp processDate) {
        this.processDate = processDate;
    }
    
    public String getProcessedBy() {
        return processedBy;
    }
    
    public void setProcessedBy(String processedBy) {
        this.processedBy = processedBy;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public String getCustomerName() {
        return customerName;
    }
    
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    
    public String getCustomerEmail() {
        return customerEmail;
    }
    
    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
    
    public double getOrderAmount() {
        return orderAmount;
    }
    
    public void setOrderAmount(double orderAmount) {
        this.orderAmount = orderAmount;
    }
    
    public Timestamp getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }
}
