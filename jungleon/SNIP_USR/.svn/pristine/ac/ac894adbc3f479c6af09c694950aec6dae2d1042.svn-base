<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- S: 추가 영역 --%>
<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />
<c:set var="ctx" value="${pageContext.request.contextPath}/${siteCode}"/>
<%-- E: 추가 영역 --%>

<ol class="join-step-list">
                    <li class="step01 checked">
                        <span class="n_mobile">01.</span>
                        <span class="num v_mobile">
                            <span class="blind">1</span>
                        </span>
                        <span class="tit">약관동의</span>
                    </li>
                    <li class="step02 checked">
                        <span class="n_mobile">02.</span>
                        <span class="num v_mobile">
                            <span class="blind">2</span>
                        </span>
                        <span class="tit">본인확인</span>
                    </li>
                    <li class="step03 active">
                        <span class="n_mobile">03.</span>
                        <span class="num v_mobile">3</span>
                        <span class="tit">정보입력</span>
                    </li>
                    <li class="step04">
                        <span class="n_mobile">04.</span>
                        <span class="num v_mobile">4</span>
                        <span class="tit">가입완료</span>
                    </li>
                </ol>

				<form  name="form1" method="post" onsubmit="fn_regist(); return false;">
				<input type="hidden" name="type" value="<c:out value="${memType }" />" />
                <div class="form-must-notic">*표시된 항목은 반드시 입력해주시기 바랍니다. </div>
                <table class="table table-join">
                    <caption class="ir-text">회원가입 테이블</caption>
                    <colgroup class="n_mobile">
                        <col style="width:15%">
                        <col style="width:35%">
                        <col style="width:15%">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>아이디</th>
                            <td colspan="3">
                                <input type="text" id="id" name="id" class="inp_txt id-fm required validate-id-format" maxlength="20" onchange="checkFlagId=false;" title="아이디를 입력하세요">
                                <button type="button" onclick="fn_checkId($('#id').val()); return false;" class="btn btn-blue btn-icon-search">중복검색</button>
                                <span class="notice-txt">* 6자이상 20자이하 영문(소문자)/숫자 조합으로 작성,한글 아이디 사용불가</span><span id="idHelp" class="notice-txt"></span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호</th>
                            <td>
                                <input type="password" id="pass" name="pass" maxlength="20" class="inp_txt wd-360 n-wd100p required" autocomplete="false" title="비밀번호를 입력하세요">
                                <span class="notice-txt">* 영문/숫자/특수문자 조합 10자리 이상 사용</span>
                            </td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호 확인</th>
                            <td>
                                <input type="password" id="pass2" name="pass2" maxlength="20" class="inp_txt wd-360 n-wd100p required" autocomplete="false" title="비밀번호를 재 입력하세요">
                                <span class="notice-txt">* 영문/숫자/특수문자 조합 10자리 이상 사용</span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호 힌트</th>
                            <td>
                                <div class="slt_wrap n-wd100p">
                                    <select name="pwdQuest" id="pwdQuest" class="slt_box required"  title="비밀번호 힌트를 선택하세요">
                                        <option value="">선택해 주세요</option>
                                        <c:forEach var="code" items="${pwdQuest }">
                                       		<option value="${code.ccode }">${code.cname }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호 답변</th>
                            <td>
                                <input type="text" name="pwdAnswer" id="pwdAnswer" maxlength="20" class="inp_txt  wd-360 required" title="비밀번호 답변을 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>성명</th>
                            <td><c:out value="${sessionScope.certInfo.name }" /></td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>성별</th>
                            <td>
                                <c:choose>
                                	<c:when test="${sessionScope.certInfo.sex eq 'M' }">
                                		남자
                                	</c:when>
                                	<c:otherwise>
                                		여자
                                	</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>생년월일</th>
                            <td colspan="3">
                                <input type="text" name="birth1" id="birth1" title="출생연도" readonly="readonly" value="<c:out value="${fn:substring(sessionScope.certInfo.birth, 0, 4) } 년" />" class="inp_txt wd-110">
                                <input type="text" name="birth2" id="birth2" title="출생월" readonly="readonly" value="<c:out value="${fn:substring(sessionScope.certInfo.birth, 4, 6) } 월" />" class="inp_txt wd-110">
                               	<input type="text" name="birth3" id="birth3" title="출생일" readonly="readonly" value="<c:out value="${fn:substring(sessionScope.certInfo.birth, 6, 8) } 일" />" class="inp_txt wd-110">
                                <div class="radio-group">
                                    <div class="radio_wrap">
                                        <input type="radio" name="birthType" value="1" id="birthType1">
                                        <label for="birthType1" class="inp_rdo">양력</label>
                                    </div>
                                    <div class="radio_wrap">
                                        <input type="radio" name="birthType" value="0" id="birthType2">
                                        <label for="birthType2" class="inp_rdo">음력</label>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">전화번호</th>
                            <td>
                                <div class="slt_wrap">
                                    <select class="slt_box" name="phone1" id="phone1" title="전화번호 앞자리를 선택하세요">
                                    </select>
                                </div>
                                <span class="hyphen">-</span>
                                <input type="text" name="phone2" id="phone2" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="전화번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="phone3" id="phone3" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="전화번호 마지막 자리를 입력하세요">
                                <input type="hidden" name="phone" />
                            </td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>핸드폰번호</th>
                            <td>
                            	<c:set var="arrMobile" value="${fn:split(ufn:getMobileAddHyphen(sessionScope.certInfo.mobile), '-') }" />
                                <input type="text" name="mobile1" id="mobile1" readonly="readonly" value="${arrMobile[0] }" class="inp_txt wd-110"  title="핸드폰번호 앞자리를 선택하세요">
                                <span class="hyphen">-</span>
                                	<input type="text" name="mobile2" id="mobile2" readonly="readonly"   value="${arrMobile[1] }"class="inp_txt wd-110"  title="핸드폰번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                               		<input type="text" name="mobile3" id="mobile3" readonly="readonly"   value="${arrMobile[2] }"class="inp_txt wd-110"  title="핸드폰번호 마지막 자리를 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>이메일</th>
                            <td colspan="3">
                                <input type="text" name="email1" id="email1" class="inp_txt email-fm" title="이메일 아이디를 입력하세요">
                                <span class="hyphen">@</span>
                                <input type="text" name="email3" id="email3" class="inp_txt email-fm"  title="이메일 공급자를 입력하세요">
                                <div class="slt_wrap  n-wd100p email-slt">
                                    <select class="slt_box" name="email2" id="email2" title="이메일 공급자를 선택하세요"  onchange="fn_emailChange();">
                                    </select>
                                </div>
                                <input type="hidden" id="email" name="email" required="required" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>주소</th>
                            <td colspan="3">
                                <div class="slt_wrap n-wd100p">
                                    <select name="areaCd" id="areaCd" class="slt_box required" title="주소를 선택하세요">
                                        <option value="">선택해 주세요</option>
                                        <c:forEach var="code" items="${addr }">
                                        	<option value="${code.ccode }">${code.cname }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>메일링서비스</th>
                            <td colspan="3">
                                <div class="radio_wrap">
                                    <input type="radio" name="emailYn" id="inp_rdo1a" value="Y">
                                    <label for="inp_rdo1a" class="inp_rdo">수신합니다.</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="emailYn" id="inp_rdo2a" checked value="N">
                                    <label for="inp_rdo2a" class="inp_rdo">수신하지 않습니다.</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">관심사업</th>
                            <td colspan="3">
                                <ul class="compny-list">
                                <c:forEach var="code" items="${concerns }" varStatus="status">
                                    <li>
                                        <div class="check_box_wrap">
                                            <input type="checkbox" name="concerns" id="concerns${status.count }" value="${code.ccode }" class="chk-box">
                                            <label class="chk-box" for="concerns${status.count }">
                                                <span><c:out value="${code.cname }" /></span>
                                            </label>
                                        </div>
                                    </li>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">성남벤처넷을 어떻게<br> 알게 되셨나요?</th>
                            <td colspan="3">
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath1" value="1" checked>
                                    <label for="knowpath1" class="inp_rdo">포털사이트(검색)</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath2" value="2">
                                    <label for="knowpath2" class="inp_rdo">이메일</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath3" value="3">
                                    <label for="knowpath3" class="inp_rdo">팩스/방문</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath4" value="4">
                                    <label for="knowpath4" class="inp_rdo">유관기관(배너)</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath5" value="5">
                                    <label for="knowpath5" class="inp_rdo">언론매체</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath6" value="6">
                                    <label for="knowpath6" class="inp_rdo">기타</label>
                                </div>

                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="btn-wrap text-c">
                    <a href="#none" onclick="fn_regist(); return false;" class="btn btn-blue btn-join ">회원가입</a>
                </div>
			</form>

