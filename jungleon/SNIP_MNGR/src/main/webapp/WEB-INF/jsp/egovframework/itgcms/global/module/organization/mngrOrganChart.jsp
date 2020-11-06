
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%@ taglib prefix="cct" uri="/WEB-INF/tlds/CreateCodeTag.tld"%>

<%
/**
 * @파일명 : mngrOrganChart.jsp
 * @파일정보 : 조직도설정 조회 페이지
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @jyl 2017. 10. 16. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
          	조직도관리
            <!-- <small>기업회원관리</small> -->
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="#">컨텐츠관리</a></li>
            <li class="active">조직도관리</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
        <form name="form1" id="form1" method="post" enctype="multipart/form-data">

			<div class="row">

				<div class="col-md-12">

					<div class="box">
						<!-- <div class="box-header with-border"><h3 class="box-title">Title</h3></div> -->
						<div class="box-body">


							<div class="row">

								<div class="col-xs-12 table-responsive">
									<table class="table table-bordered tp2">
										<colgroup>
											<col style="width:15%"/>
											<col style="width:85%"/>
										</colgroup>
										<tbody>
											<tr>
												<th class="t"><label for="popupTitle">최상위부서 설정</label></th>
												<td>
													<select id="topCode" name="topCode" title="부서" class="form-control validate-required-select input-sm f-wd-200" ">
														<option value="">선택</option>
														<c:forEach var="codeList" items="${groupList}">
															<option value="${codeList.ccode}" <c:out value="${organChartInfo.topCode eq codeList.ccode ? 'selected':''}"/>>${codeList.cname}</option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr>
												<th class="t"><label for="columnCount">부서 단위 갯수 설정</label></th>
												<td>
													<span class="col-sm-1 icheck"><input type="radio" name="columnCnt" id="columnCount1" value='1' class="validate-one-required" onclick="setColumnCount('1');" ${ufn:checked('1',organChartInfo.columnCnt) } /><label for="columnCount1">1</label></span>
													<span class="col-sm-1 icheck"><input type="radio" name="columnCnt" id="columnCount2" value='2' class="validate-one-required" onclick="setColumnCount('2');" ${ufn:checked('2',organChartInfo.columnCnt) } /><label for="columnCount2">2</label></span>
													<span class="col-sm-1 icheck"><input type="radio" name="columnCnt" id="columnCount3" value='3' class="validate-one-required" onclick="setColumnCount('3');" ${ufn:checked('3',organChartInfo.columnCnt) } /><label for="columnCount3">3</label></span>
												</td>
											</tr>
											<tr id="columnNm1">
												<th class="t"><label for="columnNm1">부서 단위명1</label></th>
												<td>
													<input type="text" name="columnNm1"  maxlength="30" value="${organChartInfo.columnNm1 }" class="form-control input-sm f-wd-400" title="부서 단위명1" />
												</td>
											</tr>
											<tr id="columnNm2">
												<th class="t"><label for="columnNm2">부서 단위명2</label></th>
												<td>
													<input type="text" name="columnNm2"  maxlength="30" value="${organChartInfo.columnNm2 }" class="form-control input-sm f-wd-400" title="부서 단위명2" />
												</td>
											</tr>
											<tr id="columnNm3">
												<th class="t"><label for="columnNm3">부서 단위명3</label></th>
												<td>
													<input type="text" name="columnNm3"  maxlength="30" value="${organChartInfo.columnNm3 }" class="form-control input-sm f-wd-400" title="부서 단위명3" />
												</td>
											</tr>
										</tbody>
									</table>
								</div><!-- /.col -->

							</div>

							<div class="box-footer">
			                  <div class="pull-right">
								<button type="submit" onclick="fn_egov_save(); return false;" class="btn btn-primary">저장</button>
			                  </div>
			                </div><!-- /.box-footer -->
						</div>

					</div>

				</div>

			</div>
        </form>
        </section><!-- /.content -->
	</div><!-- /.content-wrapper -->

<script type="text/javascript">
//<[[!CDATA[
var nameChkFlag = false;
var comNochkFlag = false;
//R: 도로명, J: 지번
var addr = "R";
var queryString = '<c:out value="${searchVO.queryString()}" escapeXml="false" />';

$(document).ready(function(){
	var chk = document.getElementsByName("columnCnt");
	if(chk[0].checked == true){
		$("#columnNm1").show();
		$("#columnNm2").hide();
		$("#columnNm3").hide();
	}else if(chk[1].checked == true){
		$("#columnNm1").show();
		$("#columnNm2").show();
		$("#columnNm3").hide();
	}else if(chk[2].checked == true){
		$("#columnNm1").show();
		$("#columnNm2").show();
		$("#columnNm3").show();
	}
});

function setColumnCount(opt){
	if(opt == "1"){
		$("#columnNm1").show();
		$("#columnNm2").hide();
		$("#columnNm3").hide();
	}else if(opt == "2"){
		$("#columnNm1").show();
		$("#columnNm2").show();
		$("#columnNm3").hide();
	}else if(opt == "3"){
		$("#columnNm1").show();
		$("#columnNm2").show();
		$("#columnNm3").show();
	}
}


/* 조직도설정 수정 프로세스 */
function fn_egov_save() {
	frm = document.form1;
	if(Validator.validate(frm)){
		frm.action = "<c:url value="mngrOrganChartUpdateProc.do"/>";
	    frm.submit();
	}
}


//]]>
</script>
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="daumPostLayer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer"
	     style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="ItgJs.getDaumAddressLayerClose()" alt="닫기 버튼">
</div>
