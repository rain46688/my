package com.kh.spring.member.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.spring.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Override
	public int insertMember(SqlSession session, Member m) {
		return session.insert("member.insertMember", m);
	}

	@Override
	public Member loginMember(SqlSession session, Member member) {
		// TODO Auto-generated method stub
		return session.selectOne("member.LoginMember", member);
	}

	@Override
	public int updateMmeber(SqlSession session, Member m) {
		// TODO Auto-generated method stub
		return session.update("member.updateMember", m);
	}

}
