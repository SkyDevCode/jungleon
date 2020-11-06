<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="fixwidth">
	<c:forEach items="${contractResultList}" var="contract" varStatus="i">
		<h4 class="conth4 mt20 terms_title" onclick="displayContract('${i.count}');" style="cursor: pointer;">${contract.title}</h4>
		<div class="contractTxt" id="contract_${i.count}">
			<c:out value="${contract.contents}" escapeXml="false" />
		</div>
	</c:forEach>
	<c:if test="${fn:length(contractResultList) == 0}">
		<h4 class="conth4 mt20">약관정보가 없습니다.</h4>
    </c:if>
</div>

<script>
	function displayContract(no){
		$(".contractTxt").find("div").css("display", "none");
		$("#contract_"+no).find("div").css("display", "block");
	}
</script>
<%-- E: 추가 영역 --%>