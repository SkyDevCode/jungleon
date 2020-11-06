
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%
/**
 * @파일명 : mngrMainIndex.jsp
 * @파일정보 : 관리자  메인
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 9. 4. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Main content -->
        <section class="content">
          <!-- Small boxes (Stat box) -->
          <div class="row">
            <div class="col-lg-4 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-green">
                <div class="inner">
                  <h3><fmt:formatNumber value="${todayVisitCount }" type="number" /></h3>
                  <p>오늘 방문자 수</p>
                </div>
                <div class="icon">
                  <i class="ion ion-stats-bars"></i>
                </div>
                <!-- 날짜별접속통계로 연결 -->
                <a href="/_mngr_/stats/statsDate_view.do?schOption=HOUR" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
              </div>
            </div><!-- ./col -->
            <div class="col-lg-4 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-yellow">
                <div class="inner">
                  <h3><fmt:formatNumber value="${monthVisitCount }" type="number" /></h3>
                  <p>이번 달 방문자 수</p>
                </div>
                <div class="icon">
                  <i class="ion ion-ios-paper"></i>
                </div>
                <a href="/_mngr_/stats/statsDate_view.do?schOption=DAY_M" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
              </div>
            </div><!-- ./col -->
            <div class="col-lg-4 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-red">
                <div class="inner">
                  <h3><fmt:formatNumber value="${totalVisitCount }" type="number" /></h3>
                  <p>총 방문자 수</p>
                </div>
                <div class="icon">
                  <i class="ion ion-pie-graph"></i>
                </div>
                <a href="/_mngr_/stats/statsDate_view.do?schOption=YEAR" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
              </div>
            </div><!-- ./col -->
          </div><!-- /.row -->
          <!-- Main row -->
          <div class="row">
<c:if test="${mngrSessionVO.currSiteCode ne 'SYSTEM'}">
          	<!-- left col -->
   <c:choose>
   		<c:when test="${mngrSessionVO.currSiteCode ne 'NE'}">
             <section class="col-lg-6 connectedSortable">
	             <div class="nav-tabs-custom">
	                <!-- Tabs within a box -->
	                <ul class="nav nav-tabs pull-right">
	                  <li class="active"><a href="#recent-bbs" data-toggle="tab">최근 글</a></li>
	                  <li class="pull-left header"><i class="fa fa-inbox"></i> 게시판</li>
	                </ul>
	                <div class="tab-content no-padding" style="min-height: 360px;">
	                	<div id="recent-bbs" class="box" style="border-top: none; border: none !important;box-shadow:none;">
	                		<div class="box-body" style="padding:20px;">
			                  <table class="table table-bordered tp2">
			                  	<colgroup>
			                  		<col style="width:20%;"/>
			                  		<col/>
			                  		<col style="width:20%;"/>
			                  		<col style="width:15%;"/>
			                  		<col style="width:13%;"/>
			                  	</colgroup>
			                  	<thead>
			                  		<tr>
			                  			<th class="t">게시판명</th>
			                  			<th class="t">제목</th>
			                  			<th class="t">작성자</th>
			                  			<th class="t">작성일</th>
			                  			<th class="t">조회수</th>
			                  		</tr>
			                  	</thead>
			                  	<c:forEach items="${recentlyBoard}" var="board">
			                  		<tr>
			                  			<td>${ufn:cutString(board.etc2, 12, '...')}
			                  			</td>
			                  			<td>
			                  				<%-- ${ufn:newTag(board.regdt, '<span class=\"label label-danger\">n</span>&nbsp;&nbsp;&nbsp;')} --%>
<a href="/_mngr_/board/${board.etc1}_view_${board.bcId}.do?schM=view&id=${board.bdIdx}">${ufn:cutString(board.bdTitle, 26, '...')}</a>
			                  			</td>
			                  			<td class="tac">${ufn:cutString(board.bdWriter, 12, '...')}</td>
			                  			<td class="tac">${ufn:printDatePattern(board.regdt, 'yyyy-MM-dd')}</td>
			                  			<td class="tac">${board.bdReadnum}</td>
			                  		</tr>
			                  	</c:forEach>
			                  </table>
		                 </div>
	                  </div>
	                </div>
	              </div><!-- /.nav-tabs-custom -->
            </section><!-- left col -->
   		</c:when>
   		<c:otherwise>
   			<section class="col-lg-6 connectedSortable">
	             <div class="nav-tabs-custom">
	                <!-- Tabs within a box -->
	                <ul class="nav nav-tabs pull-right">
	                  <li class="active"><a href="#recent-bbs" data-toggle="tab">최근 글</a></li>
	                  <li class="pull-left header"><i class="fa fa-inbox"></i> 게시판</li>
	                </ul>
	                <div class="tab-content no-padding" style="min-height: 360px;">
	                	<div id="recent-bbs" class="box" style="border-top: none; border: none !important;box-shadow:none;">
	                		<div class="box-body" style="padding:20px;">
			                  <table class="table table-bordered tp2">
			                  	<colgroup>
			                  		<col style="width:20%;"/>
			                  		<col/>
			                  		<col style="width:20%;"/>
			                  		<col style="width:15%;"/>
			                  		<col style="width:13%;"/>
			                  	</colgroup>
			                  	<thead>
			                  		<tr>
			                  			<th class="t">게시판명</th>
			                  			<th class="t">제목</th>
			                  			<th class="t">작성자</th>
			                  			<th class="t">작성일</th>
			                  			<th class="t">조회수</th>
			                  		</tr>
			                  	</thead>
			                  	<c:forEach items="${recentlyBoard}" var="board">
			                  		<tr>
			                  			<td>${ufn:cutString(board.etc2, 12, '...')}
			                  			</td>
			                  			<td>
			                  				<%-- ${ufn:newTag(board.regdt, '<span class=\"label label-danger\">n</span>&nbsp;&nbsp;&nbsp;')} --%>
<a href="/_mngr_/board/${board.etc1}_view_${board.bcId}.do?schM=view&id=${board.bdIdx}">${ufn:cutString(board.bdExt3, 26, '...')}</a>
			                  			</td>
			                  			<td class="tac">${ufn:cutString(board.bdWriter, 12, '...')}</td>
			                  			<td class="tac">${ufn:printDatePattern(board.regdt, 'yyyy-MM-dd')}</td>
			                  			<td class="tac">${board.bdReadnum}</td>
			                  		</tr>
			                  	</c:forEach>
			                  </table>
		                 </div>
	                  </div>
	                </div>
	              </div><!-- /.nav-tabs-custom -->
            </section><!-- left col -->
   		</c:otherwise>
   </c:choose>
</c:if>
            <!-- right col -->
            <section class="col-lg-6 connectedSortable">
              <!-- Custom tabs (Charts with tabs)-->
              <div class="nav-tabs-custom">
                <!-- Tabs within a box -->
                <ul class="nav nav-tabs pull-right">
                  <li class="active"><a href="#visit-chart" data-toggle="tab">방문자수</a></li>
                  <li class="pull-left header"><i class="fa fa-inbox"></i> 접속통계</li>
                </ul>
                <div class="tab-content no-padding" style="min-height: ${ufn:deCode(mngrSessionVO.currSiteCode,'SYSTEM,622','360')}px;">
                  <!-- Morris chart - Sales -->
                  <div class="chart tab-pane active" id="visit-chart" style="position: relative; min-height: ${ufn:deCode(mngrSessionVO.currSiteCode,'SYSTEM,612','350')}px;"></div>
                </div>
              </div><!-- /.nav-tabs-custom -->
            </section><!-- /.right col -->
            <!-- right col (We are only adding the ID to make the widgets sortable)-->

          	<!-- Left col -->
          	<section class="col-lg-6 connectedSortable">
              <!-- Custom tabs (Charts with tabs)-->
              <div class="nav-tabs-custom">
                <!-- Tabs within a box -->
                <ul class="nav nav-tabs pull-right">
                  <li class="active"><a href="#sales-chart" data-toggle="tab">브라우저별</a></li>
                  <li class="pull-left header"><i class="fa fa-inbox"></i> 접속통계</li>
                </ul>
                <div class="tab-content no-padding" style="min-height:280px;">
                  <!-- Morris chart - Sales -->
                  <div class="chart tab-pane active" id="sales-chart" style="position: relative; height: 260px;"></div>
                </div>
              </div><!-- /.nav-tabs-custom -->
            </section><!-- /.Left col -->

            <!-- right col -->
            <section class="col-lg-6 connectedSortable">
              <!-- Custom tabs (Charts with tabs)-->
              <div class="nav-tabs-custom">
                <!-- Tabs within a box -->
                <ul class="nav nav-tabs pull-right">
                  <li class="active"><a href="#sales-chart2" data-toggle="tab">디바이스별</a></li>
                  <li class="pull-left header"><i class="fa fa-inbox"></i> 접속통계</li>
                </ul>
                <div class="tab-content no-padding" style="min-height:280px;">
                  <!-- Morris chart - Sales -->
                  <div class="chart tab-pane active" id="sales-chart2" style="position: relative; height: 260px;"></div>
                </div>
              </div><!-- /.nav-tabs-custom -->
            </section><!-- /.right col -->

          </div><!-- /.row (main row) -->

        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->


<c:set var="initDate" value="${resultList[0].etc}"/>
<fmt:parseDate var="dateString" value="${initDate}" pattern="yyyy-MM-dd HH" />

<%-- <fmt:formatDate value="${initDate}" pattern="yyyy-MM-dd" var="initDate"/> --%>

      <script>
/* Morris.js Charts */
// Sales chart
var aaaa = "${initDate}";
var lineData = [];
<c:forEach var="stat" items="${resultList}">
lineData.push({"y" : "${fn:substring(stat.etc, 0, 10)}", "item1" : <c:out value="${stat.cntCount}" /> })
</c:forEach>

