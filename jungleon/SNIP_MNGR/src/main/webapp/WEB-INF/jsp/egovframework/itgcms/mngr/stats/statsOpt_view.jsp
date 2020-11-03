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
 * @파일명 : mngrStatsOptView.jsp
 * @파일정보 : 통계관리 옵션별 접속통계 뷰
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
			<div class="row">
				<div class="col-md-12">
					<div class="box box-primary">
		                <div class="box-header with-border">
		                  	<h3 class="box-title"><%-- ${searchVO.schDateFrom} ~ ${searchVO.schDateEnd} --%>
		                  	<c:choose>
		                  		<c:when test="${searchVO.schOption == 'DEVICE'}"> 단말기 접속통계</c:when>
		                  		<c:when test="${searchVO.schOption == 'OS'}"> 운영체제 접속통계</c:when>
		                  		<c:when test="${searchVO.schOption == 'BROWSER'}"> 브라우저 접속통계</c:when>
		                  		<c:when test="${searchVO.schOption == 'SEARCHENGINE'}"> 검색엔진 접속통계</c:when>
		                  	</c:choose></h3>
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
												<option value="BROWSER" ${ufn:selected(searchVO.schOption, 'BROWSER') }>브라우저</option>
												<option value="OS" ${ufn:selected(searchVO.schOption, 'OS') }>운영체제</option>
												<option value="DEVICE" ${ufn:selected(searchVO.schOption, 'DEVICE') }>단말기</option>
												<%-- <option value="SEARCHENGINE" ${ufn:selected(searchVO.schOption, 'SEARCHENGINE') }>검색엔진</option> --%>
										</select>
										<span class="pull-right"><button class="btn btn-block btn-default" onclick="getExcel();return false;"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button></span>
	<%-- 									<div class="input-daterange input-group" id="datepicker">
										    <input type="text" class="form-control" name="start" readOnly value="${searchVO.schDateFrom}"/>
										    <span class="input-group-addon">~</span>
										    <input type="text" class="form-control" name="end" readOnly value="${searchVO.schDateEnd}"/>
										    <span class="input-group-btn"><button class="btn btn-primary" type="button" onclick="fn_search();">조회</button></span>
										</div> --%>
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
								<div class="col-sm-12 col-md-6">
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
								                  		<c:when test="${searchVO.schOption == 'BROWSER'}">브라우저</c:when>
								                  		<%-- <c:when test="${searchVO.schOption == 'DAY_W'}"><c:out value="${result.cntDay}" /></c:when> --%>
								                  		<c:when test="${searchVO.schOption == 'OS'}">운영체제</c:when>
								                  		<c:when test="${searchVO.schOption == 'DEVICE'}">단말기</c:when>
								                  		<c:when test="${searchVO.schOption == 'SEARCHENGINE'}">검색엔진</c:when>
										            </c:choose>
									            </th>
												<th scope="col">방문자합계</th>
												<th scope="col">누적 방문자수</th>
											</tr>
										</thead>
								        <tbody>
								        	<c:set var ="totcnt" value="0"/>
								        	<c:forEach var="result" items="${resultList}" varStatus="status">
									        	<!-- S : 결과 리스트-->
								        		<tr onmouseenter="selectDonut('${status.index}')">
													<td><c:out value="${result.cntName}" /></td>
													<td class="tac"><c:out value="${result.cntCount}" /></td>
													<c:set var ="totcnt" value="${totcnt+result.cntCount}"/>
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
								  </div> <!-- .col-sm-12 col-md-6 -->
								  <div class="col-sm-12 col-md-6">
								  	<div class="box-body chart-responsive">
										<div class="chart" id="option-chart" style="position: relative; height: 350px; width: 100%;"></div>
									</div>
								  </div> <!-- .col-sm-12 col-md-6 -->
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
		f.action = "";
		f.submit();
/* 		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schOption", f.schOption.value);

		location.href="?" + tmpQuery; */
	}

	$("#siteCode").change(function(){
		fn_search();
	});

	$( "#schOption" ).change(function() {
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
		f.action = "/excel/mngrStatsOptExcelDown.do";
		f.method = "post";
	    f.submit();
    }

	  var optionData = [];
	    <c:forEach var="result" items="${resultList}" varStatus="status">
			optionData.push({"label" : "<c:out value='${fn:substring(result.cntName, 0, 10)}' />", "value" : "<c:out value='${result.cntCount}' />" });
		</c:forEach>
		if (optionData.length > 0){
			var donut = new Morris.Donut({
				  element: 'option-chart',
				  resize: true,
				  colors: ["#3c8dbc", "#f56954", "#00a65a"],
				  data: optionData,
				  hideHover: 'auto'
				});
			function selectDonut(index){
				donut.select(index);
			}
		} else {
			$('#option-chart').html("<h6 style='text-align:center;'>해당 사이트의 통계 데이터가 존재하지 않습니다.</h6>");
		}
//]]>
</script>
