<%@page import="java.util.*" %>
<%@page import="com.shoppingcart.connection.DbCon" %>
<%@page import="com.shoppingcart.model.*" %>
<%@page import="shoppingcart.doa.ProductDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
   User auth = (User) request.getSession().getAttribute("auth");
   if(auth != null){
       request.setAttribute("auth", auth);
   }

   ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
   List<Cart> cartProduct = null;
   double totalPrice = 0.0;

   if(cart_list != null) {
       ProductDao pDao = new ProductDao(DbCon.getConnection());
       cartProduct = pDao.getCartProducts(cart_list);
       request.setAttribute("cart_list", cart_list);

       for(Cart item : cartProduct) {
           totalPrice += item.getPrice(); // Calculate total price of cart items
       }
   }
%>

<!DOCTYPE html>
<html>
<head>
<title>Cart</title>
<%@include file="includes/head.jsp" %>
<style type="text/css">
.table tbody td {
	vertical-align: middle;
}

.btn-incre, .btn-decre {
	box-shadow: none;
	font-size: 25px;
}

.form-group .form-control {
	width: 60px;
	text-align: center;
}
</style>
</head>
<body>
<%@include file="includes/navbar.jsp" %>
<div class="container">
	<div class="d-flex py-3">
		<h3>Total Price: $<%= String.format("%.2f", totalPrice) %></h3> 
		<a class="mx-3 btn btn-primary" href="cart-check-out">Check out</a>
	</div>
	<table class="table table-light">
		<thead>
			<tr>
				<th scope="col">Name</th>
				<th scope="col">Category</th>
				<th scope="col">Price</th>
				<th scope="col">Quantity</th>
				<th scope="col">Buy Now</th>
				<th scope="col">Cancel</th>
			</tr>
		</thead>
		<tbody>
		<%
		if(cartProduct != null && !cartProduct.isEmpty()) {
			for(Cart c : cartProduct) { %>
				<tr>
					<td><%= c.getName() %></td>
					<td><%= c.getCategory() %></td>
					<td>$<%= String.format("%.2f", c.getPrice()) %></td>
					<td>
						<form action="order-now" method="post" class="form-inline">
						<input type="hidden" name="id" value="<%= c.getId() %>" class="form-input">
						<div class="form-group d-flex justify-content-between">
						<a class="btn btn-sm btn-decre" href="quantity-Inc-Dec?action=dec&id=<%=c.getId()%>"><i class="fas fa-minus-square"></i></a>
						<input type="text" name="quantity" class="form-control w-50" value="<%= c.getQuantity() %>" readonly>
						<a class="btn btn-sm btn-incre" href="quantity-Inc-Dec?action=inc&id=<%=c.getId()%>"><i class="fas fa-plus-square"></i></a>
						</div>
						
						</form>
						
					</td>
					<td><button type="submit" class="btn btn-primary btn-sm">Buy</button></td>
					<td><a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%=c.getId() %>">Remove</a></td>
				</tr>
			<%
			}
		} else { %>
			<tr>
				<td colspan="5" class="text-center">Your cart is empty.</td>
			</tr>
		<% } %>
		</tbody>
	</table>
	
</div>

<%@include file="includes/footer.jsp" %>
</body>
</html>
