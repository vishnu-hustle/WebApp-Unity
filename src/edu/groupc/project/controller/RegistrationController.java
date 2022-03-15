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

import edu.groupc.project.beans.RegistrationFormBean;
import edu.groupc.project.dbconfig.DbConfig;
import edu.groupc.project.service.RegistrationService;
import edu.groupc.project.service.RegistrationServiceImpl;

/**
 * Servlet implementation class ApplicationStart
 */
@WebServlet(name = "RegistrationController", urlPatterns = "/registrationController")
public class RegistrationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(RegistrationController.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	Connection connection = null;

	public RegistrationController() {
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
		request.getRequestDispatcher("WEB-INF/jsp/Registration.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RegistrationFormBean registrationFormBean = this.getFromBean(request);
		RegistrationService registrationService = new RegistrationServiceImpl();
		try {
			if (registrationService.createNewUser(registrationFormBean, connection)) {
				request.setAttribute("status", "Registered Sucessfully!!");
			} else {
				request.setAttribute("status", "Registration Failed!!!");
			}
		} catch (Exception e) {
			request.setAttribute("status", 400);
			LOGGER.error("User registration Exception: " + e.toString());
		}

		request.getRequestDispatcher("WEB-INF/jsp/Login.jsp").forward(request, response);

	}

	private RegistrationFormBean getFromBean(HttpServletRequest request) {
		RegistrationFormBean registrationFormBean = new RegistrationFormBean();

		registrationFormBean.setFirstName(request.getParameter("firstname"));
		registrationFormBean.setLastName(request.getParameter("lastname"));
		registrationFormBean.setAddress(request.getParameter("address"));
		registrationFormBean.setDateOfBirth(request.getParameter("dob"));
		registrationFormBean.setEmail(request.getParameter("emailId"));
		registrationFormBean.setUserName(request.getParameter("username"));
		registrationFormBean.setNewPassword(request.getParameter("password"));
		registrationFormBean.setPhoneNumber(request.getParameter("phoneNumber"));

		return registrationFormBean;
	}

}
