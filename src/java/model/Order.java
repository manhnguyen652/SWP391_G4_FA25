package model;

import java.sql.Timestamp;

public class Order {

    private int id;
    private int uId;
    private double totalAmount;
    private Timestamp createDate;
    private int statusId;

    private String ship_fname;
    private String ship_lname;
    private String ship_email;
    private String ship_phone;
    private String ship_address;
    private String ship_country;
    private String note;

    public Order() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUId() {
        return uId;
    }

    public void setUId(int uId) {
        this.uId = uId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getShip_fname() {
        return ship_fname;
    }

    public void setShip_fname(String ship_fname) {
        this.ship_fname = ship_fname;
    }

    public String getShip_lname() {
        return ship_lname;
    }

    public void setShip_lname(String ship_lname) {
        this.ship_lname = ship_lname;
    }

    public String getShip_email() {
        return ship_email;
    }

    public void setShip_email(String ship_email) {
        this.ship_email = ship_email;
    }

    public String getShip_phone() {
        return ship_phone;
    }

    public void setShip_phone(String ship_phone) {
        this.ship_phone = ship_phone;
    }

    public String getShip_address() {
        return ship_address;
    }

    public void setShip_address(String ship_address) {
        this.ship_address = ship_address;
    }

    public String getShip_country() {
        return ship_country;
    }

    public void setShip_country(String ship_country) {
        this.ship_country = ship_country;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
