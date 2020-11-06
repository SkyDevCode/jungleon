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
 <c:set var="searchType" value="" />
 <c:if test="${itgMap.detailFld eq 'cts' }">
 	<c:set var="searchType" value="컨텐츠" />
</c:if>
<c:if test="${itgMap.detailFld eq 'bd' }">
	<c:set var="searchType" value="게시판" />
</c:if>
<c:if test="${itgMap.detailFld eq 'gong' }">
	<c:set var="searchType" value="사업공고" />
</c:if>
                    <div class="result-text">
                       <strong>${searchType} “${boardSearchVO.schStr }”</strong>에 대한 검색결과입니다.
                    </div>
                    <c:if test="${fn:length(list) > 0}">
		                    <ul class="search-result__list">
								<li>
		                            <p class="result-cate">${searchType} 검색결과 (총 ${totCnt}건 )</p>
		                         <c:forEach var="data" items="${list}" varStatus="status">
			                         <c:if test="${itgMap.detailFld eq 'cts' }">
										<c:set var="idx" value="${data.mcIdx }" />
										<c:set var="content" value="${data.mcContent }" />
									</c:if>
									<c:if test="${itgMap.detailFld eq 'bd' }">
										<c:set var="idx" value="${data.bdIdx }" />
										<c:set var="content" value="${data.bdContent }" />
									</c:if>
									<c:if test="${itgMap.detailFld eq 'gong' }">
										<c:set var="idx" value="${data.snp }" />
										<c:set var="content" value="${data.title }" />
									</c:if>

									<c:choose>
										<c:when test="${itgMap.detailFld eq 'gong' }">
											<p class="result-site__map">
				                            	<c:set var="strParam" value="?schM=view&schId=${idx }" />
				                            	<a href="/SNIP/contents/Business1.do${strParam}"><img src="/resource/templete/cms1/src/img/common/navi_home.png" alt="home"> >성남산업진흥원>사업신청>사업공고</a></p>
				                            <p class="text text-ellips">
				                            	&gt; <c:if test="${indexofStr gt 10}">... </c:if><c:out value="${fn:replace(ufn:cutString(content, 200, '...'), boardMap.schStr, replaceSearchStr)}" escapeXml="false"/>
				                            </p>
										</c:when>
										<c:otherwise>
											 <p class="result-site__map">
				                            	<c:set var="strParam" value="?schM=view&id=${idx }" />
				                            	<c:if test="${fn:startsWith(data.bcskin, 'startUp') }">
					                            	<c:set var="strParam" value="" />
				                            	</c:if>
				                            	<a href="/${itgMap.detailSiteCode }/contents/${data.menuCode }.do${strParam}"><img src="/resource/templete/cms1/src/img/common/navi_home.png" alt="home"> ${data.menuPfullname }>${data.menuName }</a></p>
				                            <p class="text text-ellips">
				                            	<c:set var="antiHtmlStr" value="${ufn:getAntiHtml(content, '')}"/>
												<c:set var="indexofStr" value="${fn:indexOf(antiHtmlStr, boardMap.schStr) - 10}"/>
												<c:set var="contents" value="${fn:substring(antiHtmlStr, indexofStr, fn:length(antiHtmlStr))}"/>
												&gt; <c:if test="${indexofStr gt 10}">... </c:if><c:out value="${fn:replace(ufn:cutString(contents, 200, '...'), boardMap.schStr, replaceSearchStr)}" escapeXml="false"/>
				                            </p>
										</c:otherwise>
									</c:choose>
		                         </c:forEach>
		                        </li>
							</ul>
					</c:if>
					<c:if test="${fn:length(list) == 0}">
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
                    <div class="paginate">
                        <ui:pagination paginationInfo = "${paginationInfo}" type="user" jsFunction="fn_egov_link_page" />
                    </div>


<script>

function searchDetail(detailFld,detailStr,detailSiteCode){
	var frm = document.totSearch;
	frm.action = "/${siteCode}/contents/totalSearchDetail.do";
	frm.detailFld.value = detailFld;
	frm.detailStr.value = detailStr;
	frm.detailSiteCode.value = detailSiteCode;
	frm.submit();
}
/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	var queryString = "fld=${itgMap.fld}&detailFld=${itgMap.detailFld}&detailStr=${itgMap.detailStr}&detailSiteCode=${itgMap.detailSiteCode}";
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}
</script>

					<!-- //board-list -->
<%--
			<div class="searchBox">
				<p class="tit">${introMsg }</p>
				<div class="wrapbtn">
					<form name="totSearch" method="post" onsubmit="ItgJs.fn_mainSearch('${siteconfigVO.totalSearchMenuCode}',this); return false;">
						<input type="hidden" name="searchCnd" value="${siteconfigVO.totalSearch}" />
          				<input type="hidden" name="siteCode" value="${siteCode}" />
				      	<input type="text" name="schStr" id="schStr"/><button type="submit"></button>
			      	</form>
				</div>
			</div>

			<p class="resultSearching"><strong>"${boardSearchVO.schStr }"</strong> 으로 검색하신 결과 입니다.</p>


		<c:if test="${fn:length(siteResultList) > 0}">
			<c:forEach var="site" items="${siteResultList}" begin="0" end="${fn:length(siteResultList) }" varStatus="configStat">
				<c:set var="totCnt" value="0"/>
				<div class="siteResult">
					<h3>${site.siteName}</h3>
				<c:forEach var="bc" items="${site.boardConfigList}" varStatus="status">
					<c:if test="${bc.bbsCnt ne 0}">
						<c:set var="totCnt" value="${totCnt+1}"/>
					<div class="resultWrap">
						<p class="tit"><c:out value="${bc.menuName } "/><span style="margin-left:5px">${bc.bbsCnt}건</span></p>
						<ul>
						<c:forEach var="list" items="${bc.bbsResultList}" varStatus="status">
							<li><a href="/web/contents/${bc.menuCode }.do?schM=view&amp;id=<c:out value="${list.bdIdx }" />">
							<span><c:out value="${fn:replace(list.bdTitle, boardMap.schStr, replaceSearchStr)}" escapeXml="false"/></span></a>

							<c:set var="antiHtmlStr" value="${ufn:getAntiHtml(list.bdContent, '')}"/>
							<c:set var="indexofStr" value="${fn:indexOf(antiHtmlStr, boardMap.schStr) - 10}"/>
							<c:set var="contents" value="${fn:substring(antiHtmlStr, indexofStr, fn:length(antiHtmlStr))}"/>
							&gt; <c:if test="${indexofStr gt 10}">... </c:if><c:out value="${fn:replace(ufn:cutString(contents, 200, '...'), boardMap.schStr, replaceSearchStr)}" escapeXml="false"/></li>
						</c:forEach>
						</ul>
						<div class="morebtn"><a href="/web/contents/${bc.menuCode }.do">더보기</a></div>
					</div>
					</c:if>
				</c:forEach>
				<c:if test="${totCnt eq 0}">
					<div class="resultWrap">
						<p class="tit" align="center">검색 결과가 없습니다.</p>
					</div>
				</c:if>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(siteResultList) eq 0}">
			<div class="siteResult">
				<div class="resultWrap">
					<p class="tit" align="center">검색 결과가 없습니다.</p>
				</div>
			</div>
		</c:if> --%>