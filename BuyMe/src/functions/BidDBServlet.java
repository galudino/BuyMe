/**
 * BidDBServlet.java
 * 
 * Copyright (c) 2019 Gemuele Aludino.
 * All rights reserved.
 * 
 * Rutgers University: School of Arts and Sciences
 * 01:198:336 Principles of Info. and Data Mgmt., Spring 2019
 * Professor Miranda Garcia
 */
package functions;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Represents a bid servlet for an auction-style website
 * 
 * @version Apr 21, 2019
 * @author gemuelealudino
 */
@WebServlet("/bidServlet")
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class BidDBServlet extends HttpServlet {

	/**
	 * serialVersionUID
	 */

	private final String DB_URL = "jdbc:mysql://cs336buyme.cnnvlun9z7yl.us-east-2.rds.amazonaws.com:3306/buyme";
	private final String DB_USER = "cs336buyme";
	private final String DB_PASS = "Rutgers123";

	/**
	 * 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;

		String userStr = (String) request.getSession().getAttribute("currentSessionUser");

		String auctionIDStr = request.getParameter("auction_id");
		String itemIDStr = request.getParameter("item_id");
		String startDateStr = "";
		String endDateStr = "";

		String userBidStr = request.getParameter("bid");
		String minimumBidStr = request.getParameter("auction_minBid");
		String startingPriceStr = request.getParameter("auction_startingPrice");
		String bidIncrementStr = request.getParameter("auction_bidIncrement");
		String winStatusStr = "0";

		/**
		 * Parse Strings to ints
		 */
		int bid = Integer.valueOf(userBidStr);
		int minimumBid = Integer.valueOf(minimumBidStr);
		int startingPrice = Integer.valueOf(startingPriceStr);
		int bidIncrement = Integer.valueOf(bidIncrementStr);

		try {
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

			if (conn != null)
				System.out.println("test");

			java.sql.Statement statement = conn.createStatement();
			ResultSet auctionSet = null;
			auctionSet = statement.executeQuery(
					"SELECT start_time, " + "end_time from AUCTION as a where a.auction_id = " + auctionIDStr);

			// evaluate date with now
			boolean validDate = true;

			// add bid to bid table
			String insertStr = "";
			insertStr = String
					.format("INSERT INTO BID(auction_id, username, item_id, bid_amount, status)" + "VALUES(?,?,?,?,?)");

			PreparedStatement insertStatement = conn.prepareStatement(insertStr);

			insertStatement.setString(1, auctionIDStr);
			insertStatement.setString(2, userStr);
			insertStatement.setString(3, itemIDStr);
			insertStatement.setString(4, userBidStr);
			insertStatement.setString(5, winStatusStr);
			
			int z = insertStatement.executeUpdate();
			// now update minimum bid within auction for this auction_id
			// TODO
			
				System.out.println("LLL");
				String test = String.format("UPDATE AUCTION SET lowest_bid = (SELECT MAX(?) FROM BID as b WHERE b.auction_id = ?) WHERE auction_id = ?");
		
				
				PreparedStatement updateStatement = conn.prepareStatement(test);
				//updateStatement.setString(parameterIndex, x);
				
				updateStatement.setInt(1, bid);
				updateStatement.setString(2, userStr);
				updateStatement.setString(3, userStr);
				
				updateStatement.executeUpdate();

			


		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		/**
		 * After the user attempts to make a bid (whether they were successful or not),
		 * they are sent back to the auction page from which they made the bid.
		 */
		response.sendRedirect("auction.jsp?auction_id=" + auctionIDStr);
	}

	/**
	 * Method to convert a String into a Date object
	 * 
	 * @param str String to parse into a Date
	 * 
	 * @return a Date object represented by the param str
	 */
	private LocalDateTime convertJavaDate(String str) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/mm/dd HH:mm:ss:s");

		LocalDateTime ldt = LocalDateTime.parse(str, formatter);

		return ldt;
	}
}
