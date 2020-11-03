<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="cct" uri="/WEB-INF/tlds/CreateCodeTag.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>


<div class="calendarWrap">
	<div class="month">
		<p>
			<a href="#"><img
				src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/main/calendar_prev.png"
				alt="이전 달력보기"></a>
		</p>
		<span><strong><c:out value="${currMonth + 1}"/></strong>월</span>
		<p>
			<a href="#"><img
				src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/main/calendar_next.png"
				alt="다음 달력보기"></a>
		</p>
	</div>
	<ul class="iconBox">
		<li><img
			src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/main/calendar_ic1.png" alt="보기1"
			style="padding-right: 10px;">보기1</li>
		<li><img
			src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/main/calendar_ic2.png" alt="보기2"
			style="padding-right: 10px;">보기2</li>
		<li><img
			src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/main/calendar_ic3.png" alt="보기3"
			style="padding-right: 10px;">보기3</li>
	</ul>
	<table border="0" cellpadding="0" cellspacing="0" style="table-layout: fixed;">
		<caption>월간 달력</caption>
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
				<th scope="col">일</th>
				<th scope="col">월</th>
				<th scope="col">화</th>
				<th scope="col">수</th>
				<th scope="col">목</th>
				<th scope="col">금</th>
				<th scope="col">토</th>
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

						<td  id="${dispDay}" class="${todayBg} ${todayType} " >
							<div>
								<span class="${todayBg} ${todayType} ">${dispDay}</span>
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
										<span><strong class='holiday_name'><%=holidays[m][1]%></strong></span><!-- 공휴일 이름 표시 -->
										<script>
											$(window).load(function() {
												$('#${dispDay} strong').removeAttr('style');
												$('#${dispDay}').addClass('holiday'); //날짜색상,버튼없음
												$('#${dispDay} strong.holiday_name').addClass('holiday_name'); //공휴일의 이름 텍스트사이즈
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
								<%-- <div id="date_${yearString}${monthString}${resultDate }" style="font-size: 11px;"></div> --%>
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
<div class="filterWrap">
	<div class="typeBox">
		<button value="all" class="on">전체교육</button>
		<button value="seoul" class="seoul">서울</button>
		<button value="daejeon" class="daejeon">대전</button>
		<button value="changwon" class="changwon">창원</button>
	</div>
	<div class="listBox">
		<table>
			<caption>전체교육</caption>
			<colgroup>
				<col width="14%">
				<col width="14%">
				<col width="57%">
				<col width="15%">
			</colgroup>
			<tbody>
				<tr class="daejeon">
					<td class="date">05.11<br />(목)
					</td>
					<td class="type"><span>대전</span></td>
					<td class="cont">
						<p class="tit">
							<a href="#">프로젝트관리(PM) 3기</a>
						</p>
						<p class="lec">김형도 PM글로벌사 대표 , 이건재 국방대학교 교수, 김형도 PM글로벌사 대표 ,
							이건재 국방대학교 교수</p>
					</td>
					<td class="cont_v"><span><a href="#">자세히보기</a></span></td>
				</tr>
				<tr class="changwon">
					<td class="date">05.11<br />(목)
					</td>
					<td class="type"><span>대전</span></td>
					<td class="cont">
						<p class="tit">
							<a href="#">프로젝트관리(PM) 3기</a>
						</p>
						<p class="lec">김형도 PM글로벌사 대표 , 이건재 국방대학교 교수</p>
					</td>
					<td class="cont_v"><span><a href="#">자세히보기</a></span></td>
				</tr>
				<tr class="changwon">
					<td class="date">05.11<br />(목)
					</td>
					<td class="type"><span>대전</span></td>
					<td class="cont">
						<p class="tit">
							<a href="#">프로젝트관리(PM) 3기</a>
						</p>
						<p class="lec">김형도 PM글로벌사 대표 , 이건재 국방대학교 교수</p>
					</td>
					<td class="cont_v"><span><a href="#">자세히보기</a></span></td>
				</tr>
				<tr class="seoul">
					<td class="date">05.11<br />(목)
					</td>
					<td class="type"><span>대전</span></td>
					<td class="cont">
						<p class="tit">
							<a href="#">프로젝트관리(PM) 3기</a>
						</p>
						<p class="lec">김형도 PM글로벌사 대표 , 이건재 국방대학교 교수</p>
					</td>
					<td class="cont_v"><span><a href="#">자세히보기</a></span></td>
				</tr>
				<tr class="seoul">
					<td class="date">05.11<br />(목)
					</td>
					<td class="type"><span>대전</span></td>
					<td class="cont">
						<p class="tit">
							<a href="#">프로젝트관리(PM) 3기</a>
						</p>
						<p class="lec">김형도 PM글로벌사 대표 , 이건재 국방대학교 교수</p>
					</td>
					<td class="cont_v"><span><a href="#">자세히보기</a></span></td>
				</tr>
				<tr class="daejeon">
					<td class="date">05.11<br />(목)
					</td>
					<td class="type"><span>대전</span></td>
					<td class="cont">
						<p class="tit">
							<a href="#">프로젝트관리(PM) 3기</a>
						</p>
						<p class="lec">김형도 PM글로벌사 대표 , 이건재 국방대학교 교수</p>
					</td>
					<td class="cont_v"><span><a href="#">자세히보기</a></span></td>
				</tr>
				<tr class="changwon">
					<td class="date">05.11<br />(목)
					</td>
					<td class="type"><span>대전</span></td>
					<td class="cont">
						<p class="tit">
							<a href="#">프로젝트관리(PM) 3기</a>
						</p>
						<p class="lec">김형도 PM글로벌사 대표 , 이건재 국방대학교 교수</p>
					</td>
					<td class="cont_v"><span><a href="#">자세히보기</a></span></td>
				</tr>
				<tr class="changwon">
					<td class="date">05.11<br />(목)
					</td>
					<td class="type"><span>대전</span></td>
					<td class="cont">
						<p class="tit">
							<a href="#">프로젝트관리(PM) 3기</a>
						</p>
						<p class="lec">김형도 PM글로벌사 대표 , 이건재 국방대학교 교수</p>
					</td>
					<td class="cont_v"><span><a href="#">자세히보기</a></span></td>
				</tr>
				<tr class="seoul">
					<td class="date">05.11<br />(목)
					</td>
					<td class="type"><span>대전</span></td>
					<td class="cont">
						<p class="tit">
							<a href="#">프로젝트관리(PM) 3기</a>
						</p>
						<p class="lec">김형도 PM글로벌사 대표 , 이건재 국방대학교 교수</p>
					</td>
					<td class="cont_v"><span><a href="#">자세히보기</a></span></td>
				</tr>
				<tr class="seoul">
					<td class="date">05.11<br />(목)
					</td>
					<td class="type"><span>대전</span></td>
					<td class="cont">
						<p class="tit">
							<a href="#">프로젝트관리(PM) 3기</a>
						</p>
						<p class="lec">김형도 PM글로벌사 대표 , 이건재 국방대학교 교수</p>
					</td>
					<td class="cont_v"><span><a href="#">자세히보기</a></span></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
