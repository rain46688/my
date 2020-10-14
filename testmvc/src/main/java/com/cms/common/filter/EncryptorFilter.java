package com.cms.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cms.common.EncryptorWrapper;

public class EncryptorFilter implements Filter {
	protected Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		log.info(" ===== EncryptorFilter ½ÇÇàµÊ ===== ");
		EncryptorWrapper ew = new EncryptorWrapper((HttpServletRequest) request);
		chain.doFilter(ew, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
