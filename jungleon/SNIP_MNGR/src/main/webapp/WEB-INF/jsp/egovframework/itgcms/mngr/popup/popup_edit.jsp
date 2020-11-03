<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
 * @파일명 : mngrPopupRegist.jsp
 * @파일정보 : 팝업관리 등록
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
<link rel="stylesheet" type="text/css" href="/resource/common/jquery_plugin/validation/validator.css" />
<script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
		        	<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;" enctype="multipart/form-data">
					<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
					<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
					<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
					<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
					<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
					<input type="hidden" name="id" value="<c:out value="${searchVO.id}" />" />
					<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
					<input type="hidden" name="schActive" value="<c:out value="${searchVO.schActive}" />" />
					<input type="hidden" name="schPopupType" value="<c:out value="${searchVO.schPopupType}" />" />
					<input type="hidden" name="act" value="<c:out value="${searchVO.act}" />" />


						<div class="row">
								<div class="col-xs-12 table-responsive">
									<table class="table table-bordered tp2">
										<colgroup>
											<col style="width:15%"/>
											<col style="width:85%"/>
										</colgroup>
										<tbody>
											<tr>
												<th class="t"><label for="popupTitle">제목</label></th>
												<td><input type="text" name="popupTitle" id="popupTitle" maxlength="50" value="<c:out value="${result.popupTitle}"/>" class="form-control input-sm f-wd-600 required" title="제목" /></td>
											</tr>
									<c:choose>
										<c:when test="${mngrSessionVO.licenseType == 'M' and mngrSessionVO.currSiteCode eq 'SYSTEM'}">
											<tr>
												<th class="t"><label for="siteCode">표출사이트</label></th>
												<td><div style="display: -webkit-box;display: -ms-flexbox;display: flex;">
													<!-- <span class="col-sm-2 icheck"><input type="checkbox" name="chkAll" id="chkAll" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'siteCode');" /><label>전체</label></span> -->
													<span class="col-sm-2 icheck" ><input type="checkbox" name="chkAll" id="chkAll" title="전체선택/해제"/><label>전체</label></span>
													<c:forEach var="site" items="${siteList }">
							                            <span class="col-sm-2 icheck"><input type="checkbox" name="siteCode" value="${site.siteCode }" <c:if test="${ufn:strInArrChk(result.siteCodes, site.siteCode)}">checked</c:if> onclick="ItgJs.fn_check($(this).attr('name'), $('#chkAll').attr('id'));"><label>${site.siteName}</label></span>
													</c:forEach>
													</div>
													<span class="help-block">※ 선택을 하지 않을경우 표출이 되지 않습니다.</span>
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<input type="hidden" name="siteCode" value="<c:out value="${mngrSessionVO.currSiteCode}" />" />
										</c:otherwise>
									</c:choose>
											<tr>
												<th class="t"><label for="popupMobile">모바일표출</label></th>
												<td>
													<span class="col-sm-2 icheck"><input type="radio" class="minimal" name="popupMobile" id="popupMobile1" value='Y' ${ufn:checked('Y',result.popupMobile) }/><label for="popupMobile1">사용</label></span>
													<span class="col-sm-2 icheck"><input type="radio" class="minimal" name="popupMobile" id="popupMobile2" value='N' ${ufn:checked('N',result.popupMobile) } ${ufn:checked('',result.popupUseyn) }/><label for="popupMobile2">중지</label></span>
												</td>
											</tr>
											<tr>
												<th class="t"><label for="popupUseyn">사용여부</label></th>
												<td>
													<span class="col-sm-2 icheck"><input type="radio" class="minimal" name="popupUseyn" id="popupUseyn1" value='Y' ${ufn:checked('Y',result.popupUseyn) } ${ufn:checked('',result.popupUseyn) } /><label for="popupUseyn1">사용</label></span>
													<span class="col-sm-2 icheck"><input type="radio" class="minimal" name="popupUseyn" id="popupUseyn2" value='N' ${ufn:checked('N',result.popupUseyn) } /><label for="popupUseyn2">중지</label></span>
												</td>
											</tr>
											<tr>
												<th class="t"><label for="popupSdt">게시일시</label></th>
												<td>
													<div class="form-inline">
														<input type="text" name="popupSdt" id="popupSdt" maxlength="10" title="시작일" value="<c:out value="${result.popupSdt }" />" class="form-control input-sm f-wd-100 required validate-date" readonly="readonly" />
						                                    <select name="popupStm" id="popupStm" title="시작 시간" class="form-control input-sm f-wd-100">
							                                    <c:forEach var="tm" begin="0" end="23" >
							                                        <option value="<c:out value="${tm}" />" ${ufn:selected(result.popupStm,tm) } ><c:out value="${tm}" /> 시</option>
							                                    </c:forEach>
						                                    </select> 00분
					                                    &nbsp;&nbsp;~&nbsp;&nbsp;
														<input type="text" name="popupEdt" id="popupEdt" maxlength="10" title="종료일" value="<c:out value="${result.popupEdt}" />" class="form-control input-sm f-wd-100 required validate-date" readonly="readonly"  />
						                                    <select name="popupEtm" id="popupEtm" title="종료 시간" class="form-control input-sm f-wd-100">
							                                    <c:forEach var="tm" begin="0" end="23" >
							                                        <option value="<c:out value="${tm}" />" ${ufn:selected(result.popupEtm,tm) }><c:out value="${tm}" /> 시 </option>
							                                    </c:forEach>
						                                    </select> 59분

					                                    <button type="button" class="btn btn-default btn-sm" onclick="setUnlimit();" style="margin-left:10px;">무기한</button>
					                                </div>
											</tr>
