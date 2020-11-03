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
 * @파일명 : mngrComemberView.jsp
 * @파일정보 : 기업회원관리 등록/조회 페이지
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 7. 5. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
				        <form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;" class="form-horizontal">
						<input type="hidden" name="schId" value="<c:out value="${searchVO.schId }" />" />
						<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
						<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
						<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
						<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
						<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
						<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
						<input type="hidden" name="menuCodes" />
							<div class="row">
								<div class="col-xs-12 table-responsive">
									<table class="table table-bordered tp2">
										<colgroup>
											<col style="width:12%"/>
											<col style="width:12%"/>
											<col style="width:14%"/>
											<col style="width:12%"/>
											<col style="width:12%"/>
											<col style="width:12%"/>
											<col style="width:12%"/>
											<col style="width:14%"/>
										</colgroup>
										<tbody>
											<tr>
												<th class="t"><label for="comemName">기업명*</label></th>
												<td colspan="7">
								                	<input type="hidden" name="namePass" id="namePass" value="N" />
													<c:if test="${searchVO.act == 'REGIST' }">
													<input type="text" name="comemName" id="comemName" maxlength="30" value="<c:out value="${result.comemName}"/>" class="form-control input-sm f-wd-400 required" title="기업명" onchange="fn_checkName();" />
													<span id="nameHelp" style="color:#999"></span>
													</c:if>
													<c:if test="${searchVO.act == 'UPDATE' }">
													<p>${result.comemName}</p>
													</c:if>
												</td>
											</tr>
											<tr>
												<th class="t"><label for="comemCeonm">대표자명*</label></th>
												<td colspan="7">
													<input type="text" name="comemCeonm" id="comemCeonm" maxlength="15" value="<c:out value="${result.comemCeonm}"/>" class="form-control input-sm f-wd-200 required" title="대표자이름" />
												</td>
											</tr>
											<tr>
												<th class="t">주소(본사)*</th>
												<td colspan="7">
													<div class="form-inline">
														<input type="text" name="comemPost" id="post1st" maxlength="6" value="<c:out value="${result.comemPost}"/>" title="우편번호" class="form-control input-sm f-wd-100 required" readonly="readonly" />
														<button type="button" class="btn btn-default btn-sm" onclick="ItgJs.getDaumAddressLayer1st();">우편번호 찾기<!-- [다음(레이어)] --></button>
													</div>
													<div class="form-inline" style="margin-top: 5px;">
														<input type="text" name="comemAddr1" id="addr1st1" value="<c:out value="${result.comemAddr1}"/>" title="주소" class="form-control input-sm f-wd-400 required" readonly="readonly" style="width:400px"/>
														<input type="text" name="comemAddr2" id="addr1st2" value="<c:out value="${result.comemAddr2}"/>" title="상세주소" class="form-control input-sm f-wd-400" style="width:400px"/>
													</div>
													<span id="oldAddr1st" style="color:#999"></span>
													<span id="oldAddr1stHelp" style="color:#999"></span>
													<span id="guide1st" style="color:#999"></span>
												</td>
											</tr>
											<tr>
												<th class="t"><label for="comemCodeType">업태*</label></th>
												<td colspan="2">
													<input type="text" name="comemCodeType" id="comemCodeType" maxlength="20" value="<c:out value="${result.comemCodeType}"/>" class="form-control input-sm f-wd-600 required" title="업태" />
												</td>
												<th class="t" colspan="1"><label for="comemCodeCate">업종*</label></th>
												<td colspan="2">
													<input type="text" name="comemCodeCate" id="comemCodeCate" maxlength="20" value="<c:out value="${result.comemCodeCate}"/>" class="form-control input-sm f-wd-600 required" title="업종" />
												</td>
												<th class="t" colspan="1"><label for="comemEmpl">상시근로자수*</label></th>
												<td>
													<div class="form-inline">
													<input type="text" name="comemEmpl" id="comemEmpl" maxlength="4" value="<c:out value="${result.comemEmpl}"/>" class="form-control input-sm f-wd-100 required validate-digits" onkeydown="return ItgJs.fn_numberOnly(event);" title="상시근로자수" />명
													</div>
												</td>
											</tr>
											<tr>
												<th class="t" rowspan="4"><label>교육(인사)<br/>담당자</label></th>
												<th class="t" colspan="1"><label for="comemChrgeName">성명*</label></th>
												<td colspan="3">
													<input type="text" name="comemChrgeName" id="comemChrgeName" maxlength="50" value="<c:out value="${result.comemChrgeName}"/>" class="form-control input-sm f-wd-600 required" title="담당자성명" />
												</td>
												<th class="t" colspan="1"><label for="comemChrgeGrp">HRD 부서명*</label></th>
												<td colspan="2">
													<input type="text" name="comemChrgeGrp" id="comemChrgeGrp" maxlength="50" value="<c:out value="${result.comemChrgeGrp}"/>" class="form-control input-sm f-wd-600 required" title="HRD 부서명" />
												</td>
											</tr>
											<tr>
												<th class="t" colspan="1"><label for="comemChrgeAddr">주소*<br/>(담당자 사무실)</label></th>
												<td colspan="6">
													<div class="form-inline">
														<input type="text" name="comemChrgePost" id="post2nd" maxlength="6" value="<c:out value="${result.comemChrgePost}"/>" title="우편번호" class="form-control input-sm f-wd-100 required" readonly="readonly" />
														<button type="button" class="btn btn-default btn-sm" onclick="ItgJs.getDaumAddressLayer2nd();">우편번호 찾기<!-- [다음(레이어)] --></button>
														<button type="button" class="btn btn-default btn-sm" onclick="fn_copyAddr1();">본사동일<!-- [다음(레이어)] --></button>
													</div>
													<div class="form-inline" style="margin-top: 5px;">
														<input type="text" name="comemChrgeAddr1" id="addr2nd1" value="<c:out value="${result.comemChrgeAddr1}"/>" title="주소" class="form-control input-sm f-wd-400 required" readonly="readonly" style="width:400px"/>
														<input type="text" name="comemChrgeAddr2" id="addr2nd2" value="<c:out value="${result.comemChrgeAddr2}"/>" title="상세주소" class="form-control input-sm f-wd-400" style="width:400px" />
													</div>
													<span id="oldAddr2nd" style="color:#999"></span>
													<span id="oldAddr2ndHelp" style="color:#999"></span>
													<span id="guide2nd" style="color:#999"></span>
												</td>
											</tr>
											<tr>
												<th class="t" colspan="1"><label for="comemChrgeTel">사무실전화번호*</label></th>
												<td colspan="3">
													<input type="text" name="comemChrgeTel" id="comemChrgeTel" maxlength="13" value="<c:out value="${result.comemChrgeTel}"/>" class="form-control input-sm f-wd-200 required validate-tel-num" onkeydown="return ItgJs.fn_phone(event);" title="담당자 사무실전화번호" />
												</td>
												<th class="t" colspan="1"><label for="comemChrgeMail">이메일*</label></th>
												<td colspan="2">
													<input type="text" name="comemChrgeMail" id="comemChrgeMail" maxlength="50" value="<c:out value="${result.comemChrgeMail}"/>" class="form-control input-sm f-wd-600 required validate-email" title="담당자이메일" />
												</td>
											</tr>
											<tr>
												<th class="t" colspan="1"><label for="comemChrgeCell">휴대폰*</label></th>
												<td colspan="6">
													<input type="text" name="comemChrgeCell" id="comemChrgeCell" maxlength="13" value="<c:out value="${result.comemChrgeCell}"/>" class="form-control input-sm f-wd-200 required validate-tel-num" onkeydown="return ItgJs.fn_phone(event);" title="담당자휴대폰" />
												</td>
												<!-- <th class="t" colspan="1"></th>
												<td colspan="3"></td> -->
											</tr>
											<tr>
												<th class="t" colspan="1"><label for="comemChrgeTname">팀장성명*</label></th>
												<td colspan="3">
													<input type="text" name="comemChrgeTname" id="comemChrgeTname" maxlength="60" value="<c:out value="${result.comemChrgeTname}"/>" class="form-control input-sm f-wd-200 required" title="팀장성명" />
												</td>
												<th class="t" colspan="1"><label for="comemChrgeTmail">팀장이메일*</label></th>
												<td colspan="3">
													<input type="text" name="comemChrgeTmail" id="comemChrgeTmail" maxlength="50" value="<c:out value="${result.comemChrgeTmail}"/>" class="form-control input-sm f-wd-600 required validate-email" title="팀장이메일" />
												</td>
											</tr>
											<tr>
												<th class="t"><label for="etc1">고용보험관리번호*</label></th>
												<td colspan="4">
													<input type="text" name="etc1" id="etc1" maxlength="12" value="<c:out value="${result.etc1}"/>" class="form-control input-sm f-wd-200 required" onkeydown="return ItgJs.fn_phone(event);" title="고용보험관리번호" />
												</td>
												<th class="t" colspan="1"><label for="comemComno">사업자등록번호*</label></th>
												<td colspan="2">
													<input type="hidden" name="comemComno" id="comemComno" value="<c:out value="${result.comemComno}"/>" class="form-control input-sm f-wd-600 required" title="사업자등록번호" />
								                	<input type="hidden" name="comNoPass" id="comNoPass" value="N" />
								                	<c:if test="${searchVO.act == 'REGIST' }">
								                	<div class="form-inline">
									                <input type="text" name="comemComno1" maxlength="3"  value="${ufn:strSplit(result.comemComno,'-')[0]}" class="form-control input-sm f-wd-100 required validate-digits" onkeydown="return ItgJs.fn_numberOnly(event);" onkeyup="fn_checkComNo()"/>
									                -<input type="text" name="comemComno2" maxlength="2" value="${ufn:strSplit(result.comemComno,'-')[1]}" class="form-control input-sm f-wd-100 required validate-digits" onkeydown="return ItgJs.fn_numberOnly(event);" onkeyup="fn_checkComNo()"/>
									                -<input type="text" name="comemComno3" maxlength="5" value="${ufn:strSplit(result.comemComno,'-')[2]}" class="form-control input-sm f-wd-100 required validate-digits" onkeydown="return ItgJs.fn_numberOnly(event);" onkeyup="fn_checkComNo()"/>
													</div>
													<span id="comNoHelp" style="color:#999"></span>
													</c:if>
													<c:if test="${searchVO.act == 'UPDATE' }">
													<h4>${result.comemComno}</h4><span id="comNoHelp" style="color:#999">사업자 등록 번호는 수정할 수 없습니다.</span>
													</c:if>
												</td>
											</tr>
											<tr>
												<th class="t"><label for="comemStatus">기업상태</label></th>
												<td colspan="7">
													<c:out value="${result.comemStatusNm}"/>
												</td>
											</tr>
										</tbody>
									</table>
								</div><!-- /.col -->
							</div>
						<div class="box-footer">
                  			<div class="pull-right">
								<a href="#none" onclick="fn_egov_save(); return false;" class="btn btn-primary" >저장</a>
								<c:if test="${searchVO.act == 'UPDATE' }">
									<a href="#none" onclick="fn_dropComember(); return false;" class="btn btn-danger">탈퇴</a>
								</c:if>
								<a href="#none" onclick="fn_goList(); return false;" class="btn btn-default">목록</a>
                  			</div>
                		</div><!-- /.box-footer -->
        			</form>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->

