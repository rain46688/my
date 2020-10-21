package com.cms.common.socket.socket1;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import lombok.extern.java.Log;

@Configuration
@EnableWebSocket
@Log
public class WebSocketConfiguration implements WebSocketConfigurer {

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// TODO Auto-generated method stub
		log.info(" === registerWebSocketHandlers ������ �ڵ鷯 ���� == ");
		registry.addHandler(new SocketHandler(), "/socketrtc").setAllowedOrigins("*");
	}

}
