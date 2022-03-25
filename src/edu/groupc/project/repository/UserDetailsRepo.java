package edu.groupc.project.repository;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import edu.groupc.project.beans.AccountDetailsValueBean;
import edu.groupc.project.beans.AddAccountFormBean;
import edu.groupc.project.beans.CashTransactionFormBean;
import edu.groupc.project.beans.CustomerDetailsValueBean;
import edu.groupc.project.beans.FundTransferFormBean;
import edu.groupc.project.beans.LoginForm;
import edu.groupc.project.beans.RemoveAccountFormBean;
import edu.groupc.project.beans.UserValueBean;
import edu.groupc.project.constants.SqlQueries;

/**
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 *         UserDetailsRepo connects with DB and helps in performing CRUD
 *         operations on the requests
 *
 */
public class UserDetailsRepo {

	/**
	 * This metod fetches the USER data from DB
	 * 
	 * @param loginForm
	 * @return UserValueBean
	 * @throws SQLException
	 */
	public UserValueBean fetchUserDetails(LoginForm loginForm, Connection con) throws SQLException {

		UserValueBean userValueBean = UserValueBean.getInstance();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(SqlQueries.GET_CUSTOMER);
			stmt.setString(1, loginForm.getUserName());
			stmt.setString(2, loginForm.getPassword());
			rs = stmt.executeQuery();
			CustomerDetailsValueBean customerDetailsValueBean = setCustomerDetails(rs);
			userValueBean.setCustomerDetailsValueBean(customerDetailsValueBean);
			Map<String, AccountDetailsValueBean> accountDetailsValueBeanList = new HashMap<String, AccountDetailsValueBean>();
			if (customerDetailsValueBean != null) {
				stmt = con.prepareStatement(SqlQueries.GET_ACCOUNTS);
				stmt.setInt(1, Integer.parseInt(customerDetailsValueBean.getCustomerId()));
				rs = stmt.executeQuery();
				accountDetailsValueBeanList = setAccounts(accountDetailsValueBeanList, rs);
				userValueBean.setAccountDetailsValueBean(accountDetailsValueBeanList);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (rs != null) {
				rs.close();
			}

		}
		return userValueBean;
	}

	/**
	 * This method sets the account level data to Map
	 * 
	 * @param accountDetailsValueBeanList
	 * @param rs
	 * @return Map<String, AccountDetailsValueBean>
	 * @throws SQLException
	 */
	public Map<String, AccountDetailsValueBean> setAccounts(
			Map<String, AccountDetailsValueBean> accountDetailsValueBeanList, ResultSet rs) throws SQLException {
		if (rs != null) {
			while (rs.next()) {
				AccountDetailsValueBean accountDetailsValueBean = new AccountDetailsValueBean();
				accountDetailsValueBean.setAccountNumber(rs.getString(1));
				accountDetailsValueBean.setIfscCode(rs.getString(3));
				accountDetailsValueBean.setBranchName(rs.getString(4));
				accountDetailsValueBean.setBalance(rs.getFloat(5));
				accountDetailsValueBeanList.put(accountDetailsValueBean.getAccountNumber(), accountDetailsValueBean);
			}
		}
		return accountDetailsValueBeanList;
	}

	/**
	 * This method sets the data to CustomerDetailsValueBean
	 * 
	 * @param rs
	 * @return CustomerDetailsValueBean
	 * @throws SQLException
	 */
	public CustomerDetailsValueBean setCustomerDetails(ResultSet rs) throws SQLException {

		CustomerDetailsValueBean customerDetailsValueBean = null;
		if (rs != null) {
			while (rs.next()) {
				customerDetailsValueBean = new CustomerDetailsValueBean();
				customerDetailsValueBean.setCustomerId(String.valueOf(rs.getInt(1)));
				customerDetailsValueBean.setUserName(rs.getString(2));
				customerDetailsValueBean.setEmail(rs.getString(4));
				customerDetailsValueBean.setFirstName(rs.getString(5));
				customerDetailsValueBean.setLastName(rs.getString(6));
				customerDetailsValueBean.setDateOfBirth(String.valueOf(rs.getDate(7).toLocalDate()));
				customerDetailsValueBean.setAddress(rs.getString(8));
				customerDetailsValueBean.setPhoneNumber(rs.getString(9));
			}
		}
		return customerDetailsValueBean;
	}

