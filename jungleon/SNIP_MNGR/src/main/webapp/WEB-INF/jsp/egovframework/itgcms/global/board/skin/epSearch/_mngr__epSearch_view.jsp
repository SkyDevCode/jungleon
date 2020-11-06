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
 * @파일명 : _mngr__epSearch_view.jsp
 * @파일정보 : 관리자 기업탐방 게시판 조회 스킨
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 3. 19. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>
<script type="text/javascript">
//<[[!CDATA[

var checkFlag = false;
var query = "<c:out value="${searchVO.query}" escapeXml="false" />";

$(document).ready(function(){

	<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
		$("#bdCode").addClass("required");
	</c:if>

	ItgJs.fn_datePickerRange("#bdUseSdt", "#bdUseEdt");
	ItgJs.fn_datePickerRange("#bdNoticeSdt", "#bdNoticeEdt");
});

	/* 글 등록 function */
	function fn_egov_save() {
		frm = document.bbsForm;
<c:if test="${ufn:getProhibitRegEx() ne ''}">
		var prohibitRegEx = /${ufn:getProhibitRegEx()}/gi;
		if (prohibitRegEx.test(frm.bdTitle.value)) {
			alert("제목에 금지어를 포함하고 있습니다.");
			return false;
		}
		prohibitRegEx = /${ufn:getProhibitRegEx()}/gi;
</c:if>
		if(Validator.validate(frm)){
	<c:if test="${boardconfigVO.bcThumbyn eq 'Y' }">
/* 	  <c:forEach var="i" begin="1" end="${boardconfigVO.bcThumbcount }">
	   if($("#bdThumb${i}").val() == "" && $("#oldBdThumb${i}").val() == ""){
		   alert("썸네일${i} 이미지를 첨부 해 주세요.");
		   return false;
	   }
		</c:forEach> */
		<c:if test="${boardSearchVO.schM ne 'reply' }">
			if($("#bdThumb1").val() == "" && $("#oldBdThumb1").val() == ""){
			   alert("썸네일1 이미지는 반드시 첨부 되어야 합니다.");
			   $("#bdThumb1").focus();
			   return false;
		   	}
		</c:if>
	</c:if>
<c:choose>
	<c:when test="${boardconfigVO.bcEditoryn == 'Y'}">
			//에디터 내용검사
			myeditor.outputBodyText();
			if(myeditor.inputLength() == 0 && $("#bdContent").val()==""){
				var data = myeditor.getImages();
				if (data == null) {
		               		alert("상세 내용을 입력하세요.");
					myeditor.editAreaFocus();
					return false;
				}
			} else {
				frm.noHTML.value = myeditor.getBodyText();
				<%--
				var message = Validator["validate-max-length"](frm.noHTML.value,"내용",'${boardconfigVO.bcContentsLen}');
				// 오류가 있으면 메시지를 반환
				if(message) {
					alert(message);
					myeditor.editAreaFocus();
					return false;
				}--%>
			<c:if test="${ufn:getProhibitRegEx() ne ''}">
				if (prohibitRegEx.test(frm.noHTML.value)) {
					alert("내용에 금지어를 포함하고 있습니다.");
					return false;
				}
			</c:if>
			}
			myeditor.outputBodyHTML();
			//웹접근성검사
			if(!fn_checkAccessability("내용","bdContent", myeditor)) return false;
			frm.noHTML.value = myeditor.getBodyText();
	</c:when>
	<c:otherwise>
			if($("#bdContent").val()==""){
				alert("상세 내용을 입력하세요.");
				$("#bdContent").focus();
				return false;
			} else {
				<%--
				var message = Validator["validate-max-length"](frm.bdContent.value,"내용",'${boardconfigVO.bcContentsLen}');
				// 오류가 있으면 메시지를 반환
				if(message) {
					alert(message);
					return false;
				}--%>
		<c:if test="${ufn:getProhibitRegEx() ne ''}">
				if (prohibitRegEx.test(frm.bdContent.value)) {
					alert("내용에 금지어를 포함하고 있습니다.");
					$("#bdContent").focus();
					return false;
				}
		</c:if>
			}
			if(!fn_checkAccessability("내용","bdContent")) return false;
	</c:otherwise>
</c:choose>

			frm.action = "/_mngr_/board/${menuCode}_proc_${bcid}.do?schM=proc";

	<c:if test="${boardconfigVO.bcFileyn eq 'Y'}">
			if(upload1_checkFileChangeSubmit("첨부파일")){
	</c:if>
	    		frm.submit();
	<c:if test="${boardconfigVO.bcFileyn eq 'Y'}">
			}else{
				return false;
			}
	</c:if>
		}
	}

	function fn_checkAccessability(title,contentsId,editor){

		$("#vContents").html($("#"+contentsId).val());
		var result = checkAccessability(title,"vContents");
		//웹접근성검사
		if(!result){
			console.log("오류발생 : false");
			if(editor){
				editor.editAreaFocus();
			}else{
				$("#"+contentsId).focus();
			}
		}
		$("#vContents").html("");
		return result;
	}

