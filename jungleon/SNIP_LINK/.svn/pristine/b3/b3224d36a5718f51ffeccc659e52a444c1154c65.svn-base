package egovframework.itgcms.common;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HttpsRequestWrapper extends HttpServletRequestWrapper {

	private static final Logger logger = LoggerFactory.getLogger(HttpsRequestWrapper.class);
	private HttpServletResponse response = null;

	public HttpsRequestWrapper(HttpServletRequest request) {
		super(request);
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public HttpSession getSession() {
		HttpSession session = super.getSession();
		processSessionCookie(session);
		return session;
	}

	public HttpSession getSession(boolean create) {
		HttpSession session = super.getSession(create);
		processSessionCookie(session);
		return session;
	}

	private void processSessionCookie(HttpSession session) {

		if (session == null || response == null) {
			/*logger.info("session or response is null");*/
			return;
		}

		Object cookieOverWritten = getAttribute("COOKIE_OVERWRITTEN_FLAG");

		/*logger.info("cookieOverWritten : {}", cookieOverWritten);
		logger.info("isSecure() : {}", isSecure());
		logger.info("session.isNew() : {}", session.isNew());
		logger.info("RESULT : {}", (cookieOverWritten == null && isSecure() && session.isNew()));*/

		// if (cookieOverWritten == null && isSecure() && isRequestedSessionIdFromCookie() && session.isNew()) {
		if (cookieOverWritten == null && isSecure() && session.isNew()) {

			/*logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 신규생성");*/

			Cookie cookie = new Cookie("JSESSIONID", session.getId());
			cookie.setMaxAge(-1);

			String contextPath = getContextPath();

			if (contextPath != null && contextPath.length() > 0) {
				cookie.setPath(contextPath);

			} else {
				cookie.setPath("/");
			}

			response.addCookie(cookie);
			setAttribute("COOKIE_OVERWRITTEN_FLAG", "true");
		}

		/*logger.info("\n");*/

	}
}