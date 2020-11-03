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
 * @파일명 : mngrProgramList.jsp
 * @파일정보 : 프로그램관리 목록
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
					<label for="schFld" class="sr-only">검색조건</label>
					<select name="schFld" id="schFld" class="form-control input-sm">
						<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
						<option value="1" ${ufn:selected(searchVO.schFld, '1') }>프로그램 명</option>
						<option value="2" ${ufn:selected(searchVO.schFld, '2') }>사용자 URL</option>
						<option value="3" ${ufn:selected(searchVO.schFld, '3') }>관리자 URL</option>
					</select>
					<label for="schStr" class="sr-only">검색어</label>
					<input name="schStr" id="schStr"  class="form-control input-sm f-wd-400" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
					<button class="btn btn-default btn-sm btn-sm-search">검색</button>
				</div>
				<div class="col-sm-4 text-right">
					<button type="button" onclick="fn_goRegist();" class="btn btn-primary">등록</button>
					</div>
				</div>
              	<div class="row">
              		<div class="col-sm-12">
                  		<table id="example1" class="table table-bordered">
		                  	<colgroup>
		                  		<col style="width:60px">
		                  		<col style="">
		                  		<col style="width:34%">
		                  		<col style="width:34%">
		                  	</colgroup>
                    		<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="프로그램 명" fieldValue="name" /></th>
									<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="사용자 URL" fieldValue="user" /></th>
									<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="관리자 URL" fieldValue="mngr" /></th>
								</tr>
							</thead>
                    		<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="tac"><c:out value="${listNo -(status.count-1) }" /></td>
									<td class="tb_left bg_id"><a href="#none" onclick="fn_goView('<c:out value="${result.progIdx}" />'); return false;"><c:out value="${result.progName}" /></a></td>
									<td class="tb_left bg_user"><c:out value="${ufn:cutString(result.progUserurl, 70, '...') }" /></td>
									<td class="tb_left bg_mngr"><c:out value="${ufn:cutString(result.progMngrurl, 70, '...') }" /></td>
								</tr>
								</c:forEach>
								<c:if test="${fn:length(resultList ) == 0}">
									<tr><td colspan="4" style="text-align: center;">데이터가 없습니다.</td></tr>
								</c:if>
							</tbody>
                  		</table>
                 	</div> <!-- .col-sm-12 -->
                </div> <!--  .row -->
                <div class ="row">
                	<div class="col-sm-5 text-left">
                		<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">프로그램 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /> 건, 페이지 : <fmt:formatNumber value="${paginationInfo.currentPageNo}" type="number" /> / <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
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
			</div> <!-- /box-body -->
		</div> <!-- /box -->
	</div> <!-- /col -->
</div> <!-- /row -->

<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
})
var queryString = "${searchVO.query}";


/* 글 수정 화면 function */
function fn_goView(id) {
	location.href="prog_edit.do?" + ItgJs.fn_replaceQueryString(queryString, "id", id);
}

/* 글 등록 화면 function */
function fn_goRegist() {
   	location.href="prog_input.do";
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
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
	//tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
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

function fn_chkDel(){
	if($("input[name=chkId]:checked").size() == 0){
		alert("삭제할 게시물을 선택 해 주세요.");
		return false;
	}else{
		if(confirm("선택한 게시물을 삭제하시겠습니까?")){
			document.listForm.action = "prog_delete_proc.do";
		   	document.listForm.submit();
		}
	}
}
//]]>
</script>
