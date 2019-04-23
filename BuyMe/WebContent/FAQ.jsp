<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="functions.AskQuestionServlet"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<%--
 * auction.jsp
 *
 * Copyright (c) 2019
 * All rights reserved.
 *
 * Rutgers University: School of Arts and Sciences
 * 01:198:336 Principles of Information and Data Management, Spring 2019
 * Professor Miranda Garcia
--%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe - eCommerce</title>
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

	<%
	String user = (String) session.getAttribute("currentSessionUser");
	
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
			<%
			String user = (String) session.getAttribute("currentSessionUser");
			
			if(user != null) { %>
	  		 <div class="AskQ">
				<br><h3 align="center">Ask a Question!</h3>
			</div>
			
			<div style="Display: ">
				<form action="askQuestionServlet" method="post" enctype="multipart/form-data">
				<p align="center">Question: <input type="text" name="regQuestion" required></input> <button class="btn alt"><b>Submit</b></button></p>
				</form>
			</div>
			
			<hr width="100%">
			<%}%>
	
			<div style="Display :">
				<p align="center"><b>Frequently Asked Questions</b></p>
				<ul>
					<li>- How long will shipping take?</li><br>
					<li><small><i>Shipping will usually take 5-7 business days once the bidding ends.</i></small></li><br>
					<li>- What payment methods do you accept?</li><br>
					<li><small><i>We accept Paypal, most credit/debit cards, and bank-to-bank transfers. </i></small></li><br>
					<li>- Do you have to have an account to sell or bid on an item?</li><br>
					<li><small><i>Yes, you must create an account before attempting to sell or bid on an item. </i></small></li><br>
				</ul>
				
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