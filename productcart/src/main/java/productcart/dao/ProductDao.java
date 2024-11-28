package productcart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import com.productcart.model.Cart;
import com.productcart.model.Product;

public class ProductDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public ProductDao(Connection con) {
		this.con = con;
	}
	
	public List<Product> getAllProducts() {
	    List<Product> products = new ArrayList<>();
	    String query = "SELECT * FROM products";
	    try (PreparedStatement pst = con.prepareStatement(query); ResultSet rs = pst.executeQuery()) {
	        while (rs.next()) {
	            Product product = new Product();
	            product.setId(rs.getInt("id"));
	            product.setName(rs.getString("name"));
	            product.setCategory(rs.getString("category"));
	            product.setPrice(rs.getDouble("price"));
	            product.setImage(rs.getString("image"));
	            products.add(product);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return products;
	}

	public List<Cart> getCartProducts(ArrayList<Cart> cartList){
		List<Cart> products = new ArrayList<Cart>();
		try {
			if(cartList.size() > 0) {
				for(Cart item : cartList) {
					query = "select * from products where id = ?";  // Ensure table name matches database
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					if(rs.next()) {
						Cart row = new Cart();
						row.setId(rs.getInt("id"));
						row.setName(rs.getString("name"));
						row.setCategory(rs.getString("category"));  // Ensure category is set
						row.setImage(rs.getString("image"));
						row.setPrice(rs.getDouble("price") * item.getQuantity());
						row.setQuantity(item.getQuantity());
						products.add(row);
					}
				}
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return products;
	}

	public Product getSingleProduct(int id) {
		Product row = null;
		try {
			query = "select * from products where id=?";
			pst=this.con.prepareStatement(query);
			pst.setInt(1, id);
			rs= pst.executeQuery();
			
			while(rs.next()) {
				row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getDouble("price"));
				
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return row;
		
	}
}
