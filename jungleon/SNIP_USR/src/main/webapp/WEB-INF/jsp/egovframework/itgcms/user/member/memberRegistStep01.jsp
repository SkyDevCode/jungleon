<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
	<form name="form_chk" method="post">
		<input type="hidden" name="m" value="checkplusService">
		<input type="hidden" name="EncodeData" value="${sEncData }">
		<ol class="join-step-list">
                    <li class="step01 checked">
                        <span class="n_mobile">01.</span>
                        <span class="num v_mobile">
                            <span class="blind">1</span>
                        </span>
                        <span class="tit">약관동의</span>
                    </li>
                    <li class="step02 active">
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

                <div class="certification-wrap">
                    <div class="certification-text">
                        <h3>핸드폰 인증</h3>
                        <p>휴대폰 인증을 통한 가입을 원하시면 아래의 <span>‘휴대폰 인증’</span> 버튼을 눌러주세요.</p>
                    </div>
                    <div class="certification-bottom">
                        <p>“담당자(개인/기업) 명의로  실명인증을 진행해주세요. ”</p>
                        <button type="button" onclick="fnPopup(); return false;" class="btn btn-blue btn-join" title="새창열림">휴대폰 인증</button>
                    </div>
                </div>

		<%-- E: 추가 영역 --%>
	</form>
	<script>
	function fnPopup(){
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chk.target = "popupChk";
		document.form_chk.submit();
	}
	</script>