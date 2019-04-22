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

String searchQuery= "SELECT item.item_id, item.name, item.description, item.item_condition, item.brand, item.color, item.size"
                    + " from ITEM item";

String itemName = request.getParameter("item_name");
String condition = request.getParameter("condition");
String min_price = request.getParameter("min_price");
String max_price = request.getParameter("max_price");
String[] brands = request.getParameterValues("brand");
String[] colors = request.getParameterValues("color");
String[] sizes = request.getParameterValues("size");

String temp = "";

if (!itemName.equals("")){	
	String str = "'" + itemName + "'";
	temp = temp + " where item.name = " + str;
}
if (condition != null){
	String str = "";
	if (!temp.equals("")){
		str = "'" + condition + "'";
		temp = temp + " and item.item_condition = " + str;
	} else {
		str = "'" + condition + "'";
		temp = temp + " where item.item_condition = " + str;
	}
}
if (brands != null && brands.length > 0){
	if (!temp.equals("")){
		temp = temp + " and ( ";
	} else {
		temp = temp + " where ( ";
	}
	int counter = 0;
	for (int i = 0; i < brands.length; i++){
		if (!brands[i].equals("") && i < brands.length){
			String str;
			if (counter == 0){
				str = " item.brand = '" + brands[i] + "'";
				temp = temp + str;
			} else {
				str = " Or" +" item.brand = '" + brands[i] + "'";
				temp = temp + str;
			}
			counter++;		
		}
	}
	temp = temp + " )";
}
if (colors != null && colors.length > 0){
	if (!temp.equals("")){
		temp = temp + " and ( ";
	} else {
		temp = temp + " where ( ";
	}
	int counter = 0;
	for (int i = 0; i < colors.length; i++){
		if (!colors[i].equals("") && i < colors.length){
			String str;
			if (counter == 0){
				str = " item.color = '" + colors[i] + "'";
				temp = temp + str;
			} else {
				str = " Or" +" item.color = '" + colors[i] + "'";
				temp = temp + str;
			}
			counter++;		
		}
	}
	temp = temp + " )";
}
if (sizes != null && sizes.length > 0){
	if (!temp.equals("")){
		temp = temp + " and ( ";
	} else {
		temp = temp + " where ( ";
	}
	int counter = 0;
	for (int i = 0; i < sizes.length; i++){
		if (!sizes[i].equals("") && i < sizes.length){
			String str;
			if (counter == 0){
				str = " item.size = '" + sizes[i] + "'";
				temp = temp + str;
			} else {
				str = " Or" +" item.size = '" + sizes[i] + "'";
				temp = temp + str;
			}
			counter++;		
		}
	}
	temp = temp + " )";
}



searchQuery = searchQuery + temp + ";";

out.println(searchQuery);

ps = conn.prepareStatement(searchQuery);

rs = ps.executeQuery();

if (rs.next()){ %>
<h2> Item Search Results</h2>
<br/>
	<table>
		<tr>
			<th>Item ID</th>
			<th>Item Name</th>
			<th>Description</th>
			<th>Condition</th>
			<th>Brand</th>
			<th>Color</th>
			<th>Size</th>
		</tr>
		<% do {%> 
		<tr>
			<td><%= rs.getInt(1)%></td>
			<td><%= rs.getString(2)%></td>
			<td><%= rs.getString(3)%></td>
			<td><%= rs.getString(4)%></td>
			<td><%= rs.getString(5) %></td>
			<td><%= rs.getString(6)%></td>
			<td><%= rs.getDouble(7)%></td>
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