package productcart.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;

import com.productcart.connection.DbCon;
import com.productcart.model.Cart;
import com.productcart.model.Order;
import com.productcart.model.User;

import productcart.dao.OrderDao;


@WebServlet("/checkout")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try(PrintWriter out = response.getWriter()){
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
		
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			
			User auth = (User) request.getSession().getAttribute("auth");
	     
			if(cart_list !=null && auth !=null) {
				
				for(Cart c:cart_list) {
					
					  Order orders = new Order();
	                    orders.setUid(auth.getId());
	                    orders.setId(c.getId()); // Product ID
	                    orders.setQuantity(c.getQuantity());
	                    orders.setDate(LocalDate.now());
	                    orders.setImage(c.getImage());
	                    orders.setPrice(c.getPrice() * c.getQuantity());

				
					OrderDao oDao = new OrderDao(DbCon.getConnection());
					oDao.insertOrder(orders);
					
				}
				cart_list.clear();
				response.sendRedirect("orders.jsp");
				
			}else {
				if(auth == null)response.sendRedirect("login.jsp");
				response.sendRedirect("cart.jsp");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
