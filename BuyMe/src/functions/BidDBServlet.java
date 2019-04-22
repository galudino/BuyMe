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

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Represents a bid servlet for an auction-style website
 * 
 * @version Apr 21, 2019
 * @author gemuelealudino
 */
@WebServlet("/bidServlet")
public final class BidDBServlet extends HttpServlet {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -4605240899929610247L;

	private final String DB_URL = "jdbc:mysql://cs336buyme.cnnvlun9z7yl.us-east-2.rds.amazonaws.com:3306/buyme";
	private final String DB_USER = "cs336buyme";
	private final String DB_PASS = "Rutgers123";

	/**
	 * 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
	
		String auctionIDstr = "";		// will be assigned after SQL query
		int auctionID = -1;

		String userBidStr = (String)request.getParameter("userBid");
		int userBid = Integer.valueOf(userBidStr);
		
		String minimumBidStr = "";		// will be assigned after SQL query
		int minimumBid = -1;
		
		String bidIncrementStr = ""; 	// will be assigned after SQL query
		int bidIncrement = -1;

		try {
			String user = (String) (request.getSession().getAttribute("currentSessionUser"));
			
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
		
			/**
			 * First, I will query the database
			 * to retrieve the auction ID for this particular auction.
			 * 
			 * Perhaps I can match a hyperlink string
			 * that corresponds to the entry AUCTION.title?
			 * (need to know how the implementation of navigating
			 * through auctions will go)
			 */
			java.sql.Statement statement = conn.createStatement();
			String selectItem = "SELECT auction_id FROM AUCTION WHERE user_id = " + user;
			ResultSet auctionIDSet = statement.executeQuery(selectItem);
			
			/**
			 * Then, I must retrieve the starting price, minimum bid, and bid increment
			 * for this auction, via a SQL query. 
			 */
			
			/**
			 * If userBid >= (minimumBid + bidIncrement)
			 * then the program will allow the bid to be logged into the database.
			 * 
			 * Else, cancel the bid and notify the user.
			 */
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// TODO cleanup
		}

		/**
		 * After the user attempts to make a bid (whether they were successful or not), 
		 * they are sent back to the auction page from which
		 * they made the bid.
		 */
		response.sendRedirect("auction.jsp?auction_id=" + auctionID);
	}
}
