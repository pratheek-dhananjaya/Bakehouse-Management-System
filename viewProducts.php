<?php
	session_start(); 
	if(!isset($_SESSION['loginUser'])){
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
	<title>View Products</title>


</head> 
<body>
	<div class="topStyle">
		<h2 style="color:#f2ed9d;">Bakehouse Management</h2>
		<a class='userNameDisplay'>Welcome, <?php echo $_SESSION['loginUser']; ?></a>
	</div>
	<div class='sidebar'>
		<button onclick="location.href='adminHome.php'">Home</button>
		<button onclick="location.href='viewProducts.php'">View Products</button>
		<button onclick="location.href='addStock.php'">Add Stock</button>
		<button onclick="location.href='addProduct.php'">Add New Product</button>
		<button onclick="location.href='depleted.php'">Depleted Products</button>
		<button onclick="location.href='customers.php'">Customers</button>
		<button onclick="location.href='transactions.php'">Transactions</button>
		<button onclick="location.href='logout.php'">Logout</button>
	</div>
<div class='container'>

	<fieldset><legend><b>Categories</b></legend>
		<table><tr><th>Category ID</th><th>Category Name</th></tr>
		<?php 
			$conn=mysqli_connect("localhost","root","","wholesale");
			$sql="select * from categories";
			$result=mysqli_query($conn,$sql);
			while($row=mysqli_fetch_assoc($result)){
				echo "<tr><td>".$row['category_id']."</td><td>".$row['category_name']."</td></tr>";
			}
			echo "</table><br>";
		?>
		<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method='get'>
			<input class='formInputItem' type=text name="catID" placeholder="Enter Category ID" required><input class='goBtn' type=submit name='submit' value='Go'>
		</form><br><br>
	</fieldset>
		<?php 
			if(isset($_GET['submit'])){
				$catID=$_GET['catID'];
				$sql="select * from products where category_id='$catID' and quantity>=0";
				$result=mysqli_query($conn,$sql);
				echo "<fieldset><legend><b>Products</b></legend>
					<table><tr><th>Product ID</th><th>Product Name</th><th>Price</th><th>Stock Left</th></tr>";
				while($row=mysqli_fetch_assoc($result)){
					echo "<tr><td>".$row['product_id']."</td><td>".$row['product_name']."</td><td>".$row['price']."</td><td>".$row['quantity']."</td></tr>";
				}
				echo "</table></fieldset><br>";
			}
		?>
	



</div>
</body>
</html>
