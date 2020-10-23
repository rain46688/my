package com.kh.spring.board.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.board.model.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService service;

	@RequestMapping("/board/boardList.do")
	public ModelAndView boardList(@RequestParam(required = false) Map<String, Integer> map) {

		ModelAndView mv = new ModelAndView("board/boardList");
		if (map.get("cPage") == null) {
			map = new HashMap<String, Integer>();
			map.put("cPage", 0);
		}
		map.put("numPerPage", 10);

		mv.addObject("list", service.boardList(map));
		mv.addObject("totalCount", service.boardCount());
		mv.addObject("numPerPage", map.get("numPerPage"));
		return mv;
	}

}
