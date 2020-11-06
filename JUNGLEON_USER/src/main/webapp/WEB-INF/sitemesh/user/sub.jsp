<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	if (request.getProtocol().equals("HTTP/1.1")) response.setHeader("Cache-Control", "no-cache");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>

<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="tempPath" value="WEB-INF/jsp/egovframework/itgcms/user/template"/>

<!DOCTYPE HTML>
<html lang="ko">
<head>
	<c:choose>
		<c:when test="${siteconfigVO.titleNameCode eq '1'}"><c:set var="title" value="${fn:substring(menuVO.menuPfullname,1,fn:length(menuVO.menuPfullname))}"/></c:when>
		<c:when test="${siteconfigVO.titleNameCode eq '2'}"><c:set var="title" value="${siteconfigVO.titleName}"/></c:when>
		<c:otherwise><c:set var="title" value="CUBE CMS 3.0.7"/></c:otherwise>
	</c:choose>
	<title><decorator:title default="${title}"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<c:if test="${fn:indexOf(siteconfigVO.faviUrl, '.') > 0}">
		<link rel="shortcut icon" type="image/x-icon" href="${siteconfigVO.faviUrl}" />
	</c:if>
	<meta name="robots" content="noindex,nofollow">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, viewport-fit=cover">
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="format-detection" content="telephone=no" />

<!--header-->
	<jsp:include page="header.jsp"></jsp:include>
<!--//header-->

	<decorator:head />
</head>
<body>

	<!-- 본문 영역 -->
	<decorator:body />
	<!-- 본문 영역 -->

	<!--footer-->
	<jsp:include page="footer.jsp"></jsp:include>
	<!--//footer-->

</body>
</html>
