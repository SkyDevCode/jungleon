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
 * @파일명 : mngrSystemconfigMain.jsp
 * @파일정보 : 시스템 환경설정
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2016. 3. 18. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

<div class="row">
	<div class="col-md-12">
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
				<form name="smKeys" method="post" onsubmit="fn_egov_save();return false;">
				<input type="hidden" name="smNum" value="4"/>
				<input type="hidden" name="addNum" value="0"/>
				<input type="hidden" name="siteCode" value="${mngrSiteVO.siteCode}">
				<input type="hidden" name="sysName" value="${mngrSiteVO.siteName}">
					<span class="pull-right">
						<input type="submit" class="btn btn-primary" value="저장"/>
					</span> <br/><br/>
					<table class="table table-bordered tp2 smRow">
						<input type="hidden" name="smkeyIdx1" value="${fbInfo.smkeyIdx}" id="hiddenKey1"/>
						<colgroup>
							<col style="width : 10%"></col>
							<col style="width : 10%"></col>
						</colgroup>
						<tbody>
							<tr>
								<th class="t" rowspan="3" style="text-align:center">페이스북
									<input type="hidden" name="smName1" id="smName1" value="facebook" title="페이스북"/>
<%-- 													<button type="button" class="btn btn-danger pre btn-sm preRow" onclick="delSm(this);" style="margin-top:10px;" data-count="1">삭제</button> --%>
								</th>
								<th class="t"><span>App Key</span></th>
								<td><input type="text" class="form-control" name="smAppkey1" value="<c:out value="${fbInfo.smAppkey}" />"/></td>
							</tr>
							<tr>
								<th class="t"><span>App Secret</span></th>
								<td><input type="text" class="form-control" name="smSecretkey1" value="<c:out value="${fbInfo.smSecretkey}" />"/></td>
							</tr>
							<tr>
								<th class="t"><span>계정 ID</span></th>
								<td><input type="text" class="form-control" name="accountId1" value="${fbInfo.accountId}"/></td>
							</tr>
<%-- 							<tr>
								<th class="t" style="text-align: center;">홍보문구</th>
								<td colspan="2"><input type="text" class="form-control" name="exp1" value="${fbInfo.exp1}"/></td>
							</tr> --%>
						</tbody>
					</table>
					<table class="table table-bordered tp2 smRow">
						<input type="hidden" name="smkeyIdx2" value="${twInfo.smkeyIdx}" id="hiddenKey2"/>
						<colgroup>
							<col style="width : 10%"></col>
							<col style="width : 10%"></col>
						</colgroup>
						<tbody>
							<tr>
								<th class="t" rowspan="3" style="text-align:center">트위터
									<input type="hidden" name="smName2" id="smName2" value="twitter" title="트위터"/>
<%-- 													<button type="button" class="btn btn-danger pre btn-sm preRow" onclick="delSm(this);" style="margin-top:10px;" data-count="2">삭제</button> --%>
								</th>
								<th class="t"><span>App Key</span></th>
								<td><input type="text" class="form-control" name="smAppkey2" value="<c:out value="${twInfo.smAppkey}" />"/></td>
							</tr>
							<tr>
								<th class="t"><span>App Secret</span></th>
								<td><input type="text" class="form-control" name="smSecretkey2" value="<c:out value="${twInfo.smSecretkey}" />"/></td>
							</tr>
							<tr>
								<th class="t"><span>계정 ID</span></th>
								<td><input type="text" class="form-control" name="accountId2" value="${twInfo.accountId}"/></td>
							</tr>
<%-- 							<tr>
								<th class="t" style="text-align: center;">홍보문구</th>
								<td colspan="2"><input type="text" class="form-control" name="exp2" value="${twInfo.exp1}"/></td>
							</tr> --%>
						</tbody>
					</table>
					<table class="table table-bordered tp2 smRow">
						<input type="hidden" name="smkeyIdx3" value="${nbInfo.smkeyIdx}" id="hiddenKey3"/>
						<colgroup>
							<col style="width : 10%"></col>
							<col style="width : 10%"></col>
						</colgroup>
						<tbody>
							<tr>
								<th class="t" rowspan="3" style="text-align:center">네이버블로그
									<input type="hidden" name="smName3" id="smName3" value="naver" title="네이버블로그"/>
