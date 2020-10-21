package com.cms.common.socket.socket4;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.cms.model.vo.Message;
import com.cms.model.vo.SessionVo;
import com.fasterxml.jackson.databind.ObjectMapper;

public class SockjsHandler extends TextWebSocketHandler {
	ObjectMapper objectMapper = new ObjectMapper();
	private static Map<SessionVo, WebSocketSession> user = new HashMap<SessionVo, WebSocketSession>();
	private static Logger log = LoggerFactory.getLogger(SockjsHandler.class);

	// ������ ������ ���� ������
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info(" === afterConnectionEstablished ���� === ");
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		log.info(" === ����� ���̵� : " + session.getId() + " ���� �г��� : " + sv.getNickname() + " ���� ������ �� : "
				+ sv.getCurRoomBid());
		if (sv != null)
			user.put(sv, session);

	}

	// ���Ͽ� �޼����� ��������
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("{}�� ���� {} ����", session.getId(), message.getPayload());
		log.info(" === handleTextMessage ���� === ");
		Message msg = objectMapper.readValue(message.getPayload(), Message.class);
		log.info("msg : " + msg);

		Iterator<SessionVo> it = user.keySet().iterator();
		while (it.hasNext()) {
			log.info("���� ������0");
			SessionVo key = it.next();
			log.info("key.getCurRoomBid() : " + key.getCurRoomBid());
			log.info("msg.getChat_board_id() : " + msg.getChat_board_id());
			log.info("������ 1 : " + key.getCurRoomBid().equals("" + msg.getChat_board_id()));
			log.info("������ 2 : " + !key.getCurRoomBid().equals(""));
			// key.getCurRoomBid().equals("" + msg.getChat_board_id()) ������ ���� ����
			// msg.getChat_board_id()�̰� �������̶� �׷� ""�ٿ��� ���ڿ��� �ٲ�ߵ� ����
			if (!key.getCurRoomBid().equals("") && key.getCurRoomBid().equals("" + msg.getChat_board_id())) {
				if (user.get(key) != null && user.get(key).isOpen()) {
					user.get(key).sendMessage(new TextMessage(objectMapper.writeValueAsString(msg)));
				}
			}
		}
	}

	// ������ ��������
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info(" === afterConnectionClosed ���� === ");
		List<SessionVo> keyList = new ArrayList<SessionVo>();
		Set<SessionVo> set = user.keySet();
		log.info("status : " + status);
		String name = "";
		String boardId = "";
		Iterator<SessionVo> it = set.iterator();
		while (it.hasNext()) {
			SessionVo key = it.next();
			if (user.get(key).equals(session)) {
				name = key.getNickname();
				boardId = key.getCurRoomBid();
				Iterator<SessionVo> it2 = user.keySet().iterator();
				while (it2.hasNext()) {
					SessionVo key2 = it2.next();
					if (!user.get(key2).equals(session) && key2.getCurRoomBid().equals(boardId)) {
						user.get(key2).sendMessage(
								new TextMessage(objectMapper.writeValueAsString(new Message(0, name, "SYS2", "", ""))));
					}
				}
				keyList.add(key);
			}
		}
		for (SessionVo listkey : keyList) {
			user.remove(listkey);
		}
		log.info("status 2 : " + status);
	}
}
