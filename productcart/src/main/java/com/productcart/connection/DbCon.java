package com.productcart.connection;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbCon {

	private static Connection connection = null;
	public static Connection getConnection() throws ClassNotFoundException, SQLException{
		if(connection == null) {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product_cart", "root", "Password123456!");
			System.out.print("connected");
		}
		return connection;
	}
	
}
