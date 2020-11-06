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
 * @파일명 : mngrBoardconfigList.jsp
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
							<option value="2" ${ufn:selected(searchVO.schFld, '2') }>제목</option>
							<option value="3" ${ufn:selected(searchVO.schFld, '3') }>작성자</option>
							<option value="4" ${ufn:selected(searchVO.schFld, '4') }>내용</option>
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
             	<table id="example1" class="table table-bordered">
	              	<colgroup>
	              		<col style="width:50px;">
	              		<col style="width:60px;">
	              		<col style="width: 100px;">
	              		<col>
	              		<col style="width:150px;">
	              		<col style="width:150px;">
	              	</colgroup>
                	<thead>
						<tr>
							<th scope="col" ><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'nos');" /></th>
							<th scope="col" >번호</th>
							<th scope="col" >ID</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
						</tr>
					</thead>
                	<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="tac"><input type="checkbox" name="nos" value="<c:out value="${result.no}" />" title="선택" /></td>
							<td class="tb_left bg_id tac"><c:out value="${listNo -(status.count-1) }" /></td>
							<td class="tac"><c:out value="${result.no}" /></td>
							<td class="bg_name"><a href="#none" onclick="fn_goView('<c:out value="${result.no}" />'); return false;"><c:out value="${result.title}" /></a></td>
							<td class="tac"><c:out value="${result.regMemId}" /></td>
							<td class="tac"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${result.regDt}" /></td>
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
var queryString = "${searchVO.query}";

function fn_goView(no) {
	location.href="/_mngr_/contract/contract_view.do?" + ItgJs.fn_replaceQueryString(queryString, "no", no);
}

function fn_goRegist() {
   	location.href="/_mngr_/contract/contract_input.do?"+ queryString;
}

function fn_egov_link_page(pageNo){
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
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
	var checked = $("input[name='nos']:checked");
	var str = "";
	if (checked.size()==0 ){
		alert("삭제할 약관을 선택하세요");
		return false;
	} else {
		checked.each(function(){
			str += $(this).val()+",";
		});
		location.href="/_mngr_/contract/contract_delete_proc.do?" + queryString+"&nos="+str;
	}
}

</script>
