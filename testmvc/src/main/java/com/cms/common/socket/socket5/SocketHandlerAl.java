package com.cms.common.socket.socket5;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.cms.model.service.TestService;
import com.cms.model.vo.Alarm;
import com.cms.model.vo.SessionVo;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SocketHandlerAl extends TextWebSocketHandler {

	Map<SessionVo, WebSocketSession> users = new HashMap<SessionVo, WebSocketSession>();
	private ObjectMapper objectMapper = new ObjectMapper();

	@Autowired
	private TestService service;

	public SocketHandlerAl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		log.info(" === afterConnectionEstablished 실행 === ");
		Map<String, Object> map = session.getAttributes();
		SessionVo sv = (SessionVo) map.get("loginnedMember");
		if (sv != null) {
			log.info("닉네임 : " + sv.getNickname());
			users.put(sv, session);
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		log.info(" === handleTextMessage 실행 === ");
		Alarm al = objectMapper.readValue(message.getPayload(), Alarm.class);
		log.debug("send : " + al.getSend_mem_usid() + " receive : " + al.getReceive_mem_usid() + " type : "
				+ al.getType() + " msg : " + al.getAlarm_content());

		if (al.getType().equals("alarm")) {
			log.info(" === alarm 실행 === ");
			Iterator<SessionVo> it = users.keySet().iterator();
			while (it.hasNext()) {
				SessionVo key = it.next();
				if (key.getUsid() == al.getReceive_mem_usid()) {
					log.info(" === 상대에게 감 실행 === : " + key.getUsid());
					users.get(key).sendMessage(new TextMessage(objectMapper.writeValueAsString(al)));
					service.insertAlarm(al);
				}
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		log.info(" === afterConnectionClosed 실행 === ");
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
		session.close();
	}

}