/* 목록 이동 function */
function fn_goList(){
	query = ItgJs.fn_replaceQueryString(query, "id", "");
	query = ItgJs.fn_replaceQueryString(query, "schM", "list");
	location.href="/_mngr_/board/${menuCode}_list_${bcid}.do?" + query;
}

<c:if test="${searchVO.act == 'UPDATE' }">
	<c:if test="${boardconfigVO.bcReplyyn eq 'Y' }">
		function fn_goReply(){
			query = ItgJs.fn_replaceQueryString(query, "id", "${searchVO.id}");
			query = ItgJs.fn_replaceQueryString(query, "schM", "reply");
			location.href="/_mngr_/board/${menuCode}_reply_${bcid}.do?"+ query;
		}
	</c:if>
	/* 게시글 삭제 function */
	function fn_goDel(){
		if(confirm("삭제하시겠습니까?")){
			var frm = document.bbsForm;
			frm.mode.value="delete";
			frm.encoding = "application/x-www-form-urlencoded";
			frm.action = "/_mngr_/board/${menuCode}_proc_${bcid}.do";
			frm.submit();
		}
	}
</c:if>

	/* 첨부파일  사용시*/
	var uploadFlag = false;
	// 전송 버튼 클릭 시
	function send1(){
		fileUploadObj1.startUpload();
	}

 	// 태그라이브러리 에서 등록한 업로드 완료 이벤트 함수 명
	function uploadCompleted1(){
 		fileUploadObj1.refresh();
 	}

	function loadDownload() {
		var fileId= document.bbsForm.fileId.value;
		fileUploadObj1.setFileId(fileId);
		fileUploadObj1.refresh();
	}
	/* 첨부파일  end*/
