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
 * @파일명 : mngrProgramRegist.jsp
 * @파일정보 : 프로그램관리 등록
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
			<div class="box-body">
				<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;">
				<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
				<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
				<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
				<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
				<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
				<input type="hidden" name="id" value="<c:out value="${searchVO.id}" />" />
				<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
				<div class="row">
					<div class="col-xs-12 table-responsive">
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:75%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="progName">프로그램 이름</label></th>
									<td>
										<input type="text" name="progName" id="progName" maxlength="50" value="<c:out value="${result.progName}"/>" class="required form-control input-sm f-wd-400" title="프로그램 이름" />
										<span class="help-block" style="margin-bottom:0;">예)프로그램관리</span>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="progUserurl">사용자페이지</label></th>
									<td>
										<p><strong>http://<%=request.getServerName() %><%=("80".equals(request.getServerPort())?"":":"+request.getServerPort()) %>/(사이트코드)/module/(메뉴코드)_#사용자페이지#</strong></p>
										<p><input type="text" name="progUserurl" id="progUserurl" maxlength="100" value="<c:out value="${result.progUserurl}"/>" class="required form-control input-sm f-wd-400" title="사용자 URL" /></p>
										<p style="margin-bottom:0;"><input type="checkbox" name="userChk" id="userChk" onclick="fn_setUse('progUserurl',this.checked);" ${ufn:checked(result.progUserurl, '-') } /><label for="userChk" style="margin-right:10px;">사용 안함</label>
										<span class="help-block" style="display:inline-block;margin:0;">예) "/web/module/social_programList.do" 일 경우 "programList"만 입력</span></p>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="progMngrurl">관리자페이지</label></th>
									<td>
										<p><strong>http://<%=request.getServerName() %><%=("80".equals(request.getServerPort())?"":":"+request.getServerPort()) %>/_mngr_/module/(메뉴코드)_#관리자페이지#</strong></p>
										<p><input type="text" name="progMngrurl" id="progMngrurl" maxlength="100" value="<c:out value="${result.progMngrurl}"/>" class="required form-control input-sm f-wd-400" title="관리자 URL" /></p>
										<p style="margin-bottom:0;"><input type="checkbox" name="mngrChk" id="mngrChk" onclick="fn_setUse('progMngrurl',this.checked);" ${ufn:checked(result.progMngrurl, '-') } /><label for="mngrChk" style="margin-right:10px;">사용 안함</label>
										<span class="help-block" style="display:inline-block;margin:0;">예) "/_mngr_/module/social_list_program.do" 일 경우 "list_program" 입력</span></p>
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
$(document).ready(function(){
});

/* 글 등록 function */
function fn_egov_save() {
	frm = document.form1;
	if(Validator.validate(frm)){
	  	frm.action = "<c:url value="${searchVO.act == 'REGIST' ? 'prog_input_proc.do' : 'prog_edit_proc.do'}"/>";
	    frm.submit();
	}
}

function fn_goList(){
	location.href="prog_list.do?<c:out value="${searchVO.query}" escapeXml="false" />"
}

<c:if test="${searchVO.act == 'UPDATE' }">

function fn_goDel(){
	if(confirm("삭제하시겠습니까?")){
		var frm = document.form1;
		frm.page.value = "1";
		frm.encoding = "application/x-www-form-urlencoded";
		frm.action = "prog_delete_proc.do";
		frm.submit();
	}
}
</c:if>

function fn_setUse(id, flag){
	if(flag){//사용안함
		$("#" + id).val('-');
		$("#" + id).prop("readonly", "readonly");
	}else{//사용
		$("#" + id).val('');
	    $("#" + id).prop("readonly", "");
	}
}
//]]>
</script>
