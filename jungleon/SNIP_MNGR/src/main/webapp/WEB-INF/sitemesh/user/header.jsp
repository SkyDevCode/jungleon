<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="tempPath" value="WEB-INF/jsp/egovframework/itgcms/user/template"/>
	<script>
		var isOldIe = false;
	</script>
	<!--[if lt IE 10]>
		<script>
			isOldIe = true;
		</script>
	<![endif]-->

	<link href="${ctx}/resource/templete_common/css/subcommon.css"  rel="stylesheet" type="text/css" />
	<link href="${ctx}/resource/templete_common/css/itg.css"  rel="stylesheet" type="text/css" />
	<link href="${ctx}/cheditor/css/editareaView.css"  rel="stylesheet" type="text/css" />
	<link href="${ctx}/resource/templete_common/css/jquery-ui.css"  rel="stylesheet" type="text/css" />
	<link href="${ctx}/resource/templete_common/css/owl.carousel.css"  rel="stylesheet" type="text/css" />
	<link href="${ctx}/resource/templete_common/css/base.css"  rel="stylesheet" type="text/css" />
    <link href="${ctx}/resource/common/css/loading-spiner.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/resource/common/jquery_plugin/validation/validator.css" rel="stylesheet" type="text/css" />
	<c:if test="${snsconfigVO ne null}">
	<link href="${ctx}/resource/common/css/${snsconfigVO.formCode}.css"  rel="stylesheet" type="text/css" />
	</c:if>
	<link href="${ctx}/resource/templete/${siteconfigVO.tempCode}/css/layout.css"  rel="stylesheet" type="text/css" />
	<script src="${ctx}/resource/templete_common/js/jquery-1.12.0.min.js"></script>
	<script src="${ctx}/resource/templete_common/js/jquery-ui.min.js"></script>
	<script src="${ctx}/resource/templete_common/js/owl.carousel.min.js"></script>
	<script src="${ctx}/resource/templete_common/js/common.js"></script>
	<script src="${ctx}/resource/common/jquery_plugin/common_functions.js"></script>
	<script src="${ctx}/resource/common/jquery_plugin/validation/validator.js"></script>
	<script src="${ctx}/resource/common/jquery_plugin/validation/accessability.js"></script>
	<script src="/cheditor/cheditor.js"></script>
	<script src="${ctx}/resource/common/jquery_plugin/popWin.js"></script>
	<script src="${ctx}/resource/templete/${siteconfigVO.tempCode}/js/common.js"></script>