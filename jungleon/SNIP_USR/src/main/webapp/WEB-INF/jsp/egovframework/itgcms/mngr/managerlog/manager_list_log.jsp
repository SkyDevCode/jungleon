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
 * @파일명 : mngrManagerLogList.jsp
 * @파일정보 : 관리자관리 목록
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
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
                <form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;">
                <div class="row margin-bottom sch-header">
					<div class="col-sm-6 form-inline">
						<label for="viewCount" class="sr-only">리스트 갯수</label>
						<select name="viewCount" id="viewCount" class="form-control input-sm">
							<option value="10" ${ufn:selected(searchVO.viewCount, '10') }>10</option>
							<option value="30" ${ufn:selected(searchVO.viewCount, '30') }>30</option>
							<option value="50" ${ufn:selected(searchVO.viewCount, '50') }>50</option>
							<option value="100" ${ufn:selected(searchVO.viewCount, '100') }>100</option>
						</select>
						<label for="schType" class="sr-only">작업구분</label>
                        <select name="schType" id="schType" class="form-control input-sm">
                                <option value="" ${ufn:selected(searchVO.schType, '') }>전체</option>
                                <option value="C" ${ufn:selected(searchVO.schType, 'C') }>등록</option>
                                <option value="R" ${ufn:selected(searchVO.schType, 'R') }>조회</option>
                                <option value="U" ${ufn:selected(searchVO.schType, 'U') }>수정</option>
                                <option value="D" ${ufn:selected(searchVO.schType, 'D') }>삭제</option>
                        </select>
						<label for="schSdt" class="sr-only">검색기간</label>
						<input type="text" name="schSdt" id="schSdt" class="form-control input-sm f-wd-100" value="<c:out value="${searchVO.schSdt }" />" />
						<span class="add-on">-</span>
						<input type="text" name="schEdt" id="schEdt" class="form-control input-sm f-wd-100" value="<c:out value="${searchVO.schEdt }" />" />
						<label for="schFld" class="sr-only">검색조건</label>
						<select name="schFld" id="schFld" class="form-control input-sm">
								<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
								<option value="1" ${ufn:selected(searchVO.schFld, '1') }>아이디</option>
								<option value="2" ${ufn:selected(searchVO.schFld, '2') }>이름</option>
							</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>
					<div class="col-sm-6 text-right">
						<button type="button" onclick="fn_goExcel();" class="btn btn-default"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;검색결과엑셀다운로드</button>
						<button type="button" onclick="fn_goExcelAll();" class="btn btn-default"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;전체엑셀다운로드</button>
						<button type="button" onclick="fn_goDel();" class="btn btn-danger">6개월이전 로그 삭제</button>
					</div>
				</div>
	                <div class="row">
	                	<div class="col-sm-12">
			                  <table id="example1" class="table table-bordered">
			                  	<colgroup>
			                  		<col width="60">
			                  		<col width="180">
			                  		<col>
			                  		<col>
			                  		<col width="100">
			                  		<col width="150">
			                  		<col width="150">
			                  		<col width="180">
			                  	</colgroup>
			                    <thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">작업일시</th>
										<th scope="col">메쏘드명</th>
										<th scope="col">클래스명</th>
										<th scope="col">작업구분</th>
										<th scope="col">아이디</th>
										<th scope="col">이름</th>
										<th scope="col">아이피</th>
									</tr>
								</thead>
			                    <tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td class="tac"><c:out value="${listNo -(status.count-1) }" /></td>
										<td class="tac"><c:out value="${result.mlogRegdt }" /></td>
										<td class="tac"><c:out value="${result.mlogMethod }" /></td>
										<td><c:out value="${result.mlogClass }" /></td>
										<td class="tac"><span style="<c:if test="${result.mlogType eq 'U' or result.mlogType eq 'D' }">color:red;</c:if>"><c:out value="${result.mlogTypeName}" /></span></td>
										<td class="tac"><c:out value="${result.mngId}" /></td>
										<td class="tac"><c:out value="${result.mngName}" /></td>
										<td class="tac"><c:out value="${result.mlogIp}" /></td>
									</tr>
									</c:forEach>
									<c:if test="${fn:length(resultList ) == 0}">
										<tr><td colspan="8">데이터가 없습니다.</td></tr>
									</c:if>
								</tbody>
			                  </table>
		                  </div> <!-- .col-sm-12 -->
	                  </div> <!--  .row -->
	                  <div class ="row">
	                  	<div class="col-sm-5 text-left">
	                  		<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">로그 건수 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /> 건, 페이지 : <fmt:formatNumber value="${paginationInfo.currentPageNo}" type="number" /> / <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
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
    ItgJs.fn_datePickerRange("#schSdt", "#schEdt");
})
var queryString = "${searchVO.query}";

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}

function fn_goExcel(){
	location.href="/_mngr_/common/managerlog/mngrManagerLogListExcel.do?" + queryString;
}

function fn_goExcelAll(){
	location.href="/_mngr_/common/managerlog/mngrManagerLogListExcel.do";
}

function fn_goDel(){
	if(confirm("6개월 이전 데이터를 모두 삭제합니다.\n\n데이터를 미리 백업 해 주세요.\n\n[확인]을 클릭하면 삭제됩니다.")){
	    	location.href="manager_delete_log.do";
	}
}

function fn_orderby(fld, orderby){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordFld", fld);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordBy", orderby);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
}

function fn_search(){
	var tmpQuery = queryString;
	var f = document.listForm;
	if(f.schSdt.value == ""){
		alert("검색기간 시작일을 입력 해 주세요.");
		f.schSdt.focus();
		return false;
	}
	if(f.schEdt.value == ""){
		alert("검색기간 종료일을 입력 해 주세요.");
		f.schEdt.focus();
		return false;
	}
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schSdt", f.schSdt.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schEdt", f.schEdt.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schType", f.schType.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
}
//]]>
</script>