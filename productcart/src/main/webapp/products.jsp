<%@page import="java.util.List" %>
<%@page import="com.productcart.connection.DbCon" %>
<%@page import="productcart.dao.ProductDao" %>
<%@page import="com.productcart.model.*" %>
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
    %>
    
<!DOCTYPE html>
<html>
<head>
<title>Products</title>

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
      
        </div>
    </div>
</div>

	<%}
	}%>



</div>

</div> 
<%@include file="includes/footer.jsp" %>
</body>
</html>