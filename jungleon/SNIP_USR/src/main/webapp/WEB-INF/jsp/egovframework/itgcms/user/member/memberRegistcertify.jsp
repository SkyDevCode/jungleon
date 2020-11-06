<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- S: 추가 영역 --%>
<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />
<c:set var="ctx" value="${pageContext.request.contextPath}/${siteCode}"/>
<div class="btnBox">
	<a href="#none" class="button button1" onclick="javascript:success();">승인완료</a>
</div>
<form action="" name="form1" method="post">
	<input type="hidden" name="stp">
	<input type="hidden" name="type" value="member">
</form>
<script type="text/javascript">
function success() {
	document.form1.target = "Parent_window"; // 타켓을 부모창으로 설정
	document.form1.type.value="member";
	document.form1.stp.value="Step03";
	document.form1.action = "/${siteCode}/contents/${siteconfigVO.memberRegMenuCode}.do";
	document.form1.submit();
	 self.close();
}
</script>