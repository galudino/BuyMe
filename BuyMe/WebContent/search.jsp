<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search</title>
</head>
<style>
fieldset {
  padding: 1em;
  font:80%/1 sans-serif;
  border:1px solid black;
  }
legend {
  padding: 0.2em 0.5em;
  border:1px solid black;
  color:black;
  font-size:15pt;
  background-color: #DCDCDC;
  color: 8F8887;
 }

</style>
<body>
<form action="searchHistoryHandler.jsp">
	<fieldset>
		<legend>Search an User's Buying/Selling History: </legend>
			<p>Enter an user's name: <input type="text" name="username"/></p>
			<p>View an user's buying or selling history:</p>
			<input type="radio" name="history" value="bidding">Bidding<br>
			<input type="radio" name="history" value="selling">Selling<br>
			<p><input type="submit" value="Submit"></p>
	</fieldset>
</form>
<br>
<form action ="searchItemHandler.jsp">
	<fieldset>
		<legend>Search Item: </legend>
		<p>Find an item by name: <input type="text" name="item_name"/></p>
		<p>Condition:</p>
			<input type="radio" name="condition" value="New">New<br>
			<input type="radio" name="condition" value="Like New">Like New<br>
			<input type="radio" name="condition" value="Excellent">Average<br>
			<input type="radio" name="condition" value="Good">Good<br>
			<input type="radio" name="condition" value="Poor">Poor<br>
		<p>Brand:</p>
			<input type="checkbox" name="brand" value="Adidas">Adidas<br>
			<input type="checkbox" name="brand" value="New Balance">New Balance<br>
			<input type="checkbox" name="brand" value="Nike">Nike<br>
			<input type="checkbox" name="brand" value="Sketchers">Sketchers<br>
		<p>Color:</p>
			<input type="checkbox" name="color" value="Black">Black<br>
			<input type="checkbox" name="color" value="Brown">Brown<br>
			<input type="checkbox" name="color" value="Tan">Tan<br>
			<input type="checkbox" name="color" value="Blue">Blue<br>
			<input type="checkbox" name="color" value="Purple">Purple<br>
			<input type="checkbox" name="color" value="Red">Red<br>
			<input type="checkbox" name="color" value="Pink">Pink<br>
			<input type="checkbox" name="color" value="White">White<br>
		<p>Size:</p>
			<input type="checkbox" name="size" value="4">4<br>
			<input type="checkbox" name="size" value="4.5">4.5<br>
			<input type="checkbox" name="size" value="5">5<br>
			<input type="checkbox" name="size" value="5.5">5.5<br>
			<input type="checkbox" name="size" value="6">6<br>
			<input type="checkbox" name="size" value="6.5">6.5<br>
			<input type="checkbox" name="size" value="7">7<br>
			<input type="checkbox" name="size" value="7.5">7.5<br>
			<input type="checkbox" name="size" value="8">8<br>
			<input type="checkbox" name="size" value="8.5">8.5<br>
			<input type="checkbox" name="size" value="9">9<br>
			<input type="checkbox" name="size" value="9.5">9.5<br>
			<input type="checkbox" name="size" value="10">10<br>
			<input type="checkbox" name="size" value="10.5">10.5<br>
			<input type="checkbox" name="size" value="11">11<br>
			<input type="checkbox" name="size" value="11.5">12<br>
			<input type="checkbox" name="size" value="12">11<br>
			<input type="checkbox" name="size" value="12.5">12.5<br>
			<input type="checkbox" name="size" value="13">13<br>
			<input type="checkbox" name="size" value="13">13.5<br>
			<input type="checkbox" name="size" value="14">14<br>
			<input type="checkbox" name="size" value="14.5">14.5<br>
		<p><input type="submit" value="Submit"></p>
	</fieldset>
</form>
<br>
<form action="bidHistoryHandler.jsp">
	<fieldset>
		<legend>View all the history of bids for an Auction: </legend>
		<p>Enter an auction ID: <input type="text" name="auction_id"/></p>
		<p><input type="submit" value="Submit"></p>
	</fieldset>
</form>
</body>
</html>