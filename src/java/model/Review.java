package model;

import java.sql.Date;

public class Review {
    private int reviewId;
    private int bookId;
    private int userId;
    private String userName;
    private int rating;
    private String comment;
    private Date createdDate;
    
    public Review() {
    }
    
    public Review(int reviewId, int bookId, int userId, String userName, int rating, String comment, Date createdDate) {
        this.reviewId = reviewId;
        this.bookId = bookId;
        this.userId = userId;
        this.userName = userName;
        this.rating = rating;
        this.comment = comment;
        this.createdDate = createdDate;
    }
    
    public Review(int bookId, int userId, int rating, String comment) {
        this.bookId = bookId;
        this.userId = userId;
        this.rating = rating;
        this.comment = comment;
    }
    
    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }
    
    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }
    
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public String getComment() {
        return comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public Date getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
}

