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
 * @파일명 : userRentList.jsp
 * @파일정보 : 사업신청 > 대관신청 > 달력
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
               <div class="hall-apply_wrap clfx">
					<div class="calendar_area" id="calendar_area">
					</div>
					<div class="hall-apply_list">
<!-- 						<div class="top_area clfx"> -->
<!-- 						</div> -->
						<div class="hall-apply_list_box">
							<div class="total_num" id="total_num">
								<div class="select_day" id="select_day">
									<c:out value="${ufn:getDatePattern('yyyy년 MM월 dd일') }" />
								</div>
								<br>
 								<%-- 대관 <strong id=""><c:out value="${fn:length(resultList) }" /></strong>건 --%>
							</div>
							<div class="hall-apply_box_inner" id="hall-apply_box_inner">
								<ul>
								<c:forEach var="result" items="${resultList }">
									<li>
										<span class="time">[ ${result.rReserveTmName } ]</span>
										<c:out value="${result.rFacilityName }" />
									</li>
								</c:forEach>
								<c:if test="${fn:length(resultList) == 0 }">
									<li>
										대관 예약내역이 없습니다.
									</li>
								</c:if>
								</ul>
							</div>
						</div>
						<div class="btn_area">
							<a href="?schM=regist" title="대관신청하기페이지로 이동" class="btn_apply"><span>대관 신청하기 </span></a>
						</div>
					</div>
				</div>

<script>
	function fn_getCalendarTable(year, month) {
		var data = "year=" + year + "&month=" + month;
		$("#calendar_area").load("/${siteCode}/module/${menuCode}_userPrintCalendar.ajax", data);
	}
	$(function(){
		fn_getCalendarTable('', '')
	})

	function fn_selectDate(year, month, day, chkId) {
		$("td").removeClass('today');
		$(chkId).addClass('today');
		$.ajax({
// 	        url: "/${siteCode}/module/${menuCode}_userRentReserveData.ajax"
	        url: "/SNIP/module/Business4_userRentReserveData.ajax"
	        , data: "year=" + year + "&month=" + month + "&day=" + day
	        , type: "post"
	        , dataType: "json"
	        , async: false
	        , cache: false
	        , success: function(resultData) {
	        	if(resultData.result == '1') {
	        		$("#select_day").html(resultData.year + "년 " + resultData.month + "월 " + resultData.day + "일");
	        		//$("#total_num").html("대관 <strong>" + resultData.data.length + "</strong>건");

	        		var html = "<ul>";
	        		for(var i = 0; i < resultData.data.length; i++) {
	        			var tm = resultData.data[i].rReserveTm;
	        			html += "<li>";
	        			html += "<span class='time'>[ " + resultData.data[i].rReserveTmName + " ]</span> ";
	        			html += resultData.data[i].rFacilityName;
	        			html += "<span class='fin'>   예약완료</span>";
	        			html += "</li>";
	        		}

	        		if(resultData.data.length == 0) {
	        			html = "<li>대관 예약내역이 없습니다. </li>";
	        		}
	        		html += "</ul>";

	        		$("#hall-apply_box_inner").html(html);
	        	} else {
	        		alert(resultData.message);
	        		return false;
	        	}
	        }
	        , error: function (request, status, error) {
	            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	        }
	    });
	}
</script>