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
 * @파일명 : code_edit.jsp
 * @파일정보 : 코드관리 등록 레이어
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 12. 13. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<script type="text/javascript">
//<![CDATA[
<c:choose>
<c:when test="${searchVO.act eq 'REGIST' }">
	<c:set var="btnText" value="등록" />
	<c:set var="parentCode" value="${result.ccode}" />
	<c:set var="parentName" value="${result.cname}" />
	<c:set var="ccode" value="" />
	<c:set var="cname" value="" />
	<c:set var="cauth" value="" />
	<c:set var="etc1" value="" />
	<c:set var="etc2" value="" />
	<c:set var="exp1" value="" />
	<c:set var="title" value="코드 등록" />
	var codeCheck = false;
	$(function(){$("#ccode").focus()});
</c:when>
<c:when test="${searchVO.act eq 'UPDATE' }">
	<c:set var="btnText" value="저장" />
	<c:set var="parentCode" value="${result.cpcode}" />
	<c:set var="parentName" value="${result.pcodename}" />
	<c:set var="ccode" value="${result.ccode}" />
	<c:set var="cname" value="${result.cname}" />
	<c:set var="cauth" value="${result.cauth}" />
	<c:set var="etc1" value="${result.etc1}" />
	<c:set var="etc2" value="${result.etc2}" />
	<c:set var="exp1" value="${result.exp1}" />
	<c:set var="title" value="코드 수정" />
	var codeCheck = true;
	$(function(){$("#cname").focus()});
