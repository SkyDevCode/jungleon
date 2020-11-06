<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%
/**
 * @파일명 : mngrStatsConnView.jsp
 * @파일정보 : 통계관리 날짜별접속통계 뷰
 * @수정이력
 * @수정자     수정일       수정내용
 * @--------- ------------- ---------------
 * @ bluejick  2016. 3. 30. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
	<!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            접속통계
            <!-- <small>관리자 회원 목록</small> -->
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="#">통계관리</a></li>
            <li class="active">날짜별접속통계</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box box-primary">
		                <div class="box-header with-border">
		                  	<h3 class="box-title">${searchVO.schDate}<c:choose>
		                  		<c:when test="${searchVO.schOption == 'HOUR'}">일 시간별 접속통계</c:when>
		                  		<%-- <c:when test="${searchVO.schOption == 'DAY_W'}">주차 접속현황</c:when> --%>
		                  		<c:when test="${searchVO.schOption == 'DAY_M'}">월 접속통계</c:when>
		                  		<c:when test="${searchVO.schOption == 'MONTH'}">년 접속통계</c:when>
		                  		<c:when test="${searchVO.schOption == 'YEAR'}">년간 전체 접속현황</c:when>
		                  	</c:choose></h3>
		                </div><!-- /.box-header -->
						<div class="box-body">

							<form name="listForm" method="post" onsubmit="fn_search(); return false;">
							<div class="row margin-bottom">
								<div class="col-sm-12 form-inline" id="searchBox">
									<label for="schOption" class="sr-only">검색조건</label>
									<select name="schOption" id="schOption" class="form-control input-sm">
											<option value="HOUR" ${ufn:selected(searchVO.schOption, 'HOUR') }>시간별</option>
											<%-- <option value="DAY_W" ${ufn:selected(searchVO.schOption, 'DAY_W') }>일(주단위)별</option> --%>
											<option value="DAY_M" ${ufn:selected(searchVO.schOption, 'DAY_M') }>일별</option>
											<option value="MONTH" ${ufn:selected(searchVO.schOption, 'MONTH') }>월별</option>
											<option value="YEAR" ${ufn:selected(searchVO.schOption, 'YEAR') }>년도별</option>
									</select>
									<div class="input-group date">
  										<input type="text" class="form-control" name="schDate" readOnly value="${searchVO.schDate}"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
									</div>

<%-- 									<label for="viewCount" class="sr-only">리스트 갯수</label>
									<select name="viewCount" id="viewCount" class="form-control input-sm">
										<option value="10" ${ufn:selected(searchVO.viewCount, '10') }>10</option>
										<option value="30" ${ufn:selected(searchVO.viewCount, '30') }>30</option>
										<option value="50" ${ufn:selected(searchVO.viewCount, '50') }>50</option>
										<option value="100" ${ufn:selected(searchVO.viewCount, '100') }>100</option>
									</select> --%>
									<%-- <label for="schDateFrom" class="sr-only">시작일</label>
									<input name="schDateFrom" id="schDateFrom"  class="form-control input-sm" value="<c:out value="${searchVO.schDateFrom }" />" title="검색어 입력"/>
									<label for="schDateTo" class="sr-only">종료일</label>
									<input name="schDateTo" id="schDateTo"  class="form-control input-sm" value="<c:out value="${searchVO.schDateTo }" />" title="검색어 입력"/>

									<button class="btn btn-default btn-sm btn-sm-search">검색</button> --%>
								</div>
							</div>
							</form>
						</div><!-- /.box-body -->
						</form>
					</div>
					<div class="box">
						<!-- <div class="box-header with-border"><h3 class="box-title">Title</h3></div> -->
						<div class="box-body">
							<div class="row">
								<div class="col-sm-12">
								    <table id="example1" class="table table-bordered">
								       	<colgroup>
										  	<col width="30%">
										  	<col width="30%">
										  	<col width="40%">
										</colgroup>
								        <thead>
											<tr>
												<th scope="col">
													<c:choose>
								                  		<c:when test="${searchVO.schOption == 'HOUR'}">시간</c:when>
								                  		<%-- <c:when test="${searchVO.schOption == 'DAY_W'}"><c:out value="${result.cntDay}" /></c:when> --%>
								                  		<c:when test="${searchVO.schOption == 'DAY_M'}">일</c:when>
								                  		<c:when test="${searchVO.schOption == 'MONTH'}">월</c:when>
								                  		<c:when test="${searchVO.schOption == 'YEAR'}">년도</c:when>
										            </c:choose>
									            </th>
												<th scope="col">방문자수</th>
												<th scope="col">누적 방문자수</th>
											</tr>
										</thead>
								        <tbody>
								        	<c:set var ="totcnt" value="0"/>
								        	<c:forEach var="result" items="${resultList}" varStatus="status">
								        		<c:choose>
									            	<c:when test="${searchVO.schOption == 'HOUR'}"><c:set var ="date" value="${result.cntHour}" />
									            		<c:set var ="maxEnd" value="24" /></c:when>
									                <c:when test="${searchVO.schOption == 'DAY_W'}"><c:set var ="date" value="${result.cntDay}" />
									                	<c:set var ="maxEnd" value="31" /></c:when>
									                <c:when test="${searchVO.schOption == 'DAY_M'}"><c:set var ="date" value="${result.cntDay}" />
									                	<c:set var ="maxEnd" value="31" /></c:when>
									                <c:when test="${searchVO.schOption == 'MONTH'}"><c:set var ="date" value="${result.cntMonth}" />
									                	<c:set var ="maxEnd" value="12" /></c:when>
									                <c:when test="${searchVO.schOption == 'YEAR'}"><c:set var ="date" value="${result.cntYear}" /></c:when>
									            </c:choose>
									            <!-- S : 결과 리스트에 없는 데이터 출력 : 앞부분 -->
									            <c:if test="${searchVO.schOption ne 'YEAR'}">
									        		<c:if test="${status.count eq 1}">
									        			<c:set var ="begin" value="1"/>
									        			<c:set var ="end" value="${date-1}"/>
									        			<c:forEach var="i" begin="${begin}" end="${end}" step="1">
									        				<tr>
									        					<td class="tac">
									        						<c:if test="${searchVO.schOption eq 'HOUR'}">
									        							<c:if test="${(i-1)<10}">0</c:if><c:out value="${i-1} ~ " />
									        						</c:if>
									        						<c:if test="${i<10}">0</c:if><c:out value="${i}" />
									        					</td>
									        					<td class="tac">0</td><td class="tac"><c:out value="${totcnt}" /></td></tr>
														</c:forEach>
									        		</c:if>
									        		<c:if test="${status.count ne 1}">
									        			<c:set var ="end" value="${date-1}"/>
									        			<c:forEach var="i" begin="${begin}" end="${end}" step="1">
									        				<tr>
									        					<td class="tac">
									        						<c:if test="${searchVO.schOption eq 'HOUR'}">
									        							<c:if test="${(i-1)<10}">0</c:if><c:out value="${i-1} ~ " />
									        						</c:if>
									        						<c:if test="${i<10}">0</c:if><c:out value="${i}" /></td>
									        					<td class="tac">0</td><td class="tac"><c:out value="${totcnt}" /></td></tr>
														</c:forEach>
									        		</c:if>
									        	</c:if>
									        	<!-- E : 결과 리스트에 없는 데이터 출력 : 앞부분 -->
									        	<!-- S : 결과 리스트-->
								        		<tr>
													<td class="tac"><c:if test="${searchVO.schOption eq 'HOUR'}">
									        				<c:out value="${date-1} ~ " />
									        			</c:if>
									        			<c:out value="${date}" /></td>
													<td class="tac"><c:out value="${result.cntCount}" /></td>
													<c:set var ="totcnt" value="${totcnt+result.cntCount}"/>
													<td class="tac"><c:out value="${totcnt}" /></td>
													<%-- <td class="tac"><c:out value="${ufn:strCalculator(totcnt, '+', result.cntCount)}"/></td> --%>
												</tr>
												<!-- E : 결과 리스트-->
												<!-- S : 결과 리스트에 없는 데이터 출력 : 뒷부분 -->
												<c:if test="${searchVO.schOption ne 'YEAR'}">
									        		<c:if test="${(date ne maxEnd) && (fn:length(resultList ) eq status.count)}">
									        			<c:set var ="begin" value="${date+1}"/>
									        			<c:set var ="end" value="${maxEnd}"/>
									        			<c:forEach var="i" begin="${begin}" end="${end}" step="1">
									        				<tr><td class="tac"><c:if test="${searchVO.schOption eq 'HOUR'}">
									        							<c:if test="${(i-1)<10}">0</c:if><c:out value="${i-1} ~ " />
									        						</c:if>
									        						<c:if test="${i<10}">0</c:if><c:out value="${i}" /></td>
									        					<td class="tac">0</td>
									        					<td class="tac"><c:out value="${totcnt}" /></td>
									        				</tr>
														</c:forEach>
									        		</c:if>
									        		<c:set var ="begin" value="${date+1}"/>
								        		</c:if>
								        		<!-- E : 결과 리스트에 없는 데이터 출력 : 뒷부분 -->
								        	</c:forEach>
											<c:if test="${fn:length(resultList ) == 0}">
												<tr><td colspan="3" class="tac">데이터가 없습니다.</td></tr>
											</c:if>
										</tbody>
								      </table>
								  </div> <!-- .col-sm-12 -->
								</div> <!--  .row -->


						</div> <!-- /box-body -->
					</div> <!-- /box -->
				</div> <!-- /col -->
			</div> <!-- /row -->

	        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->




<script type="text/javascript">
//<![CDATA[
    var queryString = "${searchVO.query}";

	function fn_search(){
		var tmpQuery = queryString;
		var f = document.listForm;
		f.submit();
/* 		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schOption", f.schOption.value);

		location.href="?" + tmpQuery; */
	}

	$( "#schOption" ).change(function() {
		var f = document.listForm;
		f.schDate.value="";
		fn_search();
	});

	$('#searchBox .input-group.date').change(function() {
		fn_search();
	});

	$(function() {
	 	$.fn.datepicker.dates['kr'] = {
			days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
			daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
			daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
			months: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
			monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
		};

	 	var schOpt = "${searchVO.schOption}";
	 	if(schOpt == "HOUR"){
		 	$('#searchBox .input-group.date').datepicker({
		    	format: "yyyy-MM-dd",
		    	//startView: 1,
		    	//minViewMode: 1,
		    	endDate: "today",
		    	language: "kr",
		    	autoclose: true,
		    	todayHighlight: true

			});
	 	}else if(schOpt == "DAY_M"){
		 	$('#searchBox .input-group.date').datepicker({
		    	format: "yyyy-MM",
		    	endDate: "today",
		    	startView: 1,
		    	minViewMode: 1,
		    	language: "kr",
		    	autoclose: true,
		    	todayHighlight: true
			});
	 	}else if(schOpt == "MONTH"){
		 	$('#searchBox .input-group.date').datepicker({
		    	format: "yyyy",
		    	endDate: "today",
		    	startView: 2,
		    	minViewMode: 2,
		    	language: "kr",
		    	autoclose: true,
		    	todayHighlight: true
			});
	 	}else{
	 		$('#searchBox .input-group.date').hide();
	 	}

	});

//]]>
</script>

