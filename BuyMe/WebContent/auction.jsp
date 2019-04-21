<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="connection.DBConnect"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
		
	String auction_id = request.getParameter("auction_id");
	String item_id = auction_id;
	String base64Image = null;
	
	String auctionInfo[] = null;
	String itemInfo[] = null;
	
	try {
		
		DBConnect c = new DBConnect();
		Connection conn = c.getConnection();
		Statement statement = conn.createStatement();
		ResultSet auctionSet = null;
		ResultSet itemSet = null;
		
		auctionSet = statement.executeQuery("SELECT * FROM AUCTION WHERE auction_id = " + auction_id);	
		
		ResultSetMetaData auctionMetaData = auctionSet.getMetaData();
		//ResultSetMetaData itemMetaData = itemSet.getMetaData();
		
		auctionInfo= new String[auctionMetaData.getColumnCount()];
		//itemInfo = new String[itemMetaData.getColumnCount()];
		
		System.out.println(auctionMetaData.getColumnCount());
		
		if(auctionSet.next()) {
		
			for(int i = 1; i < auctionMetaData.getColumnCount(); i++) {
				auctionInfo[i] = auctionSet.getString(auctionMetaData.getColumnName(i));
			}
		}
		
        Blob blob = auctionSet.getBlob("photo");
        
        System.out.println(blob);
        
        InputStream inputStream = blob.getBinaryStream();
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
         
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);                  
        }
         
        byte[] imageBytes = outputStream.toByteArray();
        base64Image = Base64.getEncoder().encodeToString(imageBytes);
        
        System.out.println(base64Image);
		
		//if(itemSet.next()) {
			
		//	for(int i = 1; i <= itemMetaData.getColumnCount(); ++i) {
		//		itemInfo[i] = itemSet.getString(itemMetaData.getColumnName(i));
		//	}
		//}
        conn.close();
        auctionSet.close();
      //  itemSet.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
	
	try {
		
		DBConnect c = new DBConnect();
		Connection conn = c.getConnection();
		Statement statement = conn.createStatement();
		ResultSet itemSet = null;
	
		itemSet = statement.executeQuery("SELECT * FROM ITEM WHERE item_id = " + auction_id);
	
		ResultSetMetaData itemMetaData = itemSet.getMetaData();

		itemInfo = new String[itemMetaData.getColumnCount()];
	
		System.out.println(itemMetaData.getColumnCount());
	
		if(itemSet.next()) {
		
			for(int i = 1; i <= itemMetaData.getColumnCount(); ++i) {
				itemInfo[i] = itemSet.getString(itemMetaData.getColumnName(i));
			}
		}
    	
		conn.close();
    	itemSet.close();
		} catch (Exception ex) {
			ex.printStackTrace();
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
	
	<table>
		<tr>
			<td><img style="border:2px solid #9a9a9a" src="data:image/jpg;base64,<%=base64Image%>" width="400" height="300"/></td>
			<td><H2 style="padding-left: 20px;" style="vertical-align: top;"><%out.println("      "+ auctionInfo[4] + ""); %></H2>
			<p style="padding-left: 20px;"><b>Description</b>: <%out.println(itemInfo[3]);%>
			<br><b>Brand/Manufacturer:</b> <%out.println(itemInfo[5]);%>
			<br><b>Item Condition</b>: <%out.println(itemInfo[2]);%>
		</p>
			</td>
			
		</tr>
	</table>
	
	


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
 
 