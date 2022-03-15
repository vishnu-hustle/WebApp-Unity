package edu.groupc.project.beans;

/**
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 *         This bean holds the data of Fund Transfer
 *
 */

public class FundTransferFormBean {

	private String accountNumber;
	private String transferAccountNumber;
	private String transferIfscCode;
	private double transferAmount;
	private boolean isWithin;

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
	 * @return the transferAccountNumber
	 */
	public String getTransferAccountNumber() {
		return transferAccountNumber;
	}

	/**
	 * @param transferAccountNumber the transferAccountNumber to set
	 */
	public void setTransferAccountNumber(String transferAccountNumber) {
		this.transferAccountNumber = transferAccountNumber;
	}

	/**
	 * @return the transferIfscCode
	 */
	public String getTransferIfscCode() {
		return transferIfscCode;
	}

	/**
	 * @param transferIfscCode the transferIfscCode to set
	 */
	public void setTransferIfscCode(String transferIfscCode) {
		this.transferIfscCode = transferIfscCode;
	}

	/**
	 * @return the transferAmount
	 */
	public double getTransferAmount() {
		return transferAmount;
	}

	/**
	 * @param transferAmount the transferAmount to set
	 */
	public void setTransferAmount(double transferAmount) {
		this.transferAmount = transferAmount;
	}

	/**
	 * @return the isWithin
	 */
	public boolean isWithin() {
		return isWithin;
	}

	/**
	 * @param isWithin the isWithin to set
	 */
	public void setWithin(boolean isWithin) {
		this.isWithin = isWithin;
	}
}
