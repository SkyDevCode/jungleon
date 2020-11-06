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
 * @파일명 : mngrProductList.jsp
 * @파일정보 : 관리자 성남기업소개 > 성남기업 및 상품소개 > 상품정보
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
						<label for="schFld" class="sr-only">검색조건</label>
						<select name="schFld" id="schFld" class="form-control input-sm">
								<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
								<option value="1" ${ufn:selected(searchVO.schFld, '1') }>상품명</option>
								<option value="2" ${ufn:selected(searchVO.schFld, '2') }>회사명</option>
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
						<ul class="gallery_type">
<c:forEach var="result" items="${resultList}" varStatus="status">
	<c:set var="last" value="" />
	<c:if test="${status.count % 4 eq 0 }"><c:set var="last" value="class='last'"/></c:if>
							<li ${last }>
								<div class="w">
									<div class="thumb">
										<c:set var="file" value="${result.prdImgPath01 }" />
										<c:set var="alt" value="상품 이미지" />
										<input type="checkbox" name="chkId" value="<c:out value="${result.prdNo }" />" title="선택" />
										<a href="#none" onclick="fn_goView('<c:out value="${result.prdNo }" />')">
										<c:if test="${empty result.prdImg01 }">
											<img src="<c:url value="${ctx}/resource/templete/cms1/src/img/common/defalut_sub.gif" />" alt="이미지없음" />
										</c:if>
										<c:if test="${not empty result.prdImg01 }">
											<img src="<c:url value="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',fn:substring(result.prdImgPath01,1,fn:length(result.prdImgPath01)) ,result.prdImg01 ) }" />" alt="${result.prdNm }" />
										</c:if>
									</div>
									<div class="cont">
										<p class="subj"><strong><a href="#none" onclick="fn_goView('<c:out value="${result.prdNo }" />')"><c:out value="${result.prdNm }" /></a></strong></p>
										<p class="txt"><c:out value="${result.comNm }" /></p>
										<p class="txt" style="float: left; width:50%"><c:out value="${fn:substring( result.regDt, 0, 10) }" /></p>
										<p class="txt" style="float: right;margin-right: 5px;"><c:out value="${result.hitsCnt }" /></p>
									</div>
								</div>
							</li>
</c:forEach>

<c:if test="${fn:length(resultList) eq 0 }">
							<li>등록된 데이터가 없습니다.</li>
</c:if>
						</ul>
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
			frm.action = "/_mngr_/module/${menuCode}_mngrProductMultiDeleteProc.do";
			frm.submit();
		}
	}

}

function fn_getExcel(siteCode, bcid) {
	var tmpQuery = queryString;
	if(confirm("검색된 목록을 엑셀로 저장하시겠습니까?")) {
		location.href="/_mngr_/module/${menuCode}_mngrProductListExcelDown.do?" + tmpQuery;
	}
}

//]]>
</script>