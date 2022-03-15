package edu.groupc.project.service;

import java.sql.Connection;

import edu.groupc.project.beans.LoginForm;
import edu.groupc.project.beans.UserValueBean;

/**
 * This is an inteface for login Service
 * 
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 *
 */
public interface LoginService {

	public UserValueBean getUserDetails(LoginForm loginForm, Connection con);
}
