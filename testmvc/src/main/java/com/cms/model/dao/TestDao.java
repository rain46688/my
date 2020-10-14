package com.cms.model.dao;

import java.util.List;
import java.util.Map;

import com.cms.model.vo.Login;
import com.cms.model.vo.Member;

public interface TestDao {

	List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception;

	int getNoticeCount() throws Exception;

	int getBoardCount(Map<String, Object> commandMap) throws Exception;

	Login loginCheck(String id) throws Exception;

	void joinMember(Member member) throws Exception;

	List<Map<String, Object>> selectBoardList(Map<String, Object> commandMap) throws Exception;

	Map<String, Object> boardPage(Map<String, Object> commandMap) throws Exception;

	void updateReadCount(Map<String, Object> commandMap) throws Exception;

	List<Integer> tradeUserList(Map<String, Object> commandMap) throws Exception;
}