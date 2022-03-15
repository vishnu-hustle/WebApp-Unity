package edu.groupc.project.service;

import java.sql.Connection;

import edu.groupc.project.beans.RegistrationFormBean;

/**
 * This is an interface for RegistrationService
 * 
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 */
public interface RegistrationService {

	public boolean createNewUser(RegistrationFormBean registrationFormBean, Connection con);

}
