<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List" %>
<%@page import="com.shoppingcart.connection.DbCon" %>
<%@page import="com.shoppingcart.model.*" %>
<%@page import="shoppingcart.doa.ProductDao" %>
<%@page import="shoppingcart.doa.OrderDao" %>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%
    User auth = (User)request.getSession().getAttribute("auth");
     List<Order> orders = null;
    if(auth!=null){
    	request.setAttribute("auth", auth);
    	orders = new OrderDao(DbCon.getConnection()).userOrder(auth.getId());
    }else{
    	response.sendRedirect("login.jsp");
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>)session.getAttribute("cart-list");
   if(cart_list != null){
	   request.setAttribute("cart_list", cart_list);
   }
    %>
<!DOCTYPE html>
<html>
<head>
<title>Order</title>
<%@include file="includes/head.jsp" %>
</head>
<body>
<%@include file="includes/navbar.jsp" %>
 
<div class="container">
<h2>All Orders</h2>
	<table class="table table-light">
	<thead>
	<tr>
	<th scope="col"> Date</th>
	<th scope="col"> Name</th>
	<th scope="col"> Category</th>
	<th scope="col"> Quantity</th>
	<th scope="col"> Price</th>
	<th scope="col"> Cancel</th>
	</tr>
	</thead>
	<tbody>
	<%if(orders !=null){
		for(Order o:orders){%>
		<tr>
		<td><%= o.getDate() %></td>
		<td><%= o.getName() %></td>
		<td><%= o.getCategory() %></td>
		<td><%= o.getQuantity() %></td>
		<td>$<%= String.format("%.2f", o.getPrice()) %></td>
		 <td><a class="btn btn-sm btn-danger" href="cancel-order?id=<%= o.getOrderId() %>">Cancel</a></td>
		</tr>
			
		<% }
 
		
	} %>
	
	
</tbody>
</table>
<%@include file="includes/pagination.jsp" %>
</div>
<%@include file="includes/footer.jsp" %>
</body>
</html>