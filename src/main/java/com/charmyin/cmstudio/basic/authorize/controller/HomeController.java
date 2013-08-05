package com.charmyin.cmstudio.basic.authorize.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.charmyin.cmstudio.basic.authorize.domain.Identity;
import com.charmyin.cmstudio.basic.authorize.service.IdentityService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	  @Autowired(required = true)
	  IdentityService identityService;
	  @Autowired(required = true)
	  DataSource dataSource;


	  /**
	   * Does some simple work to find the current shiro subject gets a list of
	   * services, and the date.
	   */
	  @RequestMapping(method = RequestMethod.GET, value = { "/", "/index" })
	  public String home(Locale locale, Model model, HttpServletRequest request) {
	    logger.info("Welcome home! the client locale is " + locale.toString());

	    /*
	    // This gets the current subject from shiro
	    Subject currentUser = SecurityUtils.getSubject();
	    request.getSession().setAttribute("","");
	    // I was going to have more services, who knows .. maybe we will add
	    // more.
	    List<String> services = new ArrayList<String>();
	    // My SQL class org.apache.commons.dbcp.BasicDataSource
//	    if (dataSource instanceof BasicDataSource) {
//	      services.add("Data Source: " + ((BasicDataSource) dataSource).getUrl());
//	    } else if (dataSource instanceof SimpleDriverDataSource) {
//	      services.add("Data Source: " + ((SimpleDriverDataSource) dataSource).getUrl());
//	    }

	    services.add("PostgreSQL: " + dataSource.getClass());

	    // Just to prove we can do it.
	    Date date = new Date();
	    DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

	    String formattedDate = dateFormat.format(date);

	    model.addAttribute("serverTime", formattedDate);

	    // Lets get an identity object
	    Identity thisIdentity = null;

	    // Remembered (from cookie) is different from authenticated in Shiro
	    if (currentUser.isRemembered()) {
	      logger.info("Remembered PRINCIPAL: " + currentUser.getPrincipal());
	      thisIdentity = identityService.getIdentity(currentUser.getPrincipal().toString());

	      // Authenticated, we really do believe they are who they claim to
	      // be!
	    } else if (currentUser.isAuthenticated()) {
	      logger.info("Authenticated PRINCIPAL: " + currentUser.getPrincipal());
	      thisIdentity = identityService.getIdentity(currentUser.getPrincipal().toString());
	    }

	    // Pass this to the jsp.
	    model.addAttribute("currentUser", currentUser);
	    model.addAttribute("identity", thisIdentity);
	    model.addAttribute("serverTime", formattedDate);
	    model.addAttribute("services", services);
	    //return "home";
*/	    
	    return "basic/index";
	  }
	
}
