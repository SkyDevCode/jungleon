<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%
/**
 * @파일명 : mngrBoardconfigList.jsp
 * @파일정보 : 게시판관리 목록
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 9. 4. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<ul class="nav nav-tabs">
	<li class="<c:out value='${pageType eq "replList" ? "active" : "" }'/>" onclick="pageChange('replList')">
		<a href="javascript:pageChange('replList')" data-toggle="tab">답글 목록</a>
	</li>
	<li class="<c:out value='${pageType eq "commentList" ? "active" : "" }'/>" onclick="pageChange('commentList')">
		<a href="javascript:pageChange('commentList')" data-toggle="tab">댓글 목록</a>
	</li>
</ul>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
				<form name="listForm" method="post" onsubmit="fn_search(); return false;">
				<div class="row margin-bottom">
					<div class="col-sm-8 form-inline tp2">
						<label for="viewCount" class="sr-only">리스트 갯수</label>
						<select name="viewCount" id="viewCount" class="form-control input-sm">
							<option value="10" ${ufn:selected(searchVO.viewCount, '10') }>10</option>
							<option value="30" ${ufn:selected(searchVO.viewCount, '30') }>30</option>
							<option value="50" ${ufn:selected(searchVO.viewCount, '50') }>50</option>
							<option value="100" ${ufn:selected(searchVO.viewCount, '100') }>100</option>
						</select>
						<c:if test="${mngrSessionVO.currSiteCode == 'SYSTEM'}">
						<select name="siteCode" id="siteCode" class="form-control input-sm">
							<option value="all" <c:out value="${searchSite eq 'all' ? 'selected' : ''}"/>>전체</option>
							<c:forEach var="site" items="${siteList}">
							<option value="${site.siteCode}" <c:out value="${site.siteCode eq searchSite ? 'selected' : ''}"/>>${site.siteName}</option>
							</c:forEach>
						</select>
						</c:if>
						<label for="schFld" class="sr-only">검색조건</label>
						<select name="schFld" id="schFld" class="form-control input-sm">
							<option value="1" <c:out value="${searchVO.schFld eq '2' ? 'selected' : '' }" />>제목</option>
							<option value="3" <c:out value="${searchVO.schFld eq '4' ? 'selected' : '' }" />>내용</option>
						</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm f-wd-400" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
						<input type="hidden" name="pageType" value="${pageType}"/>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>
				</div>
				<div class="tab-content">
					<div class="tab-pane active" id="replList_tab">
						<table id="example1" class="table table-bordered">
							<colgroup>
								<col></col>
								<col style="width:60%;"></col>
								<col></col>
								<col style="width:15%;"></col>
								<col style="width:15%;"></col>
							</colgroup>
							<thead>
								<tr>
									<th scope="col" >번호</th>
									<th scope="col">제목</th>
									<th scope="col"><c:out value='${pageType eq "commentList" ? "댓글 수" : "답글 수" }'/></th>
									<th scope="col">최근작성일</th>
									<th scope="col">최근작성자</th>
								</tr>
							</thead>
				 			<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="tb_left bg_id tac"><c:out value="${listNo -(status.count-1) }" /></td>
									<td><a href="javascript:fn_goView('${result.menuCode}','${result.bcId}',${result.bdIdx})"><c:out value="[${result.menuName}] ${result.bdTitle}"/></a></td>
									<td class="tac"><c:out value="${result.cnt}" /></td>
									<td class="tac"><fmt:formatDate value="${result.recentDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td class="tac"><c:out value="${result.recentName}"/></td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(resultList) == 0}">
								<tr><td colspan="5" class="tac">데이터가 없습니다.</td></tr>
							</c:if>
							</tbody>
			 			</table>
			 			<div class ="row">
			 				<div class="col-sm-5 text-left">
					 			<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">게시물 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /> 건, 페이지 : <fmt:formatNumber value="${paginationInfo.currentPageNo}" type="number" /> / <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
							</div>
							<div class="col-sm-7">
								<div class="text-center dataTables_paginate paging_simple_numbers" id="example1_paginate">
									<ul class="pagination">
										<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				</form>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->

<script type="text/javascript">
var queryString = "${searchVO.query}";

/* function goView(code, id) {
	var f = document.listForm;
	var tmpQuery = queryString;

	if (f.pageType.value === "commentList") {
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "id", id);
		location.href="/_mngr_/mngrContents/"+code +".do?schM=view" + tmpQuery;
	} else if (f.pageType.value==="replList") {
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", id);
		location.href="/_mngr_/mngrContents/"+code +".do?schFld=4" + tmpQuery;
	}
} */

function fn_goView(menuCode, bcid, id) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "id", id);

	location.href="/_mngr_/board/"+menuCode+"_view_"+bcid+".do?" + tmpQuery;
}


function fn_goRegist() {
		 location.href="/_mngr_/contract/contract_input.do?"+ queryString;
}

function fn_search(){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");
	f.submit();
}

$("#siteCode").change(function(){
	var f = document.listForm;
	fn_search();
});

function fn_egov_link_page(pageNo){
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}

function pageChange(pageType){
	var f = document.listForm;
	<c:if test="${mngrSessionVO.currSiteCode == 'SYSTEM'}">f.siteCode.value='all';</c:if>
	f.pageType.value=pageType;
	f.submit();
}


</script>

