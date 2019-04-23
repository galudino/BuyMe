<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="connection.DBConnect"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe - Staff Login</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

	<%
		String user = (String) session.getAttribute("currentSessionUser");
		if (user != null) {
			session.invalidate();
		}
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
			<li class="links"><a href="login.jsp">Sign in</a> or <a href="signup.jsp">Create an Account</a></li>
		</ul>
		</div>
	</div>

	<div class="subheader">
		<a href="index.jsp"><img src="data\img\project\logo.png"></a>
	</div>

	<div class="content">
		<hr width="100%">
		
			<br><Br><br><br>
			
			<div class="SignIn" style="width: 100%;">
				<h3 align="center">Administrator & Customer Representative Login</h3>
			</div>
			<form method="post" action="staff_login.jsp">
			<div style="Display: ">
			<p align="center">Username:</p>
			<p align="center"><input style="align: center;" type="username" name="username"></input></p>
			<p align="center">Password:</p>
			<p align="center"><input type="password" name="password"></input></p>
			<p></p>
			<p align="center"><button align="center" class="btn alt">Sign In</button></p>
			</div>
			
			</form>
		</div>
		
		
			<%
	
	try {
		DBConnect c = new DBConnect();
		Connection conn = c.getConnection();
		Statement statement = conn.createStatement();
		
		String _user = request.getParameter("username");
		String _pass = request.getParameter("password");
		
		if(_user.equals("") && _pass.equals("")) {
			%>
			<script>
				alert("Please enter your username and password.");
				window.location.href = "staff_login.jsp";
			</script>
			<%
		} else if(_user.equalsIgnoreCase("admin")) {
			String adminLogin = "SELECT * FROM ADMIN a WHERE a.username='" + _user + "' and a.password='" + _pass + "'";
			ResultSet adminResult = statement.executeQuery(adminLogin);
			
			if(adminResult.next()) {
				HttpSession sess = request.getSession(true);
				sess.setAttribute("currentSessionAdmin", _user);
				%>
				<Script>
					window.location.href = "admin_cp.jsp";
				</script>
				<%	
			}
		} else {
			String custLogin = "SELECT * FROM CUSTOMER_REP c WHERE c.username='" + _user + "' and c.password='" + _pass + "'";
			ResultSet custResult = statement.executeQuery(custLogin);
			
			if(custResult.next()) {
								
				HttpSession sess = request.getSession(true);
				sess.setAttribute("currentSessionCR", _user);
				%>
				<script>
					window.location.href = "custrep_cp.jsp";
				</script>
				<%
			}
		}
		conn.close();
	} catch(Exception e) {
		//System.out.println("ERROR: " + e.getMessage());
	}
	
	%>

	<script>
		var tday = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
				"Friday", "Saturday" ];
		var tmonth = [ "January", "February", "March", "April", "May", "June",
				"July", "August", "September", "October", "November",
				"December" ];

		function GetClock() {
			var d = new Date();
			var nday = d.getDay(), nmonth = d.getMonth(), ndate = d.getDate(), nyear = d
					.getFullYear();
			var nhour = d.getHours(), nmin = d.getMinutes(), nsec = d
					.getSeconds(), ap;

			if (nhour == 0) {
				ap = " AM";
				nhour = 12;
			} else if (nhour < 12) {
				ap = " AM";
			} else if (nhour == 12) {
				ap = " PM";
			} else if (nhour > 12) {
				ap = " PM";
				nhour -= 12;
			}

			if (nmin <= 9)
				nmin = "0" + nmin;
			if (nsec <= 9)
				nsec = "0" + nsec;

			var clocktext = "" + tday[nday] + ", " + tmonth[nmonth] + " "
					+ ndate + ", " + nyear + " " + nhour + ":" + nmin + ":"
					+ nsec + ap + "";
			document.getElementById('dt').innerHTML = clocktext;
		}

		GetClock();
		setInterval(GetClock, 1000);
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