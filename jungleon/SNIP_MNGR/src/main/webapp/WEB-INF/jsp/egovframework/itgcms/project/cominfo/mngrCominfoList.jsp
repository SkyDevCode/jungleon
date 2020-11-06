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
 * @파일명 : userCominfoList.jsp
 * @파일정보 : 관리자 성남기업소개 > 성남기업 및 상품소개 > 기업정보
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 4. 8. 최초생성
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
						<label for="viewCount" class="sr-only">리스트 갯수</label>
						<label for="schFld" class="sr-only">검색조건</label>
						<select name="schFld" id="schFld" class="form-control input-sm">
								<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
								<option value="1" ${ufn:selected(searchVO.schFld, '1') }>업체명</option>
								<option value="2" ${ufn:selected(searchVO.schFld, '2') }>상품명</option>
							</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>
					<div class="col-sm-4 text-right">
						<button type="button" onclick="fn_downloadExcel();" class="btn btn-default"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button>
						<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:55px;">
								<col style="width:70px;">
								<col style="width:250px;">
								<col style="">
								<col style="width:150px;">
								<col style="width:200px;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
									<th scope="col">NO</th>
									<th scope="col">업체명</th>
									<th scope="col">상품명</th>
									<th scope="col">전화번호</th>
									<th scope="col">홈페이지</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td class="tac"><input type="checkbox" name="chkId" value="<c:out value="${result.busiRegNo }" />" title="선택" /></td>
										<td class="tac"><c:out value="${listNo -(status.count-1) }" /></td>
										<td class="bg_title" style="padding-left: ${lpadding}px;"><a href="#none" onclick="fn_goView('<c:out value="${result.busiRegNo }" />')"><c:out value="${result.comNm }" /></a></td>
										<td class=""><c:out value="${result.mainProduct }" /></td>
										<td class="tac"><c:out value="${result.officeTel01 }-${result.officeTel02 }-${result.officeTel03 }" /></td>
										<td class=""><c:out value="${result.hPage }" /></td>
									</tr>
								</c:forEach>
							<c:if test="${fn:length(resultList ) == 0}">
								<tr><td colspan="6" class="tac">데이터가 없습니다.</td></tr>
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
$(document).ready(function(){
	$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
})
var queryString = "${searchVO.query}";


/* 글 조회 화면 function */
function fn_goView(id, notice) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", id);

	var viewUrl = "/_mngr_/module/${menuCode}_mngrCominfoList.do?";
	
	location.href= viewUrl + tmpQuery;
}


/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}

function fn_search(){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
}

function fn_downloadExcel() {
	var tmpQuery = queryString;
	if(confirm("검색된 목록을 엑셀로 저장하시겠습니까?")) {
		location.href="/_mngr_/module/${menuCode}_mngrCominfoListExcelDown.do?" + tmpQuery;
	}
}

function fn_chkDel(){
	var frm = document.listForm;
	if($("input[name=chkId]:checked").size() == 0){
		alert("삭제할 게시물을 선택 해 주세요.");
		return false;
	}else{
		if(confirm("선택한 게시물을 삭제하시겠습니까?")){
			frm.mode.value="delete";
			frm.action = "/_mngr_/module/${menuCode}_mngrCominfoMultiDeleteProc.do";
			frm.submit();
		}
	}

}

//]]>
</script>