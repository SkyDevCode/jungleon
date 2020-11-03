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
 * @파일명 : mngrManagerRegist.jsp
 * @파일정보 : 관리자관리 등록
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
<c:if test="${searchVO.isMyInfo eq 'Y' }">
<script>
	$("#content-header-h1").html("내 정보 수정");
	ItgJs.RemovePageById("${urlInfo.menuPfullcode}");
</script>
</c:if>
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
		        <form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;" class="form-horizontal">
				<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
				<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
				<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
				<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
				<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
				<input type="hidden" name="id" value="<c:out value="${searchVO.id}" />" />
				<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
				<input type="hidden" name="isMyInfo" id="isMyInfo" value="${searchVO.isMyInfo}"/>
				<input type="hidden" name="mngRole" value="${result.mngRole}"/>
				<input type="hidden" name="siteCode" value="${result.siteCode}"/>
				<input type="hidden" name="menuCodes" />
							<div class="row">
								<div class="col-xs-12 table-responsive">
									<table class="table table-bordered tp2">
										<colgroup>
											<col style="width:15%"/>
											<col style="width:35%"/>
											<col style="width:15%"/>
											<col style="width:35%"/>
										</colgroup>
										<tbody>
<c:choose>
	<c:when test="${searchVO.act eq 'REGIST' }">
										<tr>
											<th class="t"><label for="mngId">아이디*</label></th>
											<td>
											<div class="form-inline">
												<input type="text" name="mngId" id="mngId" maxlength="12" value="<c:out value="${result.mngId}"/>" class="form-control input-sm f-wd-200 required" title="아이디" onchange="fn_checkId(this.value);" />
												<span id="idHelp" class="help">영문숫자조합 4~12자(영문으로 시작)</span>
											</div>
											</td>
											<th class="t"><label for="mngName">이름*</label></th>
											<td><input type="text" name="mngName" id="mngName" maxlength="20" value="<c:out value="${result.mngName}"/>" class="form-control input-sm f-wd-200 required" title="이름" /></td>
										</tr>
	</c:when>
	<c:when test="${searchVO.act eq 'UPDATE' }">
				 							<tr>
												<th class="t"><span>아이디*</span></th>
												<td><c:out value="${result.mngId}"/></td>
												<th class="t"><span>이름*</span></th>
												<td><c:out value="${result.mngName}"/></td>
											</tr>
											<tr>
												<th class="t"><label for="mngPass">비밀번호*</label></th>
												<td>
												<div class="form-inline">
												<input type="password" name="mngPass" id="mngPass" maxlength="20" class="form-control input-sm f-wd-200" title="비밀번호" />
												<span id="pwHelp" class="help">영문, 숫자, 특수문자 조합으로 10자 이상 </span>
												</div>
												</td>
												<th class="t"><label for="mngPass2">비밀번호 확인*</label></th>
												<td><input type="password" name="mngPass2" id="mngPass2" maxlength="20" class="form-control input-sm f-wd-200" title="비밀번호 확인" /></td>
											</tr>
	</c:when>
</c:choose>
<c:if test="${searchVO.act eq 'REGIST' }">
											<tr>
												<th class="t"><label for="mngPass">비밀번호*</label></th>
												<td>
												<div class="form-inline">
												<input type="password" name="mngPass" id="mngPass" maxlength="20" class="form-control input-sm f-wd-200 required" title="비밀번호" />
												<span id="pwHelp" class="help">영문, 숫자, 특수문자 조합으로 10자 이상</span>
												</div>
												</td>
												<th class="t"><label for="mngPass2">비밀번호 확인*</label></th>
												<td><input type="password" name="mngPass2" id="mngPass2" maxlength="20" class="form-control input-sm f-wd-200 required" title="비밀번호 확인" /></td>
											</tr>
