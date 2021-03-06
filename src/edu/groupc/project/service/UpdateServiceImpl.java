package edu.groupc.project.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import edu.groupc.project.beans.AccountDetailsValueBean;
import edu.groupc.project.beans.AddAccountFormBean;
import edu.groupc.project.beans.CashTransactionFormBean;
import edu.groupc.project.beans.FundTransferFormBean;
import edu.groupc.project.beans.RemoveAccountFormBean;
import edu.groupc.project.beans.UserValueBean;
import edu.groupc.project.repository.UserDetailsRepo;

/**
 * This is an Implementation for UpdateService
 * 
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 */
public class UpdateServiceImpl implements UpdateService {

	/**
	 * This is service layer method used for updating the customer details
	 * @throws SQLException 
	 */
	@Override
	public boolean updateCustomerDetails(UserValueBean userValueBean, Connection con) throws SQLException {

		UserDetailsRepo userDetailsRepo = new UserDetailsRepo();
		return userDetailsRepo.updateCustomerDetails(userValueBean, con);

	}

	/**
	 * This is service layer method used for updating the cash transaction
	 * @throws SQLException 
	 */
	@Override
	public Map<String, AccountDetailsValueBean> updateCashTransaction(UserValueBean userValueBean,
			CashTransactionFormBean cashTransactionFormBean, Connection con) throws SQLException {
		UserDetailsRepo userDetailsRepo = new UserDetailsRepo();

		return userDetailsRepo.updateCashTransaction(userValueBean, cashTransactionFormBean, con);
	}

	/**
	 * This is service layer method used for deleting the customer account
	 * @throws SQLException 
	 */
	@Override
	public Map<String, AccountDetailsValueBean> deleteAccount(UserValueBean userValueBean,
			RemoveAccountFormBean removeAccountFormBean, Connection con) throws SQLException {
		UserDetailsRepo userDetailsRepo = new UserDetailsRepo();

		return userDetailsRepo.removeAccount(userValueBean, removeAccountFormBean, con);
	}

	/**
	 * This is service layer method used for adding the customer account
	 * @throws SQLException 
	 */
	@Override
	public Map<String, AccountDetailsValueBean> addAccount(UserValueBean userValueBean,
			AddAccountFormBean addAccountFormBean, Connection con) throws SQLException {
		UserDetailsRepo userDetailsRepo = new UserDetailsRepo();

		return userDetailsRepo.addAccount(userValueBean, addAccountFormBean, con);
	}

	/**
	 * This is service layer method used for transferring the amount
	 * 
	 * @throws Exception
	 */
	@Override
	public Map<String, AccountDetailsValueBean> transferAmount(UserValueBean userValueBean,
			FundTransferFormBean fundTransferFormBean, Connection con) throws Exception {

		UserDetailsRepo userDetailsRepo = new UserDetailsRepo();

		return userDetailsRepo.transferAmount(userValueBean, fundTransferFormBean, con);
	}

}
