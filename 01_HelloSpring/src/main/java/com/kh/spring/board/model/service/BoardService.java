package com.kh.spring.board.model.service;

import java.util.List;
import java.util.Map;

import com.kh.spring.board.model.vo.Attachment;
import com.kh.spring.board.model.vo.Board;

public interface BoardService {

	List<Map<String, Integer>> boardList(Map<String, Integer> map);

	int boardCount();

	int insertBoard(Board board, List<Attachment> files);

}
