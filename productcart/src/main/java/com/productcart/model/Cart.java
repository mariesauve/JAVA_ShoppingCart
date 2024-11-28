package com.productcart.model;

public class Cart extends Product {
    private int quantity;

    public Cart() {
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be greater than zero.");
        }
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return super.toString() + ", Cart [quantity=" + quantity + "]";
    }
}
