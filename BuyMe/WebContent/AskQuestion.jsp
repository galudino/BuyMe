<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="connection.DBConnect"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe - AskQuestion</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>

<body>

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
	   <div class="AskQ">
				<br><h3>Ask a Question!</h3>
		</div>
		<div style="Display: ">
				<form method="post" action="AskQuestion.jsp">
				<p>Username: <input type="text" placeholder="Enter Username" name="regUsername" required></p>
				<p>Question: <input type="text" placeholder="Enter Question" name="regQuestion" required></p></p>
			    <button type="button"><b>Submit</b></button>
	<ul class="content">
		<li><a class="dt" id="dt"></a></li><br>
	</ul>
				</form>
	
			</div>
	
	<div class="footer">
	<hr>
	
	<div class="container well">
		<p>Footer things to add later...</p>
	</div>
	
</div>
	
	
</div>

<% 
try {
		DBConnect c = new DBConnect();
		Connection conn = c.getConnection();
		Statement statement = conn.createStatement();
		
		String newUsername = request.getParameter("regUsername");
		String newQuestion = request.getParameter("regQuestion");
		
		System.out.println(newUsername + " " + newQuestion);
		
	if(newUsername.equals(" ") || newQuestion.equals(" ") ) {
	%>
		<script>
				alert("Sorry. Please fill out all fields!");
				window.location.href = "#";
			</script>
			<%
		}

	String insert = "INSERT INTO QUESTIONS(username, question)" + "VALUES (?, ?)";
		PreparedStatement ps = conn.prepareStatement(insert);
		ps.setString(1, newUsername);
		ps.setString(2, newQuestion);
		
		int x = ps.executeUpdate();
		System.out.println(x);
		
	//	ps.executeUpdate();
		
		conn.close();
		
		session.setAttribute("username", newUsername);
		session.setAttribute("question", newQuestion);
	%>
		<script>
			alert("Your question has been submitted! Your question will be answered by a customer rep in the FAQs page shortly.");
			window.location.href ="FAQ.jsp";
		</script>
		<%
		
		System.out.println(newUsername + " " + newQuestion);
		
	 } catch (Exception e) {
		System.out.println("ERROR: " + e.getMessage());
	}
	
	%>



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