<script type="text/javascript">
//<[[!CDATA[
var nameChkFlag = false;
var comNochkFlag = false;
//R: 도로명, J: 지번
var addr = "R";
var queryString = '<c:out value="${searchVO.queryString()}" escapeXml="false" />';

$(document).ready(function(){
	<c:if test="${searchVO.act == 'UPDATE' }">
	</c:if>
});

/* 글 등록 function */
function fn_egov_save() {
	frm = document.form1;
	if(Validator.validate(frm)){
		<c:if test="${searchVO.act == 'REGIST' }">
			if(!nameChkFlag){
				alert("등록 가능한 기업명을 입력해 주세요.");
				frm.comemName.focus();
				return false;
			}
			if(!comNochkFlag){
				alert("등록 가능한 사업자 등록 번호를 입력해 주세요.");
				frm.comemComno1.focus();
				return false;
			}
			var message = Validator["validate-max-length"](frm.comemChrgeTname.value,"팀장성명",'60');
			if(message) {
				alert(message);
				frm.comemChrgeTname.focus();
				return false;
			}
			message = Validator["validate-max-length"](frm.comemChrgeGrp.value,"HRD 부서명",'60');
			if(message) {
				alert(message);
				frm.comemChrgeGrp.focus();
				return false;
			}
			frm.action = "<c:url value="comember_input_proc.do"/>";
		    frm.submit();
		</c:if>
		<c:if test="${searchVO.act == 'UPDATE' }">
			var message = Validator["validate-max-length"](frm.comemChrgeTname.value,"팀장성명",'60');
			if(message) {alert(message);frm.comemChrgeTname.focus();return false;}
			message = Validator["validate-max-length"](frm.comemChrgeGrp.value,"HRD 부서명",'60');
			if(message) {alert(message);frm.comemChrgeGrp.focus();return false;}
			frm.comNoPass.value = "Y";
			frm.namePass.value = "Y";
			fn_infoUpdate()
		</c:if>
	}
}

