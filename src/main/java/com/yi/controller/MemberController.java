package com.yi.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.yi.domain.MemberVO;
import com.yi.service.MemberService;

@RestController
@RequestMapping("/member/*")
public class MemberController {
	//로그로 확인하기
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService service;
	
	//1. 추가
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody MemberVO vo){
		
		ResponseEntity<String> entity = null;
		
		logger.info("===== Member Register ===== " + vo);
		
		try {
			service.insertMember(vo);
			entity = new ResponseEntity<String>("Success", HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//2. 리스트 가져오기
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ResponseEntity<List<MemberVO>> list(){
		ResponseEntity<List<MemberVO>> entity = null;
		
		logger.info("===== Member list ===== ");
		
		try {
			List<MemberVO> list = service.selectAll();
			entity = new ResponseEntity<>(list, HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//3. 수정하기
	@RequestMapping(value = "{userid}", method = RequestMethod.PUT)
	public ResponseEntity<String> update(@PathVariable("userid") String userid, @RequestBody MemberVO vo){
		ResponseEntity<String> entity = null;
		
		logger.info("===== Member Modify ===== ");
		
		try {
			vo.setUserid(userid);
			service.updateMember(vo);
			
			entity = new ResponseEntity<String>("Success", HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//4. 삭제하기
	@RequestMapping(value = "{userid}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("userid") String userid){
		ResponseEntity<String> entity = null;
		
		logger.info("===== Member Delete ===== ");
		
		try {
			service.deleteMember(userid);
			entity = new ResponseEntity<String>("Success", HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
