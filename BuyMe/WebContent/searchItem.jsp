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
Find an item by name<input type="text" name="item_name"/>
<br/>
<br/>
Condition:
<br/>
<input type="radio" name="condition" value="excellent">Excellent<br>
<input type="radio" name="condition" value="good">Good<br>
<input type="radio" name="condition" value="average">Average<br>
<input type="radio" name="condition" value="poor">Poor<br>
<br/>
Price:
<br/>
Min: <input type="text" name="min_price"/>
Max: <input type="text" name="max_price"/>
<br/>
<br/>
Brand: <select name="brand">
		<option>BrandName1</option>
		<option>BrandName2</option>
		<option>BrandName3</option>
		<option>BrandName4</option>
</select>
<br/>
<br/>

<input type="submit" value="Submit">
</form>

</body>
</html>