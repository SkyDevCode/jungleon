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

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body" style="width: 430px; height:290px;">
				<form name="certForm" id="certForm" method="post">
					<input type="hidden" name="loginId" value="<c:out value="${loginId}" />" />

					<div class="caution-box">
						<span class="caution-title">휴대폰 인증</span>
					</div>
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td>
									<input class="form-control required" type="text" name="certKey" id="certKey" title="인증번호 입력" placeholder="인증번호 입력"/>
									<p class="help-block" style="margin-bottom: 0;">휴대폰으로 인증번호가 발송되었습니다.</p>
								</td>
							</tr>
						</tbody>
				</table>
				<div style="margin-top: 15px;">
					<input type="button" onclick="smsCertCheck()" class="btn btn-primary btn-block" value="확인" id="accessButton"/>
				</div>
				</form>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->

<script>

$(document).ready(function(){
	$("#certKey").val("");
});

function smsCertCheck(){
	frm = document.certForm;
	if(Validator.validate(frm)){
		$.ajax({
			url:"/_mngr_/main/loginExtraCertProc.ajax"
			, data : $("#certForm").serialize()
			, type : "post"
			, dataType : "json"
			, async : "false"
			, success : function(data){
				if(data == 0) {
					alert("인증번호가 일치하지 않습니다.");
				}else if(data == 1){
					alert("인증이 완료되었습니다.");
					opener.location.href="/_mngr_/main/index.do";
					self.close();
				}else{
					alert("인증 시간이 만료되었습니다. 다시 로그인해주세요.");
					self.close();
				}
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
}

</script>