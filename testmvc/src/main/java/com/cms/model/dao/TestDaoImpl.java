package com.cms.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cms.model.vo.Alarm;
import com.cms.model.vo.Comment;
import com.cms.model.vo.Login;
import com.cms.model.vo.Member;

@Repository("testDAO")
public class TestDaoImpl extends AbstractDAO implements TestDao {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int cPage = Integer.parseInt(String.valueOf(map.get("cPage")));
		int numPerPage = Integer.parseInt(String.valueOf(map.get("numPerPage")));
		RowBounds r = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return selectList("notice.selectNoticeList", null, r);
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
		int cPage = Integer.parseInt(String.valueOf(map.get("cPage")));
		int numPerPage = Integer.parseInt(String.valueOf(map.get("numPerPage")));
		RowBounds r = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return selectList("board.selectBoardList", map, r);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> boardPage(Map<String, Object> commandMap) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) selectOne("board.boardPage", commandMap);
	}

	@Override
	public void updateReadCount(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		update("board.updateReadCount", commandMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Integer> tradeUserList(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return selectList("board.tradeUserList", commandMap);
	}

	@Override
	public int likeCount(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return (int) selectOne("board.likeCount", commandMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Integer> paidUsersList(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return selectList("board.paidUsersList", commandMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Integer> deliveryUsersList(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return selectList("board.deliveryUsersList", commandMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Integer> likeList(Map<String, Object> commandMap, int usid) throws Exception {
		// TODO Auto-generated method stub
		commandMap.put("usid", usid);
		return (List<Integer>) selectOne("board.likeList", commandMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Comment> commentList(int cBoardId) throws Exception {
		// TODO Auto-generated method stub
		return selectList("board.commentList", cBoardId);
	}

	@Override
	public int insertAlarm(Alarm al) throws Exception {
		// TODO Auto-generated method stub
		return (int) insert("alarm.insertAlarm", al);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Alarm> selectAlarmList(int usid) throws Exception {
		// TODO Auto-generated method stub
		return selectList("alarm.selectAlarmList", usid);
	}

	@Override
	public String alarmCount(int usid) throws Exception {
		// TODO Auto-generated method stub
		return (String) selectOne("alarm.selectAlarmCount", usid);
	}

	@Override
	public int alarmRead(int aid) throws Exception {
		// TODO Auto-generated method stub
		return (int) update("alarm.alarmRead", aid);
	}

}