function fn_infoUpdate(){
	var frm = document.form1;
	var resultCode;
	$.ajax({
		url : "comember_edit_proc.do"
		, data : $(frm).serialize()
		, type : "post"
		, dataType : "json"
		, success : function(data){
			if(data.resultCode > 0){
				alert("정상적으로 처리되었습니다.");
			}else{
				alert("업데이트 된 항목이 없습니다.");
			}
		}
		, error : function(jqXHR,textStatus,e){
			alert("업데이트 중 오류가 발생하였습니다. 관리자에게 문의해 주세요.");
			return;
		}
	});
}

function fn_copyAddr1(){
	var frm = document.form1;
	$("#post2nd").val(frm.comemPost.value);
	$("#addr2nd1").val(frm.comemAddr1.value);
	$("#addr2nd2").val(frm.comemAddr2.value);
}

function fn_goList(){
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", "");
	location.href="comember_list.do?"+tmpQuery;
}

function fn_checkComNo(){
 	var frm = document.form1;
	if(frm.comemComno1.value == "" || frm.comemComno2.value == "" || frm.comemComno3.value == ""){
		$("#comNoHelp").text("사업자번호가 완성되지 않았습니다.");
     	if(frm.comemComno1.value == ""||frm.comemComno1.value.length != 3){
     		frm.comemComno1.focus();
     	}else if(frm.comemComno2.value == "" ||frm.comemComno2.value.length != 2){
     		frm.comemComno2.focus();
     	}else if(frm.comemComno3.value == "" ||frm.comemComno3.value.length != 5){
     		frm.comemComno3.focus();
     	}
     	return;
     }
	//alert(frm.id.value );
	var comemComno = frm.comemComno1.value+"-"+frm.comemComno2.value+"-"+frm.comemComno3.value;
	var params = { schOpt2 : comemComno }; //파라미터 선언

	frm.comemComno.value = comemComno;
	if(ItgJs.fn_bisCheck(comemComno)){
		$("#comNoHelp").text("사업자 번호를 검증중입니다.");
		$.getJSON("/common/module/mngrComemberComnoChkAjax.do", params, function (returnData, textStatus){
			if(textStatus == 'success'){
				//alert(returnData.resultCode);
				if(returnData.resultCode == "0"){
					//alert("사용할 수 있는 사업자번호입니다.");
					comNochkFlag = true;
					$("#comNoHelp").text("사용할 수 있는 사업자번호입니다.");
					frm.comNoPass.value = "Y";
				}else{
					//alert("이미 등록된 사업자입니다.");
					$("#comNoHelp").text("이미 등록된 사업자입니다.");
					comNochkFlag = false;
					frm.comemComno.focus();
					frm.comNoPass.value = "N";
				}
				//sample 객체에 SELECT 옵션내용 추가.
				//alert(returnData);
			} else {
				$("#comNoHelp").text("사업자 번호를 검증 할 수 없습니다. 관리자에게 문의해주세요.");
				comNochkFlag = false;
				frm.comNoPass.value = "N";
				return;
			}
		});
	}else{
		//alert("유효하지 않은 사업자번호입니다.\n확인 후 다시 입력 해 주세요.");
		$("#comNoHelp").text("유효하지 않은 사업자번호입니다. 확인 후 다시 입력 해 주세요.");
		comNochkFlag = false;
		frm.comemComno.focus();
    	return;
	}

	//frm.comemComno.value = frm.comemComno1.value+"-"+frm.comemComno2.value+"-"+frm.comemComno3.value;
	//comNochkFlag = true;//테스트 가입용
}

