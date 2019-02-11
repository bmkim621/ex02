package com.yi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yi.domain.MessageVO;
import com.yi.persistence.MessageDAO;
import com.yi.persistence.PointDAO;

@Service
public class MessageServiceImpl implements MessageService {

	@Autowired
	private MessageDAO messageDao;
	
	@Autowired
	private PointDAO pointDao;
	
	@Override
	public void addMessage(MessageVO vo) {
		// TODO Auto-generated method stub
		messageDao.create(vo);
		//메시지 남기면 남긴사람의 포인트 10 증가
		pointDao.updatePoint(vo.getSender(), 10);
	}

	@Override
	@Transactional
	public MessageVO readMessage(String uid, int mid) {
		// TODO Auto-generated method stub
		messageDao.updateState(mid);
		//읽는 사람의 포인트 5 증가
		pointDao.updatePoint(uid, 5);
		
		return messageDao.readMessage(mid);
	}

}
