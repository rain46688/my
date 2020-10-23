package com.kh.spring.memo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MemoDaoImpl implements MemoDao {

	@Override
	public int insertMemo(SqlSession session, Map<String, Object> parammap) {
		// TODO Auto-generated method stub
		return session.insert("memo.memoInsert", parammap);
	}

	@Override
	public List<Map<String, Integer>> memoList(SqlSession session, Map<String, Integer> map) {
		// TODO Auto-generated method stub
		int cPage = Integer.parseInt(String.valueOf(map.get("cPage")));
		int numPerPage = Integer.parseInt(String.valueOf(map.get("numPerPage")));
		RowBounds r = new RowBounds(((cPage - 1) * numPerPage), numPerPage);
		return session.selectList("memo.memoList", null, r);

	}

	@Override
	public Object getMemoCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("memo.getMemoCount");
	}

	@Override
	public int memodel(SqlSession session, int no) {
		// TODO Auto-generated method stub
		return session.delete("memo.memodel", no);
	}

}
