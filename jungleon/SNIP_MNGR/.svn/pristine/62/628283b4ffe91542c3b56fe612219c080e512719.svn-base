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
 * @파일명 : mngrComemberList.jsp
 * @파일정보 : 기업회원관리 목록
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 7. 5. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
					<form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;">
						<input type="hidden" name="comemStatus" id="comemStatus"/>
						<input type="hidden" name="schId" id="schId"/>
						<div class="row margin-bottom">
							<div class="col-sm-7 form-inline tp2">
								<label for="viewCount" class="sr-only">리스트 갯수</label>
								<select name="viewCount" id="viewCount" class="form-control input-sm">
									<option value="10" ${ufn:selected(searchVO.viewCount, '10') }>10</option>
									<option value="30" ${ufn:selected(searchVO.viewCount, '30') }>30</option>
									<option value="50" ${ufn:selected(searchVO.viewCount, '50') }>50</option>
									<option value="100" ${ufn:selected(searchVO.viewCount, '100') }>100</option>
								</select>
								<label for="schFld" class="sr-only">검색조건</label>
								<select name="schFld" id="schFld" class="form-control input-sm">
									<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
									<option value="1" ${ufn:selected(searchVO.schFld, '1') }>기업명</option>
									<option value="2" ${ufn:selected(searchVO.schFld, '2') }>대표자명</option>
								</select>
								<label for="schStr" class="sr-only">검색어</label>
								<input name="schStr" id="schStr"  class="form-control input-sm f-wd-400" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
								<button class="btn btn-default btn-sm btn-sm-search">검색</button>
							</div>
							<div class="col-sm-5 text-right">
								<button type="button" onclick="fn_goExcel();" class="btn btn-default"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button>
								<button type="button" onclick="fn_goRegist();" class="btn btn-primary">등록</button>
								<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
								<button type="button" onclick="fn_chkConfirm();" class="btn btn-default">승인</button>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<table id="example1" class="table table-bordered">
									<colgroup>
										<col width="50"><%-- 구분 --%>
										<col width="60">
										<col>
										<col>
										<col>
										<col width="150">
										<col width="150">
										<col width="150">
									</colgroup>
									<thead>
										<tr>
											<th scope="col" class="text-center"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
											<th scope="col" class="text-center">번호</th>
											<th scope="col" class="text-center"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="기업명" fieldValue="comemName" /></th>
											<th scope="col" class="text-center"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="대표자명" fieldValue="comemCeonm" /></th>
											<th scope="col" class="text-center"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="주소(본사)" fieldValue="comemAddr" /></th>
											<th scope="col" class="text-center"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="교육담당자명" fieldValue="comemChrgeName" /></th>
											<th scope="col" class="text-center"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="전화번호" fieldValue="comemChrgeTel" /></th>
											<th scope="col" class="text-center"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="기업상태" fieldValue="comemStatus" /></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td class="text-center" style="vertical-align:middle"><input type="checkbox" name="chkId" value="<c:out value="${result.comemIdx }" />" title="선택" onclick="ItgJs.fn_check($(this).attr('name'), $('#chkAll').attr('id'));" /></td>
											<td class="text-center" style="vertical-align:middle"><c:out value="${listNo -(status.count-1) }" /></td>
											<td class="text-center tb_left bg_comemIdx" style="vertical-align:middle"><a href="#none" onclick="fn_goView('<c:out value="${result.comemIdx }" />'); return false;"><c:out value="${result.comemName}" /></a></td>
											<td class="text-center tb_left bg_comemIdx" style="vertical-align:middle"><c:out value="${result.comemCeonm}" /></td>
											<td class="tb_left bg_comemIdx" style="vertical-align:middle"><c:out value="${result.comemAddr}" /></td>
											<td class="text-center tb_left bg_comemIdx" style="vertical-align:middle"><c:out value="${result.comemChrgeName}" /></td>
											<td class="text-center tb_left bg_comemIdx" style="vertical-align:middle"><c:out value="${result.comemChrgeTel}" /></td>
											<td class="text-center tb_left bg_comemIdx" style="vertical-align:middle"><c:out value="${result.comemStatusNm}" /></td>
										</tr>
										</c:forEach>
										<c:if test="${fn:length(resultList ) == 0}">
											<tr><td colspan="8" class="text-center" style="vertical-align:middle" >데이터가 없습니다.</td></tr>
										</c:if>
									</tbody>
								</table>
							</div> <!-- .col-sm-12 -->
						</div> <!--  .row -->
						<div class ="row">
							<div class="col-sm-5 text-left">
								<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">전체 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /> 개사, 페이지 : <fmt:formatNumber value="${paginationInfo.currentPageNo}" type="number" /> / <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
							</div>
							<div class="col-sm-7">
								<div class="text-center dataTables_paginate paging_simple_numbers" id="example1_paginate">
									<ul class="pagination">
									<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
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
$(document).ready(function(){
	$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
})
var queryString = "${searchVO.queryString()}";


/* 글 수정 화면 function */
function fn_goView(schId) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", schId)
	location.href="comember_edit.do?" + tmpQuery;
}

/* 글 등록 화면 function */
function fn_goRegist() {
		 location.href="comember_input.do";
}

function fn_orderby(fld, orderby){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordFld", fld);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordBy", orderby);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}

function fn_chkDel(){
	if($("input[name=chkId]:checked").size() == 0){
		alert("삭제할 기업회원를 선택 해 주세요.");
		return false;
	}else{
		if(confirm("선택한 기업회원를 삭제하시겠습니까?")){
			document.listForm.action = "comember_delete_chkProc.do";
			document.listForm.submit();
		}
	}
}

function fn_search(){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
}

function fn_chkConfirm(){
	if($("input[name=chkId]:checked").size() == 0){
		alert("가입승인 기업을 선택 해 주세요.");
		return false;
	}else{
		if(confirm("선택한 기업을 승인하시겠습니까?")){
			document.listForm.action = "comember_edit_chkConfirm.do";
			document.listForm.submit();
		}
	}
}

function fn_goExcel(){
	location.href="/_mngr_/excel/mngrComemberListExcel.do?" + queryString;
}
//]]>
</script>