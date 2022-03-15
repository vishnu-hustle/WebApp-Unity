package edu.groupc.project.beans;

/**
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 *         This bean holds the data of Csah Transaction
 *
 */
public class CashTransactionFormBean {

	private String accountNumber;
	private boolean isCredit;
	private boolean isDebit;
	private double amount;

	/**
	 * @return the accountNumber
	 */
	public String getAccountNumber() {
		return accountNumber;
	}

	/**
	 * @param accountNumber the accountNumber to set
	 */
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	/**
	 * @return the isCredit
	 */
	public boolean isCredit() {
		return isCredit;
	}

	/**
	 * @param isCredit the isCredit to set
	 */
	public void setCredit(boolean isCredit) {
		this.isCredit = isCredit;
	}

	/**
	 * @return the isDebit
	 */
	public boolean isDebit() {
		return isDebit;
	}

	/**
	 * @param isDebit the isDebit to set
	 */
	public void setDebit(boolean isDebit) {
		this.isDebit = isDebit;
	}

	/**
	 * @return the amount
	 */
	public double getAmount() {
		return amount;
	}

	/**
	 * @param d the amount to set
	 */
	public void setAmount(double d) {
		this.amount = d;
	}

}
