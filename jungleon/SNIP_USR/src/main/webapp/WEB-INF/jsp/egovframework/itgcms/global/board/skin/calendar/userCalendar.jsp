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
 * @파일명 : userCalendar.jsp
 * @파일정보 : 통합게시판 달력 include 스킨
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @jyl 2018. 03. 22. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

<script type="text/javascript">
//달력에 출력될 게시글 리스트 설정
var bdListMap = new Map();
var tempList = new ArrayList();
var tempListMap = null;
<c:set var="sdt" value=""/>
<c:forEach var="result" items="${resultList}" varStatus="status">
	<c:set var="sdt" value="${result.bdSchSdt}"/>
	<c:set var="diff" value="${ufn:dateDiff(result.bdSchEdt, result.bdSchSdt, 'yyyy-MM-dd', 'd')}"/>
	console.log("diff : ${diff}, title : ${ufn:stripXssScript(result.bdTitle)}");
	<c:forEach var="i" begin="0" end="${diff}">
	<c:set var="bdSchNdt" value="${ufn:dateAdd(result.bdSchSdt, i, 'yyyy-MM-dd')}"/>
	console.log("forEach i: ${i}, ${bdSchNdt}");
	tempList = new ArrayList();
	console.log("tempList reset");
	tempListMap = bdListMap.get("${bdSchNdt}");
	if(tempListMap != null){
		console.log("tempList=tempListMap");
		tempList=tempListMap;
		tempListMap=null;
	}
var bdMap = new Map();
	bdMap.put("bdIdx","${result.bdIdx}");
	bdMap.put("bdSchSdt","${result.bdSchSdt}");
	bdMap.put("bdSchEdt","${result.bdSchEdt}");
	bdMap.put("bdTitle","${ufn:stripXssScript(result.bdTitle)}");
	tempList.add(bdMap);
	bdListMap.put("${bdSchNdt}",tempList);
	</c:forEach>
</c:forEach>

$(document).ready(function(){
	initBoardlist(bdListMap,2);
	initLayerlist(bdListMap);
})

//달력에 게시글 리스트 출력
function initBoardlist(bdListMap,limit){

 	for(var i=0; i<bdListMap.size();i++){
 		var bdList = bdListMap.values()[i];
 		var bdSchNdt = bdListMap.keys()[i];
 		console.log("bdSchNdt : "+bdSchNdt);
 		console.log(bdList.size());
 		console.log(limit);
		if(bdList.size() < limit || limit == null) limit = bdList.size();
 		for(var j=0; j<limit;j++){
			var bdIdx = bdList.get(j).get("bdIdx");
			var bdSchSdt = bdList.get(j).get("bdSchSdt");
			var bdSchEdt = bdList.get(j).get("bdSchEdt");
			var bdTitle = bdList.get(j).get("bdTitle");
			var linkStr = "<a href='javascript:void(0)' title='●  제목 : "+bdTitle+"&#13;●  기간 : "+bdSchSdt+"~"+bdSchEdt+"' ";
				linkStr += "onclick=\"fn_goView('"+bdIdx+"'); return false;\">";
				linkStr += "<p class='bd_tit'>"+bdTitle+"</p></a>";

			$("#"+bdSchNdt+" div").append(linkStr);
 		}
 		if(bdList.size()>2){
 			console.log(bdList.size());
 			$("#"+bdSchNdt+" div").append("<button type=\"button\" class=\"btn_more\" data-lypop=\"lypop"+bdSchNdt+"\">더보기</button>");
 		}
	}
}