</c:if>
											<tr>
												<th class="t"><label for="mngEmail">이메일*</label></th>
												<td>
													<input type="text" name="mngEmail" id="mngEmail" maxlength="50" value="<c:out value="${ufn:seedDec256(result.mngEmail)}"/>" class="form-control input-sm f-wd-600 required validate-email" title="이메일주소" />
												</td>
												<th class="t"><label for="mngMobile">휴대폰번호</label></th>
												<td>
													<input type="text" name="mngMobile" id="mngMobile" maxlength="16" value="<c:out value="${ufn:seedDec256(result.mngMobile)}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200" title="휴대폰번호" />
												</td>
											</tr>
											<tr>
												<th class="t"><label for="mngPhone">전화번호*</label></th>
												<td>
													<input type="text" name="mngPhone" id="mngPhone" maxlength="16" value="<c:out value="${result.mngPhone}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200 required" title="전화번호" />
												</td>
												<th class="t"><label for="mngFax">팩스번호</label></th>
												<td>
													<input type="text" name="mngFax" id="mngFax" maxlength="16" value="<c:out value="${result.mngFax}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200" title="팩스번호" />
												</td>
											</tr>
											<tr>
												<th class="t"><label for="groupCode">부서</label></th>
												<td>
													<select name="groupCode" id="groupCode" title="부서" class="form-control input-sm f-wd-200">
														<option value="">부서 선택</option>
														<c:forEach var="code" items="${groupList }">
															<option value="<c:out value="${code.ccode }" />" ${ufn:selected(result.groupCode, code.ccode) }><c:out value="${code.cname }" /></option>
														</c:forEach>
													</select>
												</td>
												<th class="t"><label for="gd">직위</label></th>
												<td>
													<select name="positionCode" id="positionCode" title="직위" class="form-control input-sm f-wd-200">
														<option value="">직위 선택</option>
														<c:forEach var="code" items="${positionList }">
															<option value="<c:out value="${code.ccode }" />" ${ufn:selected(result.positionCode, code.ccode) }><c:out value="${code.cname }" /></option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr>
												<th class="t"><label for="gd">관리자등급</label></th>
												<td colspan="3">
													<c:if test="${searchVO.isMyInfo ne 'Y' }">
													<select name="mngAuth" id="mngAuth" title="관리자등급" class="form-control input-sm f-wd-200 required" onChange="changeMngAuth(this.value)">
														<option value="">등급 선택</option>
														<c:forEach var="code" items="${mngrAuthList }">
															<option value="<c:out value="${code.etc1}" />" ${ufn:selected(result.mngAuth, code.etc1) }><c:out value="${code.cname }" /></option>
														</c:forEach>
													</select>
													</c:if>
													<c:if test="${searchVO.isMyInfo eq 'Y' }">
														<input type="hidden" name="mngAuth" value="${result.mngAuth}"/>
														${ufn:deCode(result.mngAuth, '80,일반관리자,90,사이트관리자,99,총괄관리자', '')}
													</c:if>
												</td>
											</tr>
											<tr id="addMngSiteTr">
												<th class="t"><label for="jobs">담당 사이트 지정</label></th>
												<td>
													<div class="form-inline">
													<select name="whichSite" id="whichSite" title="담당 사이트" class="form-control input-sm f-wd-200">
														<option value="">사이트 선택</option>
														<c:forEach var="st" items="${siteList }">
															<option value="<c:out value="${st.siteCode}" />" ${ufn:selected(result.siteCode, st.siteCode) }><c:out value="${st.siteName }" /></option>
														</c:forEach>
													</select>
													<button type="button" class="btn btn-default btn-sm" onclick="fn_addMngSite(); return false;">추가</button>
													</div>
												</td>
												<th class="t"><label for="jobs">담당 사이트</label></th>
												<td id="siteCodeMeta"><!-- 담당 사이트 뿌려짐 -->
													<c:forEach items="${mngSiteList }" var="msl">
														<p style="margin-bottom: 0;">
															<span class="form-inline handle"><input type="hidden" value="${msl.siteCode}" name="siteCodeMeta"><span class="text">&bull; ${msl.siteName}</span>
															<span><button class="btn btn-danger btn-xs" type="button" onclick="fn_delMngSite(this); return false;" style="margin-left: 10px;">삭제</button></span>
														</p>
													</c:forEach>
												</td>
											</tr>
											<tr>
												<th class="t"><label for="jobs">담당업무*</label></th>
												<td colspan="3"><textarea name="mngWork" id="mngWork" class="form-control required" title="담당업무"><c:out value="${result.mngWork }" /></textarea></td>
											</tr>
											<tr>
												<th class="t"><span>IP제한사용여부</span></th>
												<td colspan="3">
													<label><input type="radio" name="mngIpyn" id="mngIpyn" value="Y" ${ufn:checked('Y', result.mngIpyn) } ${ufn:checked('', result.mngIpyn) } /> 허용된IP 사용 </label>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label><input type="radio" name="mngIpyn" id="mngIpyn" value="N" ${ufn:checked('N', result.mngIpyn) } /> 모든 아이피 사용</label>
												</td>
											</tr>
											<tr>
												<th class="t"><span>허용IP목록</span></th>
												<td colspan="3">
													<input type="text" name="mngIp" id="mngIp" maxlength="255" value="<c:out value="${result.mngIp}"/>" class="form-control input-sm f-wd-600 required validate-ip" title="IP 목록" placeholder="콤마(,) 로 구분" />
											</tr>
