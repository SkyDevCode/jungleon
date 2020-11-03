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
 * @파일명 : mngrManagerList.jsp
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
	<div class="col-xs-12">
		<div class="box">
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
								<option value="3" ${ufn:selected(searchVO.schFld, '3') }>부서</option>
							</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm f-wd-400" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>
					<div class="col-sm-4 text-right">
						<button type="button" onclick="fn_goRegist();" class="btn btn-primary">등록</button>
						<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
					</div>
				</div>
	                <div class="row">
	                	<div class="col-sm-12">
			                  <table id="example1" class="table table-bordered">
			                  	<colgroup>
			                  		<col width="50">
			                  		<col width="60">
			                  		<col>
			                  		<col>
			                  		<col>
			                  		<col>
			                  		<col>
			                  		<col width="150">
			                  		<col width="150">
			                  	</colgroup>
			                    <thead>
									<tr>
										<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
										<th scope="col">번호</th>
										<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="아이디" fieldValue="id" /></th>
										<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="이름" fieldValue="name" /></th>
										<th scope="col">전화번호</th>
										<th scope="col">휴대폰 번호</th>
										<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="부서명" fieldValue="group" /></th>
										<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="등록일" fieldValue="regdt" /></th>
										<th scope="col">로그인로그</th>
									</tr>
								</thead>
			                    <tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td class="tac"><input type="checkbox" name="chkId" value="<c:out value="${result.mngId }" />" title="선택" onclick="ItgJs.fn_check($(this).attr('name'), $('#chkAll').attr('id'));" /></td>
										<td class="tac"><c:out value="${listNo -(status.count-1) }" /></td>
										<td class="tb_left bg_id tac"><a href="#none" onclick="fn_goView('<c:out value="${result.mngId }" />'); return false;"><c:out value="${result.mngId}" /></a></td>
										<td class="bg_name tac"><c:out value="${result.mngName }" /></td>
										<td class="tac"><c:out value="${result.mngPhone}" /></td>
										<td class="tac"><c:out value="${ufn:seedDec256(result.mngMobile)}" /></td>
										<td class="bg_group tac"><c:out value="${result.groupCodeName}" /></td>
										<td class="bg_regdt tac"><c:out value="${fn:substring(result.regdt, 0, 10) }" /></td>
										<td class="tac"><a href="#none" class="btn btn-xs btn-primary" onclick="fn_showLogList('<c:out value="${result.mngId }" />');return false;">로그인로그</a></td>
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

      <div class="modal mngrAuthorityMainModal" id="modalLoginLogListContent">
		    <div class="modal-dialog " style="width: 1300px;">
		    <div class="modal-content">
		      <div class="modal-header">
		      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		      <h4 class="modal-title">로그인 로그</h4>
		      </div>
		      <div class="modal-body">
		      	<div class="modalScr" style="">
		          <table id="example1" class="table table-bordered tac">
		              <colgroup>
		            <col width="20%" />
		            <col width="15%" />
		            <col width="20%" />
		            <col width="20%" />
		            <col width="25%" />
		          </colgroup>
		          <thead>
		            <tr>
		              <th scope="col">날짜</th>
		              <th scope="col">접속 아이피</th>
		              <th scope="col">단말</th>
		              <th scope="col">운영체제</th>
		              <th scope="col">브라우저</th>
		            </tr>
		          </thead>
		          <tbody id="modalLoginLogListTbody">
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
<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
})
var queryString = "${searchVO.query}";

/* 글 수정 화면 function */
function fn_goView(id) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "id", id)
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "isMyInfo", "N");
	location.href="manager_edit.do?" + tmpQuery;
}

/* 글 등록 화면 function */
function fn_goRegist() {
   	location.href="manager_input.do";
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
		alert("삭제할 관리자를 선택 해 주세요.");
		return false;
	}else{
		if(confirm("선택한 관리자를 삭제하시겠습니까?")){
			document.listForm.action = "manager_delete_chkProc.do";
		   	document.listForm.submit();
		}
	}
}

function fn_showLogList(id){
	$.ajax({
		url : "/_mngr_/manager/loginLog_list.ajax"
		, data : "log_id=" + id
		, dataType : "json"
		, success : function(data){
			var str = "";
      for(i = 0; i < data.result.length; i++){
        str += "<tr>";
        str += "<td>"+data.result[i].logRegdt+"</td>";
        str += "<td>"+data.result[i].logIp+"</td>";
        str += "<td>"+data.result[i].logDevice+"</td>";
        str += "<td>"+data.result[i].logOs+"</td>";
        str += "<td>"+data.result[i].logBrowser+"</td>";
        str += "</tr>";
      }
      if(data.result.length == 0){
        str = "<tr><td colspan='5' class='tac'>로그 정보가 없습니다.</td></tr>";
      }

			$('#modalLoginLogListContent').modal('show');
			$('#modalLoginLogListTbody').html(str);
		}
	});
}

//]]>
</script>