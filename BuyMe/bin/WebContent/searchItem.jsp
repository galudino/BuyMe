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
<input type="radio" name="condition" value="New">New<br>
<input type="radio" name="condition" value="Like New">Like New<br>
<input type="radio" name="condition" value="Excellent">Average<br>
<input type="radio" name="condition" value="Good">Good<br>
<input type="radio" name="condition" value="Poor">Poor<br>
<br/>
<p>
Brand: 
<input type="checkbox" name="brand" value="Adidas">Adidas<br>
<input type="checkbox" name="brand" value="New Balance">New Balance<br>
<input type="checkbox" name="brand" value="Nike">Nike<br>
<input type="checkbox" name="brand" value="Sketchers">Sketchers<br>
</p>
<br/>
<p>
Color:
<input type="checkbox" name="color" value="Black">Black<br>
<input type="checkbox" name="color" value="Brown">Brown<br>
<input type="checkbox" name="color" value="Tan">Tan<br>
<input type="checkbox" name="color" value="Blue">Blue<br>
<input type="checkbox" name="color" value="Purple">Purple<br>
<input type="checkbox" name="color" value="Red">Red<br>
<input type="checkbox" name="color" value="Pink">Pink<br>
<input type="checkbox" name="color" value="White">White<br>

</p>
<p>Size (US MEN):<br>
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
<br/>

<input type="submit" value="Submit">
</form>

</body>
</html>