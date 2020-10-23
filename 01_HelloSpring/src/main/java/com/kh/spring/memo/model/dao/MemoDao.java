package com.kh.spring.memo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface MemoDao {

	int insertMemo(SqlSession session, Map<String, Object> parammap);

	List<Map<String, Integer>> memoList(SqlSession session, Map<String, Integer> map);

	Object getMemoCount(SqlSession session);

	int memodel(SqlSession session, int no);

}
