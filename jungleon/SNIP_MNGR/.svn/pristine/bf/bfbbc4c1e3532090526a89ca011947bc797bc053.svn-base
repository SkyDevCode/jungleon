
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
 * @파일명 : userStaffList.jsp
 * @파일정보 : 조직및사무 직원리스트 조회 페이지(사용자)
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

<form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;" enctype="multipart/form-data">
	<div class="conwrap mt">
		<ul class="searchEmp">
			<li><a href="javascript:void(0);" onclick="fn_goList();">전체</a></li>
		<c:forEach var="code" items="${groupList}" varStatus="status">
			<li><a href="javascript:void(0);" onclick="fn_groupChoice('${code.ccode }');">${code.cname }</a></li>
		</c:forEach>
		</ul>
	</div>
	<div class="conwrap">
		<div class="boardTop bg" style="margin-bottom: 30px;">
			<div class="l">
				<label for="schFld" class="blind">검색조건</label>
							<select name="schFld" id="schFld" class="select_box100" title="검색어 조건선택">
	    						<option value="1" ${ufn:selected(searchVO.schFld, '1') }>성명</option>
								<option value="2" ${ufn:selected(searchVO.schFld, '2') }>전화번호</option>
								<option value="3" ${ufn:selected(searchVO.schFld, '3') }>업무</option>
	    					</select>
	    					<label for="schStr" class="blind">검색어</label>
	    					<input type="text" name="schStr" id="schStr" class="searchTxt" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력" placeholder="">
	    					<button type="submit" class="search">검색</button>
	    				</div>
	     			</div>
		<!-- //boardTop -->
	</div>

	<div class="conwrap emp">
		<div class="tblScr">
			<table class="tb02" style="margin-bottom: 0;min-width: 768px;">
				<caption>직원 검색 리스트</caption>
				<colgroup>
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
				</colgroup>
				<thead>
					<tr>
						<th>성명</th>
						<th>부서</th>
						<th>직책</th>
						<th>전화번호</th>
						<th>담당업무</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${result.staffNm}" /></td>
						<td><c:out value="${result.staffDept}" /></td>
						<td><c:out value="${result.staffPos}" /></td>
						<td><c:out value="${result.telNo}" /></td>
						<td class="task"><a href="javascript:;" onclick="openPopup(${result.staffNo})">+ 담당업무보기</a></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- tableScroll -->
	</div>
</form>

	<div id="popupLayer">
		<div class="popupInner">
			<div class="popupTit">
				<span class="t">담당업무</span>
				<span class="close"><a href="javascript:;" class="layerClose"></a></span>
			</div>
			<div class="popupCont">
				<div class="scr" id="tempWorkDesc">

				</div>
			</div>
		</div>
	</div>


<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
})
var queryString = "${searchVO.queryString()}";

var obj = {
		<c:forEach var="result" items="${resultList}" varStatus="status">
		"${result.staffNo}" : "${ufn:replaceAll(result.staffWork, '\\r\\n', '<br/>')}",
		</c:forEach>
		"" : ""
};


/* 글 수정 화면 function */
function fn_goView(schId) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", schId);
}

/* 글 등록 화면 function */
function fn_goRegist() {
		 location.href="?schM=regist";
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}

/* 직원 검색 */
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

/* 부서별 리스트 조회 */
function fn_groupChoice(group){
	location.href="?schM=searchView&schOpt5="+group;
}

/* 전체 리스트 조회 */
function fn_goList() {
		location.href="?schM=searchView";
}

function openPopup(idx){
	var value = obj[idx];
	$("#tempWorkDesc").html(value);
	$(".bbg").fadeIn();
	$("#popupLayer").fadeIn();
	$("#popupLayer .popupTit > .close a").on("click",function(e){
		$("#popupLayer").fadeOut();
		$(".bbg").fadeOut();
	});
}
//]]>
</script>
