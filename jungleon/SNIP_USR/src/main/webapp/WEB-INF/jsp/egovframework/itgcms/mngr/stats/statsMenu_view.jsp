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
 * @파일명 : mngrStatsMenuView.jsp
 * @파일정보 : 통계관리 메뉴별접속통계 뷰
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

        	<ul class="nav nav-tabs">
					<li class="active"><a href="#dataChart" data-toggle="tab" aria-expanded="false">차트</a></li>
					<li><a href="#dataTable" data-toggle="tab" aria-expanded="true">표</a></li>
				</ul>
			<div class="row">
				<div class="col-md-12">
					<div class="box box-primary">
		                <div class="box-header with-border">
		                  	<h3 class="box-title">
		                  		<c:set var="endDateStr" value=" ~ ${searchVO.schDateEnd}"/>
		                  		<c:set var="titleStr" value="${ufn:deCode(searchVO.schOption, 'DAY,일(간),MONTH,월(간),YEAR,년(간)', '')}"/>
		                  		${searchVO.schDateFrom} ${ufn:IIF(searchVO.schDateFrom eq searchVO.schDateEnd,'',endDateStr)}${titleStr} 메뉴별 접속통계
							</h3>
		                </div><!-- /.box-header -->
						<div class="box-body">
							<form name="listForm" method="post" onsubmit="fn_search(); return false;">
								<input type="hidden" name="schDateFrom" />
								<input type="hidden" name="schDateEnd" />
							<div class="row margin-bottom">
								<div class="col-sm-12 form-inline" id="searchBox">
									<label for="schOption" class="sr-only">검색조건</label>
									<select name="siteCode" id="siteCode" class="form-control">
										<option value="all" <c:out value="${searchSite eq 'all' ? 'selected' : ''}"/>>전체</option>
										<c:forEach var="site" items="${siteList}">
											<option value="${site.siteCode}" <c:out value="${site.siteCode eq searchSite ? 'selected' : ''}"/>>${site.siteName}</option>
										</c:forEach>
									</select>
									<select name="schOption" id="schOption" class="form-control">
											<option value="DAY" ${ufn:selected(searchVO.schOption, 'DAY') }>일별</option>
											<option value="MONTH" ${ufn:selected(searchVO.schOption, 'MONTH') }>월별</option>
											<option value="YEAR" ${ufn:selected(searchVO.schOption, 'YEAR') }>년도별</option>
									</select>
									<div class="input-daterange input-group" id="datepicker">
									    <input type="text" class="form-control" name="start" readOnly value="${searchVO.schDateFrom}"/>
									    <span class="input-group-addon">~</span>
									    <input type="text" class="form-control" name="end" readOnly value="${searchVO.schDateEnd}"/>
									    <span class="input-group-btn"><button class="btn btn-primary" type="button" onclick="fn_search();">조회</button></span>
									</div>
									<span class="pull-right"><button class="btn btn-block btn-default" onclick="getExcel();return false;"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button></span>
								</div>
							</div>
							</form>
						</div><!-- /.box-body -->
						</form>
					</div>
					<div class="box">
						<div class="box-header with-border">
							<span><i class="fa fa-circle-o text-light-orange"></i> 기간 내 방문자 총 <i id="cnt"></i> 명</span>
							<span class="pull-right">(단위 : 명)</span>
						</div>
						<div class="box-body">
							<div class="row">
								<div class="col-sm-12">
									<div class="nav-tabs-custom">
									<div class="tab-content">
										<div class="tab-pane active" id="dataChart">
											<div class="chart" id="menu-chart"  style="position: relative; height: <c:out value='${95 + fn:length(resultList)*30}'/>px; width: 100%; margin-top:30px;"></div>
										</div>
										<div class="tab-pane" id="dataTable">
										    <table id="example1" class="table table-bordered">
										       	<colgroup>
										       		<col width="10%">
										       		<col width="10%">
										       		<col width="20%">
												  	<col >
												  	<col width="8%">
												  	<col width="8%">
												</colgroup>
										        <thead>
													<tr>
														<th scope="col">사이트코드</th>
														<th scope="col">메뉴아이디</th>
														<th scope="col">메뉴명</th>
														<th scope="col">위치</th>
														<th scope="col">방문자<br/>합계</th>
														<th scope="col">누적<br/>방문자수</th>
													</tr>
												</thead>
										        <tbody>
										        	<c:set var ="totcnt" value="0"/>
										        	<c:forEach var="result" items="${resultList}" varStatus="status">
											        	<!-- S : 결과 리스트-->
										        		<tr>
															<td><c:out value="${result.siteCode}" /></td>
															<td><c:out value="${result.cntName}" /></td>
															<td>
														<c:choose>
															<c:when test="${result.menuName eq '' or result.menuName eq null}">
																(삭제된메뉴)
															</c:when>
															<c:otherwise>
																<a href="http://${systemconfigVO.domainAddr}/${result.siteCode}/contents/${result.cntName}.do" target="_blank"><c:out value="${result.menuName}" /></a>
															</c:otherwise>
														</c:choose>
															</td>
															<td><c:out value="${ufn:isNull(result.menuFullName,'(삭제된메뉴)')}" /></td>
															<c:choose>
																<c:when test="${result.cntName eq 'N20103000000' || result.cntName eq 'N20100000000' || result.cntName eq 'N20105000000' || result.cntName eq 'N20104000000'}">
																	<c:set var ="cntCount" value="${result.cntCount * 3}"/>
																</c:when>
																<c:otherwise>
																	<c:set var ="cntCount" value="${result.cntCount}"/>
																</c:otherwise>
															</c:choose>
															<td class="tac"><c:out value="${cntCount}" /></td>
															<c:set var ="totcnt" value="${totcnt+cntCount}"/>
															<td class="tac"><c:out value="${totcnt}" /></td>
															<%-- <td><c:out value="${ufn:strCalculator(totcnt, '+', result.cntCount)}"/></td> --%>
														</tr>
														<!-- E : 결과 리스트-->
										        	</c:forEach>
													<c:if test="${fn:length(resultList ) == 0}">
														<tr><td colspan="3" class="tac">데이터가 없습니다.</td></tr>
													</c:if>
												</tbody>
										      </table>
									      	</div>
									      </div>
								      </div>
								  </div> <!-- .col-sm-12 -->
								</div> <!--  .row -->
						</div> <!-- /box-body -->
					</div> <!-- /box -->
				</div> <!-- /col -->
			</div> <!-- /row -->

