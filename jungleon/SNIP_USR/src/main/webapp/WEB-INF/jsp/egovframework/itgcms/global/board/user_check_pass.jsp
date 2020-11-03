<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%@ taglib prefix="ora" uri="/WEB-INF/tlds/CustomTagSelectCodeList.tld" %>
<%
/**
 * @파일명 : user_qna_list.jsp
 * @파일정보 : 1대1질문답변형게시판 목록 스킨
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
<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){

})

/* 글 조회 화면 function */
function fn_goView() {

	var frm = document.schForm1;

	if (!ItgJs.fn_chkValue(frm.schSecritPw, "비밀번호를 입력해 주세요.")) {
		return false;
	}
	frm.action="?";
	frm.submit();
}


//]]>
</script>

<div class="boardTop">
	<form name="schForm1" method="post" onsubmit="fn_goView(); return false;">
	<c:forEach var="entry" items="${param}" varStatus="status">
		<input type="hidden" name="${entry.key}" value="${entry.value}"/>
	</c:forEach>
	<fieldset>
  		<legend>게시판 검색폼</legend>
  		<div class="c m secritBox">
  			<span>비밀번호를 입력해주세요.</span><br><br>
			<label for="schSecritPw" class="blind">비밀번호</label>
			<input type="password" name="schSecritPw" id="schSecritPw" class="searchTxt" title="비밀번호 입력" placeholder="비밀번호 입력해주세요" />
			<button type="submit" class="search">확인</button>
		</div>
	</fieldset>
	</form>
</div>
