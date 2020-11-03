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
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="format-detection" content="telephone=no" />
<link href="${ctx}/resource/templete_common/css/jquery-ui.css"  rel="stylesheet" type="text/css" />
<link href="${ctx}/resource/templete_common/css/owl.carousel.css"  rel="stylesheet" type="text/css" />
<link href="${ctx}/resource/templete_common/css/base.css"  rel="stylesheet" type="text/css" />
<link href="${ctx}/resource/templete_common/css/subcommon.css"  rel="stylesheet" type="text/css" />
<link href="${ctx}/cheditor/css/editareaView.css"  rel="stylesheet" type="text/css" />
<%-- <link href="${ctx}/resource/templete/${siteconfigVO.tempCode}/css/layout.css"  rel="stylesheet" type="text/css" /> --%>
<link href="${ctx}/resource/common/css/${snsconfigVO.formCode}.css"  rel="stylesheet" type="text/css" />
<script src="${ctx}/resource/templete_common/js/jquery-1.12.0.min.js"></script>
<script src="${ctx}/resource/templete_common/js/jquery-ui.min.js"></script>
<script src="${ctx}/resource/templete_common/js/owl.carousel.min.js"></script>
<%-- <script src="${ctx}/resource/templete/${siteconfigVO.tempCode}/js/jquery.js"></script> --%>
<!--[if lte IE 9]><script src="../../js/html5shiv.js"></script><![endif]-->

<%-- S: 추가 영역 --%>
<script src="${ctx}/resource/common/jquery_plugin/common_functions.js"></script>

<link rel="stylesheet" type="text/css" href="${ctx}/resource/common/jquery_plugin/validation/validator.css" />

<%-- E: 추가 영역 --%>
	<title>
		${opt2}
	</title>
</head>

<body>
	<div id="accessibility">
	    <a href="#container">본문 바로가기</a>
	    <a href="#gnb">주메뉴 바로가기</a>
	</div>

	<!--container-->
	<section id="container" class="sub">
		<div class="content">
		<div class="sub_inner">
			<span id="textcode"></span>
			<span disabled="disabled" id="htmlcode">
		    	<c:import url="/${siteCode}/${contentsUrl}">
		           	<c:param name="opt1">${opt1}</c:param>
		           	<c:param name="opt2">${opt2}</c:param>
		           	<c:param name="opt3">${opt3}</c:param>
		        </c:import>
			</span>
			<button type="button" class="preview_close" onclick="self.opener = self; self.opener = null; self.close();">닫기</button>
			</div>
		</div>
	</section>
	<c:if test="${opt2 eq '미리보기'}">
		<script type="text/javascript">
		$("#textcode").html($("#htmlcode").text());
		$("#htmlcode").html('');
	</script>
	</c:if>
	<!--//container-->

</body>
</html>