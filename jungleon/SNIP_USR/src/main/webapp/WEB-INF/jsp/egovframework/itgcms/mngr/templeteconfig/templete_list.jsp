
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
 * @파일명 : templete_list.jsp
 * @파일정보 : 탬플릿관리 목록
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
<style>
    .preView-modal{top:0px; width:100%; position: fixed; z-index:1000;}
	.preView-modal .modal {position: relative; top: 100px; bottom: auto; right: auto; left: auto; z-index: 1;}
	.preView-modal .modal {background: transparent !important;}
</style>

<div class="row">
	<div class="col-xs-12">
		<div class="box">
		<div class="box-header with-border">
				<div class="row">
					<div class="col-md-6 form-group">
						<select class="form-control select2" style="width: 100%;" name="schSiteCode" id="schSiteCode" onChange="fn_changeSite();">
						<c:forEach var="result" items="${siteList}" varStatus="status">
							<option ${ufn:selected(result.siteCode, mngrSiteVO.siteCode)} value="${result.siteCode}">${result.siteName}</option>
						</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="box-body">
				<form name="listForm" method="post">
               	<input type="hidden" name="tempCode" id="tempCode" />
               	<input type="hidden" name="tempIdx" id="tempIdx" />
               	<input type="hidden" name="siteCode" value="${mngrSiteVO.siteCode}">
				<input type="hidden" name="sysName" value="${mngrSiteVO.siteName}">
                <div class="col-sm-12 margin-bottom">
					<div class="text-right">
						<button type="button" onclick="fn_goRegist();" class="btn btn-primary">템플릿 추가하기</button>
					</div>
				</div>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<div class="col-lg-4 col-md-4 col-sm-6">
		        	<!-- Widget: user widget style 1 -->
					<div class="box box-widget widget-user">
						<!-- Add the bg color to the header using any of the bg-* classes -->
		                <div class="widget-user-header bg-aqua-active">
							<h3 class="widget-user-username"><c:out value="${result.tempName }"/></h3>
							<h5 class="widget-user-desc">CODE : <c:out value="${result.tempCode }"/></h5>
		                </div>
		                <div class="widget-user-image">
		                  	<img class="img-circle" src="${ctx}/resource/templete/${result.tempCode}/img/preView_s.jpg" alt="preView Thumb" onerror="javascript:src='${ctx}/resource/common/img/noimage.gif'; imageErr(this);">
		                </div>
		                <div class="box-footer">
		                  	<div class="row">
			                    <div class="col-sm-4 border-right">
			                      	<div class="description-block">
			                        	<h5 class="description-header"><c:out value="${result.recentBdCnt }"/></h5>
			                        	<span class="description-text">최근글</span>
			                      	</div><!-- /.description-block -->
			                    </div><!-- /.col -->
		                    	<div class="col-sm-4 border-right hide-xs">
		                      		<div class="description-block">
		                        		<h5 class="description-header"><button type="button" id="preViewBtn" class="btn btn-primary btn-sm" onclick="fn_goPreView('<c:out value="${result.tempCode}" />'); return false;">미리보기</button></h5>
		                        		<!-- <span class="description-text">수정</span> -->
		                      		</div><!-- /.description-block -->
		                    	</div><!-- /.col -->
		                    	<div class="col-sm-4">
		                      		<div class="description-block">
		                        		<h5 class="description-header">
		                        			<button type="button" class="btn btn-default btn-sm" onclick="fn_goView('<c:out value="${result.tempIdx}" />'); return false;">수정</button>
		                        			<button type="button" class="btn btn-danger btn-sm" onclick="fn_goDel('<c:out value="${result.tempIdx}" />'); return false;">삭제</button>
		                        		</h5>
		                        		<!-- <span class="description-text">관리</span> -->
		                      		</div><!-- /.description-block -->
		                    	</div><!-- /.col -->
		                  	</div><!-- /.row -->
						</div>
					</div><!-- /.widget-user -->
				</div>
	            </c:forEach>
				</form>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->

<div class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" onclick="fn_closePreView()" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">템플릿 미리보기</h4>
			</div>
			<div class="modal-body" style="text-align: center;">
				<p>One fine body&hellip;</p>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	$(".bg_${searchVO.ordFld}").css("background-color","#efefef");
})
var queryString = "${searchVO.query}";


/* 템플릿 수정 화면 function */
function fn_goView(tempIdx) {
	var f = document.listForm;
	f.tempIdx.value = tempIdx;
	f.action = "templete_edit.do";
	f.submit();
}

/* 템플릿 미리보기 화면 function */
function fn_goPreView(tempCode) {
	$(".modal").show();
	var html = "<img src='${ctx}/resource/templete/"+tempCode+"/img/preView.jpg' width='570'>";
	$(".modal-body").html(html);
}

/* 템플릿 미리보기 화면 function */
function fn_closePreView() {
	$(".modal").hide();
	var html = "";
	$(".modal-body").html(html);
}

/* 글 등록 화면 function */
function fn_goRegist() {
	var f = document.listForm;
	f.action = "templete_input.do";
	f.submit();
}

/* 글 삭제 function */
function fn_goDel(tempIdx){
	if(confirm("선택한 템플릿을 삭제하시겠습니까?")){
		var f = document.listForm;
		f.tempIdx.value = tempIdx;
		f.action = "templete_delete_proc.do";
	   	f.submit();
	}
}

/* 이미지에러 function */
function imageErr(obj){
	var btn = $(obj).parent().parent().find('#preViewBtn');
	$(btn).attr('onclick','alert("미리보기 이미지가 없습니다. 이미지를 업로드 해주세요.");')
}

function fn_changeSite(){
	var frm = document.listForm;
	frm.siteCode.value=$("#schSiteCode").val();
	frm.action = "?";
	frm.submit();
}
//]]>
</script>
