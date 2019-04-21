<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="connection.DBConnect"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="functions.FileUploadDBServlet"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%--
 * createAuction.jsp
 *
 * Copyright (c) 2019
 * All rights reserved.
 *
 * Rutgers University: School of Arts and Sciences
 * 01:198:336 Principles of Information and Data Management, Spring 2019
 * Professor Miranda Garcia
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe - eCommerce</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>

<body>

	<%	String user = (String) session.getAttribute("currentSessionUser");
		if(user == null)
			response.sendRedirect("login.jsp"); 	
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

	<div class="subheader">
		<a href="index.jsp"><img src="data\img\project\logo.png"></a>
	</div>

	<div class="content">
		<hr width="100%">

	<p align="center">Please fill out all the information to create an auction. If information is not filled out, the post will not be successful.</p>

	<form action="uploadServlet" method="post" enctype="multipart/form-data">

	<div class="grid pg_login">
	
		<div class="grid_item one-half create_acc">
			<div class="CreateAcc">
				<h3 align="center">Item Information</h3>
			</div>
			<div style="Display :" class="tessss">
				<p><b>Item Name</b>:
				<input class="borderless" type="text" name="itemName" required>

				<p><b>Description</b>:
				<textarea rows="15" cols="45" name="description" required></textarea></p>

				<p><b>Condition</b>:                     
				<select name="conditionType" required>
							<option>New</option>
							<option>Like New</option>
							<option>Excellent</option>
							<option>Good</option>
							<option>Poor</option>
				</select></p>

				<p><b>Manufacturer</b>: 
				<input class="borderless" type="text" name="manufacturer" required></p>

				<p><b>Size</b> (US Men's): 
				<select name="size" required>
					<option>4</option>		
					<option>4.5</option>
					<option>5</option>		
					<option>5.5</option>
					<option>6</option>		
					<option>6.5</option>
					<option>7</option>		
					<option>7.5</option>
					<option>8</option>		
					<option>8.5</option>
					<option>9</option>		
					<option>9.5</option>
					<option>10</option>		
					<option>10.5</option>
					<option>11</option>		
					<option>11.5</option>
					<option>12</option>		
					<option>12.5</option>
					<option>13</option>		
					<option>13.5</option>
					<option>14</option>		
					<option>14.5</option>
				</select></p>

				<p><b>Color</b>:	
				<select name="color" required>
					<option>Black</option>
					<option>Grey</option>
					<option>Brown</option>
					<option>Tan</option>
					<option>Blue</option>
					<option>Purple</option>
					<option>Red</option>
					<option>Pink</option>
					<option>White</option>
				</select></p>

						<label for="uploadfile"><b>File name</b>: <input type="file" name="photo" accept="image/*" size="50" required/></label>
			</div>
		</div>
		
		<div class="grid_item one-half sign_in">
			<div class="SignIn">
				<h3 class="h3move">Auction Information</h3>
			</div>
			<div style="Display :" >

				<p><b>Start Date</b>:
				<input class="borderless" type="datetime-local" name="startDate" required></p>
	
				<p><b>End Date</b>:
				<input class="borderless" type="datetime-local" name="endDate" required></p>
	
				<p><b>Bid Increment</b>: 
				<input class="borderless" type="text" name="bidIncrement" required></p>
	
				<p><b>Minimum Bid Permitted</b>: 
				<input class="borderless" type="text" name="minBid" required></p>
	
				<p><b>Starting Price</b>:
				<input class="borderless" type="text" name="startingPrice" required></p>
				
				<p class="h3move"><button class="btn alt" value="Save">Create Auction</button></p>
			</div>
		</div>
	</div>
	
	</form>
	
	<br><Br>
<div class="footer">
	<hr>
	

	<div class="container well">
		<p>Footer things to add later...</p>
	</div>

		
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
</html>
 
 