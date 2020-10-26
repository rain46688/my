package com.kh.spring.configuration;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

//Spring bean configuration xml���ϰ� ���� ������ �ϴ� class
@Configuration
public class ServletConfiguration {
	@Bean
	public Logger getLogger() {
		return LoggerFactory.getLogger(ServletConfiguration.class);
		// @Slf4j �Һ� ������̼� ���� ���ص��ɵ�
	}
}
