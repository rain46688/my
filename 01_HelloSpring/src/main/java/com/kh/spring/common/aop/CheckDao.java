package com.kh.spring.common.aop;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CheckDao {

	@Autowired
	private SqlSession session;

	public int insertCheck(Map param) {
		return session.insert("memo.insertCheck", param);
	}

}
