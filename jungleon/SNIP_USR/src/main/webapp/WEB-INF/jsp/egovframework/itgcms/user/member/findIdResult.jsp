<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

<div class="login-wrap idpw-find mt-50">    
	<div class="member-help">
	    <p class="end-msg">요청하신 아이디는 [ <strong class="point-color">${memId}</strong> ] 입니다. </p>
	    <p class="end-msg">가입일 : ${ufn:printDatePattern(regDt, 'yyyy-MM-dd')} </p>
	</div>               
</div>
<div class="btn-wrap is-btn_two text-c">
    <a href="/${siteCode}/contents/snipLogin.do" class="btn btn-gray btn-go ">로그인 페이지로 이동</a> 
    <a href="/${siteCode}/contents/find.do" class="btn btn-blue btn-join ">아이디 찾기</a>
    <a href="#none" onclick="document.form1.submit();return false;" class="btn btn-blue btn-join ">비밀번호 찾기</a>
</div>
<form name="form1" method="post" action="/${siteCode}/contents/find-pass.do">
<input type="hidden" name="findId" value="${memId }" />
</form>
