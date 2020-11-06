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
 * @파일명 : _mngr__custom_view.jsp
 * @파일정보 : 관리자 커스텀게시판 조회 스킨
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

var extEditorList = new Array();
var query = "<c:out value="${searchVO.query}" escapeXml="false" />";

$(document).ready(function(){
	ItgJs.fn_datePickerRange("#bdUseSdt", "#bdUseEdt");
	ItgJs.fn_datePickerRange("#bdNoticeSdt", "#bdNoticeEdt");
});

	/* 글 등록 function */
	function fn_egov_save() {
		frm = document.bbsForm;
<c:if test="${ufn:getProhibitRegEx() ne ''}">
		var prohibitRegEx = /${ufn:getProhibitRegEx()}/gi;
		if (prohibitRegEx.test(frm.bdTitle.value)) {
			alert(frm.bdTitle.title+"에 금지어를 포함하고 있습니다.");
			return false;
		}
		prohibitRegEx = /${ufn:getProhibitRegEx()}/gi;
</c:if>
		if(Validator.validate(frm)){
<c:choose>
	<c:when test="${boardconfigVO.bcEditoryn == 'Y'}">
			//에디터 내용검사
			myeditor.outputBodyText();
			if(myeditor.inputLength() == 0 && $("#bdContent").val()==""){
				var data = myeditor.getImages();
				if (data == null) {
					alert(frm.bdContent.title+"을(를) 입력하세요.");
					myeditor.editAreaFocus();
					return false;
				}
			} else {
				frm.noHTML.value = myeditor.getBodyText();
				var message = Validator["validate-max-length"](frm.noHTML.value,frm.bdContent.title,myeditor.size);
				// 오류가 있으면 메시지를 반환
				if(message) {
					alert(message);
					myeditor.editAreaFocus();
					return false;
				}
			<c:if test="${ufn:getProhibitRegEx() ne ''}">
				if (prohibitRegEx.test(frm.noHTML.value)) {
					alert(frm.bdContent.title+"에 금지어를 포함하고 있습니다.");
					myeditor.editAreaFocus();
					return false;
				}
			</c:if>
			}
			myeditor.outputBodyHTML();
			//웹접근성검사
			if(!fn_checkAccessability("bdContent", myeditor)) return false;
			frm.noHTML.value = myeditor.getBodyText();
	</c:when>
	<c:otherwise>
			if($("#bdContent").val()==""){
				alert(frm.bdContent.title+"을(를) 입력하세요.");
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
					alert(frm.bdContent.title+"에 금지어를 포함하고 있습니다.");
					$("#bdContent").focus();
					return false;
				}
		</c:if>
			}
			if(!fn_checkAccessability("bdContent")) return false;
	</c:otherwise>
</c:choose>

			var returnflag = false;
			$(extEditorList).each(function(index){
				if(this.required == "Y"){
					this.editor.outputBodyText();
					if(this.editor.inputLength() == 0 && $("#"+this.editor.inputForm).val()==""){
						var data = this.editor.getImages();
						if (data == null) {
							alert(this.name+"을(를) 입력하세요.");
							this.editor.editAreaFocus();
							returnflag = true;
							return false;
						}
					}
				}

				var message = Validator["validate-max-length"](this.editor.getBodyText(),this.name,this.size);
				// 오류가 있으면 메시지를 반환
				if(message) {
					alert(message);
					returnflag = true;
					return false;
				}

				if(!fn_checkAccessability(this.editor.inputForm,this.editor)){ returnflag = true; return false;}
				<c:if test="${ufn:getProhibitRegEx() ne ''}">
					if (prohibitRegEx.test(this.editor.getBodyText())) {
						alert(this.name+"에 금지어를 포함하고 있습니다.");
						this.editor.editAreaFocus();
						returnflag = true;
						return false;
					}
				</c:if>
				this.editor.outputBodyHTML();
			});
			if(returnflag) return false;

			frm.action = "/_mngr_/board/${menuCode}_proc_${bcid}.do?schM=proc";

	<c:if test="${boardconfigVO.bcFileyn eq 'Y'}">
			if(upload1_checkFileChangeSubmit(frm.fileId.title)){
	</c:if>
				frm.submit();
	<c:if test="${boardconfigVO.bcFileyn eq 'Y'}">
			}else{
				return false;
			}
	</c:if>
		}
	}

	function fn_checkAccessability(contentsId,editor){

		$("#vContents").html($("#"+contentsId).val());
		var result = checkAccessability($("#"+contentsId).attr('title'),"vContents");
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

	/* S : 썸네일 처리 */
	function fn_checkDelThumb(obj,required){
		console.log(obj.name+" : "+required);
		if(required == 'Y'){
			var thumbName = "bdThumb"+obj.name.replace("delcheckThumb","");
			if(obj.checked){
				$("#"+thumbName).addClass("required");
			}else{
				$("#"+thumbName).removeClass("required");
			}
		}
	}
	/* E : 썸네일 처리 */

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
					<input type="hidden" name="bcExtcolumninfo" value="<c:out value="${boardconfigVO.bcExtcolumninfo}"/>" />
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
												<ora:selectCodeList selectName="bdCode" selectedValue="${boardMap.bdCode }" codeList="${codeList }" selectTitle="구분" className="required form-control input-sm f-wd-200" />
											</td>
										</tr>
		</c:if>
										<tr>
											<th class="t"><label for="bdTitle">제목</label></th>
											<td colspan="3">
												<input type="text" name="bdTitle" id="bdTitle" class="required form-control input-sm" value="<c:out value="${boardMap.bdTitle }"/>" maxlength="50" title="제목" />
											</td>
										</tr>
										<tr>
											<th class="t"><span>작성자</span></th>
											<td colspan="3"><c:out value="${boardMap.bdWriter }" /></td>
										</tr>
<c:forEach var="column" items="${customColumnList}" varStatus="status">
	<c:choose>
		<c:when test="${column.code eq 'bdContent'}">
										<tr>
											<th class="t"><label for="bdContent"><c:out value="${column.name}" /></label></th>
											<td colspan="3">
											<c:if test="${boardMap.bdSecret eq 'Y' }">
												(※ 비밀글입니다)<br/>
												<input type="hidden" name="bdSecret" value="<c:out value="${boardMap.bdSecret}" />" />
											</c:if>
									<c:choose>
										<c:when test="${boardMap.bdHtmlyn eq 'Y'}">
											<c:if test="${boardconfigVO.bcEditoryn ne 'Y'}">
												<textarea name="bdContent" id="bdContent" class="form-control" title="<c:out value="${column.name}" />"></textarea>
												<section id="bdContentTemp" style="display:none;">
													<c:out value="${ufn:decodeXss(boardMap.bdContent)}" escapeXml="false" />
												</section>
												<script>
												$("#bdContent").val(ItgJs.stripHtmlforTextarea($("#bdContentTemp").html()));
												</script>
											</c:if>
											<c:if test="${boardconfigVO.bcEditoryn eq 'Y'}">
												<textarea name="bdContent" id="bdContent" class="form-control" title="<c:out value="${column.name}" />"><c:out value="${ufn:decodeXss(boardMap.bdContent)}" escapeXml="false" /></textarea>
											</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${boardconfigVO.bcEditoryn ne 'Y'}"><c:set var="bdContent" value="${ufn:decodeXss(boardMap.bdContent)}"/></c:if>
											<c:if test="${boardconfigVO.bcEditoryn eq 'Y'}"><c:set var="bdContent" value="${ufn:stripXss(boardMap.bdContent)}"/></c:if>
												<textarea name="bdContent" id="bdContent" class="form-control" title="<c:out value="${column.name}" />"><c:out value="${bdContent}" escapeXml="false" /></textarea>
										</c:otherwise>
									</c:choose>
									<c:if test="${boardconfigVO.bcEditoryn ne 'Y'}">
										<c:set var="maxLengthClass" value="${ufn:IIF(!empty column.size and column.size ne '',' validate-max-length_'.concat(column.size),'') }"/>
			                                    <!-- max_length 클래스를 삽입한다. -->
			                                    <script type="text/javascript">
			                                    	$("#bdContent").addClass("required<c:out value="${maxLengthClass}"/>");
			                                    </script>
									</c:if>
									<c:if test="${boardconfigVO.bcEditoryn eq 'Y'}">
			                                    <!-- 에디터를 화면에 출력합니다. -->
			                                    <script type="text/javascript">
				                                    var myeditor = new cheditor();              // 에디터 개체를 생성합니다.
				                                    myeditor.config.editorHeight = '300px';     // 에디터 세로폭입니다.
				                                    myeditor.config.editorWidth = '100%';        // 에디터 가로폭입니다.
				                                    myeditor.config.editorBgColor  = '#ffffff'; 	// 에디터 기본배경색입니다.
				                                    myeditor.inputForm = 'bdContent';           // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
				                                    myeditor.size = '${column.size}';           // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
				                                    myeditor.run();                             // 에디터를 실행합니다.
				                                    $("#bdContent").removeClass("required");
			                                    </script>
									</c:if>
											</td>
										</tr>
		</c:when>
		<c:when test="${column.code eq 'fileId'}">
										<tr>
											<th class="t"><span><c:out value="${column.name}" /></span></th>
											<td colspan="3">
												<!-- 파일업로드 폼 추가 시작 -->
												<c:import  url="/afile/fileuploadForm.do">
													<c:param name="formName" value="bbsForm" />
													<c:param name="objectId" value="upload1" />
													<c:param name="fileIdName" value="fileId" />
													<c:param name="fileIdTitle" value="${column.name}"/>
													<c:param name="fileIdValue" value="${boardMap.fileId}" />
													<c:param name="fileTypes" value="${boardconfigVO.bcFiletypedesc}" />
													<c:param name="maxFileSize" value="${boardconfigVO.bcFilesize}" />
													<c:param name="maxFileCount" value="${boardconfigVO.bcFilecount}" />
													<c:param name="isRequired" value="${column.required}" />
													<c:param name="useSecurity" value="false" />
													<c:param name="uploadMode" value="db" />
												</c:import>
												<!-- 파일업로드 폼 추가 끝 -->
											</td>
										</tr>
		</c:when>
		<c:when test="${column.code eq 'bdThumb'}">
			<c:if test="${boardSearchVO.schM ne 'reply'}">
				<c:if test = "${(boardMap.bdRelevel eq '0')||(boardMap.bdRelevel eq null)}">
					<c:forEach var="i" begin="1" end="${boardconfigVO.bcThumbcount }">
						<c:set var="file" value="${boardMap['bdThumb'.concat(i)]}" />
						<c:set var="alt" value="${boardMap['bdThumb'.concat(i).concat('Alt')]}" />
										<tr>
											<th class="t"><label for="bdThumb${i}"><c:out value="${column.name}" />${i}</label></th>
											<td>
												<input type="file" name="bdThumb${i}" id="bdThumb${i}"
														class="form-control validate-is-image<c:out value="${ufn:IIF((column.required eq 'Y') and (empty file),' required','') }"/>" title="<c:out value="${column.name}" />${i}" value="<c:out value="${file }" />"/>
												가로:${boardconfigVO.bcThumbwidth }px 세로:${boardconfigVO.bcThumbheight }px
												<input type="hidden" name="oldBdThumb${i}" id="oldBdThumb${i}" value="<c:out value="${file }" />" />
						<c:if test="${not empty file }">
												<div style="">
													<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','gallery',file,'thumb') }" />" alt="<c:out value="${ufn:quot(alt) }" />" />
													<input type="checkbox" name="delcheckThumb${i}" value="Y" onclick="fn_checkDelThumb(this,'${column.required}');"><label for="delcheckThumb${i}">삭제</label>
												</div>
						</c:if>
											</td>
											<th class="t"><label for="bdThumb${i}Alt">대체 텍스트${i}</label></th>
											<td>
												<textarea name="bdThumb${i}Alt" id="bdThumb${i}Alt" class="form-control<c:out value="${ufn:IIF((column.required eq 'Y') and (empty file),' required','') }"/>" maxlength="250" title="대체 텍스트${i}"><c:out value="${alt}" /></textarea>
											</td>
										</tr>
					</c:forEach>
				</c:if>
			</c:if>
		</c:when>
		<c:otherwise>
			<c:if test="${column.used eq 'Y'}">
										<tr>
											<th class="t"><span><c:out value="${column.name}" /></span></th>
											<td colspan="3">
											<c:if test="${column.type eq 'columnType01'}">
												<input type="text" name="<c:out value="${column.code}" />" id="<c:out value="${column.code}" />" title="<c:out value="${column.name}" />" value="<c:out value="${boardMap[column.code]}" />"
														class="form-control<c:out value="${ufn:IIF(!empty column.size and column.size ne '',' validate-max-length_'.concat(column.size),'') }"/><c:out value="${ufn:IIF(column.required eq 'Y',' required','') }"/>"/>
											</c:if>
											<c:if test="${column.type eq 'columnType02'}">
												<textarea name="<c:out value="${column.code}" />" id="<c:out value="${column.code}" />" title="<c:out value="${column.name}" />"
														class="form-control<c:out value="${ufn:IIF(!empty column.size and column.size ne '',' validate-max-length_'.concat(column.size),'') }"/><c:out value="${ufn:IIF(column.required eq 'Y',' required','') }"/>"><c:out value="${boardMap[column.code]}"/></textarea>
												<script type="text/javascript">
				                                    var height = Math.ceil(${column.size}/100)*30;
				                                    height = (height > 500 ? 500 : (height < 100 ? 100 : height));
				                                    $("#<c:out value="${column.code}" />").height(height);
												</script>
											</c:if>
											<c:if test="${column.type eq 'columnType03'}">
												<%-- <input type="hidden" name="<c:out value="${column.code}" />" id="<c:out value="${column.code}" />" value="EXTCLOB"/> --%>
												<c:set var="bdContent" value="${ufn:getLobContents(boardMap.bdIdx,column.code)}"/>
												<textarea name="<c:out value="${column.code}LOB" />" id="<c:out value="${column.code}LOB" />" title="<c:out value="${column.name}" />"
														<%-- class="form-control<c:out value="${ufn:IIF(!empty column.size and column.size ne '',' validate-max-length_'.concat(column.size),'') }"/>"><c:out value="${boardMap[column.code]}"/></textarea> --%>
														class="form-control"><c:out value="${ufn:decodeXss(boardMap.bdContent)}" escapeXml="false" /></textarea>
			                                    <!-- 에디터를 화면에 출력합니다. -->
			                                    <script type="text/javascript">
				                                    var ${column.code}Editor = new cheditor();              // 에디터 개체를 생성합니다.
				                                    var height = Math.ceil(${column.size}/100)*30;
				                                    height = (height > 500 ? 500 : (height < 200 ? 200 : height));
				                                    ${column.code}Editor.config.editorHeight = height+'px';     // 에디터 세로폭입니다.
				                                    ${column.code}Editor.config.editorWidth = '100%';        // 에디터 가로폭입니다.
				                                    ${column.code}Editor.config.editorBgColor  = '#ffffff'; 	// 에디터 기본배경색입니다.
				                                    ${column.code}Editor.inputForm = '${column.code}LOB';           // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
				                                    ${column.code}Editor.run();                             // 에디터를 실행합니다.
				                                    var tempMap = new Object();;
				                                    tempMap.name = "<c:out value="${column.name}" />";
				                                    tempMap.editor = ${column.code}Editor;
				                                    tempMap.required = '<c:out value="${column.required}" />';
				                                    tempMap.size = '<c:out value="${column.size}" />';
				                                    extEditorList.push(tempMap);
			                                    </script>
											</c:if>
											<c:if test="${column.type eq 'columnType04'}">
												<input type="text" name="<c:out value="${column.code}" />" id="<c:out value="${column.code}" />" title="<c:out value="${column.name}" />" value="<c:out value="${boardMap[column.code]}" />"
														class="form-control<c:out value="${ufn:IIF(!empty column.size and column.size ne '',' validate-digits_'.concat(column.size),' validate-digits') }"/><c:out value="${ufn:IIF(column.required eq 'Y',' required','') }"/>"/>
											</c:if>
<%-- 												column.code : [<c:out value="${column.code}" />],
												column.type : [<c:out value="${column.type}" />],
												column.size : [<c:out value="${column.size}" />],
												column.defaultVal : [<c:out value="${column.defaultVal}" />],
												column.required : [<c:out value="${column.required}" />],
												column.used : [<c:out value="${column.used}" />],
												boardMap[column.code] : [<c:out value="${boardMap[column.code]}" />] --%>

											</td>
										</tr>
			</c:if>
		</c:otherwise>
	</c:choose>
</c:forEach>


		<c:if test="${boardconfigVO.bcFileyn eq 'Y' }" >

		</c:if>
										<tr>
											<th class="t"><label for="bdUseyn">게시여부</label></th>
											<td colspan="3">
												<div class="form-inline">
													<input type="radio" class="minimal" name="bdUseyn" id="bdUseyn1" value="Y" ${ufn:checked(boardMap.bdUseyn, 'Y')} ${ufn:checked(boardMap.bdUseyn, '')}/><label for="bdUseyn1">사용</label>
													<input type="radio" class="minimal" name="bdUseyn" id="bdUseyn2" value="N" ${ufn:checked(boardMap.bdUseyn, 'N')}/><label for="bdUseyn2">중지</label>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

													<input type="checkbox" name="bdUseTermyn" id="bdUseTermyn" value="Y" ${ufn:checked(boardMap.bdUseTermyn, 'Y') } onclick="if(this.checked){$('#bdUseSdt,#bdUseEdt').addClass('required validate-date');}else{$('#bdUseSdt,#bdUseEdt').removeClass('required validate-date');}" /><label for="bdUseTermyn">기간설정 사용</label>
													<input type="text" name="bdUseSdt" id="bdUseSdt" maxlength="10" title="게시기간 시작일" value="<c:out value="${boardMap.bdUseSdt }" />" class="form-control input-sm f-wd-100" readonly="readonly" />
					                                    &nbsp;&nbsp;~&nbsp;&nbsp;
													<input type="text" name="bdUseEdt" id="bdUseEdt" maxlength="10" title="게시기간 종료일" value="<c:out value="${boardMap.bdUseEdt}" />" class="form-control input-sm f-wd-100" readonly="readonly"  />
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
