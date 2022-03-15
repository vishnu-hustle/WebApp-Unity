package edu.groupc.project.service;

import java.sql.Connection;

import edu.groupc.project.beans.RegistrationFormBean;
import edu.groupc.project.repository.RegistrationDbRepo;

/**
 * This is an Implementation for RegistrationService
 * 
 * @author GroupC(Doshi Pratik, Duraipandi Vasanth,Kuladeep Perumalla, Pawan,
 *         Sugam, Pabbathi Vishnuvardhan Reddy)
 *
 */
public class RegistrationServiceImpl implements RegistrationService {

	/**
	 * This method is a service layer method used to register the new user
	 */
	@Override
	public boolean createNewUser(RegistrationFormBean registrationFormBean, Connection con) {

		RegistrationDbRepo registrationDbRepo = new RegistrationDbRepo();
	
		return registrationDbRepo.createUser(registrationFormBean, con);
	}

}
