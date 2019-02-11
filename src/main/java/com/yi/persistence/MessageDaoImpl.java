package com.yi.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.domain.MessageVO;

@Repository
public class MessageDaoImpl implements MessageDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.yi.mapper.MessageMapper";

	@Override
	public void create(MessageVO vo) {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace + ".create", vo);
	}

	@Override
	public MessageVO readMessage(int mid) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".readMessage", mid);
	}

	@Override
	public void updateState(int mid) {
		// TODO Auto-generated method stub
		sqlSession.update(namespace + ".updateState", mid);
	}

}
