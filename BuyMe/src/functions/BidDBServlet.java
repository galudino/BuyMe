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
		
		String user = (String) request.getSession().getAttribute("currentSessionUser");
			
		String auctionIDStr = request.getParameter("auction_id");
		
		String itemIDStr = request.getParameter("item_id");

		String userBidStr = request.getParameter("bid");
		int bid = Integer.valueOf(userBidStr);
		
		String minimumBidStr = request.getParameter("auction_minBid");
		int minimumBid = Integer.valueOf(minimumBidStr);
		
		String startingPriceStr = request.getParameter("auction_startingPrice");
		int startingPrice = Integer.valueOf(startingPriceStr);
		
		String bidIncrementStr = request.getParameter("auction_bidIncrement");
		int bidIncrement = Integer.valueOf(bidIncrementStr);
		
		String winStatusStr = "0";
		
		System.out.println(minimumBid + " " + startingPrice + " " + bidIncrement + " " + bid);
		
		try {			
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
		
			
			if (bid >= minimumBid) {
				/**
				 * SCENARIO 1:
				 * bid is allowed to go through
				 * (bid satisfies condition bid >= minimumBid)
				 */
				
				/**
				 * Begin the process of adding the bid to the database
				 * (add the bid data to the BID table)
				 * 
				 * BID has the following columns:
				 * 	auction_id
				 * 	item_id
				 * 	amount
				 * 	winstatus
				 */
				String insertStr = "";
				insertStr = String.format(
						"INSERT INTO BID "
						+ "VALUES(%s,%s,%s,%s)", 
						auctionIDStr, 
						itemIDStr, 
						userBidStr, 
						winStatusStr);
				
				PreparedStatement insertStatement = conn.prepareStatement(insertStr);
				insertStatement.executeUpdate();
				
				/**
				 * Change the minimum bid amount in AUCTION
				 * (precondition: bid >= minimumBid)
				 * 
				 * newMinimumBid = bid + bidIncrement;
				 * minimumBid = newMinimumBid;
				 * 
				 * AUCTION has the following columns:
				 * 	auction_id
				 * 	start_time
				 * 	end_time
				 * 	title
				 * 	lowest_bid
				 * 	starting_price
				 * 	bidIncrement
				 * 	photo
				 * 	user_id
				 */
				
				/*
				String updateStr = "";
				//updateStr = String.format(format, args);
				
				PreparedStatement updateStatement = conn.prepareStatement(updateStr);
				updateStatement.executeUpdate();
				*/
				
				
			} else {
				/**
				 * SCENARIO 2:
				 * bid is not allowed to go through.
				 * (bid does not meet condition bid >= minimumBid)
				 */

				
				// TODO: display an error telling the user that the bid was too low
				response.sendRedirect("auction.jsp?auction_id=" + auctionIDStr);
				return;
			}
			
			
			
			//java.sql.Statement statement = conn.createStatement();
	
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
		response.sendRedirect("auction.jsp?auction_id=" + auctionIDStr);
	}
}
