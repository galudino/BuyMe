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
<link rel="stylesheet" type="text/css" href="css/searchItemHandler.css">
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<% if (session.getAttribute("currentSessionUser") == null) { %>
    	<div class="header-container">
	<div class="TopMenu">
		<ul class="social">
			<li><a href="https://twitter.com/RutgersU"><img src="data\img\social\twitter.png" height="25px" width="25px"></a></li>
			<li><a href="https://www.facebook.com/RutgersU"><img src="data\img\social\facebook.png" height="25px" width="25px"></a></li>
			<li><a href="https://www.instagram.com/RutgersU"><img src="data\img\social\instagram.png" height="25px" width="25px"></a></li>
		</ul>
		
		<ul class="Links">
			<li><a class="dt" id="dt"></a></li><br>
			<li class="links"><a href="login.jsp">Sign in</a> or <a href="signup.jsp">Create an Account</a></li>
		</ul>
	</div>
</div>

<% } else {%>

	<%	String user = (String) session.getAttribute("currentSessionUser");
	
	if(user == null)
		response.sendRedirect("index.jsp"); 
		
	%>

    	<div class="header-container">
	<div class="TopMenu">
		<ul class="social">
			<li><a href="https://twitter.com/RutgersU"><img src="data\img\social\twitter.png" height="25px" width="25px"></a></li>
			<li><a href="https://www.facebook.com/RutgersU"><img src="data\img\social\facebook.png" height="25px" width="25px"></a></li>
			<li><a href="https://www.instagram.com/RutgersU"><img src="data\img\social\instagram.png" height="25px" width="25px"></a></li>
		</ul>
		
		<ul class="Links">
			<li><a class="dt" id="dt"></a></li><br>
			<li class="links">Welcome <%=user%>!</li>
			<li class="links"><a href="createAuction.jsp">Sell</a></li>
			<li class="links"><a href="tools/logout.jsp">Logout</a></li>
		</ul>
	</div>
</div>

<% } %>

<div class="subheader">
	<a href="index.jsp"><img src="data\img\project\logo.png"></a>
</div>

<div class="content">
	<hr width="100%">

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



ps = conn.prepareStatement(searchQuery);

rs = ps.executeQuery();

if (rs.next()){ %>
<h2 align="center"> Item Search Results</h2>
<br/>
	<div align="center">
	<table id="search">
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
	</div>
<%
} else {
	out.println("<p>No search results matching your parameters</p>");
}

ps.close();
rs.close();
conn.close();%>
</div>
</body>

<script>
	var tday=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
	var tmonth=["January","February","March","April","May","June","July","August","September","October","November","December"];

	function GetClock(){
		var d=new Date();
		var nday=d.getDay(),nmonth=d.getMonth(),ndate=d.getDate(),nyear=d.getFullYear();
		var nhour=d.getHours(),nmin=d.getMinutes(),nsec=d.getSeconds(),ap;

		if(nhour == 0) {	
			ap=" AM";
			nhour = 12;
		} else if(nhour < 12) {
			ap=" AM";
		} else if(nhour == 12){
			ap=" PM";
		} else if(nhour > 12){
			ap=" PM";
			nhour -= 12;
		}

		if(nmin<=9) 
			nmin="0"+nmin;
		if(nsec<=9) 
			nsec="0"+nsec;

		var clocktext=""+tday[nday]+", "+tmonth[nmonth]+" "+ndate+", "+nyear+" "+nhour+":"+nmin+":"+nsec+ap+"";
		document.getElementById('dt').innerHTML=clocktext;
	}

	GetClock();
	setInterval(GetClock,1000);
</script>

<div class="footer" style="width: 60%;">
	<hr>
	
	<div class="container well">
		<table style="width: 100%;">
			<tr>
				<th style="width: 33%"><u>ABOUT BuyMe</u></th>
				<th style="width: 33%"><u>LINKS</u></th>
				<th style="width: 33%"><u>CONTACT</u></th>
			</tr>
			<tr>
				<td style="width: 33%; align: center; text-align: center;">BuyMe is an online auction website that allows users to experience an auction website like no other. An easy user experience to ensure 100% satisfaction between customers. Active customer staff to assist with any issues that may arise.</td>
				<td style="width: 33%; align: center; text-align: center;"><a href="staff_login.jsp">Staff Login</a><br>Meet the Team<br><a href="FAQ.jsp">F.A.Q</a><br><a href="https://twitter.com/RutgersU">Twitter</a> | <a href="https://www.facebook.com/RutgersU">Facebook</a>  | <a href="https://www.instagram.com/RutgersU">Instagram</a> </td>
				<td style="width: 33%; align: center; text-align: center;"><b>BuyMe LLC</b><br>Rutgers University<br>New Brunswick, NJ<br>P: (123) 456-7890</td>
			</tr>
		</table>
	</div>
	
</div>
</html>