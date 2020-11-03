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
		</c:if>