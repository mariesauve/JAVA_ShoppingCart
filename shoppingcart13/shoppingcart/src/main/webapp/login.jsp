<%@page import="com.shoppingcart.model.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
        <%
   User auth = (User)request.getSession().getAttribute("auth");
    if(auth != null){
    	// request.setAttribute("auth", auth);
    	response.sendRedirect("index.jsp");
    }
    %>
    
<!DOCTYPE html>
<html>
<head>
<title>login</title>
<%@include file="includes/head.jsp" %>
<%@include file="includes/navbar.jsp" %>
</head>
<body>
<div class="container">
<div class="card  w-50 text-grey bg-light mx-auto my5">
<div class="card-header text-center">Login</div>

<div class="card-body">
<form action="user-login" method="post">
<div class="form-group">
<label>Email Add</label>
<input type="email" class="form-control" name="login-email" placeholder="Enter email...">
<br/>
<label>Password</label>
<input type="password" class="form-control" name="login-password" placeholder="Enter password...">
<br/>
<div class="text-center">
 <button type="submit" class="btn btn-outline-primary">login</button>
 </div>
</div>
</form>
</div>
</div>

</div>
     
<%@include file="includes/footer.jsp" %>
</body>
</html>