<script type="text/javascript">
//<![CDATA[
    var queryString = "${searchVO.query}";

	function fn_search(){
		var tmpQuery = queryString;
		var f = document.listForm;
		f.schDateFrom.value=f.start.value;
		f.schDateEnd.value=f.end.value;
		f.action = "";
		f.submit();
/* 		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schOption", f.schOption.value);

		location.href="?" + tmpQuery; */
	}

	$("#siteCode").change(function(){
		var f = document.listForm;
		f.start.value="";
		f.end.value="";
		fn_search();
	});

	$( "#schOption" ).change(function() {
		var f = document.listForm;
		f.start.value="";
		f.end.value="";
		fn_search();
	});

	$('#searchBox .input-group.date').change(function() {
		fn_search();
	});

	$(function() {
		$("#cnt").html('${totcnt}');
	 	$.fn.datepicker.dates['kr'] = {
			days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
			daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
			daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
			months: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
			monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
		};

	 	var schOpt = "${searchVO.schOption}";
	 	if(schOpt == "DAY"){
		 	$('#searchBox .input-daterange').datepicker({
		    	format: "yyyy-MM-dd",
		    	//startView: 1,
		    	//minViewMode: 1,
		    	endDate: "today",
		    	language: "kr",
		    	autoclose: true,
		    	todayHighlight: true
			});
	 	}else if(schOpt == "MONTH"){
		 	$('#searchBox .input-daterange').datepicker({
		    	format: "yyyy-MM",
		    	endDate: "today",
		    	startView: 1,
		    	minViewMode: 1,
		    	language: "kr",
		    	autoclose: true,
		    	todayHighlight: true
			});
	 	}else{
		 	$('#searchBox .input-daterange').datepicker({
		    	format: "yyyy",
		    	endDate: "today",
		    	startView: 2,
		    	minViewMode: 2,
		    	language: "kr",
		    	autoclose: true,
		    	todayHighlight: true
			});
	 	}
	});

	function getExcel(){
    	var f = document.listForm;
		f.action = "/excel/mngrStatsMenuExcelDown.do";
		f.method = "post";
		f.schDateFrom.value=f.start.value;
		f.schDateEnd.value=f.end.value;
	    f.submit();
    }

	var chartData = [];
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:if test="${status.count == 1}">
			var maxValue = "${result.cntCount}";
		</c:if>
		<c:choose>
			<c:when test="${result.cntName eq 'N20103000000' || result.cntName eq 'N20100000000' || result.cntName eq 'N20105000000' || result.cntName eq 'N20104000000'}">
			chartData.push({"label" : "[${result.siteCode}]<c:out value='${result.menuName == "" ? result.cntName : result.menuName}'/>", "value" : "${result.cntCount * 3}", "href": "/${result.siteCode}/contents/${result.cntName}.do"});
			</c:when>
			<c:otherwise>
			chartData.push({"label" : "[${result.siteCode}]<c:out value='${result.menuName == "" ? result.cntName : result.menuName}'/>", "value" : "${result.cntCount}", "href": "/${result.siteCode}/contents/${result.cntName}.do"});
			</c:otherwise>
		</c:choose>
	</c:forEach>

	if (chartData.length > 0) {
		var menuBarChart = new Morris.Bar({
		      element: 'menu-chart',
		      resize: true,
		      data: chartData,
		      xkey: 'label',
		      ykeys: ['value'],
		      labels: ['방문자'],
		      barColors : function (row, series, type) {
		    	  if ((maxValue * 0.7) < row.y) {
		    		  return "#f56954";
		    	  } else if ((maxValue * 0.4) < row.y) {
		    		  return "#00a65a";
		    	  } else {
		    		  return "#a0d0e0";
		    	  }
		      },
		      xAxisTop : true,
		      xAxisTopPos : '10',
		      horizontal : true,
		      hideHover: 'auto'
	    });

		menuBarChart.on("click", function(i, row){
			 window.open(row.href);
		});
	} else {
		$("#menu-chart").html("<h6 style='text-align:center;'>해당 기간의 통계 데이터가 존재하지 않습니다.</h6>");
	}
//]]>
</script>
