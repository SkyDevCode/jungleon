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
 * @파일명 : mngrSiteRegist.jsp
 * @파일정보 : 사이트관리 등록
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

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<!-- <div class="box-header with-border"><h3 class="box-title">Title</h3></div> -->
			<div class="box-body">
				<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;">
				<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
				<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
				<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
				<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
				<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
				<input type="hidden" name="id" value="<c:out value="${searchVO.id}" />" />
				<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
				<input type="hidden" name="act" value="<c:out value="${searchVO.act}" />" />
				<div class="row">
					<div class="col-xs-12 table-responsive">
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:75%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="siteName">사이트 이름</label></th>
									<td>
											<input type="text" name="siteName" id="siteName" maxlength="20" value="<c:out value="${result.siteName}"/>" class="required form-control input-sm f-wd-400" title="사이트 이름" />
									</td>
								</tr>
								<tr>
									<th class="t"><label for="siteCode">사이트 코드</label></th>
									<td>
										<c:choose>
											<c:when test="${searchVO.act eq 'REGIST' }">
												<input type="text" name="siteCode" id="siteCode" maxlength="20" value="<c:out value="${result.siteCode}"/>" class="required validate-id-format form-control input-sm f-wd-400" title="사이트 코드" />
												<span class="help" id="siteCodeHelp"></span>
											</c:when>
											<c:otherwise>
												<c:out value="${result.siteCode }" />
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="siteName">표출 순서</label></th>
									<td>
											<input type="text" name="siteOrder" id="siteOrder" maxlength="2" value="<c:out value="${result.siteOrder}"/>" class="required form-control input-sm f-wd-100 validate-digits" title="표출순서" />
									</td>
								</tr>
							</tbody>
						</table>
					</div><!-- /.col -->
				</div><!-- /row -->
				<div class="box-footer">
              		<div class="pull-right">
						<button  type="submit" value="" class="btn btn-primary">저장</button>
<c:if test="${searchVO.act == 'UPDATE' }">
						<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
</c:if>
						<a href="#none" onclick="fn_goList(); return false;" class="btn btn-default">목록</a>
       				</div>
       			</div>
				</form>
			</div> <!-- /box-body -->
		</div> <!-- /box -->
	</div> <!-- /col -->
</div> <!-- /row -->

<script type="text/javascript">
//<[[!CDATA[
var codeCheck = true;//코드 중복검사, 수정일때는 코드 중복검사 필요없음.
<c:if test="${searchVO.act eq 'REGIST'}">
codeCheck = false;
</c:if>
$(document).ready(function(){
});

/* 등록 function */
function fn_egov_save() {
	frm = document.form1;
	if(Validator.validate(frm)){
		if(!codeCheck){
			alert("사용할 수 없는 사이트 코드입니다. 메시지를 확인해 주세요.");
			return false;
		}

	  	frm.action = "sitemng_edit_proc.do";
	    frm.submit();
	}
}

function fn_goList(){
	location.href="sitemng_list.do?<c:out value="${searchVO.query}" escapeXml="false" />"
}

$(function(){
	/*
		코드 중복 검사
	*/
	$("#siteCode").on("change",function(){
		var ptrn1 = /^[^a-zA-Z]/; //false가 정상
		var ptrn2 = /[^a-zA-Z0-9._]/; //false가 정상 +
		var str = $(this).val();
		if(str == ""){
			fn_printHelp(1);
			return false;
		}
		if(ptrn1.test(str)){
			alert("사이트 코드명은 영문(대소문)자로 시작해야 합니다.");
			//codeCheck = false;
			return false;
		}
		if(ptrn2.test(str)){
			alert("사이트 코드명은 영문(대소문자), 숫자, ., _ 만 입력 할 수 있습니다.");
			//codeCheck = false;
			return false;
		}
		fn_siteDuplCheck($(this).val());
	});
})

function fn_siteDuplCheck(siteCode){
	$.ajax({
		url:"sitemng_comm_dupleCheck.ajax"
		, data : "id=<c:out value="${searchVO.id}" />&siteCode="+siteCode+"&act=<c:out value="${searchVO.act}" />"
		, type : "post"
		, dataType : "json"
		, async : "false"
		, success : function(data){
			fn_printHelp(data.result);
		}
		, error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function fn_printHelp(result){
	if(result == 0){
		codeCheck = true;
		$("#siteCodeHelp").text("사용가능한 사이트코드 입니다.");
	}else if(result == 1){
		codeCheck = false;
		$("#siteCodeHelp").text("중복된 사이트코드 입니다.");
	}else{
		codeCheck = false;
		$("#siteCodeHelp").text("시스템 기본코드는 사용할 수 없습니다.");
	}
}

<c:if test="${searchVO.act == 'UPDATE' }">
function fn_goDel(){
	if(confirm("삭제하시겠습니까?\n\n사이트를 삭제하면 등록된 메뉴가 모두 삭제됩니다.\n\n삭제하시려면 [확인]을 클릭하세요.")){
		var frm = document.form1;
		frm.encoding = "application/x-www-form-urlencoded";
		frm.action = "sitemng_delete_proc.do";
		frm.submit();
	}
}
</c:if>
//]]>
</script>
