<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="tempPath" value="WEB-INF/jsp/egovframework/itgcms/user/template"/>


	<!-- 라이브러리 -->
    <%-- <script src="/resource/templete/${siteconfigVO.tempCode }/lib/js/jquery/jquery-1.11.0.min.js"></script> --%>
    <script src="/resource/common/js/jquery-1.12.0.min.js"></script>
    <!-- //플러그인 -->
	<script src="/resource/templete/${siteconfigVO.tempCode }/lib/js/slick/slick.js"></script>
	<script src="/resource/templete/${siteconfigVO.tempCode }/lib/js/jquery/jquery.bxslider.min.js"></script> <!-- 20200509 파일 추가 -->
	<script src="/resource/common/jquery_plugin/jquery_ui/jquery-ui.min.js"></script>
	<script src="/resource/common/jquery_plugin/jquery_ui/jquery.ui.datepicker-ko.js"></script>
	<%-- <script src="/resource/templete/${siteconfigVO.tempCode }/lib/js/datepicker.js"></script> --%>
	<script src="/resource/templete/${siteconfigVO.tempCode }/lib/js/jquery.fullPage.js"></script>
	<script src="/resource/templete/${siteconfigVO.tempCode }/lib/js/jquery.rwdImageMaps.min.js"></script>
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="/resource/templete/${siteconfigVO.tempCode }/src/css/reset.css" >
    <link rel="stylesheet" type="text/css" href="/resource/templete/${siteconfigVO.tempCode }/lib/js/slick/slick.css">
    <link rel="stylesheet" type="text/css" href="/resource/templete/${siteconfigVO.tempCode }/lib/js/slick/jquery.bxslider.min.css"> <!-- 20200509 파일 추가 -->
    <link rel="stylesheet" type="text/css" href="/resource/templete/${siteconfigVO.tempCode }/src/css/jquery.fullPage.css">
    <link rel="stylesheet" type="text/css" href="/resource/templete/${siteconfigVO.tempCode }/src/css/layout.css" >
    <link rel="stylesheet" type="text/css" href="/resource/templete/${siteconfigVO.tempCode }/src/css/sub.css" >
    <link rel="stylesheet" type="text/css" href="/resource/templete/${siteconfigVO.tempCode }/src/css/itg.css">
    <link rel="stylesheet" type="text/css" href="/resource/templete/${siteconfigVO.tempCode }/src/css/main.css" >
    <link rel="stylesheet" type="text/css" href="/resource/common/jquery_plugin/jquery_ui/jquery-ui.min.css">
    <!-- //css -->
    <!-- script -->
    <script src="/resource/templete/${siteconfigVO.tempCode }/src/js/common.js"></script>
    <script src="/resource/templete/${siteconfigVO.tempCode }/src/js/gnb.js"></script>
    <script src="/resource/templete/${siteconfigVO.tempCode }/src/js/main.js"></script>
    <!-- //script -->
    <script src="/resource/common/jquery_plugin/common_functions.js"></script>
	<script>
	window.GitpleConfig = { appCode: 'xOKbaehoDM8TOOEiERC7RfxFSs24e3' };
	!function(){function e(){function e(){var e=t.contentDocument,a=e.createElement("script");a.type="text/javascript",a.async=!0,a.src=window[n]&&window[n].url?window[n].url+"/inapp-web/gitple-loader.js":"https://app.gitple.io/inapp-web/gitple-loader.js",a.charset="UTF-8",e.head&&e.head.appendChild(a)}var t=document.getElementById(a);t||((t=document.createElement("iframe")).id=a,t.style.display="none",t.style.width="0",t.style.height="0",t.addEventListener?t.addEventListener("load",e,!1):t.attachEvent?t.attachEvent("onload",e):t.onload=e,document.body.appendChild(t))}var t=window,n="GitpleConfig",a="gitple-loader-frame";if(!window.Gitple){document;var i=function(){i.ex&&i.ex(arguments)};i.q=[],i.ex=function(e){i.processApi?i.processApi.apply(void 0,e):i.q&&i.q.push(e)},window.Gitple=i,t.attachEvent?t.attachEvent("onload",e):t.addEventListener("load",e,!1)}}();
	Gitple('boot');
	</script>