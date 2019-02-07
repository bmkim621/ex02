package com.yi.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/member/*")
public class MemberController {
	//로그로 확인하기
		private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
}
