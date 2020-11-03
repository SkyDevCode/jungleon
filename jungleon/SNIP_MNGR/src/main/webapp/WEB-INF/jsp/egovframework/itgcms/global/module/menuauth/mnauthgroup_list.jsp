<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
 * @파일명 : mnauthgroup_list.jsp
 * @파일정보 : 메뉴권한리스트
 * @수정이력
 * @수정자    수정일       수정내용
 * @------- ------------ ----------------
 * @JANG  2018.11.07 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 3.0.7 Copyright (C) ITGOOD All right reserved.
 */
%>

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-header with-border">
				<div class="row">
					<div class="col-md-6 form-group">
						<select class="form-control select2" style="width: 100%;" name="schSiteCode" id="schSiteCode" onChange="fn_changeSite();">
						<c:forEach var="result" items="${siteList}" varStatus="status">
							<option ${ufn:selected(result.siteCode, mngrSiteVO.siteCode)} value="${result.siteCode}">${result.siteName}</option>
						</c:forEach>
						</select>
					</div>
				</div>
			</div>
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
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm f-wd-400" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>
					<div class="col-sm-4 text-right">
						<button type="button" onclick="fn_goRegist();" class="btn btn-primary">권한그룹등록</button>
					</div>
				</div>
				</form>
				<div class="row">
					<div class="col-sm-12">
						<table id="example1" class="table table-bordered">
							<colgroup>
								<col width="45%" />
								<col width="15%" />
								<col width="10%" />
								<col width="20%" />
								<col width="10%" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">메뉴권한명</th>
									<th scope="col">관리자</th>
									<th scope="col">등록자</th>
									<th scope="col">등록일</th>
									<th scope="col">삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td><a href="#none" onclick="fn_edit('${result.menuAuthIdx}'); return false;"><c:out value="${result.menuAuthName}" /></a></td>
									<td class="tac">
										<a href="#none" class="btn btn-xs btn-primary" onclick="fn_modalOpenManager('${result.menuAuthIdx }'); return false;">관리(<c:out value="${result.managerCount}"/>)</a>
									</td>
									<td class="tac"><c:out value="${result.regmemid}"/></td>
									<td class="tac"><fmt:formatDate value="${result.regdt}" type="date" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td class="tac"><a href="#none" class="btn btn-xs btn-warning" onclick="fn_delete('${result.menuAuthIdx}'); return false;">삭제</a></td>
								</tr>
								</c:forEach>
								<c:if test="${fn:length(resultList ) == 0}">
								<tr><td colspan="5" class="tac">데이터가 없습니다.</td></tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
				<div class ="row">
                  	<div class="col-sm-5 text-left">
                  		<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">권한그룹 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /> 개, 페이지 : <fmt:formatNumber value="${paginationInfo.currentPageNo}" type="number" /> / <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
                  	</div>
                  	<div class="col-sm-7">
                  		<div class="text-center dataTables_paginate paging_simple_numbers" id="example1_paginate">
                  			<ul class="pagination">
                  			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
                  			</ul>
                  		</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- S : 관리자추가 모달창 -->
<div class="modal mnauthgroupListModal" id="modalManagerContent">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">관리자 등록/해지</h4>
			</div>
			<div class="modal-body">
				<div class="form-inline" style="margin-bottom:30px;">
					<input name="schManagerStr" id="schManagerStr" class="form-control input-sm" title="검색어 입력" onkeydown="if(ItgJs.fn_isEnter(event)) fn_searchManager(1);" />
					<button type="button" class="btn btn-default btn-sm btn-sm-search" style="margin-right:20px;" onclick="fn_searchManager(1);">검색</button>
					<span id="searchResult"></span>

					<button type="button" class="btn btn-default" style="margin-right:20px; float:right;" onclick="fn_searchManager(1,'Y');">권한 소유 관리자</button>
					<button type="button" class="btn btn-default" style="margin-right:1px; float:right;" onclick="fn_searchManager(1,'N');">권한 미소유 관리자</button>
				</div>
				<form name="managerForm" id="managerForm" method="post" action="">
					<input type="hidden" name="menuAuthIdx" />
					<input type="hidden" name="optStr" />
					<input type="hidden" name="sysName" value="${mngrSiteVO.siteName}">

					<table class="table table-bordered">
			        	<colgroup>
							<col width="40" />
							<col/>
							<col width="20%" />
							<col width="20%" />
							<col width="100" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><input type="checkbox" name="chkall" id="chkAll" onclick="ItgJs.fn_checkAll(this, 'chkId')" title="전체선택" /></th>
								<th scope="col">이름</th>
								<th scope="col">아이디</th>
								<th scope="col">부서명</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody id="managerListTbody">
							<tr>
								<td colspan="5" class="tac">&nbsp; </td>
							</tr>
						</tbody>
					</table>
				</form>
				<div style="text-align:right;margin-top:10px; padding:10px;">
					<button type="button" id="managerListMoreBtn" class="btn btn-default" onclick="fn_searManagerMore();" style="display:none;">더보기</button>
					<button type="button" class="btn btn-primary" onclick="fn_registManagerAuthAll();">일괄권한부여</button>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<form:form name="searchForm" id="searchForm" method="get">
	<input type="hidden" name="schMenuAuthIdx"/>
	<input type="hidden" name="schSiteCode"/>
