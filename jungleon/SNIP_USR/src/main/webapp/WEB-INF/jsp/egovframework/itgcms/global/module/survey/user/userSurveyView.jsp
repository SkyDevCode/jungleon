<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld"%>
<script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
function fn_egov_prev() {
	location.href="?schM=list";
}
		function surveySubmit() {

			var survNum = "${survey.svIdx}";

			$("#surveyParam").empty();
			var isSubmit = false;
			$("#surveyParam").append("<input type='hidden' name='svIdx' value='"+survNum+"'/>");
			$(".questionOption").each(function(){
				var queNo = $(this).attr("no");
				var checkedOp = $("[name='option_"+queNo+"']").filter(":checked ");

				if (checkedOp.length == 0) {
					isSubmit = false;
					alert("답변을 선택하지 않은 문항이 존재합니다.");
					$(this).focus();
					return false;
				}else {
					$("#surveyParam").append("<input type='hidden' name='valParam' value='"+queNo+"/;/"+checkedOp.attr("no")+"/;/"+checkedOp.attr("value")+"'/>");
					isSubmit = true;
				}

			});

			if (isSubmit) {
				$(".descQuestion").each(function(){
					var desc = $(this)
					var queNo = desc.attr("no");
					var answer = desc.val();
					var checkdesc = $("[name='question_"+queNo+"']").val();
					if (checkdesc.trim() == "") {
						isSubmit = false;
						alert("서술형 답변을 입력하지 않은 문항이 존재합니다.");
						$(this).focus();
						return false;
					}else {
						$("#surveyParam").append("<input type='hidden' name='valParam' value='"+queNo+"/;/0/;/"+answer+"'/>");
						isSubmit = true;
					}

				});
			}

			if (isSubmit) {
				document.surveyParam.submit();
			}

		}
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

				}else if (queType=== "op_editable_radio") {

					$(".questionOption").each(function(){
						var checkedOp = $("[name='op_editable_radio_"+no+"']").filter(":checked "); 
						if (checkedOp.length == 0) {
						} else {
							chkboxValidate = true;
						}
					});
					

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
									<input type="hidden" name="memberId" value="${userId}"/>
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
															placeholder="최대 ${question.sqTextlimit eq '' ? '1000' : question.sqTextlimit}자까지 입력 가능합니다.">${question.value}</textarea>
													</c:when>
													<c:when test="${question.sqAnswertype eq 'op_editable_checkbox'}">
														<ul class="chk questionOption quCheckbox" sqChecklimit="${question.sqChecklimit}">
															<c:forEach var="option" items="${question.optionList}">
																	<li class="crb">
																		<input class="questionOptionList" type="checkbox" value="${option.soIdx}_${option.soContent}" <c:out value="${ufn:isContainValue(option.soIdx, question.valueArr) == true ? 'checked':''}"/>
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
																		<input class="questionOptionList" type="radio" value="${option.soIdx}_${option.soContent}" <c:out value="${option.soIdx eq question.value ? 'checked':''}"/>
																			name="${question.sqAnswertype}_${question.sqIdx}" id="opt_${option.soIdx}" >
																		<label for="opt_${option.soIdx}">${option.soContent}</label>
																		<c:if test="${option.soInputyn=='Y'}">
																		<c:if test="${index.last}">
																		<input type="text" class="descQuestion" name="soValue"
																	id="${question.sqAnswertype}_${question.sqIdx}" value="${question.value}">
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
									<%-- <c:if test="${act eq 'userForm'}"> --%>
										<a href="javascript:answerSurvey();" class="btn submit">제&nbsp;&nbsp;출</a>
									<%-- </c:if> --%>
									<a href="javascript:fn_egov_prev();" class="btn bg_gray">취소</a>
								</div>
							</div>
					</div>
				</div>
				<!-- //본문 -->
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