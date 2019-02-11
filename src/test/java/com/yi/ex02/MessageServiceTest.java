package com.yi.ex02;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yi.domain.MessageVO;
import com.yi.service.MessageService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MessageServiceTest {

	@Autowired
	private MessageService service;
	
	//@Test
	public void testAddMessage() {
		MessageVO vo = new MessageVO();
		vo.setSender("user00");
		vo.setTargetid("user01");
		vo.setMessage("테스트 메시지 00 -> 01");
		
		service.addMessage(vo);
	}
	
	//@Test
	public void testReadMessage() {
		service.readMessage("user01", 1);
	}
}
