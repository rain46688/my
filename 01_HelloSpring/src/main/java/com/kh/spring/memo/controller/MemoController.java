package com.kh.spring.memo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.memo.model.service.MemoService;

@Controller
public class MemoController {

	@Autowired
	private MemoService service;

	Logger log = LoggerFactory.getLogger(this.getClass());

	@RequestMapping("/memo/memo.do")
	public ModelAndView memo(@RequestParam(required = false) Map<String, Integer> map) {
		log.debug(" === memo 실행 === ");

		if (map.get("cPage") == null) {
			map = new HashMap<String, Integer>();
			map.put("cPage", 0);
		}
		map.put("numPerPage", 10);
		List<Map<String, Integer>> list = service.memoList(map);

//		for (Map<String, Integer> m : list) {
//			Iterator<String> it = map.keySet().iterator();
//			while (it.hasNext()) {
//				String key = it.next();
//				log.info("key : " + key + " value : " + map.get(key));
//			}
//		}

		ModelAndView mv = new ModelAndView("memo/memo");
		mv.addObject("list", list);
		mv.addObject("totalCount", Integer.parseInt(String.valueOf(service.getMemoCount())));
		mv.addObject("numPerPage", map.get("numPerPage"));
		return mv;
	}

	@RequestMapping(value = "/memo/memoinsert.do", method = RequestMethod.POST)
	public ModelAndView memoInsert(@RequestParam Map<String, Object> parammap) {
		log.debug(" === memoInsert 실행 === ");
		log.debug(parammap.get("memo") + " " + parammap.get("password"));
		int result = service.insertMemo(parammap);

		String msg = "";
		String loc = "";

		if (result > 0) {
			msg = "메모 작성 성공";
			loc = "/memo/memo.do";
		} else {
			msg = "메모 작성 실패";
			loc = "/memo/memo.do";
		}
		ModelAndView mv = new ModelAndView("common/msg");
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		return mv;
	}

	@RequestMapping(value = "/memo/memodel.do")
	public ModelAndView memodel(int no) {
		log.debug(" === memodel 실행 === ");

		int result = service.memodel(no);

		String msg = "";
		String loc = "";

		if (result > 0) {
			msg = "메모 삭제 성공";
			loc = "/memo/memo.do";
		} else {
			msg = "메모 삭제 실패";
			loc = "/memo/memo.do";
		}
		ModelAndView mv = new ModelAndView("common/msg");
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		return mv;
	}

}
