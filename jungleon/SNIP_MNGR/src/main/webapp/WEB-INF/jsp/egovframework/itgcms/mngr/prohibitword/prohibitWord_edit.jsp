<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>

		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-body">
						<div class="caution-box">
						    <h4 class="caution-title" style="color:#d54e21;font-size:20px;">확인!</h4>
						    <ul>
						    	<li>금지어 사이에는 '|'로 구분을 해야 정상적으로 작동합니다.</li>
						    	<li>예 ) 금지어1|금지어2|금지어3</li>
						    </ul>
						</div>
						<div class="box-header with-border" style="padding:0 0 10px;border-bottom:none;margin-top:50px;"><h3 class="box-title">금지어 목록</h3></div>
						<div class="box-body" style="padding:0;">
							<textarea class="form-control" id="prohibitWordDesc" rows="10" cols="10" style="resize:none; width: 100%;">${prohibitDesc}</textarea>
							<div class="pull-left" style="margin-top: 10px;">
								<span class="fa fa-warnnig"></span>
							</div>
							<div class="pull-right" style="margin-top: 10px;">
								<button class="btn btn-default">원래대로</button>
								<button class="btn btn-primary" onclick="saveDesc()">저장</button>
							</div>
						</div>
					</div> <!-- /box-body -->
				</div> <!-- /box -->
			</div> <!-- /col -->
		</div> <!-- /row -->
<script type="text/javascript">
//<![CDATA[
function saveDesc(){
	$("#prohibitWordDesc").val( $("#prohibitWordDesc").val().replace("\r\n", "") );
	$.ajax({
		url : 'prohibitWord_edit_proc.ajax',
		data : {words : $("#prohibitWordDesc").val()},
		type : "POST",
		success : function(data){
			if(data.status === "success") {
				alert(data.msg);
			} else {
				alert(data.msg+"\n 에러 상태 : "+data.status);
			}
		},
		error : function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

$(function(){
	$("#prohibitWordDesc").focus();
});
//]]>
</script>
