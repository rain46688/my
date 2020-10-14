package com.cms.model.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cms.model.vo.Login;
import com.cms.model.vo.Member;

@Repository("testDAO")
public class TestDaoImpl extends AbstractDAO implements TestDao {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("notice.selectNoticeList", map);
	}

	@Override
	public int getNoticeCount() {
		// TODO Auto-generated method stub
		return (Integer) selectOne("notice.getNoticeCount");
	}

	@Override
	public Login loginCheck(String id) {
		// TODO Auto-generated method stub
		return (Login) selectOne("member.loginCheck", id);
	}

	@Override
	public void joinMember(Member member) {
		// TODO Auto-generated method stub
		insert("member.joinMember", member);
	}

	@Override
	public int getBoardCount(Map<String, Object> commandMap) {
		// TODO Auto-generated method stub
		return (Integer) selectOne("board.getBoardCount", commandMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("board.selectBoardList", map);
	}

}
