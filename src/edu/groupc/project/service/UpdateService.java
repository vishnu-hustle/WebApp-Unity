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

/**
 * This is an inteface for UpdateService
 * 
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 */
public interface UpdateService {

	public boolean updateCustomerDetails(UserValueBean userValueBean, Connection con) throws SQLException;

	public Map<String, AccountDetailsValueBean> updateCashTransaction(UserValueBean userValueBean,
			CashTransactionFormBean cashTransactionFormBean, Connection con) throws SQLException;

	public Map<String, AccountDetailsValueBean> addAccount(UserValueBean userValueBean,
			AddAccountFormBean addAccountFormBean, Connection con) throws SQLException;

	public Map<String, AccountDetailsValueBean> deleteAccount(UserValueBean userValueBean,
			RemoveAccountFormBean removeAccountFormBean, Connection con) throws SQLException;

	public Map<String, AccountDetailsValueBean> transferAmount(UserValueBean userValueBean,
			FundTransferFormBean fundTransferFormBean, Connection con) throws Exception;

}