function initLayerlist(bdListMap){

 	for(var i=0; i<bdListMap.size();i++){
 		var htmlStr = "";
 		var bdList = bdListMap.values()[i];
 		if(bdList.size()>2){
	 		var bdSchNdt = bdListMap.keys()[i];
	 		var bdSchNdtArr = bdSchNdt.split("-");
	 		console.log("bdSchNdt : "+bdSchNdt);
	 		console.log(bdList.size());
	 		htmlStr  = '<div class="layer_wrap" tabindex="0" data-lypop-con="lypop'+bdSchNdt+'" data-focus="lypop'+bdSchNdt+'" data-focus-prev="lypop'+bdSchNdt+'-close" style="display:none">';
	 		htmlStr += '	<div class="layer_inner">';
	 		htmlStr += '		<strong class="layer_title">'+bdSchNdtArr[0]+'<span class="blind">년</span> '+bdSchNdtArr[1]+'<span class="blind">월</span> '+bdSchNdtArr[2]+'<span class="blind">일</span> 일정</strong>';
	 		htmlStr += '		<div class="layer_cont">';
	 		htmlStr += '			<div class="calendar_info">';
	 		for(var j=0; j<bdList.size();j++){
				var bdIdx = bdList.get(j).get("bdIdx");
				var bdSchSdt = bdList.get(j).get("bdSchSdt");
				var bdSchEdt = bdList.get(j).get("bdSchEdt");
				var bdTitle = bdList.get(j).get("bdTitle");
				htmlStr +=					'<a href="#" class="calendar_tit" onclick="fn_goView(\''+bdIdx+'\'); return false;">'+bdTitle+'</a>';
	 		}
	 		htmlStr += '			</div>';
	 		htmlStr += '		</div>';
	 		htmlStr += '		<a href="#" class="layer_close" data-focus="lypop'+bdSchNdt+'-close" data-focus-next="lypop'+bdSchNdt+'"><span class="blind">레이어 닫기</span></a>';
	 		htmlStr += '	</div>';
	 		htmlStr += '</div>';
	 		$('.conWrap').append(htmlStr);
 		}
	}
}
</script>

