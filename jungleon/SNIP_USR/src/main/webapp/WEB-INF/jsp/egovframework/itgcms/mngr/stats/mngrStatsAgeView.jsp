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
	<!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            연령대 접속통계
            <!-- <small>관리자 회원 목록</small> -->
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="#">통계관리</a></li>
            <li class="active">연령대별 접속통계</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box box-primary">
		                <div class="box-header with-border">
		                  	<h3 class="box-title"><c:choose>
		                  		<c:when test="${searchVO.schOption == 'DAY_M'}">${searchVO.schDateFrom}월 ~ ${searchVO.schDateEnd}월 접속통계</c:when>
		                  		<c:when test="${searchVO.schOption == 'MONTH'}">${searchVO.schDateFrom}년 ~ ${searchVO.schDateEnd}년 접속통계</c:when>
		                  		<c:when test="${searchVO.schOption == 'YEAR'}">${searchVO.schDateFrom}년 ~ ${searchVO.schDateEnd}년 접속현황</c:when>
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
											<option value="DAY_M" ${ufn:selected(searchVO.schOption, 'DAY_M') }>일별</option>
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
										<div class="col-md-6" id="dataTable">
										    <table id="example1" class="table table-bordered">
										       	<colgroup>
												  	<col width="30%">
												  	<col width="30%">
												  	<col width="40%">
												</colgroup>
										        <thead>
													<tr>
														<th scope="col">연령대</th>
														<th scope="col">방문자 수</th>
														<th scope="col">누적 방문자수</th>
													</tr>
												</thead>
										        <tbody>
										        	<c:set var ="totcnt" value="0"/>
										        	<c:forEach var="result" items="${resultList}" varStatus="status">
										        		<c:set var="totcnt" value="${totcnt+result.num}"/>
										        		<tr onmouseenter="selectDonut('${status.index}')">
										        			<td class="tac">${result.ageGroup}</td>
										        			<td class="tac">${result.num}</td>
										        			<td class="tac">${totcnt}</td>
										        		</tr>
										        	</c:forEach>
													<c:if test="${fn:length(resultList ) == 0}">
														<tr><td colspan="3" class="tac">데이터가 없습니다.</td></tr>
													</c:if>
												</tbody>
										      </table>
											</div>
											<div class="col-md-6">
												<div class="chart" id="age-chart" style="position: relative; height: 300px; width: 100%;"></div>
											</div>
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
	 	if(schOpt == "DAY_M"){
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

	 	} else {
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
		f.action = "/excel/mngrStatsAgeExcelDown.do";
		f.method = "post";
	    f.submit();
    }


	 var ageData = [];
   	<c:forEach var="stat" items="${resultList}">
   		ageData.push({label : "${stat.ageGroup}", value:${stat.num}});
	</c:forEach>

	if (ageData.length > 0){
		var donut = new Morris.Donut({
			  element: 'age-chart',
			  resize: true,
			  colors: ["#3c8dbc", "#f56954", "#00a65a"],
			  data: ageData,
			  hideHover: 'auto'
			});

		function selectDonut(index){
			donut.select(index);
		}
	} else {
		$('#age-chart').html("<h6 style='text-align:center;'>해당 통계 데이터가 존재하지 않습니다.</h6>");
	}


//]]>
</script>

