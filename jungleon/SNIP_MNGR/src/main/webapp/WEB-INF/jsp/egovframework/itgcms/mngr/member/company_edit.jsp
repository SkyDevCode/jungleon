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
													<td colspan="3">
														<div class="form-inline">
															<input type="text" name="id" id="id" maxlength="20" value="<c:out value="${result.id}"/>" class="form-control input-sm f-wd-200 required" title="아이디" onchange="fn_checkId(this.value);" />
															<span id="idHelp" class="help">영문숫자조합 (영문으로 시작, 4 ~ 12자)</span>
														</div>
													</td>
												</tr>
											</c:when>
											<c:when test="${searchVO.act == 'UPDATE'}">
												<tr>
													<th class="t"><span>아이디</span></th>
													<td colspan="3">
														<c:out value="${result.id}"/>
														<c:choose>
															<c:when test="${result.status eq 'mem_cutoff'}">
																<span style="color:#1A90D8;padding-left:5px;">[차단된 사용자 정보]</span>
															</c:when>
														</c:choose>
														<input type="hidden" name="id" id="id" value="<c:out value="${result.id}"/>">
													</td>
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
											<th class="t"><label for="pwdQuest">비밀번호 힌트 *</label></th>
											<td>
												<select name="pwdQuest" id="pwdQuest" class="form-control required">
													<c:forEach var="code" items="${pwdQuest }">	
														<option value="${code.ccode }" ${ufn:selected(result.pwdQuest, code.ccode) }><c:out value="${code.cname}" /></option>
													</c:forEach>
												</select>
											</td>
											<th class="t"><span>비밀번호 답변 * </span></th>
											<td>
												<input type="text" name="pwdAnswer" id="pwdAnswer" maxlength="20" value="<c:out value="${result.pwdAnswer}"/>" class="form-control input-sm f-wd-200 required" title="비밀번호 답변" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="comNm">회사명 *</label></th>
											<td>
												<input type="text" name="comNm" id="comNm" maxlength="20" value="<c:out value="${cominfo.comNm}"/>" class="form-control input-sm f-wd-200 required" title="회사명" />
											</td>
											<th class="t"><span for="comNm">대표자명 * </span></th>
											<td>
												<input type="text" name="ceoNm" id="ceoNm" maxlength="20" value="<c:out value="${cominfo.ceoNm}"/>" class="form-control input-sm f-wd-200 required" title="대표자명" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="sexM">대표자 성별 *</label></th>
											<td>
												<label><input type="radio" name="sex" id="sexM" value="M" ${ufn:checked('M', result.sex)} ${ufn:checked('', result.sex)} /> 남성</label>
												<label><input type="radio" name="sex" id="sexF" value="F" ${ufn:checked('F', result.sex)} /> 여성</label>
											</td>
											<th class="t"><span for="comTp1">기업형태 * </span></th>
											<td>
												<label><input type="radio" name="comTp" id="comTp1" value="V006000001" ${ufn:checked('V006000001', cominfo.comTp)} ${ufn:checked('', cominfo.comTp)} /> 개인기업</label>
												<label><input type="radio" name="comTp" id="comTp2" value="V006000002" ${ufn:checked('V006000002', cominfo.comTp)} /> 법인기업</label>
											</td>
										</tr>
								<c:choose>
									<c:when test="${searchVO.act == 'REGIST'}">
										<tr>
											<th class="t"><label for="busiRegNo1">사업자등록번호</label></th>
											<td colspan="3">
												<input type="text" name="busiRegNo1" id="busiRegNo1" maxlength="3" onkeydown="ItgJs.fn_numberOnly(event);" class="form-control input-sm f-wd-100 required" style="display:inline-block;" title="사업자등록번호 첫번째" />
												- <input type="text" name="busiRegNo2" id="busiRegNo2" maxlength="2" onkeydown="ItgJs.fn_numberOnly(event);"  class="form-control input-sm f-wd-100 required" style="display:inline-block;" title="사업자등록번호 두번째" />
												- <input type="text" name="busiRegNo3" id="busiRegNo3" maxlength="5" onkeydown="ItgJs.fn_numberOnly(event);"  class="form-control input-sm f-wd-100 required" style="display:inline-block;" title="사업자등록번호 세번째" />
												<input type="hidden" name="busiRegNo" />
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<th class="t"><label>사업자등록번호</label></th>
											<td colspan="3">
												<c:out value="${fn:substring(cominfo.busiRegNo, 0,3) }" />
												- <c:out value="${fn:substring(cominfo.busiRegNo, 3,5) }" />
												- <c:out value="${fn:substring(cominfo.busiRegNo, 5,10) }" />
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
										<tr>
											<th class="t"><label for="busiRegNo1">표준산업분류코드</label></th>
											<td colspan="3">
												<input type="hidden" name="unCd" id="unCd" value="<c:out value="${cominfo.unCd }" />" />
												<span id="unNm"><c:out value="${cominfo.unNm }" /></span>
												<button type="button" class="btn btn-default btn-sm" onclick="fn_showKsicSearchLayer();" style="margin-left: 10px;">산업분류 검색</button>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="mainProduct">주요생산품</label></th>
											<td>
												<input type="text" name="mainProduct" id="mainProduct" maxlength="50" value="<c:out value="${cominfo.mainProduct}"/>" class="form-control input-sm f-wd-200" title="주요생산품" />
											</td>
											<th class="t"><span for="officeTel01">회사전화번호 </span></th>
											<td>
												<select name="officeTel01" id="officeTel01" class="form-control f-wd-100" style="display: inline-block;" title="회사 전화번호 국번"></select>
												<input type="text" name="officeTel02" id="officeTel02" class="form-control input-sm f-wd-100" style="display: inline-block;" value="<c:out value="${cominfo.officeTel02 }" />" maxlength="4" title="회사 전화번호 앞자리" />
												<input type="text" name="officeTel03" id="officeTel03" class="form-control input-sm f-wd-100" style="display: inline-block;" value="<c:out value="${cominfo.officeTel03 }" />" maxlength="4" title="회사 전화번호 뒷자리" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="estDt">설립일</label></th>
											<td>
												<input type="text" name="estDt" id="estDt" maxlength="10" value="<c:out value="${cominfo.estDt}"/>" class="form-control input-sm f-wd-200 validate-date"  title="설립일"/>
												<span id="pwHelp" class="help">예)2016-01-01</span>
											</td>
											<th class="t"><span for="faxNo01">회사팩스번호</span></th>
											<td>
												<select name="faxNo01" id="faxNo01" class="form-control f-wd-100" style="display: inline-block;"  title="회사 팩스번호 국번"></select>
												<input type="text" name="faxNo02" id="faxNo02" class="form-control input-sm f-wd-100" style="display: inline-block;" value="<c:out value="${cominfo.faxNo02 }" />" maxlength="4" title="회사 팩스번호 앞자리" />
												<input type="text" name="faxNo03" id="faxNo03" class="form-control input-sm f-wd-100" style="display: inline-block;" value="<c:out value="${cominfo.faxNo03 }" />" maxlength="4" title="회사 팩스번호 뒷자리" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="ceoEmail">대표자 이메일 *</label></th>
											<td colspan="3">
												<c:set var="arrCeoEmail" value="${fn:split(cominfo.ceoEmail, '@') }" />
												<input type="text" value="<c:out value="${arrCeoEmail[0]}"/>" id="ceoEmail1"  class="form-control input-sm f-wd-200 required" name="ceoEmail1" style="display: inline-block" title="대표자 이메일 주소">&nbsp;@&nbsp;
												<input type="text" value="<c:out value="${arrCeoEmail[1]}"/>" id="ceoEmail3" class="form-control input-sm f-wd-200" name="ceoEmail3" style="display: inline-block;">
												<select id="ceoEmail2" class="form-control input-sm f-wd-200" name="ceoEmail2" onchange="fn_emailChange('ceoEmail');return false;"  style="display: inline-block"></select>
												<input type="hidden" id="ceoEmail" name="ceoEmail" required="required"/>
												<p id="emailHelpP"><span id="emailHelp" style="color:blue; font-weight:bold;"></span></p>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="hPage">홈페이지</label></th>
											<td colspan="3">
												<input type="text" name="hPage" id="hPage" class="form-control input-sm f-wd-600" value="<c:out value="${cominfo.hPage }" />" maxlength="50" title="회사 홈페이지" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="ceoEmail">주소</label></th>
											<td colspan="3">
												<input type="text" name="zip" id="zip" maxlength="6" value="<c:out value="${cominfo.zip}"/>"  style="display:inline-block" title="우편번호" class="form-control input-sm f-wd-100 required" readonly="readonly" />
												<button type="button" class="btn btn-default btn-sm" onclick="ItgJs.getDaumAddressStreet({zip:'zip',addr1:'addr01',addr2:'addr02'});">우편번호 찾기<!-- [다음(레이어)] --></button>
												<input type="text" name="addr01" id="addr01" class="required form-control input-sm f-wd-600" value="<c:out value="${cominfo.addr01 }"/>" maxlength="50" title="회사주소" readonly="readonly"/>
												<input type="text" name="addr02" id="addr02" class="required form-control input-sm f-wd-600" value="<c:out value="${cominfo.addr02 }"/>" maxlength="50" title="회사 상세주소" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="name">가입자 성명</label></th>
											<td colspan="3"><input type="text" name="name" id="name" maxlength="20" value="<c:out value="${result.name}"/>" class="form-control input-sm f-wd-200 required" title="가입자성명" /></td>
										</tr>
										<tr>
											<th class="t"><label for="birth">생년월일</label></th>
											<td colspan="3">
												<div class="form-inline">
													<input type="text" name="birth" id="birth" maxlength="10" value="<c:out value="${result.birth}"/>" class="form-control input-sm f-wd-200 validate-date" title="생년월일"/>
													<span id="pwHelp" class="help">예)2016-01-01</span>
													
													<label><input type="radio" name="birthType" id="birthType1" value="1" ${ufn:checked('1', result.birthType)} ${ufn:checked('', result.birthType)} /> 양력</label>
													<label><input type="radio" name="birthType" id="birthType2" value="0" ${ufn:checked('0', result.birthType)} /> 음력</label>
												</div>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="position">부서/직급</label></th>
											<td colspan="3">
												<div class="form-inline">
													<input type="text" name="position" id="position" maxlength="10" value="<c:out value="${result.position}"/>" class="form-control input-sm f-wd-200" title="부서/직급"/>
													<span id="pwHelp" class="help">예)2016-01-01</span>
												</div>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="fax">팩스</label></th>
											<td colspan="3">
												<input type="text" name="fax" id="fax" maxlength="16" value="<c:out value="${result.fax}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200 " title="휴대폰번호" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="phone">전화번호</label></th>
											<td colspan="3">
												<input type="text" name="phone" id="phone" maxlength="16" value="<c:out value="${result.phone}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200" title="전화번호" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="mobile">핸드폰번호*</label></th>
											<td colspan="3">
												<input type="text" name="mobile" id="mobile" maxlength="16" value="<c:out value="${result.mobile}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200 required" title="핸드폰번호" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="email">이메일 *</label></th>
											<td colspan="3">
												<input type="text" name="email" id="email" maxlength="50" value="<c:out value="${result.email}"/>" class="form-control input-sm f-wd-200 required validate-email" title="이메일주소" />
											</td>
										</tr>
										<tr>
											<th class="t"><span>메일링 서비스</span></th>
											<td colspan="3">
												<label><input type="radio" name="emailYn" id="emailY" value="Y" ${ufn:checked('Y', fn:toUpperCase(result.emailYn))} ${ufn:checked('', fn:toUpperCase(result.emailYn))} /> 수신</label>
												<label><input type="radio" name="emailYn" id="emailN" value="N" ${ufn:checked('N', fn:toUpperCase(result.emailYn))} /> 미수신</label>
											</td>
										</tr>
										<tr>
											<th class="t"><span>관심 사업</span></th>
											<td colspan="3">
												<c:forEach var="code" items="${concerns}" varStatus="status">
												<c:set var="checked" value="" />
	                                        	<c:if test="${fn:indexOf(result.concerns, code.ccode) > -1 }">
	                                        		<c:set var="checked" value="checked='checked'" />
	                                        	</c:if>
													<p><label><input type="checkbox" name="concerns" id="concerns${status.count }" value="${code.ccode }" ${checked } /><c:out value="${code.cname}" /></label></p>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<th class="t"><span>성남벤처넷을 어떻게 알게 되셨나요?</span></th>
											<td colspan="3">
												<div class="radio_wrap">
				                                    <input type="radio" name="knowpath" id="knowpath1" value="1" ${ufn:checked(result.knowpath, '1') }>
				                                    <label for="knowpath1" class="inp_rdo">포털사이트(검색)</label>
				                                </div>    
				                                <div class="radio_wrap">
				                                    <input type="radio" name="knowpath" id="knowpath2" value="2" ${ufn:checked(result.knowpath, '2') }>
				                                    <label for="knowpath2" class="inp_rdo">이메일</label>
				                                </div>    
				                                <div class="radio_wrap">
				                                    <input type="radio" name="knowpath" id="knowpath3" value="3" ${ufn:checked(result.knowpath, '3') }>
				                                    <label for="knowpath3" class="inp_rdo">팩스/방문</label>
				                                </div>    
				                                <div class="radio_wrap">
				                                    <input type="radio" name="knowpath" id="knowpath4" value="4" ${ufn:checked(result.knowpath, '4') }>
				                                    <label for="knowpath4" class="inp_rdo">유관기관(배너)</label>
				                                </div>    
				                                <div class="radio_wrap">
				                                    <input type="radio" name="knowpath" id="knowpath5" value="5" ${ufn:checked(result.knowpath, '5') }>
				                                    <label for="knowpath5" class="inp_rdo">언론매체</label>
				                                </div>    
				                                <div class="radio_wrap">
				                                    <input type="radio" name="knowpath" id="knowpath6" value="6" ${ufn:checked(result.knowpath, '6') }>
				                                    <label for="knowpath6" class="inp_rdo">기타</label>
				                                </div>   
											</td>
										</tr>
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
													&nbsp;<img src="<c:url value="/resource/common/img/icon/ico_flag" />/<c:out value="${result.regCountryCd}" />.png" title="<c:out value="${result.regCountryName}" />" />
												</c:if>
												<c:if test="${!empty result.regOsIcon}">
													&nbsp;<img src="<c:url value="/resource/common/img/icon/ico_os" />/<c:out value="${result.regOsIcon}" />" title="<c:out value="${result.regOs}" />" />
												</c:if>
												<c:if test="${!empty result.regBrowserIcon}">
													&nbsp;<img src="<c:url value="/resource/common/img/icon/ico_ua" />/<c:out value="${result.regBrowserIcon}" />" title="<c:out value="${result.regBrowser}" />" />
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
													&nbsp;<img src="<c:url value="/resource/common/img/icon/ico_flag" />/<c:out value="${result.loginCountryCd}" />.png" title="<c:out value="${result.loginCountryName}" />" />
												</c:if>
												<c:if test="${!empty result.loginOsIcon}">
													&nbsp;<img src="<c:url value="/resource/common/img/icon/ico_os" />/<c:out value="${result.loginOsIcon}" />" title="<c:out value="${result.loginOs}" />" />
												</c:if>
												<c:if test="${!empty result.loginBrowserIcon}">
													&nbsp;<img src="<c:url value="/resource/common/img/icon/ico_ua" />/<c:out value="${result.loginBrowserIcon}" />" title="<c:out value="${result.loginBrowser}" />" />
												</c:if>
											</td>
										</tr>
									</c:if>
										<tr>
											<th class="t"><span>문자수신</span></th>
											<td colspan="3">
												<label><input type="radio" name="smsYn" id="smsY" value="Y" ${ufn:checked('Y', fn:toUpperCase(result.smsYn))} ${ufn:checked('', fn:toUpperCase(result.smsYn))}/> 수신</label>
												<label><input type="radio" name="smsYn" id="smsN" value="N" ${ufn:checked('N', fn:toUpperCase(result.smsYn))} /> 미수신</label>
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


