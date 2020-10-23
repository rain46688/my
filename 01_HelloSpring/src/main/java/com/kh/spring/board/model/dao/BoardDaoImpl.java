package com.kh.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Override
	public List<Map<String, Integer>> boardList(SqlSession session, Map<String, Integer> map) {
		// TODO Auto-generated method stub
		int cPage = Integer.parseInt(String.valueOf(map.get("cPage")));
		int numPerPage = Integer.parseInt(String.valueOf(map.get("numPerPage")));
		RowBounds r = new RowBounds(((cPage - 1) * numPerPage), numPerPage);
		return session.selectList("board.boardList", null, r);
	}

	@Override
	public int boardCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("board.boardCount");
	}

}
