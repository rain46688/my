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

	// 서버에 접속이 성공 했을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		// 접속한 유저 리스트에 저장
		sessionList.add(session);
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		log.info(" === 연결됨 아이디 : " + session.getId() + " 유저 닉네임 : " + sv.getNickname());

		for (WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(sv.getNickname() + "님이 입장 하셨습니다."));
		}
	}

	// 소켓에 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("{}로 부터 {} 받음", session.getId(), message.getPayload());

		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");

		// 모든 유저에게 메세지 출력
		for (WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(sv.getNickname() + " : " + message.getPayload()));
		}

	}

	// 소켓이 끊겼을때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);

		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");

		for (WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(sv.getNickname() + "님이 퇴장 하셨습니다."));
		}

	}
}
