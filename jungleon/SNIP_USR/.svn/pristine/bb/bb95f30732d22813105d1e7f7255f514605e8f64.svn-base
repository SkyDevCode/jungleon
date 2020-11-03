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
 * @파일명 : mngrStatsTermView.jsp
 * @파일정보 : 통계관리 기간별 접속통계 뷰
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
		                  		<c:set var="titleStr" value="${ufn:deCode(searchVO.schOption, 'HOUR,일(간) 시간대별,DAY_M,월(간) 일자별,DAY_W,월(간) 요일별,MONTH,년(간) 월별,YEAR,년(간) 전체', '')}"/>
		                  		${searchVO.schDateFrom} ${ufn:IIF(searchVO.schDateFrom eq searchVO.schDateEnd,'',endDateStr)}${titleStr} 접속통계
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
											<option value="HOUR" ${ufn:selected(searchVO.schOption, 'HOUR') }>시간별</option>
											<option value="DAY_M" ${ufn:selected(searchVO.schOption, 'DAY_M') }>일별</option>
											<option value="DAY_W" ${ufn:selected(searchVO.schOption, 'DAY_W') }>요일별</option>
											<option value="MONTH" ${ufn:selected(searchVO.schOption, 'MONTH') }>월별</option>
											<option value="YEAR" ${ufn:selected(searchVO.schOption, 'YEAR') }>년도별</option>
									</select>
									<div class="input-daterange input-group" id="datepicker">
									    <input type="text" class="form-control" name="start" readOnly value="${searchVO.schDateFrom}"/>
									    <span class="input-group-addon">~</span>
									    <input type="text" class="form-control" name="end" readOnly value="${searchVO.schDateEnd}"/>
									    <span class="input-group-btn"><button class="btn btn-primary" type="button" onclick="fn_search(); return false;">조회</button></span>
									</div>
									<span class="pull-right"><button class="btn btn-block btn-default" onclick="getExcel(); return false;"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button></span>
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
									<div class="nav-tabs-custom" style="box-shadow:none;margin-bottom:0;">
									<div class="tab-content" style="padding:0;">
										<div class="tab-pane active" id="dataChart">
											<div class="box box-info">
												<div class="box-header with-border">
													<h5>${searchVO.schDateFrom} ${ufn:IIF(searchVO.schDateFrom eq searchVO.schDateEnd,'',endDateStr)}${titleStr} 접속현황</h5>
												</div>
												<div class="box-body chart-responsive">
													<div class="chart" id="date-chart" style="position: relative; height: 300px; width: 100%;"></div>
												</div>
											</div>
											<div class="box box-primary">
												<div class="box-header with-border">
													<h5>접속 누적 차트</h5>
												</div>
												<div class="box-body chart-responsive">
													<div class="chart" id="total-chart" style="position: relative; height: 300px; width: 100%;"></div>
												</div>
											</div>
										</div>
										<div class="tab-pane" id="dataTable">
										    <table id="example1" class="table table-bordered">
										       	<colgroup>
												  	<col width="30%">
												  	<col width="30%">
												  	<col width="40%">
												</colgroup>
										        <thead>
													<tr>
														<th scope="col">
															${ufn:deCode(searchVO.schOption, 'HOUR,시간대,DAY_M,일,DAY_W,요일,MONTH,월,YEAR,년도', '')}
											            </th>
														<th scope="col">방문자합계</th>
														<th scope="col">누적 방문자수</th>
													</tr>
												</thead>
										        <tbody>
										        	<c:set var ="totcnt" value="0"/>
										        	<c:set var ="maxValue" value="0"/>
										        	<c:forEach var="result" items="${resultList}" varStatus="status">
										        		<c:set var ="maxValue" value="${maxValue < result.cntCount ? result.cntCount :maxValue}"/>
										        		<c:choose>
										        			<c:when test="${searchVO.schOption ne 'DAY_W'}"><c:set var ="date" value="${result.cntDate}" /></c:when>
										        			<c:otherwise><c:set var ="date" value="${result.etc}" /></c:otherwise>
										        		</c:choose>
										        		<c:choose>
											                <c:when test="${searchVO.schOption == 'YEAR'}"><c:set var ="maxEnd" value="${searchVO.schDateEnd}" /></c:when>
											            	<c:otherwise>
											            		<c:set var ="maxEnd" value="${ufn:deCode(searchVO.schOption, 'HOUR,23,DAY_M,31,DAY_W,7,MONTH,31','')}" />
											            	</c:otherwise>
											            </c:choose>
											            <!-- S : 결과 리스트에 없는 데이터 출력 : 앞부분 31 -->
															<c:if test="${searchVO.schOption ne 'YEAR'}">
												        		<c:if test="${status.count eq 1}">
												        			<c:set var ="begin" value="1"/>
												        			<c:if test="${searchVO.schOption eq 'HOUR'}">
																		<c:set var ="begin" value="0"/>
																	</c:if>
												        			<c:set var ="end" value="${date-1}"/>
												        			<c:if test="${end>=0}">
												        			<c:forEach var="i" begin="${begin}" end="${end}" step="1">
												        				<tr>
												        					<td class="tac">
												        						<c:choose>
													        						<c:when test="${searchVO.schOption eq 'HOUR'}">
													        							<c:if test="${i<10}">0</c:if><c:out value="${i} ~ " />
													        							<c:if test="${(i+1)<10}">0</c:if><c:out value="${i+1}" /></td>
													        						</c:when>
													        						<c:when test="${searchVO.schOption eq 'DAY_W'}">
													        							${ufn:deCode(i, '1,일요일,2,월요일,3,화요일,4,수요일,5,목요일,6,금요일,7,토요일', '')}
													        						</c:when>
													        						<c:otherwise>
													        							<c:if test="${i<10}">0</c:if><c:out value="${i}" /></td>
													        						</c:otherwise>
												        						</c:choose>
												        					</td>
												        					<td class="tac">0</td>
												        					<td class="tac"><c:out value="${totcnt}" /></td>
												        				</tr>
																	</c:forEach>
																	</c:if>
												        		</c:if>
												        		<c:if test="${status.count ne 1}">
												        			<c:set var ="end" value="${date-1}"/>
												        			<c:if test="${end>=0}">
												        			<c:forEach var="i" begin="${begin}" end="${end}" step="1">
												        				<tr>
												        					<td class="tac">
												        						<c:choose>
													        						<c:when test="${searchVO.schOption eq 'HOUR'}">
													        							<c:if test="${i<10}">0</c:if><c:out value="${i} ~ " />
													        							<c:if test="${(i+1)<10}">0</c:if><c:out value="${i+1}" /></td>
													        						</c:when>
													        						<c:when test="${searchVO.schOption eq 'DAY_W'}">
																						${ufn:deCode(i, '1,일요일,2,월요일,3,화요일,4,수요일,5,목요일,6,금요일,7,토요일', '')}
													        						</c:when>
													        						<c:otherwise>
													        							<c:if test="${i<10}">0</c:if><c:out value="${i}" /></td>
													        						</c:otherwise>
												        						</c:choose>
																			</td>
												        					<td class="tac">0</td><td class="tac"><c:out value="${totcnt}" /></td></tr>
																	</c:forEach>
																	</c:if>
												        		</c:if>
												        	</c:if>
														<!-- E : 결과 리스트에 없는 데이터 출력 : 앞부분 -->
											        	<!-- S : 결과 리스트-->
										        		<tr>
															<td class="tac">
																<c:choose>
																	<c:when test="${searchVO.schOption eq 'HOUR'}">
												        				<c:out value="${date} ~ " /><c:if test="${date<10}">0</c:if><c:out value="${date+1}" />
												        			</c:when>
												        			<c:when test="${searchVO.schOption eq 'DAY_W'}">
									        							${result.cntDate}
									        						</c:when>
												        			<c:otherwise>
												        				<c:out value="${date}" />
												        			</c:otherwise>
											        			</c:choose>
										        			</td>
															<td class="tac"><c:out value="${result.cntCount}" /></td>
															<c:set var ="totcnt" value="${totcnt+result.cntCount}"/>
															<td class="tac"><c:out value="${totcnt}" /></td>
															<%-- <td><c:out value="${ufn:strCalculator(totcnt, '+', result.cntCount)}"/></td> --%>
														</tr>
														<!-- E : 결과 리스트-->
														<!-- S : 결과 리스트에 없는 데이터 출력 : 뒷부분 -->
											        		<c:if test="${(date ne maxEnd) && (fn:length(resultList) eq status.count)}">
											        			<c:set var ="begin" value="${date+1}"/>
											        			<c:set var ="end" value="${maxEnd}"/>
											        			<c:forEach var="i" begin="${begin}" end="${end}" step="1">
											        				<tr><td class="tac"><c:choose>
													        						<c:when test="${searchVO.schOption eq 'HOUR'}">
													        							<c:if test="${i<10}">0</c:if><c:out value="${i} ~ " />
													        							<c:if test="${(i+1)<10}">0</c:if><c:out value="${i+1}" /></td>
													        						</c:when>
													        						<c:when test="${searchVO.schOption eq 'DAY_W'}">
													        							${ufn:deCode(i, '1,일요일,2,월요일,3,화요일,4,수요일,5,목요일,6,금요일,7,토요일', '')}
													        						</c:when>
													        						<c:otherwise>
													        							<c:if test="${i<10}">0</c:if><c:out value="${i}" /></td>
													        						</c:otherwise>
												        						</c:choose></td>
											        					<td class="tac">0</td>
											        					<td class="tac"><c:out value="${totcnt}" /></td>
											        				</tr>
																</c:forEach>
											        		</c:if>
											        		<c:set var ="begin" value="${date+1}"/>
										        		<!-- E : 결과 리스트에 없는 데이터 출력 : 뒷부분 -->
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
	 	if(schOpt == "HOUR"){
		 	$('#searchBox .input-daterange').datepicker({
		    	format: "yyyy-MM-dd",
		    	//startView: 1,
		    	//minViewMode: 1,
		    	endDate: "today",
		    	language: "kr",
		    	autoclose: true,
		    	todayHighlight: true
			});
	 	}else if(schOpt == "DAY_M"){
		 	$('#searchBox .input-daterange').datepicker({
		    	format: "yyyy-MM",
		    	endDate: "today",
		    	startView: 1,
		    	minViewMode: 1,
		    	language: "kr",
		    	autoclose: true,
		    	todayHighlight: true
			});
	 	}else if(schOpt == "DAY_W"){
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
		f.schDateFrom.value=f.start.value;
		f.schDateEnd.value=f.end.value;
		f.action = "/excel/mngrStatsTermExcelDown.do";
		f.method = "post";
	    f.submit();
    }

	 var dateData = [];
	    var totalData = [];
	    <c:set var="total" value="0"/>
	    	<c:forEach var="stat" items="${resultList}" varStatus="status">
	    		<c:choose>
					<c:when test="${searchVO.schOption ne 'DAY_W'}"><c:set var ="date" value="${stat.cntDate}" /></c:when>
					<c:otherwise><c:set var ="date" value="${stat.etc}" /></c:otherwise>
				</c:choose>
				<c:choose>
			    	<c:when test="${searchVO.schOption == 'HOUR'}"><c:set var ="maxEnd" value="23" /></c:when>
			        <c:when test="${searchVO.schOption == 'DAY_W'}"><c:set var ="maxEnd" value="7" /></c:when>
			        <c:when test="${searchVO.schOption == 'DAY_M'}"><c:set var ="maxEnd" value="31" /></c:when>
			        <c:when test="${searchVO.schOption == 'MONTH'}"><c:set var ="maxEnd" value="12" /></c:when>
			        <c:when test="${searchVO.schOption == 'YEAR'}"><c:set var ="maxEnd" value="${searchVO.schDateEnd}" /></c:when>
			    </c:choose>
			<c:if test="${status.count eq 1}">
			/* count eq 1  */
				<c:if test="${searchVO.schOption eq 'YEAR'}">
				/* option eq yeqr  */
					<c:set var ="begin" value="${searchVO.schDateFrom}"/>
				</c:if>
				<c:if test="${searchVO.schOption ne 'YEAR'}">
					<c:set var ="begin" value="1"/>
				</c:if>
				<c:set var ="end" value="${date-1}"/>
				<c:if test="${searchVO.schOption eq 'HOUR'}">
					<c:set var ="begin" value="0"/>
				</c:if>
				<c:if test="${end>=0}">
				<c:forEach var="i" begin="${begin}" end="${end}" step="1">
							<c:choose>
				<c:when test="${searchVO.schOption eq 'HOUR'}">
					dateData.push({"y" : "<c:if test='${i<10}'>0</c:if>${i}:00", "num" : "0"});
	   				totalData.push({"y" : "<c:if test='${i<10}'>0</c:if>${i}:00","total" : "${total}"});
				</c:when>
				<c:when test="${searchVO.schOption eq 'MONTH'}">
					dateData.push({"y" : "${i}월", "num" : "0"});
	    			totalData.push({"y" : "${i}월","total" : "${total}"});
				</c:when>
				<c:when test="${searchVO.schOption eq 'YEAR'}">
				dateData.push({"y" : "${i}년", "num" : "0"});
				totalData.push({"y" : "${i}년","total" : "${total}"});
				</c:when>
				<c:when test="${searchVO.schOption eq 'DAY_W'}">
					<c:choose>
						<c:when test="${i == 1}">
							dateData.push({"y" : "일요일", "num" : "0"});
			    			totalData.push({"y" : "일요일","total" : "${total}"});
						</c:when>
						<c:when test="${i == 2}">
							dateData.push({"y" : "월요일", "num" : "0"});
			    			totalData.push({"y" : "월요일","total" : "${total}"});
						</c:when>
						<c:when test="${i == 3}">
							dateData.push({"y" : "화요일", "num" : "0"});
			    			totalData.push({"y" : "화요일","total" : "${total}"});
						</c:when>
						<c:when test="${i == 4}">
							dateData.push({"y" : "수요일", "num" : "0"});
			    			totalData.push({"y" : "수요일","total" : "${total}"});
						</c:when>
						<c:when test="${i == 5}">
							dateData.push({"y" : "목요일", "num" : "0"});
			    			totalData.push({"y" : "목요일","total" : "${total}"});
						</c:when>
						<c:when test="${i == 6}">
							dateData.push({"y" : "금요일", "num" : "0"});
			    			totalData.push({"y" : "금요일","total" : "${total}"});
						</c:when>
						<c:when test="${i == 7}">
							dateData.push({"y" : "토요일", "num" : "0"});
			    			totalData.push({"y" : "토요일","total" : "${total}"});
						</c:when>
					</c:choose>
				</c:when>
				<c:otherwise>
					dateData.push({"y" : "${i}일", "num" : "0"});
					totalData.push({"y" : "${i}일","total" : "${total}"});
				</c:otherwise>
			</c:choose>
				</c:forEach>
				</c:if>
			</c:if>
			<c:if test="${status.count ne 1}">
				<c:set var ="end" value="${date-1}"/>
				<c:if test="${date>0}">
				<c:forEach var="i" begin="${begin}" end="${end}" step="1">
				<c:choose>
				<c:when test="${searchVO.schOption eq 'HOUR'}">
					dateData.push({"y" : "<c:if test='${i<10}'>0</c:if>${i}:00", "num" : "0"});
	   				totalData.push({"y" : "<c:if test='${i<10}'>0</c:if>${i}:00","total" : "${total}"});
				</c:when>
				<c:when test="${searchVO.schOption eq 'MONTH'}">
					dateData.push({"y" : "${i}월", "num" : "0"});
	    			totalData.push({"y" : "${i}월","total" : "${total}"});
				</c:when>
				<c:when test="${searchVO.schOption eq 'YEAR'}">
				dateData.push({"y" : "${i}년", "num" : "0"});
				totalData.push({"y" : "${i}년","total" : "${total}"});
				</c:when>
				<c:when test="${searchVO.schOption eq 'DAY_W'}">
				<c:choose>
					<c:when test="${i == 1}">
						dateData.push({"y" : "일요일", "num" : "0"});
		    			totalData.push({"y" : "일요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 2}">
						dateData.push({"y" : "월요일", "num" : "0"});
		    			totalData.push({"y" : "월요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 3}">
						dateData.push({"y" : "화요일", "num" : "0"});
		    			totalData.push({"y" : "화요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 4}">
						dateData.push({"y" : "수요일", "num" : "0"});
		    			totalData.push({"y" : "수요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 5}">
						dateData.push({"y" : "목요일", "num" : "0"});
		    			totalData.push({"y" : "목요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 6}">
						dateData.push({"y" : "금요일", "num" : "0"});
		    			totalData.push({"y" : "금요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 7}">
						dateData.push({"y" : "토요일", "num" : "0"});
		    			totalData.push({"y" : "토요일","total" : "${total}"});
					</c:when>
				</c:choose>
				</c:when>
				<c:otherwise>
					dateData.push({"y" : "${i}일", "num" : "0"});
					totalData.push({"y" : "${i}일","total" : "${total}"});
				</c:otherwise>
			</c:choose>
				</c:forEach>
				</c:if>
			</c:if>
			/* E : 결과 리스트에 없는 데이터 출력 : 앞부분  */
	   	 /* S : 결과 리스트 */
		<c:set var="total" value="${total+stat.cntCount}"/>
		<c:choose>
			<c:when test="${searchVO.schOption ne 'DAY_W'}"><c:set var ="date" value="${stat.cntDate}" /></c:when>
			<c:otherwise><c:set var ="date" value="${stat.etc}" /></c:otherwise>
		</c:choose>
		/* ${date} */
		<c:choose>
		<c:when test="${searchVO.schOption eq 'HOUR'}">
			dateData.push({"y" : "${date}:00", "num" : "${stat.cntCount}"});
			totalData.push({"y" : "${date}:00","total" : "${total}"});
		</c:when>
		<c:when test="${searchVO.schOption eq 'MONTH'}">
			dateData.push({"y" : "${stat.cntDate}월", "num" : "${stat.cntCount}"});
			totalData.push({"y" : "${stat.cntDate}월","total" : "${total}"});
		</c:when>
		<c:when test="${searchVO.schOption eq 'YEAR'}">
			dateData.push({"y" : "${stat.cntDate}년", "num" : "${stat.cntCount}"});
			totalData.push({"y" : "${stat.cntDate}년","total" : "${total}"});
		</c:when>
		<c:when test="${searchVO.schOption eq 'DAY_W'}">
			dateData.push({"y" : "${stat.cntDate}", "num" : "${stat.cntCount}"});
			totalData.push({"y" : "${stat.cntDate}","total" : "${total}"});
		</c:when>
		<c:otherwise>
			dateData.push({"y" : "${stat.cntDate}일", "num" : "${stat.cntCount}"});
			totalData.push({"y" : "${stat.cntDate}일","total" : "${total}"});
		</c:otherwise>
	</c:choose>
		 /* E : 결과 리스트 */
		/*  S : 결과 리스트에 없는 데이터 출력 : 뒷부분 */
			<c:if test="${(date ne maxEnd) && (fn:length(resultList ) eq status.count)}">
				<c:set var ="begin" value="${date+1}"/>
				<c:set var ="end" value="${maxEnd}"/>
				<c:forEach var="i" begin="${begin}" end="${end}" step="1">
				<c:choose>
				<c:when test="${searchVO.schOption eq 'HOUR'}">
					dateData.push({"y" : "<c:if test='${i<10}'>0</c:if>${i}:00", "num" : "0"});
	   				totalData.push({"y" : "<c:if test='${i<10}'>0</c:if>${i}:00","total" : "${total}"});
				</c:when>
				<c:when test="${searchVO.schOption eq 'MONTH'}">
					dateData.push({"y" : "${i}월", "num" : "0"});
	    			totalData.push({"y" : "${i}월","total" : "${total}"});
				</c:when>
				<c:when test="${searchVO.schOption eq 'YEAR'}">
				dateData.push({"y" : "${i}년", "num" : "0"});
				totalData.push({"y" : "${i}년","total" : "${total}"});
				</c:when>
				<c:when test="${searchVO.schOption eq 'DAY_W'}">
				<c:choose>
					<c:when test="${i == 1}">
						dateData.push({"y" : "일요일", "num" : "0"});
		    			totalData.push({"y" : "일요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 2}">
						dateData.push({"y" : "월요일", "num" : "0"});
		    			totalData.push({"y" : "월요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 3}">
						dateData.push({"y" : "화요일", "num" : "0"});
		    			totalData.push({"y" : "화요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 4}">
						dateData.push({"y" : "수요일", "num" : "0"});
		    			totalData.push({"y" : "수요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 5}">
						dateData.push({"y" : "목요일", "num" : "0"});
		    			totalData.push({"y" : "목요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 6}">
						dateData.push({"y" : "금요일", "num" : "0"});
		    			totalData.push({"y" : "금요일","total" : "${total}"});
					</c:when>
					<c:when test="${i == 7}">
						dateData.push({"y" : "토요일", "num" : "0"});
		    			totalData.push({"y" : "토요일","total" : "${total}"});
					</c:when>
				</c:choose>
				</c:when>
				<c:otherwise>
					dateData.push({"y" : "${i}일", "num" : "0"});
					totalData.push({"y" : "${i}일","total" : "${total}"});
				</c:otherwise>
			</c:choose>
				</c:forEach>
			</c:if>
			<c:set var ="begin" value="${date+1}"/>
				/* E : 결과 리스트에 없는 데이터 출력 : 뒷부분 */
		</c:forEach>

		var maxValue = "${maxValue}";
		if (dateData.length > 0) {
		    var dateBarChart = new Morris.Bar({
		      element: 'date-chart',
		      resize: true,
		      data: dateData,
		      xkey: 'y',
		      ykeys: ['num'],
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
		      hideHover: 'auto'
		    });
		} else {
			$('#date-chart').html("<h6 style='text-align:center;'>해당 사이트의 통계 데이터가 존재하지 않습니다.</h6>");
		}

		if (totalData.length > 0) {
		    var totalBarChart = new Morris.Bar({
		        element: 'total-chart',
		        resize: true,
		        data: totalData,
		        xkey: 'y',
		        ykeys: ['total'],
		        labels: ['누적'],
		        barColors: ['#3c8dbc'],
		        hideHover: 'auto'
		      });
		}else {
			$('#total-chart').html("<h6 style='text-align:center;'>해당 사이트의 통계 데이터가 존재하지 않습니다.</h6>");
		}
//]]>
</script>
