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
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="replaceSearchStr" value="<span style='color:red'>${boardMap.schStr}</span>"/>

<%-- E: 추가 영역 --%>

<%
/**
 * @파일명 : include_web_search.jsp
 * @파일정보 : 통합검색 결과 페이지
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @YongHo 2017. 01. 20. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

					<div class="board_top total-search">
                        <form name="totSearch" method="post" onsubmit="ItgJs.fn_mainSearch('totalSearch',this); return false;">
                        <input type="hidden" name="searchCnd" value="${siteconfigVO.totalSearch}" />
          				<input type="hidden" name="siteCode" value="${siteCode}" />
          				<input type="hidden" name="detailFld"/>
          				<input type="hidden" name="detailStr"/>
          				<input type="hidden" name="detailSiteCode"/>
                            <fieldset>
                                <legend>통합 검색폼</legend>
                                <div class="inner">
                                    <label for="schStr" class="blind">검색어</label>
                                    <input type="text" class="search_txt" name="schStr" id="schStr" value="${ufn:quot(boardSearchVO.schStr) }" title="검색어 입력" placeholder="검색어를 입력해주세요">
                                    <button type="submit" class="search">검색</button>
                                </div>
                            </fieldset>
						</form>
                    </div>
                    <!-- //board_top -->
                    <div class="result-text">
                       <strong> “${boardSearchVO.schStr }”</strong>에 대한 검색결과입니다.
                    </div>
                    <c:if test="${fn:length(ctsResultList) > 0 or fn:length(bbsResultList) > 0 or fn:length(gongResultList) > 0}">
		                    <ul class="search-result__list">
		                    <c:if test="${fn:length(gongResultList) > 0}">
								<li>
		                            <p class="result-cate">사업공고 검색결과 (총 ${gongCnt}건 )</p>
		                         <c:forEach var="list" items="${gongResultList}" varStatus="status">
		                            <p class="result-site__map">
		                             <a href="https://www.snip.or.kr/SNIP/contents/Business1.do?schM=view&schId=${list.snp }">
		                            <img src="/resource/templete/cms1/src/img/common/navi_home.png" alt="home"> >성남산업진흥원>사업신청>사업공고
		                            </a>
		                            </p>
		                            <p class="text text-ellips">
										&gt; <c:if test="${indexofStr gt 10}">... </c:if><c:out value="${fn:replace(ufn:cutString(list.title, 200, '...'), boardMap.schStr, replaceSearchStr)}" escapeXml="false"/>
		                            </p>
		                         </c:forEach>
		                            <a href="javascript:searchDetail('gong','${boardSearchVO.schStr }','SNIP');" class="btn btn-more">더보기</a>
		                        </li>
		                    </c:if>
		                    <c:if test="${fn:length(ctsResultList) > 0}">
								<li>
		                            <p class="result-cate">컨텐츠 검색결과 (총 ${ctsCnt}건 )</p>
		                         <c:forEach var="list" items="${ctsResultList}" varStatus="status">
		                            <p class="result-site__map">
		                             <a href="/SNIP/contents/${list.menuCode }.do?schM=view&id=${list.mcIdx }">
		                            <img src="/resource/templete/cms1/src/img/common/navi_home.png" alt="home"> ${list.menuPfullname }>${list.menuName }
		                            </a>
		                            </p>
		                            <p class="text text-ellips">
		                            	<c:set var="antiHtmlStr" value="${ufn:getAntiHtml(list.mcContent, '')}"/>
										<c:set var="indexofStr" value="${fn:indexOf(antiHtmlStr, boardMap.schStr) - 10}"/>
										<c:set var="contents" value="${fn:substring(antiHtmlStr, indexofStr, fn:length(antiHtmlStr))}"/>
										&gt; <c:if test="${indexofStr gt 10}">... </c:if><c:out value="${fn:replace(ufn:cutString(contents, 200, '...'), boardMap.schStr, replaceSearchStr)}" escapeXml="false"/>
		                            </p>
		                         </c:forEach>
		                            <a href="javascript:searchDetail('cts','${boardSearchVO.schStr }','SNIP');" class="btn btn-more">더보기</a>
		                        </li>
		                    </c:if>
		                    <c:if test="${fn:length(bbsResultList) > 0}">
		                        <li>
		                            <p class="result-cate">게시판 검색결과 (총 ${bbsCnt}건 )</p>
		                        <c:forEach var="list" items="${bbsResultList}" varStatus="status">
		                            <p class="result-site__map">
		                            <a href="/SNIP/contents/${list.menuCode }.do?schM=view&id=${list.bdIdx }">
		                            <img src="/resource/templete/cms1/src/img/common/navi_home.png" alt="home"> ${list.menuPfullname }>${list.menuName }
		                            </a>
		                            </p>
		                            <p class="text text-ellips">
			                            <c:set var="antiHtmlStr" value="${ufn:getAntiHtml(list.bdContent, '')}"/>
										<c:set var="indexofStr" value="${fn:indexOf(antiHtmlStr, boardMap.schStr) - 10}"/>
										<c:set var="contents" value="${fn:substring(antiHtmlStr, indexofStr, fn:length(antiHtmlStr))}"/>
										&gt; <c:if test="${indexofStr gt 10}">... </c:if><c:out value="${fn:replace(ufn:cutString(contents, 200, '...'), boardMap.schStr, replaceSearchStr)}" escapeXml="false"/>
		                            </p>
		                        </c:forEach>
		                            <a href="javascript:searchDetail('bd','${boardSearchVO.schStr }','SNIP');" class="btn btn-more">더보기</a>
								</li>
							</c:if>
							</ul>
					</c:if>
					<c:if test="${fn:length(ctsResultList) == 0 and fn:length(bbsResultList) == 0 and fn:length(gongResultList) == 0} ">
					 <ul class="search-result__list">
						<li class="no-result">
							<p class="tit">검색결과 미확인</p>
							<ul>
								<li>단어의 철자가 정확한지 확인해 보세요.  </li>
								<li>한글을 영어로 혹은 영어를 한글로 입력했는지 확인해보세요. </li>
								<li>검색어의 단어 수를 줄이거나, 보다 일반적인 검색어로 다시 검색해보세요. </li>
								<li>두 단어 이상의 검색어의 경우, 띄어쓰기를 확인해 보세요. </li>
							</ul>
                        </li>
                    </ul>
                    </c:if>

<script>

function searchDetail(detailFld,detailStr,detailSiteCode){
	location.href="/${siteCode}/contents/totalSearchDetail.do?detailFld="+detailFld+"&detailStr="+encodeURIComponent(detailStr)+"&detailSiteCode="+detailSiteCode;
	/* var frm = document.totSearch;
	frm.action = "/${siteCode}/contents/totalSearchDetail.do";
	frm.detailFld.value = detailFld;
	frm.detailStr.value = detailStr;
	frm.detailSiteCode.value = detailSiteCode;
	frm.submit(); */
}

</script>

