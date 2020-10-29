package com.kh.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.spring.board.model.vo.Attachment;
import com.kh.spring.board.model.vo.Board;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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

	@Override
	public int insertBoard(SqlSession session, Board board) {
		log.debug(" ========== insertBoard dao =========");
		// TODO Auto-generated method stub
		return session.insert("board.insertBoard", board);
	}

	@Override
	public int insertAttachment(SqlSession session, Attachment file) {
		// TODO Auto-generated method stub
		return session.insert("board.insertAttachment", file);
	}

	@Override
	public Board selctBoard(SqlSession session, int no) {
		// TODO Auto-generated method stub
		return session.selectOne("board.selectBoard", no);
	}

	@Override
	public List<Attachment> selctAttachmentList(SqlSession session, int no) {
		// TODO Auto-generated method stub
		return session.selectList("board.selectAttachmentList", no);
	}

}
