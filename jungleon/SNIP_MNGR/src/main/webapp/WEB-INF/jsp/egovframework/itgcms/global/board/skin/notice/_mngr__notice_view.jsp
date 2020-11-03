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
 * @파일명 : _mngr__notice_view.jsp
 * @파일정보 : 관리자 공지사항 조회 스킨
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
<c:choose>
	<c:when test="${boardconfigVO.bcEditoryn == 'Y'}">
		<%--<c:if test="${(searchVO.act eq 'UPDATE' and boardMap.regmemid ne searchVO.schRegmemid) ne true}">--%>
			//에디터 내용검사
			myeditor.outputBodyText();
			if(myeditor.inputLength() == 0 && $("#bdContent").val()==""){
				var data = myeditor.getImages();
				if (data == null) {
					alert("내용을 입력하세요.");
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
				alert("내용을 입력하세요.");
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
				<div class="row">
					<div class="col-xs-12 table-responsive">
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:15%"/>
								<col/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="bdTitle">제목</label></th>
									<td colspan="3"><c:out value="${boardMap.bdTitle }"/></td>
								</tr>
								<tr>
									<th class="t"><span>작성자</span></th>
									<td colspan="3"><c:out value="${boardMap.bdWriter }" /></td>
								</tr>
								<tr>
									<th class="t"><label for="bdContent">내용</label></th>
									<td colspan="3">
									<c:choose>
										<c:when test="${boardMap.bdHtmlyn eq 'Y'}">
										    <c:out value="${ufn:decodeXss(boardMap.bdContent)}" escapeXml="false" />
										</c:when>
										<c:otherwise>
										    <c:out value="${ufn:stripXss(boardMap.bdContent) }" escapeXml="false" />
										</c:otherwise>
									</c:choose>
									</td>
								</tr>
	<c:if test="${boardconfigVO.bcFileyn eq 'Y' }" >
								<tr>
									<th class="t"><span>첨부파일</span></th>
									<td colspan="3">
										<!-- 파일다운로드 폼 추가 시작 -->
										<c:import  url="/afile/filedownForm.do">
											<c:param name="formName" value="bbsForm" />
											<c:param name="objectId" value="download1" />
											<c:param name="fileIdName" value="fileId" />
											<c:param name="fileIdValue" value="${boardMap.fileId}" />
											<c:param name="useSecurity" value="false" />
											<c:param name="uploadMode" value="db" />
										</c:import>
										<!-- 파일다운로드 폼 추가 끝  -->
									</td>
								</tr>
	</c:if>
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
							</tbody>
						</table>
					</div><!-- /.col -->
				</div><!-- /inner row -->
				<c:if test="${boardconfigVO.bcComment > 0 && searchVO.schM eq 'view'}">
	 				<jsp:include page="../boardReple.jsp"/>
				</c:if>
				<div class="body-footer" id="footerButtons">
					<div class="pull-right">
						<a href="#none" onclick="fn_goList(); return false;" class="btn btn-default">목록</a>
					</div>
				</div><!-- /.body-footer -->
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
