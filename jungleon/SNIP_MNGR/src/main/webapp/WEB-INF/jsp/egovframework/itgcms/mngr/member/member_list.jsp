<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
	 * @파일명 : mngrMemberList.jsp
	 * @파일정보 : 회원관리 목록
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
							<input type="hidden" id="schExcel" name="schExcel" value="<c:out value="${searchVO.schExcel }" />" />
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
									<select name="schFldSub" id="schFldSub" class="form-control input-sm">
										<option value="" ${ufn:selected(searchVO.schFldSub, '') }>전체</option>
										<option value="mem_normal" ${ufn:selected(searchVO.schFldSub, 'mem_normal') }>승인</option>
										<option value="mem_cutoff" ${ufn:selected(searchVO.schFldSub, 'mem_cutoff') }>차단</option>
										<option value="mem_del" ${ufn:selected(searchVO.schFldSub, 'mem_del') }>탈퇴</option>
										<option value="mem_wait" ${ufn:selected(searchVO.schFldSub, 'mem_wait') }>대기</option>
										<option value="mem_unreceived" ${ufn:selected(searchVO.schFldSub, 'mem_unreceived') }>미승인</option>
									</select>
									<select name="schFld" id="schFld" class="form-control input-sm">
										<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
										<option value="1" ${ufn:selected(searchVO.schFld, '1') }>아이디</option>
										<option value="2" ${ufn:selected(searchVO.schFld, '2') }>이름</option>
									</select>
									<label for="schStr" class="sr-only">검색어</label>
									<input name="schStr" id="schStr" class="form-control input-sm f-wd-400" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
									<button class="btn btn-default btn-sm btn-sm-search">검색</button>
								</div>
								<div class="col-sm-4 text-right">
									<button type="button" onclick="fn_memberExcel();" class="btn btn-default"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button>
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
											<col width="150">
											<col width="150">
										</colgroup>
										<thead>
										<tr>
											<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
											<th scope="col">번호</th>
											<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="아이디" fieldValue="id" /></th>
											<th scope="col">이메일</th>
											<th scope="col">이름</th>
											<th scope="col">성별</th>
											<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="회원상태" fieldValue="status" /></th>
											<th scope="col"><orderby:setOrderBy schOrderFld="${searchVO.ordFld }" schOrderBy="${searchVO.ordBy }" fieldText="등록일" fieldValue="regdt" /></th>
										</tr>
										</thead>
										<tbody>
										<c:forEach var="result" items="${resultList}" varStatus="status">
											<tr>
												<td class="tac"><input type="checkbox" name="chkId" value="<c:out value="${result.id }" />" title="선택" onclick="ItgJs.fn_check($(this).attr('name'), $('#chkAll').attr('id'));" /></td>
												<td class="tac"><c:out value="${listNo - (status.count - 1) }" /></td>
												<td class="tb_left bg_id"><a href="#none" onclick="fn_goView('<c:out value="${result.id }" />'); return false;"><c:out value="${result.id}" /></a></td>
												<%-- <td class="tb_left bg_id tac"><a href="javascript:fn_showAccessPass('<c:out value="${result.id}" />');"><c:out value="${result.id}" /></a></td> --%>
												<td class="bg_name tac"><c:out value="${ufn:isNull(result.email, '(내용없음)')}" /></td>
												<td class="bg_nickname tac"><c:out value="${ufn:isNull(result.name, '(내용없음)')}" /></td>
												<td class="tac"><c:out value="${ufn:deCode(result.sex,'M,남,F,여','')}" /></td>
												<td class="bg_status tac">
													<c:choose>
														<c:when test="${fn:trim(result.status) == 'mem_normal'}">
															승인
														</c:when>
														<c:when test="${fn:trim(result.status) == 'mem_cutoff'}">
															차단
														</c:when>
														<c:when test="${fn:trim(result.status) == 'mem_del'}">
															탈퇴
														</c:when>
														<c:when test="${fn:trim(result.status) == 'mem_wait'}">
															대기
														</c:when>
														<c:when test="${fn:trim(result.status) == 'mem_unreceived'}">
															미승인
														</c:when>
													</c:choose>
												</td>
												<td class="bg_regdt tac"><c:out value="${fn:substring(result.regDt, 0, 10) }" /></td>
											</tr>
										</c:forEach>
										<c:if test="${fn:length(resultList ) == 0}">
											<tr><td colspan="8" style="text-align: center">데이터가 없습니다.</td></tr>
										</c:if>
										</tbody>
									</table>
								</div> <!-- .col-sm-12 -->
							</div> <!--  .row -->
							<div class ="row">
								<div class="col-sm-5 text-left">
									<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">일반회원 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /> 명, 페이지 : <fmt:formatNumber value="${paginationInfo.currentPageNo}" type="number" /> / <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
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
<div class="modal" id="typeForAccess">
	<div class="modal-dialog mngrMemberList" style="width: 500px;">
		<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="fn_closeAccessPass()"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">관리자 비밀번호 확인</h4>
		</div>
		<div class="modal-body">
			<form id="acForm" name="acForm" method="post">
				<table id="example1" class="table table-bordered">
					<tbody id="modalLoginLogListTbody">
						<tr>
							<td>
								<input type="text" id="userId" style="display:none;" />
								<input class="form-control" type="password" name="bfView" id="bfView" placeholder="비밀번호 입력"/>
							</td>
						</tr>
						<tr>
							<td>
								<textarea class="form-control" name="reason" rows="2" cols="10" style="width: 100%; resize:none;" placeholder="개인정보를 확인해야하는 사유를 적어주세요."></textarea>
								<p class="help-block" style="margin-bottom: 0;">사용자 개인정보 보호를 위해 관리자 비밀번호를 입력해주세요</p>
							</td>
						</tr>
					</tbody>
				</table>
				<div style="margin-top: 15px;">
					<input type="button" onclick="accessCheck()" class="btn btn-primary btn-block" value="조 회" id="accessButton"/>
				</div>
			</form>
		</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
 <script type="text/javascript">
	//<[[!CDATA[
	$(document).ready(function() {
		$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
	});

	var queryString = "${searchVO.query}";

	/* 글 등록 화면 function */
	function fn_goRegist() {
		location.href = "member_input.do";
	}

	/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo) {
		location.href = "?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
	}

	function fn_orderby(fld, orderby) {
		var tmpQuery = queryString;
		var f = document.listForm;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordFld", fld);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordBy", orderby);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFldSub", f.schFldSub.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

		location.href = "?" + tmpQuery;
	}

	function fn_search() {
		var tmpQuery = queryString;
		var f = document.listForm;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFldSub", f.schFldSub.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

		location.href = "?" + tmpQuery;
	}

	function fn_chkDel() {
		if ($("input[name='chkId']:checked").size() == 0) {
			alert("삭제할 회원을 선택 해 주세요.");
			return false;
		}
		else {
			if (confirm("선택한 회원을 삭제하시겠습니까?")) {
				document.listForm.action = "member_delete_chkProc.do";
				document.listForm.submit();
			}
		}
	}

	function fn_memberExcel() {
		document.listForm.action = "mngrMemberExcelDown.do";
		document.listForm.submit();
	}

	function fn_showAccessPass(id){
		$("#userId").val(id);
		$('#typeForAccess').show();
		$("#bfView").focus();
	}

	/* 템플릿 미리보기 화면 function */
	function fn_closeAccessPass() {
		$("#typeForAccess").hide();
		var html = "";
		$('#accessButton').html("");
		$('#schStr').removeAttr("disabled");
	}

	/* 글 수정 화면 function */
	function fn_goView(id) {
		document.acForm.action = "member_edit.do?" + ItgJs.fn_replaceQueryString(queryString, "id", id);
		document.acForm.submit();
	}

	function fn_chkPassBfView(chkPw,mngrId, id){
		$.ajax({
			url:"/common/member/comm_chk_pass.ajax"
			, data : {
				chkPw : chkPw, mngrId : mngrId
			}
			, type : "post"
			, dataType : "json"
			, async : "false"
			, success : function(data){
				if (data) {
					fn_goView(id);
				} else {
					alert("비밀번호가 일치하지 않습니다.");
				}
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}

	function accessCheck() {
		var mngrId = "${mngrSessionVO.id}";
		fn_chkPassBfView($("#bfView").val(), mngrId, $("#userId").val());
	}
	//]]>
</script>