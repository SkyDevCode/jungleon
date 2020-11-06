package egovframework.itgcms.common;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HttpsFilter implements Filter {

	private static final Logger logger = LoggerFactory.getLogger(HttpsFilter.class);

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		logger.info(">>> filter start");

		HttpsRequestWrapper httpsRequest = new HttpsRequestWrapper((HttpServletRequest) request);
		httpsRequest.setResponse((HttpServletResponse) response);
		chain.doFilter(httpsRequest, response);

		logger.info(">>> filter end");
	}

	public void init(FilterConfig arg0) throws ServletException {
	}

}

