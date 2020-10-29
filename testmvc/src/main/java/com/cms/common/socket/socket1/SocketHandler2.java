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

@Log
public class SocketHandler2 extends TextWebSocketHandler {
	// action-servlet.xml�� ���� ��������ߵ�!

	List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("SocketHandler ���� �ñ׳θ� ����");
		sessions.add(session);
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		log.info("sv : " + sv + " map : " + map);
		log.info("�г��� : " + sv.getNickname() + " " + sv.getMemberId());
	}

	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message)
			throws InterruptedException, IOException {
		log.info("handleTextMessage ���� �ñ׳θ� ����");
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		log.info("sv : " + sv + " map : " + map);
		log.info("�г��� : " + sv.getNickname() + " " + sv.getMemberId());

		for (WebSocketSession webSocketSession : sessions) {
			if (webSocketSession.isOpen() && !session.getId().equals(webSocketSession.getId())) {
				log.info("�б⹮ ����" + message + "�г��� : " + sv.getNickname());
				webSocketSession.sendMessage(message);
			}
		}

	}

}