<%-- 													<button type="button" class="btn btn-danger pre btn-sm preRow" onclick="delSm(this);" style="margin-top:10px;" data-count="3">삭제</button> --%>
								</th>
								<th class="t"><span>App Key</span></th>
								<td><input type="text" class="form-control" name="smAppkey3" value="<c:out value="${nbInfo.smAppkey}" />"/></td>
							</tr>
							<tr>
								<th class="t"><span>App Secret</span></th>
								<td><input type="text" class="form-control" name="smSecretkey3" value="<c:out value="${nbInfo.smSecretkey}" />"/></td>
							</tr>
							<tr>
								<th class="t"><span>계정 ID</span></th>
								<td><input type="text" class="form-control" name="accountId3" value="${nbInfo.accountId}"/></td>
							</tr>
<%-- 							<tr>
								<th class="t" style="text-align: center;">홍보문구</th>
								<td colspan="2"><input type="text" class="form-control" name="exp3" value="${nbInfo.exp1}"/></td>
							</tr> --%>
						</tbody>
					</table>
					<table class="table table-bordered tp2 smRow">
						<input type="hidden" name="smkeyIdx4" value="${inInfo.smkeyIdx}" id="hiddenKey4"/>
						<colgroup>
							<col style="width : 10%"></col>
							<col style="width : 10%"></col>
						</colgroup>
						<tbody>
							<tr>
								<th class="t" rowspan="3" style="text-align:center">인스타그램
									<input type="hidden" name="smName4" id="smName4" value="instagram" title="인스타그램"/>
<%-- 													<button type="button" class="btn btn-danger pre btn-sm preRow" onclick="delSm(this);" style="margin-top:10px;" data-count="4">삭제</button> --%>
								</th>
								<th class="t"><span>App Key</span></th>
								<td><input type="text" class="form-control" name="smAppkey4" value="<c:out value="${inInfo.smAppkey}" />"/></td>
							</tr>
							<tr>
								<th class="t"><span>App Secret</span></th>
								<td><input type="text" class="form-control" name="smSecretkey4" value="<c:out value="${inInfo.smSecretkey}" />"/></td>
							</tr>
							<tr>
								<th class="t"><span>계정 ID</span></th>
								<td><input type="text" class="form-control" name="accountId4" value="${inInfo.accountId}"/></td>
							</tr>
<%-- 							<tr>
								<th class="t" style="text-align: center;">홍보문구</th>
								<td colspan="2"><input type="text" class="form-control" name="exp4" value="${inInfo.exp1}"/></td>
							</tr> --%>
						</tbody>
					</table>
					<div id="smDiv"></div>
<!-- 								<button type="button" class="btn btn-primary addImgBtn" onclick="addSm();" style="margin-left:47%;">소셜미디어 추가</button> -->
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
//<[[!CDATA[
/* 등록 function */
function fn_egov_save() {
	frm = document.smKeys;
	if(Validator.validate(frm)){
		var message = Validator["validate-max-length"](frm.accountId1.value,"facebook 계정 ID",'60');
		if(message) {alert(message);frm.accountId1.focus();return false;}
/* 		message = Validator["validate-max-length"](frm.exp1.value,"facebook 홍보문구",'500');
		if(message) {alert(message);frm.exp1.focus();return false;} */
		message = Validator["validate-max-length"](frm.accountId2.value,"twitter 계정 ID",'60');
		if(message) {alert(message);frm.accountId2.focus();return false;}
/* 		message = Validator["validate-max-length"](frm.exp2.value,"twitter 홍보문구",'500');
		if(message) {alert(message);frm.exp2.focus();return false;} */
		message = Validator["validate-max-length"](frm.accountId3.value,"naver 계정 ID",'60');
		if(message) {alert(message);frm.accountId3.focus();return false;}
/* 		message = Validator["validate-max-length"](frm.exp3.value,"naver 홍보문구",'500');
		if(message) {alert(message);frm.exp3.focus();return false;} */
		message = Validator["validate-max-length"](frm.accountId4.value,"instagram 계정 ID",'60');
		if(message) {alert(message);frm.accountId4.focus();return false;}
/* 		message = Validator["validate-max-length"](frm.exp4.value,"instagram 홍보문구",'500');
		if(message) {alert(message);frm.exp4.focus();return false;} */

		frm.smNum.value = $(".smRow").length;
	  	frm.action = "socialKey_edit_proc.do";
		frm.submit();
	}
}

