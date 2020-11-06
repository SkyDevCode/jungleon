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
 * @파일명 : user_custom_list.jsp
 * @파일정보 : 통합게시판 기본형 스킨
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
<script type="text/javascript">
//<[[!CDATA[
	$(document).ready(function(){
		var count = 0;
		$('th').each(function(){
			if ( $(this).css('display') == 'none'){
			}else{
				count++;
			}
			$('#noData').attr('colspan',count);
		});
	})

	var queryString = "${searchVO.query}";

	/* 글 조회 화면 function */
	function fn_goView(id, notice) {
		var tmpQuery = queryString;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "id", id);

		if (notice) {
			tmpQuery += "&notice="+notice;
		}

		//location.href="/user/board/${menuCode}_view_${bcid}.do?" + tmpQuery;
		location.href="?" + tmpQuery;
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
<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schBdcode", $("#schBdcode").val()  );
</c:if>
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

		location.href="?" + tmpQuery;
	}

	function fn_viewcount(){
		var tmpQuery = queryString;
		var f = document.listForm;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

		location.href="?" + tmpQuery;
	}

<c:if test="${boardAuthVO.regist == true}">
	/* 글 등록 화면 function */
	function fn_goRegist() {
		//location.href="/user/board/${menuCode}_input_${bcid}.do?schM=regist";
		location.href="?schM=input";
	}
</c:if>

<c:if test="${boardconfigVO.bcRSS eq 'Y'}">
	function getRSS(){
		window.open("./rss/${menuVO.menuCode}.do");
	}
</c:if>
//]]>
</script>

<div class="boardTop">
	<div class = "topInfo">${boardconfigVO.bcTopinfo}</div>
	<form name="listForm" method="post" onsubmit="fn_search(); return false;">
		<fieldset>
			<legend>게시판 검색폼</legend>
			<div class="l">
<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
				<label for="schBdcode" class="blind">검색구분</label>
				<ora:selectCodeList selectName="schBdcode" selectedValue="${searchVO.schBdcode }" codeList="${codeList }" selectTitle="구분" className="select_box100"/>
</c:if>
				<label for="schFld" class="blind">검색조건</label>
				<select name="schFld" id="schFld" class="select_box100" title="검색어 조건선택">
					<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
					<option value="1" ${ufn:selected(searchVO.schFld, '1') }>제목</option>
					<option value="2" ${ufn:selected(searchVO.schFld, '2') }>작성자</option>
					<option value="3" ${ufn:selected(searchVO.schFld, '3') }>내용</option>
				</select>

				<label for="schStr" class="blind">검색어</label>
				<input type="text" name="schStr" id="schStr" class="searchTxt" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력" placeholder="검색어를 입력해주세요" />
				<button type="submit" class="search">검색</button>
			</div>
			<div class="r">
				<span  class="pageTotal">총 게시물 수 <strong id="totalArticles">${paginationInfo.totalRecordCount}</strong> / 총 페이지 수 <strong id="totalPages">${paginationInfo.totalPageCount}</strong></span>
				<select name="viewCount" id="viewCount" title="목록 갯수" onchange="fn_viewcount();">
					<option value="${boardconfigVO.bcViewcount *1}" ${ufn:selected(searchVO.viewCount, boardconfigVO.bcViewcount *1) }>${boardconfigVO.bcViewcount *1}</option>
					<option value="${boardconfigVO.bcViewcount *3}" ${ufn:selected(searchVO.viewCount, boardconfigVO.bcViewcount *3) }>${boardconfigVO.bcViewcount *3}</option>
					<option value="${boardconfigVO.bcViewcount *5}" ${ufn:selected(searchVO.viewCount, boardconfigVO.bcViewcount *5) }>${boardconfigVO.bcViewcount *5}</option>
					<option value="${boardconfigVO.bcViewcount*10}" ${ufn:selected(searchVO.viewCount, boardconfigVO.bcViewcount*10) }>${boardconfigVO.bcViewcount*10}</option>
				</select>
			</div>
		</fieldset>
	</form>
</div>
<div class="boardBox">
	<table class="board tb01">
		<caption><c:out value="${boardconfigVO.bcName }" /> 게시판 리스트</caption>
		<colgroup>
<c:set var="colspan" value="5" />
			<col class="n_mobile" style="width: 50px;"/>
<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }"><c:set var="colspan" value="${colspan + 1 }" />
			<col class="n_mobile" style="width: 100px;"/><%-- 구분 --%>
</c:if>
			<col style="width:auto;"/>
<c:if test="${boardconfigVO.bcFileyn eq  'Y' }"><c:set var="colspan" value="${colspan + 1 }" />
			<col class="n_mobile" style="width: 80px;"/>
