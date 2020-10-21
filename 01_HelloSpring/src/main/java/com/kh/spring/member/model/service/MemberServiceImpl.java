package com.kh.spring.member.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.member.model.dao.MemberDao;
import com.kh.spring.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDao dao;

	@Autowired
	private SqlSession session;
	
	@Override
	public int insertMember(Member m) {
		
		return dao.insertMember(session,m);
		
	}
	
	
	
}