//]]>
</script>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
				<div class="body-header">
					<div class="pull-right margin-bottom" id="headerButtons"></div>
					<script>$(function(){$("#headerButtons").html($("#footerButtons").html())})</script>
				</div>
				<form name="bbsForm" id="bbsForm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
					<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
					<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
					<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
					<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
					<input type="hidden" name="id" value="<c:out value="${searchVO.id}" />" />
					<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
					<input type="hidden" name="act" value="<c:out value="${searchVO.act}" />" />
					<input type="hidden" name="mode" value="${ufn:deCode(searchVO.act,'REGIST,insert,UPDATE,update,REPLY,reply', '')}" />
					<input type="hidden" name="noHTML" value="" />
					<input type="hidden" name="bdHtmlyn" value="${boardconfigVO.bcEditoryn}" />
					<input type="hidden" name="bdContentText"/>
						<div class="row">
							<div class="col-xs-12 table-responsive">
								<table class="table table-bordered tp2">
									<colgroup>
										<col style="width:15%"/>
										<col style="width:35%"/>
										<col style="width:15%"/>
										<col style="width:35%"/>
									</colgroup>
									<tbody>
										<c:if test="${boardconfigVO.bcGroupyn eq 'Y' }">
											<tr>
												<th class="t"><label for="bdCode">구분</label></th>
												<td colspan="3" class="last">
													<ora:selectCodeList selectName="bdCode" selectedValue="${boardMap.bdCode }" codeList="${codeList }" selectTitle="구분"/>
												</td>
											</tr>
											</c:if>
										<tr>
											<th class="t"><label for="bdTitle">제목</label></th>
											<td colspan="3">
												<input type="text" name="bdTitle" id="bdTitle" class="required form-control input-sm f-wd-600" value="<c:out value="${boardMap.bdTitle }"/>" maxlength="50" title="제목" />
											</td>
										</tr>
										<%-- <tr>
											<th class="t"><span>작성자</span></th>
											<td colspan="3"><c:out value="${boardMap.bdWriter }" /></td>
										</tr> --%>

										<c:if test="${boardSearchVO.schM ne 'reply'}">
										    <c:if test = "${(boardMap.bdRelevel eq '0')||(boardMap.bdRelevel eq null)}">
												<c:if test="${boardconfigVO.bcThumbyn eq 'Y' }">
													<c:forEach var="i" begin="1" end="${boardconfigVO.bcThumbcount }">
														<c:set var="file" value="" />
														<c:set var="alt" value="" />
														<c:choose>
															<c:when test="${i eq 1 }">
																<c:set var="file" value="${boardMap.bdThumb1 }" />
																<c:set var="alt" value="${boardMap.bdThumb1Alt }" />
															</c:when>
															<c:when test="${i eq 2 }">
																<c:set var="file" value="${boardMap.bdThumb2 }" />
																<c:set var="alt" value="${boardMap.bdThumb2Alt }" />
															</c:when>
															<c:when test="${i eq 3 }">
																<c:set var="file" value="${boardMap.bdThumb3 }" />
																<c:set var="alt" value="${boardMap.bdThumb3Alt }" />
															</c:when>
														</c:choose>
															<tr>
					                        					<th class="t"><label for="bdThumb${i}">썸네일${i}</label></th>
					                        					<td>
					                    							<input type="file" name="bdThumb${i}" id="bdThumb${i}" class="validate-is-image" title="썸네일${i}" />
																		<p></p>
					                                            		<span><h4>가로:${boardconfigVO.bcThumbwidth }px 세로:${boardconfigVO.bcThumbheight }px</h4></span>
					                        						<input type="hidden" name="oldBdThumb${i}" id="oldBdThumb${i}" value="<c:out value="${file }" />" />
																<c:if test="${not empty file }">
																	<div style="">
																		<c:choose>
																			<c:when test="${fn:contains(file,'WEBROOT_NEW')}">
																				<img src="<c:url value="/comm/viewImage2.do?f=${ufn:getDownloadLink('','gallery',file,'thumb') }" />" class="img" alt="<c:out value="${ufn:quot(alt) }" />">
																			</c:when>
																			<c:otherwise>
																		        <img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','gallery',file,'thumb') }" />" class="img" alt="<c:out value="${ufn:quot(alt) }" />">
																			</c:otherwise>
																		</c:choose>
																		<%-- <img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','gallery',file,'thumb') }" />" alt="<c:out value="${ufn:quot(alt) }" />" /> --%>
																	</div>
																</c:if>
																</td>
																<th class="t"><label for="bdThumb${i}Alt">대체 텍스트${i}</label></th>
																<td>
																	<textarea name="bdThumb${i}Alt" id="bdThumb${i}Alt" class=" form-control" maxlength="250" title="대체 텍스트${i}"><c:out value="${alt}" /></textarea>
																</td>
															</tr>
												    </c:forEach>
												</c:if>
											</c:if>
										</c:if>
										<c:if test="${boardconfigVO.bcFileyn eq 'Y' }" >
											<tr>
												<th class="t"><span>첨부파일</span></th>
												<td colspan="3">
													<!-- 파일업로드 폼 추가 시작 -->
													<c:import  url="/afile/fileuploadForm.do">
														<c:param name="formName" value="bbsForm" />
														<c:param name="objectId" value="upload1" />
														<c:param name="fileIdName" value="fileId" />
														<c:param name="fileIdValue" value="${boardMap.fileId}" />
														<c:param name="fileTypes" value="${boardconfigVO.bcFiletypedesc}" />
														<c:param name="maxFileSize" value="${boardconfigVO.bcFilesize}" />
														<c:param name="maxFileCount" value="${boardconfigVO.bcFilecount}" />
														<c:param name="useSecurity" value="false" />
														<c:param name="uploadMode" value="db" />
													</c:import>
													<!-- 파일업로드 폼 추가 끝 -->
												</td>
											</tr>
										</c:if>
										<tr>
											<th class="t"><label for="bdLnUrl">링크 URL</label></th>
											<td colspan="3">
												<input type="text" name="bdLnUrl" id="bdLnUrl" class="required form-control input-sm f-wd-600" value="<c:out value="${boardMap.bdLnUrl }"/>" maxlength="50" title="링크 URL" />
												<p></p>
												<span><h4>※ 입력 예 : https://www.snip.or.kr</h4></span>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="bdUseyn">게시여부</label></th>
											<td colspan="3">
												<div class="form-inline">
													<input type="radio" class="minimal" name="bdUseyn" id="bdUseyn1" value="Y" ${ufn:checked(boardMap.bdUseyn, 'Y')} ${ufn:checked(boardMap.bdUseyn, '')}/><label for="bdUseyn1">사용</label>
													<input type="radio" class="minimal" name="bdUseyn" id="bdUseyn2" value="N" ${ufn:checked(boardMap.bdUseyn, 'N')}/><label for="bdUseyn2">중지</label>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												</div>
											</td>
										</tr>

										<c:if test="${boardconfigVO.bcNoticeyn eq 'Y' }">
											<tr>
												<th class="t"><label for="bdNotice">공지여부</label></th>
												<td colspan="3">
													<div class="form-inline">
														<input type="radio" class="minimal" name="bdNotice" id="bdNotice0" value="0" title="공지글 선택" <c:out value="${boardMap.bdNotice eq '0' ? 'checked' : ''}"/> /><label for="bdNotice0" class="font05"> 미사용</label>
														<input type="radio" class="minimal" name="bdNotice" id="bdNotice1" value="1" title="공지글 선택" <c:out value="${boardMap.bdNotice eq '1' ? 'checked' : ''}"/> /><label for="bdNotice1" class="font05"> 전체</label>
														<input type="radio" class="minimal" name="bdNotice" id="bdNotice2" value="2" title="공지글 선택" <c:out value="${boardMap.bdNotice eq '2' ? 'checked' : ''}"/> /><label for="bdNotice2" class="font05"> 내 사이트</label>
														<input type="radio" class="minimal" name="bdNotice" id="bdNotice3" value="3" title="공지글 선택" <c:out value="${boardMap.bdNotice eq '3' ? 'checked' : ''}"/> /><label for="bdNotice3" class="font05"> 해당게시판</label>
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

														<input type="checkbox" name="bdNoticeTermyn" id="bdNoticeTermyn" value="Y" ${ufn:checked(boardMap.bdNoticeTermyn, 'Y') } onclick="if(this.checked){$('#bdNoticeSdt,#bdNoticeEdt').addClass('required validate-date');}else{$('#bdNoticeSdt,#bdNoticeEdt').removeClass('required validate-date');}" /><label for="bdNoticeTermyn">기간설정 사용</label>
														<input type="text" name="bdNoticeSdt" id="bdNoticeSdt" maxlength="10" title="공지기간 시작일" value="<c:out value="${boardMap.bdNoticeSdt }" />" class="form-control input-sm f-wd-100" readonly="readonly" />
						                                    &nbsp;&nbsp;~&nbsp;&nbsp;
														<input type="text" name="bdNoticeEdt" id="bdNoticeEdt" maxlength="10" title="공지기간 종료일" value="<c:out value="${boardMap.bdNoticeEdt}" />" class="form-control input-sm f-wd-100" readonly="readonly"  />
													</div>
												</td>
											</tr>
										</c:if>

										<c:if test="${searchVO.act eq 'UPDATE' }">
											<tr>
													<th class="t"><span>등록자 정보</span></th>
													<td colspan="3"><strong>아이디 : </strong><c:out value="${boardMap.regmemid }" />, <strong>등록일 : </strong><c:out value="${boardMap.regdt }" /></td>
												</tr>
											<c:if test="${not empty boardMap.updmemid }">
												<tr>
													<th class="t"><span>수정자 정보</span></th>
													<td colspan="3"><strong>아이디 : </strong><c:out value="${boardMap.updmemid }" />, <strong>수정일 : </strong><c:out value="${boardMap.upddt }" /></td>
												</tr>
											</c:if>
										</c:if>

									</tbody>
								</table>
							</div><!-- /.col -->
						</div><!-- /inner row -->
					</form>
					<c:if test="${boardconfigVO.bcComment > 0 && searchVO.schM eq 'view'}">
 						<jsp:include page="../boardReple.jsp"/>
					</c:if>
					<div class="body-footer" id="footerButtons">
						<div class="pull-right">
							<c:if test="${searchVO.act eq 'UPDATE' && boardconfigVO.bcReplyyn eq 'Y'}">
								<button type="button" onclick="fn_goReply();" class="btn btn-danger">답글</button>
							</c:if>
								<button type="button" onclick="fn_egov_save(); return false;" class="btn btn-primary">저장</button>
							<c:if test="${searchVO.act eq 'UPDATE'}">
								<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
							</c:if>
								<button type="button" onclick="fn_goList(); return false;" class="btn btn-default">목록</button>
						</div>
					</div><!-- /.body-footer -->
 				<%@ include file="../../../module/socialmedia/connectScript.jsp" %>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
