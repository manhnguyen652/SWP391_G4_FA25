package model;

public class Book {
    private int bId;
    private String bTitle;
    private String description;
    private int publicationYear;
    private double price;
    private int stock;
    private int pId; // publisher_id
    private int aId; // author_id
    private int imageId; // cover_image_id
    private int cId; // category_id

    // Constructors
    public Book() {
    }

    public Book(int bId, String bTitle, String description, int publicationYear, double price, int stock, int pId, int aId, int imageId, int cId) {
        this.bId = bId;
        this.bTitle = bTitle;
        this.description = description;
        this.publicationYear = publicationYear;
        this.price = price;
        this.stock = stock;
        this.pId = pId;
        this.aId = aId;
        this.imageId = imageId;
        this.cId = cId;
    }

    // Getters and Setters
    public int getBId() {
        return bId;
    }

    public void setBId(int bId) {
        this.bId = bId;
    }

    public String getBTitle() {
        return bTitle;
    }

    public void setBTitle(String bTitle) {
        this.bTitle = bTitle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPublicationYear() {
        return publicationYear;
    }

    public void setPublicationYear(int publicationYear) {
        this.publicationYear = publicationYear;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getPId() {
        return pId;
    }

    public void setPId(int pId) {
        this.pId = pId;
    }

    public int getAId() {
        return aId;
    }

    public void setAId(int aId) {
        this.aId = aId;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getCId() {
        return cId;
    }

    public void setCId(int cId) {
        this.cId = cId;
    }
}