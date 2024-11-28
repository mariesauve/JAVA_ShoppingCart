// Utility for Conversion
package com.productcart.util;

import com.productcart.model.Cart;
import com.productcart.model.Order;

import java.time.LocalDate;

public class OrderUtils {
    public static Order convertCartToOrder(Cart cart, int userId) {
        Order order = new Order();
        order.setOrderId(generateUniqueOrderId()); // Replace with real ID generation logic
        order.setUid(userId);
        order.setQuantity(cart.getQuantity());
        order.setDate(LocalDate.now());
        order.setPrice(cart.getPrice());
        order.setImage(cart.getImage());
        return order;
    }

    private static int generateUniqueOrderId() {
        // Simulated logic for generating a unique order ID
        return (int) (Math.random() * 100000);
    }
}
