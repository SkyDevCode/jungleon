<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>

<script type="text/javascript">
	<c:set var="parentCode" value="${result.orCode}" />
	<c:if test="${empty result}">
		<c:set var="parentCode" value="0" />
	</c:if>
	var codeCheck = false;
	$(function(){$("#orCode").focus()});

<%-- 중복검사 --%>
function fn_codeDuplCheck(code){
	$.ajax({
		url:"${menuCode}_comm_organization_duplCheck.ajax"
		, data : "orCode="+code
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

<%-- 중복검사 결과 --%>
function fn_printHelp(result){
	codeCheck = false;
	if(result == 0){
		codeCheck = true;
		$("#orCodeHelp").css("color","green");
		$("#orCodeHelp").text("사용가능한 코드 입니다.");
	}else if(result == 1) {
		$("#orCodeHelp").css("color","red");
		$("#orCodeHelp").text("중복된 코드 입니다.");
	}else if(result == 2) {
		$("#orCodeHelp").css("color","red");
		$("#orCodeHelp").text("코드명은 영문자로 시작해야 합니다.");
	}else if(result == 3) {
		$("#orCodeHelp").css("color","red");
		$("#orCodeHelp").text("코드명은 영문(대소문자), 숫자, -(하이픈) 만 입력 할 수 있습니다.");
	}else{
		$("#orCodeHelp").css("color","");
		$("#orCodeHelp").text("등록 후에 수정 할 수 없습니다.");
	}
}
$(function(){
	/*
		코드 중복 검사
	*/
	$("#orCode").on("change",function(){
		var ptrn2 = /[^a-zA-Z0-9-]/; //false가 정상 +
		var str = $(this).val();
		if(str == ""){
			fn_printHelp();
			$(this).focus();
			return false;
		}
		if(ptrn2.test(str)){
			fn_printHelp(3);
			$(this).focus();
			return false;
		}
		fn_codeDuplCheck($(this).val());
	});
})

function fn_save(){
	var frm = document.form1;
	if(!codeCheck){
		alert("코드가 올바르지 않습니다. 메시지 확인 후 다시 시도해주세요.");
		return false;
	}
	if(Validator.validate(frm)){
		$.ajax({
			url : "${menuCode}_input_organization_proc.ajax"
			, data : $("#form1").serialize()
			, dataType : "json"
			, type : "post"
			, success : function(data){
				if(data.result == 0){
					alert(data.message); //alert("데이터 저장 중 오류가 발생했습니다. 다시 시도해 주세요");
					return false;
				}else if(data.result == 1){
					if(confirm("등록되었습니다.\n계속해서 같은 레벨의 코드를 등록 하시겠습니까?")){
						fn_load("REGIST", "<c:out value="${searchMap.schCode}" />");
					}else{
						fn_clear();
					}
					refreshNode();

				}else if(data.result == 2){
					alert(data.message);
					return false;
				}

			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
}

function fn_chkDel(){
	if(confirm("코드를 삭제하시겠습니까?")){
		$.ajax({
			url : "${menuCode}_delete_organization_proc.ajax"
			, data : $("#form1").serialize()
			, dataType : "json"
			, type : "post"
			, success : function(data){
				if(data.result == 0){
					alert("삭제 중 오류가 발생했습니다. 다시 시도해 주세요");
					return false;
				}else if(data.result == 1){
					alert("삭제가 완료 되었습니다.");
					fn_clear();
					refreshNode();
					zTree.cancelSelectedNode();
				}else if(data.result == 2){
					alert("코드에 포함된 하위코드가 있어서 삭제 할 수 없습니다.\n하위코드를 먼저 삭제 해 주세요.");
					return false;
				}
			}
			, error:function(request,status,error){
	   		   alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
}
//]]>
</script>

<style>
.org_cont > h1 {
  position: relative;
  padding-left: 25px;
  font-size: 21px;
  font-weight: 500;
}
.org_cont > h1:before {
  content: "";
  display: block;
  width: 25px;
  height: 100%;
  background: url('/resource/common_adm/img/content-header-bg.png') 0 2px no-repeat;
  position: absolute;
  left: 0;
  top: 0;
}
</style>

<form name="form1" id="form1" method="post" onsubmit="fn_save(); return false;">
	<input type="hidden" name="act" value="<c:out value="${searchMap.act }" />" />
	<input type="hidden" name="orPcode" value="<c:out value="${parentCode}" />" />
	<div class="row">
		<div class="col-xs-12 table-responsive">
			<section class="org_cont">
				<h1>부서 기본 정보</h1>
			</section>
			<table class="table table-bordered tp2">
				<colgroup>
					<col style="width:25%"/>
					<col style="width:75%"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="t"><span>부서 코드 </span></th>
						<td><input type="text" name="orCode" id="orCode" maxlength="20" class="required validate-code-format form-control input-sm f-wd-200" title="부서 코드" value="<c:out value="${orCode }" />" />
							<span id="orCodeHelp" class="help-block" style="margin-bottom:0;"><c:if test="${searchVO.act eq 'REGIST' }">등록 후에 수정 할 수 없습니다.</c:if></span>
						</td>

					</tr>
					<tr>
						<th class="t"><label for="tel">부서명</label></th>
						<td>
							<input type="text" name="orName" id="orName" maxlength="21" class="required form-control input-sm f-wd-200" title="부서명" value="<c:out value="${orName}" />" />
						</td>
					</tr>
					<tr>
						<th class="t"><label for="tel">부서 전화</label></th>
						<td>
							<input type="text" name="orTel" id="orTel" maxlength="20" class="validate-digits- form-control input-sm f-wd-200" title="부서 전화" value="<c:out value="${orTel}" />" />
						</td>
					</tr>
					<tr>
						<th class="t"><label for="etc1">부서 팩스</label></th>
						<td>
							<input type="text" name="orFax" id="orFax" maxlength="20" class="form-control validate-digits- input-sm f-wd-400" title="비고1" value="<c:out value="${orFax}" />" />
						</td>
					</tr>
					<tr>
						<th class="t"><label for="exp1">부서 소개</label></th>
						<td>
							<textarea name="orMemo" id="orMemo" rows="8" class="form-control" maxlength="1333" title="부서 소개" ><c:out value="${orMemo}" /></textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div><!-- /.col -->
	</div>
	<div class="text-right">

	<button type="submit" class="btn btn-primary">등록</button>

	</div>
</form>