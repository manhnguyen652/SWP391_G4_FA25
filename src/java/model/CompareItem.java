/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
public class CompareItem {
    private int id;
    private int compareId; // Sửa từ order_id
    private int bId;

    // Constructors
    public CompareItem() {
    }

    public CompareItem(int id, int compareId, int bId) {
        this.id = id;
        this.compareId = compareId;
        this.bId = bId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCompareId() {
        return compareId;
    }

    public void setCompareId(int compareId) {
        this.compareId = compareId;
    }

    public int getBId() {
        return bId;
    }

    public void setBId(int bId) {
        this.bId = bId;
    }
}