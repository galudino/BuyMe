<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="connection.DBConnect"%>
<%@ page import="java.lang.*,java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="functions.FileUploadDBServlet"%>
<%@ page import="functions.BidDBServlet"%>

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
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>

<body>

	<%
		String user = (String) session.getAttribute("currentSessionUser");

		if (user == null)
			response.sendRedirect("index.jsp");

		String auction_id = request.getParameter("auction_id");
		String item_id = auction_id;
		String base64Image = null;

		String auctionInfo[] = null;
		String itemInfo[] = null;
		
		int startingPrice = 0;
		int minBid = 0;
		int bidIncrement = 0;
			
		try {
			DBConnect c = new DBConnect();
			Connection conn = c.getConnection();

			Statement statement = conn.createStatement();

			ResultSet auctionSet = statement.executeQuery("SELECT * FROM AUCTION WHERE auction_id = " + auction_id);

			ResultSetMetaData auctionMetaData = auctionSet.getMetaData();
			//ResultSetMetaData itemMetaData = itemSet.getMetaData();

			auctionInfo = new String[auctionMetaData.getColumnCount()];
			//itemInfo = new String[itemMetaData.getColumnCount()];

			System.out.println(auctionMetaData.getColumnCount());

			if (auctionSet.next()) {

				for (int i = 0; i < auctionMetaData.getColumnCount(); i++) {
					auctionInfo[i] = auctionSet.getString(auctionMetaData.getColumnName(1 + i));
				}
			}
			
			
			startingPrice = auctionSet.getInt(6);
			minBid = auctionSet.getInt(5);
			bidIncrement = auctionSet.getInt(7);
			
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

			if (itemSet.next()) {
				for (int i = 0; i < itemMetaData.getColumnCount(); i++) {
					itemInfo[i] = itemSet.getString(itemMetaData.getColumnName(1 + i));
				}
			}

			conn.close();
			itemSet.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		final String auction_startDate = auctionInfo[1];
		final String auction_endDate = auctionInfo[2];
		final String auction_itemName = auctionInfo[3];
		final String auction_minBid = auctionInfo[4];
		final String auction_startingPrice = auctionInfo[5];
		final String auction_bidIncrement = auctionInfo[6];

		final String item_conditionType = itemInfo[1];
		final String item_description = itemInfo[2];
		final String item_name = itemInfo[3];
		final String item_manufacturer = itemInfo[4];
		final String item_size = itemInfo[5];
		final String item_color = itemInfo[6];
		
		
		System.out.println("minBid is " + minBid);
		System.out.println("startingPrice is " + startingPrice);
		System.out.println("bidIncrement is " + bidIncrement);
		
		int minimumBidAccepted = minBid + bidIncrement;

		/**
		 * auction_minBid and auction_startingPrice are mutable values,
		 * while auction_bidIncrement is a fixed value.
		 *
		 * All auctions have a base auction_startingPrice value,
		 * which increases each time a bid is made.
		 *
		 * auction_minBid = auction_startingPrice + auction_bidIncrement.
		 *
		 * For a bid to be valid, the user's bid must be
		 * greater than or equal to the auction_minBid value.
		 *
		 * The value of the most recent bid becomes the value
		 * of auction_startingPrice.
		 */
		//final int minimumBidAccepted = auction_minBid + auction_bidIncrement;
		final String fmt = String.format("(Enter US $%d.00 or more)", minimumBidAccepted);

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
				<td><img style="border: 2px solid #9a9a9a"
					src="data:image/jpg;base64,<%=base64Image%>" width="400"
					height="300" /></td>

				<td><H2 style="padding-left: 20px;"
						style="vertical-align: top:">
						<%-- PRINT ITEM NAME --%>
						<%
							out.println("      " + item_name + "");
						%>
					</H2>
					<p style="padding-left: 20px;">
						<b>Condition:</b>
						<%
							out.println(item_conditionType);
						%>
						<br> <b>Size:</b>
						<%
							out.println(item_size);
						%>
						<b>Color:</b>
						<%
							out.println(item_color);
						%>
						<br> <b>Brand/Manufacturer:</b>
						<%
							out.println(item_manufacturer);
						%>
						<br> <br> <b>Start Date:</b>
						<%
							out.println(auction_startDate);
						%>
						<br> <b>End Date:</b>
						<%
							out.println(auction_endDate);
						%>
						<br> <br> <b>Time Left:</b>
						<%
							
						%>
						
										<form action="bidServlet" method="post"
			enctype="multipart/form-data">
			<div style="Display:">
				<p style="padding-left: 20px;">
					<b>Starting bid:</b>
					<%
						out.println("$" + auction_minBid + ".00");
					%>
					<br> <b>Enter bid $</b> <input class="borderless" type="number"
						name="bid" min="<%=minimumBidAccepted%>" step="1" required>.00 <br>
					<%
						out.println(fmt);
					%>

				</p>
				
				<input type="hidden" name="auction_id" value=<%=auction_id%>>
				<input type="hidden" name="item_id" value=<%=item_id%>>
				<input type="hidden" name="auction_minBid" value=<%=auction_minBid%>>
				<input type="hidden" name="auction_startingPrice" value=<%=auction_startingPrice%>>
				<input type="hidden" name="auction_bidIncrement" value=<%=auction_bidIncrement%>>
				<input type="hidden" name="auction_startDate" value=<%=auction_startDate%>>
				<input type="hidden" name="auction_endDate" value=<%=auction_endDate%>>
				
				<p style="padding-left: 20px;" class="h3move">
					<button class="btn alt" value="Save">BID NOW</button>
				</p>
								
			</div>
		</form>
					
			</tr>
		</table>

		<table>
			<tr>
				<td><H3 style="padding-left: 20px;"
						style="vertical-align: top:">
						<b>Description:</b>
					</H3>
					<p style="padding-left: 20px;">
						<%
							out.println(item_description);
						%>
						<br> <br>
			</tr>
		</table>
					
	</div>
	
	<%-- IF BID AMOUNT IS BELOW THE MINIMUM ACCEPTED SHOW AN ERROR --%>

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

