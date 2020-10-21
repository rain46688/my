package com.cms.common.socket.socket4;

import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import lombok.extern.java.Log;

@Log
public class SockjsConfiguration implements WebSocketConfigurer {

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// TODO Auto-generated method stub
		log.info(" === registerWebSocketHandlers ½ÇÇà ===");
		registry.addHandler(new SockjsHandler(), "/socket").setAllowedOrigins("*").withSockJS();
	}

}
