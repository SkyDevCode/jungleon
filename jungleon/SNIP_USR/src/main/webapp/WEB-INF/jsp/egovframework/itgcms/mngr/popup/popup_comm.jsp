<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
/**
 * @파일명 : mngrPopup.jsp
 * @파일정보 : 팝업관리 공통
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
<c:choose>
    <c:when test="${mngrPopupSearchVO.schM eq 'regist'}">
		<c:import url="/_mngr_/popup/popup${mngrPopupSearchVO.schPopupType}_input.do" />
    </c:when>
    <c:when test="${mngrPopupSearchVO.schM eq 'view'}">
        <c:import url="/_mngr_/popup/popup${mngrPopupSearchVO.schPopupType}_edit.do" />
    </c:when>
    <c:when test="${mngrPopupSearchVO.schM eq 'registProc'}">
    	<c:import url="/_mngr_/popup/popup${mngrPopupSearchVO.schPopupType}_input_proc.do" />
    </c:when>
    <c:when test="${mngrPopupSearchVO.schM eq 'updateProc'}">
    	<c:import url="/_mngr_/popup/popup${mngrPopupSearchVO.schPopupType}_edit_proc.do" />
    </c:when>
    <c:when test="${mngrPopupSearchVO.schM eq 'delete'}">
        <c:import url="/_mngr_/popup/popup${mngrPopupSearchVO.schPopupType}_delete_proc.do" />
    </c:when>
    <c:when test="${mngrPopupSearchVO.schM eq 'chkDel'}">
        <c:import url="/_mngr_/popup/popup${mngrPopupSearchVO.schPopupType}_delete_chkProc.do" />
    </c:when>
    <c:otherwise>
        <c:import url="/_mngr_/popup/popup${mngrPopupSearchVO.schPopupType}_list.do" />
    </c:otherwise>
</c:choose>
