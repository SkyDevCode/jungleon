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
 * @파일명 : mnauthindividual_list.jsp
 * @파일정보 : 관리자관리 목록
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2018. 12. 14. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<div class="row">
	<div class="col-xs-12">
    	<div class="box">
        	<div class="box-header with-border">
				<div class="row">
					<div class="col-md-6 form-group">
						<select class="form-control select2" style="width: 100%;" name="schSiteCode" id="schSiteCode" onChange="fn_changeSite();">
						<c:forEach var="result" items="${siteList}" varStatus="status">
							<option ${ufn:selected(result.siteCode, schSiteCode)} value="${result.siteCode}">${result.siteName}</option>
						</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="box-body">
                <form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;">
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
								<option value="1" ${ufn:selected(searchVO.schFld, '1') }>아이디</option>
								<option value="2" ${ufn:selected(searchVO.schFld, '2') }>이름</option>
							</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm f-wd-400" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>
				</div>
                <div class="row">
                	<div class="col-sm-12">
		                  <table id="example1" class="table table-bordered">
			                  <colgroup>
			                  	<col width="60">
			                  	<col width="">
			                  	<col width="">
			                  	<col width="200">
			                  </colgroup>
		                    <thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="아이디" fieldValue="id" /></th>
									<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="이름" fieldValue="name" /></th>
									<th scope="col">그룹권한목록</th>
								</tr>
							</thead>
		                    <tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="tac"><c:out value="${listNo -(status.count-1) }" /></td>
									<td class="tb_left bg_id tac"><a href="#none" onclick="fn_goView('<c:out value="${result.mngId }" />','${ufn:IIF(result.ndvCnt>0,result.menuAuthIdx,'')}'); return false;"><c:out value="${result.mngId}" /></a></td>
									<td class="bg_name tac"><c:out value="${result.mngName }" /></td>
									<td class="tac"><a href="#none" class="btn btn-xs btn-primary" onclick="fn_showMenuAuthList('<c:out value="${result.mngId }" />');return false;">보기</a></td>
								</tr>
								</c:forEach>
								<c:if test="${fn:length(resultList ) == 0}">
									<tr><td colspan="4" class="tac">데이터가 없습니다.</td></tr>
								</c:if>
							</tbody>
						</table>
		        	</div> <!-- .col-sm-12 -->
				</div> <!--  .row -->
				<div class ="row">
                  	<div class="col-sm-5 text-left">
                  		<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">관리자 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /> 명, 페이지 : <fmt:formatNumber value="${paginationInfo.currentPageNo}" type="number" /> / <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
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

<div class="modal mngrMenuAuthMainModal" id="modalMenuAuthListContent">
		    <div class="modal-dialog" style="width: 1300px;">
		    <div class="modal-content">
		      <div class="modal-header">
		      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		      <h4 class="modal-title">소유그룹권한</h4>
		      </div>
		      <div class="modal-body">
		      	<div class="modalScr" style="">
		          <table id="example1" class="table table-bordered tac">
		              <colgroup>
		            <col width="60" />
		            <col width="" />
		            <col width="" />
		          </colgroup>
		          <thead>
		            <tr>
		              <th scope="col">NO</th>
		              <th scope="col">권한명</th>
		              <th scope="col">권한사이트</th>
		            </tr>
		          </thead>
		          <tbody id="modalMenuAuthListTbody">
		            <tr>
		              <td colspan="5" class="tac">&nbsp; </td>
		            </tr>
		          </tbody>
		          </table>
		        </div>
		      </div>
		    </div><!-- /.modal-content -->
		    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<form:form name="searchForm" id="searchForm" method="get">
	<input type="hidden" name="schMngId"/>
	<input type="hidden" name="schSiteCode"/>
	<input type="hidden" name="schMenuAuthIdx"/>
</form:form>

<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
})
var queryString = "${searchVO.queryString()}";

function fn_changeSite(){
	var frm = document.searchForm;
	frm.schSiteCode.value=$("#schSiteCode").val();
	frm.action = "mnauthindividual_list.do";
	frm.submit();
}

function fn_goMenuAuth(idx,siteCode){
	var frm = document.searchForm;
	frm.schMenuAuthIdx.value=idx;
	frm.schSiteCode.value=siteCode;
	frm.action = "mnauthgroup_edit.do";
	frm.submit();
}

/* 글 수정 화면 function */
function fn_goView(id, authIdx) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schMngId", id)
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schSiteCode", $("#schSiteCode").val());
	if(authIdx){
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schMenuAuthIdx", authIdx);
		location.href="mnauthindividual_edit.do?" + tmpQuery;
	}else{
		location.href="mnauthindividual_input.do?" + tmpQuery;
	}
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
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schSiteCode", $("#schSiteCode").val());
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
}

function fn_search(){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schSiteCode", $("#schSiteCode").val());
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
}

function fn_showMenuAuthList(id){
	$.ajax({
		url : "/_mngr_/menuauth/mnauth_comm_authlistforindiv.ajax"
		, data : "schMngId=" + id
		, dataType : "json"
		, success : function(data){
			var str = "";
      for(i = 0; i < data.result.length; i++){
        str += "<tr>";
        str += "<td>"+(i+1)+"</td>";
        str += "<td><a href='#' onclick='fn_goMenuAuth(\""+data.result[i].menuAuthIdx+"\",\""+data.result[i].menuAuthSitecode+"\")'>"+data.result[i].menuAuthName+"</a></td>";
        str += "<td>"+data.result[i].menuAuthSitename+"</td>";
        str += "</tr>";
      }
      if(data.result.length == 0){
        str = "<tr><td colspan='3' class='tac'>권한그룹 정보가 없습니다.</td></tr>";
      }

			$('#modalMenuAuthListContent').modal('show');
			$('#modalMenuAuthListTbody').html(str);
		}
	});
}

//]]>
</script>