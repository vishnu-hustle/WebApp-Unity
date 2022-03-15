package edu.groupc.project.service;

import java.sql.Connection;

import edu.groupc.project.beans.LoginForm;
import edu.groupc.project.beans.UserValueBean;
import edu.groupc.project.repository.UserDetailsRepo;

/**
 * This is an Implementation for login Service
 * 
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 */
public class LoginServiceImpl implements LoginService {
	/**
	 * This method is a service layer method used to retreive login details
	 */
	@Override
	public UserValueBean getUserDetails(LoginForm loginForm, Connection con) {
		UserDetailsRepo userDetailsRepo = new UserDetailsRepo();

		return userDetailsRepo.fetchUserDetails(loginForm, con);
	}

}