<c:if test="${POPUP_CONFIG.value eq 'POPUPWIN' }">
											<tr>
												<th class="t"><label for="popupWidth">팝업창 크기</label></th>
												<td>
													<div class="form-inline">
														가로 : <input type="text" name="popupWidth" id="popupWidth" maxlength="3" title="팝업창 가로" value="<c:out value="${result.popupWidth}" />" class="required validate-digits form-control input-sm f-wd-100" onkeydown="return ItgJs.fn_numberOnly(event);" onChange="fn_changeWidth(this);" style="text-align: right;" />&nbsp;px&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														세로 : <input type="text" name="popupHeight" id="popupHeight" maxlength="3" title="팝업창 높이" value="<c:out value="${result.popupHeight}" />" class="required validate-digits form-control input-sm f-wd-100" onkeydown="return ItgJs.fn_numberOnly(event);" onChange="fn_changeHeight(this);" style="text-align: right;" />&nbsp;px
														<p><span class="help-block">팝업창의 사이즈를 입력해주세요</span></p>
													</div>
												</td>
											</tr>
</c:if>
											<tr>
												<th class="t"><label for="popupUseyn">업로드 형식</label></th>
												<td>
													<input type="hidden" name="oldUploadType" value="<c:out value="${result.uploadType}" />" />
													<input type="radio" name="uploadType" class="uploadType minimal" id="uploadType1" value="img" ${ufn:checked('img',result.uploadType) } ${ufn:checked('',result.uploadType) } /><label for="uploadType1">이미지</label>&nbsp;&nbsp;&nbsp;
													<input type="radio" name="uploadType" class="uploadType minimal" id="uploadType2" value="mv" ${ufn:checked('mv',result.uploadType) } /><label for="uploadType2">동영상 파일</label>&nbsp;&nbsp;&nbsp;
													<input type="radio" name="uploadType" class="uploadType minimal" id="uploadType3" value="stream" ${ufn:checked('stream',result.uploadType) } /><label for="uploadType3">실시간 동영상</label>&nbsp;&nbsp;&nbsp;
													<input type="radio" name="uploadType" class="uploadType minimal" id="uploadType4" value="editor" ${ufn:checked('editor',result.uploadType) } /><label for="uploadType4">에디터</label>&nbsp;&nbsp;&nbsp;
												</td>
											</tr>
											<tr id="imgTr">
												<th class="t"><label for="popupImg">이미지 첨부</label></th>
												<td>
													<input  type="file" name="popupImg" id="popupImg" class="${searchVO.act == 'REGIST'?' required ':''}validate-is-image" <c:out value="${result.popupImg }" /> title="이미지 첨부"/>
													<input type="hidden" name="oldFile" id="oldFile" value="<c:out value="${result.popupImg }" />" />
													<c:if test="${param.popupType eq '2' }">
														<span>가로 261 * 세로 124 사이즈의 이미지파일만 첨부해 주세요.</span>
													</c:if>
													<c:if test="${param.popupType eq '3' }">
														<span>가로 97 * 세로 25 사이즈의 이미지파일만 첨부해 주세요.</span>
													</c:if>
				                                    <c:if test="${not empty result.popupImg }">
				                                    첨부 이미지 :   <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','popup',result.popupImg,result.popupImg) }" />" ><c:out value="${result.popupImg }" /></a>
				                                    <div class="transbg" id="viewImageDiv" style="border:5px solid lightgray; width:0px; height:0px;">
				                                    	<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','popup',result.popupImg,result.popupImg) }" />" alt="<c:out value="${result.popupAlt}" />" style="width:100%;max-height:100%"/>
				                                    </div>
				                                    </c:if>
												</td>
											</tr>
											<tr id="mvTr">
												<th class="t"><label for="mvFile">동영상 첨부</label></th>
												<td>
													<input type="file" id="mvFile" name="mvFile" value="" class="${searchVO.act == 'REGIST'?' required ':''}validate-is-video" title="동영상 파일"/>
													<input type="hidden" name="mvFile" id="mvFile" value="<c:out value="${result.mvFile}" />" />
													<input type="hidden" name="oldMvFile" id="oldMvFile" value="<c:out value="${result.oldMvFile}" />" />
													<c:if test="${not empty result.oldMvFile}">
													  첨부 동영상 :   <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','movie',result.mvFile,result.oldMvFile) }" />" ><c:out value="${result.oldMvFile}" /></a>
													</c:if>
												</td>
											</tr>
											<tr id="streamTr">
												<th class="t"><label for="stream">실시간 동영상</label></th>
												<td>
													https://www.youtube.com/watch?v= &nbsp;<div id="yt" style="display: inline;"></div><input style="display: inline;" type="text" id="stream" name="streamUrl" value="<c:out value="${result.streamUrl}" />" class="${searchVO.act == 'REGIST'?' required ':''} form-control f-wd-400" placeholder="URL 업로드는 YouTube링크만 가능합니다." title="동영상  URL" onkeyup="youtube_parser(this)"/>
												</td>
											</tr>
											<tr id="editor">
												<th class="t"><label for="stream">에디터</label></th>
												<td>
													<div id="editorWraper">
														<script type="text/javascript" src="<c:url value="/cheditor/cheditor.js" />"></script>
														<textarea id="menuContents" name="menuContents" title="컨텐츠 내용" class="${searchVO.act == 'REGIST'?' required ':''}"><c:out value="${result.edit_contents }" /></textarea>
														<script type="text/javascript">
															var myeditor = new cheditor();              // 에디터 개체를 생성합니다.
															myeditor.config.editorHeight = '450px';     // 에디터 세로폭입니다.
															myeditor.config.editorWidth = '100%';        // 에디터 가로폭입니다.
															myeditor.config.usePreview = false;         // 미리보기 버튼을 사용하지 않습니다.
															myeditor.inputForm = 'menuContents';             // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
															myeditor.run(function(){
																$(".cheditor-editarea").css("width",$("#popupWidth").val());
																$(".cheditor-editarea").css("height",$("#popupHeight").val());
															});                             // 에디터를 실행합니다.
														</script>
													</div>
													<p><span class="help-block">편집화면과 실제 팝업창에 보여지는 화면이 다를 수 있으며, 화면에서 벗어나는 내용은 표시되지 않습니다. </span></p>
													<p><span class="help-block">팝업창크기를 수정하면 편집화면에 자동 적용됩니다.</span></p>
												</td>
											</tr>
											<tr>
												<th class="t"><label for="popupFile">파일 첨부</label></th>
												<td>
													<input  type="file" name="popupFile" id="popupFile" title="파일 첨부" onchange="fn_fileSizeCheck(this);" />
													<input type="hidden" name="popupFile" id="popupFile" value="<c:out value="${result.popupFile}" />" />
													<input type="hidden" name="oldFileNm" id="oldFileNm" value="<c:out value="${result.oldFileNm}" />" />
				                                    <c:if test="${not empty result.popupFile }">
				                                         	 첨부 파일 : <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','popup',result.popupFile,result.oldFileNm) }" />" ><c:out value="${result.oldFileNm}" /></a>
				                                    </c:if>
												</td>
											</tr>
											<tr>
												<th class="t"><label for="popupAlt">대체텍스트</label></th>
												<td>
													<textarea name="popupAlt" id="popupAlt" title="대체텍스트" class="form-control required" maxlength="1000"><c:out value="${result.popupAlt}"/></textarea>
													<span class="help-block">첨부한 파일과 관련된 상세 정보를 입력해주세요.(1000자 제한)</span>
												</td>
											</tr>
											<tr id="linktypeTr">
												<th class="t"><label for="popupLinktype1">링크구분</label></th>
												<td>
													<span class="col-sm-2 icheck"><input type="radio" class="minimal" name="popupLinktype" id="popupLinktype1" value='0' onclick="setLinktype('0');" ${ufn:checked('0',result.popupLinktype) } ${ufn:checked('',result.popupLinktype) }/><label for="popupLinktype1">없음</label></span>
													<span class="col-sm-2 icheck"><input type="radio" class="minimal" name="popupLinktype" id="popupLinktype2" value='1' onclick="setLinktype('1');" ${ufn:checked('1',result.popupLinktype) } /><label for="popupLinktype2">현재창</label></span>
													<span class="col-sm-2 icheck"><input type="radio" class="minimal" name="popupLinktype" id="popupLinktype3" value='2' onclick="setLinktype('2');" ${ufn:checked('2',result.popupLinktype) } /><label for="popupLinktype3">새창</label></span>
												</td>
											</tr>
											<tr id="linkTr">
												<th class="t"><label for="popupUrl">링크주소</label></th>
												<td>
													<input type="text" name="popupUrl" id="popupUrl" maxlength="100" title="링크주소" value="<c:out value="${result.popupUrl}"/>" class="form-control input-sm f-wd-400" />
													<span class="help-block">http:// 또는 https:// 를 포함한 전체 주소를 입력 해 주세요.</span>
												</td>
											</tr>
											<tr>
												<th class="t">순서</th>
												<td>
													<select name="popupOrder" id="popupOrder">
														<option value="1" ${ufn:selected('1', result.popupOrder) } >1번째위치</option>
														<option value="2" ${ufn:selected('2', result.popupOrder) } >2번째위치</option>
														<option value="3" ${ufn:selected('3', result.popupOrder) } >3번째위치</option>
														<option value="4" ${ufn:selected('4', result.popupOrder) } >4번째위치</option>
														<option value="5" ${ufn:selected('5', result.popupOrder) } >5번째위치</option>
														<option value="6" ${ufn:selected('6', result.popupOrder) } >6번째위치</option>
														<option value="7" ${ufn:selected('7', result.popupOrder) } >7번째위치</option>
														<option value="8" ${ufn:selected('8', result.popupOrder) } >8번째위치</option>
													</select>
												</td>
											</tr>
											<c:if test="${searchVO.schPopupType == 2}">
											<tr>
												<th class="t"><label for="expires">닫기 설정 표시</label></th>
												<td>
													<input type="text" name="expires" id="expires" maxlength="2" title="닫기 설정 일수" value="<c:out value="${result.expires}" />" placeholder="일 수를 입력해주세요." class="validate-digits form-control input-sm f-wd-400" />
													<p><span class="help-block">00일간 보이지 않기</span></p>
												</td>
											</tr>
											</c:if>
											<c:if test="${searchVO.act eq 'UPDATE' }">
												<tr>
													<th class="t">등록자 아이디 / 등록일</th>
													<td><c:out value="${result.regmemid }" /> / <fmt:formatDate value="${result.regdt }" type="date" pattern="yyyy-MM-dd HH:mm:ss" /></td>
												</tr>
												<c:if test="${not empty result.upddt }">
													<tr>
														<th class="t">수정자 아이디 / 등록일</th>
														<td><c:out value="${result.updmemid }" /> / <fmt:formatDate value="${result.upddt }" type="date" pattern="yyyy-MM-dd HH:mm:ss" /></td>
													</tr>
												</c:if>
											</c:if>
										</tbody>
									</table>
								</div><!-- /.col -->
							</div>
						<div class="box-footer">
		                  <div class="pull-right">
												<button  type="submit" value="" class="btn btn-primary btn-sm">저장</button>
		                    <c:if test="${searchVO.act == 'UPDATE' }">
												<button type="button" onclick="fn_goDel();" class="btn btn-danger btn-sm">삭제</button>
							</c:if>
												<a href="#none" onclick="fn_goList(); return false;" class="btn btn-default btn-sm">목록</a>
		                  </div>
		                </div><!-- /.box-footer -->
					</form>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->

