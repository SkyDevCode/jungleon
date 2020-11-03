<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>${title}</title>
</head>
<body>
	<!--container-->
	<section id="container" class="sub">
		<div class="content">
			<div class="sub_inner">
				<span disabled="disabled" id="htmlcode">
					<c:if test="${contentsUrl ne 'popImg'}">
						<c:import url="/${siteCode}/${contentsUrl}">
							<c:param name="opt1">${opt1}</c:param>
							<c:param name="opt2">${opt2}</c:param>
							<c:param name="opt3">${opt3}</c:param>
						</c:import>
					</c:if>
					<c:if test="${contentsUrl eq 'popImg'}">
						<img src="${ctx}/comm/viewImage.do?f=<c:out value="${ufn:getDownloadLink('','popup',opt1,opt1) }" />" alt="${opt2}"/>
					</c:if>
				</span>
				<button type="button" class="preview_close" onclick="self.opener = self; self.opener = null; self.close();">닫기</button>
			</div>
		</div>
	</section>
	<script type="text/javascript">
		$(".sub_inner").prepend($("#htmlcode").text());
		$("#htmlcode").remove();
	</script>
	<!--//container-->

</body>
</html>