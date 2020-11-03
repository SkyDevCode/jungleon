<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%
/**
 * @파일명 : surveyResult.jsp
 * @파일정보 : 설문 결과 
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @hjw 2017. 7. 17. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<h3 style="text-align: center;">${surveyInfo.svTitle}</h3>
<p style="text-align: right;">총 제출 : ${surveyInfo.saNum} 명</p>


<c:forEach var="question" items="${surveyInfo.questionList}" varStatus="status">
	<div class="formchoice" style="margin-top: 10px; margin-bottom: 35px;">
		<div class="formtxt">
			<p class="tit">
				<strong style="font-size: 16px;">${status.count}.&nbsp;&nbsp;${question.sqQuestion}</strong>
			</p>	
			<c:choose>
				<c:when test="${question.sqAnswertype eq 'op_descriptive'}">
					<table class="table table-bordered">
						<c:forEach var="descVal" items="${question.valueArr}">
							<tr>
								<td>${descVal}</td>
							</tr>
						</c:forEach>
						<tr></tr>
					</table>
				</c:when>
				<c:when test="${question.sqAnswertype eq 'op_editable_radio'}">
					<table class="table table-bordered">
						<c:forEach var="value" items="${question.optionList}" varStatus="valIdx">
							<tr>
								<td style="width: 50px; text-align: center;">${valIdx.count}</td>
								<c:choose>
								<c:when test="${value.soContent eq '기타'}">
								<td>
									${value.soContent}<br><br>
									<c:forEach var="descVal" items="${question.valueArr}">
										${descVal}<hr>
									</c:forEach>
									<td style="width: 90px; text-align: right;">${fn:length(question.valueArr) }</td>
								</td>
								</c:when>
								<c:otherwise>
								<td>${value.soContent}</td>
								<td style="width: 90px; text-align: right;">${value.cnt}</td>
								</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</table>
				</c:when>
				<c:when test="${question.sqAnswertype == 'ob_sat' or question.sqAnswertype == 'ob_ass' or question.sqAnswertype == 'sc_num'}">
					<c:set var="widthVal" value="${100/(fn:length(question.optionList))}"/>
					<table class="table table-bordered">
						<tr>
							<c:forEach var="value" items="${question.optionList}">
								<th style="width: ${widthVal}%;text-align: center;">${value.soContent}</th>
							</c:forEach>
						</tr>
						<tr>
							<c:forEach var="value" items="${question.optionList}">
								<td style="text-align: center;">${value.cnt}</td>
							</c:forEach>
						</tr>
					</table>
				</c:when>
				<c:otherwise>
					<table class="table table-bordered">
						<c:forEach var="value" items="${question.optionList}" varStatus="valIdx">
							<tr>
								<td style="width: 50px; text-align: center;">${valIdx.count}</td>
								<td>${value.soContent}</td>
								<td style="width: 90px; text-align: right;">${value.cnt}</td>
							</tr>
						</c:forEach>
					</table>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</c:forEach>