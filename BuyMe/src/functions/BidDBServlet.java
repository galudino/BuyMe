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
import java.util.*;

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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
	}
}
