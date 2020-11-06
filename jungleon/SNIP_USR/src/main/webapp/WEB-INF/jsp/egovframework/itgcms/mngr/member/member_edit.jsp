<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%
	/**
	 * @파일명 : mngrMemberRegist.jsp
	 * @파일정보 : 회원관리 등록
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
<!-- daum 도로명 주소 api -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
/**
 * 2016.09.23 형철
   회원관리 > 일반회원관리
   차단 , 허용 스크립트 삽입
   허용일 경우 input 값 쓰기 방지 함]

 */
$(document).ready(function(){
	//페이지 로딩시 차단 메뉴가 허용으로 되어 있기 때문에 아래 구분 삽입
	$("#cutoffReason").attr("readonly", "readonly");

	//차단 했을 경우 차단 사유 입력
	$("#cutoffY").on('click',function(){
		$("#cutoffReason").removeAttr("readonly");
	});

	//허용 했을 경우 사유 입력 못합
	$("#cutoffN").on('click',function(){
		$("#cutoffReason").attr("readonly", "readonly");
	});

	// 차단 초기 세팅
	if("${result.status}"=="mem_normal"){ //허용
		$("#cutoffReason").attr("readonly", "readonly");
	}else if("${result.status}"=="mem_cutoff"){ //차단
		$("#cutoffReason").removeAttr("readonly");
	}

	$('#cutoffReason').keyup(function(){
		if($('#cutoffReason').val().length >= 120){
			alert("120자 까지만 가능 합니다.");
		}
	});

	/* $('#code').keyup(function(){
		if($('#code').val().length >= 2){
			alert("회원코드은 2자리수 입니다.");
		}
	}); */
});
</script>

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
						<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
						<input type="hidden" name="schExcel" value="<c:out value="${searchVO.schExcel }" />" />
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
											<c:when test="${searchVO.act == 'REGIST'}">
												<tr>
													<th class="t"><label for="id">아이디*</label></th>
													<td>
														<div class="form-inline">
															<input type="text" name="id" id="id" maxlength="20" value="<c:out value="${result.id}"/>" class="form-control input-sm f-wd-200 required" title="아이디" onchange="fn_checkId(this.value);" />
															<span id="idHelp" class="help">영문숫자조합 (영문으로 시작, 4 ~ 12자)</span>
														</div>
													</td>
													<th class="t"><label for="name">이름<c:out value="${joinForm.name == 1 ? '*' : ''}"/></label></th>
													<td><input type="text" name="name" id="name" maxlength="20" value="<c:out value="${result.name}"/>" class="form-control input-sm f-wd-200 <c:out value="${joinForm.name == 1 ? 'required' : ''}"/>" title="이름" /></td>
												</tr>
											</c:when>
											<c:when test="${searchVO.act == 'UPDATE'}">
												<tr>
													<th class="t"><span>아이디*</span></th>
													<td>
														<c:out value="${result.id}"/>
														<c:choose>
															<c:when test="${result.status eq 'mem_cutoff'}">
																<span style="color:#1A90D8;padding-left:5px;">[차단된 사용자 정보]</span>
															</c:when>
														</c:choose>
														<input type="hidden" name="id" id="id" value="<c:out value="${result.id}"/>">
													</td>
													<th class="t"><span>이름*</span></th>
													<td><c:out value="${result.name}"/></td>
												</tr>
											</c:when>
										</c:choose>
										<c:if test="${searchVO.act == 'REGIST'}">
											<tr>
												<th class="t"><label for="pass">비밀번호*</label></th>
												<td>
													<div class="form-inline">
														<input type="password" name="pass" id="pass" maxlength="20" class="form-control input-sm f-wd-200 required" title="비밀번호" />
														<span id="pwHelp" class="help">영문, 숫자, 특수문자의 조합으로 9자리 이상</span>
													</div>
												</td>
												<th class="t"><label for="pass2">비밀번호 확인*</label></th>
												<td><input type="password" name="pass2" id="pass2" maxlength="20" class="form-control input-sm f-wd-200 required" title="비밀번호 확인" /></td>
											</tr>
										</c:if>
										<tr>
											<th class="t"><label for="birth">생년월일<c:out value="${joinForm.birth == 1 ? '*' : ''}"/></label></th>
											<td>
												<div class="form-inline">
														<input type="text" name="birth" id="birth" maxlength="10" value="<c:out value="${result.birth}"/>" class="form-control input-sm f-wd-200 validate-date <c:out value="${joinForm.birth == 1 ? 'required' : ''}"/>" title="생년월일"/>
														<span id="pwHelp" class="help">예)2016-01-01</span>
												</div>
											</td>
											<th class="t"><span>성별<c:out value="${joinForm.sex == 1 ? '*' : ''}"/></span></th>
											<td>
												<label><input type="radio" name="sex" id="sexM" value="M" ${ufn:checked('M', result.sex)} ${ufn:checked('', result.sex)} /> 남성</label>
												<label><input type="radio" name="sex" id="sexF" value="F" ${ufn:checked('F', result.sex)} /> 여성</label>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="email">이메일<c:out value="${joinForm.email == 1 ? '*' : ''}"/></label></th>
											<td>
												<input type="text" name="email" id="email" maxlength="50" value="<c:out value="${result.email}"/>" class="form-control input-sm f-wd-200 validate-email <c:out value="${joinForm.name == 1 ? 'email' : ''}"/>" title="이메일주소" />
											</td>
											<th class="t"><label for="nickName">닉네임<c:out value="${joinForm.nickName == 1 ? '*' : ''}"/></label></th>
											<td>
												<div class="form-inline">
													<input type="text" name="nickName" id="nickName" maxlength="30" value="<c:out value="${result.nickName}"/>" class="form-control input-sm f-wd-200 <c:out value="${joinForm.nickName == 1 ? 'required' : ''}"/>" title="닉네임"
													       onchange="fn_checkNickName(this.value);"/>
													<span id="nickHelp" class="help"></span>
													<input type="hidden" name="nickName2" id="nickName2" value="<c:out value="${result.nickName}"/>">
												</div>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="phone">전화번호<c:out value="${joinForm.phone == 1 ? '*' : ''}"/></label></th>
											<td>
												<input type="text" name="phone" id="phone" maxlength="16" value="<c:out value="${result.phone}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200 <c:out value="${joinForm.phone == 1 ? 'required' : ''}"/>" title="전화번호" />
											</td>
											<th class="t"><label for="mobile">휴대폰번호<c:out value="${joinForm.mobile == 1 ? '*' : ''}"/></label></th>
											<td>
												<input type="text" name="mobile" id="mobile" maxlength="16" value="<c:out value="${result.mobile}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200 <c:out value="${joinForm.mobile == 1 ? 'required' : ''}"/>" title="휴대폰번호" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="fax">팩스번호<c:out value="${joinForm.fax == 1 ? '*' : ''}"/></label></th>
											<td>
												<input type="text" name="fax" id="fax" maxlength="16" value="<c:out value="${result.fax}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200 <c:out value="${joinForm.fax == 1 ? 'required' : ''}"/>" title="팩스번호" />
											</td>
											<%-- <th class="t"><label for="code">회원코드</label></th>
											<td>
												<input type="text" name="code" id="code" maxlength="2" onkeydown="return ItgJs.fn_numberOnly(event)"  value="<c:out value="${result.code}"/>" class="form-control input-sm f-wd-200" title="회원코드" />
											</td> --%>

											<th class="t"><label for="fax">직급</label></th>
											<td>
												<input type="text" name="position" id="position" maxlength="16" value="<c:out value="${result.position}"/>" class="form-control input-sm f-wd-200" title="직급" />
											</td>
										<tr/>
										<tr>
											<th class="t"><label for="oldPost">우편번호</label></th>
											<td colspan="3">
												<div class="form-inline">
													<input type="text" name="oldPost" id="oldPost" maxlength="6" value="<c:out value="${result.oldPost}"/>" title="우편번호" class="form-control input-sm f-wd-100" readonly="readonly" />
													<input type="text" name="newPost" id="newPost" maxlength="6" value="<c:out value="${result.newPost}"/>" title="우편번호" class="form-control input-sm f-wd-100" readonly="readonly" />
													<!-- <button type="button" class="btn btn-default btn-sm" onclick="ItgJs.getDaumAddressPopup();">우편번호 찾기[다음(팝업)]</button> -->
													<button type="button" class="btn btn-default btn-sm" onclick="ItgJs.getDaumAddressLayer();">우편번호 찾기<!-- [다음(레이어)] --></button>
													<!-- <button type="button" class="btn btn-default btn-sm" onclick="getAddressLayer();">우편번호 찾기[우체국]</button> -->
												</div>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="newAddr1">주소</label></th>
											<td colspan="3">
												<div class="form-inline">
													<input type="text" name="newAddr1" id="newAddr1" value="<c:out value="${result.newAddr1}"/>" title="주소" class="form-control input-sm f-wd-400" readonly="readonly" style="width:400px"/>
													<input type="text" name="newAddr2" id="newAddr2" value="<c:out value="${result.newAddr2}"/>" title="상세주소" class="form-control input-sm f-wd-400" />

													<input type="text" name="oldAddr1" id="oldAddr1" value="<c:out value="${result.oldAddr1}"/>" title="주소" class="form-control input-sm f-wd-400" readonly="readonly" />
													<input type="text" name="oldAddr2" id="oldAddr2" value="<c:out value="${result.oldAddr2}"/>" title="상세주소" class="form-control input-sm f-wd-400" />
												</div>
												<span id="guide" style="color:#999"></span>
											</td>
										</tr>
										<%-- <tr>
											<th class="t"><label for="group">회원그룹</label></th>
											<td>
												<input type="text" name="group" id="group" maxlength="16" value="<c:out value="${result.group}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200" title="회원그룹" />
											</td>
											<th class="t"><label for="type">회원타입</label></th>
											<td>
												<input type="text" name="type" id="type" maxlength="16" value="<c:out value="${result.type}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200" title="회원타입" />
											</td>
										</tr> --%>
										<tr>
											<th class="t"><span>회원상태</span></th>
											<td>
												<select name="status" class="form-control required">
													<c:forEach var="status" items="${statusCodeList}">
														<option value="${status.ccode}" <c:out value="${result.status eq status.ccode ? 'selected' : ''}"/>>${status.cname}</option>
													</c:forEach>
												</select>
											</td>
											<th class="t"><span>차단일</span></th>
											<td><c:out value="${result.cutoffDt}" /></td>
										</tr>
										<tr>
											<th class="t"><span>차단 사유</span></th>
											<td colspan="3">
												<textarea id="cutoffReason" name="cutoffReason" class="form-control" title="차단사유" maxlength="120" ><c:out value="${result.cutoffReason}" /></textarea>
											</td>
										</tr>
									<c:if test="${searchVO.act == 'UPDATE'}">
										<tr>
											<th class="t"><span>등록일</span></th>
											<td><c:out value="${result.regDt}" /></td>
											<th class="t"><span>등록자아이디</span></th>
											<td><c:out value="${result.regId}" /></td>
										</tr>
										<tr>
											<th class="t"><span>등록아이피</span></th>
											<td colspan="3">
												<c:out value="${result.regIp}" />
												<c:if test="${!empty result.regCountryCd}">
													&nbsp;<img src="<c:url value="/images/egovframework/com/cmm/icon/ico_flag" />/<c:out value="${result.regCountryCd}" />.png" title="<c:out value="${result.regCountryName}" />" />
												</c:if>
												<c:if test="${!empty result.regOsIcon}">
													&nbsp;<img src="<c:url value="/images/egovframework/com/cmm/icon/ico_os" />/<c:out value="${result.regOsIcon}" />" title="<c:out value="${result.regOs}" />" />
												</c:if>
												<c:if test="${!empty result.regBrowserIcon}">
													&nbsp;<img src="<c:url value="/images/egovframework/com/cmm/icon/ico_ua" />/<c:out value="${result.regBrowserIcon}" />" title="<c:out value="${result.regBrowser}" />" />
												</c:if>
											</td>
										</tr>
										<tr>
											<th class="t"><span>수정일</span></th>
											<td><c:out value="${result.updDt}" /></td>
											<th class="t"><span>수정자아이디</span></th>
											<td><c:out value="${result.updId}" /></td>
										</tr>
										<tr>
											<th class="t"><span>수정아이피</span></th>
											<td colspan="3">
												<c:out value="${result.updIp}" />
											</td>
										</tr>
										<tr>
											<th class="t"><span>비밀번호 수정일</span></th>
											<td><c:out value="${result.passDt}" /></td>
											<th class="t"><span>비밀번호 오류 횟수</span></th>
											<td><c:out value="${result.passTryCnt}" /></td>
										</tr>
										<tr>
											<th class="t"><span>삭제일</span></th>
											<td><c:out value="${result.delDt}" /></td>
											<th class="t"><span>삭제아이디</span></th>
											<td><c:out value="${result.delId}" /></td>
										</tr>
										<tr>
											<th class="t"><span>삭제아이피</span></th>
											<td colspan="3">
												<c:out value="${result.delIp}" />
											</td>
										</tr>
										<tr>
											<th class="t"><span>접속일</span></th>
											<td><c:out value="${result.loginDt}" /></td>
											<th class="t"><span>접속아이피</span></th>
											<td>
												<c:out value="${result.loginIp}" />
												<c:if test="${!empty result.loginCountryCd}">
													&nbsp;<img src="<c:url value="/images/egovframework/com/cmm/icon/ico_flag" />/<c:out value="${result.loginCountryCd}" />.png" title="<c:out value="${result.loginCountryName}" />" />
												</c:if>
												<c:if test="${!empty result.loginOsIcon}">
													&nbsp;<img src="<c:url value="/images/egovframework/com/cmm/icon/ico_os" />/<c:out value="${result.loginOsIcon}" />" title="<c:out value="${result.loginOs}" />" />
												</c:if>
												<c:if test="${!empty result.loginBrowserIcon}">
													&nbsp;<img src="<c:url value="/images/egovframework/com/cmm/icon/ico_ua" />/<c:out value="${result.loginBrowserIcon}" />" title="<c:out value="${result.loginBrowser}" />" />
												</c:if>
											</td>
										</tr>
									</c:if>
										<tr>
											<th class="t"><span>문자수신</span></th>
											<td>
												<label><input type="radio" name="smsYn" id="smsY" value="Y" ${ufn:checked('Y', fn:toUpperCase(result.smsYn))} ${ufn:checked('', fn:toUpperCase(result.smsYn))}/> 수신</label>
												<label><input type="radio" name="smsYn" id="smsN" value="N" ${ufn:checked('N', fn:toUpperCase(result.smsYn))} /> 미수신</label>
											</td>
											<th class="t"><span>이메일수신</span></th>
											<td>
												<label><input type="radio" name="emailYn" id="emailY" value="Y" ${ufn:checked('Y', fn:toUpperCase(result.emailYn))} ${ufn:checked('', fn:toUpperCase(result.emailYn))} /> 수신</label>
												<label><input type="radio" name="emailYn" id="emailN" value="N" ${ufn:checked('N', fn:toUpperCase(result.emailYn))} /> 미수신</label>
											</td>
										</tr>
										<tr>
											<th class="t"><span>정보공개</span></th>
											<td colspan="3">
												<label><input type="radio" name="infoOpenYn" id="memInfoOpenY" value="Y" ${ufn:checked('Y', result.infoOpenYn)} ${ufn:checked('', result.infoOpenYn)} /> 공개</label>
												<label><input type="radio" name="infoOpenYn" id="memInfoOpenN" value="N" ${ufn:checked('N', result.infoOpenYn) } /> 미공개</label>
											</td>
										</tr>
										</tbody>
									</table>
								</div><!-- /.col -->
							</div>
							<div class="box-footer">
								<div class="pull-right">
									<c:if test="${searchVO.act == 'UPDATE'}">
										<button type="button" onclick="fn_goInitPass();" class="btn btn-danger">비밀번호 초기화</button>
										<button type="submit" value="" class="btn btn-primary">저장</button>
										<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
									</c:if>
									<c:if test="${searchVO.act == 'REGIST'}">
										<button type="submit" value="" class="btn btn-primary">저장</button>
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
	$(document).ready(function() {
		$("#oldPost").hide();
		$("#oldAddr1").hide();
		$("#oldAddr2").hide();

		$("#modalpopup").show();
	});

	var checkFlagId = false;
	var checkFlagNickName = false;
	//R: 도로명, J: 지번
	var addr = "R";

	/* 글 등록 function */
	function fn_egov_save() {
		var frm = document.form1;
		if (Validator.validate(frm)) {
			<c:if test="${searchVO.act == 'REGIST'}">
				if (!checkFlagId) {
					alert("아이디를 다시 입력 해 주세요.");
					return false;
				}
				if (!checkFlagNickName && frm.nickName.value != "") {
					alert("닉네임을 다시 입력 해 주세요.");
					return false;
				}
				var msg = ItgJs.fn_checkPass(frm.pass.value, frm.pass2.value);
				if (msg != "") {
					alert(msg);
					return false;
				}
			</c:if>

			if (addr == 'R') {
				$("#oldAddr2").val($("#newAddr2").val());
			}
			else if (addr == 'J') {
				$("#newAddr2").val($("#oldAddr2").val());
			}

			frm.action = "<c:url value="${searchVO.act == 'REGIST' ? 'member_input_proc.do' : 'member_edit_proc.do'}"/>";
			frm.submit();
		}
	}

	function fn_goList(){
		location.href = "member_list.do?<c:out value="${searchVO.query}" escapeXml="false" />"
	}

	function fn_checkId(id) {
		var ptrn1 = /^[^a-zA-Z]/; //false가 정상
		var ptrn2 = /[^a-zA-Z0-9._]/; //false가 정상 +
		if ($.trim(id) == "") {
			$("#idHelp").text("영문숫자조합 (영문으로 시작, 4 ~ 12자)");
			return false;
		}
		if (ptrn1.test($.trim(id))) {
			alert("아이디는 영문(대소문)자로 시작해야 합니다.");
			checkFlagId = false;
			return false;
		}
		if (ptrn2.test($.trim(id))) {
			alert("아이디는 영문(대소문자), 숫자, ., _ 만 입력 할 수 있습니다.");
			checkFlagId = false;
			return false;
		}
		if (id.length<4) {
			$("#idHelp").text("아이디는 4자 이상으로 등록하여야 합니다.");
			checkFlagId = false;
			return false;
		}

		$.ajax({
			url: "member_comm_chkId.ajax"
			, data: "id=" + id
			, type: "get"
			, dataType: "json"
			, async: false
			, cache: false
			, success: function (data) {
				if (data.result == "0") {
					alert(data.message);
					checkFlagId = false;
					return false;
				}
				else if (data.result == "1") {
					$("#idHelp").text("사용가능한 아이디 입니다.");
					checkFlagId = true;
				}
				else if (data.result == "2") {
					$("#idHelp").text("중복된 아이디 입니다.");
					checkFlagId = false;
				}
				else {
					$("#idHelp").text("아이디를 다시 입력 해 주세요.");
					checkFlagId = false;
				}
			}
			, error: function (request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}

	function fn_checkNickName(nickname, cnt) {
		<c:if test="${fn:trim(searchVO.act) == 'UPDATE'}">
			if ($.trim(nickname) == $.trim($("#nickName2").val())) {
				$("#nickHelp").text("");
				checkFlagNickName = true;
				return false;
			}
		</c:if>

		var ptrn = /[^(가-힣a-zA-Z0-9)]/;
		if ($.trim(nickname) == "") {
			return false;
		}
		if (ptrn.test($.trim(nickname))) {
			alert("닉네임은 한글, 영문(대,소), 숫자만 허용 합니다.");
			checkFlagNickName = false;
			return false;
		}

		$.ajax({
			url: "member_comm_chkNick.ajax"
			, data: "nickName=" + nickname + "&cnt=" + cnt
			, type: "get"
			, dataType: "json"
			, async: false
			, cache: false
			, success: function (data) {
				if (data.result == "0") {
					alert(data.message);
					checkFlagNickName = false;
					return false;
				}
				else if (data.result == "1") {
					$("#nickHelp").text("사용가능한 닉네임 입니다.");
					checkFlagNickName = true;
				}
				else if (data.result == "2") {
					$("#nickHelp").text("중복된 닉네임 입니다.");
					checkFlagNickName = false;
				}
				else {
					$("#nickHelp").text("닉네임을 다시 입력 해 주세요.");
					checkFlagNickName = false;
				}
			}
			, error: function (request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}

	<c:if test="${searchVO.act == 'UPDATE'}">
		function fn_goInitPass() {
			if (confirm("비밀번호를 초기화 하시겠습니까? \n비밀번호는 아이디와 동일하게 초기화되며, 비밀번호 오류 횟수도 초기화 됩니다")) {
				var frm = document.form1;
				frm.encoding = "application/x-www-form-urlencoded";
				frm.action = "member_edit_initPass.do";
				frm.submit();
			}
		}

		function fn_goDel() {
			if (confirm("삭제하시겠습니까?")) {
				var frm = document.form1;
				frm.encoding = "application/x-www-form-urlencoded";
				frm.action = "member_delete_proc.do";
				frm.submit();
			}
		}
	</c:if>
	//]]>

	function getAddressLayer() {
		$("#modalpopup").show();
	}
	function getAddressLayerClose() {
		$("#modalpopup").hide();
	}
	function getNewAddrLayer() {
		$("#zip1").show();
		$("#zip2").hide();
		$("#newtab").attr("class", "active");
		$("#oldtab").attr("class", "last");
	}
	function getOldAddrLayer() {
		$("#zip1").hide();
		$("#zip2").show();
		$("#newtab").attr("class", "");
		$("#oldtab").attr("class", "last active");
	}

	function getNewAddr() {
		if ($.trim($("#loadNew").val()) == "") {
			alert("도모명/건물명을 입력해 주세요.");
			return false;
		}

		$.ajax({
			url: "http://post.phpschool.com/json.phps.kr"
			, data: "addr=" + $.trim($("#loadNew").val()) + "&ipkey=1595532&type=new"
			, type: "post"
			, dataType: "json"
			, async: false
			, cache: false
			, success: function (data) {
				//result "-1" 일경우: 너무많은검색결과 1000건이상
				//result "-2" 일경우: 서버 IP 미인증
				//result "-3" 일경우: 조회횟수초과
				//result "-4" 일경우: 미인증 사용자
				if (data.result == "-1") {
					alert("검색결과가 너무 많습니다. 입력하신 검색어 " + $("#loadNew").val() + " 뒤에 단어를 추가해서 검색해보세요.");
				}
				else if (data.result == "0") {
					alert("검색결과가 없습니다.");
				}
				else {
					console.log(data.result);
				}
			}
			, error: function (request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}
</script>

<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="daumPostLayer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<a href="#none" id="btnCloseLayer"
	     style="cursor:pointer;display:block;position:absolute;right:-3px;top:-3px;z-index:100" onclick="ItgJs.getDaumAddressLayerClose()"><img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png"  alt="닫기 버튼"></a>
</div>

<%-- http://post.phpschool.com/join.html#exam --%>
<%--
<div id="modalpopup" name="modalpopup" class="zip">
	<div class="w">
		<h2 class="tit">우편번호 검색</h2>
		<div class="content">

			<ul class="zipTab mb10">
				<li id="newtab" class="active"><a href="javascript:void(0);" id="newAddrLayer" name="newAddrLayer" onclick="getNewAddrLayer()">도로명주소</a></li>
				<li id="oldtab" class="last"><a href="javascript:void(0);" id="oldAddrLayer" name="oldAddrLayer" onclick="getOldAddrLayer()">지번주소</a></li>
			</ul>

			<div id="zip1">
				<h3 class="blind">도로명주소 검색</h3>
				<div class="zipMsg">
					<p>도로명주소 검색방법</p>
					<p>1. 도로명 입력 (예: 올림픽로)</p>
					<p>2. 도로명+건물번호 입력 (예: 올림픽로 326)</p>
					<p>3. 건물명 입력 (예: 강남소방서)</p>
				</div>

				<div class="mb10">
					<table class="tb02 brd">
						<caption>도로명주소 검색조건</caption>
						<colgroup>
							<col style="width:110px"/>
							<col style="width:auto"/>
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="road">도로명/건물명</label></th>
							<td class="last">
								<div class="ipw100">
									<input type="text" id="loadNew" name="loadNew" class="solo" value="에이스테크노"/>
								</div>
							</td>
						</tr>
						</tbody>
					</table>
				</div>

				<div class="boardBtnBox mb20">
					<button type="button" id="btnNewAddr" name="btnNewAddr" class="midBtn btnLblue" onclick="getNewAddr();">검색</button>
				</div>

				<table class="tb03">
					<caption>도로명 검색결과</caption>
					<colgroup>
						<col style="width:90px"/>
						<col style="width:auto"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">우편번호</th>
						<th scope="col">주소</th>
					</tr>
					</thead>
				</table>

				<div class="scrollWrap mb10">
					<table class="tb03 bn">
						<caption>도로명 검색결과</caption>
						<colgroup>
							<col style="width:90px"/>
							<col style="width:auto"/>
						</colgroup>
						<tbody>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						</tbody>
					</table>
				</div>
			</div>

			<div id="zip2">
				<h3 class="blind">지번주소 검색</h3>
				<div class="zipMsg txtC">
					검색하실 주소의 동/읍/면을 입력해 주세요. (예: 논현동)
				</div>
				<div class="mb10">
					<table class="tb02 brd">
						<caption>지번주소 검색조건</caption>
						<colgroup>
							<col style="width:70px"/>
							<col style="width:auto"/>
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="road">주소명</label></th>
							<td class="last"><input type="text" id="road" class="solo"/></td>
						</tr>
						</tbody>
					</table>
				</div>

				<div class="boardBtnBox mb20">
					<button type="button" id="btnOldAddr" name="btnOldAddr" class="midBtn btnLblue">검색</button>
				</div>

				<table class="tb03">
					<caption>도로명 검색결과</caption>
					<colgroup>
						<col style="width:90px"/>
						<col style="width:auto"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">우편번호</th>
						<th scope="col">주소</th>
					</tr>
					</thead>
				</table>

				<div class="scrollWrap mb10">
					<table class="tb03 bn">
						<caption>도로명 검색결과</caption>
						<colgroup>
							<col style="width:90px"/>
							<col style="width:auto"/>
						</colgroup>
						<tbody>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						<tr>
							<td>000-000</td>
							<td class="subj"><a href="#">서울 관악구 난곡로 00길</a></td>
						</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<a href="javascript:void(0);" class="close" onclick="getAddressLayerClose();return false"><span class="blind">닫기</span></a>
	</div>
</div>
 --%>
