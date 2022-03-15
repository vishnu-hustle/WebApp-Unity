package edu.groupc.project.beans;

import java.util.Map;

/**
 * @author Group9(Ankita, Doshi Pratik, Duraipandi Vasanth, Kaur Awalpreet,
 *         Pabbathi Vishnuvardhan Reddy)
 *
 *         This bean holds the data of User level
 *
 */

public class UserValueBean {

	private static UserValueBean instance = new UserValueBean();

	public static UserValueBean getInstance() {
		if (instance == null) {
			// if instance is null, initialize
			instance = new UserValueBean();
		}
		return instance;
	}

	public static void deleteInstance() {
		instance = new UserValueBean();
	}

	private Map<String, AccountDetailsValueBean> accountDetailsValueBeanList;
	private CustomerDetailsValueBean customerDetailsValueBean;

	/**
	 * @return the accountDetailsValueBean
	 */
	public Map<String, AccountDetailsValueBean> getAccountDetailsValueBean() {
		return accountDetailsValueBeanList;
	}

	/**
	 * @param accountDetailsValueBean the accountDetailsValueBean to set
	 */
	public void setAccountDetailsValueBean(Map<String, AccountDetailsValueBean> accountDetailsValueBean) {
		this.accountDetailsValueBeanList = accountDetailsValueBean;
	}

	/**
	 * @return the customerDetailsValueBean
	 */
	public CustomerDetailsValueBean getCustomerDetailsValueBean() {
		return customerDetailsValueBean;
	}

	/**
	 * @param customerDetailsValueBean the customerDetailsValueBean to set
	 */
	public void setCustomerDetailsValueBean(CustomerDetailsValueBean customerDetailsValueBean) {
		this.customerDetailsValueBean = customerDetailsValueBean;
	}

}
