package com.cms.common.socket.socket1;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.java.Log;

@Log
public class SocketHandler extends TextWebSocketHandler {

	List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("SocketHandler ���� �ñ׳θ� ����");
		sessions.add(session);
	}

	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message)
			throws InterruptedException, IOException {
		log.info("handleTextMessage ���� �ñ׳θ� ����");
		log.info("session : " + session + " messsage : " + message);

		for (WebSocketSession webSocketSession : sessions) {
			if (webSocketSession.isOpen() && !session.getId().equals(webSocketSession.getId())) {
				// �ڱ� ���� �޼����� ����
				webSocketSession.sendMessage(message);
				log.info("send message : " + message);
			}
		}

	}

}
