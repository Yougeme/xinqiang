package com.charmyin.cmstudio.basic.authorize.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.charmyin.cmstudio.basic.authorize.form.RegistrationForm;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:test-context.xml"})
public class IdentityServiceT {
	
	@Autowired(required = true)
	 private IdentityService identityService;
	
	@Test
	public void testregisterIdentity(){
		RegistrationForm rg = new RegistrationForm();
		rg.setPassphrase("123456");
		rg.setEmail("default@default.com");
		rg.setLoginId("default");
		this.identityService.registerIdentity(rg);
		System.out.println("Successs!!!");
	}

	public IdentityService getIdentityService() {
		return identityService;
	}

	public void setIdentityService(IdentityService identityService) {
		this.identityService = identityService;
	}
}
