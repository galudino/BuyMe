<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe - AdminCP: Generate Report</title>
<link rel="stylesheet" type="text/css" href="css/style.css">              
</head>

<body>

	<%
		String user = (String) session.getAttribute("currentSessionAdmin");

		if (user == null)
			response.sendRedirect("index.jsp");
			
	%>

	<div class="header-container">
		<div class="TopMenu">
			<ul class="social">
				<li><a href="https://twitter.com/RutgersU"><img
						src="data\img\social\twitter.png" height="25px" width="25px"></a></li>
				<li><a href="https://www.facebook.com/RutgersU"><img
						src="data\img\social\facebook.png" height="25px" width="25px"></a></li>
				<li><a href="https://www.instagram.com/RutgersU"><img
						src="data\img\social\instagram.png" height="25px" width="25px"></a></li>
			</ul>

			<ul class="Links">
				<li><a class="dt" id="dt"></a></li><br>
				<li class="links">Welcome <%=user%>!</li>
				<li class="links"><a href="generate_report.jsp">Generate</a></li>
				<li class="links"><a href="create_custrep.jsp">Create Cust. Rep</a></li>
				<li class="links"><a href="tools/logout.jsp">Logout</a></li>
			</ul>
		</div>
	</div>

<div class="subheader">
	<a href="admin_cp.jsp"><img src="data\img\project\logo.png"></a>
</div>

<div class="content">
	<hr width="100%">

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