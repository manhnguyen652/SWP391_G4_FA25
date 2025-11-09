/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class BookImage {
    private int id;
    private String imgUrl;
    private int bId; 

    // Constructors
    public BookImage() {
    }

    public BookImage(int id, String imgUrl, int bId) {
        this.id = id;
        this.imgUrl = imgUrl;
        this.bId = bId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public int getBId() {
        return bId;
    }

    public void setBId(int bId) {
        this.bId = bId;
    }
}