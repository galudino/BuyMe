<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe - eCommerce</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>  
   <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script> 
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>

<body>

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

<div class="subheader">
	<a href="index.jsp"><img src="data\img\project\logo.png"></a>
</div>

<div class="content">
	<hr width="100%">
	<%-- BEGIN ITEM/AUCTION LISTING --%>
<h1>CREATE NEW ITEM/AUCTION</h1>

	<%-- BEGIN ITEM LISTING --%>
	<h2>ITEM INFORMATION</h2>
	
	<p>Item/Listing Name<br>
	<input type="text">

	<p>Description<br>
	<textarea rows="10" cols="28">(enter description here)</textarea>

	<p>Condition<br>
	<select>
		<option>(unspecified)</option>
		<option>New</option>
		<option>Like New</option>
		<option>Excellent</option>
		<option>Good</option>
		<option>Poor</option>
	</select>
	
	<p>Manufacturer/Brand<br>
	<input type="text">
	
	<p>Size (US Men's)<br>
	<select>
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
	</select>
	
	<p>Color<br>
	<select>
		<option>Black</option>
		<option>Grey</option>
		<option>Brown</option>
		<option>Tan</option>
		<option>Blue</option>
		<option>Purple</option>
		<option>Red</option>
		<option>Pink</option>
		<option>White</option>
	</select>

	<form action="someplace.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<legend>Upload image file</legend>
			<label for="uploadfile">File name: </label>
			<input type="file" name="uploadfile" id="uploadfile">
		</fieldset>
	</form>
	<%--END ITEM LISTING --%>

	
	<%-- BEGIN AUCTION LISTING --%>
	<h2>AUCTION INFORMATION/SETTINGS</h2>
		
	<p>Start Date<br>
	<input type="date" name="date">
	<script>

	</script>
	
	<p>End Date<br>
	<input type="date" name="date">
	<script>

	</script>
	

	<p>Bid Increment ($x.xx)<br>
	<input type="text">
	
	<p>Minimum Bid Permitted ($x.xx)<br>
	<input type="text">
	
	<p>Starting Price ($x.xx)<br>
	<input type="text">
	
	</p>
	<%-- END AUCTION LISTING --%>
	
<p>
<button type="button">Submit</button>
</p>

<div class="footer">
	<hr>
	

	<div class="container well">
		<p>Footer things to add later...</p>
	</div>

	
</div>


<%-- END ITEM/AUCTION LISTING --%>
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
 
 