
package model;


public class Category {
    private int id;
    private String cateName;

    public Category() {
    }

    public Category(int id, String cateName) {
        this.id = id;
        this.cateName = cateName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }
}