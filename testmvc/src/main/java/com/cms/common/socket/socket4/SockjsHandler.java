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

	// 서버에 접속이 성공 했을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info(" === afterConnectionEstablished 실행 === ");
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		log.info(" === 연결됨 아이디 : " + session.getId() + " 유저 닉네임 : " + sv.getNickname() + " 현재 입장한 방 : "
				+ sv.getCurRoomBid());
		if (sv != null)
			user.put(sv, session);

	}

	// 소켓에 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
		log.info(" === handleTextMessage 실행 === ");
		Message msg = objectMapper.readValue(message.getPayload(), Message.class);
		log.info("msg : " + msg);

		Iterator<SessionVo> it = user.keySet().iterator();
		while (it.hasNext()) {
			log.info("여기 집입함0");
			SessionVo key = it.next();
			log.info("key.getCurRoomBid() : " + key.getCurRoomBid());
			log.info("msg.getChat_board_id() : " + msg.getChat_board_id());
			log.info("참거짓 1 : " + key.getCurRoomBid().equals("" + msg.getChat_board_id()));
			log.info("참거짓 2 : " + !key.getCurRoomBid().equals(""));
			// key.getCurRoomBid().equals("" + msg.getChat_board_id()) 거짓이 나온 이유
			// msg.getChat_board_id()이게 정수형이라서 그럼 ""붙여서 문자열로 바꿔야됨 ㄷㄷ
			if (!key.getCurRoomBid().equals("") && key.getCurRoomBid().equals("" + msg.getChat_board_id())) {
				if (user.get(key) != null && user.get(key).isOpen()) {
					user.get(key).sendMessage(new TextMessage(objectMapper.writeValueAsString(msg)));
				}
			}
		}
	}

	// 소켓이 끊겼을때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info(" === afterConnectionClosed 실행 === ");
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
