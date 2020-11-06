<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
<script type="text/javascript">
$(document).ready(function(){
	opener.name = "snip";
	document.form1.target = opener.name;
	document.form1.submit();
	self.close();
})
</script>
<form name="form1" method="post" action="/${siteCode }/contents/registration.do">
	<input type="hidden" name="type" value="${memType }" />
	<input type="hidden" name="stp" value="Step03" />
</form>
