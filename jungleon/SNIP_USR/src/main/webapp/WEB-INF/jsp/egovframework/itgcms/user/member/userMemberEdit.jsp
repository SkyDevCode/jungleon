<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
				<form  name="form1" method="post" onsubmit="fn_update(); return false;">
				<div class="form-must-notic">*표시된 항목은 반드시 입력해주시기 바랍니다. </div>
                <table class="table table-join">
                    <caption class="ir-text">회원가입 테이블</caption>
                    <colgroup class="n_mobile">
                        <col width="15%">
                        <col width="35%">
                        <col width="15%">
                        <col width="">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="row">아이디</th>
                            <td colspan="3">
                                <c:out value="${memberVO.id }" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호</th>
                            <td>
                                <input type="password" id="pass" name="pass" maxlength="20" class="inp_txt wd-360"  title="비밀번호를 입력하세요">
                                <span class="notice-txt">* 신규 비밀번호를 입력하면 변경됩니다. 영문/숫자/특수문자 조합 10자리 이상 사용</span>
                            </td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호 확인</th>
                            <td>
                                <input type="password" id="pass2" name="pass2" maxlength="20" class="inp_txt wd-360"   title="비밀번호를 재 입력하세요">
                                <span class="notice-txt">* 영문/숫자/특수문자 조합 10자리 이상 사용</span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호 힌트</th>
                            <td>
                                <div class="slt_wrap  n-wd100p">
                                    <select name="pwdQuest" id="pwdQuest" class="slt_box required"  title="비밀번호 힌트를 선택하세요">
                                        <option value="">선택해 주세요</option>
                                        <c:forEach var="code" items="${pwdQuest }">
                                       		<option value="${code.ccode }" ${ufn:selected(memberVO.pwdQuest, code.ccode) }>${code.cname }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호 답변</th>
                            <td>
                                <input type="text" name="pwdAnswer" id="pwdAnswer" maxlength="20" value="<c:out value="${memberVO.pwdAnswer }" />" class="inp_txt  wd-360 required" title="비밀번호 답변을 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">성명</th>
                            <td><input type="text" name="name" id="name" maxlength="20" value="<c:out value="${memberVO.name }" />" class="inp_txt wd-360 required" title="성명을 입력하세요"></td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>성별</th>
                            <td>
                                <div class="radio_wrap">
                                    <input type="radio" name="sex" id="inp_rdo1" value="M" ${ufn:checked(memberVO.sex, 'M') }>
                                    <label for="inp_rdo1" class="inp_rdo">남자</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="sex" id="inp_rdo2" value="F" ${ufn:checked(memberVO.sex, 'F') }>
                                    <label for="inp_rdo2" class="inp_rdo">여자</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>생년월일</th>
                            <td colspan="3">
                                <div class="slt_wrap">
                                	<c:set var="arrBirth" value="${fn:split(memberVO.birth, '-') }" />
                                	<c:set var="year" value="${ufn:getDatePattern('yyyy')}" />

                                    <select name="birth1" id="birth1" class="slt_box year" title="년도를 선택하세요">
                                    <c:forEach var="i" begin="0" end="100" step="1">
                                        <option value="${year - i  }" ${ufn:selected(arrBirth[0], year - i) }>${year - i  }년</option>
									</c:forEach>
                                    </select>
                                </div>
                                <div class="slt_wrap">
                                    <select name="birth2" id="birth2" class="slt_box" title="월 선택해 주세요">
                                    	<c:forEach var="i" begin="1" end="12" step="1">
                                        	<option value="${ufn:getZeroPlus(i) }" ${ufn:selected(arrBirth[1], i) }>${i }월</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="slt_wrap day">
                                    <select name="birth3" id="birth3" class="slt_box" title="일 선택해 주세요">
                                        <c:forEach var="i" begin="1" end="31" step="1">
                                        	<option value="${ufn:getZeroPlus(i) }" ${ufn:selected(arrBirth[2], i) }>${i }일</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <input type="hidden" name="birth" />
                                <div class="radio-group">
                                    <div class="radio_wrap">
                                        <input type="radio" name="birthType" id="inp_rdo3" value="1" ${ufn:checked(memberVO.birthType, '1') }>
                                        <label for="inp_rdo3" class="inp_rdo">양력</label>
                                    </div>
                                    <div class="radio_wrap">
                                        <input type="radio" name="birthType" id="inp_rdo4" value="0" ${ufn:checked(memberVO.birthType, '0') }>
                                        <label for="inp_rdo4" class="inp_rdo">음력</label>
                                    </div>
                                 </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">전화번호</th>
                            <td>
                            	<c:set var="arrPhone" value="${fn:split(memberVO.phone, '-') }" />
                                <div class="slt_wrap">
                                    <select name="phone1" id="phone1" class="slt_box" title="전화번호 앞자리를 선택하세요">
                                    </select>
                                </div>
                                <span class="hyphen">-</span>
                                <input type="text" name="phone2" id="phone2" value="<c:out value="${arrPhone[1] }" />" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="전화번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="phone3" id="phone3" value="<c:out value="${arrPhone[2] }" />" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="전화번호 마지막 자리를 입력하세요">
                                <input type="hidden" name="phone" />
                            </td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>핸드폰번호</th>
                            <td>
                           		<c:set var="arrMobile" value="${fn:split(memberVO.mobile, '-') }" />
                                <div class="slt_wrap">
                                    <select name="mobile1" id="mobile1" class="slt_box" title="핸드폰번호 앞자리를 선택하세요">
                                    </select>
                                </div>
                                <span class="hyphen">-</span>
                                <input type="text" name="mobile2" id="mobile2" maxlength="4" value="${arrMobile[1] }" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="핸드폰번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="mobile3" id="mobile3" maxlength="4" value="${arrMobile[2] }" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="핸드폰번호 마지막 자리를 입력하세요">
                                <input type="hidden" name="mobile" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>이메일</th>
                            <td colspan="3">
                            	<c:set var="arrEmail" value="${fn:split(memberVO.email, '@') }" />
                                <input type="text" name="email1" id="email1" value="<c:out value="${arrEmail[0] }" />" maxlength="20" class="inp_txt email-fm" title="이메일 아이디를 입력하세요">
                                <span class="hyphen">@</span>
                                <input type="text" name="email3" id="email3" value="<c:out value="${arrEmail[1] }" />" maxlength="50" class="inp_txt email-fm"  title="이메일 공급자를 입력하세요">
                                <div class="slt_wrap  n-wd100p email-slt">
                                    <select name="email2" id="email2" class="slt_box" title="이메일 공급자를 선택하세요" onchange="fn_emailChange();">
                                    </select>
                                </div>
                                <input type="hidden" name="email" id="email" required="required" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>주소</th>
                            <td colspan="3">
                                <div class="slt_wrap n-wd100p">
                                    <select name="areaCd" class="slt_box" title="주소를 선택하세요">
                                        <option value="">선택해 주세요</option>
                                        <c:forEach var="code" items="${addr }">
											<option value="${code.ccode }" ${ufn:selected(memberVO.areaCd, code.ccode) }>${code.cname }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>메일링서비스</th>
                            <td colspan="3">
                                <div class="radio_wrap">
                                    <input type="radio" name="emailYn" id="inp_rdo1a" value="Y" ${ufn:checked(memberVO.emailYn, 'Y') }>
                                    <label for="inp_rdo1a" class="inp_rdo">수신합니다.</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="emailYn" id="inp_rdo2a" value="N" ${ufn:checked(memberVO.emailYn, 'N') }>
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
                                        	<c:set var="checked" value="" />
                                        	<c:if test="${fn:indexOf(memberVO.concerns, code.ccode) > -1 }">
                                        		<c:set var="checked" value="checked='checked'" />
                                        	</c:if>
                                            <input type="checkbox" name="concerns" id="concerns${status.count }" ${checked } value="${code.ccode }" class="chk-box">
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
                                    <input type="radio" name="knowpath" id="knowpath1" value="1" ${ufn:checked(memberVO.knowpath, '1') }>
                                    <label for="knowpath1" class="inp_rdo">포털사이트(검색)</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath2" value="2" ${ufn:checked(memberVO.knowpath, '2') }>
                                    <label for="knowpath2" class="inp_rdo">이메일</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath3" value="3" ${ufn:checked(memberVO.knowpath, '3') }>
                                    <label for="knowpath3" class="inp_rdo">팩스/방문</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath4" value="4" ${ufn:checked(memberVO.knowpath, '4') }>
                                    <label for="knowpath4" class="inp_rdo">유관기관(배너)</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath5" value="5" ${ufn:checked(memberVO.knowpath, '5') }>
                                    <label for="knowpath5" class="inp_rdo">언론매체</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" id="knowpath6" value="6" ${ufn:checked(memberVO.knowpath, '6') }>
                                    <label for="knowpath6" class="inp_rdo">기타</label>
                                </div>

                            </td>
                        </tr>
                    </tbody>
                </table>
                 <div class="btn-wrap text-c">
                     <a href="#none" onclick="fn_update(); return false;" class="btn btn-blue btn-join ">저장</a>
                     <a href="#none" onclick="document.form1.reset();" class="btn btn-gray btn-join ">취소</a>
                 </div>
				</form>