<div class="calendarWrap">
	<div class="inner">
		<div class="year"><strong><c:out value="${currYear}"/></strong>년</div>
		<div class="month"><strong><c:out value="${currMonth + 1}"/></strong>월</div>
		<a href="javascript:void(0)" class="btn_prev"><img src="${ctx}/resource/templete_common/img/common/calendar_prev.png" onclick="fn_changeMonth('0'); return false;" alt="이전 달력보기"></a>
		<a href="javascript:void(0)" class="btn_next"><img src="${ctx}/resource/templete_common/img/common/calendar_next.png" onclick="fn_changeMonth('1'); return false;" alt="다음 달력보기"></a>
		<a href="#" class="btn_today" onclick="fn_changeMonth(''); return false;" alt="오늘 달력보기">오늘<span class="blind">날짜로 가기</span></a>
	</div>

	<table border="0" cellpadding="0" cellspacing="0"
		style="table-layout: fixed;">
		<caption>월간 교육일정</caption>
		<colgroup>
			<col width="14.25%">
			<col width="14.25%">
			<col width="14.25%">
			<col width="14.25%">
			<col width="14.25%">
			<col width="14.25%">
			<col width="14.25%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">SUN</th>
				<th scope="col">MON</th>
				<th scope="col">TUE</th>
				<th scope="col">WED</th>
				<th scope="col">THU</th>
				<th scope="col">FRI</th>
				<th scope="col">SAT</th>
			</tr>
		</thead>
		<tbody>
			<%
				String[][] holidays = {
						{"0101","신정"}, {"0301","삼일절"},
						{"0505","어린이날"}, {"0606","현충일"}, {"0815","광복절"},
						{"1003","개천절"}, {"1009","한글날"}, {"1225","성탄절"}
				};

				String tempMonthDay1 = "";
				String tempMonthDay2 = "";
				String stringMonthDay = "";
			%>
			<c:set var="count" value="1"/>
			<c:set var="dispDay" value="1"/>
			<c:set var="todayBg" value=""/>
			<c:set var="todayType" value=""/>

		<c:forEach var="w" begin="1" end="${weekCount}" step="1"  >
			<tr>
			<c:forEach var="d" begin="1" end="7" step="1">
  			<c:choose>
	  			<c:when test='${! (count >= firstYoil) }'>
					<td>&nbsp;</td>
					<c:set var="count" value="${count+1}" />
				</c:when>
				<c:otherwise>
					<c:choose>
	  					<c:when test='${ufn:isDate(currMonth + 1, dispDay, currYear)}'>
							<c:choose>
							 	<c:when test='${dispDay == todayCalDay && todayCalMonth ==  setCalMonth && todayCalYear == setCalYear}'>
									<c:set var="todayBg" value="today_bg"/>
									<c:choose>
										<c:when test='${d == 1 }'>
											<c:set var="todayType" value="sun"/>
										</c:when>
										<c:when test='${d == 7 }'>
											<c:set var="todayType" value="sat"/>
										</c:when>
										<c:otherwise>
											<c:set var="todayType" value="weekday"/>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:set var="todayBg" value=""/>
									<c:choose>
										<c:when test='${d == 1 }'>
											<c:set var="todayType" value="sun"/>
										</c:when>
										<c:when test='${d == 7 }'>
											<c:set var="todayType" value="sat"/>
										</c:when>
										<c:otherwise>
											<c:set var="todayType" value="weekday"/>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>

						<c:set var="dispFullDay" value="${yearString}-${monthString}-${ufn:getZeroPlus(dispDay)}"/>
						<td  id="${dispFullDay}" class="<c:out value="${todayBg} ${todayType}"/>">
							<div>
								<span class="dispDay <c:out value="${todayBg} ${todayType} ${ufn:IIF(ufn:isLunar(dispFullDay),'sun','')}"/>">${dispDay}</span>
								<%
									tempMonthDay1 = String.format("%02d", Integer.parseInt(request.getAttribute("currMonth").toString())+1);
									tempMonthDay2 = String.format("%02d", Integer.parseInt(pageContext.getAttribute("dispDay").toString()) );
									stringMonthDay = tempMonthDay1 + tempMonthDay2;
								%>
								<%
									/*********** 국경일 표시 ************************/
									for (int m=0; m < holidays.length; m++){
										if (stringMonthDay.equals(holidays[m][0]) ) {
										%>
										<%-- <span><strong class='holiday_name'><%=holidays[m][1]%></strong></span> --%><!-- 공휴일 이름 표시 -->
										<script>
											$(window).load(function() {
												$('#${dispFullDay} .dispDay').addClass('sun'); //날짜색상,버튼없음
												/* $('#${dispDay} strong.holiday_name').addClass('holiday_name'); */ //공휴일의 이름 텍스트사이즈
											});
										</script>
										<%
										} //if문 종료
									} //for문 종료
								%>
								<c:set var="resultDate" value="${dispDay }" />
								<c:choose>
									<c:when test="${resultDate < 10 }">
										<c:set var="resultDate" value="0${resultDate }" />
									</c:when>
									<c:otherwise>
										<c:set var="resultDate" value="${resultDate}" />
									</c:otherwise>
								</c:choose>
							</div>
						</td>
							<c:set var="count" value="${count+1}" />
							<c:set var="dispDay" value="${dispDay+1}" />
						</c:when>
						<c:otherwise>
						<td >&nbsp;</td>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			</c:forEach>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>

<form name="calForm" id="calForm" method="post">
	<input type="hidden" name="schId" id="schId"/>
	<input type="hidden" name="schM" id="schM"/>
	<input type="hidden" name="act" id="act"/>
	<input type="hidden" name="schMonth" id="schMonth"/>
	<input type="hidden" name="schOpt1" id="schOpt1" value ="<c:out value="${boardSearchVO.schOpt1}"/>"/>
	<input type="hidden" name="schOpt2" id="schOpt2" value ="<c:out value="${boardSearchVO.schOpt2}"/>"/>
</form>
