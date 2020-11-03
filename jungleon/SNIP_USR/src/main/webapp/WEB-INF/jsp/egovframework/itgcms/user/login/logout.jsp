<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

		<%-- S: 추가 영역 --%>

		<div class="loginBox">
			<div class="w">
						이용해주셔서 감사합니다.
				<ul class="btn">
					<li class="last"><a href="/web/main/index.do" id="main" name="main">메인으로</a></li>
				</ul>
			</div>
		</div>

		<%-- E: 추가 영역 --%>
