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
 * @파일명 : surveyRegist.jsp
 * @파일정보 : 설문조사 작성
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
<!-- Content Wrapper. Contains page content -->

        <!-- Main content -->
        <section class="content">
          <div class="row">
            <div class="col-xs-12">
              <div class="box">
                <div class="box-body">
                <form name="surveyForm" method="post" action="/_mngr_/survey/surRegist_input_proc.do" onsubmit="registSurvey(); return false;">
                	<input type="hidden" name="svIdx" id="svIdx" value="${surveyInfo.svIdx}"/>
                	<input type="hidden" name="saNum" id="saNum" value="${surveyInfo.saNum}"/>
                	<input type="hidden" name="useyn" id="useyn" value="${surveyInfo.useyn}"/>
                	<input type="hidden" name="schSitecode" id="schSitecode" value="<c:out value="${mngrSessionVO.currSiteCode}"/>"/>
	                <div class="row"><!-- 기본입력 .row S -->
	                	<div class="col-sm-12">
	                		  <h6 class="page-header" style="font-size: 1.3em;">기본 정보 입력</h6>
			                  <table id="example1" class="table table-bordered">
			                  	<colgroup>
			                  		<col style="width:20%; min-width : 150px;" />
			                  		<col style="min-width : 150px;" />
			                  		<col style="width:15%; min-width : 150px;" />
			                  		<col style="min-width : 150px;" />
			                  		<col style="width:15%; min-width : 150px;" />
			                  		<col style="min-width : 150px;" />
			                  	</colgroup>
			                    <tbody>
			                    	<tr>
				                    	<th class="text-center t">설문 제목</th>
				                    	<td colspan="5"><input type="text" class="form-control required" id="svTitle" name="svTitle" value="${surveyInfo.svTitle}"/></td>
				                    </tr>
				                    <tr>
				                    	<th class="text-center t">설문 기간</th>
				                    	<td colspan="5" id="datepicker">
				                    		<span class="input-daterange input-group"><input type="text" class="form-control required" name="svStartdate" readOnly="readOnly" value='<fmt:formatDate value="${surveyInfo.svStartdate}" pattern="yyyy-MM-dd"/>' />
										    <span class="input-group-addon">~</span>
										    <input type="text" class="form-control required" name="svEnddate" readOnly="readOnly" value='<fmt:formatDate value="${surveyInfo.svEnddate}" pattern="yyyy-MM-dd"/>'/></span>
				                    	</td>
				                    </tr>
				                    <tr>
				                    	<th class="text-center t">설문 설명</th>
				                    	<td colspan="5">
				                    		<textarea class="form-control required" name="svExplain" id="svExplain" style="width:100%; height:100px; background-color:#fdfde4;">${surveyInfo.svExplain}</textarea>
				                    		<!-- 에디터셋팅부분
				                    		<script type="text/javascript">
			                                    var myeditor = new cheditor();              // 에디터 개체를 생성합니다.
			                                    myeditor.config.editorHeight = '100px';     // 에디터 세로폭입니다.
			                                    myeditor.config.editorWidth = '100%';        // 에디터 가로폭입니다.
			                                    myeditor.config.editorBgColor  = '#fdfde4'; 	// 에디터 기본배경색입니다.
			                                    myeditor.config.usePreview = false;     // 미리보기 삭제
			                                    myeditor.inputForm = 'svExplain';           // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
			                                    myeditor.run();                             // 에디터를 실행합니다.
		                                    </script>       -->
				                    	</td>
				                    </tr>
								</tbody>
							</table>
	                  		<div id="queListParameters"></div>
		                  </div> <!-- .col-sm-12 -->
	                  </div> <!--  . 기본입력 row -->
				</form>

                  <div class="row" id="suvQuestion"> <!-- style="display: none;" -->
                 	 <div class="col-sm-12">
                 	 	<table class="table table-bordered">
		             		<colgroup>
		                  		<col style="width : 150px;"/>
		                  		<col />
		                  		<col style="width : 100px;"/>
		                  	</colgroup>
		                  	<tbody id="questionList">
		                  		<c:if test="${surveyInfo ne null }">
		                  			<c:forEach var="que" items="${surveyInfo.questionList}" varStatus="i">
		                  				<tr class="questionTr" id="question_${i.count}" sqChecklimit="${que.sqChecklimit}" isRequired="Y" etcRequired="${que.optionList[fn:length(que.optionList)-1].soInputyn }">
		                  					<td class="queNum text-center">${i.count}</td>
		                  					<td>
		                  						<p>
		                  							<span class="queStr" style="font-weight: bold;">${que.sqQuestion}</span>
		                  							<c:if test="${que.sqAnswertype == 'op_editable_checkbox'}">
														<span style="margin-left:10px; font-size: 13.5px;"> (최대 ${que.sqChecklimit}개 선택 가능)</span>
                  									</c:if>
		                  						</p>

		                  						<p class="answerOp" option="${que.sqAnswertype}">
		                  							<c:choose>
		                  								<c:when test="${que.sqAnswertype == 'op_descriptive'}">
		                  									<textarea rows="2" class="form-control" style="resize : none;"
		                  										maxlength="${que.sqTextlimit eq '' ? '1000' : que.sqTextlimit}"
		                  										placeholder="최대 ${que.sqTextlimit eq '' ? '1000' : que.sqTextlimit}자까지 입력 가능합니다."></textarea>
		                  								</c:when>
		                  								<c:when test="${que.sqAnswertype == 'op_editable_radio'}">
															<c:forEach var="option" items="${que.optionList}" varStatus="oi">
																<span>
																	<input type="radio" name="freeObj_${i.count}" id="freeObj_${i.count}${oi.count}">&nbsp;&nbsp;
																	<label for="freeObj_${i.count}${oi.count}">${option.soContent}&nbsp;&nbsp;&nbsp;&nbsp;</label>
																</span>
															</c:forEach>
		                  								</c:when>
		                  								<c:when test="${que.sqAnswertype == 'op_editable_checkbox'}">
															<c:forEach var="option" items="${que.optionList}" varStatus="oi">
																<span>
																	<input type="checkbox" name="freeObj_${i.count}" id="freeObj_${i.count}${oi.count}">&nbsp;&nbsp;
																	<label for="freeObj_${i.count}${oi.count}">${option.soContent}&nbsp;&nbsp;&nbsp;&nbsp;</label>
																</span>
															</c:forEach>
		                  								</c:when>
		                  								<c:when test="${que.sqAnswertype == 'ob_sat'}">
															<c:forEach var="option" items="${que.optionList}" varStatus="oi">
																<span>
																	<input type="radio" name="freeObj_${i.count}" id="freeObj_${i.count}${oi.count}">&nbsp;&nbsp;
																	<label for="freeObj_${i.count}${oi.count}">${option.soContent}&nbsp;&nbsp;&nbsp;&nbsp;</label>
																</span>
															</c:forEach>
		                  								</c:when>
	                  									<c:when test="${que.sqAnswertype == 'ob_ass'}">
															<c:forEach var="option" items="${que.optionList}" varStatus="oi">
																<span>
																	<input type="radio" name="freeObj_${i.count}" id="freeObj_${i.count}${oi.count}">&nbsp;&nbsp;
																	<label for="freeObj_${i.count}${oi.count}">${option.soContent}&nbsp;&nbsp;&nbsp;&nbsp;</label>
																</span>
															</c:forEach>
		                  								</c:when>
		                  								<c:when test="${que.sqAnswertype == 'sc_num'}">
															<c:forEach var="option" items="${que.optionList}"  varStatus="oi">
																<span>
																	<input type="radio" name="freeObj_${i.count}" id="freeObj_${i.count}${oi.count}" value="${option.soValue}">&nbsp;&nbsp;
																	<label for="freeObj_${i.count}${oi.count}">${option.soContent}&nbsp;&nbsp;&nbsp;&nbsp;</label>
																</span>
															</c:forEach>
		                  								</c:when>
		                  							</c:choose>
		                  						</p>
		                  					</td>
											<td class="text-center">
												<button class="btn btn-danger btn-xs" onclick="delQuetionList('${i.count}')">삭제</button>
												<div class="btn-group-vertical" style="margin-left: 5px; width: 20px;">
													<button class="btn btn-primary btn-xs" onclick="listUpQustionList('${i.count}')">
														<span class="fa fa-sort-up"></span>
													</button>
													<button class="btn btn-primary btn-xs" onclick="listDownQustionList('${i.count}')">
														<span class="fa fa-sort-desc"></span>
													</button>
												</div>
											</td>
										</tr>
		                  			</c:forEach>
		                  		</c:if>
		                  	</tbody>
	                  	</table>
               		  <h6 class="page-header" style="font-size: 1.3em;">설문문항입력</h6>
	                  <table id="questionInputForm" class="table table-bordered">
	                  	<colgroup>
	                  		<col style="width : 20%; min-width : 150px;"/>
	                  		<col />
	                  	</colgroup>
	                  	<tr>
	                  		<th class="text-center t">문항 유형</th>
      						    <td>
      						    	<c:forEach var="code" items="${surveyCode.childCodeList}">
      						    		<span class="icheck">
      						    		<label>
      						    			<input type="radio" class="validate-one-required" name="answerType" id="${code.ccode}Type" value="${code.ccode}" onchange="answerTypeSelet(this.value)" />&nbsp;&nbsp;${code.cname}
      						    		</label>&nbsp;&nbsp;&nbsp;&nbsp;
										</span>
      						    	</c:forEach>
      						    </td>
	                  	</tr>
	                  	<tr>
	                  		<th class="text-center t">설문 문항</th>
   						    <td>
   						    	<input type="text" class="form-control" name="question" id="question" placeholder="질문을 입력하세요" style="display: inline-block; width: 80%;"/>
   						    	 &nbsp;&nbsp; &nbsp;&nbsp;
   						    </td>
	                  	</tr>
	                  	<tr>
	                  		<th class="text-center t">문항 답안</th>
   						    <td id="optionSelect"></td>
	                  	</tr>
	                  	<tr>
	                  		<th colspan="2" style="text-align: center;"><button type="button" onclick="addQuestionList();" class="btn btn-default">문항 추가</button></th>
	                  	</tr>
	                  </table>
		             </div>

			          <div class="col-sm-12" style="text-align: center;">
		          		<button onclick="registSurvey();" class="btn btn-primary">
		          			<c:choose>
		          				<c:when test="${surveyInfo eq null }">설 문 생 성</c:when>
		          				<c:otherwise>저장</c:otherwise>
		          			</c:choose>
		          		</button>
		          		<c:if test="${not empty surveyInfo}">
			          		<button onclick="openPreview();" class="btn btn-info">
			          			미 리 보 기
			          		</button>
		          		</c:if>
			          </div>
                  </div>
                </div><!-- /.box-body -->
              </div><!-- /.box -->
            </div><!-- /.col -->
          </div><!-- /.row -->
        </section><!-- /.content -->