var donutData = [];
<c:forEach var="stat" items="${resultBrowserList}">
donutData.push({"label" : "<c:out value="${fn:substring(stat.cntName, 0, 10)}" />", "value" : <c:out value="${stat.cntCount}" /> })
</c:forEach>

var donutData2 = [];
<c:forEach var="stat" items="${resultDeviceList}">
donutData2.push({"label" : "<c:out value="${fn:substring(stat.cntName, 0, 10)}" />", "value" : <c:out value="${stat.cntCount}" /> })
</c:forEach>

var area = new Morris.Area({
  element: 'visit-chart',
  resize: true,
  data: lineData,
  xkey: 'y',
  ykeys: ['item1'],
  labels: ['방문자'],
  lineColors: ['#a0d0e0'],
  hideHover: 'auto'
});

//Donut Chart
var donut = new Morris.Donut({
  element: 'sales-chart',
  resize: true,
  colors: ["#3c8dbc", "#f56954", "#00a65a"],
  data: donutData,
  hideHover: 'auto'
});
//Donut Chart
var donut2 = new Morris.Donut({
  element: 'sales-chart2',
  resize: true,
  colors: ["#3c8dbc", "#f56954", "#00a65a"],
  data: donutData2,
  hideHover: 'auto'
});

//Fix for charts under tabs
$('.box ul.nav a').on('shown.bs.tab', function () {
  area.redraw();
  donut.redraw();
  donut2.redraw();
});

$( document ).ready(function() {
	$("#visit-chart").css("height",$("#recent-bbs").height());
});

</script>
