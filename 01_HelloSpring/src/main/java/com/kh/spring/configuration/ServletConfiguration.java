package com.kh.spring.configuration;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

//Spring bean configuration xml파일고 같은 역할을 하는 class
@Configuration
public class ServletConfiguration {
	@Bean
	public Logger getLogger() {
		return LoggerFactory.getLogger(ServletConfiguration.class);
		// @Slf4j 롬복 어노테이션 쓰면 안해도될듯
	}
}