	/**
	 * This method updates the customer details to the DB
	 * 
	 * @param userValueBean
	 * @throws SQLException
	 */
	public boolean updateCustomerDetails(UserValueBean userValueBean, Connection con) throws SQLException {
		int result = 0;
		PreparedStatement stmt = null;
		try {
			CustomerDetailsValueBean customerDetailsValueBean = userValueBean.getCustomerDetailsValueBean();

			stmt = con.prepareStatement(SqlQueries.UPDATE_CUSTOMER_DETAILS);

			stmt.setString(1, customerDetailsValueBean.getUserName());
			stmt.setString(2, customerDetailsValueBean.getEmail());
			stmt.setString(3, customerDetailsValueBean.getFirstName());
			stmt.setString(4, customerDetailsValueBean.getLastName());
			String dateString = customerDetailsValueBean.getDateOfBirth();
			stmt.setDate(5, java.sql.Date.valueOf(dateString));
			stmt.setString(6, customerDetailsValueBean.getAddress());
			stmt.setBigDecimal(7, BigDecimal.valueOf(Long.valueOf(customerDetailsValueBean.getPhoneNumber())));
			stmt.setInt(8, Integer.parseInt(customerDetailsValueBean.getCustomerId()));
			result = stmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return result != 0 ? true : false;

	}

	/**
	 * This method updates the Cash transactions to the DB
	 * 
	 * @param userValueBean
	 * @param cashTransactionFormBean
	 * @return Map<String, AccountDetailsValueBean>
	 * @throws SQLException
	 */
	public Map<String, AccountDetailsValueBean> updateCashTransaction(UserValueBean userValueBean,
			CashTransactionFormBean cashTransactionFormBean, Connection con) throws SQLException {
		Map<String, AccountDetailsValueBean> accountDetailsValueBeans = userValueBean.getAccountDetailsValueBean();
		int result = 0;
		PreparedStatement stmt = null;
		for (Entry<String, AccountDetailsValueBean> entry : accountDetailsValueBeans.entrySet()) {

			if (entry.getKey().equals(cashTransactionFormBean.getAccountNumber())) {
				AccountDetailsValueBean accountDetailsValueBean = (AccountDetailsValueBean) entry.getValue();
				try {

					stmt = con.prepareStatement(SqlQueries.UPDATE_CASH_TRANSACTION);

					if (cashTransactionFormBean.isCredit()) {
						accountDetailsValueBean
								.setBalance(accountDetailsValueBean.getBalance() + cashTransactionFormBean.getAmount());
					} else {
						accountDetailsValueBean
								.setBalance(accountDetailsValueBean.getBalance() - cashTransactionFormBean.getAmount());
					}
					stmt.setDouble(1, accountDetailsValueBean.getBalance());
					stmt.setString(2, cashTransactionFormBean.getAccountNumber());
					result = stmt.executeUpdate();
					if (result == 1) {
						accountDetailsValueBeans.put(cashTransactionFormBean.getAccountNumber(),
								accountDetailsValueBean);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (stmt != null) {
						stmt.close();
					}
				}

			}

		}

		return accountDetailsValueBeans;
	}

	/**
	 * This method removes the account of the customer from the DB
	 * 
	 * @param userValueBean
	 * @param removeAccountFormBean
	 * @return Map<String, AccountDetailsValueBean>
	 * @throws SQLException
	 */
	public Map<String, AccountDetailsValueBean> removeAccount(UserValueBean userValueBean,
			RemoveAccountFormBean removeAccountFormBean, Connection con) throws SQLException {
		Map<String, AccountDetailsValueBean> accountDetailsValueBeans = userValueBean.getAccountDetailsValueBean();
		int result = 0;
		PreparedStatement stmt = null;
		try {
			CustomerDetailsValueBean customerDetailsValueBean = userValueBean.getCustomerDetailsValueBean();
			stmt = con.prepareStatement(SqlQueries.DELETE_CUSTOMER);
			stmt.setInt(1, Integer.parseInt(removeAccountFormBean.getAccountNumber()));
			stmt.setInt(2, Integer.parseInt(customerDetailsValueBean.getCustomerId()));
			result = stmt.executeUpdate();
			if (result == 1) {
				accountDetailsValueBeans.remove(removeAccountFormBean.getAccountNumber());
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return accountDetailsValueBeans;
	}

	/**
	 * This method add the New account of the customer to the DB
	 * 
	 * @param userValueBean
	 * @param addAccountFormBean
	 * @return Map<String, AccountDetailsValueBean>
	 * @throws SQLException
	 */
	public Map<String, AccountDetailsValueBean> addAccount(UserValueBean userValueBean,
			AddAccountFormBean addAccountFormBean, Connection con) throws SQLException {
		Map<String, AccountDetailsValueBean> accountDetailsValueBeans = userValueBean.getAccountDetailsValueBean();
		PreparedStatement stmt = null;

		try {
			AccountDetailsValueBean accountDetailsValueBean = addAccountFormBean.getAccountDetailsValueBean();
			CustomerDetailsValueBean customerDetailsValueBean = userValueBean.getCustomerDetailsValueBean();
			stmt = con.prepareStatement(SqlQueries.ADD_ACCOUNT);
			stmt.setString(1, accountDetailsValueBean.getAccountNumber());
			stmt.setInt(2, Integer.parseInt(customerDetailsValueBean.getCustomerId()));
			stmt.setString(3, accountDetailsValueBean.getIfscCode());
			stmt.setString(4, accountDetailsValueBean.getBranchName());
			stmt.setDouble(5, accountDetailsValueBean.getBalance());

			int i = stmt.executeUpdate();
			if (i == 1) {
				accountDetailsValueBeans.put(accountDetailsValueBean.getAccountNumber(), accountDetailsValueBean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return accountDetailsValueBeans;
	}

	/**
	 * This method transfers the data from the customer account to other account in
	 * the DB
	 * 
	 * @param userValueBean
	 * @param fundTransferFormBean
	 * @return Map<String, AccountDetailsValueBean>
	 * @throws Exception
	 */
	public Map<String, AccountDetailsValueBean> transferAmount(UserValueBean userValueBean,
			FundTransferFormBean fundTransferFormBean, Connection con) throws Exception {
		Map<String, AccountDetailsValueBean> accountDetailsValueBeans = userValueBean.getAccountDetailsValueBean();
		int result = 0;
		PreparedStatement stmt = null;
		try {
			con.setAutoCommit(false);
			AccountDetailsValueBean primaryAccount = accountDetailsValueBeans
					.get(fundTransferFormBean.getAccountNumber());
			primaryAccount.setBalance(primaryAccount.getBalance() - fundTransferFormBean.getTransferAmount());
			stmt = con.prepareStatement(SqlQueries.UPDATE_MAIN_ACCOUNT_BALANCE);
			stmt.setDouble(1, primaryAccount.getBalance());
			stmt.setString(2, primaryAccount.getAccountNumber());
			result = stmt.executeUpdate();
			if (result == 1) {
				accountDetailsValueBeans.put(primaryAccount.getAccountNumber(), primaryAccount);
				if (fundTransferFormBean.isWithin()) {
					AccountDetailsValueBean secondary = accountDetailsValueBeans
							.get(fundTransferFormBean.getTransferAccountNumber());
					if (secondary != null) {
						secondary.setBalance(secondary.getBalance() + fundTransferFormBean.getTransferAmount());
						stmt = con.prepareStatement(SqlQueries.UPDATE_CHILD_ACCOUNT_BALANCE);
						stmt.setDouble(1, secondary.getBalance());
						stmt.setString(2, secondary.getAccountNumber());
						stmt.setString(3, secondary.getIfscCode());
						result = stmt.executeUpdate();
					} else {
						result = 0;
					}
					if (result == 0) {
						throw new Exception("Transfer account Not Found");
					} else {

						accountDetailsValueBeans.put(secondary.getAccountNumber(), secondary);
					}
				} else {
					stmt = con.prepareStatement(SqlQueries.SELECT_TRANSFER_ACCOUNT_BALANCE);
					stmt.setString(1, fundTransferFormBean.getTransferAccountNumber());
					stmt.setString(2, fundTransferFormBean.getTransferIfscCode());
					ResultSet rset = stmt.executeQuery();
					double balance = 0.00;
					while (rset.next()) {
						balance = rset.getDouble(1);
					}
					balance += fundTransferFormBean.getTransferAmount();
					stmt = con.prepareStatement(SqlQueries.UPDATE_TRANSFER_ACCOUNT_BALANCE);
					stmt.setDouble(1, balance);
					stmt.setString(2, fundTransferFormBean.getTransferAccountNumber());
					stmt.setString(3, fundTransferFormBean.getTransferIfscCode());
					result = stmt.executeUpdate();
					if (result == 0) {
						throw new Exception("Transfer account Not Found");
					}
				}
			}
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
			con.rollback();
			throw new Exception("Transfer Failed");
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return accountDetailsValueBeans;
	}

}
