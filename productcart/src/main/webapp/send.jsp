<%@page import="java.util.*" %>
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
    
   ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
   List<Cart> cartProduct = null;
   double totalPrice = 0.0;

   if(cart_list != null) {
       ProductDao pDao = new ProductDao(DbCon.getConnection());
       cartProduct = pDao.getCartProducts(cart_list);
       request.setAttribute("cart_list", cart_list);

       for(Cart item : cartProduct) {
           totalPrice += item.getPrice(); 
       }
   }
%>
<!DOCTYPE html>
<html>
<head>

<style>
body, html {
  height: 100%;
  margin: 0;
}
.container {
  position: relative;
}

.center {
  margin: auto;
  width: 50%;
  border: 3px solid green;
  padding: 10px;
      font-family: monospace;
    font-size: 35px; 
   
}
@media screen and (max-width: 800px) {

.center {
  margin: auto;
  width: 50%;
 
  padding: 10px;
      font-family: monospace;
    font-size: 25px; 
   
}

}


</style>

<%@include file="includes/head.jsp" %>
<%@include file="includes/navbar.jsp" %>
<body>

<div class="container"><p>Message Sent Successfully!</p></div>
<div class="center"><p>groucho@mail.com</p>
<p>Hello!</p></div>
</body>
</html>