<script src="/resource/common/jquery_plugin/validation/validator.js"></script>
<script>
	$(function(){
		ItgJs.selectBoxLocalNumber("phone1", "${arrPhone[0]}");
		ItgJs.selectBoxMobileLocalNumber("mobile1", "${arrMobile[0]}");
		ItgJs.selectBoxEmail("email2","");

	});

	function fn_update() {
		var frm = document.form1;
		if(Validator.validate(frm)) {

			//비밀번호
			if($("#pass").val() == "" && $("#pass2").val() != "" ) {
				alert("비밀번호 입력 해 주세요");
				return false;
			}
			if($("#pass").val() != "" && $("#pass2").val() == "" ) {
				alert("비밀번호 확인을 입력 해 주세요");
				return false;
			}
			if($("#pass").val() != "" && $("#pass2").val() != "") {
				var msg = ItgJs.fn_checkPass($("#pass").val(), $("#pass2").val());
				if (msg != "") {
					alert(msg);
					return false;
				}
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

			var phonePtrn = /[0-9]{2,4}-[0-9]{3,4}-[0-9]{4}/;
			var mobilePtrn = /[0-9]{3,4}-[0-9]{3,4}-[0-9]{4}/;
			var phone = frm.phone1.value + "-" + frm.phone2.value + "-" + frm.phone3.value;
			if(phone != "--" && !phonePtrn.test(phone)) {
				alert("전화번호를 형식에 맞게 입력해 주세요(02-123-1234)");
				return false;
			}
			frm.phone.value = phone;

			var mobile = frm.mobile1.value + "-" + frm.mobile2.value + "-" + frm.mobile3.value;
			if(mobile != "--" && !mobilePtrn.test(mobile)) {
				alert("핸드폰번호를 형식에 맞게 입력해 주세요(011-456-7890)");
				return false;
			}
			frm.mobile.value = mobile;

			var birth = frm.birth1.value + "-" + frm.birth2.value + "-" + frm.birth3.value;
			frm.birth.value = birth;



			frm.action="/${siteCode}/module/${menuVO.menuCode}_update_proc.do";
			frm.submit();
		}
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