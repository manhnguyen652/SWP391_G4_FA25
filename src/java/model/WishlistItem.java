
package model;

public class WishlistItem {
    private int id;
    private int wishlistId;
    private int bId;

    // Constructors
    public WishlistItem() {
    }

    public WishlistItem(int id, int wishlistId, int bId) {
        this.id = id;
        this.wishlistId = wishlistId;
        this.bId = bId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getWishlistId() {
        return wishlistId;
    }

    public void setWishlistId(int wishlistId) {
        this.wishlistId = wishlistId;
    }

    public int getBId() {
        return bId;
    }

    public void setBId(int bId) {
        this.bId = bId;
    }
}