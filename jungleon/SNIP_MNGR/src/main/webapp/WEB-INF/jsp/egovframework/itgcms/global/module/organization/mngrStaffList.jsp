
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
 * @파일명 : mngrStaffList.jsp
 * @파일정보 : 조직및사무 직원리스트 조회 페이지
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @jyl 2017. 10. 16. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>



<!-- Content Wrapper. Contains page content -->

	<!-- Main content -->
	<section class="content" style="padding:0;">
		<div class="row">
			<div class="col-xs-12">
				<div>
					<div>
					<form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;" enctype="multipart/form-data">
						<input type="hidden" name="schId" id="schId"/>
						<input type="hidden" name="staffOrd" id="staffOrd" value=""/>
						<input type="hidden" name="staffNo" id="staffNo" value=""/>
						<input type="hidden" name="direction" id="direction" value=""/>
						<div class="row margin-bottom">
							<div class="col-sm-7 form-inline">
								<label for="viewCount" class="sr-only">리스트 갯수</label>
								<select name="viewCount" id="viewCount" class="form-control input-sm">
									<option value="10" ${ufn:selected(searchVO.viewCount, '10') }>10</option>
									<option value="30" ${ufn:selected(searchVO.viewCount, '30') }>30</option>
									<option value="50" ${ufn:selected(searchVO.viewCount, '50') }>50</option>
									<option value="100" ${ufn:selected(searchVO.viewCount, '100') }>100</option>
								</select>

								<select id="schOpt2" name="schOpt2" class="form-control input-sm">
									<option value="" ${ufn:selected(searchVO.schOpt2, '') }>부서</option>
									<c:forEach var="code" items="${groupList}">
										<option value="${code.ccode}" ${searchVO.schOpt2 eq code.ccode ? 'selected':''} >${code.cname}</option>
									</c:forEach>
								</select>

								<select id="schOpt3" name="schOpt3" class="form-control input-sm">
									<option value="" ${ufn:selected(searchVO.schOpt3, '') }>직책</option>
									<c:forEach var="code" items="${position}">
										<option value="${code.ccode}" ${searchVO.schOpt3 eq code.ccode ? 'selected':''} >${code.cname}</option>
									</c:forEach>
								</select>

								<label for="schFld" class="sr-only">검색조건</label>
								<select name="schFld" id="schFld" class="form-control input-sm">
									<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
									<option value="1" ${ufn:selected(searchVO.schFld, '1') }>성명</option>
									<option value="2" ${ufn:selected(searchVO.schFld, '2') }>전화번호</option>
								</select>
								<label for="schStr" class="sr-only">검색어</label>
								<input name="schStr" id="schStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>

								<button class="btn btn-default btn-sm">검색</button>
							</div>
							<div class="col-sm-5 text-right">
								<button type="button" onclick="fn_goExcel();" class="btn btn-default"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button>
								<button type="button" onclick="fn_goRegist();" class="btn btn-primary">등록</button>
								<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<table id="example1" class="table table-bordered">

									<thead>
										<tr>
											<th scope="col" class="text-center"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
											<th scope="col" class="text-center">번호</th>
											<th scope="col" class="text-center">정렬</th>
											<th scope="col" class="text-center">성명</th>
											<th scope="col" class="text-center">부서</th>
											<th scope="col" class="text-center">직책</th>
											<th scope="col" class="text-center">전화번호</th>
										</tr>
									</thead>
									<tbody class="imgRow">
										<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td class="text-center" style="vertical-align:middle"><input type="checkbox" name="chkId" value="<c:out value="${result.staffNo}" />" title="선택" onclick="ItgJs.fn_check($(this).attr('name'), $('#chkAll').attr('id'));" /></td>
											<td class="text-center" style="vertical-align:middle"><c:out value="${listNo -(status.count-1) }" /></td>
											<td class="text-center" style="vertical-align:middle">
											<a href="#none" onclick="fn_order('${result.staffOrd}','${result.staffNo}','up','${paginationInfo.totalRecordCount}'); return false;">▲</a>
											<a href="#none" onclick="fn_order('${result.staffOrd}','${result.staffNo}','down','${paginationInfo.totalRecordCount}'); return false;">▼</a>
											</td>
											<td class="text-center tb_left bg_comemIdx" style="vertical-align:middle"><a href="#none" onclick="fn_goView('<c:out value="${result.staffNo}" />'); return false;"><c:out value="${result.staffNm}" /></a></td>
											<td class="text-center tb_left bg_comemIdx" style="vertical-align:middle"><c:out value="${result.staffDept}" /></td>
											<td class="text-center tb_left bg_comemIdx" style="vertical-align:middle"><c:out value="${result.staffPos}" /></td>
											<td class="text-center tb_left bg_comemIdx" style="vertical-align:middle"><c:out value="${result.telNo}" /></td>
										</tr>
										</c:forEach>
										<c:if test="${fn:length(resultList ) == 0}">
											<tr><td colspan="7" class="text-center" style="vertical-align:middle" >데이터가 없습니다.</td></tr>
										</c:if>
									</tbody>
								</table>
							</div> <!-- .col-sm-12 -->
						</div> <!--  .row -->
						<div class ="row">
							<div class="col-sm-5 text-left">
								<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">전체 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /> 개, 페이지 : <fmt:formatNumber value="${paginationInfo.currentPageNo}" type="number" /> / <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
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
	</section><!-- /.content -->





<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
})
var queryString = "${searchVO.queryString()}";


/* 직원정보 수정 화면 function */
function fn_goView(schId) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", schId);
		location.href="?schM=view"+ tmpQuery;
}

/* 직원정보 등록 화면 function */
function fn_goRegist() {
		 location.href="?schM=regist";
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}

/* 직원정보 선택삭제 */
function fn_chkDel(){
	if($("input[name=chkId]:checked").size() == 0){
		alert("삭제할 글을 선택 해 주세요.");
		return false;
	}else{
		if(confirm("선택한 글을 삭제하시겠습니까?")){
			document.listForm.action = "/_mngr_/module/mngrOrganization.do?schM=proc&act=chkDelete&menuUrl=${menuCode}";
			document.listForm.submit();
		}
	}
}

/* 직원검색 */
function fn_search(){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schOpt2", f.schOpt2.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schOpt3", f.schOpt3.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
}

/* 엑셀 다운로드 */
function fn_goExcel(){
	location.href="/_mngr_/module/mngrOrganization.do?schM=proc&act=excelDown" + queryString;
}

/* 직원리스트 순서 정렬 */
function fn_order(staffOrd,staffNo,direction,totalCnt) {

	if(staffOrd == 1 && direction =='up'){
		alert("최상위 순서입니다.");
		return false;
	}else if(staffOrd == totalCnt && direction =='down'){
		alert("최하위 순서입니다.");
		return false;
	}
 	frm = document.listForm;
	 	frm.staffOrd.value = staffOrd;
	 	frm.staffNo.value = staffNo;
	 	frm.direction.value = direction;

	frm.action = "/_mngr_/module/mngrOrganization.do?schM=proc&act=CHANGE&menuUrl=${menuCode}"+ queryString;
    frm.submit();


}

//]]>
</script>
