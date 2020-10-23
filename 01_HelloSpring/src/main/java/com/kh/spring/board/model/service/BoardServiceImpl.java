package com.kh.spring.board.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.board.model.dao.BoardDao;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao dao;

	@Autowired
	private SqlSession session;

	@Override
	public List<Map<String, Integer>> boardList(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return dao.boardList(session, map);
	}

	@Override
	public int boardCount() {
		// TODO Auto-generated method stub
		return dao.boardCount(session);
	}

}
