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
<%
/**
 * @파일명 : _mngr__default_list.jsp
 * @파일정보 : 관리자 일반형 게시판 목록 스킨
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
<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
})
var queryString = "${searchVO.query}";


/* 글 조회 화면 function */
function fn_goView(id, notice) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "id", id);

	var viewUrl = "/_mngr_/board/${menuCode}_view_${bcid}.do?";
	if (notice) {
		tmpQuery += "&notice="+notice;
		viewUrl = "/_mngr_/board/${menuCode}_view_${bcid}_notice.do?";
	}

	location.href= viewUrl + tmpQuery;
}

/* 글 등록 화면 function */
function fn_goRegist() {
	location.href="/_mngr_/board/${menuCode}_input_${bcid}.do?schM=regist";
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}

function fn_orderby(fld, orderby){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordFld", fld);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordBy", orderby);
	/* tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value); */
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");
	location.href="?" + tmpQuery;
}

function fn_search(){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schBdcode", f.schBdcode.value);
</c:if>
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
}

function fn_chkDel(){
	var frm = document.listForm;
	if($("input[name=chkId]:checked").size() == 0){
		alert("삭제할 게시물을 선택 해 주세요.");
		return false;
	}else{
		if(confirm("선택한 게시물을 삭제하시겠습니까?")){
			frm.mode.value="delete";
			frm.action = "/_mngr_/board/${menuCode}_proc_${bcid}.do";
			frm.submit();
		}
	}

}

function fn_getExcel(siteCode, bcid) {
	if (confirm("해당 게시판의 전체 목록을 엑셀로 저장하시겠습니까?")) {
		document.listForm.action = "/bbsExcel/"+siteCode+"/"+bcid+".do";
		document.listForm.submit();
	}
}

