<%@ page contentType="text/html;charset=UTF-8" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><!DOCTYPE html>
<html lang="ko">
<head>
    <title></title>
</head>
<body>
<script type="text/javascript">
window.onload = function(){
	document.dataForm.submit();
}
</script>
<form name="dataForm" id="dataForm" method="post" action="<%=request.getSession().getAttribute("RETURN_URI_JUNGLE")%>">
    <input type="hidden" name="authId" value="${dataBean.id}" />
</form>
</body>
</html>