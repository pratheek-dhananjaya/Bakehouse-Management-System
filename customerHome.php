<?php
	session_start(); 
	if(isset($_SESSION['loginUser'])){
		echo "<title>".$_SESSION['loginUser']."</title>";
	}
	else{
		header("Location:logout.php");
	}

?>
<!DOCTYPE html>
<html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
	<link rel='stylesheet' href="css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


</head> 
<body>

	<div class="topStyle">
		<h2 style="color:#f2ed9d;">Bakehouse Management</h2>
		<a class='userNameDisplay'>Welcome, <?php echo $_SESSION['loginUser']; ?></a>
	</div>
	<div class='sidebar'>
		<button onclick="location.href='customerHome.php'">Home</button>
		<button onclick="location.href='viewProductsCustomer.php'">View Products</button>
		<button onclick="location.href='order.php'">Order</button>
		<button onclick="location.href='cart.php'">Cart</button>
		<button onclick="location.href='customerViewTransactions.php'">My Transactions</button>
		<button onclick="location.href='logout.php'">Logout</button>
	</div>
<div class='container'>

	<fieldset><legend><b>You can</b></legend>
<p>- View Products
- Order Products
- View Transactions
</p>
</fieldset>
</div>

</body>
</html>
