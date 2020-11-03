
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
 * @파일명 : mngrSlidesList.jsp
 * @파일정보 : 슬라이드셋 관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 4. 10. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<c:if test="${mngrSessionVO.currSiteCode == 'SYSTEM'}">
<ul class="nav nav-tabs">
	<c:forEach var="result" items="${siteList}" varStatus="status">
	<li class="<c:if test = "${result.siteCode eq mngrSiteVO.siteCode}">active</c:if>">
	<a href="#" id="${result.siteCode}" data-toggle="tab">${result.siteName}</a>
	</li>
</c:forEach>
</ul>
</c:if>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body" style="padding:35px 15px;">
        	<form name="listForm" method="post">
          		<input type="hidden" name="slidesCode" id="slidesCode" />
          		<input type="hidden" name="slidesIdx" id="slidesIdx" />
          		<input type="hidden" name="slitemIdx" id="slitemIdx" />
          		<input type="hidden" name="siteCode" value="${mngrSiteVO.siteCode}">
				<input type="hidden" name="sysName" value="${mngrSiteVO.siteName}">
  			</form>
	       		<div class="col-sm-12 margin-bottom">
					<div class="text-right">
						<button type="button" onclick="fn_goRegist();" class="btn btn-primary">슬라이드셋 추가하기</button>
					</div>
				</div>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:if test="${searchVO.slidesIdx eq '' or searchVO.slidesIdx eq null}">
				<div class="col-sm-12 slideset margin-bottom<c:out value="${ufn:deCode(status.count, '1, ', 'collapsed-box') }"/>">
	        </c:if>
	        <c:if test="${searchVO.slidesIdx ne '' and searchVO.slidesIdx ne null}">
				<div class="col-sm-12 slideset margin-bottom<c:out value="${ufn:IIF(result.slidesIdx eq searchVO.slidesIdx,' ','collapsed-box')}"/>">
	        </c:if>
				    <div class="box-header with-border slideset">
			            <h3 class="box-title"><c:out value="${result.slidesName}" />
			            	<small>
								(<c:out value="${ufn:deCode(result.useyn, 'N,사용 안함', '사용') }" />)
							</small>
			            </h3>
		            </div>
	            	<div class="box-body slideset">
					<!-- <div class="col-wd-240">
						<a href="#" class="thumbnail">
					    	<img src="http://placehold.it/240x150" alt="...">
						</a>
					</div> -->
					<c:forEach var="item" items="${result.itemList}" varStatus="itemStatus">
						<div class="col-sm-3 slideThumb">
							<a href="#" class="thumbnail small-box" onclick="fn_goItemView('<c:out value="${item.slitemIdx}" />'); return false;">
						    	<img class="transbg" src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','slides',item.slitemImg,'thumb') }" />" alt="<c:out value="${item.slitemImgalt}" />"/>
								<div class="icon<c:out value="${ufn:deCode(item.useyn, 'Y,-green', '-red') }" />">
                  					<i class="ion <c:out value="${ufn:deCode(item.useyn, 'Y,ion-checkmark-circled', 'ion-close-circled') }" />"></i>
                				</div>
                				<span class="small-box-footer" style="position:absolute;bottom:0;width:100%;">More info <i class="fa fa-arrow-circle-right"></i></span>
							</a>
						</div>
					</c:forEach>
						<div class="col-sm-3 slideThumb">
		            		<a class="thumbnail small-box" style="font-size:60px;line-height:200px;color: darkgrey;text-align: center;display:block;" href="javascript:void(0);" onclick="fn_goItemAdd('<c:out value="${result.slidesIdx}" />'); return false;">
		              			<i class="fa  fa-plus-square-o"></i>
		              		</a>
		              	</div>
	            	</div><!-- /.box-body -->
		            <div class="box-footer text-right">
		              	<button type="button" class="btn btn-default" onclick="fn_goView('<c:out value="${result.slidesIdx}" />'); return false;">수정</button>
				        <button type="button" class="btn btn-danger" onclick="fn_goDel('<c:out value="${result.slidesIdx}" />'); return false;">삭제</button>
		            </div><!-- /.box-footer-->
          		</div><!-- /.col-sm-12 -->
		</c:forEach>
		<c:if test="${listNo eq 0}">
				<div class="callout callout-info" style="margin-bottom: 0!important;">
		            <h4><i class="fa fa-info"></i> Note:</h4>
		            설정된 슬라이드셋이 없습니다. 슬라이드셋을 추가 해 주세요.
		        </div>
		</c:if>
        	</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div>
	<div class="modal">
       	<div class="modal-dialog">
			<div class="modal-content">
            	<div class="modal-header">
                   	<button type="button" class="close" onclick="fn_closeItemView()" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                   	<h4 class="modal-title">슬라이드 아이템</h4>
                </div>
				<div class="modal-body">

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="fn_closeItemView()" data-dismiss="modal">Close</button>
				</div>
			</div><!-- /.modal-content -->
       	</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->




<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){

})

/* 템플릿 수정 화면 function */
function fn_goView(slidesIdx) {
	var f = document.listForm;
	f.slidesIdx.value = slidesIdx;
	f.action = "slides_view.do";
	f.submit();
}

/*템플릿 삭제 function*/
function fn_goDel(slidesIdx){
	 var f = document.listForm;
	f.slidesIdx.value = slidesIdx;
	f.action = "slides_delete_proc.do";
	f.submit();
}

/* 글 등록 화면 function */
function fn_goRegist() {
   	location.href="slides_input.do";
}

/* 이미지 아이템 등록 function */
function fn_goItemAdd(slidesIdx) {
	var f = document.listForm;
	f.slidesIdx.value = slidesIdx;
	f.action ="slides_input_item.do";
	f.submit();
}

/* 템플릿 미리보기 화면 function */
function fn_goItemView(slitemIdx) {
	var f = document.listForm;
	f.slitemIdx.value = slitemIdx;
	f.action ="slides_view_item.do";
	f.submit();
}

/* 템플릿 미리보기 화면 function */
/* function fn_goItemView(tempCode) {

	$(".modal").show();
	var html = "";
	$(".modal-body").html(html);
} */

/* 아이템 등록/수정 화면 닫기 function */
function fn_closeItemView() {
	$(".modal").hide();
	var html = "";
	$(".modal-body").html(html);

}
//탭 버튼 변경 체크
$("a[data-toggle='tab']").on("show.bs.tab", function(e) {
	e.preventDefault();
	fn_change_tab(e.target.id);
});
function fn_change_tab(code) {
	frm = document.listForm;
	frm.siteCode.value = code;
  	frm.action = "?";
    frm.submit();
}

//]]>
</script>

