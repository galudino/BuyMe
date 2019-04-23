package functions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/askQuestionServlet")
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class AskQuestionServlet extends HttpServlet {

	private final String DB_URL = "jdbc:mysql://cs336buyme.cnnvlun9z7yl.us-east-2.rds.amazonaws.com:3306/buyme";
	private final String DB_USER = "cs336buyme";
	private final String DB_PASS = "Rutgers123";

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Connection conn = null;
		
		String user = (String) request.getSession().getAttribute("currentSessionUser");
		String question = request.getParameter("regQuestion");
		
		try {
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
			
			String insertQuestion = "INSERT INTO QUESTIONS(username, question)"
					+ "VALUES (?, ?)";
			
			PreparedStatement questionStatement = conn.prepareStatement(insertQuestion);
			questionStatement.setString(1, user);
			questionStatement.setString(2, question);
			questionStatement.executeUpdate();
			
			conn.close();
		} catch(Exception e) {
			
		}
		response.sendRedirect("FAQ.jsp");
	}
}
