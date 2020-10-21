package com.kh.spring.member.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.kh.spring.member.model.vo.Member;

public interface MemberDao {

	int insertMember(SqlSession session, Member m);

	Member loginMember(SqlSession session, Member member);

	int updateMmeber(SqlSession session, Member m);
}
