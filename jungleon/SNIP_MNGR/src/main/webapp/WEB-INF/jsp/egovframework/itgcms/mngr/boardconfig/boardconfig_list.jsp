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
 * @파일명 : boardconfig_list.jsp
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
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
                <form name="listForm" method="post" onsubmit="fn_search(); return false;">
                <div class="row margin-bottom">
					<div class="col-sm-8 form-inline">
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
								<option value="1" ${ufn:selected(searchVO.schFld, '1') }>게시판 아이디</option>
								<option value="2" ${ufn:selected(searchVO.schFld, '2') }>게시판 이름</option>
							</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>
					<div class="col-sm-4 text-right">
						<button type="button" onclick="fn_goRegist();" class="btn btn-primary">등록</button>
						<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
					</div>
				</div>
	                <div class="row">
	                	<div class="col-sm-12">
			                  <table id="example1" class="table table-bordered tac">
			                  	<colgroup>
			                  		<col width="50">
			                  		<col width="60">
			                  		<col>
			                  		<col>
			                  		<col>
			                  		<col width="80">
			                  		<col width="50">
			                  		<col width="50">
			                  		<col width="60">
			                  		<col width="60">
			                  		<col width="75">
			                  		<col width="60">
			                  		<col width="60">
			                  		<col width="60">
			                  		<col width="50">
			                  		<col width="50">
			                  		<col width="80">
			                  	</colgroup>
			                    <thead>
									<tr>
										<th scope="col" rowspan="2"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
										<th scope="col" rowspan="2">번호</th>
										<th scope="col" rowspan="2"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="게시판 아이디" fieldValue="id" /></th>
										<th scope="col" rowspan="2"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="게시판 이름" fieldValue="name" /></th>
										<th scope="col" rowspan="2">게시판스킨</th>
										<th scope="col" rowspan="2">목록갯수</th>
<!--									<th scope="col" colspan="5">권한정보</th> -->
										<th scope="col" colspan="10">기능정보</th>
										<th scope="col" rowspan="2">게시물수</th>
									</tr>
									<tr>
<!-- 									<th scope="col">목록</th> -->
<!-- 									<th scope="col">조회</th> -->
<!-- 									<th scope="col">등록</th> -->
<!-- 									<th scope="col">수정</th> -->
<!-- 									<th scope="col">답변</th> -->
										<th scope="col">답변</th>
										<th scope="col">첨부</th>
										<th scope="col">비밀글</th>
										<th scope="col">공지글</th>
										<th scope="col">카테고리</th>
										<th scope="col">에디터</th>
										<th scope="col">이전/다음글</th>
<!-- 									<th scope="col">공공누리</th> -->
										<th scope="col">썸네일</th>
										<th scope="col">RSS</th>
										<th scope="col">댓글</th>
									</tr>
								</thead>
			                    <tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td><input type="checkbox" name="chkId" value="<c:out value="${result.bcId }" />" title="선택" /></td>
										<td class="tac"><c:out value="${listNo -(status.count-1) }" /></td>
										<td class="tb_left bg_id"><a href="#none" onclick="fn_goView('<c:out value="${result.bcId}" />'); return false;" title="${result.bcId }"><c:out value="${ufn:cutString(result.bcId, 10, '...')}" /></a></td>
										<td class="bg_name" title="${result.bcName }"><c:out value="${ufn:cutString(result.bcName, 10, '...')}" /></td>
										<td class=""><c:out value="${skinResult[result.bcSkin]}" /></td>
										<td class="tac"><c:out value="${result.bcViewcount}" /></td>
<%--									<td class=""><c:out value="${hmUserAuth[result.bcList]}" /></td> --%>
<%--									<td class=""><c:out value="${hmUserAuth[result.bcView]}" /></td> --%>
<%--									<td class=""><c:out value="${hmUserAuth[result.bcRegist]}" /></td> --%>
<%--									<td class=""><c:out value="${hmUserAuth[result.bcUpdate]}" /></td> --%>
<%--									<td class=""><c:out value="${hmUserAuth[result.bcReply]}" /></td> --%>
										<td class="tac"><span class="label label-<c:out value="${ufn:deCode(result.bcReplyyn,'Y,success,N,danger','')}" />"><c:out value="${result.bcReplyyn }" /></span></td>
										<td class="tac"><span class="label label-<c:out value="${ufn:deCode(result.bcFileyn,'Y,success,N,danger','')}" />"><c:out value="${result.bcFileyn}" /></span></td>
										<td class="tac"><span class="label label-<c:out value="${ufn:deCode(result.bcSecretyn,'Y,success,N,danger','')}" />"><c:out value="${result.bcSecretyn}" /></span></td>
										<td class="tac"><span class="label label-<c:out value="${ufn:deCode(result.bcNoticeyn,'Y,success,N,danger','')}" />"><c:out value="${result.bcNoticeyn}" /></span></td>
										<td class="tac"><span class="label label-<c:out value="${ufn:deCode(result.bcGroupyn,'Y,success,N,danger','')}" />"><c:out value="${result.bcGroupyn}" /></span></td>
										<td class="tac"><span class="label label-<c:out value="${ufn:deCode(result.bcEditoryn,'Y,success,N,danger','')}" />"><c:out value="${result.bcEditoryn}" /></span></td>
										<td class="tac"><span class="label label-<c:out value="${ufn:deCode(result.bcPrevnextyn,'Y,success,N,danger','')}" />"><c:out value="${result.bcPrevnextyn}" /></span></td>
<%-- 								<td class=""><span class="label label-<c:out value="${ufn:deCode(result.bcKoglyn,'Y,success,N,danger','')}" />"><c:out value="${result.bcKoglyn}" /></span></td> --%>
										<td class="tac"><span class="label label-<c:out value="${ufn:deCode(result.bcThumbyn,'Y,success,N,danger','')}" />"><c:out value="${result.bcThumbyn}" /></span></td>
										<td class="tac"><span class="label label-<c:out value="${ufn:deCode(result.bcRSS,'Y,success,N,danger','')}" />"><c:out value="${result.bcRSS}" /></span></td>
										<td class="tac"><span class="label label-<c:out value="${result.bcComment == 0 ? 'danger' : 'success'}" />"><c:out value="${result.bcComment == 0 ? 'N' : 'Y'}" /></span></td>
										<td class="tac"><fmt:formatNumber value="${result.boardCnt }" type="number" /></td>
									</tr>
									</c:forEach>
									<c:if test="${fn:length(resultList ) == 0}">
									<tr><td colspan="15">데이터가 없습니다.</td></tr>
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
var queryString = "${searchVO.query}";

/* 글 수정 화면 function */
function fn_goView(id) {
	location.href="boardconfig_edit.do?" + ItgJs.fn_replaceQueryString(queryString, "id", id);
}

/* 글 등록 화면 function */
function fn_goRegist() {
   	location.href="boardconfig_input.do";
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
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

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
			document.listForm.action = "boardconfig_delete_chkProc.do";
		   	document.listForm.submit();
		}
	}
}
//]]>
</script>