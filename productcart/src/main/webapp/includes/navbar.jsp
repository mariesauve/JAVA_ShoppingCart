<nav class="navbar navbar-expand-lg bg-primary" data-bs-theme="dark">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
      <a class="navbar-brand" href="index.jsp">Sweet Marie's Cakes</a>
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="items.jsp">Items</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="about.jsp">About</a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="contact.jsp">Contact</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="cart.jsp">Cart <span class="badge text-bg-light px1">${cart_list.size()}</span></a>
        </li>
				<%
			
				if (auth != null) {
				%>

				<li class="nav-item"><a class="nav-link" href="orders.jsp">Order</a></li>
				<li class="nav-item"><a class="nav-link" href="log-out">Logout</a></li>
				<%
				} else {
				%>
				<li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
				<%
				}
				%>

			</ul>
    </div>
  </div>
</nav>
<br/>
