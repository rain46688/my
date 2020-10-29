package com.cms.common.socket.socket1;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.cms.model.vo.RtcMsg;
import com.cms.model.vo.SessionVo;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SocketHandler extends TextWebSocketHandler {

	Map<SessionVo, WebSocketSession> users = new HashMap<SessionVo, WebSocketSession>();
	private ObjectMapper objectMapper = new ObjectMapper();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("SocketHandler ���� �ñ׳θ� ����");
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		users.put(sv, session);
		log.info("�г��� : " + sv.getNickname());

	}

	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message)
			throws InterruptedException, IOException {
		log.info("handleTextMessage ���� �ñ׳θ� ����");

		RtcMsg msg = objectMapper.readValue(message.getPayload(), RtcMsg.class);
		log.info("sdp : " + msg.getSdp() + " type : " + msg.getType());
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		log.info("users Size : " + users.size());
		Iterator<SessionVo> it = users.keySet().iterator();
		while (it.hasNext()) {
			SessionVo key = it.next();
			// ���� ���� �ο���
			if (key.getCurRoomBid().equals(sv.getCurRoomBid())) {
				if (sv.isHost()) {
					// ȣ��Ʈ�� ���
					log.debug("���� ���� ȣ��Ʈ");
					if (!key.isHost()) {
						log.debug("���� ���� ȣ��Ʈ �̴ϱ� ���������� �޼��� ����");
						users.get(key).sendMessage(message);
					}
				} else {
					// ȣ��Ʈ�� �ƴѰ��
					log.debug("���� ���� ������");
					if (key.isHost()) {
						log.debug("���� ���� ȣ��Ʈ �ƴϴϱ� ȣ��Ʈ���� �޼��� ����");
						users.get(key).sendMessage(message);
					}
				}

			}
		}

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info(" === afterConnectionClosed ���� === ");
		List<SessionVo> keyList = new ArrayList<SessionVo>();
		Iterator<SessionVo> it = users.keySet().iterator();
		while (it.hasNext()) {
			SessionVo key = it.next();
			if (users.get(key).equals(session)) {
				keyList.add(key);
			}
		}
		for (SessionVo listkey : keyList) {
			users.remove(listkey);
		}
	}

}