<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="daumPostLayer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer"
	     style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="ItgJs.getDaumAddressLayerClose()" alt="닫기 버튼">
</div>
<div class="modal " id="ksicSearchLayer">
  <div class="modal-dialog " style="width: 1300px;">
  <div class="modal-content">
    <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="fn_closeModal();"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title">산업분류 검색</h4>
    </div>
    <div class="modal-body">
    	<div class="row margin-bottom">
					<div class="col-sm-12 form-inline text-right">
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schKsicStr" id="schKsicStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" onkeydown="if(ItgJs.fn_isEnter()) fn_ksicSearch();" title="코드, 산업분류 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search" onclick="fn_ksicSearch();">검색</button>
					</div>
				</div>
    	<div class="modalScr" style="">
        <table id="example1" class="table table-bordered tac">
            <colgroup>
          <col width="20%" />
          <col width="80%" />
        </colgroup>
        <thead>
          <tr>
            <th scope="col">산업분류 코드</th>
            <th scope="col">산업분류 명</th>
          </tr>
        </thead>
        <tbody id="ksicSearchLayerBody">
          <tr>
            <td colspan="2" class="tac">산업분류 코드 또는 산업분류 명을 입력해 주세요.</td>
          </tr>
        </tbody>
        </table>
      </div>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="fn_closeModal();">닫기</button>
    </div>
  </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->




