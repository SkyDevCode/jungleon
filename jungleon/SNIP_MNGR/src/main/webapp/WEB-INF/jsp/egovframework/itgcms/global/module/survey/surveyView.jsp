<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
 * @파일명 : surveyView.jsp
 * @파일정보 : 설문 뷰
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

<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<link rel="shortcut icon" type="image/x-icon" href="${systemconfigVO.faviUrl}" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="format-detection" content="telephone=no" />
<script src="/resource/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<link href="/resource/templete_common/css/base.css"  rel="stylesheet" type="text/css" />
<link href="/resource/templete_common/css/subcommon.css"  rel="stylesheet" type="text/css" />
<link href="/resource/templete_common/css/sub.css"  rel="stylesheet" type="text/css" />

<!--[if lte IE 9]><script src="../../js/html5shiv.js"></script><![endif]-->

	<title>
		${pageTitle}
	</title>

	<%-- <c:if test="${act eq 'userForm'}"> --%>
		<script>

			function answerSurvey() {

				$(".formtxt").removeClass("active");

				var reqVal = [];
				var frm = document.surveyForm;
				var yn='y';
				$(".formchoice").each(function(idx, ele){

					var _$ele = $(ele);
					var queType = _$ele.attr("type");
					var no = _$ele.attr("no");
					var inputEle = frm[queType+"_"+no];

					var chkedtmp=_$ele.find("input[type='checkbox']").filter(':checked').length;
					var sqChecklimit=_$ele.find("ul").attr('sqChecklimit');
					if (chkedtmp>sqChecklimit) {
						alert("최대 선택 가능한 개수는"+sqChecklimit+"개 입니다.");
						yn='n';
						return false;
					}
					if (queType=== "op_editable_checkbox") {

						var chkboxValidate = false;
						for (var i=0; i < inputEle.length;i++) {
							if (inputEle[i].checked) {
								chkboxValidate = true;
								break;
							}
						}

						if (!chkboxValidate) reqVal.push(_$ele);

					} else {

						if (inputEle.value === "") {
							reqVal.push(_$ele);
						}

					}

				});


				if(yn==='n') return false;
				if (reqVal.length > 0) {
					alert("문항을 선택안하셨습니다. 표시된 문항을 다시 확인해주세요.");
					$.each(reqVal, function(idx, ele){
						$(ele).find(".formtxt").addClass("active");
					});
				}else {
					// frm.method ="POST";
					frm.action ="/module/userAnswerSurveyProc.do";
					frm.submit();
				}

			}
		</script>
	<%-- </c:if> --%>
