<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%@ taglib prefix="ora" uri="/WEB-INF/tlds/CustomTagSelectCodeList.tld" %>
<%
/**
 * @파일명 : _mngr__calendar_list.jsp
 * @파일정보 : 통합게시판 달력형 관리자 리스트 스킨
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @jyl 2018. 03. 22. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
	fn_changeMonth("");
})

var queryString = "${searchVO.query}";

/* 글 조회 화면 function */
function fn_goView(id) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "id", id);
	location.href="/_mngr_/board/${menuCode}_view_${bcid}.do?" + tmpQuery;
}

/* 글 등록 화면 function */
function fn_goRegist() {
   	location.href="/_mngr_/board/${menuCode}_input_${bcid}.do?schM=regist";
}

/* 달력 출력 function */
function fn_changeMonth(act){
	var data = null;
	var frm = null;
	var bcid = '${boardSearchVO.schBcid}';

	if(act != ""){
		frm = document.calForm;
		frm.act.value=act;
		data = new FormData(frm);
	}
	$.ajax({
		type : "post"
		, url : "/${root}/board/${menuCode}_comm_${bcid}_getCalendar.ajax"
		, data : data
	    , processData: false  // Important!
	    , contentType: false
        , cache: false
		, dataType : "html"
		, success : function(data){
			$("#conWrap").html(data);
		}
		, error : function(jqXHR,textStatus,e){
			alert("일정 조회 중 오류가 발생하였습니다. 관리자에게 문의해 주세요.");
			return;
		}
	});
}

/* 월 검색 */
$.fn.datepicker.dates['kr'] = {
	days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
	daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
	daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
	months: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
	monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	};

$('.input-group.date').datepicker({
	format: "yyyy-MM",
	/* startView: 1, */
	minViewMode: 1,
	language: "kr",
	autoclose: true,
	todayHighlight: true
});

$('.input-group.date').change(function() {
	frm1 = document.schForm;
	frm2 = document.calForm;
	frm2.schMonth.value = frm1.schDate.value;
	fn_changeMonth('2');
});
/* 월 검색 end */


//]]>
</script>

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
				<div class="row margin-bottom">
					<div class="col-sm-8 form-inline"></div>
					<div class="col-sm-4 text-right">
						<button type="button" onclick="fn_goRegist();" class="btn btn-primary btn-sm">등록</button>
					</div>
				</div>
				<form name="schForm" id="schForm" method="post">
				<div class="input-group date" style="float: right; width: 200px;">
					<input type="text" class="form-control" name="schDate" readOnly value=""><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
				</div>
				</form>
				<div id="conWrap" class="conWrap" style="margin-top:60px">
					<!-- 달력 출력 -->
				</div>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->