function fn_checkName(){
	var frm = document.form1;
	var comemName = frm.comemName.value;
	var params = { schOpt2 : comemName }; //파라미터 선언
	var resultCode;
	if(comemName.length!=0){
		$("#nameHelp").text("등록 가능한 기업명을 검증중입니다.");
		$.ajax({
			url : "/common/module/mngrComemberConameChkAjax.do"
			, data : params
			, type : "post"
			, dataType : "json"
			, success : function(data){
				if(data.resultCode == "0"){
					$("#nameHelp").text("등록 가능한 기업입니다.");
					nameChkFlag = true;
					frm.namePass.value = "Y";
				}else{
					//alert("이미 등록된 사업자입니다.");
					$("#nameHelp").text("동일한 이름의 기업이 이미 등록되어있습니다. 관리자에게 문의해 주세요.");
					nameChkFlag = false;
					frm.comemName.focus();
					frm.namePass.value = "N";
				}
			}
			, error : function(jqXHR,textStatus,e){
				$("#nameHelp").text("기업명을 검증 할 수 없습니다. 관리자에게 문의해주세요.");
				nameChkFlag = false;
				frm.namePass.value = "N";
				return;
			}
		});
	}else{
		$("#nameHelp").text("기업명을 입력해 주세요");
		nameChkFlag = false;
		frm.comemName.focus();
    	return;
	}
}

<c:if test="${searchVO.act == 'UPDATE' }">
function fn_dropComember(){
	if(confirm("탈퇴하시겠습니까?")){
		var frm = document.form1;
		frm.encoding = "application/x-www-form-urlencoded";
		frm.action = "comember_delete_proc.do";
		frm.submit();
	}
}
</c:if>
//]]>
</script>
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="daumPostLayer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer"
	     style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="ItgJs.getDaumAddressLayerClose()" alt="닫기 버튼">
</div>