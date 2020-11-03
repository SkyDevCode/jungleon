<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>

<script type="text/javascript">
//<![CDATA[

    var queryString = "${searchVO.query}";

	function fn_search(){
		var tmpQuery = queryString;
		var f = document.listForm;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");
		location.href="?" + tmpQuery;
	}

	function fn_egov_link_page(pageNo){
		location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
	}

	function fn_goRevision (revisionNo) {
		// location.href="/_mngr_/mngrContents/${menuCode}.do?revision="+revisionNo+"&"+ItgJs.fn_replaceQueryString(queryString, "id", "");
		location.href="/_mngr_/contents/${menuCode}_view.do?revision="+revisionNo;
	}

	function fn_chkDel(){
		var totCnt = ${totCnt};
		if($("input[name=chkId]:checked").size() == 0){
			alert("삭제할 게시물을 선택 해 주세요.");
			return false;
		}else{
			if(totCnt > 1){
				var frm = document.listForm;
				frm.action="/_mngr_/contents/${menuCode}_delete_revision_proc.do";
				frm.submit();
			}else{
				alert("리비전은 2개 이상일 경우 삭제가능합니다.");
				return false;
			}
		}
	}

	//]]>
</script>

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
				<form name="listForm" method="post" id="listForm" onsubmit="fn_search(); return false;">
					<input type="hidden" name="menuCode" value="${menuCode}"/>
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
								<option value="0" <c:out value="${searchVO.schFld eq '0' ? 'selected' : '' }" />>전체</option>
								<option value="1" <c:out value="${searchVO.schFld eq '1' ? 'selected' : '' }" />>내용</option>
								<option value="2" <c:out value="${searchVO.schFld eq '2' ? 'selected' : '' }" />>작성자</option>
							</select>
							<label for="schStr" class="sr-only">검색어</label>
							<input name="schStr" id="schStr"  class="form-control input-sm" value="${searchVO.schStr}" title="검색어 입력"/>
							<input type="hidden" name="pageType" value="${pageType}"/>
							<button class="btn btn-default btn-sm">검색</button>
						</div>
						<div class="col-sm-4 text-right">
							<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
						</div>
					</div>
					<div>
						<table id="example1" class="table table-bordered">
							<colgroup>
								<col style="width:40px;">
								<col style="width:60px;">
								<col style="width:175px;">
								<col style="width:110px;">
								<col style="">
								<col style="width:110px;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
									<th scope="col">번호</th>
									<th scope="col">작성일</th>
									<th scope="col">구분</th>
									<th scope="col">요약</th>
									<th scope="col">작성자</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" varStatus="status" var="result">
									<tr id="revision_${result.id}">
										<td class="tac"><input type="checkbox" name="chkId" value="<c:out value="${result.id}"/>" title="선택" /></td>
										<td class="tac"><c:out value="${listNo -(status.count-1) }" /></td>
										<td class="tac"><a href="javascript:fn_goRevision('${result.id}');"><c:out value="${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd HH:mm:ss')}"/></a></td>
										<td class="tac"><c:out value="${result.delyn eq 'T' ? '임시저장' : currentNum eq result.id ? '현재 적용 중' : ''}"/></td>
										<td>	<c:out value="${ufn:cutString(result.menuMemo, 100, '...')}"/></td>
										<td class="tac">${result.regmemid}</td>
									</tr>
								</c:forEach>
								<c:if test="${fn:length(resultList ) == 0}">
									<tr><td colspan="6" class="tac">데이터가 없습니다.</td></tr>
								</c:if>
							</tbody>
						</table>
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
					</div>
				</form>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
