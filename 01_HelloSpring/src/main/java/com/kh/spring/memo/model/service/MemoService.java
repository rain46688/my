package com.kh.spring.memo.model.service;

import java.util.List;
import java.util.Map;

public interface MemoService {

	int insertMemo(Map<String, Object> parammap);

	List<Map<String, Integer>> memoList(Map<String, Integer> map);

	Object getMemoCount();

	int memodel(int no);

}
