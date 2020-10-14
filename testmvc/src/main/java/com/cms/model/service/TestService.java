package com.cms.model.service;

import java.util.List;
import java.util.Map;

import com.cms.model.vo.Login;
import com.cms.model.vo.Member;
import com.cms.model.vo.SessionVo;

public interface TestService {

	List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception;

	int getNoticeCount();

	SessionVo loginCheck(Login login);

	void joinMember(Member member);

	List<Map<String, Object>> selectBoardList(Map<String, Object> commandMap);

	int getBoardCount(Map<String, Object> commandMap);

}
