<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

<%-- S: 추가 영역 --%>
<form name="form1" method="post" onsubmit="fn_goNext(); return false;">
<input type="hidden" name="stp" value="Step01" />
<input type="hidden" name="type" value="<c:out value="${memType }" />" />
<input type="hidden" name="agree" value="agree" />
<ol class="join-step-list">
                    <li class="step01 active">
                        <span class="n_mobile">01.</span>
                        <span class="num v_mobile">1</span>
                        <span class="tit">약관동의</span>
                    </li>
                    <li class="step02">
                        <span class="n_mobile">02.</span>
                        <span class="num v_mobile">2</span>
                        <span class="tit">본인확인</span>
                    </li>
                    <li class="step03">
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

                <div class="box member-guide__box">
                    서비스를 이용하시는 이용자 여러분께 감사드립니다. <br>
                    성남산업진흥원이 운영하는 중소/벤처기업 여러분을 위한 정보공유와 지원사업을 진행하는 포탈사이트입니다.
                </div>

                <h3 class="y-subpage-tit">개인정보 수집 및 이용</h3>
                <textarea class="yaguan">
가. 개인정보의 수집 및 이용목적
1. 회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 각종 고지·통지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 수집합니다.
2. 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등의 목적으로 개인정보를 수집합니다.
3. 서비스제공, 콘텐츠 제공, 맞춤 서비스 제공, 본인인증 등을 목적으로 개인 정보를 수집합니다.
4. 진흥원 사업안내, 신규 서비스 지원 및 맞춤 서비스 제공, 기업의 진흥원사업 참여 기회 제공을 위한 안내, 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 수집합니다.
                </textarea>
                <div class="yakguan-agree">
                    <div class="radio_wrap">
                        <input type="radio" name="agree1" id="agree11">
                        <label for="agree11" class="inp_rdo">약관에 동의함</label>
                    </div>
                    <div class="radio_wrap">
                        <input type="radio" name="agree1" id="agree12">
                        <label for="agree12" class="inp_rdo">약관에 동의하지 않음</label>
                    </div>
                </div>

                <h3 class="y-subpage-tit">선택적 개인정보 수집 및 이용</h3>
                <textarea class="yaguan">
가. 개인정보의 수집 및 이용목적
1. 회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 각종 고지·통지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 수집합니다.
2. 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등의 목적으로 개인정보를 수집합니다.
3. 서비스제공, 콘텐츠 제공, 맞춤 서비스 제공, 본인인증 등을 목적으로 개인 정보를 수집합니다.
4. 진흥원 사업안내, 신규 서비스 지원 및 맞춤 서비스 제공, 기업의 진흥원사업 참여 기회 제공을 위한 안내, 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 수집합니다.
                </textarea>
                <div class="yakguan-agree">
                    <div class="radio_wrap">
                        <input type="radio" name="agree2" id="agree21">
                        <label for="agree21" class="inp_rdo">약관에 동의함</label>
                    </div>
                    <div class="radio_wrap">
                        <input type="radio" name="agree2" id="agree22">
                        <label for="agree22" class="inp_rdo">약관에 동의하지 않음</label>
                    </div>
                </div>
                <h3 class="y-subpage-tit">성남벤처넷 이용약관</h3>
                <textarea class="yaguan">
가. 개인정보의 수집 및 이용목적
1. 회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 각종 고지·통지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 수집합니다.
2. 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등의 목적으로 개인정보를 수집합니다.
3. 서비스제공, 콘텐츠 제공, 맞춤 서비스 제공, 본인인증 등을 목적으로 개인 정보를 수집합니다.
4. 진흥원 사업안내, 신규 서비스 지원 및 맞춤 서비스 제공, 기업의 진흥원사업 참여 기회 제공을 위한 안내, 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 수집합니다.
                </textarea>
                <div class="yakguan-agree">
                    <div class="radio_wrap">
                        <input type="radio" name="agree3" id="agree31">
                        <label for="agree31" class="inp_rdo">약관에 동의함</label>
                    </div>
                    <div class="radio_wrap">
                        <input type="radio" name="agree3" id="agree32">
                        <label for="agree32" class="inp_rdo">약관에 동의하지 않음</label>
                    </div>
                </div>

                <div class="btn-wrap__member">
                    <a href="#none" onclick="fn_cancel(); return false;" class="btn btn-gray btn-cancel">취소하기</a>
                    <a href="#none" onclick="fn_regist(); return false;" class="btn btn-blue btn-ok">확인하기</a>
                </div>
</form>
<script>
function fn_cancel(){
	if(confirm("회원가입을 취소하시겠습니까?")) {
		location.href="/${siteCode}/contents/registration.do";
	}
}
function fn_regist(){
	var frm = document.form1;
	if(!frm.agree1[0].checked) {
		alert("개인정보 수집 및 이용에 동의 해 주세요.");
		frm.agree1[0].focus();
		return false;
	}
	if(!frm.agree2[0].checked) {
		alert("선택적 개인정보 수집 및 이용에 동의 해 주세요.");
		frm.agree2[0].focus();
		return false;
	}
	if(!frm.agree3[0].checked) {
		alert("성남벤처넷 이용약관에 동의 해 주세요.");
		frm.agree3[0].focus();
		return false;
	}
	frm.action="/${siteCode}/contents/registration.do";
	frm.submit();
}
</script>
<%-- E: 추가 영역 --%>
