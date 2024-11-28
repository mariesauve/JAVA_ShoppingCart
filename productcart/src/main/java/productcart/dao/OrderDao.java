package productcart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.productcart.model.Order;
import com.productcart.model.Product;

public class OrderDao {
    private Connection con;
    private String query;
	private PreparedStatement pst;
	private ResultSet rs;

    public OrderDao(Connection con) {
        this.con = con;
    }


    public boolean insertOrder(Order orders) {
    	 boolean result = false;
    	 try { query = "INSERT INTO `product_cart`.`orders` (order_id, product_id, user_id, quantity, date, image, price) VALUES (?, ?, ?, ?, ?, ?, ?)";
       pst = this.con.prepareStatement(query);
            pst.setInt(1, orders.getOrderId());
            pst.setInt(2, orders.getId());
            pst.setInt(3, orders.getUserId());
            pst.setInt(4, orders.getQuantity());
            pst.setDate(5, java.sql.Date.valueOf(orders.getDate()));
            pst.setString(6, orders.getImage());
            pst.setDouble(7, orders.getPrice());
            int rowsInserted = pst.executeUpdate();
	        if (rowsInserted > 0) {
	            result = true; 
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
    }

    public List<Order> userOrder(int userId) {
        List<Order> list = new ArrayList<>();
        try { query = "SELECT * FROM from orders where order_id=? ORDER BY order_id DESC";

         pst = con.prepareStatement(query); 
            pst.setInt(1, userId);
            rs = pst.executeQuery();
              
                while(rs.next()) {
    				Order orders = new Order();
    				ProductDao productDao = new ProductDao(this.con);

                   
                    int productId = rs.getInt("product_id");

            
                    Product product = productDao.getSingleProduct(productId);
                    if (product != null) {
                        orders.setOrderId(rs.getInt("order_id"));
                        orders.setId(productId);
                        orders.setName(product.getName());
                        orders.setCategory(product.getCategory());
                        orders.setPrice(product.getPrice() * rs.getInt("quantity"));
                        orders.setQuantity(rs.getInt("quantity"));
                        orders.setDate(rs.getDate("date").toLocalDate());
                        orders.setImage(product.getImage());
                    } else {
                        // Handle missing product
                        orders.setOrderId(rs.getInt("order_id"));
                        orders.setId(productId);
                        orders.setName("Unknown Product");
                        orders.setCategory("Unknown Category");
                        orders.setPrice(0);
                        orders.setQuantity(rs.getInt("quantity"));
                        orders.setDate(rs.getDate("date").toLocalDate());
                        orders.setImage(rs.getString("image"));
                    }
                    list.add(orders);
                }
    			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
		
	}
	public void cancelOrder(int id) {
		try {
			query = "delete from orders where order_id=?";
			pst=this.con.prepareStatement(query);
			pst.setInt(1, id);
			pst.execute();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
