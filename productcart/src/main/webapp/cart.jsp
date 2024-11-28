<%@page import="java.util.*" %>
<%@page import="com.productcart.connection.DbCon" %>
<%@page import="com.productcart.model.*" %>
<%@page import="productcart.dao.ProductDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   User auth = (User) request.getSession().getAttribute("auth");
   if(auth != null){
       request.setAttribute("auth", auth);
   }

   ArrayList<Cart> cartList = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
   System.out.println("Cart List: " + cartList);
                     
   List<Cart> cartProduct = null;
   double totalPrice = 0.0;

   if(cartList != null) {
       ProductDao pDao = new ProductDao(DbCon.getConnection());
       cartProduct = pDao.getCartProducts(cartList);
       request.setAttribute("cart_list", cartList);

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
  @media (max-width: 768px) {
        .table tbody td {
            font-size: 14px; 
        }
        .form-control {
            width: 50px; 
        }
        img {
            width: 100px;
        }
    }
</style>
</head>
<body>
<%@include file="includes/navbar.jsp" %>
<div class="container">
    <div class="row py-3">
        <div class="col-md-8 col-12">
            <h3>Total Price: $<%= String.format("%.2f", totalPrice) %></h3>
        </div>
        <div class="col-md-4 col-12 text-end">
            <a class="btn btn-primary" href="<%= request.getContextPath() %>/checkout">Check out</a>
      
                  </div>
    </div>
    <div class="table-responsive">
        <table class="table table-light">
            <thead>
                <tr>
                    <th scope="col">Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Price</th>
                    <th scope="col">Image</th>
                    <th scope="col">Quantity</th>
                      <th scope="col">Buy Now</th>
                    <th scope="col">Cancel</th>
                </tr>
            </thead>
            <tbody>
            <% if (cartProduct != null && !cartProduct.isEmpty()) {
                   for (Cart c : cartProduct) { %>
				<tr>
					<td><%= c.getName() %></td>
					<td><%= c.getCategory() %></td>
					<td>$<%= String.format("%.2f", c.getPrice()) %></td>
					<td>
                        <img class="img-fluid img-thumbnail" src="<%=request.getContextPath() %>/images/<%= c.getImage() %>" alt="Thumbnail for <%=c.getName() %>" style="width:150px; height: 100px;">
                    </td>
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
					<td><a class="btn btn-sm btn-danger" href="order-now?id=<%=c.getId() %>">Buy</a></td>

					<td><a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%=c.getId() %>">Remove</a></td>
				</tr>
            <%  }} else { %>
                <tr>
                    <td colspan="6" class="text-center">Your cart is empty.</td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>


<%@include file="includes/footer.jsp" %>
</body>
</html>
