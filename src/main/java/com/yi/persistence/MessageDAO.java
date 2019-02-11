package com.yi.persistence;

import com.yi.domain.MessageVO;

public interface MessageDAO {
	public void create(MessageVO vo);
	
	public MessageVO readMessage(int mid);
	
	public void updateState(int mid);
}
