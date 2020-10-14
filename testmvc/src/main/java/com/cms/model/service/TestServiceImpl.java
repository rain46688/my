package com.cms.model.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cms.common.exception.BoardPageNotFoundException;
import com.cms.common.exception.IdPasswordNotMatchingException;
import com.cms.common.exception.MemberInsertFailedException;
import com.cms.model.dao.TestDao;
import com.cms.model.vo.Login;
import com.cms.model.vo.Member;
import com.cms.model.vo.SessionVo;

@Service("testService")
public class TestServiceImpl implements TestService {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "testDAO")
	private TestDao testDAO;

	@Override
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return testDAO.selectNoticeList(map);
	}

	@Override
	public int getNoticeCount() throws Exception {
		// TODO Auto-generated method stub
		return testDAO.getNoticeCount();
	}

	@SuppressWarnings("unused")
	@Override
	public SessionVo loginCheck(Login login) throws Exception {
		// TODO Auto-generated method stub
		Login lo = testDAO.loginCheck(login.getMemberId());
		SessionVo sv = new SessionVo();

		if (lo == null) {
			throw new IdPasswordNotMatchingException();
		}

		if (!lo.checkPassword(login.getMemberPw())) {
			log.debug("lo : " + lo.getMemberId() + " " + lo.getMemberPw());
			throw new IdPasswordNotMatchingException();
		}
		sv.setMemberPw(login.getMemberPw());
		sv.setMemberId(login.getMemberId());
		return sv;
	}

	@Override
	public void joinMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		if (member != null)
			testDAO.joinMember(member);
		else {
			throw new MemberInsertFailedException();
		}
	}

	@Override
	public int getBoardCount(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return testDAO.getBoardCount(commandMap);
	}

	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return testDAO.selectBoardList(commandMap);
	}

	@Override
	public Map<String, Object> boardPage(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = testDAO.boardPage(commandMap);
		if (map == null) {
			throw new BoardPageNotFoundException();
		} else if (!(Boolean) commandMap.get("hasRead")) {
			try {
				testDAO.updateReadCount(commandMap);
			} catch (Exception e) {
				return null;
			}
		}
		return map;
	}

	@Override
	public List<Integer> tradeUserList(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return testDAO.tradeUserList(commandMap);
	}

}