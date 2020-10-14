package com.cms.model.dao;

import java.util.List;
import java.util.Map;

import com.cms.model.vo.Login;
import com.cms.model.vo.Member;

public interface TestDao {

	List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception;

	int getNoticeCount();

	int getBoardCount(Map<String, Object> commandMap);

	Login loginCheck(String id);

	void joinMember(Member member);

	List<Map<String, Object>> selectBoardList(Map<String, Object> commandMap);
}
