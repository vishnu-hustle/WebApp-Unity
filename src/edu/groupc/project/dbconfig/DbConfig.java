package edu.groupc.project.dbconfig;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.sun.org.slf4j.internal.Logger;
import com.sun.org.slf4j.internal.LoggerFactory;

import edu.groupc.project.constants.DataBaseConstants;

/**
 * This class Consist of Configuration details of DB instance
 * 
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 *
 */
public class DbConfig {

	private String jdbcDriverClassName;
	private String jdbcUrl;
	private String jdbcUserName;
	private String jdbcPassword;
	private static final Logger LOGGER = LoggerFactory.getLogger(DbConfig.class);

	public DbConfig() {
		super();
		this.jdbcDriverClassName = DataBaseConstants.JDBC_DRIVER_CLASS_NAME;
		this.jdbcUrl = DataBaseConstants.JDBC_URL;
		this.jdbcUserName = DataBaseConstants.JDBC_USERNAME;
		this.jdbcPassword = DataBaseConstants.JDBC_PASSWORD;
	}

	/**
	 * @return the jdbcDriverClassName
	 */
	public String getJdbcDriverClassName() {
		return jdbcDriverClassName;
	}

	/**
	 * @param jdbcDriverClassName the jdbcDriverClassName to set
	 */
	public void setJdbcDriverClassName(String jdbcDriverClassName) {
		this.jdbcDriverClassName = jdbcDriverClassName;
	}

	/**
	 * @return the jdbcUrl
	 */
	public String getJdbcUrl() {
		return jdbcUrl;
	}

	/**
	 * @param jdbcUrl the jdbcUrl to set
	 */
	public void setJdbcUrl(String jdbcUrl) {
		this.jdbcUrl = jdbcUrl;
	}

	/**
	 * @return the jdbcUserName
	 */
	public String getJdbcUserName() {
		return jdbcUserName;
	}

	/**
	 * @param jdbcUserName the jdbcUserName to set
	 */
	public void setJdbcUserName(String jdbcUserName) {
		this.jdbcUserName = jdbcUserName;
	}

	/**
	 * @return the jdbcPassword
	 */
	public String getJdbcPassword() {
		return jdbcPassword;
	}

	/**
	 * @param jdbcPassword the jdbcPassword to set
	 */
	public void setJdbcPassword(String jdbcPassword) {
		this.jdbcPassword = jdbcPassword;
	}

	public Connection getDatabaseConnection() throws ClassNotFoundException, SQLException {
		LOGGER.trace("Establising connection with Database");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		return DriverManager.getConnection(this.getJdbcUrl(), this.getJdbcUserName(), this.getJdbcPassword());
	}
}
