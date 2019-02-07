package com.yi.ex02;

import java.util.List;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yi.domain.ReplyVO;
import com.yi.persistence.ReplyDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ReplyDAOTest {

	@Autowired
	private ReplyDAO dao;
	
	//@Test
	public void test01CreateReply() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(34804);
		vo.setReplyer("잠온다");
		vo.setReplytext("피곤...");
		
		dao.create(vo);
	}
	
	@Test
	public void test02List() {
		List<ReplyVO> list = dao.list(34804);
		for(ReplyVO vo : list) {
			System.out.println(vo);
		}
	}
	
	//@Test
	public void test03UpdateReply() {
		ReplyVO vo = new ReplyVO();
		vo.setReplytext("댓글 수정하기 테스트ㅎㅎ");
		vo.setRno(11);
		
		dao.update(vo);
	}
	
	//@Test
	public void test04DeleteReply() {
		dao.delete(6);
	}
}
