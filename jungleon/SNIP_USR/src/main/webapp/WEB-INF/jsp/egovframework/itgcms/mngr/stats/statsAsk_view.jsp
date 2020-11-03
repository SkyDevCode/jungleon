<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="cct" uri="/WEB-INF/tlds/CreateCodeTag.tld" %>

        	<ul class="nav nav-tabs">
				<li class="active"><a href="javscript:void(0);">질의응답 통계</a></li>
				<li><a href="javascript:location.href='?schOpt1=USER'">이용자통계</a></li>
				<li><a href="javascript:location.href='?schOpt1=KB'">KB 등록 통계</a></li>
			</ul>
			<div class="row">
				<div class="col-md-12">
					<div class="box box-primary">
		                <div class="box-header with-border">
		                  	<h3 class="box-title">
		                  		<%-- <c:set var="endDateStr" value=" ~ ${searchVO.schDateEnd}"/>
		                  		${searchVO.schDateFrom} ${ufn:IIF(searchVO.schDateFrom eq searchVO.schDateEnd,'',endDateStr)}  --%>질의응답 통계
							</h3>
		                </div><!-- /.box-header -->
						<div class="box-body">
							<form name="listForm" method="get" onsubmit="fn_search(); return false;">
								<input type="hidden" name="schOpt1" value="${searchVO.schOpt1}" />
								<input type="hidden" name="schDateFrom" />
								<input type="hidden" name="schDateEnd" />
							<div class="row margin-bottom">
								<div class="col-sm-9 form-inline" id="searchBox">
									<label for="schOption" class="sr-only">검색조건</label>

									<cct:codeTag pidx="626" tagType="select" tagName="schOpt2" selectedValue="${ufn:isNull(searchVO.schOpt2, '')}" useNullOpt="전체" tagTitle="지역선택" className="form-control" tagId="schOpt2"/>

									<select name="schOpt4" id="schOpt4" class="form-control">
										<option value="" ${ufn:selected(searchMap.schOpt4, '') }>도서관 차수 전체</option>
										<option value="1차 도서관" ${ufn:selected(searchMap.schOpt4, '1차 도서관') }>1차 도서관</option>
										<option value="2차 도서관" ${ufn:selected(searchMap.schOpt4, '2차 도서관') }>2차 도서관</option>
										<option value="3차 도서관" ${ufn:selected(searchMap.schOpt4, '3차 도서관') }>3차 도서관</option>
									</select>

									<select name="schFld" id="schFld" class="form-control">
										<option value="1" ${ufn:selected(searchMap.schFld, '1') }>일별</option>
										<option value="2" ${ufn:selected(searchMap.schFld, '2') }>월별</option>
										<option value="3" ${ufn:selected(searchMap.schFld, '3') }>연도별</option>
									</select>

									<div class="input-daterange input-group input-sm schStr" id="schDtPeriod">
									    <input type="text" class="form-control" name="schDtFrom" id="schDtFrom" readOnly value="${searchVO.schDtFrom}" title=시작일" />
									    <span class="input-group-addon">~</span>
									    <input type="text" class="form-control" name="schDtEnd" id="schDtEnd" readOnly value="${searchVO.schDtEnd}" title=종료일"/>
									</div>

									<div class="input-daterange input-group schStr" id="schMonthPeriod">
									    <input type="text" class="form-control" name="start" readOnly value="${searchVO.schDateFrom}"/>
									    <span class="input-group-addon">~</span>
									    <input type="text" class="form-control" name="end" readOnly value="${searchVO.schDateEnd}"/>
									</div>

									<div class="input-daterange input-group schStr" id="schYear">
									    <input type="text" class="form-control" name="schYear" readOnly value="${searchVO.schYear}"/>
									</div>

									<button class="btn btn-primary" type="button" onclick="fn_search(); return false;">조회</button>
								</div>
								 <div class="col-sm-3 text-right">
									<button type="button" onclick="window.print();return false;" class="btn btn-warning">인쇄</button>
									<button type="button" onclick="getExcel(); return false;" class="btn btn-default"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button>
								</div>
							</div>
							</form>
						</div><!-- /.box-body -->
					</div>
					<div class="box">
						<div class="box-header with-border">
						</div>
						<div class="box-body">
							<div class="row">
								<div class="col-sm-12">
								    <table id="example1" class="table table-bordered">
								       	<colgroup>
										  	<col width="8%">
										  	<col width="8%">
										  	<col width="">
										  	<col width="15%">
										  	<col width="15%">
										</colgroup>
								        <thead>
											<tr>
												<th scope="col" rowspan="2">NO</th>
												<th scope="col" rowspan="2">지역</th>
												<th scope="col" rowspan="2">도서관명</th>
												<th scope="col" colspan="2">웹폼 통계</th>
											</tr>
											<tr>
												<th scope="col">접수 질문</th>
												<th scope="col">완료 답변</th>
											</tr>
										</thead>
								        <tbody>
								        	<c:set var="qtotcnt" value="0"/>
								        	<c:set var="atotcnt" value="0"/>
								        	<c:forEach var="result" items="${resultList}" varStatus="status">
								        		<c:set var="qtotcnt" value="${qtotcnt + result.qcnt}" />
								        		<c:set var="atotcnt" value="${atotcnt + result.acnt}" />
												<tr>
													<td class="tac">
														${status.count }
													</td>
													<td class="tac">
														${result.areaName }
													</td>
													<td class="tac">
														${result.libName }
													</td>
													<td class="tac">
														${result.qcnt }
													</td>
													<td class="tac">
														${result.acnt }
													</td>
												</tr>
								        	</c:forEach>
											<c:if test="${fn:length(resultList ) == 0}">
												<tr><td colspan="2" class="tac">데이터가 없습니다.</td></tr>
											</c:if>
											<c:if test="${fn:length(resultList ) != 0}">
									        	<tfoot>
													<tr>
														<th style="text-align: center;" colspan="2" id="locName"></th>
														<th style="text-align: center;">합계</th>
														<th style="text-align: center;">${qtotcnt }</th>
														<th style="text-align: center;">${atotcnt }</th>
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
		if($("#schFld").val() == '1'){
			f.schDateFrom.value="";
			f.schDateEnd.value="";
			f.schYear.value="";
		}else if($("#schFld").val() == '2'){
			f.schDateFrom.value=f.start.value;
			f.schDateEnd.value=f.end.value;
			f.schDtFrom.value="";
			f.schDtEnd.value="";
			f.schYear.value="";
		}else{
			f.schDtFrom.value="";
			f.schDtEnd.value="";
			f.schDateFrom.value="";
			f.schDateEnd.value="";
		}

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
	 	$('#schMonthPeriod').datepicker({
	    	format: "yyyy-MM",
	    	endDate: "today",
	    	startView: 1,
	    	minViewMode: 1,
	    	language: "kr",
	    	autoclose: true,
	    	todayHighlight: true
		});

	 	$('#schYear').datepicker({
	 		format: "yyyy",
	    	endDate: "today",
	    	startView: 2,
	    	minViewMode: 2,
	    	language: "kr",
	    	autoclose: true,
	    	todayHighlight: true
		});

	 	ItgJs.fn_datePickerRange("#schDtFrom", "#schDtEnd");

		$("#locName").text($("#schOpt2").children("option:selected").text());

		fn_setSchFld($("#schFld"));
		$("#schFld").change(function (){
			fn_setSchFld(this);
		});

		});

	function fn_setSchFld(obj) {
		$(".schStr").hide();
		if($(obj).val() == '1'){
			$("#schDtPeriod").show();
		}else if($(obj).val() == '2'){
			$("#schMonthPeriod").show();
		}else{
			$("#schYear").show();
		}
	}

	function getExcel(){

    	var f = document.listForm;
    	if($("#schFld").val() == '1'){
			f.schDateFrom.value="";
			f.schDateEnd.value="";
			f.schYear.value="";
		}else if($("#schFld").val() == '2'){
			f.schDateFrom.value=f.start.value;
			f.schDateEnd.value=f.end.value;
			f.schDtFrom.value="";
			f.schDtEnd.value="";
			f.schYear.value="";
		}else{
			f.schDtFrom.value="";
			f.schDtEnd.value="";
			f.schDateFrom.value="";
			f.schDateEnd.value="";
		}

		f.action = "/excel/mngrStatsAskExcelDown.do";
		f.method = "get";
	    f.submit();
    }
//]]>
</script>