//]]>
</script>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
			<form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;">
				<input type="hidden" name="mode" value="" />
				<div class="row margin-bottom">
					<div class="col-sm-8 form-inline">
						<label for="viewCount" class="sr-only">리스트 갯수</label>
						<select name="viewCount" id="viewCount" class="form-control input-sm">
							<option value="${boardconfigVO.bcViewcount *1}" ${ufn:selected(searchVO.viewCount, boardconfigVO.bcViewcount *1) }>${boardconfigVO.bcViewcount *1}</option>
							<option value="${boardconfigVO.bcViewcount *2}" ${ufn:selected(searchVO.viewCount, boardconfigVO.bcViewcount *2) }>${boardconfigVO.bcViewcount *2}</option>
							<option value="${boardconfigVO.bcViewcount *5}" ${ufn:selected(searchVO.viewCount, boardconfigVO.bcViewcount *5) }>${boardconfigVO.bcViewcount *5}</option>
							<option value="${boardconfigVO.bcViewcount*10}" ${ufn:selected(searchVO.viewCount, boardconfigVO.bcViewcount*10) }>${boardconfigVO.bcViewcount*10}</option>
						</select>
						<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
							<label for="schBdcode" class="sr-only">검색구분</label>
							<ora:selectCodeList selectName="schBdcode" selectedValue="${searchVO.schBdcode }" codeList="${codeList }" selectTitle="센터명" className="form-control input-sm"/>
						</c:if>
						<%-- <label for="schFld" class="sr-only">검색조건</label>
						<select name="schFld" id="schFld" class="form-control input-sm">
							<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
							<option value="1" ${ufn:selected(searchVO.schFld, '1') }>제목</option>
							<option value="2" ${ufn:selected(searchVO.schFld, '2') }>작성자</option>
							<option value="3" ${ufn:selected(searchVO.schFld, '3') }>내용</option>
						</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/> --%>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>
					<div class="col-sm-4 text-right">
						<button type="button" onclick="fn_getExcel('${mngrSessionVO.currSiteCode}', '${bcid }');" class="btn btn-default"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button>
						<button type="button" onclick="fn_goRegist();" class="btn btn-primary">등록</button>
						<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:55px;">
								<col style="width:70px;">
								<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
									<col style="width:150px;">
								</c:if>
								<col style="">
								<c:if test="${boardconfigVO.bcFileyn eq  'Y' }">
									<col style="width:70px;">
								</c:if>
								<col style="width:150px;">
								<col style="width:150px;">
								<col style="width:100px;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
									<th scope="col">번호</th>
									<c:set var="colspan" value="7" />
									<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
										<c:set var="colspan" value="${colspan + 1 }" />
										<th scope="col">사업명</th>
									</c:if>
									<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="제목" fieldValue="title" /></th>
									<th scope="col">접수기간</th>
									<c:if test="${boardconfigVO.bcFileyn eq  'Y' }">
										<c:set var="colspan" value="${colspan + 1 }" />
										<th scope="col">첨부</th>
									</c:if>
									<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="작성자" fieldValue="writer" /></th>
									<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="등록일" fieldValue="regdt" /></th>
									<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="조회수" fieldValue="readnum" /></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${noticeList}" varStatus="status">
									<tr>
										<td class="tac"><input type="checkbox" disabled="disabled"/></td>
										<td class="tac"><strong>공지</strong></td>
										<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
											<td class="tac">-</td>
										</c:if>
											<td class="bg_title" style="padding-left: ${lpadding}px;"><a href="#none" onclick="fn_goView('<c:out value="${result.bdIdx }" />', '<c:out value="${result.bcId}" />')"><c:out value="${result.bdTitle }" /></a></td>
										<c:if test="${boardconfigVO.bcFileyn eq  'Y' }">
											<td class="tac">
												<c:if test="${result.fileCnt > 0 }">
													<i class="fa fa-paperclip"></i>
												</c:if>
											</td>
										</c:if>
										<td class="bg_writer tac"><c:out value="${result.bdWriter }" /></td>
										<td class="bg_regdt tac">
											<fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd" value="${result.regdt}"/>
											<fmt:formatDate pattern="yyyy-MM-dd" value="${dateFmt}"/></td>
										<td class="bg_readnum tac"><fmt:formatNumber value="${result.bdReadnum }" /></td>
									</tr>
								</c:forEach>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									 <c:set var="lpadding" value="8" />
									 <c:if test="${boardconfigVO.bcReplyyn eq 'Y'}">
										 <c:set var="lpadding" value="${lpadding + result.bdRelevel * 10 }" />
									 </c:if>
									<tr>
										<td class="tac"><input type="checkbox" name="chkId" value="<c:out value="${result.bdIdx }" />" title="선택" /></td>
										<td class="tac"><c:out value="${listNo -(status.count-1) }" /></td>
										<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
											<td class="tac"><c:out value="${result.bdCodeName }" /></td>
										</c:if>
										<td class="bg_title" style="padding-left: ${lpadding}px;"><a href="#none" onclick="fn_goView('<c:out value="${result.bdIdx }" />')"><c:out value="${result.bdTitle }" /></a></td>





										<td class="bg_regdt tac"><c:out value='${result.bdExt5 }' /></td>






										<c:if test="${boardconfigVO.bcFileyn eq  'Y' }">
											<td class="tac">
											<c:if test="${result.fileCnt > 0 }">
												<i class="fa fa-paperclip"></i>
											</c:if>
											</td>
										</c:if>
										<td class="bg_writer tac"><c:out value="${result.bdWriter }" /></td>
										<td class="bg_regdt tac">
											<fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd" value="${result.regdt}"/>
											<fmt:formatDate pattern="yyyy-MM-dd" value="${dateFmt}"/></td>
										<td class="bg_readnum tac"><fmt:formatNumber value="${result.bdReadnum }" /></td>
									</tr>
								</c:forEach>
							<c:if test="${fn:length(resultList ) == 0}">
								<tr class="tac"><td colspan="${colspan }">데이터가 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
					</div> <!-- .col-sm-12 -->
				</div> <!--  .row -->
				<div class ="row">
					<div class="col-sm-5 text-left">
						<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">게시물 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /> 건, 페이지 : <fmt:formatNumber value="${paginationInfo.currentPageNo}" type="number" /> / <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
					</div>
					<div class="col-sm-7">
						<div class="text-center dataTables_paginate paging_simple_numbers" id="example1_paginate">
							<ul class="pagination">
							<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page" />
							</ul>
						</div>
					</div>
				</div>
			</form>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->