function addSm() {
	frm = document.smKeys;
	var addNum = Number(frm.addNum.value)+1;
	var rowHtml = "<table class='table table-bordered tp2 addRow'>"+
						"<colgroup>"+
							"<col style='width : 10%'></col>"+
							"<col style='width : 10%'></col>"+
						"</colgroup>"+
						"<tbody>"+
							"<tr>"+
								"<th class='t' rowspan='3'>"+
								"<input type='text' class='form-control required' name='smNameAdd"+addNum+"' id='smName"+addNum+"' title='소셜미디어 이름'/>"+
								"<button type='button' class='btn btn-primary new' onclick='delSm(this);' style='margin-top:20%; margin-left:25%;'>삭제</button>"+
								"</th>"+
								"<th class='t'>App Key</th>"+
								"<td><input type='text' class='form-control' name='smAppkeyAdd"+addNum+"'/></td>"+
							"</tr>"+
							"<tr>"+
								"<th class='t'>App Secret</th>"+
								"<td><input type='text' class='form-control' name='smSecretkeyAdd"+addNum+"'/></td>"+
							"</tr>"+
							"<tr>"+
								"<th class='t'>계정 ID</th>"+
								"<td><input type='text' class='form-control' name='accountIdAdd"+addNum+"'/></td>"+
							"</tr>"+
							"<tr>"+
								"<th class='t'>홍보문구</th>"+
								"<td colspan='2'><input type='text' class='form-control' name='expAdd"+addNum+"'/></td>"+
							"</tr>"+
						"</tbody>"+
					"</table>";

	$("#smDiv").append(rowHtml);
	frm.addNum.value = addNum;
}

function checkSmName(name,idx){
	$.ajax({
		url:"/_mngr_/socialKey/socialKey_comm_check.ajax",
		type : "post",
		data : {"smName":name, "idx":idx},
		dataType : "json",
		success : function(data){
			if(data > 0) {
				alert('이미 존재하는 ID값입니다. 중복되지 않게 입력해주세요.');
				$('input[name='+idx+']').val('');
			}
		}
		, error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

$(function(){
	/*
		코드 중복 검사
	*/
	$("input[name^='smName']").on("change",function(){
		var ptrn1 = /^[^a-zA-Z]/; //false가 정상
		var ptrn2 = /[^a-zA-Z0-9._]/; //false가 정상 +
		var str = $(this).val();
		/* if(ptrn1.test(str)){
			alert("코드명은 영문(대소문)자로 시작해야 합니다.");
			return false;
		}
		if(ptrn2.test(str)){
			alert("ID는 영문(대소문자), 숫자, ., _ 만 입력 할 수 있습니다.");
			$(this).val('');
			return false;
		}*/
		checkSmName(str, $(this).attr("name"));
	});
})

function delSm(row){
	frm = document.smKeys;
	$(row).parent().parent().parent().remove();

	if($(row).hasClass("preRow")){
		var count = $(row).attr("data-count");
		var key = "#hiddenKey"+count;
		$(key).attr("value", "");
		var checkboxid = "#delSm"+count;
		$(checkboxid).prop('checked', true);
	}else{
		var addNum = Number(frm.addNum.value)-1;
		frm.addNum.value = addNum;
	}
}

function fn_changeSite(){
	var frm = document.smKeys;
	frm.siteCode.value=$("#schSiteCode").val();
	frm.action = "?";
	frm.submit();
}

//]]>
</script>