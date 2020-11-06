<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

<%-- S: 추가 영역 --%>
<form name="form1" method="post" onsubmit="fn_goNext();return false;">
<input type="hidden" name="stp" value="agree" />
<input type="hidden" name="type" />
<div class="login-tit">
	<h3>안녕하십니까? 성남산업진흥원입니다.</h3>
	<p>
		성남산업진흥원 회원은 개인회원과 기업회원이 구분되어지며, 회원가입 후 다양한 혜택과 서비스를 받으실 수 있습니다. <br>
		<span class="ponter-color">※ 개인회원과 기업회원은 서로 전환되지 않습니다.</span>
	</p>
</div>

<div class="member-join__wrap">
	<div class="member-type type01">
		<h3>개인회원</h3>
		<p>
			성남산업진흥원의 다양한 정보와 <br> 서비스를 모두 이용하실 수 있습니다.
		</p>
		<button type="button" onclick="fn_goNext('N');return false;" class="btn  btn-join">회원가입</button>
	</div>
	<div class="member-type type02">
		<h3>기업회원</h3>
		<p>
			성남산업진흥원의 기업지원을 위한 서비스를 모두 이용하실 수 있습니다.<br> <span class="ponter">*
				담당자(개인/기업)명의로 실명인증을 진행해주세요.</span>
		</p>
		<button type="button" onclick="fn_goNext('C');return false;" class="btn btn-join ">회원가입</button>
	</div>
</div>
</form>
<script>
function fn_goNext(tp) {
	if(tp === "") {
		alert("회원 구분을 선택해 주세요");
		return false;
	}
	document.form1.type.value = tp;
	document.form1.action="/${siteCode}/contents/registration.do";
	document.form1.submit();
}
</script>
<%-- E: 추가 영역 --%>
