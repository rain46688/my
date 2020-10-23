package com.kh.spring.memo.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.memo.model.dao.MemoDao;

@Service
public class MemoServiceImpl implements MemoService {

	@Autowired
	private MemoDao dao;

	@Autowired
	private SqlSession session;

	@Override
	public int insertMemo(Map<String, Object> parammap) {
		// TODO Auto-generated method stub
		return dao.insertMemo(session, parammap);
	}

	@Override
	public List<Map<String, Integer>> memoList(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return dao.memoList(session, map);
	}

	@Override
	public Object getMemoCount() {
		// TODO Auto-generated method stub
		return dao.getMemoCount(session);
	}

	@Override
	public int memodel(int no) {
		// TODO Auto-generated method stub
		return dao.memodel(session, no);
	}

}
