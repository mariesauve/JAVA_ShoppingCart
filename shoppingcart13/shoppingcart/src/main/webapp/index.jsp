<%@page import="java.util.*" %>
<%@page import="com.shoppingcart.connection.DbCon" %>
<%@page import="shoppingcart.doa.ProductDao" %>
<%@page import="com.shoppingcart.model.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
   User auth = (User)request.getSession().getAttribute("auth");
    if(auth != null){
    	request.setAttribute("auth", auth);
    }
    ProductDao pd = new ProductDao(DbCon.getConnection());
    pd.getAllProducts();
    List<Product> products = pd.getAllProducts();
    
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
<title>home</title>

<style>
.card {
    height: 400px; 
    margin-bottom: 15px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    border: 1px solid #ddd; 
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
}

.card-body {
    flex-grow: 1; 
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 15px; 
}

.card-img-top {
    width: 100%;
    height: 200px; 
    object-fit: cover;
    border-bottom: 1px solid #ddd;
}

.card-body h5 {
    margin-bottom: 10px; 
    text-align: center; 
}

.card-body .btn {
    width: 45%; 
    margin: 5px; 
}

.card-body .btn-primary {
    background-color: #007bff; 
    border: none;
}

.card-body .btn-secondary {
    background-color: #6c757d; 
    border: none;
}

</style>

<%@include file="includes/head.jsp" %>
<%@include file="includes/navbar.jsp" %>
</head>
<body>
<div class="container">
<div class="card-header my-3">All Products
</div>
<div class="row">
<%
if(!products.isEmpty()) {
	for(Product p:products){%>
		
		
<div class="col-md-3">
    <div class="card">
        <img src="images/<%= p.getImage()%>" class="card-img-top" alt="<%= p.getName()%>">
             
    
        <div class="card-body">
            <h5 class="card-title"><%= p.getName()%></h5>
            <h5 class="price">Price: $<%= String.format("%.2f", p.getPrice()) %></h5>
            <h5 class="category">Category: <%= p.getCategory()%></h5>

            <div class="mt-3 d-flex justify-content-between">
                <a href="add-to-cart?id=<%=p.getId() %>" class="btn btn-outline-primary">Add To Cart</a>
                <a href="order-now?quantity=1&id=<%=p.getId() %>" class="btn btn-outline-secondary">Buy Now</a>
                
               
            </div>
      
        </div>
    </div>
</div>

	<%}
	}%>



</div>
<%@include file="includes/pagination.jsp" %>
</div> 
<!-- out.print(p.getCategory()); -->
<%-- <% out.print(DbCon.getConnection()); %>    --%>

<%@include file="includes/footer.jsp" %>
</body>
</html>