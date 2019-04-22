<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Buying/Selling History</title>
<link rel="stylesheet" type="text/css" href="css/searchHistoryHandler.css">
</head>
<body>
<%
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://cs336buyme.cnnvlun9z7yl.us-east-2.rds.amazonaws.com:3306/buyme";


Connection conn = DriverManager.getConnection(url, "cs336buyme", "Rutgers123");

String user_id = request.getParameter("username");
String history = request.getParameter("history");

if (user_id == null || user_id.equals("")){
	out.print("<p>User not found</p>");
	out.print("<p class=\"message\">Go back to search page? <a href=\"searchHistory.jsp\">Go back</a></p>");
	
}else {
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	if(history.equals("selling")){
		ps = conn.prepareStatement("select a.auction_id, a.start_time, a.end_time, a.title, a.starting_price"
				                  +" from AUCTION a"
				                  +" where a.user_id = ?");
		ps.setString(1, user_id);
		rs = ps.executeQuery();
		
		if (rs.next()){
			out.println("<h2>" + user_id + "'s Selling History</h2>"); %>
			<table>
				<tr>
					<th>Auction ID</th>
					<th>Start Time</th>
					<th>End Time</th>
					<th>Title</th>
					<th>Price</th>
				</tr>
			<% do {%> 
				<tr>
					<td><%= rs.getInt(1)%></td>
					<td><%= rs.getTimestamp(2)%></td>
					<td><%= rs.getTimestamp(3)%></td>
					<td><%= rs.getString(4)%></td>
					<td><%= rs.getInt(5)%></td>
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
			out.println("<h2>" + user_id + "'s Bidding History</h2>");
		%>
		<table>
			<tr>
				<th>Auction ID</th>
				<th>Title</th>
				<th>Amount</th>
				<th>Start Time</th>
				<th>End time</th>
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