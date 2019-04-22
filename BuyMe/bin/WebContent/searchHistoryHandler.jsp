<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Buying/Selling History</title>
</head>
<body>
<%
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://cs336buyme.cnnvlun9z7yl.us-east-2.rds.amazonaws.com:3306";


Connection conn = DriverManager.getConnection(url, "cs336buyme", "Rutgers123");

String username = request.getParameter("username");
String history = request.getParameter("history");

if (username == null){
	out.print("<p>User not found</p>");
	out.print("<p class=\"message\">Go back to search page? <a href=\"searchHistory.jsp\">Go back</a></p>");
	
}else {
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	if(history == "selling"){
		ps = conn.prepareStatement("SELECT item_id.has_item, name.has_item, description.has_item, condition.has_item"
				                   + " FROM HAS_ITEM has_item"
				                   + " WHERE auction_id.has_item in ("
				                   + " SELECT auction_id.creates"
				                   + " FROM CREATES creates"
				                   + " Where user_id.creates = ?)");
		ps.setString(1, username);
		rs = ps.executeQuery();
		
		if (rs.next()){
			out.println("<h2>" + username + "'s Selling History</h2>"); %>
			<table>
				<tr>
					<th>Item ID</th>
					<th>Name</th>
					<th>Description</th>
					<th>Condition</th>
				</tr>
			<% do {%> 
				<tr>
					<td><%= rs.getString(1)%></td>
					<td><%= rs.getString(2)%></td>
					<td><%= rs.getString(3)%></td>
					<td><%= rs.getString(4)%></td>
				</tr>
			<% } while(rs.next());%>
			</table>	
		<%} else { %>
			<h3>No selling history found for this user</h3>
		<%
		}
	}else {
		ps = conn.prepareStatement("SELECT auction_id.auction, title.auction, amount.auction, start_time.auction, date_time.auction"
				                  +" FROM AUCTION auction"
				                  +" WHERE auction_id.auction in ("
				                  +" SELECT auction_id.bid"
				                  +" FROM BID bid"
				                  +" WHERE user_id = ?)");
		ps.setString(1, "username");
		rs = ps.executeQuery();
		
		if (rs.next()){ 
			out.println("<h2>" + username + "'s Bidding History</h2>");
		%>
		<table>
			<tr>
				<th>Auction ID</th>
				<th>Title</th>
				<th>Amount</th>
				<th>Start Time</th>
				<th>End_time</th>
			</tr>
		<% do {%> 
				<tr>
					<td><%= rs.getInt(1)%></td>
					<td><%= rs.getString(2)%></td>
					<td><%= rs.getInt(3)%></td>
					<td><%= rs.getTimestamp(4)%></td>
					<td><%= rs.getTimestamp(5) %></td>
				</tr>
			<% } while(rs.next());%>
		</table>	
		<%} else {%>
			<h3>No Bidding (Auction) history for this user</h3>
		<%		
		}
	}
	ps.close();
	rs.close();
}

conn.close(); 
%>

</body>
</html>