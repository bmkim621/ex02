package com.yi.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	

	//테스트
	@RequestMapping(value = "hello", method = RequestMethod.GET)
	public @ResponseBody String sayHello() {
		//@ResponseBody : hello 키를 입력했을 때 Hello World.jsp 파일로 가는게 아니라 말그대로 String으로 출력됨.(데이터만 그냥 전송)
		return "Hello World";
	}
	
	@RequestMapping(value = "test", method = RequestMethod.GET)
	public String test() {
		logger.info("test =====> get");
		
		return "test";
	}
}
