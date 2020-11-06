<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>

			<div class="row">
				<div class="col-md-12">
					<div class="box box-primary">
		                <div class="box-header with-border">
		                  	<h3 class="box-title">
		                  		<c:set var="endDateStr" value=" ~ ${searchVO.schDateEnd}"/>
		                  		<c:set var="titleStr" value="${ufn:deCode(searchVO.schOption, 'DAY_M,월(간) 일자별,MONTH,년(간) 월별,YEAR,년(간) 전체,STATUS, 상태별,USER, 이용자별', '')}"/>
		                  		${searchVO.schDateFrom} ${ufn:IIF(searchVO.schDateFrom eq searchVO.schDateEnd,'',endDateStr)}${titleStr} 견학 통계
							</h3>
		                </div><!-- /.box-header -->
						<div class="box-body">
							<form name="listForm" method="post" onsubmit="fn_search(); return false;">
								<input type="hidden" name="schDateFrom" />
								<input type="hidden" name="schDateEnd" />
							<div class="row margin-bottom">
								<div class="col-sm-12 form-inline" id="searchBox">
									<label for="schOption" class="sr-only">검색조건</label>
									<select name="schOption" id="schOption" class="form-control">
											<option value="DAY_M" ${ufn:selected(searchVO.schOption, 'DAY_M') }>일별</option>
											<option value="MONTH" ${ufn:selected(searchVO.schOption, 'MONTH') }>월별</option>
											<option value="YEAR" ${ufn:selected(searchVO.schOption, 'YEAR') }>년도별</option>
											<option value="STATUS" ${ufn:selected(searchVO.schOption, 'STATUS') }>상태별</option>
											<option value="USER" ${ufn:selected(searchVO.schOption, 'USER') }>이용자별</option> 
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
							<span><i class="fa fa-circle-o text-light-orange"></i> 기간 내 방문자 총 <i id="cnt"></i> 명 <c:if test="${searchVO.schOption ne 'STATUS' }">(※상태 승인 기준 방문자 통계 입니다.)</c:if> </span>
							<span class="pull-right">(단위 : 명)</span>
						</div>
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
												<th scope="col">${ufn:deCode(searchVO.schOption, 'STATUS,상태,USER,이용자', '기간')}</th>
												<th scope="col">이용수</th>
											</tr>
										</thead>
								        <tbody>
								        	<c:set var="totcnt" value="0"/>
								        	<c:forEach var="result" items="${resultList}" varStatus="status">
								        		<c:set var="totcnt" value="${totcnt + result.cCount}" />
												<tr>
													<td class="tac">
														<c:choose>
															<c:when test="${searchVO.schOption eq 'DAY_M' }">
																${result.cDay }
															</c:when>
															<c:when test="${searchVO.schOption eq 'MONTH' }">
																${result.cMonth }
															</c:when>
															<c:when test="${searchVO.schOption eq 'YEAR' }">
																${result.cYear }
															</c:when>
															<c:when test="${searchVO.schOption eq 'STATUS' }">
																${result.cStatus }
															</c:when>
															<c:when test="${searchVO.schOption eq 'USER' }">
																${result.cUser }
															</c:when>	
														</c:choose>
													</td>
													<td class="tac">
														${result.cCount }
													</td>
												</tr>
								        	</c:forEach>
											<c:if test="${fn:length(resultList ) == 0}">
												<tr><td colspan="2" class="tac">데이터가 없습니다.</td></tr>
											</c:if>
											<c:if test="${fn:length(resultList ) != 0}">
									        	<tfoot>
													<tr>
														<th style="text-align: center;">총합계</th>
														<th style="text-align: center;">${totcnt }</th>
													</tr>
												</tfoot>
											</c:if>											
										</tbody>
								      </table>
								  </div> <!-- .col-sm-12 -->
								</div> <!--  .row -->
						</div> <!-- /box-body -->
					</div> <!-- /box -->
				</div> <!-- /col -->
			</div> <!-- /row -->

<script type="text/javascript">
//<![CDATA[

	function fn_search(){
		var f = document.listForm;
		f.schDateFrom.value=f.start.value;
		f.schDateEnd.value=f.end.value;
		f.action = "";
		f.submit();
	}

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
	 	if(schOpt == "DAY_M" || schOpt == "STATUS" || schOpt == "USER"){
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
		f.action = "/excel/mngrStatsObserveExcelDown.do";
		f.method = "post";
	    f.submit();
    }
//]]>
</script>
