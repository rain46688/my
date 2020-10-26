package com.kh.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.spring.board.model.vo.Attachment;
import com.kh.spring.board.model.vo.Board;

public interface BoardDao {

	int boardCount(SqlSession session);

	List<Map<String, Integer>> boardList(SqlSession session, Map<String, Integer> map);

	int insertBoard(SqlSession session, Board board);

	int insertAttachment(SqlSession session, Attachment file);

}
