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
 * @파일명 : user_custom_regist.jsp
 * @파일정보 : 커스텀게시판 등록/수정
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
<!-- AX5-UI -->
<script src="${ctx}/resource/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/ax5core.min.js"></script>
<script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/ax5ui.itg.js"></script>
<script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/jquery-direct.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/resource/plugins/ax5ui/ax5ui.itg.css"/>
<script type="text/javascript">
//<[[!CDATA[

var extEditorList = new Array();
var query = "<c:out value="${searchVO.query}" escapeXml="false" />";

$(document).ready(function(){
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

		frm.action = "/user/board/${menuCode}_proc_${bcid}.do";

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
		location.href="?" + query;
	}

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

<form name="bbsForm" id="bbsForm" method="post" action="" onsubmit="fn_egov_save(); return false;" enctype="multipart/form-data">
	<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
	<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
	<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
	<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
	<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
	<input type="hidden" name="id" value="<c:out value="${searchVO.id}" />" />
	<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
	<input type="hidden" name="act" value="<c:out value="${searchVO.act}" />" />
	<input type="hidden" name="mode" value="${ufn:deCode(searchVO.act,'REGIST,insert,UPDATE,update,REPLY,reply','')}" />
	<input type="hidden" name="siteCode" value="${siteCode}" />
	<input type="hidden" name="noHTML" value="" />
	<input type="hidden" name="bdHtmlyn" value="${boardconfigVO.bcEditoryn}" />
	<input type="hidden" name="bdContentText"/>
	<input type="hidden" name="bcExtcolumninfo" value="<c:out value="${boardconfigVO.bcExtcolumninfo}"/>" />
	<div class="fixwidth">
		<div class="boardWrite st_01">
			<dl class="infor f">
				<dt class="t"><label for="bdTitle">제목</label></dt>
				<dd class="writer"><input type="text" name="bdTitle" id="bdTitle"  maxlength="50" class="required" title="제목" value="<c:out value="${boardMap.bdTitle }" />" />
<c:if test="${boardconfigVO.bcSecretyn eq 'Y' }">
					<p>
						<input type="checkbox" name="bdSecret" id="bdSecret" value="Y" title="비밀글 선택" ${ufn:checked(boardMap.bdSecret, 'Y') } /><label for="bdSecret" class="font05"> 비밀글</label>
					</p>
</c:if>
				</dd>
			</dl>
<c:if test="${boardconfigVO.bcGroupyn eq  'Y' and boardSearchVO.schM ne 'reply'}">
			<dl class="infor">
				<dt class="t"><label for="writer_name">구분</label></dt>
				<dd class="writer">
					<ora:selectCodeList selectName="bdCode" selectedValue="${boardMap.bdCode }" codeList="${codeList }" selectTitle="구분" className="required" />
				</dd>
			</dl>
</c:if>
			<dl class="infor">
				<dt class="t"><label for="bdWriter">작성자</label></dt>
				<dd class="writer">
<c:choose>
	<c:when test="${ufn:getUserSessionVO() eq null}">
					<input type="text" name="bdWriter" id="bdWriter"  maxlength="20" class="required" title="작성자" value="<c:out value="${boardMap.bdWriter}" />" />
	</c:when>
	<c:otherwise>
					<c:out value="${boardMap.bdWriter }" />
	</c:otherwise>
</c:choose>
				</dd>
<c:if test="${ufn:getUserSessionVO() eq null or '' eq boardMap.regmemid}">
				<dt class="t"><label for="bdPasswd">비밀번호</label></dt>
				<dd class="writer">
					<input style="" type="password" name="bdPasswd" id="bdPasswd"  maxlength="20" class="required" title="비밀번호"/>
	<c:if test="${searchVO.act == 'UPDATE' }"><br/>
					<span class="help">본인 확인용도 이며, 변경은 불가합니다.</span>
	</c:if>
				</dd>
</c:if>
			</dl>
<c:forEach var="column" items="${customColumnList}" varStatus="status">
	<c:choose>
		<c:when test="${column.code eq 'bdContent'}">
			<dl class="infor">
				<dt class="t"><label for="bdContent"><c:out value="${column.name}" /></label></dt>
				<dd class="writeTxt">
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
						userEditorSet(myeditor);						// 사용 안하는 버튼 제거
						myeditor.inputForm = 'bdContent';           // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
						myeditor.size = '${column.size}';           // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
						myeditor.run();                             // 에디터를 실행합니다.
						$("#bdContent").removeClass("required");
					</script>
			</c:if>
				</dd>
			</dl>
		</c:when>
		<c:when test="${column.code eq 'fileId'}">
			<c:if test="${not isMobile}">
				<c:if test="${boardconfigVO.bcFileyn eq 'Y' }" >
			<dl class="infor">
				<dt class="t"><c:out value="${column.name}" /></dt>
				<dd class="writer">
					<!-- 파일업로드 폼 추가 시작 -->
					<c:import  url="/afile/fileuploadForm.do">
						<c:param name="formName" value="bbsForm"/>
						<c:param name="objectId" value="upload1"/>
						<c:param name="fileIdName" value="fileId"/>
						<c:param name="fileIdTitle" value="${column.name}"/>
						<c:param name="fileIdValue" value="${boardMap.fileId}"/>
						<c:param name="fileTypes" value="${boardconfigVO.bcFiletypedesc}"/>
						<c:param name="maxFileSize" value="${boardconfigVO.bcFilesize}"/>
						<c:param name="maxFileCount" value="${boardconfigVO.bcFilecount}"/>
						<c:param name="isRequired" value="${column.required}" />
						<c:param name="useSecurity" value="false" />
						<c:param name="uploadMode" value="db" />
					</c:import>
					<!-- 파일업로드 폼 추가 끝 -->
				</dd>
			</dl>
				</c:if>
			</c:if>
		</c:when>
		<c:when test="${column.code eq 'bdThumb'}">
			<c:if test="${boardSearchVO.schM ne 'reply'}">
				<c:if test = "${(boardMap.bdRelevel eq '0')||(boardMap.bdRelevel eq null)}">
					<c:forEach var="i" begin="1" end="${boardconfigVO.bcThumbcount }">
						<c:set var="file" value="${boardMap['bdThumb'.concat(i)]}" />
						<c:set var="alt" value="${boardMap['bdThumb'.concat(i).concat('Alt')]}" />
			<dl class="infor">
				<dt class="t"><label for="bdThumb${i}"><c:out value="${column.name}"/>${i}</label></dt>
				<dd class="writer">
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
				</dd>
				<dt class="t"><label for="bdThumb${i}Alt">대체 텍스트${i}</label></dt>
				<dd class="writer">
					<textarea name="bdThumb${i}Alt" id="bdThumb${i}Alt" class="form-control<c:out value="${ufn:IIF((column.required eq 'Y') and (empty file),' required','') }"/>" maxlength="250" title="대체 텍스트${i}"><c:out value="${alt}" /></textarea>
				</dd>
			</dl>
					</c:forEach>
				</c:if>
			</c:if>
		</c:when>
		<c:otherwise>
			<c:if test="${column.used eq 'Y'}">
			<dl class="infor">
				<dt class="t"><c:out value="${column.name}" /></dt>
				<dd class="writer">
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
						var tempMap = new Object();
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
				</dd>
			</dl>
			</c:if>
		</c:otherwise>
	</c:choose>
</c:forEach>
		</div>
		<div class="boardBtnBox">
			<ul class="list_btn">
<c:if test="${boardAuthVO.regist eq true }">
				<li class="update"><a href="#none" onclick="fn_egov_save();">저장</a></li>
</c:if>
<c:if test="${boardSearchVO.schM eq 'reply' and boardAuthVO.reply eq true }">
				<li class="update"><a href="#none" onclick="fn_egov_save();">답글저장</a></li>
</c:if>
				<li class="list"><a href="#none" onclick="fn_goList(); return false;">목록</a></li>
			</ul>
		</div>
	</div>
</form>
