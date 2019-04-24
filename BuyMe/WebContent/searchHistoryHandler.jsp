<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Buying/Selling History</title>
<link rel="stylesheet" type="text/css" href="css/style.css"> 
<link rel="stylesheet" type="text/css" href="css/searchItemHandler.css">
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

<div align="center">
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
			out.println("<h2 align='center'>" + user_id + "'s Selling History</h2>"); %>
			<table id="search">
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
		ps = conn.prepareStatement("select b.bid_id, b.auction_id, b.item_id, b.bid_amount, b.status from BID b where b.username = ? ;");
		ps.setString(1, user_id);
		rs = ps.executeQuery();
		
		if (rs.next()){ 
			out.println("<h2>" + user_id + "'s Bidding History</h2>");
		%>
		<table id="search">
			<tr>
				<th>Bid ID</th>
				<th>Auction ID</th>
				<th>Item ID</th>
				<th>Amount</th>
				<th>Status</th>
			</tr>
		<% do {%> 
				<tr>
					<td><%= rs.getInt(1)%></td>
					<td><%= rs.getInt(1)%></td>
					<td><%= rs.getInt(3)%></td>
					<td><%= rs.getInt(4)%></td>
					<td><%if ((rs.getInt(5)==0)){out.println("Ongoing");}else{out.println("Ended");}%></td>
				</tr>
			<% } while(rs.next());%>
		</table>	
		<%} else {%>
			<h3>No Bidding history for this user</h3>
		<%		
		}
	}
	ps.close();
	rs.close();
}

conn.close(); 
%>
</div>

</div>

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



</body>

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