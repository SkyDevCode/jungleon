<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
<script>
$(document).ready(function(){
})
</script>
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
				<input type="hidden" name="busiRegNo" />
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
                                    <select name="pwdQuest" id="pwdQuest" class="slt_box required" title="비밀번호 힌트를 선택하세요">
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
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>회사명</th>
                            <td><input type="text" name="comNm" id="comNm" maxlength="50" class="inp_txt  wd-360 required" title="회사명을 입력하세요"></td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>대표자명</th>
                            <td><input type="text" name="ceoNm" id="ceoNm" maxlength="24" class="inp_txt  wd-360 required" title="대표자명을 입력하세요"></td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>대표자성별</th>
                            <td>
                                <div class="radio_wrap">
                                    <input type="radio" name="sex" id="sex1" value="M">
                                    <label for="sex1" class="inp_rdo">남자</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="sex" id="sex2" value="F" checked="checked">
                                    <label for="sex2" class="inp_rdo">여자</label>
                                </div>
                            </td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>기업형태</th>
                            <td>
                                <div class="radio_wrap">
                                    <input type="radio" name="comTp" id="comTp1" checked="checked" value="V006000002" />
                                    <label for="comTp1" class="inp_rdo">법인기업</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="comTp" id="comTp2" value="V006000001">
                                    <label for="comTp2" class="inp_rdo">개인기업</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>사업자등록번호</th>
                            <td colspan="3">
                                <input type="text" name="busiRegNo1" id="busiRegNo1" maxlength="3" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110 required"  title="사업자등록번호 첫번째 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="busiRegNo2" id="busiRegNo2" maxlength="2" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110 required"  title="사업자등록번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="busiRegNo3" id="busiRegNo3" maxlength="5" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110 required"  title="사업자등록번호 마지막 자리를 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>표준산업분류코드</th>
                            <td colspan="3">
                                <input type="text" name="unCd" id="schKsicCd" readonly="readonly" class="inp_txt wd-160"  title="표준산업분류코드">
                                <input type="text" name="unNm" id="schKsicNm" readonly="readonly" class="inp_txt wd-360"  title="표준산업분류 명칭">
                                <button type="button" class="btn btn-blue btn-icon-search btn-modal-pop" id="ksic_popup">분류검색</button>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>주요생산품</th>
                            <td>
                                <input type="text" name="mainProduct" id="mainProduct" maxlength="500" class="inp_txt wd-360 required" title="주요생산품을 입력하세요">
                            </td>
                            <th scope="row">회사전화번호</th>
                            <td>
                                <div class="slt_wrap">
                                    <select name="officeTel01" id="officeTel01" class="slt_box" title="전화번호 앞자리를 선택하세요">
                                    </select>
                                </div>
                                <span class="hyphen">-</span>
                                <input type="text" name="officeTel02" id="officeTel02" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="전화번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="officeTel03" id="officeTel03" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="전화번호 마지막 자리를 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>설립일</th>
                            <td>
                                <input type="text" name="estDt" id="estDt" readonly="readonly" class="inp_txt  wd-110 datapick-m required" id="datepicker" title="설립일 입력하세요">
                            </td>
                            <th scope="row">회사팩스번호</th>
                            <td>
                                <div class="slt_wrap">
                                    <select name="faxNo01" id="faxNo01" class="slt_box" title="팩스번호 앞자리를 선택하세요">
                                    </select>
                                </div>
                                <span class="hyphen">-</span>
                                <input type="text" name="faxNo02" id="faxNo02" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="팩스번호 가운데 자리를 입력 하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="faxNo03" id="faxNo03" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="팩스번호 마지막 자리를 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>대표자 이메일</th>
                            <td colspan="3">
                                <input type="text" name="ceoEmail1" id="ceoEmail1" maxlength="20" class="inp_txt email-fm" title="이메일 아이디를 입력하세요">
                                <span class="hyphen">@</span>
                                <input type="text" name="ceoEmail3" id="ceoEmail3" maxlength="50" class="inp_txt email-fm"  title="이메일 공급자를 입력하세요">
                                <div class="slt_wrap  n-wd100p email-slt">
                                    <select name="ceoEmail2" id="ceoEmail2" class="slt_box" title="이메일 공급자를 선택하세요" onchange="fn_emailChange('ceoEmail');">
                                    </select>
                                    <input type="hidden" name="ceoEmail" id="ceoEmail" required="required"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">홈페이지</th>
                            <td colspan="3">
                                <input type="text" name="hPage" id="hPage" maxlength="100" class="inp_txt wd-100p validate-url" title="홈페이지를 입력하세요">

                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>주소</th>
                            <td colspan="3">
                                <ul class="address-form">
                                    <li>
                                        <input type="text" name="zip" id="zip" readonly="readonly" class="inp_txt wd-160 required" title="우편번호"> <button type="button" onclick="ItgJs.getDaumAddressStreet({zip:'zip',addr1:'addr01',addr2:'addr02'});" class="btn btn-blue btn-icon-search" id="postSearchBtn">우편검색</button>
				<div id="daumPostLayer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;" tabindex="0">
				<a href="#none" id="btnCloseLayer"
	     style="cursor:pointer;display:block;position:absolute;right:-3px;top:-3px;z-index:100" onclick="ItgJs.getDaumAddressLayerClose()" tabindex="0" title="우편번호 찾기 레이어 닫기"><img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png"  alt="닫기 버튼"></a>
				</div>
                                    </li>
                                    <li class="mt-5"><input type="text" name="addr01" id="addr01" readonly="readonly" class="inp_txt wd-100p"  title="주소 입력"></li>
                                    <li class="mt-5"><input type="text" name="addr02" id="addr02" maxlength="50" class="inp_txt wd-100p" title="상세주소를 입력해주세요."  placeholder="상세주소를 입력해주세요."></li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>가입자성명</th>
                            <td colspan="3">
                                <c:out value="${sessionScope.certInfo.name }" />
                            </td>
                        </tr>

                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>생년월일</th>
                            <td colspan="3">
                                <input type="text" name="birth1" id="birth1" title="출생년도" readonly="readonly" value="<c:out value="${fn:substring(sessionScope.certInfo.birth, 0, 4) } 년" />" class="inp_txt wd-110">
                                <input type="text" name="birth2" id="birth2"  title="출생월" readonly="readonly" value="<c:out value="${fn:substring(sessionScope.certInfo.birth, 4, 6) } 월" />" class="inp_txt wd-110">
                                <input type="text" name="birth3" id="birth3"  title="출생일" readonly="readonly" value="<c:out value="${fn:substring(sessionScope.certInfo.birth, 6, 8) } 일" />" class="inp_txt wd-110">
                                <div class="radio-group">
                                    <div class="radio_wrap">
                                        <input type="radio" name="birthType" value="1" id="birthType1" checked>
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
                            <th scope="row">부서/직급</th>
                            <td colspan="3">
                                <input type="text" name="position" id="position" maxlength="30" class="inp_txt wd-360" title="부서/직급을 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">전화번호</th>
                            <td colspan="3">
                                <div class="slt_wrap">
                                    <select class="slt_box" name="phone1" id="phone1" title="전화번호 앞자리를 선택하세요">
                                    </select>
                                </div>
                                <span class="hyphen">-</span>
                                <input type="text" name="phone2" id="phone2" maxlength="4" class="inp_txt wd-110" onkeydown="ItgJs.fn_numberOnly(event);" title="전화번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text"  name="phone3" id="phone3" maxlength="4" class="inp_txt wd-110" onkeydown="ItgJs.fn_numberOnly(event);" title="전화번호 마지막 자리를 입력하세요">
                                <input type="hidden" name="phone" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">핸드폰번호</th>
                            <td colspan="3">
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
                                <input type="text" name="email1" id="email1" maxlength="20" class="inp_txt email-fm" title="이메일 아이디를 입력하세요">
                                <span class="hyphen">@</span>
                                <input type="text" name="email3" id="email3" maxlength="50" class="inp_txt email-fm"  title="이메일 공급자를 입력하세요">
                                <div class="slt_wrap  n-wd100p email-slt">
                                    <select class="slt_box" name="email2" id="email2" onchange="fn_emailChange('email');" title="이메일 공급자를 선택하세요">
                                    </select>
                                </div>
                                <input type="hidden" name="email" id="email" required="required" />
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
				</form>
                <div class="btn-wrap text-c">
                    <a href="#none" onclick="fn_regist(); return false;" class="btn btn-blue btn-join ">회원가입</a>
                </div>

				<!-- 분류검색 레이어팝업 -->
				<div class="layerpopup pop02 ksic_popup" >
					<h3 class="pop-header"><strong>표준산업분류 명칭</strong></h3>
					<div class="pop-content">
						<ul class="ksic_info">
							<li>검색할 표준산업분류코드(KSIC) 명칭을 입력한 후 검색 버튼을 누르세요.</li>
							<li>보기 : 통신, 의료, 소프트웨어</li>
						</ul>
						<form action="#">
							<fieldset>
								<legend>표준산업분류 명칭 검색하는 폼</legend>
								<div class="ksic_search">
									<label for="ksic_name">표준산업분류 명칭</label>
									<input type="text" id="ksic_name" onkeydown="if(ItgJs.fn_isEnter(event)) {fn_searchKsic(event); return false;}"  />
									<button class="ksic_search_btn" onclick="fn_searchKsic(event); return false;">검색</button>
								</div>
								<div class="ksic_list" id="ksic_list">
								</div>
								<div class="btn-wrap">
									<button onclick="fn_setKsicSelect(event);" class="btn type2">적 용</button>
								</div>
								<button class="btn-pop-close" onclick="return false;">
									팝업닫기
								</button>
							</fieldset>
						</form>
					</div>
				</div>
				<!-- //분류검색 레이어팝업 -->

 <script src="/resource/common/jquery_plugin/validation/validator.js"></script>
 <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
 <script>

 $(function(){
		ItgJs.selectBoxLocalNumber("officeTel01", "");
		ItgJs.selectBoxLocalNumber("faxNo01", "");
		ItgJs.selectBoxLocalNumber("phone1", "");
		ItgJs.selectBoxEmail("ceoEmail2","");
		ItgJs.selectBoxEmail("email2","");
		$("#estDt").datepicker();
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
			//사업자번호
			var busiRegNo = frm.busiRegNo1.value + "" +frm.busiRegNo2.value + ""  +frm.busiRegNo3.value ;
			if(!ItgJs.fn_bisCheck(busiRegNo)) {
				alert("올바른 사업자번호가 아닙니다.");
				return false;
			}
			frm.busiRegNo.value = busiRegNo;
			// 표준산업분류코드

			//대표이사이메일
			if ($.trim($("#ceoEmail1").val()) != "") {
				var email = $("#ceoEmail1").val();
				if ($.trim($("#ceoEmail2 > option:selected").val()) != "") {
					email += "@" + $("#ceoEmail2 > option:selected").val();
				}
				else {
					email += "@" +  $("#ceoEmail3").val();
				}
				$("#ceoEmail").val(email);

				if (frm.ceoEmail.required) {
					if (!ItgJs.fn_chkEmail(frm.ceoEmail, "대표이사이메일을 확인해 주세요.(빈칸, 형식 등)")) {
						return false;
					}
				} else {
					if (!ItgJs.fn_chkEmail(frm.ceoEmail)){
						$("#ceoEmail").val("");
					}
				}
			}else{
				if (frm.ceoEmail.required && !ItgJs.fn_chkValue(frm.ceoEmail1, "대표이사이메일을 앞부분을 입력해주세요")) {
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

			var phone = frm.phone1.value + "-" + frm.phone2.value + "-" + frm.phone3.value;
			frm.phone.value = phone;
			$.ajax({
				 url: "/${siteCode}/module/${menuVO.menuCode}_checkbusiRegNo.ajax"
				, data: "busiRegNo=" + busiRegNo
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
						checkFlagId = true;
						frm.action="/${siteCode}/module/${menuVO.menuCode}_input_proc.do";
						frm.submit();
					}
					else if (data.result == "2") {
						alert(data.message);
						checkFlagId = false;
						return false;
					}
				}
				, error: function (request, status, error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});

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
	function fn_emailChange(id) {

		$("#").val("");
		if ($("#"+ id + "2 > option:selected").val() == "") {
			$("#"+ id + "3").show();
		}
		else {
			$("#"+ id + "3").hide();
		}
		$("#"+ id + "3").val("");
	}

	function fn_searchKsic(event) {
 		bSelect = false;
 		event.preventDefault();
 		var ksicName = $("#ksic_name").val();
 		if(ksicName == "") {
 			alert("검색 할 표준산업분류 명칭을 입력 해 주세요");
 			return false;
 		}
 		$.ajax({
 			url: "/${siteCode}/cominfo/userKsicSearch.ajax",
 			data: "schStr=" + encodeURIComponent(ksicName),
 			dataType: "json",
 			success: function(resultData) {
 				if(resultData.result == "1") {
 					var html = "";
 					for(var i = 0; i < resultData.data.length; i++ ) {
 						html += "<li>";
 						html += "<button onclick=\"fn_selectKsic(event, '"+resultData.data[i].ksicCd+"','"+resultData.data[i].ksicNm+"')\">";
 						html += resultData.data[i].ksicNm
//  						html += "</td>";
//  						html += "<td><a href='#' onclick=\"fn_setKsic('" + resultData.data[i].ksicCd + "','" + resultData.data[i].ksicNm + "')\">";
//  						html += resultData.data[i].ksicNm
//  						html += "</a>";
 						html += "</button>";
 						html += "</li>";
 					}
 					if(resultData.data.length == 0){
 						html = "<li>검색된 데이터가 없습니다</li>";
 					}
 					$("#ksic_list").html("<ul>" + html + "</ul>");
 				} else {
 					alert(resultData.message);
 					return;
 				}
 			},
 			error:function(request,status,error){
 				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
 			}
 		})
 	}

 	var ksicCd = "";
 	var ksicNm = "";
 	var bSelect = false;
 	function fn_selectKsic(event, cd, nm){
 		event.preventDefault();
 		ksicCd = cd;
 		ksicNm = nm;
 		bSelect = true;

 		var thisEle = event.target;
		$(thisEle).closest('ul').find('button').css('color','#595959');
		$(thisEle).css('color','#0080c9');
 	}
 	function fn_setKsicSelect(event) {
 		event.preventDefault();
 		if(!bSelect) {
 			alert("적용할 항목을 선택 해 주세요");
 			return false;
 		}
 		$("#schKsicCd").val(ksicCd);
 		$("#schKsicNm").val(ksicNm);
 		bSelect = false;
 		fn_ksicPopupClose(event);
 	}
 	function fn_ksicPopupClose(event){
 		event.preventDefault();
 		$('.ksic_popup').removeAttr("tabindex").hide();
         $('.pop-bg').remove();
         $("body").removeAttr("style");
         $(".btn-modal-pop#ksic_popup").focus();
 	}
 </script>
