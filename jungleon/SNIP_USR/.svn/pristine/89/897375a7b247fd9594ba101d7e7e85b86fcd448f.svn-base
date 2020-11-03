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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>
		<c:if test="${siteconfigVO.titleNameCode eq '2'}">
			${siteconfigVO.titleName}
		</c:if>
		<c:if test="${siteconfigVO.titleNameCode eq '1'}">
			${siteconfigVO.sysName}
		</c:if>
	</title>
</head>
<body>
<div style="margin-top:200px; text-align: center;">
<c:if test="${not empty siteconfigVO.underConstrImg }">
	<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','system',siteconfigVO.underConstrImg,siteconfigVO.underConstrImg) }" />" alt="점검 중 이미지" />
</c:if>
</div>
</body>
</html>