</form:form>

<script type="text/javascript">
//<![CDATA[

	var queryString = "${searchVO.queryString()}";

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
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", "1");
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schSiteCode", $("#schSiteCode").val());
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

		location.href="?" + tmpQuery;
	}

	function fn_search(){
		var tmpQuery = queryString;
		var f = document.listForm;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", "1");
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schSiteCode", $("#schSiteCode").val());
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

		location.href="?" + tmpQuery;
	}

	$("#modalManagerContent").on('hidden.bs.modal', function (e) {
		var frm = document.searchForm;
		frm.schSiteCode.value=$("#schSiteCode").val();
		frm.action = "?";
		frm.submit();
	})

	function fn_changeSite(){
		var frm = document.searchForm;
		frm.schSiteCode.value=$("#schSiteCode").val();
		frm.action = "mnauthgroup_list.do";
		frm.submit();
	}

	function fn_goRegist(){
		var frm = document.searchForm;
		frm.schSiteCode.value=$("#schSiteCode").val();
		frm.action = "mnauthgroup_input.do";
		frm.submit();
	}

	function fn_edit(menuAuthIdx){
		var frm = document.searchForm;
		frm.schSiteCode.value=$("#schSiteCode").val();
		frm.schMenuAuthIdx.value=menuAuthIdx;
		frm.action = "mnauthgroup_edit.do";
		frm.submit();
	}

	function fn_delete(idx){
		if(confirm("선택한 권한을 삭제하시겠습니까?\n해당 권한을 가진 사용자는 권한을 부여하기전까지 사용할 수 없습니다.")){
			var frm = document.searchForm;
			frm.schMenuAuthIdx.value = idx;
			frm.schSiteCode.value=$("#schSiteCode").val();
			frm.action="mnauthgroup_delete_proc.do";
			frm.submit();
		}
	}

	function fn_modalOpenManager(menuAuthIdx){
		$("#modalManagerContent").modal("show");
		if(oldModalManagerContent == "") oldModalManagerContent = $("#modalManagerContent").html();
		else $("#modalManagerContent").html(oldModalManagerContent);
		document.managerForm.menuAuthIdx.value = menuAuthIdx;
		fn_searchManager(1);
	}

	var oldModalManagerContent = "";
	var searchManagerPage = 1; //더보기용 페이지 저장
	function fn_searManagerMore(){ //더보기용 페이지 증가
		searchManagerPage++;
		fn_searchManager(searchManagerPage);
	}

	function fn_searchManager(page,hasAuth){//검색결과 조회
		searchManagerPage = page;
		var dataStr = "schSitecode=${mngrSiteVO.siteCode}&schOpt1="+document.managerForm.menuAuthIdx.value+"&schStr="+encodeURIComponent($("#schManagerStr").val())+"&page="+page;
		if(hasAuth) dataStr +="&schOpt2="+hasAuth;

		$.ajax({
			url:"/_mngr_/manager/manager_list_site.ajax",
			data : dataStr,
			dataType : "json",
			async : false,
			success : function(data){
				str = "";
				var color = (page % 2 == 0)? "#fafafa":"#fafaff";
				for(i = 0; i < data.result.length; i++){
					var disableStr="",buttonStr ="";
					if(data.result[i].managerMenuAuthIdx == "N"){
						buttonStr = "<button onclick='fn_registManagerAuth(\""+data.result[i].mngId+"\")' class='btn btn-xs btn-primary'>권한부여</button>";
					}else{
						disableStr = "disabled=true";
						buttonStr = "<button onclick='fn_deleteManagerAuth(\""+data.result[i].managerMenuAuthIdx+"\")' class='btn btn-xs btn-warning'>권한제거</button>";
					}
					str += "<tr>";
					str += "<td class='tac'><input type=\"checkbox\" name=\"chkId\" title=\"\" onclick=\"\" value=\""+data.result[i].mngId+"\" "+disableStr+"/></td>";
					str += "<td class='tac'>"+data.result[i].mngName+"</td>";
					str += "<td class='tac'>"+data.result[i].mngId+"</td>";
					str += "<td class='tac'>"+data.result[i].groupCodeName+"</td>";
					str += "<td class='tac'>"+buttonStr+"</td>";
					str += "</tr>";
				}
				//검색결과 표시
				$("#searchResult").text("검색결과 : " + data.total + " 건 " +  data.currentPage +"/"+ data.totalPage);
				if(str == ""){
					str = "<tr><td colspan='5' class='tac'>검색 결과가 없습니다.</td></tr>";
					searchManagerPage = 0;
				}
				if(parseInt(data.currentPage) < parseInt(data.totalPage)){ // 페이지 더 있으면 더보기 버튼 보여줌
					$("#managerListMoreBtn").show();
					$("#managerListMoreBtn").text(data.currentPage +"/"+ data.totalPage + " 더보기");
				}else{
					$("#managerListMoreBtn").hide();
					$("#managerListMoreBtn").text("더보기");
				}
				if(page == 1){ // 첫페이지는 지우고 출력
					$("#managerListTbody").html(str);
				}else{ // 2페이지 이상은 추가
					$("#managerListTbody").append(str);
				}
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}

	function fn_registManagerAuth(optStr){
		if(confirm("해당 관리자에게 권한을 부여 하시겠습니까?")){
			var frm = document.managerForm;
			frm.optStr.value = optStr;
			$.ajax({
				url : "mnauth_input_indvtogrp_proc.ajax"
				, data : $("#managerForm").serialize()
				, type : "post"
				, dataType : "json"
				, async : false
				, success : function(data){
					if(data.result == "1"){
						alert("적용이 완료 되었습니다.");
						fn_searchManager(1);
						return false;
					}else if(data.result == "2"){
						alert("메뉴권한 정보가 올바르지 않습니다.");
						return false;
					}else if(data.result == "3"){
						alert("관리자 정보가 올바르지 않습니다.");
						return false;
					}else{
						alert("처리중 오류가 발생했습니다. 다시 시도해 주세요");
						return false;
					}
				}
				, error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	}

	function fn_deleteManagerAuth(optStr){
		if(confirm("해당 관리자의 권한을 제거 하시겠습니까?")){
			var frm = document.managerForm;
			frm.optStr.value = optStr;
			$.ajax({
				url : "mnauth_delete_indvfromgrp_proc.ajax"
				, data : $("#managerForm").serialize()
				, type : "post"
				, dataType : "json"
				, async : false
				, success : function(data){
					if(data.result == "1"){
						alert("적용이 완료 되었습니다.");
						fn_searchManager(1);
						//location.href='?';
						return false;
					}else if(data.result == "2"){
						alert("권한 등록 정보가 올바르지 않습니다.");
						return false;
					}else{
						alert("처리중 오류가 발생했습니다. 다시 시도해 주세요");
						return false;
					}
				}
				, error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	}

	function fn_registManagerAuthAll(){
		if($("input[name=chkId]:checked:enabled").size() == 0){alert('권한을 적용할 관리자를 선택 해 주세요.\n\n이미 권한이 부여된 관리자는 선택되지 않습니다.'); return false;}
		if(confirm("선택된 관리자(들)에게 권한을 일괄 부여 하시겠습니까?")){
			var frm = document.managerForm;
			var strData = $("#managerForm").serialize();
			$.ajax({
				url : "mnauth_input_indvtogrpAll_proc.ajax"
				, data : strData
				, type : "post"
				, dataType : "json"
				, async : false
				, success : function(data){
					if(data.result == "1"){
						alert("적용이 완료 되었습니다.");
						fn_searchManager(1);
						return false;
					}else if(data.result == "2"){
						alert("권한 롤 정보가 없습니다.");
						return false;
					}else if(data.result == "3"){
						alert("권한을 적용 할 관리자를 선택 해 주세요.");
						return false;
					}else{
						alert("처리중 오류가 발생했습니다. 다시 시도해 주세요");
						return false;
					}
				}
				, error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	}
//]]>
</script>