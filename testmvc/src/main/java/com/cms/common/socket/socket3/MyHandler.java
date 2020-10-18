package com.cms.common.socket.socket3;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.cms.model.vo.SessionVo;

@RequestMapping("/socket")
public class MyHandler extends TextWebSocketHandler {

	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	private static Logger log = LoggerFactory.getLogger(MyHandler.class);

	// ������ ������ ���� ������
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		// ������ ���� ����Ʈ�� ����
		sessionList.add(session);
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		log.info(" === ����� ���̵� : " + session.getId() + " ���� �г��� : " + sv.getNickname());

		for (WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(sv.getNickname() + "���� ���� �ϼ̽��ϴ�."));
		}
	}

	// ���Ͽ� �޼����� ��������
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("{}�� ���� {} ����", session.getId(), message.getPayload());

		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");

		// ��� �������� �޼��� ���
		for (WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(sv.getNickname() + " : " + message.getPayload()));
		}

	}

	// ������ ��������
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);

		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");

		for (WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(sv.getNickname() + "���� ���� �ϼ̽��ϴ�."));
		}

	}
}
