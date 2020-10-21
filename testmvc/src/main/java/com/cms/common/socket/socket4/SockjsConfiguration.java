package com.cms.common.socket.socket4;

import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

public class SockjsConfiguration implements WebSocketConfigurer {

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// TODO Auto-generated method stub
		registry.addHandler(new SockjsHandler(), "/socket").setAllowedOrigins("*").withSockJS();
	}

}
