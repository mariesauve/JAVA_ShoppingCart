package shoppingcart.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import com.shoppingcart.model.Cart;

@WebServlet("/quantity-Inc-Dec")
public class QuantityIncDecServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
 
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            int id = Integer.parseInt(request.getParameter("id"));
 
            // Retrieve the cart list from session
            ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
 
            if (action != null && id > 0 && cart_list != null) {
                // Perform increment action
                if (action.equals("inc")) {
                    for (Cart c : cart_list) {
                        if (c.getId() == id) {
                            c.setQuantity(c.getQuantity() + 1);  // Increment quantity
                            break;
                        }
                    }
                }
 
                // Perform decrement action
                else if (action.equals("dec")) {
                    for (Cart c : cart_list) {
                        if (c.getId() == id && c.getQuantity() > 1) {
                            c.setQuantity(c.getQuantity() - 1);  // Decrement quantity
                            break;
                        }
                    }
                }
 
                // Redirect after the action is performed
                response.sendRedirect("cart.jsp");
            } else {
                // Redirect to cart page if the action is invalid or ID is not greater than 0
                response.sendRedirect("cart.jsp");
            }
        }
    }
}