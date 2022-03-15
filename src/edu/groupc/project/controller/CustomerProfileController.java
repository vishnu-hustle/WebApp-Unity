package edu.groupc.project.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.org.slf4j.internal.Logger;
import com.sun.org.slf4j.internal.LoggerFactory;

import edu.groupc.project.dbconfig.DbConfig;

/**
 * Servlet implementation class ApplicationStart
 */
@WebServlet("/CustomerProfileController")
public class CustomerProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(CustomerProfileController.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	Connection connection = null;

	public CustomerProfileController() {
		super();

	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		DbConfig db = new DbConfig();
		try {
			connection = db.getDatabaseConnection();
		} catch (ClassNotFoundException e) {
			LOGGER.error("Unable to establish connection with database Exception: " + e.toString());
		} catch (SQLException e) {
			LOGGER.error("Unable to establish connection with database Exception: " + e.toString());
		}
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				LOGGER.error("Unable to close database connection Exception: " + e.toString());
			}
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("WEB-INF/jsp/CustomerProfile.jsp").forward(request, response);
	}



}
