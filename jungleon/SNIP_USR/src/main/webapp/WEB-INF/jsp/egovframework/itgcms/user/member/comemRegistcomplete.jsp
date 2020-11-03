<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>


<script type="text/javascript">
	$(document).ready(function() {
		var resultMsg = "${resultMsg}";
		if (resultMsg != "") {
			alert(resultMsg);
		}
	});
</script>


<div class="fixwidth">
	<div class="userInfo">
	
		<div class="grayCont">
			<ul class="joinic_c">
				<li><div></div><span>기업 정보입력</span></li>
				<li class="on"><div></div><span>기업 신청완료</span></li>
			</ul>
		</div>
		
		<div class="conbox">
			<div class="msgwrap">
				<p class="msgimg"><img src="/resource/common/img/sub/join_w_msgbox.png" alt="기업 신청이 정상적으로 완료되었습니다."></p>
				<p class="msgtit">기업 신청이<br>정상적으로 완료되었습니다.</p>
				<p class="msgtxt">관리자 승인이 완료되면 문자(SMS)로 승인확인 문자가 발송되오니 이용에 참고하여 주시기 바랍니다.</p>
				<p><a href="/" class="btn4">메인으로</a></p>
			</div>
		</div>
						
	</div>
</div>


<%-- 
	<div class="content">
		S: 추가 영역
		<ul class="stepList">
			<li class="step01"><div></div><span>본인인증</span></li>
			<li class="step02"><div></div><span>약관동의</span></li>
			<li class="step03 on"><div></div><span>개인정보입력</span></li>
			<li class="step04"><div></div><span>가입완료</span></li>
<!-- 			<li class="step01"><em>01</em>약관동의</li>
			<li class="step02"><em>02</em>회원정보입력</li>
			<li class="step03 on"><em>03</em>가입완료</li> -->
		</ul>

		<div class="join_complete">
			<h3 class="tit">회원가입이 <span>완료되었습니다.</span></h3>
			<p class="mb5"> 회원에 가입하신 것을 환영합니다.</p>
			<p>하단의 확인을 클릭하시면 로그인페이지로 이동합니다.</p>
		</div>

		<div class="clauseBtn">
			<a href="/web/contents/login.do" class="midBtn btnRed">확인</a>
		</div>
		E: 추가 영역
	</div>
 --%>