<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	setLinktype("${searchVO.act == 'REGIST' ? '0' : result.popupLinktype}");
	/** 기간 달력 */
	$(document).ready(function(){
		ItgJs.fn_datePickerRange("#popupSdt", "#popupEdt");
	});

	var upType = $(":input:radio[name=uploadType]:checked").val();
	setUploadType(upType);
});

var start = "A";
$('input').on('ifChecked ifUnchecked', function(event){

	var opt = $(this).attr('name');
	var chkAll = $('input[name="chkAll"]');
	var siteCodes = $('input[name="siteCode"]');

	if(opt == "popupLinktype"){
		setLinktype($(this).val());
	}else if(opt == "chkAll"){
		if(start=="A"){//사이트코드의 변경이벤트로 발생되는 이벤트를 막기 위한 조치
			if (event.type == 'ifChecked') {
				siteCodes.iCheck('check');
			} else {
				siteCodes.iCheck('uncheck');
			}
		}
	}else if(opt == "siteCode"){
		start = "S";
		if(siteCodes.filter(':checked').length == siteCodes.length) {
			chkAll.iCheck('check');
		}else{
			chkAll.iCheck('uncheck');
		}
		start = "A";
		//alert(chkAll.filter(':checked').length);
		//chkAll.iCheck('update');

	}

});

