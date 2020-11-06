package com.cms.common.socket.socket1;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.cms.model.vo.SessionVo;

import lombok.extern.java.Log;

//수정중!! 11 04
@Log
public class SocketHandlerMulti extends TextWebSocketHandler {
	// action-servlet.xml도 같이 수정해줘야됨!

	List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("SocketHandler 실행 시그널링 서버");
		sessions.add(session);
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		log.info("sv : " + sv + " map : " + map);
		log.info("닉네임 : " + sv.getNickname() + " " + sv.getMemberId());
	}

	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message)
			throws InterruptedException, IOException {
		log.info("handleTextMessage 실행 시그널링 서버");
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		log.info("sv : " + sv + " map : " + map);
		log.info("닉네임 : " + sv.getNickname() + " " + sv.getMemberId());

		for (WebSocketSession webSocketSession : sessions) {
			if (webSocketSession.isOpen() && !session.getId().equals(webSocketSession.getId())) {
				log.info("분기문 진입" + message + "닉네임 : " + sv.getNickname());
				webSocketSession.sendMessage(message);
			}
		}

	}

}
