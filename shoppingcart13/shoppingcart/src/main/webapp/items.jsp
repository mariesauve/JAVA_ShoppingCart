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
<meta charset="UTF-8">
<title>Products</title>
<%@include file="includes/head.jsp" %>
<%@include file="includes/navbar.jsp" %>

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

.modal-title {
    padding: 2px;
    margin-left: 5px;
}
</style>
</head>
<body>

<div class="container mt-5">
    <div class="row">
        <%
        if (!products.isEmpty()) {
            for (Product p : products) {
                String modalId = "modal" + p.getId(); // Unique modal ID
        %>
        <!-- Individual Card -->
        <div class="col-md-3 mb-4">
            <div class="card">
                <img src="images/<%= p.getImage() %>" class="card-img-top" alt="<%= p.getName() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= p.getName() %></h5>
                    <div class="text-center">
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%= modalId %>">
                            <i class="fa-solid fa-binoculars" style="color: #b7b7b8;"></i><br/> More Info</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="<%= modalId %>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="<%= modalId %>Label" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <img src="images/<%= p.getImage() %>" class="card-img-top" alt="<%= p.getName() %>">
                        <h1 class="modal-title fs-5" id="<%= modalId %>Label"><%= p.getName() %></h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <h5 class="category">Category: <%= p.getCategory() %></h5>
                        <h5 class="price">Price: $<%= String.format("%.2f", p.getPrice()) %></h5>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <a href="add-to-cart?id=<%= p.getId() %>" class="btn btn-outline-primary">Add To Cart</a>
                    </div>
                </div>
            </div>
        </div>
        <% 
            }
        } 
        %>
    </div>
    <%@include file="includes/pagination.jsp" %>
</div>

<%@include file="includes/footer.jsp" %>

</body>
</html>
