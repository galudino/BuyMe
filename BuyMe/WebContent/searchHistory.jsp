<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search An User's Selling/Bidding History</title>
</head>
<body>

<form action="searchHistoryHandler.jsp">
Enter an user's name: <input type="text" name="username"/>
<br/>
<br/>
View an user's buying or selling history:
<br/>
<br/>
<input type="radio" name="history" value="bidding">Bidding<br>
<input type="radio" name="history" value="selling">Selling<br>
<br/>
<input type="submit" value="Submit">
</form>



 
</body>
</html>