/* 글 등록 function */
 function fn_egov_save() {
	frm = document.form1;
	$("#menuContents").val($.trim(myeditor.outputBodyText()));

	if(Validator.validate(frm)){
		var message = Validator["validate-max-length"](frm.streamUrl.value,"동영상  URL",'100');
		if(message) {alert(message);frm.streamUrl.focus();return false;}
		$("#menuContents").val($.trim(myeditor.outputBodyHTML()));
		$("#expires").val(Number($("#expires").val()));
	  	frm.action = "<c:url value="${searchVO.act == 'REGIST' ? '?schM=registProc' : '?schM=updateProc'}"/>";
	    frm.submit();
	}
}

function fn_goList(){
	/* var frm = document.form1;
	frm.encoding = "application/x-www-form-urlencoded";
	frm.action = "mngrPopupList.do";
	frm.submit(); */
	var queryString = "${searchVO.query}";
	queryString = ItgJs.fn_replaceQueryString(queryString, "schM", "list");
	queryString = ItgJs.fn_replaceQueryString(queryString, "id", "");
	location.href="?" + queryString;
}

/**
 * 2016.09.23 수정
   링크구분 없음 선택시 input 값 쓰지 못하도록 방지
 */
function setLinktype(opt){
	if(opt == "0"){
		$("#linkTr").hide();
		$("#popupUrl").removeClass("required validate-url").attr("readonly",true);
	}else if(opt == "1"){
		$("#linkTr").show();
		$("#popupUrl").addClass("required validate-url").attr("readonly",false);
	}else if(opt == "2"){
		$("#linkTr").show();
		$("#popupUrl").addClass("required validate-url").attr("readonly",false);
	}
}