<c:if test="${searchVO.act eq 'UPDATE' }">
											<tr>
												<th class="t"><span>등록일</span></th>
												<td><c:out value="${result.regdt }" /></td>
												<th class="t"><span>등록자아이디</span></th>
												<td><c:out value="${result.regmemid }" /></td>
											</tr>
											<tr>
												<th class="t"><span>수정일</span></th>
												<td><c:out value="${result.upddt }" /></td>
												<th class="t"><span>수정자아이디</span></th>
												<td><c:out value="${result.updmemid }" /></td>
											</tr>
											<tr>
												<th class="t"><span>비밀번호 수정일</span></th>
												<td><c:out value="${result.mngPassdt }" /></td>
												<th class="t"><span>비밀번호 오류 횟수</span></th>
												<td><c:out value="${result.mngPasstrycnt }" /></td>
											</tr>
</c:if>
										</tbody>
									</table>
								</div><!-- /.col -->
							</div>
							<div class="box-footer">
			                  <div class="pull-right">
			                  <c:choose>
			                  	<c:when test="${searchVO.act == 'UPDATE' && searchVO.isMyInfo ne 'Y'}">
			                  		<button type="button" onclick="fn_goInitPass();" class="btn btn-danger">비밀번호 초기화</button>
			                  		<button  type="submit" value="" class="btn btn-primary">저장</button>
									<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
									<a href="#none" onclick="fn_goList(); return false;" class="btn btn-default">목록</a>
			                  	</c:when>
			                  	<c:when test="${searchVO.act == 'UPDATE' && searchVO.isMyInfo eq 'Y'}">
			                  		<button  type="submit" value="" class="btn btn-primary">저장</button>
			                  	</c:when>
			                  	<c:otherwise>
									<button  type="submit" value="" class="btn btn-primary">저장</button>
									<a href="#none" onclick="fn_goList(); return false;" class="btn btn-default">목록</a>
			                  	</c:otherwise>
			                  </c:choose>
			                  </div>
			                </div><!-- /.box-footer -->
        				</form>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
<script type="text/javascript">
//<[[!CDATA[
var checkFlag = false;

$(document).ready(function(){
	<c:if test="${searchVO.act eq 'UPDATE'}">
		<c:if test="${result.mngIpyn eq 'N'}">
			$("#mngIp").removeClass("required");
			$("#mngIp").attr('readonly','readonly');
		</c:if>
	</c:if>

	$("input[name=mngIpyn]").change(function(){
		changeMngIpyn(this.value);
	});

	changeMngAuth("${result.mngAuth}");
});

/* 아이피제한 사용여부 변경 */
function changeMngIpyn(value){
	if(value == 'Y'){
		$("#mngIp").addClass('required');
		$("#mngIp").removeAttr('readonly');
	}else{
		$("#mngIp").removeClass('required');
		$("#mngIp").val('');
		$("#mngIp").attr('readonly','readonly');
	}
}

/* 아이피제한 사용여부 변경 */
function changeMngAuth(value){
	if(value == '99' || value==''){
		$("#addMngSiteTr").hide();
	}else{
		$("#addMngSiteTr").show();
	}
}

/* 글 등록 function */
function fn_egov_save() {
	frm = document.form1;
	if(Validator.validate(frm)){
		<c:if test="${searchVO.act eq 'REGIST'}">
		if(!checkFlag){
			alert("아이디를 다시 입력 해 주세요.");
			return false;
		}
		var msg = ItgJs.fn_checkPass(frm.mngPass.value, frm.mngPass2.value);
		if(msg != ""){
			alert(msg);
			return false;
		}
		</c:if>
		<c:if test="${searchVO.act ne 'REGIST'}">
		if("" != frm.mngPass.value){
			var msg = ItgJs.fn_checkPass(frm.mngPass.value, frm.mngPass2.value);
			if(msg != ""){
				alert(msg);
				return false;
			}
		}
		</c:if>
		var message = Validator["validate-max-length"](frm.mngWork.value,"담당업무",'3000');
		if(message) {alert(message);frm.mngWork.focus();return false;}
		if("99" != frm.mngAuth.value){
			if($("input[name=siteCodeMeta]").length == 0){
				alert("적어도 하나 이상의 관리 사이트를 지정하셔야 합니다.");
				return false;
			}
		}
	  	frm.action = "<c:url value="${searchVO.act == 'REGIST' ? 'manager_input_proc.do' : 'manager_edit_proc.do'}"/>";
	    frm.submit();
	}
}

