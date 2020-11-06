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
 * @파일명 : memberLoginConfig.jsp
 * @파일정보 : 회원 로그인 설정
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
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.exedit-3.5.js"></script>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
				<div class="col-md-12" style="padding:0;">
					<form name="findIdPwdConfig" id="findIdPwdConfig" method="post" onsubmit="fn_egov_save(); return false;" class="form-horizontal">
						<table class="table table-bordered table tp2">
							<colgroup>
								<col style="width: 25%;" />
								<col style="width: 75%;" />
							</colgroup>
							<tr>
								<th style="vertical-align: middle;"><span>현재메뉴코드</span></th>
								<td>
									<label>${urlInfo.menuCode}</label>
								</td>
							</tr>
							<tr>
								<th style="vertical-align: middle;"><span>아이디/비밀번호찾기메뉴코드</span></th>
								<td>
									<label>${findIdPwdMenuCode}</label>
								</td>
							</tr>
						</table>
						<button type="submit" class="btn btn-primary pull-right">저장</button>
					</form>
				</div>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
<!-- /.content -->
<script type="text/javascript">
//<[[!CDATA[

/* 글 등록 function */
function fn_egov_save() {
	frm = document.findIdPwdConfig;
	if(Validator.validate(frm)){
		$.ajax({
			url : '${urlInfo.menuCode}_edit_mngrFindIdPwd_proc.ajax',
			data : $("#findIdPwdConfig").serialize(),
			type : "POST",
			success : function(data){
				if(data == 401){
					alert("해당 권한이 없습니다.");
					return false;
				}else if(data.status === "success") {
					alert(data.msg);
					location.reload();
				} else {
					alert(data.msg+"\n 에러 상태 : "+data.status);
				}
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});

	}
}
//]]>
</script>