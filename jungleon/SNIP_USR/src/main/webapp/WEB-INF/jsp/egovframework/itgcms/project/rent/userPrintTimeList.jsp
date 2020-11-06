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
 * @파일명 : userPrintTimeList.jsp
 * @파일정보 : 사업신청 > 대관신청 > 신청화면 4.시간선택 리스트
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 04. 19. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<ul>
<c:forEach var="tm" items="${resultTimeList }" varStatus="status">
	<li class="${tm.disabled }">
		<input type="checkbox" name="rReserveTm" id="rReserveTm${status.count }" onclick="fn_selectItem('rReserveTm', '${status.count }');" value="${tm.time }" ${tm.disabled } />
		<label for="rReserveTm${status.count }">${tm.time }:00~${tm.time + 1 }:00</label>
	</li>
</c:forEach>
</ul>
<script>
tmSelList = [];
<c:forEach var="tm" items="${resultTimeList }" varStatus="status">
tmSelList.push('${tm.date}')
</c:forEach>
</script>