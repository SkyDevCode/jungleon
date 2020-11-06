
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
 * @파일명 : userOrganizationInfo.jsp
 * @파일정보 : 조직및 사무 조직도 페이지(사용자)
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
<div class="conwrap">
		<div class="searchEmployee">
			<span><a href="#" onclick="fn_goSearch(); return false;">직원정보검색</a></span>
		</div>
		<p class="tit_square_m">조직도</p>
		<ul class="list_cont">
			<li>조직도 설명</li>
		</ul>
	</div>

	<div class="conwrap orga">
		<!-- <img src="/resource/common_mta/img/intro/organization_01.png" alt="조직도"> -->
	</div>

	<div class="conwrap pd mb emp">

<!-- 1 column -->
<c:if test="${organChartInfo.columnCnt == 1}">
		<table class="tb02">
			<caption>부서별 담당업무</caption>
			<colgroup>
				<col style="width: 17.5%;">
				<col style="width: auto;">
			</colgroup>
			<thead>
				<tr>
					<th>${organChartInfo.columnNm1 }</th>
					<th>담당업무</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="result" items="${totResultList}" varStatus="i">
					<tr>
						<td>${result.cname}</td>
						<td><pre style="text-align:left; font-family:'Noto Sans KR', 'NanumSquare', 'barun', 'Nanum Gothic', '굴림', 'Gulim', 'sans-serif', 'Tahoma';">${result.exp1}</pre></td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
</c:if>

<!-- 2 column -->
<c:if test="${organChartInfo.columnCnt == 2}">
		<table class="tb02">
			<caption>부서별 담당업무</caption>
			<colgroup>
				<col style="width: 17.5%;">
				<col style="width: 27%;">
				<col style="width: auto;">
			</colgroup>
			<thead>
				<tr>
					<th>${organChartInfo.columnNm1 }</th>
					<th>${organChartInfo.columnNm2 }</th>
					<th>담당업무</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="result" items="${totResultList}" varStatus="i">
					<tr>
					<c:set var="list" value="${ufn:getInnerListToMap(listMap, result.ccode) }"/>
					<td rowspan="${fn:length(list)}">${result.cname}</td>
					<c:forEach var="result2" items="${list}" varStatus="j">
						<c:if test="${j.count > 1}"><tr></c:if>
						<td>${result2.cname}<br>${result2.etc1}</td>
						<td><pre style="text-align:left; font-family:'Noto Sans KR', 'NanumSquare', 'barun', 'Nanum Gothic', '굴림', 'Gulim', 'sans-serif', 'Tahoma';">${result2.exp1}</pre></td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(list) < 1}">
						<td></td>
						<td><pre style="text-align:left; font-family:'Noto Sans KR', 'NanumSquare', 'barun', 'Nanum Gothic', '굴림', 'Gulim', 'sans-serif', 'Tahoma';">${result3.exp1}</pre></td>
					</c:if>
				</c:forEach>

			</tbody>
		</table>
</c:if>

<!-- 3 column -->
<c:if test="${organChartInfo.columnCnt == 3}">
		<table class="tb02">
		<caption>부서별 담당업무</caption>
		<colgroup>
			<col style="width: 17.5%;">
			<col style="width: 27%;">
			<col style="width: 20%;">
			<col style="width: auto;">
		</colgroup>
		<thead>
			<tr>
				<th>${organChartInfo.columnNm1 }</th>
				<th>${organChartInfo.columnNm2 }</th>
				<th>${organChartInfo.columnNm3 }</th>
				<th>담당업무</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach var="result" items="${totResultList}" varStatus="i">
				<tr>
				<c:set var="list" value="${ufn:getInnerListToMap(listMap, result.ccode) }"/>
				<td rowspan="${result.rowcount}">${result.cname}</td>
				<c:forEach var="result2" items="${list}" varStatus="j">
					<c:if test="${j.count > 1}"><tr></c:if>
					<c:set var="list2" value="${ufn:getInnerListToMap(listMap, result2.ccode) }"/>
					<td rowspan="${fn:length(list2)}">${result2.cname}<br>${result2.etc1}</td>
					<c:forEach var="result3" items="${list2}" varStatus="k">
						<c:if test="${k.count > 1}"><tr></c:if>
						<td>${result3.cname}<br>${result3.etc1}</td>
						<td><pre style="text-align:left; font-family:'Noto Sans KR', 'NanumSquare', 'barun', 'Nanum Gothic', '굴림', 'Gulim', 'sans-serif', 'Tahoma';">${result3.exp1}</pre></td>
					</c:forEach>
					<c:if test="${fn:length(list2) < 1}">
						<td></td>
						<td><pre style="text-align:left; font-family:'Noto Sans KR', 'NanumSquare', 'barun', 'Nanum Gothic', '굴림', 'Gulim', 'sans-serif', 'Tahoma';">${result3.exp1}</pre></td>
					</c:if>
				</c:forEach>
				</tr>
			</c:forEach>

		</tbody>
	</table>
</c:if>

	</div>
	<!-- //conwrap -->

<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){

})
var queryString = "${searchVO.queryString()}";


/* 직원정보검색 페이지 이동 */
function fn_goSearch() {
		 location.href="?schM=searchView"
}


//]]>
</script>