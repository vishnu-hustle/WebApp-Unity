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

import edu.groupc.project.beans.CustomerDetailsValueBean;
import edu.groupc.project.beans.UserValueBean;
import edu.groupc.project.dbconfig.DbConfig;
import edu.groupc.project.service.UpdateService;
import edu.groupc.project.service.UpdateServiceImpl;

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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserValueBean userValueBean = (UserValueBean) request.getSession().getAttribute("user");
		CustomerDetailsValueBean customerProfile = userValueBean.getCustomerDetailsValueBean();
		this.getFromBean(request, customerProfile);
		try {
			userValueBean.setCustomerDetailsValueBean(customerProfile);
			UpdateService updateService = new UpdateServiceImpl();
			if (updateService.updateCustomerDetails(userValueBean, connection)) {
				request.setAttribute("status", "updated Sucessfully!!");
			} else {
				request.setAttribute("status", "update Failed!!!");
			}
		} catch (Exception e) {
			request.setAttribute("status", "update Failed!!!");
			LOGGER.error("Customer Profile update Exception: " + e.toString());
		}

		request.getRequestDispatcher("WEB-INF/jsp/CustomerProfile.jsp").forward(request, response);

	}

	private void getFromBean(HttpServletRequest request, CustomerDetailsValueBean customerProfile) {
		customerProfile.setFirstName(request.getParameter("firstname"));
		customerProfile.setLastName(request.getParameter("lastname"));
		customerProfile.setAddress(request.getParameter("address"));
		customerProfile.setDateOfBirth(request.getParameter("dob"));
		customerProfile.setEmail(request.getParameter("emailId"));
		customerProfile.setUserName(request.getParameter("username"));
		customerProfile.setPhoneNumber(request.getParameter("phoneNumber"));
	}

}
