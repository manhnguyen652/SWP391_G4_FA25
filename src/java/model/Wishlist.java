
package model;

public class Wishlist {
    private int id;
    private int uId;

    // Constructors
    public Wishlist() {
    }

    public Wishlist(int id, int uId) {
        this.id = id;
        this.uId = uId;
    }

    // Getters and Setters
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
}