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
                        <col style="width:15%">
                        <col style="width:35%">
                        <col style="width:15%">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>아이디</th>
                            <td colspan="3">
                                <c:out value="${memberVO.id}" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호</th>
                            <td>
                                <input type="password" id="pass" name="pass" maxlength="20" class="inp_txt wd-360" autocomplete="false" title="비밀번호를 입력하세요">
                                <span class="notice-txt">* 신규 비밀번호를 입력하면 변경됩니다. 영문/숫자/특수문자 조합 10자리 이상 사용</span>
                            </td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호 확인</th>
                            <td>
                                <input type="password" id="pass2" name="pass2" maxlength="20" class="inp_txt wd-360" autocomplete="false"  title="비밀번호를 재 입력하세요">
                                <span class="notice-txt">* 영문/숫자/특수문자 조합 10자리 이상 사용</span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>비밀번호 힌트</th>
                            <td>
                                <div class="slt_wrap n-wd100p">
                                    <select name="pwdQuest" id="pwdQuest" class="slt_box" title="비밀번호 힌트 선택">
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
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>회사명</th>
                            <td><input type="text" name="comNm" id="comNm" maxlength="50" value="<c:out value="${cominfo.comNm }" />" class="inp_txt  wd-360 required" title="회사명을 입력하세요"></td>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>대표자명</th>
                            <td><input type="text" name="ceoNm" id="ceoNm" maxlength="24" value="<c:out value="${cominfo.ceoNm }" />" class="inp_txt  wd-360 required" title="대표자명을 입력하세요"></td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>대표자성별</th>
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
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>기업형태</th>
                            <td>
                                <div class="radio_wrap">
                                    <input type="radio" name="comTp" id="inp_rdo1c" value="V006000002" ${ufn:checked(cominfo.comTp, 'V006000002') }>
                                    <label for="inp_rdo1c" class="inp_rdo">법인기업</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="comTp" id="inp_rdo2c" value="V006000001" ${ufn:checked(cominfo.comTp, 'V006000001') }>
                                    <label for="inp_rdo2c" class="inp_rdo">개인기업</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>사업자등록번호</th>
                            <td colspan="3">
                                <input type="text" name="busiRegNo1" id="busiRegNo1" readonly="readonly" maxlength="3" value="<c:out value="${fn:substring(cominfo.busiRegNo, 0,3) }" />" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110 required"  title="사업자등록번호 첫번째 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="busiRegNo2" id="busiRegNo2" readonly="readonly" maxlength="2" value="<c:out value="${fn:substring(cominfo.busiRegNo, 3,5) }" />" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110 required"  title="사업자등록번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="busiRegNo3" id="busiRegNo3" readonly="readonly" maxlength="5" value="<c:out value="${fn:substring(cominfo.busiRegNo, 5,10) }" />" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110 required"  title="사업자등록번호 마지막 자리를 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>표준산업분류코드</th>
                            <td colspan="3">
                                <input type="text" name="unCd" id="schKsicCd" value="<c:out value="${cominfo.unCd }" />" readonly="readonly" class="inp_txt wd-160 required"  title="사업자등록번호 첫번째 자리를 입력하세요">
                                <input type="text" name="unNm" id="schKsicCd" value="<c:out value="${cominfo.unNm }" />" readonly="readonly" class="inp_txt wd-360"  title="사업자등록번호 가운데 자리를 입력하세요">
                                <button type="button" class="btn btn-blue btn-icon-search btn-modal-pop" id="ksic_popup">분류검색</button>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>주요생산품</th>
                            <td>
                                <input type="text" name="mainProduct" id="mainProduct" value="<c:out value="${cominfo.mainProduct }" />" maxlength="500" class="inp_txt  wd-360 required" title="주요생산품을 입력하세요">
                            </td>
                            <th scope="row">회사전화번호</th>
                            <td>
                                <div class="slt_wrap">
                                    <select name="officeTel01" id="officeTel01" class="slt_box" title="전화번호 앞자리를 선택하세요">
                                    </select>
                                </div>
                                <span class="hyphen">-</span>
                                <input type="text" name="officeTel02" id="officeTel02" value="<c:out value="${cominfo.officeTel02 }" />" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="전화번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="officeTel03" id="officeTel03" value="<c:out value="${cominfo.officeTel03 }" />" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="전화번호 마지막 자리를 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>설립일</th>
                            <td>
                                <input type="text" name="estDt" id="estDt" value="<c:out value="${cominfo.estDt }" />" readonly="readonly" class="inp_txt  wd-110 datapick-m required" id="datepicker" title="설립일 입력하세요">
                            </td>
                            <th scope="row">회사팩스번호</th>
                            <td>
                                <div class="slt_wrap">
                                    <select name="faxNo01" id="faxNo01" class="slt_box" title="팩스번호 앞자리를 선택하세요">
                                    </select>
                                </div>
                                <span class="hyphen">-</span>
                                <input type="text" name="faxNo02" id="faxNo02" value="<c:out value="${cominfo.faxNo02 }" />" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="팩스번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="faxNo03" id="faxNo03" value="<c:out value="${cominfo.faxNo03 }" />" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="팩스번호 마지막 자리를 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>대표자 이메일</th>
                            <td colspan="3">
                            	<c:set var="arrCeoEmail" value="${fn:split(cominfo.ceoEmail, '@') }" />
                                <input type="text" name="ceoEmail1" id="ceoEmail1" value="<c:out value="${arrCeoEmail[0] }" />" maxlength="20" class="inp_txt email-fm" title="이메일 아이디를 입력하세요">
                                <span class="hyphen">@</span>
                                <input type="text" name="ceoEmail3" id="ceoEmail3" value="<c:out value="${arrCeoEmail[1] }" />" maxlength="50"class="inp_txt email-fm"  title="이메일 공급자를 입력하세요">
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
                                <input type="text" name="hPage" id="hPage" maxlength="100" value="<c:out value="${cominfo.hPage }" />" class="inp_txt wd-100p validate-url" title="홈페이지를 입력하세요">

                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>주소</th>
                            <td colspan="3">
                                <ul class="address-form">
                                    <li>
                                        <input type="text" name="zip" id="zip" value="<c:out value="${cominfo.zip }" />" readonly="readonly" class="inp_txt wd-160 required" title="우편번호">
                                        <button type="button" onclick="ItgJs.getDaumAddressStreet({zip:'zip',addr1:'addr01',addr2:'addr02'});" class="btn btn-blue btn-icon-search" id="postSearchBtn">우편검색</button>
                                        <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
																									<div id="daumPostLayer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;" tabindex="0">
																									<a href="#none" id="btnCloseLayer"
																						     style="cursor:pointer;display:block;position:absolute;right:-3px;top:-3px;z-index:100" onclick="ItgJs.getDaumAddressLayerClose()" tabindex="0" title="우편번호 찾기 레이어 닫기"><img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png"  alt="닫기 버튼"></a>
																									</div>
                                    </li>
                                    <li class="mt-5"><input type="text" name="addr01" id="addr01" value="<c:out value="${cominfo.addr01 }" />" readonly="readonly" class="inp_txt wd-100p"  title="주소 입력"></li>
                                    <li class="mt-5"><input type="text" name="addr02" id="addr02" value="<c:out value="${cominfo.addr02 }" />" maxlength="50" class="inp_txt wd-100p" title="상세주소를 입력해주세요."  placeholder="상세주소를 입력해주세요."></li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>가입자성명</th>
                            <td colspan="3">
                                <input type="text" name="name" id="name" maxlength="20" value="<c:out value="${memberVO.name }" />" class="inp_txt wd-360 required" title="가입자성명을 입력하세요">
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
                                    <input type="hidden" name="birth" id="birth" />
                                </div>
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
                            <th scope="row">부서/직급</th>
                            <td colspan="3">
                                <input type="text" name="position" id="position" value="<c:out value="${memberVO.position }" />" maxlength="30" class="inp_txt wd-360" title="부서/직급을 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">전화번호</th>
                            <td colspan="3">
                            	<c:set var="arrPhone" value="${fn:split(memberVO.phone, '-') }" />
                                <div class="slt_wrap">
                                    <select name="phone1" id="phone1" class="slt_box" title="전화번호 앞자리를 선택하세요">
                                    </select>
                                </div>
                                <span class="hyphen">-</span>
                                <input type="text" name="phone2" id="phone2" value="<c:out value="${arrPhone[1] }" />" maxlength="4" class="inp_txt wd-110" onkeydown="ItgJs.fn_numberOnly(event);" title="전화번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="phone3" id="phone3" value="<c:out value="${arrPhone[2] }" />" maxlength="4" class="inp_txt wd-110" onkeydown="ItgJs.fn_numberOnly(event);" title="전화번호 마지막 자리를 입력하세요">
                                <input type="hidden" name="phone" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">핸드폰번호</th>
                            <td colspan="3">
                            <c:set var="arrMobile" value="${fn:split(memberVO.mobile, '-') }" />
                                <div class="slt_wrap">
                                    <select name="mobile1" id="mobile1" class="slt_box" title="핸드폰번호 앞자리를 선택하세요">
                                    </select>
                                </div>
                                <span class="hyphen">-</span>
                                <input type="text" name="mobile2" id="mobile2" value="<c:out value="${arrMobile[1] }" />" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="핸드폰번호 가운데 자리를 입력하세요">
                                <span class="hyphen">-</span>
                                <input type="text" name="mobile3" id="mobile3" value="<c:out value="${arrMobile[2] }" />" maxlength="4" onkeydown="ItgJs.fn_numberOnly(event);" class="inp_txt wd-110"  title="핸드폰번호 마지막 자리를 입력하세요">
                                <input type="hidden" name="mobile" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>이메일</th>
                            <td colspan="3">
                            	<c:set var="arrEmail" value="${fn:split(memberVO.email, '@') }" />
                                <input type="text" name="email1" id="email1" value="${arrEmail[0] }" maxlength="20" class="inp_txt email-fm" title="이메일 아이디를 입력하세요">
                                <span class="hyphen">@</span>
                                <input type="text" name="email3" id="email3" value="${arrEmail[1] }" maxlength="50" class="inp_txt email-fm"  title="이메일 공급자를 입력하세요">
                                <div class="slt_wrap  n-wd100p email-slt">
                                    <select name="email2" id="email2" onchange="fn_emailChange('email');" class="slt_box" title="이메일 공급자를 선택하세요">
                                    </select>
                                </div>
                                <input type="hidden" name="email" id="email" required="required" />
                            </td>
                        </tr>

                        <tr>
                            <th scope="row"><span class="must-icon" title="필수체크 항목">*</span>메일링서비스</th>
                            <td colspan="3">
                                <div class="radio_wrap">
                                    <input type="radio" name="emailYn" value="Y" id="inp_rdo1a" ${ufn:checked(memberVO.emailYn, 'Y') }>
                                    <label for="inp_rdo1a" class="inp_rdo">수신합니다.</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="emailYn" value="N" id="inp_rdo2a" ${ufn:checked(memberVO.emailYn, 'N') }>
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
                                    <input type="radio" name="knowpath" value="1" id="knowpath1" ${ufn:checked(memberVO.knowpath, '1') }>
                                    <label for="knowpath1" class="inp_rdo">포털사이트(검색)</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" value="2" id="knowpath2" ${ufn:checked(memberVO.knowpath, '2') }>
                                    <label for="knowpath2" class="inp_rdo">이메일</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" value="3" id="knowpath3" ${ufn:checked(memberVO.knowpath, '3') }>
                                    <label for="knowpath3" class="inp_rdo">팩스/방문</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" value="4" id="knowpath4" ${ufn:checked(memberVO.knowpath, '4') }>
                                    <label for="knowpath4" class="inp_rdo">유관기관(배너)</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" value="5" id="knowpath5" ${ufn:checked(memberVO.knowpath, '5') }>
                                    <label for="knowpath5" class="inp_rdo">언론매체</label>
                                </div>
                                <div class="radio_wrap">
                                    <input type="radio" name="knowpath" value="6" id="knowpath6" ${ufn:checked(memberVO.knowpath, '6') }>
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

				<!-- 분류검색 레이어팝업 -->
				<div class="layerpopup pop02 ksic_popup" >
					<h3 class="pop-header"><strong>표준산업분류 명칭</strong></h3>
					<div class="pop-content">
						<ul class="ksic_info">
							<li>검색할 표준산업분류코드(KSIC) 명칭을 입력한 후 검색 버튼을 누르세요.</li>
							<li>보기 : 통신, 의료, 소프트웨어</li>
						</ul>
						<!-- <form action="#"> -->
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
								<button class="btn-pop-close">
									팝업닫기
								</button>
							</fieldset>
						<!-- </form> -->
					</div>
				</div>
				<!-- //분류검색 레이어팝업 -->

                 <script src="/resource/common/jquery_plugin/validation/validator.js"></script>
                 <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
                 <script>
                 $(function(){
             		ItgJs.selectBoxLocalNumber("officeTel01", "<c:out value="${cominfo.officeTel01}" />");
             		ItgJs.selectBoxLocalNumber("faxNo01", "<c:out value="${cominfo.faxNo01}" />");
             		ItgJs.selectBoxLocalNumber("phone1", "<c:out value="${arrPhone[0]}" />");
             		ItgJs.selectBoxMobileLocalNumber("mobile1", "<c:out value="${arrMobile[0]}" />");
             		ItgJs.selectBoxEmail("ceoEmail2","");
             		ItgJs.selectBoxEmail("email2","");
             		$("#estDt").datepicker();
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
//              						html += "</td>";
//              						html += "<td><a href='#' onclick=\"fn_setKsic('" + resultData.data[i].ksicCd + "','" + resultData.data[i].ksicNm + "')\">";
//              						html += resultData.data[i].ksicNm
//              						html += "</a>";
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
                     $(".btn-modal-pop#ksic_popup").focus();
             	}

                 </script>

