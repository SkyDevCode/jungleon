<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="tempPath" value="WEB-INF/jsp/egovframework/itgcms/user/template"/>

<!DOCTYPE HTML>
<html lang="ko">
<head>
	<c:choose>
		<c:when test="${siteconfigVO.titleNameCode eq '1'}"><c:set var="title" value="${siteconfigVO.sysName}"/></c:when>
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
<!--[if lte IE 9]><script src="${ctx}/resource/templete_common/js/html5shiv.js"></script><script src="${ctx}/resource/templete_common/js/respond.min.js"></script><![endif]-->

	<script>
		<c:if test="${sessionScope.userSessionVO!=null}">
			$(function(){
				setTimeout(
				function(){
					document.location.href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do?code=out";
				}, <c:out value="${sessionTime}"/> * 1000);
			});
		</c:if>
		/* <c:if test="${siteconfigVO.chatBot == 'Y' and siteconfigVO.chatBotKey != ''}">
			window.GitpleConfig = { appCode: '${siteconfigVO.chatBotKey}' };
			!function(){function e(){function e(){var e=t.contentDocument,a=e.createElement("script");a.type="text/javascript",a.async=!0,a.src=window[n]&&window[n].url?window[n].url+"/inapp-web/gitple-loader.js":"https://app.gitple.io/inapp-web/gitple-loader.js",a.charset="UTF-8",e.head&&e.head.appendChild(a)}var t=document.getElementById(a);t||((t=document.createElement("iframe")).id=a,t.style.display="none",t.style.width="0",t.style.height="0",t.addEventListener?t.addEventListener("load",e,!1):t.attachEvent?t.attachEvent("onload",e):t.onload=e,document.body.appendChild(t))}var t=window,n="GitpleConfig",a="gitple-loader-frame";if(!window.Gitple){document;var i=function(){i.ex&&i.ex(arguments)};i.q=[],i.ex=function(e){i.processApi?i.processApi.apply(void 0,e):i.q&&i.q.push(e)},window.Gitple=i,t.attachEvent?t.attachEvent("onload",e):t.addEventListener("load",e,!1)}}();
			Gitple('boot');
		</c:if> */
	</script>
</head>
<body class="main">
	<div id="accessibility">
		<a href="#container">본문 바로가기</a>
		<a href="#gnb">주메뉴 바로가기</a>
	</div>
	<!-- 본문 영역 -->
	<decorator:body />
	<!-- 본문 영역 -->

	<!--footer-->
	<%-- <jsp:include page="footer.jsp"></jsp:include> --%>
	<!--//footer-->

</body>
</html>