function fn_goList(){
	location.href="manager_list.do?<c:out value="${searchVO.query}" escapeXml="false" />"
}

function setLinktype(opt){
	if(opt == "0"){
		$("#linkTr").hide();
		$("#managerUrl").removeClass("required validate-url")
	}else if(opt == "1"){
		$("#linkTr").show();
		$("#managerUrl").addClass("required validate-url")
	}else if(opt == "2"){
		$("#linkTr").show();
		$("#managerUrl").addClass("required validate-url")
	}
}

function fn_checkId(id){
	var ptrn1 = /^[^a-zA-Z]/; //false가 정상
	var ptrn2 = /[^a-zA-Z0-9._]/; //false가 정상 +
	if(id == ""){
		return false;
	}
	if(ptrn1.test(id)){
		alert("아이디는 영문(대소문)자로 시작해야 합니다.");
		checkFlag = false;
		return false;
	}
	if(ptrn2.test(id)){
		alert("아이디는 영문(대소문자), 숫자, ., _ 만 입력 할 수 있습니다.");
		checkFlag = false;
		return false;
	}
	if(id.length<4){
		alert("아이디는 4글자 이상으로 이루어져야 합니다.");
		checkFlag = false;
		return false;
	}
	$.ajax({
		url : "manager_comm_checkId.ajax"
		, data : "id="+id
		, type : "post"
		, dataType : "json"
		, success : function(data){
			if(data.result == "0"){
				alert(data.message);//
				checkFlag = false;
				return false;
			}else if(data.result == "1"){
				$("#idHelp").text("사용가능한 아이디 입니다.");
				checkFlag = true;
			}else if(data.result == "2"){
				$("#idHelp").text("중복된 아이디 입니다.");
				checkFlag = false;
			}else{
				$("#idHelp").text("아이디를 다시 입력 해 주세요.");
				checkFlag = false;
			}
		}
		, error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

<c:if test="${searchVO.act == 'UPDATE' }">
function fn_goInitPass(){
	if(confirm("비밀번호를 초기화 하시겠습니까? \n비밀번호는 아이디와 동일하게 초기화되며, 비밀번호 오류 횟수도 초기화 됩니다")){
		var frm = document.form1;
		frm.encoding = "application/x-www-form-urlencoded";
		frm.action = "manager_edit_pass.do";
		frm.submit();
	}
}

function fn_goDel(){
	if(confirm("삭제하시겠습니까?")){
		var frm = document.form1;
		frm.encoding = "application/x-www-form-urlencoded";
		frm.action = "manager_delete_proc.do";
		frm.submit();
	}
}
</c:if>

function fn_addMngSite() {
	var f = document.form1;
	var addSite = f.whichSite.value;
	//사이트 선택 추가시 예외처리
	if(addSite == ""){
		alert("사이트를 선택해 주세요.");
		return false;
	}
	//동일한 사이트 추가시 예외처리
	var addedSite = f.siteCodeMeta;
	if(typeof addedSite !== 'undefined'){
		if(Object.prototype.toString.call(addedSite) === "[object HTMLInputElement]"){
			if(addedSite.value == addSite){
				alert("이미 추가된 사이트 입니다.");
				return false;
			}
		}
		else if(Object.prototype.toString.call(addedSite) === "[object RadioNodeList]"){
			var tmpArry = Array.from(addedSite);
				for(var i=0;i<tmpArry.length;i++){
					if(tmpArry[i].value == addSite){
						alert("이미 추가된 사이트 입니다.");
						return false;
					}
				}
		}
	}

	var addSiteName = $('#whichSite option:selected').text();
	var addcon = null;

	$('#siteCodeMeta').append(addContents2(addSite,addSiteName));
}

function addContents2(addSite,addSiteName) {
	return '<li>'+
	'<span class="form-inline handle"><input type="hidden" value="'+addSite+'" name="siteCodeMeta"><span class="text">'+addSiteName+'</span>'+
	'<span><button class="btn btn-danger btn-xs" type="button" onclick="fn_delMngSite(this); return false;">삭제</button></span>'+
	'</li>';
}

function fn_delMngSite(target) {
	$(target).parent().parent().parent().remove();
}
//]]>
</script>
