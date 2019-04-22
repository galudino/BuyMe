<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Browse Auctions and Items</title>
</head>
<body>
<form action="searchItemHandler.jsp">
<p> Find an item by name: <input type="text" name="item_name"/></p>

<p> Condition:</p>
<input type="radio" name="condition" value="excellent">Excellent<br>
<input type="radio" name="condition" value="good">Good<br>
<input type="radio" name="condition" value="average">Average<br>
<input type="radio" name="condition" value="poor">Poor<br>
<br/>
Price:
<br/>
<p>Min: <input type="text" name="min_price"/>
Max: <input type="text" name="max_price"/></p>
<p>
Brand: 
<input type="checkbox" name="brand" value="Brand 1">Brand 1
<input type="checkbox" name="brand" value="Brand 2">Brand 2
<input type="checkbox" name="brand" value="Brand 3">Brand 3
<input type="checkbox" name="brand" value="Brand 4">Brand 4
</p>
<br/>
<br/>

<input type="submit" value="Submit">
</form>

</body>
</html>