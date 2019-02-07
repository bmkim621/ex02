package com.yi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.yi.domain.SampleVO;

@RestController
@RequestMapping("/sample/*")
public class SampleController {
	
	@RequestMapping("/hello")
	public String sayHello() {
		
		return "Hello World";
	}
	
	@RequestMapping("/sendVO")
	public SampleVO sendVO() {
		SampleVO vo = new SampleVO();
		vo.setMno(1234);
		vo.setFirstName("길동");
		vo.setLastName("홍");
		
		return vo;
	}
	
	@RequestMapping("/sendList")
	public List<SampleVO> sendList(){
		List<SampleVO> list = new ArrayList<>();
		
		for(int i = 0 ; i < 10 ; i++) {
			SampleVO vo = new SampleVO();
			vo.setMno(i);
			vo.setFirstName("길동" + i);
			vo.setLastName("홍");
			
			list.add(vo);
		}
		return list;
	}
	
	@RequestMapping("/sendMap")
	public Map<String, SampleVO> sendMap(){
		Map<String, SampleVO> map = new HashMap<>();
		
		for(int i = 0 ; i < 10 ; i++) {
			SampleVO vo = new SampleVO();
			vo.setMno(i);
			vo.setFirstName("길동" + i);
			vo.setLastName("홍");
			
			map.put(""+i, vo);
		}
		return map;
	}
	
	//에러
	@RequestMapping("/sendErrorAuth")
	public ResponseEntity<Void> sendListAuth(){
	 
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);	//400 에러 강제로 발생시킴.
	}
	
	//데이터와 에러 같이 보내기
	@RequestMapping("/sendMapStatus")
	public ResponseEntity<Map<String, SampleVO>> sendMapStatus(){
		
		Map<String, SampleVO> map = new HashMap<>();
		
		for(int i = 0 ; i < 10 ; i++) {
			SampleVO vo = new SampleVO();
			vo.setMno(i);
			vo.setFirstName("길동" + i);
			vo.setLastName("홍");
			
			map.put(""+i, vo);
		}
		
		ResponseEntity<Map<String, SampleVO>> res = new ResponseEntity<Map<String,SampleVO>>(map, HttpStatus.NOT_FOUND);
		return res;
	}
}
