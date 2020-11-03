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
 * @파일명 : mngrTotalTbList.jsp
 * @파일정보 : 관리자 사업안내 > 총괄표리스트
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @hsk1218 2020. 4. 27. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

<script type="text/javascript">

function fn_orderby(fld, orderby) {
	var tmpQuery = "";
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordFld", fld);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordBy", orderby);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");
	location.href="?" + tmpQuery;
}

function fn_getExcel() {
	var tmpQuery = "";
	if(confirm("검색된 목록을 엑셀로 저장하시겠습니까?")) {
		location.href="/_mngr_/module/${menuCode}_mngrNewsletterExcelDown.do";
	}
}

/* 글 조회 화면 function */
function fn_goView(id) {
	var tmpQuery = "";
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "update");
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", id);

	location.href="/_mngr_/module/${menuCode}_list_newsletter.do?" + tmpQuery;
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	var queryString = "";
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}

/* 글 등록 화면 function */
function fn_goRegist() {
	location.href = "?schM=regist";
}


/* 글 삭제 function */
function fn_chkDel(){
	var frm = document.listForm;
	if($("input[name=chkId]:checked").size() == 0){
		alert("삭제할 게시물을 선택 해 주세요.");
		return false;
	}else{
		if(confirm("선택한 게시물을 삭제하시겠습니까?")){
			frm.mode.value="delete";
			frm.action = "/_mngr_/module/${menuCode}_multiDelete_newsletter.do";
			frm.submit();
		}
	}

}

</script>


<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
			<form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;">
				<input type="hidden" name="mode" value="" />
				<div class="row margin-bottom">
					<div class="col-sm-8 form-inline">
						<label for="schFld" class="sr-only">검색조건</label>
						<select name="schFld" id="schFld" class="form-control input-sm">
								<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
								<option value="1" ${ufn:selected(searchVO.schFld, '1') }>제목</option>
								<option value="1" ${ufn:selected(searchVO.schFld, '2') }>내용</option>
							</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>
					<div class="col-sm-4 text-right">
						<!-- <button type="button" onclick="fn_getExcel();" class="btn btn-default"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button> -->
						<button type="button" onclick="fn_goRegist();" class="btn btn-primary">등록</button>
						<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:5%">
								<col style="width:5%">
								<col style="width:15%">
								<col style="">
                         	   	<col style="width:10%">
								<col style="width:5%">
								<col style="width:10%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th>기사 제목 </th>
									<th>조회수 </th>
									<th scope="col">담당자</th>
									<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="작성일" fieldValue="regdt" /></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<c:set var="lpadding" value="8" />
									<c:set var="rowspan_cnt" value="0" />
									<c:choose>
										<c:when test="${result.nlArCnt eq 0}">
											<tr>
												<td class="tac" ><input type="checkbox" name="chkId" value="<c:out value="${result.nlIdx }" />" title="선택" /></td>
												<td class="tac" ><c:out value="${listNo -(status.count-1) }" /></td>
												<td class="bg_title" style="padding-left: ${lpadding}px;"><a href="#none" onclick="fn_goView('<c:out value="${result.nlIdx }" />')"><c:out value="${result.nlTitle }" /></a></td>
												<td></td>
												<td></td>
												<td class="bg_writer tac"><c:out value="${result.nlCharger }" /></td>
												<td class="bg_regdt tac">
															<fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd" value="${result.regdt}"/>
															<fmt:formatDate pattern="yyyy-MM-dd" value="${dateFmt}"/></td>
											</tr>
										</c:when>
										<c:otherwise>
												<c:forEach var="resultArticle" items="${resultArticleList}" varStatus="status1">
													<c:if test="${result.nlIdx eq resultArticle.nlIdx }">
														<c:choose>
															<c:when test="${ rowspan_cnt eq 0 }">
																<tr>
																	<td rowspan="${result.nlArCnt }" class="tac" ><input type="checkbox" name="chkId" value="<c:out value="${result.nlIdx }" />" title="선택" /></td>
																	<td rowspan="${result.nlArCnt }" class="tac" ><c:out value="${listNo -(status.count-1) }" /></td>
																	<td rowspan="${result.nlArCnt }" class="bg_title tac" style="padding-left: ${lpadding}px;"><a href="#none" onclick="fn_goView('<c:out value="${result.nlIdx }" />')"><c:out value="${result.nlTitle }" /></a></td>
																	<td><c:out value="${resultArticle.nlaSubject }" /></td>
																	<td class="tac" ><c:out value="${resultArticle.nlaReadnum }" /></td>
																	<td rowspan="${result.nlArCnt }" class="bg_writer tac"><c:out value="${result.nlCharger }" /></td>
																	<td rowspan="${result.nlArCnt }" class="bg_regdt tac">
																		<fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd" value="${result.regdt}"/>
																		<fmt:formatDate pattern="yyyy-MM-dd" value="${dateFmt}"/></td>
																</tr>
																<c:set var="rowspan_cnt" value="${rowspan_cnt + 1}" />
															</c:when>
															<c:otherwise>
																	<tr>
																		<td>${resultArticle.nlaSubject }</td>
																		<td class="tac" >${resultArticle.nlaReadnum }</td>
																	</tr>
															</c:otherwise>
														</c:choose>
													</c:if>
												</c:forEach>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							<c:if test="${fn:length(resultList ) == 0}">
								<tr class="tac"><td colspan="8">데이터가 없습니다.</td></tr>
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
