package com.productcart.model;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;

public class Order extends Product {
    private int order_id;
    private int user_id;
    private int quantity;
    private LocalDate date;
    private String image;
    private double price;

    public Order() {
    }

    public Order(int order_Id, int user_id, int product_id, LocalDate date, String image, int quantity, double price) {
        this.order_id = order_Id;
        this.user_id = user_id;
        setQuantity(quantity); 
        setDate(date);
        this.image = image;
        setPrice(price); 
    }

    public int getOrderId() {
        return order_id;
    }

    public void setOrderId(int order_Id) {
        this.order_id = order_Id;
    }

    public int getUserId() {
        return user_id;
    }

    public void setUid(int user_id) {
        this.user_id = user_id;
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

    public void setDate(LocalDate date2) {
        this.date = date2;
    }

    public void setDate(String date) {
        try {
            this.date = LocalDate.parse(date); // Assumes date is in yyyy-MM-dd format
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Invalid date format. Expected yyyy-MM-dd.");
        }
    }

    public LocalDate getDate() {
        return date;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        if (price < 0) {
            throw new IllegalArgumentException("Price cannot be negative.");
        }
        this.price = Math.round(price * 100.0) / 100.0;
    }

    @Override
    public String toString() {
        return super.toString() + ", Order [order_id=" + order_id + ", user_id=" + user_id + ", quantity=" + quantity + 
               ", date=" + date + ", image=" + image + ", price=" + price + "]";
    }
}