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

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
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
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class BidDBServlet extends HttpServlet {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 236580712716675606L;

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

		String userBidStr = request.getParameter("bid");
		String minimumBidStr = request.getParameter("auction_minBid");
		//String startingPriceStr = request.getParameter("auction_startingPrice");
		String bidIncrementStr = request.getParameter("auction_bidIncrement");
		String winStatusStr = "0";

		int bid = Integer.valueOf(userBidStr);
		int minimumBid = Integer.valueOf(minimumBidStr);
		//int startingPrice = Integer.valueOf(startingPriceStr);
		int bidIncrement = Integer.valueOf(bidIncrementStr);

		try {
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

			String insertStr = "";
			insertStr = String
					.format("INSERT INTO BID(auction_id, username, item_id, bid_amount, status)" + "VALUES(?,?,?,?,?)");

			PreparedStatement insertStatement = conn.prepareStatement(insertStr);

			insertStatement.setString(1, auctionIDStr);
			insertStatement.setString(2, userStr);
			insertStatement.setString(3, itemIDStr);
			insertStatement.setString(4, userBidStr);
			insertStatement.setString(5, winStatusStr);

			insertStatement.executeUpdate();
			
			int newMinimumBid = bid;
			String newMinimumBidStr = Integer.toString(newMinimumBid);

			String updateStr = "UPDATE AUCTION SET lowest_bid = ? WHERE auction_id = ?";
			
			PreparedStatement updateStatement = conn.prepareStatement(updateStr);
			updateStatement.setString(1, newMinimumBidStr);
			updateStatement.setString(2, auctionIDStr);

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
}
