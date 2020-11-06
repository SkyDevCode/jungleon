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
 * @파일명 : userPrintCalendar.jsp
 * @파일정보 : 사업신청 > 대관신청 달력 출력
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
<div class="calendar_top_area clfx">
	<button class="btn_month_prev" onclick="fn_getCalendarTable('${prevYear}', '${ufn:getZeroPlus(prevMonth )}')"><img src="${ctx }/resource/templete/cms1/src/img/sub/prev_month_btn.gif" alt="이전달" /></button>
	<span class="month"><c:out value="${year }" />년 <c:out value="${ufn:getZeroPlus(month) }" />월</span>
	<button class="btn_month_next" onclick="fn_getCalendarTable('${nextYear}', '${ufn:getZeroPlus(nextMonth )}')"><img src="${ctx }/resource/templete/cms1/src/img/sub/next_month_btn.gif" alt="다음달" /></button>
</div>
<div class="calendar" id="calendar">
	<table>
		<caption>
				<p class="ir-text">일,월,화,수,목,금,토요일의 대관신청을 선택할수있는 캘린더</p>
		</caption>
		<colgroup>
			<col style="width:14.28%;" />
			<col style="width:14.28%;" />
			<col style="width:14.28%;" />
			<col style="width:14.28%;" />
			<col style="width:14.28%;" />
			<col style="width:14.28%;" />
			<col />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="c-red">일</th>
				<th scope="col">월</th>
				<th scope="col">화</th>
				<th scope="col">수</th>
				<th scope="col">목</th>
				<th scope="col">금</th>
				<th scope="col" class="c-blue">토</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="cnt" value="1" />
			<tr>
			<c:forEach var="f" begin="1" end="${dayOfWeek - 1}" step="1">
				<td></td>
				<c:set var="cnt" value="${cnt + 1 }" />
			</c:forEach>
			<c:forEach var="day" begin="1" end="${lastDayOfMonth }" step="1">
				<c:set var="weekend" value="" />
				<c:if test="${cnt mod 7 eq 1 }">
					<c:set var="weekend" value="c-red" />
					</tr><tr>
				</c:if>
				<c:if test="${cnt mod 7 eq 0 }">
					<c:set var="weekend" value="c-blue" />
				</c:if>
				<%-- <c:if test="${day eq date }">
					<c:set var="weekend" value="${weekend } today" />
				</c:if> --%>
				<c:if test="${day eq date }">
					<c:set var="weekend" value="${weekend }" />
				</c:if>
				<%-- <td class="${weekend }">
					<span class="day">${day }</span>
					<c:if test="${not empty result[ufn:getZeroPlus(day)] }">
						<button class="reservation_num" onclick="fn_selectDate('${year}', '${ufn:getZeroPlus(month) }', '${ufn:getZeroPlus(day )}')"><span>대관 </span>${result[ufn:getZeroPlus(day)] }<span>건</span></button>
					</c:if>
				</td> --%>
				<td class="${weekend }">
					<a href="#none"  onclick="fn_selectDate('${year}', '${ufn:getZeroPlus(month) }', '${ufn:getZeroPlus(day )}', this)">
					<span class="day">${day }</span>
					<c:if test="${not empty result[ufn:getZeroPlus(day)] }">
						<button class="reservation_num" ><span>대관 </span>${result[ufn:getZeroPlus(day)] }<span>건</span></button>
					</c:if>
					</a>
				</td>
				<c:set var="cnt" value="${cnt + 1 }" />
			</c:forEach>
			<c:forEach var="l" begin="${dayOfWeekLastDay + 1 }" end="7" step="1">
				<td></td>
			</c:forEach>
			</tr>
		</tbody>
	</table>
</div>