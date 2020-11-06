 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%@ taglib prefix="ora" uri="/WEB-INF/tlds/CustomTagSelectCodeList.tld" %>

<caption>
    <p class="ir-text">번호,부서명,성명,직위,전화번호,담당업무로 구성된 부서별 직원정보 리스트</p>
</caption>
<colgroup>
    <col class="col1 n_mobile">
    <col class="col2 n_mobile">
    <col class="col3">
    <col class="col4">
    <col class="col5">
    <col class="col6 n_mobile">
</colgroup>
<thead>
	<tr>
	    <th scope="col" class="n_mobile">번호</th>
	    <th scope="col" class="n_mobile">부서명</th>
	    <th scope="col">성명</th>
	    <th scope="col">직위</th>
	    <th scope="col">전화번호</th>
	    <th scope="col" class="n_mobile">담당업무</th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${mngResult }" var="result" varStatus="status">
		<tr>
	         <td class="n_mobile"><c:out value="${listNoRev +(status.count)}" /></td>
	         <c:set var="dptName" value="${orgResult.orName }" />
	         <c:choose>
				<c:when test="${empty dptName}">
					<td class="n_mobile"><c:out value="${result.orName }" /></td>
	         	</c:when>
	         	<c:otherwise>
	         		<td class="n_mobile"><c:out value="${orgResult.orName }" /></td>
	         	</c:otherwise>
	         </c:choose>
	         <td class="file">${result.mngName }</td>
	         <td class="writer"><c:out value="${result.cName }" /></td>
	         <td><c:out value="${result.mngPhone }" /></td>
	         <td class="text-l n_mobile" style="word-break:break-all;white-space:pre-line;"><c:out value="${result.mngWork }" /></td>
    	</tr>
	</c:forEach>

</tbody>