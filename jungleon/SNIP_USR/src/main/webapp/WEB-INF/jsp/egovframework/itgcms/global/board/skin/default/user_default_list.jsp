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
 * @파일명 : user_default_list.jsp
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
			//tmpQuery += "&notice="+notice;
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
                <label for="schStr1" class="blind">검색어</label>
                <input type="text" name="schStr" id="schStr2" class="search_txt"  value="<c:out value="${searchVO.schStr }" escapeXml="false" />" onkeyup="charCheck(this);" onkeydown="charCheck(this);" title="검색어 입력" placeholder="검색어를 입력해주세요">
                <button type="submit" class="search"><span class="ir-text">검색</span></button>
            </div>
        </fieldset>
    </form>
</div>
<!-- //board_top -->
<div class="total_list_number">
    전체게시글 <strong>${paginationInfo.totalRecordCount}</strong>개
</div>



<!-- board-list -->
<div class="board-list_wrap">
    <table class="board-list">
        <caption>
            <p class="ir-text">번호,제목,첨부,담당자,작성일,조회수로 구성된 <c:out value="${boardconfigVO.bcName }" /> 게시판 리스트</p>
        </caption>
            <colgroup class="n_mobile">
                <col class="col1">
                <c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
					<col2>
				</c:if>
				<col class="col3">
				<c:if test="${boardconfigVO.bcFileyn eq  'Y' }"><c:set var="colspan" value="${colspan + 1 }" />
                	<col class="col4">
				</c:if>
                <col class="col5">
                <col class="col6">
                <col class="col7">
            </colgroup>
        <thead>
         <tr>
             	<th scope="col">번호</th>
             	<c:set var="colspan" value="7" />
				<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
					<c:set var="colspan" value="${colspan + 1 }" />
					<th scope="col">분류</th>
				</c:if>
           		<th scope="col">제목</th>
				<c:if test="${boardconfigVO.bcFileyn eq  'Y' }">
           	  		<th scope="col">첨부</th>
				</c:if>
          		<th scope="col">담당자</th>
          		<th scope="col">작성일</th>
          		<th scope="col">조회수</th>
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
	  				<td class="num"><strong style="color: #ffa024;">공지</strong></td>
					<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
	  					<td class="n_mobile"></td>
					</c:if>
	  				<td class="subject">
	      				<a href="#none" onclick="fn_goView('<c:out value="${result.bdIdx}" />', '<c:out value="${result.bcId}" />')">
	          			<strong style="color: #ffa024;" class="v_mobile">공지</strong> <c:out value="${result.bdTitle }" />
	      				</a>
	  				</td>
					<c:if test="${boardconfigVO.bcFileyn eq  'Y' }">
	  					<td class="file">
	      				<c:if test="${result.fileCnt > 0 }">
	      					<img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/src/img/common/icon_down.png" alt="첨부된 파일이 있습니다."/>
	      				</c:if>
	  					</td>
					</c:if>
	  				<td class="writer"><c:out value="${result.bdWriter }" /></td>
	  				<td class="data"><c:out value="${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd')}" /></td>
	  				<td class="hit"><fmt:formatNumber value="${result.bdReadnum }" /></td>
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
    				<td class="num"><c:out value="${listNo -(status.count-1) }" /></td>
					<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
    					<td class="num"><c:out value="${result.bdCodeName }" /></td>
					</c:if>
    				<td class="subject">
        				<a href="#none" onclick="fn_goView('<c:out value="${result.bdIdx}" />')">
       					<c:choose>
							<c:when test="${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd')>'2020-06-14'}">
								 <c:out value="${result.bdTitle }" />
							</c:when>
							<c:otherwise>
								  <c:out value="${result.bdTitle }" escapeXml="false"/>
							</c:otherwise>
						</c:choose>
        				</a>
        				<c:if test="${result.newYn eq 'Y' }"><img src="/resource/templete/cms1/src/img/common/icon_new.png" alt="새 글"/></c:if>
        				<c:if test="${result.bdSecret eq 'Y' }"><img src="/resource/common/img/common/lock.png" alt="잠금"/></c:if>
    				</td>
					<c:if test="${boardconfigVO.bcFileyn eq  'Y' }">
    					<td class="file">
    					<c:if test="${result.fileCnt > 0 }">
        					<img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/src/img/common/icon_down.png" alt="첨부된 파일이 있습니다."/>
    					</c:if>
    					</td>
					</c:if>
    				<td class="writer"><c:out value="${result.charger }" /></td>
				    <td class="data"><c:out value="${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd')}" /></td>
				    <td class="hit"><fmt:formatNumber value="${result.bdReadnum }" /></td>
				</tr>
			</c:forEach>
			<!-- 게시글 출력 end -->
			<c:if test="${fn:length(resultList ) == 0}">
				<tr><td id="noData" colspan="${colspan }" style="text-align: center;">등록된 데이터가 없습니다.</td></tr>
			</c:if>
        </tbody>
    </table>
</div>
<!-- //board-list -->

<!-- paginate -->
<%@ include file="/WEB-INF/jsp/egovframework/comm/pagination/comm_pagination_include.jsp" %>
<!-- //paginate -->
<!-- //게시판리스트 -->
