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

	<%
		String user = (String) session.getAttribute("currentSessionUser");
		if (user == null)
			response.sendRedirect("login.jsp");
		
		String auction_id = request.getParameter("auction_id");
		
		String alertsInfo[] = null;
		
		
		
		
		try {
			DBConnect c = new DBConnect();
			Connection conn = c.getConnection();

			conn.connect(function(err));
			{
				  if (err) throw err;
				  // if connection is successful
				  con.query("INSERT INTO ALERTS (username) values (user)"); {
				   //  if any error while executing above query, throw error
				    if (err) throw err;
				    // if there is no error, you have the result
				    console.log(result);
				  };
				};
			

		
		
		
		
		try {
			DBConnect c = new DBConnect();
			Connection conn = c.getConnection();

			Statement statement = conn.createStatement();

			ResultSet auctionSet = null;
			auctionSet = statement.executeQuery("SELECT * FROM AUCTION WHERE auction_id = " + auction_id);
			ResultSetMetaData auctionMetaData = auctionSet.getMetaData();
			alertsInfo = new String[auctionMetaData.getColumnCount()];
	
			System.out.println(auctionMetaData.getColumnCount());

			if (auctionSet.next()) {

				for (int i = 0; i < auctionMetaData.getColumnCount(); i++) {
					alertsInfo[i] = auctionSet.getString(auctionMetaData.getColumnName(1 + i));
				}
			}
			
			conn.close();
			auctionSet.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		
		
		
		try {
			DBConnect c = new DBConnect();
			Connection conn = c.getConnection();

			conn.connect(function(err));
			{
				  if (err) throw err;
				  // if connection is successful
				  con.query("INSERT INTO ALERTS (auction_id) values (auction_id)"); {
				   //  if any error while executing above query, throw error
				    if (err) throw err;
				    // if there is no error, you have the result
				    console.log(result);
				  };
				};
		
	
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
	
<script>

try{
	var today = new Date();
	var dd = String(today.getDate()).padStart(2, '0');
	var mm = String(today.getMonth() + 1).padStart(2, '0');
	var yyyy = today.getFullYear();
	today= mm + '/' + dd + '/' + yyyy;
}
	//finally
	//{
	//document.write(today); 
	//}


</script>

<script>

var a = ["SELECT * FROM AUCTION(auction_id)"];
for(auction_id==a){
	var i = ["SELECT * FROM AUCTION(usernames)"];//create an array of usernames in auction table with this auction id
}
for(int i=0, i<array.length, i++){
	String x = "INSERT INTO ALERTS(usernames[i] + auction_id + "A higher bid was placed on an iten you bid on!");
	execute.statement(x);
	
}

</script>

<script>

for(user){
	al = ("SELECT * FROM ALERTS(alert_id))");
	for(al=1, al<al.length, al++){
		notifs = ("SELECT * FROM ALERTS(messages)");
		document.write(notifs);
	}
	}
		}
		
		
</script>



















   //if(auction_startingPrice > amount){ //if current bid is higher than your bid is placed
    	//create a statement of what the alert would say and insert into alerts table
    	//document.write("Someone placed a bid higher than your bid on an item");
  // }}
   
   //if(today == end_date) {
	//   document.write("An item you bid on has been sold!");
 //  }
//   }

	
</div>

<div class="footer">
	<hr>
	
	<div class="container well">
		<p>Footer things to add later...</p>
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