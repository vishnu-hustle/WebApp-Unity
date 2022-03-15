package edu.groupc.project.constants;

/**
 * This class Consist of SQL queries DB instance
 * 
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 *
 */
public class SqlQueries {

	public static final String CREATE_USER = "Insert into CUSTOMERS(Username,Passwrd,Email,FirstName,LastName,DateOfBirth,Address,Phonenumber) values(?,?,?,?,?,?,?,?)";
	public static final String GET_CUSTOMER = "select * from customers where username=? and passwrd=? ";
	public static final String GET_ACCOUNTS = "select * from ACCOUNTS where CustId=?";
	public static final String UPDATE_CUSTOMER_DETAILS = "update customers set username=?, email=?, firstname=?, lastname=?, dateofbirth=?, address=?,phonenumber=? where custid=?";
	public static final String UPDATE_CASH_TRANSACTION = "update accounts set balanace=? where accnumber=?";
	public static final String DELETE_CUSTOMER = "delete from accounts where accnumber=? and custid=?";
	public static final String ADD_ACCOUNT = "insert into accounts(ACCNUMBER,CUSTID,IFSCCODE,BRANCH,BALANACE) values(?,?,?,?,?)";
	public static final String UPDATE_MAIN_ACCOUNT_BALANCE = "update accounts set balanace=? where accnumber=? ";
	public static final String UPDATE_CHILD_ACCOUNT_BALANCE = "update accounts set balanace=? where accnumber=? and IFSCCODE=?";
	public static final String SELECT_TRANSFER_ACCOUNT_BALANCE = "select balanace from ACCOUNTS where accnumber=? and IFSCCODE=?";
	public static final String UPDATE_TRANSFER_ACCOUNT_BALANCE = "update accounts set balanace=? where accnumber=? and IFSCCODE=?";
}
