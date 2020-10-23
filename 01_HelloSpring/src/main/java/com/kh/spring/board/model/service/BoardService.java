package com.kh.spring.board.model.service;

import java.util.List;
import java.util.Map;

public interface BoardService {

	List<Map<String, Integer>> boardList(Map<String, Integer> map);

	int boardCount();

}
