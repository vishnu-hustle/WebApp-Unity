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

import edu.groupc.project.beans.CashTransactionFormBean;
import edu.groupc.project.beans.FundTransferFormBean;
import edu.groupc.project.beans.UserValueBean;
import edu.groupc.project.dbconfig.DbConfig;
import edu.groupc.project.service.UpdateService;
import edu.groupc.project.service.UpdateServiceImpl;

/**
 * Servlet implementation class ApplicationStart
 */
@WebServlet("/FundTransferController")
public class FundTransferController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(FundTransferController.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	Connection connection = null;

	public FundTransferController() {
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
		request.getRequestDispatcher("WEB-INF/jsp/FundTransfer.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		boolean success;
		String flow = request.getParameter("flow");
		if (flow != null && flow.equalsIgnoreCase("transfer")) {
			success = this.fundTransfer(request);
			if (success)
				request.setAttribute("status", "Transferred succesfully!!");
			else
				request.setAttribute("status", "Failed to Transfer Amount!!");
		} else {
			success = this.cashTransaction(request);
			if (success)
				request.setAttribute("status", "Transaction done succesfully!!");
			else
				request.setAttribute("status", "Transaction Failed!!");
		}

		request.getRequestDispatcher("WEB-INF/jsp/FundTransfer.jsp").forward(request, response);
	}

	protected boolean fundTransfer(HttpServletRequest request) {
		FundTransferFormBean fundTransferFormBean = new FundTransferFormBean();
		fundTransferFormBean.setAccountNumber(request.getParameter("fromAccount"));
		fundTransferFormBean.setTransferAccountNumber(request.getParameter("accountNumber"));
		fundTransferFormBean.setTransferIfscCode(request.getParameter("ifscCode"));
		fundTransferFormBean.setTransferAmount(Double.parseDouble(request.getParameter("amount")));
		int type = Integer.parseInt(request.getParameter("transferType"));
		if (type == 1) {
			fundTransferFormBean.setWithin(true);
		} else {
			fundTransferFormBean.setWithin(false);
		}
		UserValueBean userValueBean = (UserValueBean) request.getSession().getAttribute("user");
		try {
			UpdateService updateService = new UpdateServiceImpl();
			userValueBean.setAccountDetailsValueBean(
					updateService.transferAmount(userValueBean, fundTransferFormBean, connection));
			request.getSession().removeAttribute("user");
			request.getSession().setAttribute("user", userValueBean);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	protected boolean cashTransaction(HttpServletRequest request) {
		CashTransactionFormBean cashTransactionFormBean = new CashTransactionFormBean();
		cashTransactionFormBean.setAccountNumber(request.getParameter("fromAccountCash"));
		int type = Integer.parseInt(request.getParameter("transactionType"));
		if (type == 2) {
			cashTransactionFormBean.setDebit(true);
			cashTransactionFormBean.setCredit(false);

		} else {
			cashTransactionFormBean.setDebit(false);
			cashTransactionFormBean.setCredit(true);
		}
		UserValueBean userValueBean = (UserValueBean) request.getSession().getAttribute("user");
		cashTransactionFormBean.setAmount(Double.parseDouble(request.getParameter("amountCash")));
		try {
			UpdateService updateService = new UpdateServiceImpl();

			userValueBean.setAccountDetailsValueBean(
					updateService.updateCashTransaction(userValueBean, cashTransactionFormBean, connection));
			request.getSession().removeAttribute("user");
			request.getSession().setAttribute("user", userValueBean);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

}