</head>
<body>

	<div class="sub_inner">
		<div class="fixwidth">
			<div class="survey_view">
						<div class="survey_tit">
							<ul>
								<li><span class="blind">설문제목</span><strong class="tit">${survey.svTitle}</strong></li>
								<li>
									설문기간 :
									<fmt:formatDate value="${survey.svStartdate}" pattern="yyyy-MM-dd"/>&nbsp;-&nbsp;
									<fmt:formatDate value="${survey.svEnddate}" pattern="yyyy-MM-dd"/>
									<span class="ing">
										${survey.useyn}
									</span>
								</li>
								<li>설문내용 : ${survey.svExplain }</li>
							</ul>
						</div>
						<div class="formcontent">
							<form name="surveyForm" method="post">
								<input type="hidden" name="svIdx" value="${survey.svIdx}"/>
								<c:forEach var="question" items="${survey.questionList}" varStatus="status">
									<div class="formchoice" isRequired="Y" type="${question.sqAnswertype}" no="${question.sqIdx}">
										<div class="formtxt">
											<p class="tit">
												<strong>${status.count}.&nbsp;&nbsp;${question.sqQuestion}</strong>
												<c:if test="${question.sqAnswertype == 'op_editable_checkbox'}">
													<span style="margin-left:10px; font-size: 13.5px;"> (최대 ${question.sqChecklimit}개 선택 가능)</span>
               									</c:if>
											</p>
											<c:choose>
												<c:when test="${question.sqAnswertype eq 'op_descriptive'}">
													<textarea class="descQuestion" name="${question.sqAnswertype}_${question.sqIdx}"
														id="${question.sqAnswertype}_${question.sqIdx}"
														maxlength="${question.sqTextlimit eq '' ? '1000' : question.sqTextlimit}"
														placeholder="최대 ${question.sqTextlimit eq '' ? '1000' : question.sqTextlimit}자까지 입력 가능합니다.">${question.valueArr[0]}</textarea>
												</c:when>
												<c:when test="${question.sqAnswertype eq 'op_editable_checkbox'}">
													<ul class="chk questionOption quCheckbox" sqChecklimit="${question.sqChecklimit}">
														<c:forEach var="option" items="${question.optionList}">
							    							<li class="crb">
							    								<input class="questionOptionList" type="checkbox" value="${option.soIdx}"
							    								<c:out value="${ufn:isContainValue(option.soIdx, question.valueArr)}"/>
							    									name="${question.sqAnswertype}_${question.sqIdx}" id="opt_${option.soIdx}" >
							    								<label for="opt_${option.soIdx}">${option.soContent}</label>
							    							</li>
							    						</c:forEach>
													</ul>
												</c:when>
												<c:when test="${question.sqAnswertype eq 'op_editable_radio'}">
													<ul class="chk questionOption quRadio">
														<c:forEach var="option" items="${question.optionList}" varStatus="index">
							    							<li class="crb">
							    								<c:choose>
							    									<c:when test="${selectEtc eq 'selectEtc'}">
								    									<input class="questionOptionList" type="radio" value="${option.soIdx}_${option.soContent}" name="${question.sqAnswertype}_${question.sqIdx}" id="opt_${option.soIdx}" checked>
							    									</c:when>
							    									<c:otherwise>
								    									<input class="questionOptionList" type="radio" value="${option.soIdx}_${option.soContent}" <c:out value="${option.soIdx eq question.value ? 'checked':''}"/>
								    									name="${question.sqAnswertype}_${question.sqIdx}" id="opt_${option.soIdx}" >
							    									</c:otherwise>
							    								</c:choose>
							    								<label for="opt_${option.soIdx}">${option.soContent}</label>
							    								<c:if test="${option.soInputyn=='Y'}">
							    								<c:if test="${index.last}">
							    								<input type="text" class="descQuestion" name="soValue"
																id="${question.sqAnswertype}_${question.sqIdx}" value="${question.valueArr[0]}">
																</c:if></c:if>

							    							</li>
							    						</c:forEach>
													</ul>
												</c:when>
												<c:otherwise>
													<ul class="chk questionOption quRadio">
														<c:forEach var="option" items="${question.optionList}">
							    							<li class="crb">
							    								<input class="questionOptionList" type="radio" value="${option.soIdx}_${option.soContent}" <c:out value="${option.soIdx eq question.value ? 'checked':''}"/>
							    									name="${question.sqAnswertype}_${question.sqIdx}" id="opt_${option.soIdx}" >
							    								<label for="opt_${option.soIdx}">${option.soContent}</label>
							    							</li>
							    						</c:forEach>
													</ul>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</c:forEach>
							</form>
							<div class="btn_wrap center">
									<a href="javascript:window.close();" class="btn submit">창닫기</a>
							</div>

				</div>
			</div>

		</div>
	</div>
<c:if test="${act eq 'answer'}">
	<script>
		$("input").attr("disabled", "disabled");
		$("textarea").attr("disabled", "disabled");
	</script>
</c:if>
<script type="text/javascript">
$("input[type='checkbox']").change(function(){
    if($("input[type='checkbox']").is(":checked")){
    	var tabletmp=$(this).parent().parent();
		var chktot=tabletmp.attr("sqChecklimit");
		var chkedtmp=tabletmp.find("input[type='checkbox']:checked").length;
		if (chkedtmp>chktot) {
			alert(chktot+"개만 선택 가능합니다.");
			$(this).prop('checked', false);
		}
    }else{
    }
});
</script>
</body>
</html>
