package com.yi.service;

import com.yi.domain.MessageVO;

public interface MessageService {
	public void addMessage(MessageVO vo);
	
	public MessageVO readMessage(String uid, int mid);
}