<%-- E: 추가 영역 --%>
<script src="/resource/common/jquery_plugin/validation/validator.js"></script>
<script>

	$(function(){
		ItgJs.selectBoxLocalNumber("phone1", "");
		ItgJs.selectBoxEmail("email2","");
	});

	function fn_regist(){
		var frm = document.form1;
		if(Validator.validate(frm)) {
			//아이디
			if (!checkFlagId) {
				alert("아이디 중복여부를 확인해 주세요.");
				return false;
			}

			//비밀번호
			var msg = ItgJs.fn_checkPass($("#pass").val(), $("#pass2").val());
			if (msg != "") {
				alert(msg);
				return false;
			}

			//이메일
			if ($.trim($("#email1").val()) != "") {
				var email = $("#email1").val();
				if ($.trim($("#email2 > option:selected").val()) != "") {
					email += "@" + $("#email2 > option:selected").val();
				}
				else {
					email += "@" +  $("#email3").val();
				}
				$("#email").val(email);

				if (frm.email.required) {
					if (!ItgJs.fn_chkEmail(frm.email, "이메일을 확인해 주세요.(빈칸, 형식 등)")) {
						return false;
					}
				} else {
					if (!ItgJs.fn_chkEmail(frm.email)){
						$("#email").val("");
					}
				}
			}else{
				if (frm.email.required && !ItgJs.fn_chkValue(frm.email1, "이메일을 앞부분을 입력해주세요")) {
					return false;
				}
			}

			var phone = frm.phone1.value + "-" + frm.phone2.value + "-" + frm.phone3.value;
			frm.phone.value = phone;

			frm.action="/${siteCode}/module/${menuVO.menuCode}_input_proc.do";
			frm.submit();
		}
	}
	var checkFlagId = false;

	function fn_checkId(id) {
		var ptrn1 = /^[^a-zA-Z]/; //false가 정상
		var ptrn2 = /[^a-zA-Z0-9._]/; //false가 정상 +
		if ($.trim(id) == "") {
			alert("아이디를 입력해 주세요.");
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
		if($.trim(id).length < 6 || $.trim(id).length > 20) {
			alert("아이디는 6자이상 20자이하로 입력해 주세요");
			return false;
		}
		$.ajax({
			 url: "/${siteCode}/module/${menuVO.menuCode}_checkId.ajax"
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
	function fn_emailChange() {
		$("#email").val("");
		if ($("#email2 > option:selected").val() == "") {
			$("#email3").show();
		}
		else {
			$("#email3").hide();
		}
		$("#email3").val("");
	}
</script>

