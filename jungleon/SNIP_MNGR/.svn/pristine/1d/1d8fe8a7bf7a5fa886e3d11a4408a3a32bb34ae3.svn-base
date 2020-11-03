<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%
/**
 * @파일명 : survey.jsp
 * @파일정보 : 교육만족도조사 목록
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
<script type="text/javascript" src="/cheditor/cheditor.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>
<!-- 본문 영역 -->
				<div class="sub_inner">
					<div class="fixwidth">

						<div class="survey_view">
							<div class="survey_tit">
								<ul>
									<li><span class="blind">설문제목</span><strong class="tit">${survey.svTitle }</strong></li>
									<li>설문기간 : <fmt:formatDate value="${survey.svStartdate}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${survey.svEnddate}" pattern="yyyy-MM-dd"/> <span class="end">${surveyInfo.useyn }</span></li>
									<li>설문내용 : ${survey.svExplain }</li>
								</ul>
							</div>

							<div class="app_table">
							<div class="survey_cont survey_end">
								<ul>
							<c:forEach var="question" items="${surveyInfo.questionList}" varStatus="status">
								<li style="list-style: none;">
									<c:choose>
										<c:when test="${ufn:startWith(question.sqAnswertype, 'op_descriptive')}">
											<div class="que"><strong>${status.count}. ${question.sqQuestion}</strong></div>
											<div class="ans textarea">
												<textarea class=" descQuestion"  no="${question.sqIdx}" name="question_${question.sqIdx}" id="question_${question.sqIdx}" readonly="readonly">서술형은 총 ${fn:length(question.valueArr) }명이 참여하였습니다.</textarea>
											</div>
										</c:when>

										<c:otherwise>
											<div class="que"><strong>${status.count}. ${question.sqQuestion}</strong></div>
											<div class="ans">
												<ul class="total_list" no="${question.sqIdx}">
													<c:forEach var="value" items="${question.optionList}" varStatus="status">
														<li>${status.count}. ${value.soContent}(<fmt:formatNumber type="percent" value="${(value.cnt) / (survey.saNum)}" />)</li>
													</c:forEach>
					    					</ul>
											</div>
										</c:otherwise>
									</c:choose>
								</li>
							</c:forEach>
							</ul>
							</div>
									</div>
									<div class="btnBox">
											<button type="button" id="btnReg" onclick="fn_egov_prev()" class="button button1">목록으로</button>
									</div>

							</div>
						</div>


					</div>
				</div>
				<!-- //본문 -->


<script type="text/javascript">

function fn_egov_prev() {
	location.href="?schM=list";
}

</script>

