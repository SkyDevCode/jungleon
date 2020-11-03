<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld"%>
<script type="text/javascript">
//<[[!CDATA[

var queryString = "${searchVO.queryString()}";


function fn_egov_detail(svIdx) {
	location.href = "?schM=surveyreg&svIdx="+svIdx;
}
function fn_egov_result(svIdx) {
	location.href = "?schM=surveyresult&svIdx="+svIdx;
}
/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}
//]]>
</script>
					<div class="fixwidth">
						<div class="survey_wrap">


							<div class="boardBox">
								<table class="tb01">
									<caption>설문조사 게시판 리스트</caption>
									<colgroup>
										<col class="n_mobile num">
										<col class="suj" width="*">
										<col class="n_mobile start">
										<col class="n_mobile end">
       									<col class="status">
    								</colgroup>
    								<thead>
        								<tr>
        								  	<th scope="col" class="n_mobile num">번호</th>
											<th scope="col" class="suj">제목</th>
											<th scope="col" class="n_mobile start">시작일</th>
        									<th scope="col" class="n_mobile end">종료일</th>
        									<th scope="col" class="status">상태</th>

        								</tr>
    								</thead>
    								<tbody>
    								<c:forEach var="result" items="${resultList}" varStatus="status">
	    								<c:if test="${!(result.saNum<1 && result.useyn eq 'svstatus01')}">
	    									<tr>
					                    		<td class="n_mobile">
					                    			<c:out value="${listNo -(status.count-1) }" />
					                    		</td>
					                    		<td class="subj">
					                    			<c:choose>
					                    				<c:when test="${result.useyn eq 'svstatus01'}">
			                    							<a href="javascript:fn_egov_result('${result.svIdx}');">${result.svTitle}</a>
					                    				</c:when>
					                    				<c:when test="${result.useyn eq 'svstatus04'}">
			                    							<a href="javascript:fn_egov_detail('${result.svIdx}');">${result.svTitle}</a>
					                    				</c:when>
					                    			</c:choose>
					                    		</td>
					                    		<td class="n_mobile">
					                    			<fmt:formatDate value="${result.svStartdate}" pattern="yyyy-MM-dd"/>
					                    		</td>
					                    		<td class="n_mobile">
					                    			<fmt:formatDate value="${result.svEnddate}" pattern="yyyy-MM-dd"/>
					                    		</td>
	
					                    		<td class="status">
			                    					<c:choose>
					                    				<c:when test="${result.useyn eq 'svstatus01'}">
			                    							<span class="end">${result.etc1 }</span>
					                    				</c:when>
					                    				<c:when test="${result.useyn eq 'svstatus04'}">
			                    							<span class="ing">${result.etc1 }</span>
					                    				</c:when>
					                    			</c:choose>
					                    		</td>
	    								</c:if>
			                    	</c:forEach>
									<c:if test="${fn:length(resultList ) == 0}">
										<tr><td colspan="5" class="no_data"><span>진행중인 설문조사가 없습니다.</span><span> 다음 설문조사 진행 시 많은 참여 부탁드립니다.</span></td></tr>
									</c:if>
        							</tbody>
        							</table>
							</div>
							<div class="pagingWrap">
                  				<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
							</div>

						</div>
					</div>