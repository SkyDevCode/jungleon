<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

<html>
<head>
    <title>NICE평가정보 - CheckPlus 안심본인인증</title>
    <script language="javascript" type="text/javascript" >

    alert("본인 인증이 완료되었습니다. 다음단계로 진행합니다.");

    fncOpenerSubmit();

	function fncOpenerSubmit() {

		opener.document.registForm.param_r1.value = "${result.NAME}";
		opener.document.registForm.param_r2.value = "${result.BIRTHDATE}";
		opener.document.registForm.param_r3.value = "${result.MobileNo}";
        opener.callbackCerti();

        self.close();

	}

    </script>
</head>
<body>
    <center>
    <p><p><p><p>
    본인인증이 완료 되었습니다.<br>

    ${ sMessage }<br>
    </center>
</body>
</html>