function setUnlimit(){
	$("#popupSdt").val('<c:out value="${ufn:getDatePattern('yyyy-MM-dd')}" />');
	$("#popupStm").val("0");
	$("#popupEdt").val('2999-12-31');
	$("#popupEtm").val("23");
	/* alert($("#popupSdt").val().date().add(10)); */
}
<c:if test="${searchVO.act == 'UPDATE' }">
function fn_goDel(){
	if(confirm("삭제하시겠습니까?")){
		var frm = document.form1;
		frm.encoding = "application/x-www-form-urlencoded";
		frm.action = "?schM=delete";
		frm.submit();
	}
}
</c:if>

function setUploadType(opt){
	var act = document.form1.act.value;
	var upType = document.form1.oldUploadType.value;
	if(opt == "img"){
		$("#linktypeTr").show();
		$("#imgTr").show();
		$("#mvTr").hide();
		$("#streamTr").hide();
		$("#editor").hide();
		$("#mvFile").removeClass("required");
		$("#stream").removeClass("required");
		$("#menuContents").removeClass("required");
		if(act == 'REGIST' || (act == 'UPDATE' && upType == opt)){
			$("#popupImg").addClass("required");
		}
		<c:if test="${not empty result.popupImg }">
			if(act == 'REGIST' || (act == 'UPDATE' && upType == opt)){
				$("#popupImg").removeClass("required");
			}
		</c:if>
	}else if(opt == "mv"){
		$("#linktypeTr").show();
		$("#imgTr").hide();
		$("#mvTr").show();
		$("#streamTr").hide();
		$("#editor").hide();
		$("#popupImg").removeClass("required");
		$("#stream").removeClass("required");
		$("#menuContents").removeClass("required");
		if(act == 'REGIST' || (act == 'UPDATE' && upType == opt)){
			$("#mvFile").addClass("required");
		}
		<c:if test="${not empty result.oldMvFile }">
			if(act == 'REGIST' || (act == 'UPDATE' && upType == opt)){
				$("#mvFile").removeClass("required");
			}
		</c:if>
	}else if(opt == "stream"){
		$("#linktypeTr").show();
		$("#imgTr").hide();
		$("#mvTr").hide();
		$("#streamTr").show();
		$("#editor").hide();
		$("#mvFile").removeClass("required");
		$("#popupImg").removeClass("required");
		$("#menuContents").removeClass("required");
		if(act == 'REGIST' || (act == 'UPDATE' && upType != opt)){
			$("#stream").addClass("required");
		}
		/* if ($("#stream").val()!=null||$("#stream").val()!='') {
			if(act == 'REGIST' || (act == 'UPDATE' && upType == opt)){
				$("#stream").removeClass("required");
			}
		} */
	}else if(opt == "editor"){ //에디터 임시
		$("#linktypeTr").hide();
		$("#imgTr").hide();
		$("#mvTr").hide();
		$("#streamTr").hide();
		$("#editor").show();
		$("#mvFile").removeClass("required");
		$("#popupImg").removeClass("required");
		$("#stream").removeClass("required");
		if(act == 'REGIST' || (act == 'UPDATE' && upType != opt)){
			$("#menuContents").addClass("required");
		}

		/* if ($("#menuContents").val()!=null||$("#menuContents").val()!='') {
			if(act == 'REGIST' || (act == 'UPDATE' && upType == opt)){
				$("#menuContents").removeClass("required");
			}
		} */
	}

	fn_changeWidth($("#popupWidth").val());
	fn_changeHeight($("#popupHeight").val());
}

