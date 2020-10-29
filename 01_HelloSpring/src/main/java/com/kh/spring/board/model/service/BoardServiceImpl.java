package com.kh.spring.board.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.board.model.dao.BoardDao;
import com.kh.spring.board.model.vo.Attachment;
import com.kh.spring.board.model.vo.Board;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao dao;

	@Autowired
	private SqlSession session;

	@Override
	public List<Map<String, Integer>> boardList(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return dao.boardList(session, map);
	}

	@Override
	public int boardCount() {
		// TODO Auto-generated method stub
		return dao.boardCount(session);
	}

	@Override
//	@Transactional
	// 트랜잭션 처리 어노테이션 예외가 발생하면 트랜잭션이 처리되서 롤백됨
	// @Transactional() 괄호에 옵션을 넣을수있다!
	public int insertBoard(Board board, List<Attachment> files) throws RuntimeException {
		// TODO Auto-generated method stub
		log.debug(" ========== insertBoard service =========");
		// inesrt 두개 처리
		log.debug("boardNo값 전: " + board.getBoardNo());
		int result = dao.insertBoard(session, board);
		log.debug("boardNo값 후 : " + board.getBoardNo());
		if (result > 0) {
			if (!files.isEmpty()) {
				for (Attachment file : files) {
					file.setBoardNo(board.getBoardNo());
					result = dao.insertAttachment(session, file);
					if (result == 0)
						throw new RuntimeException("입력오류");
				}
			}
		}
		return result;
	}

	@Override
	public Board selctBoard(int no) {
		// TODO Auto-generated method stub
		return dao.selctBoard(session, no);
	}

	@Override
	public List<Attachment> selctAttachmentList(int no) {
		// TODO Auto-generated method stub
		return dao.selctAttachmentList(session, no);
	}

}
