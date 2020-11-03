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
 * @파일명 : userPrintCalendarRegist.jsp
 * @파일정보 : 사업신청 > 대관신청 > 신청화면 달력 출력
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 04. 16. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<div class="hall_select_month">
	<button  onclick="fn_getCalendarTableRegist('${prevYear}', '${ufn:getZeroPlus(prevMonth) }'); return false;"><img src="/resource/templete/cms1/src/img/sub/hall_select_prev_month.gif" alt="이전달" /></button>
	<span class="month_txt"><c:out value="${year }" />년 <c:out value="${ufn:getZeroPlus(month) }" />월</span>
	<button onclick="fn_getCalendarTableRegist('${nextYear}', '${ufn:getZeroPlus(nextMonth) }'); return false;"><img src="/resource/templete/cms1/src/img/sub/hall_select_next_month.gif" alt="다음달" /></button>
</div>

<ul>
<c:set var="arrWeek" value="${fn:split('일,월,화,수,목,금,토',',') }" />
<c:forEach var="d" items="${dateList }" varStatus="status">
	<li class="${d.disabled }">
		<input type="radio" name="rReserveDt" id="rReserveDt${status.count }" value="${ufn:getZeroPlus(d.date) }"  onclick="fn_selectItem('rReserveDt', '${status.count}')" ${d.disabled } />
		<label for="rReserveDt${status.count }"><c:out value="${ufn:getZeroPlus(month) }" />월<c:out value="${ufn:getZeroPlus(d.date) }" />일 ${arrWeek[d.week - 1] }요일</label>
	</li>
</c:forEach>
</ul>