</c:if>
			<col class="n_mobile" style="width: 100px;"/>
			<col class="n_mobile" style="width: 110px;"/>
			<col class="n_mobile" style="width: 80px;"/>
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="n_mobile">번호</th>
<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
				<th scope="col" class="n_mobile">구분</th>
</c:if>
				<th scope="col">제목</th>
<c:if test="${boardconfigVO.bcFileyn eq  'Y' }">
				<th class="n_mobile" scope="col">첨부</th>
</c:if>
				<th scope="col" class="n_mobile">작성자</th>
				<th scope="col" class="n_mobile">작성일</th>
				<th scope="col" class="n_mobile">조회수</th>
			</tr>
		</thead>
		<tbody>
			<!-- 공지사항 출력 -->
			<c:forEach var="result" items="${noticeList}" varStatus="status">
			<c:set var="lpadding" value="0" />
			<c:if test="${boardconfigVO.bcReplyyn eq 'Y'}">
				<c:set var="lpadding" value="${result.bdRelevel * 10 }" />
			</c:if>
			<tr style='background-color:#fafafa;font-weight:bold;' class="noti">
				<td class="n_mobile"><strong>공지</strong></td>
<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
				<td class="n_mobile"><c:out value="${result.bdCodeName }" /></td>
</c:if>
				<td class="subj">
					<a href="#none" onclick="fn_goView('<c:out value="${result.bdIdx}" />', '<c:out value="${result.bcId}" />')">
						<c:out value="${result.bdTitle }" />
					</a>
				</td>
<c:if test="${boardconfigVO.bcFileyn eq  'Y' }">
				<td class="n_mobile">
					<c:if test="${result.fileCnt > 0 }">
					<img src="/resource/common/img/common/iconFile.png" alt="첨부된 파일이 있습니다."/>
					</c:if>
				</td>
</c:if>
				<td class="n_mobile"><c:out value="${result.bdWriter }" /></td>
				<td class="n_mobile"><c:out value="${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd')}" /></td>
				<td class="n_mobile"><fmt:formatNumber value="${result.bdReadnum }" /></td>
			</tr>
			</c:forEach>
			<!-- 공지사항 출력 end -->

			<!-- 게시글 출력 -->
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="lpadding" value="0" />
			<c:if test="${boardconfigVO.bcReplyyn eq 'Y'}">
				<c:set var="lpadding" value="${result.bdRelevel * 10 }" />
			</c:if>
			<tr>
				<td class="n_mobile"><c:out value="${listNo -(status.count-1) }" /></td>
<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
				<td class="n_mobile"><c:out value="${result.bdCodeName }" /></td>
</c:if>
				<td class="subj">
					<a href="#none" onclick="fn_goView('<c:out value="${result.bdIdx}" />')">
					<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
					<span class="v_mobile code">[<c:out value="${result.bdCodeName }"/>]</span>
					</c:if>
					<span class="title"><c:out value="${result.bdTitle }" /></span>
					<span class="v_mobile writer"><c:out value="${result.bdWriter }" /></span>
					<span class="v_mobile date"><c:out value="${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd')}" /></span>
					</a>
					<c:if test="${result.bdSecret eq 'Y' }"><img src="/resource/common/img/common/lock.png" alt="잠금"/></c:if>
				</td>
<c:if test="${boardconfigVO.bcFileyn eq  'Y' }">
				<td class="n_mobile">
				<c:if test="${result.fileCnt > 0 }">
					<img src="/resource/common/img/common/iconFile.png" alt="첨부된 파일이 있습니다."/>
				</c:if>
				</td>
</c:if>
				<td class="n_mobile"><c:out value="${result.bdWriter }" /></td>
				<td class="n_mobile"><c:out value="${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd')}" /></td>
				<td class="n_mobile"><fmt:formatNumber value="${result.bdReadnum }" /></td>
			</tr>
		</c:forEach>
		<!-- 게시글 출력 end -->
		<c:if test="${fn:length(resultList ) == 0}">
			<tr><td id="noData" colspan="${colspan }" style="text-align: center;">등록 된 데이터가 없습니다.</td></tr>
		</c:if>
		</tbody>
	</table>
</div>
<div class="boardBtnBox">
	<ul class="list_btn">
	<c:if test="${boardAuthVO.regist == true}">
		<li class="regist"><a href="#none" onclick="fn_goRegist(); return false;">글쓰기</a></li>
	</c:if>
	<c:if test="${boardconfigVO.bcRSS eq 'Y'}">
		<li class="rss"><a href="#none" onclick="getRSS(); return false;">RSS</a></li>
	</c:if>
	</ul>
</div>
<!-- paginate -->
<%@ include file="/WEB-INF/jsp/egovframework/comm/pagination/comm_pagination_include.jsp" %>
<!-- //paginate -->