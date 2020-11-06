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
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.exedit-3.5.js"></script>

        	<ul class="nav nav-tabs">
				<li class="active" id="charttab"><a href="#dataChart" data-toggle="tab" aria-expanded="false" >차트</a></li>
				<li id="tabletab"><a href="#dataTable" data-toggle="tab" aria-expanded="true">표</a></li>
			</ul>
			<div class="row">
				<div class="col-xs-12">
					<div class="box box-primary">
		                <div class="box-header with-border">
		                  	<h3 class="box-title">게시판 통계</h3>
		                </div><!-- /.box-header -->
						<div class="box-body">
							<form name="listForm" method="post" onsubmit="fn_search(); return false;">
								<input type="hidden" name="schDateFrom" />
								<input type="hidden" name="schDateEnd" />
							<div class="row margin-bottom">
								<div class="col-sm-12 form-inline" id="searchBox">
									<label for="schOption" class="sr-only">검색조건</label>
									<select name="siteCode" id="siteCode" class="form-control">
										<c:forEach var="site" items="${siteList}">
											<option value="${site.siteCode}" <c:out value="${site.siteCode eq searchSite ? 'selected' : ''}"/>>${site.siteName}</option>
										</c:forEach>
									</select>
									<span class="pull-right"><button class="btn btn-block btn-default" onclick="getExcel();return false;"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button></span>
								</div>
							</div>
							</form>
							<hr/>
								<div class="col-sm-12">
									<div class="nav-tabs-custom" style="box-shadow:none;margin-bottom:0;">
									<div class="tab-content" style="padding:0;">
										<div class="tab-pane active" id="dataChart">
											<div class="row">
												<div class="col-md-6 col-xs-12">
													<div class="box box-success">
														<div class="box-header widt-border">
															게시글 수
														</div>
														<div class="box-body">
															<div class="chart" id="count-chart"  style="position: relative; height: <c:out value='${95 + fn:length(resultList)*30}'/>px; width: 100%; margin-top:30px; display: inline-block;"></div>
														</div>
													</div>
												</div>
												<div class="col-md-6 col-xs-12">
													<div class="box box-info">
														<div class="box-header widt-border">
															조회 수
														</div>
														<div class="box-body">
															<div class="chart" id="read-chart"  style="position: relative; height: <c:out value='${95 + fn:length(resultList)*30}'/>px; width: 100%; margin-top:30px; display: inline-block;"></div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="tab-pane" id="dataTable">
										    <table id="example1" class="table table-bordered">
										       	<colgroup>
										       		<col width="15%">
										       		<col width="15%">
										       		<col width="50%">
												  	<col width="10%">
												  	<col width="10%">
												</colgroup>
										        <thead>
													<tr>
														<th scope="col">게시판아이디</th>
														<th scope="col">게시판이름</th>
														<th scope="col">경로</th>
														<th scope="col">게시글<br/>합계</th>
														<th scope="col">조회수<br/>합계</th>
													</tr>
												</thead>
										        <tbody>
										        	<c:forEach var="result" items="${resultList}" varStatus="status">
											        	<!-- S : 결과 리스트-->
										        		<tr>
															<td><c:out value="${result.menuCode}" /></td>
															<td><a href="/${searchSite}/contents/${result.menuCode}.do" target="_blank"><c:out value="${result.menuName}" /></a></td>
															<td><c:out value="${result.menuPfullname}" /></td>
															<td class="tac"><c:out value="${result.countList}" /></td>
															<td class="tac"><c:out value="${result.sumReadNum}" /></td>
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
				</div><!-- /.box-body -->

<script type="text/javascript">
//<![CDATA[
    var queryString = "${searchVO.query}";

	function fn_search(){
		var tmpQuery = queryString;
		var f = document.listForm;
		f.action = "";
		f.submit();
	}

	function fn_barColor(row, series, type, maxValue){
		 if ((maxValue * 0.7) < row.y) {
      		  return "#f56954";
      	  } else if ((maxValue * 0.4) < row.y) {
      		  return "#00a65a";
      	  } else {
      		  return "#a0d0e0";
      	  }
	}

	$("#siteCode").change(function(){
		fn_search();
	});

	$(function() {
		$("#cnt").html('${totcnt}');
	});

	function getExcel(){
    	var f = document.listForm;
		f.action = "/excel/mngrStatsBoardExcelDown.do";
		f.method = "post";
	    f.submit();
    }

	var countList = [];
	var readNumList = [];
	<c:set var="maxCountList" value="0"/>
	<c:set var="maxSumReadNum" value="0"/>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		countList.push({y : "${result.menuName}",countList : "${result.countList}"});
		readNumList.push({y : "${result.menuName}",sumReadNum : "${result.sumReadNum}"});
		<c:if test="${maxCountList < result.countList}">
			<c:set var="maxCountList" value="${result.countList}"/>
		</c:if>
		<c:if test="${maxSumReadNum < result.sumReadNum}">
			<c:set var="maxSumReadNum" value="${result.sumReadNum}"/>
		</c:if>
	</c:forEach>

	var countBarChart = fn_barChart(countList, 'count-chart', 'y', ['countList'], ['게시글 수'], ${maxCountList});
	var readBarChart = fn_barChart(readNumList, 'read-chart', 'y', ['sumReadNum'], ['조회 수'], ${maxSumReadNum});

	function fn_barChart(data, target, xKey, yKey, label, maxValue){
		if (data.length == 0) {
			document.getElementById(target).innerHTML = "<h6 style='text-align:center;'>해당 통계 데이터가 존재하지 않습니다.</h6>";
			return null;
		} else {
			return new Morris.Bar({
			      element: target,
			      resize: true,
			      data: data,
			      xkey: xKey,
			      ykeys: yKey,
			      labels: label,
			      barColors : function (row, series, type) {
			    	  if ((maxValue * 0.7) < row.y) {
			       		  return "#f56954";
			       	  } else if ((maxValue * 0.4) < row.y) {
			       		  return "#00a65a";
			       	  } else {
			       		  return "#a0d0e0";
			       	  }
			      },
			      hideHover: 'auto',
			      xAxisTop : true,
			      xAxisTopPos : '10',
			      horizontal : true
		    });
		}
	}
//]]>
</script>
