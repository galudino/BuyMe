<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Item Results</title>
</head>
<body>
<% Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://cs336buyme.cnnvlun9z7yl.us-east-2.rds.amazonaws.com:3306/buyme";


Connection conn = DriverManager.getConnection(url, "cs336buyme", "Rutgers123");

PreparedStatement ps = null;
ResultSet rs = null;

String searchQuery= "SELECT auction.auction_id, item.item_id, item.name, item.brand, item.item_condition, bid.amount"
                    + " FROM AUCTION auction,"
                    + " ITEM item,"
                    + " BID bid"
                    + " WHERE auction.auction_id = bid.auction_id"
                    + " And item.item_id = bid.item_id";

String itemName = request.getParameter("item_name");
String condition = request.getParameter("condition");
String min_price = request.getParameter("min_price");
String max_price = request.getParameter("max_price");
String[] brands = request.getParameterValues("brand");

if (!itemName.equals("")){
	String str = "'" + itemName + "'";
	searchQuery = searchQuery + " AND item.name = " + str;
}
if (condition != null){
	String str = "'" + condition + "'";
	searchQuery = searchQuery + " AND item.item_condition = " + str;
}
if (!min_price.equals("")){
	searchQuery = searchQuery + " AND bid.amount > " + min_price;
}
if (!min_price.equals("")){
	searchQuery = searchQuery + " AND bid.amount <= " + max_price;
}
if (brands != null && brands.length > 0){
	searchQuery = searchQuery + " And ( ";
	int counter = 0;
	for (int i = 0; i < brands.length; i++){
		if (!brands[i].equals("") && i < brands.length){
			String str;
			if (counter == 0){
				str = " item.brand = '" + brands[i] + "'";
				searchQuery = searchQuery + str;
			} else {
				str = " Or" +" item.brand = '" + brands[i] + "'";
				searchQuery = searchQuery + str;
			}
			counter++;		
		}
	}
	searchQuery = searchQuery + " )";
}

searchQuery = searchQuery + ";";

out.println(searchQuery);

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