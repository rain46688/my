package com.kh.spring.member.model.service;

import com.kh.spring.member.model.vo.Member;

public interface MemberService {
	int insertMember(Member m);

	Member loginMember(Member member);

	int updateMember(Member m);
}