</c:when>
</c:choose>
function fn_codeDuplCheck(code){
	$.ajax({
		url:"code_comm_dupleCheck.ajax"
		, data : "schCode=<c:out value="${searchVO.schCode}" />&ccode="+code+"&act=<c:out value="${searchVO.act}" />"
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
		$("#ccodeHelp").text("사용가능한 코드 입니다.");
	}else{
		codeCheck = false;
		if ($("#ccode").val()==null||$("#ccode").val()=='') {
			$("#ccodeHelp").text("등록 후에 수정 할 수 없습니다.");
		}else{
			$("#ccodeHelp").text("중복된 코드 입니다.");
		}
	}
}
$(function(){
	/*
		코드 중복 검사
	*/
	$("#ccode").on("change",function(){
		var ptrn1 = /^[^a-zA-Z]/; //false가 정상
		var ptrn2 = /[^a-zA-Z0-9-]/; //false가 정상 +
		var str = $(this).val();
		if(str == ""){
			fn_printHelp(1);
			$(this).focus();
			return false;
		}
		if(ptrn1.test(str)){
			alert("코드명은 영문자로 시작해야 합니다.");
			$(this).focus();
			return false;
		}
		if(ptrn2.test(str)){
			alert("코드명은 영문(대소문자), 숫자, -(하이픈) 만 입력 할 수 있습니다.");
			$(this).focus();
			return false;
		}
		fn_codeDuplCheck($(this).val());
	});
})

function fn_save(){
	var frm = document.form1;
	if(Validator.validate(frm)){
		if(!codeCheck){
			alert("중복된 코드입니다. 확인 후 다시 시도해주세요.");
			return false;
		}
		$.ajax({
			url : "/_mngr_/code/code_edit_proc.ajax"
			, data : $("#form1").serialize()
			, dataType : "json"
			, type : "post"
			, success : function(data){
				if(data.result == 0){
					alert(data.message); //alert("데이터 저장 중 오류가 발생했습니다. 다시 시도해 주세요");
					return false;
				}else if(data.result == 1){
					if("<c:out value="${searchVO.act}" />" == "REGIST"){
						if(confirm("등록되었습니다.\n계속해서 같은 레벨의 코드를 등록 하시겠습니까?")){
							fn_load("REGIST", "<c:out value="${searchVO.schCode}" />");
						}else{
							fn_clear();
						}

					}else if("<c:out value="${searchVO.act}" />" == "UPDATE"){
						alert("저장 되었습니다.");
						fn_load("UPDATE",'');
					}
					refreshNode();

				}else if(data.result == 2){
					alert(data.message); //alert("코드가 중복 되었습니다. 확인 후 다시 시도해 주세요");
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
			url : "code_delete_proc.ajax"
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

<form name="form1" id="form1" method="post" onsubmit="fn_save(); return false;">
	<input type="hidden" name="schCode" value="<c:out value="${searchVO.schCode }" />" />
	<input type="hidden" name="act" value="<c:out value="${searchVO.act }" />" />
	<div class="row">
		<div class="col-xs-12 table-responsive">
			<table class="table table-bordered tp2">
				<colgroup>
					<col style="width:25%"/>
					<col style="width:75%"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="t"><span>상위코드</span></th>
						<td><c:out value="${parentCode}" /></td>
					</tr>
					<tr>
						<th class="t"><span>상위코드명</span></th>
						<td><c:out value="${parentName}" /></td>
					</tr>
					<tr>
						<th class="t"><label for="em">코드</label></th>
						<td>
							<div class="form-inline">
							<c:choose>
				        		<c:when test="${searchVO.act eq 'REGIST' }">
						            <input type="text" name="ccode" id="ccode" maxlength="20" class="required validate-code-format form-control input-sm f-wd-200" title="코드" value="<c:out value="${ccode }" />" />
				        		</c:when>
				        		<c:otherwise>
				        			<c:out value="${ccode }" />
				        		</c:otherwise>
				        	</c:choose>
				            <span id="ccodeHelp" class="help"><c:if test="${searchVO.act eq 'REGIST' }">등록 후에 수정 할 수 없습니다.</c:if></span>
				            </div>
						</td>
					</tr>
					<tr>
						<th class="t"><label for="tel">코드이름</label></th>
						<td>
							<input type="text" name="cname" id="cname" maxlength="50" class="required form-control input-sm f-wd-200" title="코드이름" value="<c:out value="${cname}" />" />
						</td>
					</tr>
					<c:if test="${mngrSessionVO.mngAuth == '99'}">
					<tr>
						<th class="t"><label for="tel">코드권한</label></th>
						<td>
							<input type="text" name="cauth" id="cauth" maxlength="2" class="required validate-digits form-control input-sm f-wd-200" title="코드권한" value="<c:out value="${cauth}" />" />
						</td>
					</tr>
					<tr>
						<th class="t"><label for="etc1">비고1</label></th>
						<td>
							<input type="text" name="etc1" id="etc1" maxlength="50" class="form-control input-sm f-wd-400" title="비고1" value="<c:out value="${etc1}" />" />
						</td>
					</tr>
					<tr>
						<th class="t"><label for="etc2">비고2</label></th>
						<td>
							<input type="text" name="etc2" id="etc2" maxlength="100" class="form-control input-sm f-wd-400" title="비고2" value="<c:out value="${etc2}" />" />
						</td>
					</tr>
					<tr>
						<th class="t"><label for="exp1">설명</label></th>
						<td>
							<textarea name="exp1" id="exp1" rows="5" class="form-control input-sm" maxlength="1000" title="설명1"><c:out value="${exp1}" /></textarea>
						</td>
					</tr>
					</c:if>
					<c:if test="${searchVO.act == 'UPDATE'}">
				    	<tr>
					        <th class="t"><span>등록자 아이디</span></th>
					        <td>
					            <c:out value="${result.regmemid }" />
					        </td>
				    	</tr>
				    	<tr>
					        <th class="t"><span>등록일</span></th>
					        <td>
					            <c:out value="${result.regdt }" />
					        </td>
				    	</tr>
				    	<c:if test="${not empty result.upddt }">
					    	<tr>
						        <th class="t"><span>수정자 아이디</span></th>
						        <td>
						            <c:out value="${result.updmemid }" />
						        </td>
					    	</tr>
					    	<tr>
						        <th class="t"><span>수정일</span></th>
						        <td>
						        	<c:out value="${result.upddt }" />
						        </td>
					    	</tr>
				    	</c:if>
				    </c:if>
				</tbody>
			</table>
		</div><!-- /.col -->
	</div>
	<div class="text-right">
<c:if test="${searchVO.act == 'UPDATE' and result.subtree == 0 and result.defaultyn eq 'Y'}">
		<span style="font-weight: 500;padding-right:10px;">(※기본설정코드는 삭제할 수 없습니다.)</span>
</c:if>
		<button type="submit" class="btn btn-primary"><c:out value="${btnText }" /></button>
<c:if test="${searchVO.act == 'UPDATE' and result.subtree == 0 and result.defaultyn ne 'Y'}">
		<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
</c:if>
	</div>
</form>
