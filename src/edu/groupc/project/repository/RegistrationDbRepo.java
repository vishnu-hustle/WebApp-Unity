package edu.groupc.project.repository;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;

import edu.groupc.project.beans.RegistrationFormBean;
import edu.groupc.project.constants.SqlQueries;

/**
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 *         RegistrationDbRepo connects with DB and helps in Inserting New User
 *         data to the DB
 *
 */
public class RegistrationDbRepo {

	/**
	 * This Repository takes the registrationFormBean and inserts the data to the
	 * data base
	 * 
	 * @param registrationFormBean
	 * @return success/failure in inserting data
	 */
	public boolean createUser(RegistrationFormBean registrationFormBean, Connection con) {
		boolean isSuccess = false;
		try {

			PreparedStatement stmt = con.prepareStatement(SqlQueries.CREATE_USER);

			stmt.setString(1, registrationFormBean.getUserName());
			stmt.setString(2, registrationFormBean.getNewPassword());
			stmt.setString(3, registrationFormBean.getEmail());
			stmt.setString(4, registrationFormBean.getFirstName());
			stmt.setString(5, registrationFormBean.getLastName());
			String dateString = registrationFormBean.getDateOfBirth();
			stmt.setDate(6, java.sql.Date.valueOf(dateString));
			stmt.setString(7, registrationFormBean.getAddress());
			stmt.setBigDecimal(8, BigDecimal.valueOf(Long.valueOf(registrationFormBean.getPhoneNumber())));

			int i = stmt.executeUpdate();
			if (i == 1) {
				isSuccess = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			isSuccess = false;
			return isSuccess;
		}

		return isSuccess;

	}

}
