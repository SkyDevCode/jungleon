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
/*
 * @파일명 : user_calendar_list.jsp
 * @파일정보 : 통합게시판 달력형 사용자 리스트 스킨
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
		//location.href="/user/board/${menuCode}_view_${bcid}.do?" + tmpQuery;
		location.href="?" + tmpQuery;
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

</script>

<div id="conWrap" class="conWrap">
	<!-- 달력 출력 -->
</div>
