package functions;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
 
@WebServlet("/uploadServlet")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class FileUploadDBServlet extends HttpServlet {
	
	private final String DB_URL = "jdbc:mysql://cs336buyme.cnnvlun9z7yl.us-east-2.rds.amazonaws.com:3306/buyme";
	private final String DB_USER = "cs336buyme";
	private final String DB_PASS = "Rutgers123";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		Connection conn = null;
		InputStream inputStream = null;
		
		int auctionID = -1;
		
		String user = (String) request.getSession().getAttribute("currentSessionUser");
		
		String itemName = request.getParameter("itemName");
		String description = request.getParameter("description");
		String conditionType = request.getParameter("conditionType");
		String manufacturer = request.getParameter("manufacturer");
		double size = Double.valueOf(request.getParameter("size"));
		String color = request.getParameter("color");
		Part filePart = request.getPart("photo");

		//AUCTION INFORMATION
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		double bidIncrement = Double.valueOf(request.getParameter("bidIncrement"));
		double minBid = Double.valueOf(request.getParameter("minBid"));
		double startingPrice = Double.valueOf(request.getParameter("startingPrice"));
		
        if (filePart != null) {
            inputStream = filePart.getInputStream();
        }
        
        try {
        	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
        	conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        	
			String insertItem = "INSERT INTO ITEM(item_condition, description, name, brand, size, color)" + "VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement itemStatement = conn.prepareStatement(insertItem);
			itemStatement.setString(1, conditionType);
			itemStatement.setString(2, description);
			itemStatement.setString(3, itemName);
			itemStatement.setString(4, manufacturer);
			itemStatement.setDouble(5, size);
			itemStatement.setString(6, color);
			
			int x = itemStatement.executeUpdate();
			System.out.println(x);
		
			
			String insertAuction= "INSERT INTO AUCTION(start_time, end_time, title, lowest_bid, starting_price, bidIncrement, photo, user_id)" + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement auctionStatement = conn.prepareStatement(insertAuction);
			auctionStatement.setString(1, startDate);
			auctionStatement.setString(2, endDate);
			auctionStatement.setString(3, itemName);
			auctionStatement.setDouble(4, minBid);
			auctionStatement.setDouble(5, startingPrice);
			auctionStatement.setDouble(6, bidIncrement);
			if(inputStream != null) {
				auctionStatement.setBlob(7, inputStream);
			}
			auctionStatement.setString(8, user);
			
			int y = auctionStatement.executeUpdate();
			
			if(y > 0)
				System.out.println("File uploaded.");
			
			java.sql.Statement statement = conn.createStatement();
			ResultSet auctionSet = null;
			
			auctionSet = statement.executeQuery("SELECT * FROM AUCTION");
			
			while(auctionSet.next()) {
				if(auctionSet.isLast()) {
					auctionID = auctionSet.getInt(1);
				} else {
					auctionID = 0;
				}
			}
			
        } catch(SQLException e) {
        	e.printStackTrace();
        } finally {
        	if(conn != null) {
        		try {
        			conn.close();
        		} catch(SQLException e) {
        			e.printStackTrace();
        		}
        	}
        	
        }
        
        response.sendRedirect("auction.jsp?auction_id=" + auctionID);
	}

}
