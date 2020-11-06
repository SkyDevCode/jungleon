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
 * @파일명 : mngrRentList.jsp
 * @파일정보 : 관리자 사업신청 > 대관신청
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 4. 15. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
			<form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;">
				<input type="hidden" name="mode" value="" />
				<div class="row margin-bottom">
					<div class="col-sm-8 form-inline">
						<select name="schStatus" id="schStatus" class="form-control input-sm">
							<option value="" ${ufn:selected(searchVO.schFld, '')}>처리상태</option>
							<c:forEach var="code" items="${statusCodeList }">
							<option value="${code.ccode}" ${ufn:selected(searchVO.schStatus, code.ccode)}><c:out value="${code.cname}" /></option>
							</c:forEach>
						</select>
						<label for="schFld" class="sr-only">검색조건</label>
						<select name="schFld" id="schFld" class="form-control input-sm">
								<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
								<option value="1" ${ufn:selected(searchVO.schFld, '1') }>담당자</option>
								<option value="2" ${ufn:selected(searchVO.schFld, '2') }>이메일</option>
							</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>
					<div class="col-sm-4 text-right">
						<button type="button" onclick="fn_getExcel();" class="btn btn-default"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button>
						<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:55px;">
								<col style="width:75px;">
								<col style="width:150px;">
								<col style="">
								<col style="width:100px;">
								<col style="width:100px;">
								<col style="width:100px;">
								<col style="width:100px;">
								<col style="width:100px;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
									<th scope="col">NO</th>
									<th scope="col">담당자</th>
									<th scope="col">대관 장소</th>
									<th scope="col">모임 분류</th>
									<th scope="col">신청일</th>
									<th scope="col">예약일</th>
									<th scope="col">처리 상태</th>
									<th scope="col">사용료</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td class="tac"><input type="checkbox" name="chkId" value="<c:out value="${result.rIdx }" />" title="선택" /></td>
										<td class="tac"><c:out value="${listNo -(status.count-1) }" /></td>
										<td class="bg_title tac" style="padding-left: ${lpadding}px;"><a href="#none" onclick="fn_goView('<c:out value="${result.rIdx }" />')"><c:out value="${result.rName }" /></a></td>
										<td class="tac"><a href="#none" onclick="fn_goView('<c:out value="${result.rIdx }" />')"><c:out value="${result.rFacilityName }" /></a></td>
										<td class="tac"><c:out value="${result.rMeetTypeName }" /></td>
										<td class="tac"><c:out value="${fn:substring(result.regdt, 0, 10) }" /></td>
										<td class="tac"><c:out value="${fn:substring(result.rReserveDt, 0, 10) }" /></td>
										<td class="tac"><c:out value="${result.rStatusName }" /></td>
										<td class="tac"><fmt:formatNumber value="${result.rCharge}" type="number" /></td>
									</tr>
								</c:forEach>
							<c:if test="${fn:length(resultList ) == 0}">
								<tr><td colspan="9" class="tac">데이터가 없습니다.</td></tr>
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

<script type="text/javascript">
//<[[!CDATA[
var queryString = "${searchVO.query}";


/* 글 조회 화면 function */
function fn_goView(id, notice) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", id);

	location.href= "?" + tmpQuery;
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}


function fn_search(){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStatus", f.schStatus.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
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
			frm.action = "/_mngr_/module/${menuCode}_mngrRentMultiDeleteProc.do";
			frm.submit();
		}
	}

}

function fn_getExcel(siteCode, bcid) {
	var tmpQuery = queryString;
	if(confirm("검색된 목록을 엑셀로 저장하시겠습니까?")) {
		location.href="/_mngr_/module/${menuCode}_mngrRentListExcelDown.do?" + tmpQuery;
	}
}

//]]>
</script>