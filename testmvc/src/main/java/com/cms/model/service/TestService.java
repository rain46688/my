package com.cms.model.service;

import java.util.List;
import java.util.Map;

import com.cms.model.vo.Login;
import com.cms.model.vo.Member;
import com.cms.model.vo.SessionVo;

public interface TestService {

	List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception;

	int getNoticeCount() throws Exception;

	SessionVo loginCheck(Login login) throws Exception;

	void joinMember(Member member) throws Exception;

	List<Map<String, Object>> selectBoardList(Map<String, Object> commandMap) throws Exception;

	int getBoardCount(Map<String, Object> commandMap) throws Exception;

	Map<String, Object> boardPage(Map<String, Object> commandMap) throws Exception;

	List<Integer> tradeUserList(Map<String, Object> commandMap) throws Exception;

	int likeCount(Map<String, Object> commandMap) throws Exception;

	List<Integer> paidUsersList(Map<String, Object> commandMap) throws Exception;

	List<Integer> deliveryUsersList(Map<String, Object> commandMap) throws Exception;

}
