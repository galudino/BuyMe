<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Item Results</title>
</head>
<body>
<% Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://cs336buyme.cnnvlun9z7yl.us-east-2.rds.amazonaws.com:3306";


Connection conn = DriverManager.getConnection(url, "cs336buyme", "Rutgers123");

PreparedStatement ps = null;
ResultSet rs = null;

String searchQuery= "SELECT auction_id.has_item, item_id.has_item, name.has_item, brand.has_item, condition.has_item, amount.bid"
                    + " FROM AUCTION auction,"
                    + " Bid bid"
                    + "WHERE auction_id.auction = auction_id.bid";

String itemName = request.getParameter("item_name");
String condition = request.getParameter("condition");
String min_price = request.getParameter("min_price");
String max_price = request.getParameter("max_price");
String brand = request.getParameter("brand");

if (!itemName.equals("")){
	searchQuery = searchQuery + " AND name.has_item = " + itemName;
}
searchQuery = searchQuery + " And condition.has_item = " + condition;
if (!min_price.equals("")){
	searchQuery = searchQuery + " And amount.bid > " + min_price;
}
if (!min_price.equals("")){
	searchQuery = searchQuery + " And amount.bid <= " + max_price;
}
if (!brand.equals("")){
	searchQuery = searchQuery + " And brand.hasItem = " + brand;
}

searchQuery = searchQuery + ";";

ps = conn.prepareStatement(searchQuery);

rs = ps.executeQuery();

if (rs.next()){ %>
<h2> Item Search Results</h2>
<br/>
	<table>
		<tr>
			<th>Auction ID</th>
			<th>Item ID</th>
			<th>Item Name</th>
			<th>Brand</th>
			<th>Condition</th>
			<th>Price</th>
		</tr>
		<% do {%> 
		<tr>
			<td><%= rs.getInt(1)%></td>
			<td><%= rs.getString(2)%></td>
			<td><%= rs.getString(3)%></td>
			<td><%= rs.getString(4)%></td>
			<td><%= rs.getString(5) %></td>
			<td><%= rs.getInt(6)%></td>
		</tr>
		<% } while(rs.next());%>
	</table>
<%
} else {
	out.println("<p>No search results matching your parameters</p>");
}

ps.close();
rs.close();
conn.close();%>

</body>
</html>