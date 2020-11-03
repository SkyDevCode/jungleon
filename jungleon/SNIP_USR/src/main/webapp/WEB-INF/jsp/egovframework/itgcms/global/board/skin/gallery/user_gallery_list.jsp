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
 * @파일명 : user_gallery_list.jsp
 * @파일정보 : 갤러리형 게시판
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @hsk1218 2020. 4. 14. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
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

function charCheck(ele){
	var regExp = /[~!@\#$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}]/gi;
	if(regExp.test($(ele).val())){
		alert("특수문자는 입력하실 수 없습니다.");
		$(ele).val($(ele).val().substring(0, $(ele).val().length - 1)); //특수문자를 지우는 구문
	}
}
//]]>
</script>

<!-- 게시판리스트 -->
<!-- board_top -->
<div class="board_top">
    <form name="listForm" method="post" onsubmit="fn_search(); return false;">
        <fieldset>
            <legend>게시판 검색폼</legend>
            <div class="inner">
				<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
	                <label for="schBdcode" class="blind">검색구분</label>
	                <ora:selectCodeList selectName="schBdcode" selectedValue="${searchVO.schBdcode }" codeList="${codeList }" selectTitle="구분" className="select_box"/>
				</c:if>
                <label for="schFld" class="blind">검색조건</label>
                <select name="schFld" id="schFld" class="select_box" title="검색어 조건선택">
	                  <option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
				      <option value="1" ${ufn:selected(searchVO.schFld, '1') }>제목</option>
				      <option value="2" ${ufn:selected(searchVO.schFld, '2') }>담당자</option>
				      <option value="3" ${ufn:selected(searchVO.schFld, '3') }>내용</option>
                </select>
                <label for="schStr2" class="blind">검색어</label>
                <input type="text" name="schStr" id="schStr2" class="search_txt"  value="<c:out value="${searchVO.schStr }" escapeXml="false" />" onkeyup="charCheck(this);" onkeydown="charCheck(this);"  title="검색어 입력" placeholder="검색어를 입력해주세요">
                <button type="submit" class="search"><span class="ir-text">검색</span></button>
            </div>
        </fieldset>
    </form>
</div>
<!-- //board_top -->
<div class="total_list_number">
    전체게시글 <strong>${paginationInfo.totalRecordCount}</strong>개
</div>

<div class="board_box">
    <ul class="gallery_type">
	    <c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="last" value="" />
			<c:if test="${status.count % 4 eq 0 }">
				<c:set var="last" value="class='last'"/>
			</c:if>
	        <li>
	        	<a href="#none" onclick="fn_goView('<c:out value="${result.bdIdx }" />')">
		            <span class="thumb" style="display:block;">
		            	<c:set var="file" value="${result.bdThumb1 }" />
						<c:set var="alt" value="${result.bdTitle }" />
						<c:choose>
							<c:when test="${fn:contains(file,'WEBROOT_NEW')}">
								<img src="<c:url value="/comm/viewImage2.do?f=${ufn:getDownloadLink('','gallery',file,'thumb') }" />" class="img" alt="">
							</c:when>
							<c:otherwise>
						        <img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','gallery',file,'thumb') }" />" class="img" alt="">
							</c:otherwise>
						</c:choose>
		            </span>
		           	<span class="gallery_link">
			            <p class="subj">${result.bdTitle }<c:if test="${result.newYn eq 'Y' }"><img src="/resource/templete/cms1/src/img/common/icon_new.png" alt="새 글" style="margin-left: 10px;width: 20px;"/></c:if></p>

			            <div class="infor">
			                <p><c:out value="${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd')}" />&nbsp;&nbsp;  <span class="read">&nbsp;&nbsp; 조회수 : <c:out value="${result.bdReadnum }" /></span></p>
			            </div>
			            <span class="btn-more">
		           			<img src="${ctx}/resource/templete/cms1/src/img/sub/btn_more.png" alt="더보기">
		           		</span>
		           	</span>
	           	</a>
	        </li>
        </c:forEach>
    </ul>
</div>

<!-- paginate -->
<%@ include file="/WEB-INF/jsp/egovframework/comm/pagination/comm_pagination_include.jsp" %>
<!-- //paginate -->



