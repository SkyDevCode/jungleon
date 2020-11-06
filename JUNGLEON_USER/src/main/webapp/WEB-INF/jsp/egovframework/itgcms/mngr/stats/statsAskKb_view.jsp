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
				<li><a href="javascript:location.href='?schOpt1=ASK'">질의응답 통계</a></li>
				<li><a href="javascript:location.href='?schOpt1=USER'">이용자통계</a></li>
				<li class="active"><a href="javascript:location.href='?schOpt1=KB'">KB 등록 통계</a></li>
			</ul>
			<div class="row">
				<div class="col-md-12">
					<div class="box box-primary">
		                <div class="box-header with-border">
		                  	<h3 class="box-title">
		                  		<c:set var="endDateStr" value=" ~ ${searchVO.schDtEnd}"/>
		                  		${searchVO.schDtFrom} ${ufn:IIF(searchVO.schDtFrom eq searchVO.schDtEnd,'',endDateStr)} KB등록 통계
							</h3>
		                </div><!-- /.box-header -->
						<div class="box-body">
							<form name="listForm" method="get" onsubmit="fn_search(); return false;">
								<input type="hidden" name="schOpt1" value="${searchVO.schOpt1}" />
							<div class="row margin-bottom">
								<div class="col-sm-9 form-inline" id="searchBox">
									<div class="input-daterange input-group" id="datepicker">
									    <input type="text" class="form-control" name="schDtFrom" id="schDtFrom" readOnly value="${searchVO.schDtFrom}"/>
									    <span class="input-group-addon">~</span>
									    <input type="text" class="form-control" name="schDtEnd" id="schDtEnd" readOnly value="${searchVO.schDtEnd}"/>
									    <span class="input-group-btn"><button class="btn btn-primary" type="button" onclick="fn_search(); return false;">조회</button></span>
									</div>
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
								        <thead>
											<tr>
												<th scope="col">주제</th>
												<th scope="col">총류</th>
												<th scope="col">철학</th>
												<th scope="col">종교</th>
												<th scope="col">사회과학</th>
												<th scope="col">자연과학</th>
												<th scope="col">기술과학</th>
												<th scope="col">예술</th>
												<th scope="col">언어</th>
												<th scope="col">문학</th>
												<th scope="col">역사</th>
												<th scope="col">합계</th>
											</tr>
										</thead>
								        <tbody>
								        	<c:forEach var="result" items="${resultList}" varStatus="status">
								        		<c:set var="totCnt" value="0" />
												<tr>
													<td class="tac">
														합계
													</td>
													<td class="tac">
														${result.cnt00 }
													</td>
													<td class="tac">
														${result.cnt01 }
													</td>
													<td class="tac">
														${result.cnt02 }
													</td>
													<td class="tac">
														${result.cnt03 }
													</td>
													<td class="tac">
														${result.cnt04 }
													</td>
													<td class="tac">
														${result.cnt05 }
													</td>
													<td class="tac">
														${result.cnt06 }
													</td>
													<td class="tac">
														${result.cnt07 }
													</td>
													<td class="tac">
														${result.cnt08 }
													</td>
													<td class="tac">
														${result.cnt09 }
													</td>
													<td class="tac">
														${result.cnt00 + result.cnt01 + result.cnt02 + result.cnt03 + result.cnt04 + result.cnt05 + result.cnt06 + result.cnt07 + result.cnt08 + result.cnt09 }
													</td>
												</tr>
								        	</c:forEach>
											<c:if test="${fn:length(resultList ) == 0}">
												<tr><td colspan="12" class="tac">데이터가 없습니다.</td></tr>
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
		f.action = "";
		f.submit();
	}

	$( "#schOption" ).change(function() {
		var f = document.listForm;
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
	 	ItgJs.fn_datePickerRange("#schDtFrom", "#schDtEnd");

		$("#locName").text($("#schOpt2").children("option:selected").text());
	});

	function getExcel(){
    	var f = document.listForm;
		f.action = "/excel/mngrStatsAskKbExcelDown.do";
		f.method = "get";
	    f.submit();
    }
//]]>
</script>
