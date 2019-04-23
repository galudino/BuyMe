<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe - eCommerce</title>
<link rel="stylesheet" type="text/css" href="css/style.css">  

<style type="text/css">
    input.test {
       float:left;
          width:100px;
   }
 </style>            
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

<form action="searchItemHandler.jsp">
<p align="center"> Find an item by name: <input type="text" name="item_name"/></p>

<table style="width: 100%;">
	<tr>
		<td class="test" width="50%" style="padding-left: 25%">
		<p> Condition:</p>
			<input type="radio" name="condition" value="New">New<br>
			<input type="radio" name="condition" value="Like New">Like New<br>
			<input type="radio" name="condition" value="Excellent">Average<br>
			<input type="radio" name="condition" value="Good">Good<br>
			<input type="radio" name="condition" value="Poor">Poor
		</td>
		
		<td class="test" width="50%" style="padding-right: 25%">
		Brand: <br>
			<input type="checkbox" name="brand" value="Adidas">Adidas<br>
			<input type="checkbox" name="brand" value="New Balance">New Balance<br>
			<input type="checkbox" name="brand" value="Nike">Nike<br>
			<input type="checkbox" name="brand" value="Sketchers">Sketchers<br>
		</td>
	</tr>
	<tr>
		<td class="test" width="50%" style="padding-left: 25%">
		Color:<br>
			<input type="checkbox" name="color" value="Black">Black<br>
			<input type="checkbox" name="color" value="Brown">Brown<br>
			<input type="checkbox" name="color" value="Tan">Tan<br>
			<input type="checkbox" name="color" value="Blue">Blue<br>
			<input type="checkbox" name="color" value="Purple">Purple<br>
			<input type="checkbox" name="color" value="Red">Red<br>
			<input type="checkbox" name="color" value="Pink">Pink<br>
			<input type="checkbox" name="color" value="White">White<br>
		</td>
		
		<td width="50%">
		
			<table>
				<tr>
					<td class="test" width="50%">
								Size (US MEN):<br>
<input type="checkbox" name="size" value="4">4<br>
<input type="checkbox" name="size" value="4.5">4.5<br>
<input type="checkbox" name="size" value="5">5<br>
<input type="checkbox" name="size" value="5.5">5.5<br>
<input type="checkbox" name="size" value="6">6<br>
<input type="checkbox" name="size" value="6.5">6.5<br>
<input type="checkbox" name="size" value="7">7<br>
<input type="checkbox" name="size" value="7.5">7.5<br>
<input type="checkbox" name="size" value="8">8<br>
<input type="checkbox" name="size" value="8.5">8.5<br>
<input type="checkbox" name="size" value="9">9<br>
					</td>
					<td class="test" width="50%">
					<br>
<input type="checkbox" name="size" value="9.5">9.5<br>
<input type="checkbox" name="size" value="10">10<br>
<input type="checkbox" name="size" value="10.5">10.5<br>
<input type="checkbox" name="size" value="11">11<br>
<input type="checkbox" name="size" value="11.5">11.5<br>
<input type="checkbox" name="size" value="12">12<br>
<input type="checkbox" name="size" value="12.5">12.5<br>
<input type="checkbox" name="size" value="13">13<br>
<input type="checkbox" name="size" value="13">13.5<br>
<input type="checkbox" name="size" value="14">14<br>
<input type="checkbox" name="size" value="14.5">14.5<br>
					</td>
				</tr>
			
			</table>
		
		</td>
	</tr>
</table>

<p align="center">
<input type="submit" value="Submit">
</p>
</form>


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