<script type="text/javascript">
$(document).ready(function(){


	$('input').iCheck({
	  checkboxClass: 'icheckbox_square-red',
	  radioClass: 'iradio_square-red',
	  increaseArea: '20%' // optional
	});
});



<c:if test="${not empty surveyInfo}">
	function openPreview(){
		var popOption = "width=800, scrollbars=1, resizable=no, status=no;";
		var ow = window.open("/_mngr_/survey/${surveyInfo.svIdx}/survey_vieww_pre.do", popOption);

		if (!ow) {
			alert("팝업을 해제한 후 다시 시도해주세요.");
		}
	}
</c:if>
 	 var surveyCode ={};
 	<c:forEach var="code" items="${surveyCode.childCodeList}">
 	surveyCode["${code.ccode}"] =
 		{
	  		code : "${code.ccode}",
	  		name : "${code.cname}",
	  		name : "${code.etc1}",
	  		childCode : [
	  			<c:forEach var="child" items="${code.childCodeList}">
	  				{
	  				code : "${child.ccode}",
	          		name : "${child.cname}",
	          		value : "${child.etc1}",
	          		childCode : [
						<c:forEach var="child2" items="${child.childCodeList}">
						{
			  				code : "${child2.ccode}",
			          		name : "${child2.cname}",
			          		value : "${child2.etc1}"
						},
						</c:forEach>
	          		]},
	  			</c:forEach>
	  		]
	  	};
 	</c:forEach>


	$.fn.datepicker.dates['kr'] = {
		days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
		daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
		daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
		months: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
		monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	};
	$('.input-daterange').datepicker({
    	format: "yyyy-MM-dd",
    	language: "kr",
    	autoclose: true,
    	todayHighlight: true
	});



	function registSurvey() {
		var svForm = document.surveyForm;
		var _$Form = $("#queListParameters").empty();
		/* 에디터설정부분
		svForm.svExplain.value = myeditor.getContents(); */

		var questionList =  $("#questionList").children();
		var yn='y';
		if(svForm.saNum.value && svForm.saNum.value > 0) {
			alert("이미 답변이 생성된 설문은 수정하실 수 없습니다.");
			location.reload(true);
			return false;
		}

		if(svForm.useyn.value && svForm.useyn.value === 'Y') {
			alert("진행 중인 설문은 수정하실수 없습니다.");
			location.reload(true);
			return false;
		}

		if (Validator.validate(svForm)){
			if (questionList.length > 0) {

				if(($("input[name='answerType']:checked").length > 0 || $("#question").val())
						&& !confirm("작성 중인 설문문항이 존재합니다. \n작성하던 문항을 제외하고 설문을 생성하시겠습니까?")) {
					return false;
				} else {

					var countRequired = 0;

					questionList.each(function(idx, ele){
						var _$ele = $(ele);
						var eleID = _$ele.attr("id");
						eleID = eleID.substring(eleID.lastIndexOf("_")+1);
						var queStr = _$ele.find(".queStr").html();
						var opList = _$ele.find(".answerOp");
						var opCode = opList.attr("option");
						var sqChecklimit = _$ele.attr("sqChecklimit");
						var etcRequired = _$ele.attr("etcRequired");
						var chkedtmp=_$ele.find("input[type='checkbox']").filter(':checked').length;
						var chkid=$(this).attr('id');


						if (chkedtmp>sqChecklimit) {
							alert("최대 선택 가능한 개수는"+sqChecklimit+"개 입니다.");
							yn='n';
							return false;
						}
						var html = "<input type='hidden' name='paramSubfix' value='"+eleID+"'/>"+
						           		"<input type='hidden' name='que_"+eleID+"' value='"+queStr+"'/>"+
										"<input type='hidden' name='anType_"+eleID+"' value='"+opCode+"' />"+
										"<input type='hidden' name='isRequired_"+eleID+"' value='Y' />"

						if (opCode == "op_descriptive") {
							html += "<input type='hidden' name='maxLength_"+eleID+"' value='"+_$ele.find("textarea").attr("maxlength")+"' />";

						} else if(opCode == "op_editable_radio") {
							opList = opList.children();

							opList.each(function(idx2, ele2) {


								var _$ele2 = $(ele2);

								// html+= "<input type='text' name='opOrder_"+eleID+"' value='"+(idx2+1)+"'/>";
								html+= "<input type='hidden' name='opTitle_"+eleID+"' value='"+_$ele2.find('label').html().replace(/&nbsp;/gi, '')+"'/>";
								var numValue = _$ele2.find(".valueTmp").val();
								if (numValue) {
									html+= "<input type='hidden' name='opTitle_"+eleID+"_"+idx2+"' value='"+numValue+"'/>";
								}
								html+="<input type='hidden' name='etcRequired_"+eleID+"' value='"+etcRequired+"' />";
							});
						}else if(opCode == "op_editable_checkbox") {
							opList = opList.children();

							opList.each(function(idx2, ele2) {


								var _$ele2 = $(ele2);

								// html+= "<input type='text' name='opOrder_"+eleID+"' value='"+(idx2+1)+"'/>";
								html+= "<input type='hidden' name='opTitle_"+eleID+"' value='"+_$ele2.find('label').html().replace(/&nbsp;/gi, '')+"'/>";
								var numValue = _$ele2.find(".valueTmp").val();
								if (numValue) {
									html+= "<input type='hidden' name='opTitle_"+eleID+"_"+idx2+"' value='"+numValue+"'/>";
								}
								html+="<input type='hidden' name='sqChecklimit_"+eleID+"' value='"+Number(sqChecklimit)+"' />";
							});
						}else{
							opList = opList.children();

							opList.each(function(idx2, ele2) {


								var _$ele2 = $(ele2);

								// html+= "<input type='text' name='opOrder_"+eleID+"' value='"+(idx2+1)+"'/>";
								html+= "<input type='hidden' name='opTitle_"+eleID+"' value='"+_$ele2.find('label').html().replace(/&nbsp;/gi, '')+"'/>";
								var numValue = _$ele2.find(".valueTmp").val();
								if (numValue) {
									html+= "<input type='hidden' name='opTitle_"+eleID+"_"+idx2+"' value='"+numValue+"'/>";
								}
							});
						}

						_$Form.append(html);
					});
					if(yn=== 'n') return false;

					svForm.submit();
				}

			} else {
				alert("문항을 하나 이상 입력해야 저장 가능합니다.");
				return false;
			}
		}

	}





	var editableOptionClass = "editableOption";
	var editableOptionHTML = "<span class='"+editableOptionClass+"'>"+
								"<input type='text' class='opchk form-control' style='display:inline-block;width:80%;'/>"+
								"&nbsp;&nbsp;<button class='btn btn-default' type='button' onclick='addFreeOption(this)'>추가</button>"+
								"<button class='btn btn-danger' type='button' onclick='delFreeOption(this)' style='margin-left: 5px;'>삭제</button>"+
							  "</span>";
  var editableOptionHTML1 = "<span class='"+editableOptionClass+"'>"+
								"<input type='text' class='opchk form-control' style='display:inline-block;width:80%;'/>"+
								"&nbsp;&nbsp;<button class='btn btn-default' type='button' onclick='addFreeOption1(this)'>추가</button>"+
								"<button class='btn btn-danger' type='button' onclick='delFreeOption(this)' style='margin-left: 5px;'>삭제</button>"+
							  "</span>";


	function addFreeOption(target) { // 객관식 문항 선택시 문항 답안 추가
		if ($("#optionSelect").find("span").length < 5) {
			var span = $(target).parent();
			span.after(editableOptionHTML);
		} else {
			alert("답안은 5개 이상 입력할 수 없습니다.");
			return false;
		}

	}
	function addFreeOption1(target) { // 객관식 문항 선택시 문항 답안 추가
		if ($("#optionSelect").find("span").length < 6) {
			var span = $(target).parent();
			span.after(editableOptionHTML1);
		} else {
			alert("답안은 5개 이상 입력할 수 없습니다.");
			return false;
		}

	}
	function delFreeOption(target) { // 객관식 문항 선택시 문항 답안 삭제
		var options = $("#optionSelect").children();
		if (options.length > 1) {
			$(target).parent().remove();
		} else {
			alert("문항 답안은 반드시 하나 이상 입력해야 합니다.");
		}
	}

	var inputStr = "<input type='text' class='form-control'/>";
	var questionListIdPrefix = "question_";

	function addQuestionList() { // 문항 작성 완료 후 목록에 추가 하는 메소드
		if ($(".queNum").length+1>50) {
			alert("설문문항은 최대 50개만 만들수 있습니다");
			return;
		}
		if (Number($("#descript").val())<=0) {
			alert("0은 최대글자수로 들어갈 수 없는 수 입니다.");
			return;
		}

		// questionInputForm
		var quInputForm = $("#questionInputForm");
		var questionList =  $("#questionList");
		var quLen = questionList.find(".questionTr").length;
		var options = $("#optionSelect");

		var isRequired = 'Y';
		var answerTypeInput = quInputForm.find("input[name='answerType']:checked");
		var answerType = quInputForm.find("input[name='answerType']:checked").val();
		var questionInput = quInputForm.find("input[name='question']");
		var questionStr = questionInput.val();
		var answerTypeDetail = $("input[name='answerTypeDetail']:checked").length > 0 ? $("input[name='answerTypeDetail']:checked").val() : answerType;
		var nocheck = $("input[name='answerTypeDetail']:checked").length > 0 ? $("input[name='answerTypeDetail']:checked").val() : "";
		var sqTextlimit = $("#descript").val();
		var sqChecklimit = $("#checkboxCnt").val();
		var randomId = getRandomId(questionListIdPrefix);
		var etcRequired = quInputForm.find("input[name='etcRequired']:checked").length > 0 ? 'Y' : 'N';

		var quTrHTML = "<tr class='questionTr' id='"+questionListIdPrefix+randomId+"' isRequired='"+isRequired+"'><td class='queNum text-center'>"+(quLen+1)+"</td><td>"+
			"<p><span class='queStr' style='font-weight: bold; font-size : 1.2em;'>"+
				questionStr+
			"</span></p><p class='answerOp' option='"+answerTypeDetail+"'>";

		if (!questionStr) {
			alert("설문 문항을 입력해주세요.");
			questionInput.focus();
			return;
		}

		var optionsHTML = "";

		if (answerType === "") {
			alert("문항 유형을 선택해주세요.");
			return;
		} else if (answerType === "op_editable_radio") {

			var shType = answerType.split("_")[2];

			var optionList = options.children();
			var validate = true;
			optionList.each(function(idx, ele){

				var _$ele = $(ele);
				var opVal = _$ele.find("input").val();
				if (!opVal) {
					validate = false;
					alert("문항 답안에 빈칸을 입력할 수 없습니다.");
					_$ele.focus();
					return;
				}else {
					if (idx===optionList.length-1) {
					}else{
						optionsHTML += "<span><input type='"+shType+"' class='opgubun validate-one-required' name='freeObj_"+randomId+"'/>&nbsp;&nbsp;<label for='freeObj_"+randomId+"'>"+opVal+"</lable>&nbsp;&nbsp;&nbsp;&nbsp;</span>"
					}
				}

			});
			if (!validate) {
				return;
			}
			if (etcRequired=='Y') {
				optionsHTML += "<span><input type='"+shType+"' class='opgubun validate-one-required' name='freeObj_"+randomId+"'/>&nbsp;&nbsp;<label for='freeObj_"+randomId+"'>기타</lable></span>"
			}
			quTrHTML = "<tr class='questionTr' id='"+questionListIdPrefix+randomId+"' etcRequired='"+etcRequired+"' isRequired='"+isRequired+"'><td class='queNum text-center'>"+(quLen+1)+"</td><td>"+
			"<p><span class='queStr' style='font-weight: bold; font-size : 1.2em;'>"+
				questionStr+
			"</span></p><p class='answerOp' option='"+answerTypeDetail+"'>";
		}else if (answerType === "op_editable_checkbox") {
			if (Number(sqChecklimit) === "") {
				alert("최대선택 가능 개수를 입력해주세요.");
				return;
			}
			if (Number(sqChecklimit)<=0) {
				alert("0은 입력할 수 없습니다.");
				return;
			}
			if (Number(sqChecklimit)>0&&Number(sqChecklimit)<=5) {
		    }else{
		    	alert("5개 이상 입력할 수 없습니다.");
		        return false;
		    }

			var shType = answerType.split("_")[2];

			var optionList = options.children();
			if (Number(sqChecklimit) >optionList.length-1) {
				alert("최대선택 가능 개수가 문항답안보다 많을 수 없습니다.");
				return;
			}
			var validate = true;
			optionList.each(function(idx, ele){
				var _$ele = $(ele);
				var opVal = _$ele.find("input").val();
				if (!opVal) {
					validate = false;
					alert("문항 답안에 빈칸을 입력할 수 없습니다.");
					_$ele.focus();
					return;
				}
				else {
					if (idx===optionList.length-1) {
					}else{
						optionsHTML += "<span><input type='"+shType+"' class='opgubun validate-one-required' name='freeObj_"+randomId+"' id='freeObj_"+randomId+"'/>&nbsp;&nbsp;<label>"+opVal+"</lable>&nbsp;&nbsp;&nbsp;&nbsp;</span>"
					}
				}
			});
			if (!validate) {
				return;
			}
			quTrHTML = "<tr class='questionTr' id='"+questionListIdPrefix+randomId+"' sqChecklimit='"+Number(sqChecklimit)+"' isRequired='"+isRequired+"'><td class='queNum text-center'>"+(quLen+1)+"</td><td>"+
			"<p><span class='queStr' style='font-weight: bold; font-size : 1.2em;'>"+
				questionStr+
			"</span><span style='margin-left:10px; font-size: 13.5px;'> (최대 "+Number(sqChecklimit)+"개 선택 가능)</span></p>"+
			"<p class='answerOp' option='"+answerTypeDetail+"'>";
		} else if (answerType === "op_descriptive") {
			var maxInput = quInputForm.find("#descript").val();
			/* if (maxInput > 1000 ) {
				alert("최대 ${maxLength}자 까지 입력 가능합니다.");
				return;
			}  */
			if (sqTextlimit === "") {
				alert("최대 글자수를 입력해주세요.");
				return;
			}
			optionsHTML += "<textarea rows='2' id='sqTextlimit' class='form-control' style='resize : none;' maxlength='"+Number(maxInput)+"' placeholder='최대 "+Number(maxInput)+"자까지 입력 가능합니다.'></textarea>";

		} else {
			if (answerTypeDetail === "" || nocheck === "") {
				alert("문항 답안을 선택해주세요.");
				return;
			} else {
				var answerTypeChild = surveyCode[answerType].childCode;
				var answerList = null;

				for (var i = 0; i < answerTypeChild.length; i++) {
					if(answerTypeChild[i].code === answerTypeDetail) {
						answerList = answerTypeChild[i].childCode;
						break;
					}
				}
				if (answerList) {
					var length = answerList.length;

					for (var i = 0; i < length; i++) {
						optionsHTML += "<span><input class='valueTmp validate-one-required' type='radio' name='freeObj_"+randomId+"' value='"+(answerList[i].value ? answerList[i].value : "")+"'/>&nbsp;&nbsp;<label>"+answerList[i].name+"</label>&nbsp;&nbsp;&nbsp;&nbsp;</span>"
					}

				} else {
					alert("선택하신 문항 유형에 해당하는 답변 유형이 존재하지 않습니다. \n창을 새로고침한 후 다시 작성해주세요.");
					return;
				}
			}

		}

		quTrHTML += optionsHTML;
		quTrHTML += "</p></td>"+
							"<td class='text-center'>"+
								"<button class='btn btn-danger btn-xs' onclick='delQuetionList(\""+randomId+"\")'>삭제</button>"+
								"<div class='btn-group-vertical' style='margin-left: 5px;width: 20px;'>"+
									"<button class='btn btn-primary btn-xs' onclick='listUpQustionList(\""+randomId+"\")'><span class='fa fa-sort-up'></span></button>"+
									"<button class='btn btn-primary btn-xs' onclick='listDownQustionList(\""+randomId+"\")'><span class='fa fa-sort-desc'></span></button>"+
								"</div>"+
							"</td>"+
						"</tr>";

		questionList.append(quTrHTML);

		$('.opgubun').iCheck({
			  checkboxClass: 'icheckbox_square-red',
			  radioClass: 'iradio_square-red',
			  increaseArea: '20%' // optional
			});
		$('.valueTmp').iCheck({
			  checkboxClass: 'icheckbox_square-red',
			  radioClass: 'iradio_square-red',
			  increaseArea: '20%' // optional
			});
		var nonchk1 = $('input[name="answerType"]');
		nonchk1.iCheck('uncheck');
		answerTypeInput.removeAttr("checked");
		options.empty();
		questionInput.val("");
	}

	function delQuetionList(id) {
		var delRow = $("#"+questionListIdPrefix+id);
		if (delRow.length > 0) {
			delRow.remove();
			renumberingQueList();
		} else {
			alert("error");
		}
	}

	function listUpQustionList(id) {
		var curRow = $("#"+questionListIdPrefix+id);
		var prevObj = $("#"+questionListIdPrefix+id).prev();
		var textareaContent=$("#questionList").find("textarea").val();

		var selectValMap = new Map();
		$(curRow.find("input").each(function(idx) {
			var tagSelectId = $(this).attr("id");
			selectValMap.put($(this).attr("id"),$(this).val());
		}));

		var chkPrevTMap = new Map();
		$(prevObj.find("input").each(function(idx) {
			var chkId = $(this).attr("id");
			chkPrevTMap.put($(this).attr("id"),$(this).val());
		}));

		if(prevObj.length == 1 && curRow.length == 1) {
			prevObj.before(curRow);

			for(var i=0; i<selectValMap.size();i++){
				$("#"+selectValMap.keys()[i]).val(selectValMap.values()[i]);
			}

			renumberingQueList();

			for(var i=0; i<chkPrevTMap.size();i++){
				var chkSplitArr = chkPrevTMap.keys()[i].split("_");
				var chkKey = chkSplitArr[0]+"_"+(Number(chkSplitArr[1])+1);
				$("#"+chkKey).val(chkPrevTMap.values()[i]);
				$("#"+chkKey).prop("checked", true);
			}
		}
		/*
		if (prevObj.length == 1 && curRow.length == 1) {
			prevObj.before(curRow[0].outerHTML);
			 if(textareaContent!=null||textareaContent!=""){
				prevObj.prev().find("textarea").val(textareaContent);
			}
			curRow.remove();
			renumberingQueList();
		}  */else {
			console.log("error id is Not Single Object");
		}
	}

	function listDownQustionList(id) {
		var curRow = $("#"+questionListIdPrefix+id);
		var nextT = $("#"+questionListIdPrefix+id).next();
		var selectValMap = new Map();
		$(curRow.find("select").each(function(idx) {
			var tagSelectId = $(this).attr("id");
			selectValMap.put($(this).attr("id"),$(this).val());
		}));

		var chkClickTMap = new Map();
		$(curRow.find("input[type=radio]:checked").each(function(idx) {
			var chkId = $(this).attr("id");
			chkClickTMap.put($(this).attr("id"),$(this).val());
		}));

		if (nextT.length == 1 && curRow.length == 1) {
			nextT.after(curRow);

			for(var i=0; i<selectValMap.size();i++){
				$("#"+selectValMap.keys()[i]).val(selectValMap.values()[i]);
			}

			renumberingQueList();

			for(var i=0; i<chkClickTMap.size();i++){
				var chkSplitArr = chkClickTMap.keys()[i].split("_");
				var chkKey = chkSplitArr[0]+"_"+(Number(chkSplitArr[1])+1);
				$("#"+chkKey).val(chkClickTMap.values()[i]);
				$("#"+chkKey).prop("checked", true);
			}
		}
		/* var textareaContent=$("#questionList").find("textarea").val();
		if (nextObj.length == 1 && curRow.length == 1) {
			nextObj.after(curRow[0].outerHTML);
			 if(textareaContent!=null||textareaContent!=""){
				nextObj.next().find("textarea").val(textareaContent);
			}
			curRow.remove();
			renumberingQueList();
		} */ else {
			console.log("error id is Not Single Object");
		}
	}

	function renumberingQueList() {
		var queList = $("#questionList").children();

		if (queList.length > 0) {
			// queNum
			queList.each(function(idx, ele){
				var _$ele = $(ele);
				_$ele.find(".queNum").html(idx+1);
			});
		}
	}

	function getRandomId(prefix){  // 객관식 문항 선택시 문항 답안 추가
		if (!prefix) prefix = "";
		var len = 10;
		var id = ItgJs.getRandomStr(len);
		var domObj = $("#"+prefix+id);

		while(domObj.length != 0) {
			id = ItgJs.getRandomStr(len);
			domObj = $("#"+prefix+id);
		}

		return id;
	}

	$("input[name='answerType']").on('ifChecked ifUnchecked', function(event){
			var answerTypeInfo =  surveyCode[$(this).val()];
			var optionSelect = $("#optionSelect").empty();
			var insertHTML = "";
			$("#question").val("");

			if ($(this).val() === "op_editable_radio") {
				insertHTML = editableOptionHTML1+"<span class='editableOption'><br><br>기타 문항 사용여부 <input type='checkbox' name='etcRequired' id='etcRequired'/></span>";
			}else if ($(this).val() === "op_editable_checkbox") {
				insertHTML = editableOptionHTML1+"<span class='editableOption'><br><br>최대 선택 가능 개수 : <input type='text' id='checkboxCnt' class='form-control required validate-digits' maxlength='2' style='display:inline-bolck; width : 150px; text-align:right;' onkeydown='return ItgJs.fn_numberOnly(event);'/></span>";
			}else if ($(this).val() === "op_descriptive") {
				insertHTML = "최대 : <input type='text' id='descript' title='최대글자수' max='${maxLength}' class='form-control required validate-digits' style='display:inline-bolck; width : 150px; text-align:right;' onkeydown='return ItgJs.fn_numberOnly(event);'/> 자";
			} else {
				if(answerTypeInfo.childCode.length > 0) {
					var childCodeList = answerTypeInfo.childCode;
					for (var i = 0; i < childCodeList.length ; i++) {
						var childObj = childCodeList[i];
						insertHTML += "<span><label><input type='radio' class='validate-one-required' name='answerTypeDetail' value='"+childObj.code+"'/>&nbsp;&nbsp;"+childObj.name+"<label>&nbsp;&nbsp;&nbsp;&nbsp;</span>";
					}
				}
			}
			optionSelect.html(insertHTML);
			$('#optionSelect').find("input[name='answerTypeDetail']").iCheck({
				  checkboxClass: 'icheckbox_square-red',
				  radioClass: 'iradio_square-red',
				  increaseArea: '20%' // optional
				});
			$('#optionSelect').find("input[name='etcRequired']").iCheck({
				  checkboxClass: 'icheckbox_square-red',
				  radioClass: 'iradio_square-red',
				  increaseArea: '20%' // optional
				});
	});
/*
	$("input[type='checkbox']").on('ifChecked ifUnchecked', function(event){
		var tabletmp=$(this).parent().parent().parent().parent().parent();
		var chktot=tabletmp.attr("sqChecklimit");
		var chkedtmp=tabletmp.find("input[type='checkbox']").filter(':checked').length;
		var chkid=$(this).attr('id');
		if (chkedtmp>chktot) {
			alert(chktot+"개만 선택 가능합니다.");
			 $(this).removeAttr('checked').iCheck('update');
			return false;
		}
		}); */
</script>