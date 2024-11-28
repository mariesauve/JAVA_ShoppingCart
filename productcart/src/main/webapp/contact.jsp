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

.bgimg {

  background-image: url("images/batmancakecoopy.png");
  background-position: center;
  background-size: cover;
  height: 100vh;
  position: relative;
  color: white;
  font-family: "Courier New", Courier, monospace;
  font-size: 25px;
}

.topleft {
  position: absolute;
  top: 0;
  left: 16px;
  font-weight: bold;
}

.bottomleft {
  position: absolute;
  bottom: 0;
  left: 16px;
  color: white;
}

.text-center {
  font-weight: bold;
  padding: 25px;
}

.bottomCenter {
  position: absolute;
  bottom: 0;
  left: 16px;
  color: white;
  padding-bottom: 15px;
  text-align: center;
}

.middle {
  text-align: center;
  background-color: hsla(9, 100%, 64%, 0.2);
  font-weight: bold;
  padding: 15px;
  border-radius: 15px;
  margin-top: 20px; 
}


@media screen and (max-width: 500px) {

:root {
   --bs-gradient: linear-gradient(to right, #FFA07A, #FFD700);
}

  .bgimg {
   background-image: var(--bs-gradient);
    
    background-position: center;
    background-size: cover;
    height: 70vh; 
    position: relative;
    color: white;
    font-family: monospace;
    font-size: 15px; 
    opacity: 90%;
  }
  
  .middle {
  text-align: center;
  background-color: hsla(9, 100%, 64%, 0.9);
  font-weight: bold;
  padding: 15px;
  border-radius: 15px;
  margin-top: 20px; 
}
  
}

</style>

<%@include file="includes/head.jsp" %>
<%@include file="includes/navbar.jsp" %>
<body>

<div class="bgimg"> 
    <div class="topleft">
        <p>Contact Us</p>
    </div>
  
    
    <div class="text-center">
        <form action="send.jsp" method="post">
            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">Email address</label>
                <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="name@example.com" required>
            </div>
            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">Message Us</label>
                <textarea class="form-control" id="exampleFormControlTextarea1" placeholder="Talk to us!" rows="6" required></textarea>
            </div> 
            <button type="submit" name="id" class="btn btn-sm btn-danger">Send</button>
        </form>
    </div>

    <!-- Cake Shop Information -->
    <div class="middle">
        <h1>Cake Shop</h1>
        <br/>
        <p>222-333-4444</p>
        <br/>
        <p>25 Somewhere Drive</p>
        <br/>
        <p>Ontario, Canada</p>
    </div>
</div>

<br/>
<%@include file="includes/pagination.jsp" %>

<%@include file="includes/footer.jsp" %>

</body>
</html>
