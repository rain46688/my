//package com.cms.common.socket.socket1;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.socket.config.annotation.EnableWebSocket;
//import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
//import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Configuration
//@EnableWebSocket
//@Slf4j
//public class WebSocketConfiguration implements WebSocketConfigurer {
//
//	@Override
//	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
//		// TODO Auto-generated method stub
//		log.info(" === registerWebSocketHandlers 웹소켓 핸들러 실행 == ");
//		registry.addHandler(new SocketHandler(), "/socketrtc").setAllowedOrigins("*");
//	}
//
//}
