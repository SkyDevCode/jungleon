<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta charset="utf-8">
	<title><decorator:title default="${systemconfigVO.sysName}" /></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<c:if test="${fn:indexOf(systemconfigVO.faviUrl, '.') > 0}">
    	<link rel="shortcut icon" type="image/x-icon" href="${systemconfigVO.faviUrl}" />
	</c:if>
	<meta name="robots" content="noindex,nofollow">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="format-detection" content="telephone=no" />
<!--[if lte IE 9]><script src="../../js/html5shiv.js"></script><![endif]-->
	<decorator:head />

<!--header-->
<jsp:include page="header.jsp"></jsp:include>
<!--//header-->

<decorator:body />

<!--footer-->
<jsp:include page="footer.jsp"></jsp:include>
<!--//footer-->
</body>
</html>