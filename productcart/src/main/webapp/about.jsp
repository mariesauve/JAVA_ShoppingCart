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
           totalPrice += item.getPrice(); // Calculate total price of cart items
       }
   }
%>
<!DOCTYPE html>
<html>
<head>
<title>About</title>

<style>
  #carouselExampleDark {
    max-height: 400px; /* Set the maximum height of the carousel */
    overflow: hidden; /* Prevent overflow of the content */
  }

  #carouselExampleDark img {
    object-fit: cover; /* Ensure images fill their containers */
    height: 100%; /* Match the height of the carousel */
  }

  .carousel-inner {
    height: 400px; /* Match the carousel's height */
  }

  /* Carousel and Image Adjustments */
  #carouselExampleDark {
      max-height: 400px; /* Define the height for the carousel */
      overflow: hidden;
  }

  #carouselExampleDark img {
      object-fit: cover; /* Ensures images fill the carousel area */
      height: 400px; /* Consistent height */
      width: 100%; /* Full width */
  }

  /* Caption Styles */
  .carousel-caption {
      color: white; /* Text color */
      background: rgba(0, 0, 0, 0.2); /* Translucent black background for contrast */
      padding: 10px; /* Add padding inside captions */
      border-radius: 5px; /* Rounded corners for aesthetic */
      bottom: 20px; /* Position captions closer to the bottom */
  }
  
  .carousel-control-prev-icon, .carousel-control-next-icon {
  		background: rgba(0, 0, 0, 0.5); 
  		 color: white;
  		 border-radius: 10px;
  }
  
  #button {
  margin-left: 5px;
  }
</style>


<%@include file="includes/head.jsp" %>
<%@include file="includes/navbar.jsp" %>

</head>
<body>
<div id="carouselExampleDark" class="carousel carousel-dark slide">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active" data-bs-interval="10000">
      <img src="images/stained-glass-cake.png" class="d-block w-100" alt="First slide">
      <div class="carousel-caption d-none d-md-block">
        <h5 style="color:white">Sweet Marie's</h5>
        <p style="color:white">A journey from cake decorator to developer</p>
      </div>
    </div>
    <div class="carousel-item" data-bs-interval="2000" >
      <img src="images/strawberry-fruit-cake-fresh-strawberry-wooden-table.jpg" class="d-block w-100" alt="Second slide">
      <div class="carousel-caption d-none d-md-block">
        <h5 style="color:black; ">Second Slide Label</h5>
        <p style="color:black">Some representative placeholder content for the second slide.</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="images/batmancakecoopy.png" class="d-block w-100" alt="Third slide">
      <div class="carousel-caption d-none d-md-block">
        <h5 style="color:white">Third Slide Label</h5>
        <p style="color:white">Some representative placeholder content for the third slide.</p>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next"  type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
<br/>
<button popovertarget="my-popover" id="button" >Click</button>

<div popover id="my-popover"  style="position: position: sticky; top: 0;">Happy Winter Holidays!</div>


<div class="container">
<div class="card-header my-3">All Products
</div>
<div class="row">
<%
if(!products.isEmpty()) {
	for(Product p:products){%>
		
		
<div class="col-md-3"  style="margin-top:10px;">
    <div class="card">
        <img src="images/<%= p.getImage()%>" style="width:auto; height: 250px; object-fit: fill;" class="card-img-top" alt="<%= p.getName()%>">
             
    
        <div class="card-body">
            <h5 class="card-title"><%= p.getName()%></h5>
         
            <h5 class="category">Category: <%= p.getCategory()%></h5>
     
        </div>
    </div>
</div>

	<%}
	}%>



</div>
<br/>
<%@include file="includes/pagination.jsp" %>


<%@include file="includes/footer.jsp" %>
</body>
</html>