function fn_changeWidth(obj){
	fn_resetEditArea($("#popupWidth").val(),$("#popupHeight").val());
	fn_resetViewImage($("#popupWidth").val(),$("#popupHeight").val());
}
function fn_changeHeight(obj){
	fn_resetEditArea($("#popupWidth").val(),$("#popupHeight").val());
	fn_resetViewImage($("#popupWidth").val(),$("#popupHeight").val());
}

function fn_resetEditArea(width,height){
	myeditor.config.editorHeight = height;
	if(width != "") $(".cheditor-editarea").css("width",width);
	if(height != "") $(".cheditor-editarea").css("height",height);
}
function fn_resetViewImage(width,height){
	if(width != "") $("#viewImageDiv").css("width",width);
	if(height != "") $("#viewImageDiv").css("height",height);
}


$(".uploadType").on("ifChecked", function(event){
	setUploadType($(this).val());
});

function youtube_parser(url){
	var rUrl = url.value;
	if(rUrl.length > 11){
	    var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
	    var match = rUrl.match(regExp);
	    var $x = $("#mvFile2");
	    $("#mvFile2").val(match[7]);
	}
//     return (match&&match[7].length==11)? match[7] : false;
}

<%--
	수정일: 2019/3/19
	수정자: 아이티 굿 이덕천
	내용: 첨부파일 용량체크 기능 추가
--%>
function fn_fileSizeCheck(val){
	var file = val.files;
	var maxSize =  1024 * 1024 * 10;
	//파일사이즈를 MB 단위로 표시하기
	var fileSize = Math.round(file[0].size /1024/1024*100)/100;
	//파일사이즈의 숫자 표시를 000,000,000 처럼 만들기
	var sfileSize = fileSize.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	if(file[0].size > maxSize){
	alert("10MB 이하 파일만 업로드 할 수 있습니다.\n파일 확인 후 다시 시도해 주세요.\n(현재파일용량 : "+ sfileSize + "MB)");
	//용량 초과시 선택된 내용을 초기화 처리
	val.value = null;
	} else return;

}


//]]>
</script>