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

import edu.groupc.project.beans.AccountDetailsValueBean;
import edu.groupc.project.beans.AddAccountFormBean;
import edu.groupc.project.beans.RemoveAccountFormBean;
import edu.groupc.project.beans.UserValueBean;
import edu.groupc.project.dbconfig.DbConfig;
import edu.groupc.project.service.UpdateService;
import edu.groupc.project.service.UpdateServiceImpl;

/**
 * Servlet implementation class ApplicationStart
 */
@WebServlet("/AccountDetailsController")
public class AccountDetailsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(AccountDetailsController.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	Connection connection = null;

	public AccountDetailsController() {
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
		request.getRequestDispatcher("WEB-INF/jsp/AccountDetails.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String submitFlag = request.getParameter("flagSubmit");
		boolean success;
		if (submitFlag != null && !submitFlag.equals("")) {
			if (submitFlag.equalsIgnoreCase("add")) {
				success = this.addAccount(request);
				if (success)
					request.setAttribute("status", "Added the account succesfully!!");
				else
					request.setAttribute("status", "Failed to add account!!");
			} else {
				success = this.removeAccount(request);
				if (success)
					request.setAttribute("status", "Removed the account succesfully!!");
				else
					request.setAttribute("status", "Failed to remove account!!");
			}
		}

		request.getRequestDispatcher("WEB-INF/jsp/AccountDetails.jsp").forward(request, response);
	}

	protected boolean addAccount(HttpServletRequest request) {
		AccountDetailsValueBean accountDetailsValueBean = new AccountDetailsValueBean();
		accountDetailsValueBean.setAccountNumber(request.getParameter("accountNumber"));
		accountDetailsValueBean.setIfscCode(request.getParameter("ifscCode"));
		accountDetailsValueBean.setBranchName(request.getParameter("branchName"));
		AddAccountFormBean addAccountFormBean = new AddAccountFormBean();
		addAccountFormBean.setAccountDetailsValueBean(accountDetailsValueBean);
		UpdateService updateService = new UpdateServiceImpl();
		UserValueBean userValueBean = (UserValueBean) request.getSession().getAttribute("user");
		try {
			userValueBean.setAccountDetailsValueBean(
					updateService.addAccount(userValueBean, addAccountFormBean, connection));
			request.getSession().removeAttribute("user");
			request.getSession().setAttribute("user", userValueBean);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	protected boolean removeAccount(HttpServletRequest request) {
		RemoveAccountFormBean removeAccountFormBean = new RemoveAccountFormBean();
		removeAccountFormBean.setAccountNumber(request.getParameter("removeAccNum"));
		UpdateService updateService = new UpdateServiceImpl();
		UserValueBean userValueBean = (UserValueBean) request.getSession().getAttribute("user");
		try {
			userValueBean.setAccountDetailsValueBean(
					updateService.deleteAccount(userValueBean, removeAccountFormBean, connection));
			request.getSession().removeAttribute("user");
			request.getSession().setAttribute("user", userValueBean);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}
