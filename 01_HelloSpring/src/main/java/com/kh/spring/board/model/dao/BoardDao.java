package com.kh.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface BoardDao {

	int boardCount(SqlSession session);

	List<Map<String, Integer>> boardList(SqlSession session, Map<String, Integer> map);

}
