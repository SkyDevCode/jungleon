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
				<li class="active"><a href="javascript:void(0)">이용자통계</a></li>
				<li><a href="javascript:location.href='?schOpt1=KB'">KB 등록 통계</a></li>
			</ul>
			<div class="row">
				<div class="col-md-12">
					<div class="box box-primary">
		                <div class="box-header with-border">
		                  	<h3 class="box-title">
		                  		<c:set var="endDateStr" value=" ~ ${searchVO.schDtEnd}"/>
		                  		${searchVO.schDtFrom} ${ufn:IIF(searchVO.schDtFrom eq searchVO.schDtEnd,'',endDateStr)} 이용자 통계
							</h3>
		                </div><!-- /.box-header -->
						<div class="box-body">
							<form name="listForm" method="get" onsubmit="fn_search(); return false;">
								<input type="hidden" name="schOpt1" value="${searchVO.schOpt1}" />
							<div class="row margin-bottom">
								<div class="col-sm-9 form-inline" id="searchBox">
									<label for="schOption" class="sr-only">검색조건</label>
									<select name="schOpt3" id="schOpt3" class="form-control">
<%-- 											<option value="AGE" ${ufn:selected(searchVO.schOpt3, 'AGE') }>나이</option> --%>
											<option value="SATIS" ${ufn:selected(searchVO.schOpt3, 'SATIS') }>만족도</option>
											<option value="GOAL" ${ufn:selected(searchVO.schOpt3, 'GOAL') }>질문목적</option>
									</select>
									<cct:codeTag pidx="626" tagType="select" tagName="schOpt2" selectedValue="${ufn:isNull(searchVO.schOpt2, '01')}" useNullOpt="전체" tagTitle="지역선택" className="form-control" tagId="schOpt2"/>
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
								       	<colgroup>
										  	<col width="8%">
										  	<col width="8%">
										  	<col width="">
										  	<col width="8%">
										  	<col width="8%">
										  	<col width="8%">
										  	<col width="8%">
											<c:choose>
												<c:when test="${searchVO.schOpt3 eq 'AGE' }">
													<col width="8%">
													<col width="8%">
												</c:when>
												<c:when test="${searchVO.schOpt3 eq 'SATIS' }">
													<col width="8%">
												</c:when>
											</c:choose>
											<col width="10%">
										</colgroup>
								        <thead>
											<tr>
												<th scope="col" rowspan="2">NO</th>
												<th scope="col" rowspan="2">지역</th>
												<th scope="col" rowspan="2">도서관명</th>
												<c:choose>
													<c:when test="${searchVO.schOpt3 eq 'AGE' }">
														<th scope="col" colspan="5">나이 분류</th>
													</c:when>
													<c:when test="${searchVO.schOpt3 eq 'SATIS' }">
														<th scope="col" colspan="6">만족도 분류</th>
													</c:when>
													<c:when test="${searchVO.schOpt3 eq 'GOAL' }">
														<th scope="col" colspan="4">질문목적 분류</th>
													</c:when>
												</c:choose>
												<th scope="col" rowspan="2">합계</th>
											</tr>
											<tr>
												<c:choose>
													<c:when test="${searchVO.schOpt3 eq 'AGE' }">
														<th scope="col">13세 이하</th>
														<th scope="col">14세 ~ 19세</th>
														<th scope="col">20대 ~ 30대</th>
														<th scope="col">40대 ~ 50대</th>
														<th scope="col">60대 이상</th>
													</c:when>
													<c:when test="${searchVO.schOpt3 eq 'SATIS' }">
														<th scope="col">매우만족</th>
														<th scope="col">만족</th>
														<th scope="col">보통</th>
														<th scope="col">부족</th>
														<th scope="col">매우부족</th>
														<th scope="col">무응답</th>
													</c:when>
													<c:when test="${searchVO.schOpt3 eq 'GOAL' }">
														<th scope="col">일반적인관심/취미</th>
														<th scope="col">연구과제</th>
														<th scope="col">업무수행</th>
														<th scope="col">기타</th>
													</c:when>
												</c:choose>
											</tr>
										</thead>
								        <tbody>
								        	<c:set var="val1" value="0"/>
								        	<c:set var="val2" value="0"/>
								        	<c:set var="val3" value="0"/>
								        	<c:set var="val4" value="0"/>
								        	<c:set var="val5" value="0"/>
								        	<c:set var="val6" value="0"/>
								        	<c:set var="valTot" value="0"/>
								        	<c:forEach var="result" items="${resultList}" varStatus="status">
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
												<c:choose>
													<c:when test="${searchVO.schOpt3 eq 'AGE' }">
														<td class="tac">
														<c:set var="val1" value="${val1 + result.old13 }"/>
														${result.old13 }
														</td>
														<td class="tac">
														<c:set var="val2" value="${val2 + result.old14 }"/>
														${result.old14 }
														</td>
														<td class="tac">
														<c:set var="val3" value="${val3 + result.old20 }"/>
														${result.old20 }
														</td>
														<td class="tac">
														<c:set var="val4" value="${val4 + result.old40 }"/>
														${result.old40 }
														</td>
														<td class="tac">
														<c:set var="val5" value="${val5 + result.old60 }"/>
														${result.old60 }
														</td>
													</c:when>
													<c:when test="${searchVO.schOpt3 eq 'SATIS' }">
														<td class="tac">
														<c:set var="val1" value="${val1 + result.cnt01 }"/>
														${result.cnt01 }
														</td>
														<td class="tac">
														<c:set var="val2" value="${val2 + result.cnt02 }"/>
														${result.cnt02 }
														</td>
														<td class="tac">
														<c:set var="val3" value="${val3 + result.cnt03 }"/>
														${result.cnt03 }
														</td>
														<td class="tac">
														<c:set var="val4" value="${val4 + result.cnt04 }"/>
														${result.cnt04 }
														</td>
														<td class="tac">
														<c:set var="val5" value="${val5 + result.cnt05 }"/>
														${result.cnt05 }
														</td>
														<td class="tac">
														<c:set var="val6" value="${val6 + result.cnt06 }"/>
														${result.cnt06 }
														</td>
													</c:when>
													<c:when test="${searchVO.schOpt3 eq 'GOAL' }">
														<td class="tac">
														<c:set var="val1" value="${val1 + result.cnt01 }"/>
														${result.cnt01 }
														</td>
														<td class="tac">
														<c:set var="val2" value="${val2 + result.cnt02 }"/>
														${result.cnt02 }
														</td>
														<td class="tac">
														<c:set var="val3" value="${val3 + result.cnt03 }"/>
														${result.cnt03 }
														</td>
														<td class="tac">
														<c:set var="val4" value="${val4 + result.cnt00 }"/>
														${result.cnt00 }
														</td>
													</c:when>
												</c:choose>
													<td class="tac">
														<c:set var="valTot" value="${valTot + result.cntTotal }"/>
														${result.cntTotal }
													</td>
												</tr>
								        	</c:forEach>
											<c:if test="${fn:length(resultList ) == 0}">
											<c:choose>
													<c:when test="${searchVO.schOpt3 eq 'AGE' }">
														<c:set var="cols" value="5"/>
													</c:when>
													<c:when test="${searchVO.schOpt3 eq 'SATIS' }">
														<c:set var="cols" value="6"/>
													</c:when>
													<c:when test="${searchVO.schOpt3 eq 'GOAL' }">
														<c:set var="cols" value="4"/>
													</c:when>
											</c:choose>
												<tr><td colspan="${cols }" class="tac">데이터가 없습니다.</td></tr>
											</c:if>
											<c:if test="${fn:length(resultList ) != 0}">
									        	<tfoot>
													<tr>
														<th style="text-align: center;" colspan="2" id="locName"></th>
														<th style="text-align: center;">합계</th>
												<c:choose>
													<c:when test="${searchVO.schOpt3 eq 'AGE' }">
														<th style="text-align: center;">${val1 }</th>
														<th style="text-align: center;">${val2 }</th>
														<th style="text-align: center;">${val3 }</th>
														<th style="text-align: center;">${val4 }</th>
														<th style="text-align: center;">${val5 }</th>
													</c:when>
													<c:when test="${searchVO.schOpt3 eq 'SATIS' }">
														<th style="text-align: center;">${val1 }</th>
														<th style="text-align: center;">${val2 }</th>
														<th style="text-align: center;">${val3 }</th>
														<th style="text-align: center;">${val4 }</th>
														<th style="text-align: center;">${val5 }</th>
														<th style="text-align: center;">${val6 }</th>
													</c:when>
													<c:when test="${searchVO.schOpt3 eq 'GOAL' }">
														<th style="text-align: center;">${val1 }</th>
														<th style="text-align: center;">${val2 }</th>
														<th style="text-align: center;">${val3 }</th>
														<th style="text-align: center;">${val4 }</th>
													</c:when>
												</c:choose>
														<th style="text-align: center;">${valTot }</th>
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
		f.action = "";
		f.submit();
	}

	$( "#schOption" ).change(function() {
		var f = document.listForm;
		f.schDtFrom.value="";
		f.schDtEnd.value="";
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
		f.action = "/excel/mngrStatsAskUserExcelDown.do";
		f.method = "get";
	    f.submit();
    }
//]]>
</script>