<script type="text/javascript">
	//<[[!CDATA[
	$(function(){
   		ItgJs.selectBoxLocalNumber("officeTel01", "<c:out value="${cominfo.officeTel01}" />");
   		ItgJs.selectBoxLocalNumber("faxNo01", "<c:out value="${cominfo.faxNo01}" />");
   		ItgJs.selectBoxLocalNumber("phone1", "<c:out value="${arrPhone[0]}" />");
   		ItgJs.selectBoxMobileLocalNumber("mobile1", "<c:out value="${arrMobile[0]}" />");
   		ItgJs.selectBoxEmail("ceoEmail2","");
   		ItgJs.selectBoxEmail("email2","");
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
				var msg = ItgJs.fn_checkPass(frm.pass.value, frm.pass2.value);
				if (msg != "") {
					alert(msg);
					return false;
				}
			frm.busiRegNo.value = frm.busiRegNo1.value + "" + frm.busiRegNo2.value + "" + frm.busiRegNo3.value
			</c:if>
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
					if (!ItgJs.fn_chkEmail(frm.ceoEmail, "대표자이메일을 확인해 주세요.(빈칸, 형식 등)")) {
						return false;
					}
				} else {
					if (!ItgJs.fn_chkEmail(frm.ceoEmail)){
						$("#ceoEmail").val("");
					}
				}
			}else{
				if (frm.ceoEmail.required && !ItgJs.fn_chkValue(frm.ceoEmail1, "대표자이메일을 앞부분을 입력해주세요")) {
					return false;
				}
			}
			frm.action = "<c:url value="${searchVO.act == 'REGIST' ? 'company_input_proc.do' : 'company_edit_proc.do'}"/>";
			frm.submit();
		}
	}

	function fn_goList(){
		location.href = "company_list.do?<c:out value="${searchVO.query}" escapeXml="false" />"
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
				frm.action = "company_edit_initPass.do";
				frm.submit();
			}
		}

		function fn_goDel() {
			if (confirm("삭제하시겠습니까?")) {
				var frm = document.form1;
				frm.encoding = "application/x-www-form-urlencoded";
				frm.action = "company_delete_proc.do";
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
	
	function fn_showKsicSearchLayer() {
		$("#ksicSearchLayer").modal('show');
	}

	function fn_ksicSearch() {
		if($("#schKsicStr").val() == "") {
			alert("산업분류 코드 또는 산업분류 명을 입력해 주세요");
			return false;
		}
		$.ajax({
			url: "/_mngr_/module/${menuCode}_mngrKsicSearch.ajax",
			data: "schStr="+ $("#schKsicStr").val(),
			type: "post",
			dataType: "json",
			success: function(resultData) {
				if(resultData.result == "1") {
					var html = "";
					for(var i = 0; i < resultData.data.length; i++ ) {
						html += "<tr>";
						html += "<td>";
						html += resultData.data[i].ksicCd
						html += "</td>";
						html += "<td><a href='#' onclick=\"fn_setKsic('" + resultData.data[i].ksicCd + "','" + resultData.data[i].ksicNm + "')\">";
						html += resultData.data[i].ksicNm
						html += "</a></td>";
						html += "</tr>";
					}
					if(resultData.data.length == 0){
						html = "<tr><td colspan='2'>데이터가 없습니다.</td></tr>";
					}
					$("#ksicSearchLayerBody").html(html);
				} else {
					alert(resultData.message);
					return;
				}
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}

	function fn_setKsic(cd, nm) {
		if(confirm("선택하신 산업분류[" + nm + "]를 적용하시겠습니까?")) {
			$("#unCd").val(cd);
			$("#unNm").text(nm);
			$("#ksicSearchLayer").modal('hide');
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
</script>