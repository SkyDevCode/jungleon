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
 * @파일명 : mngrTotalTbRegist.jsp
 * @파일정보 : 총괄표 관리자 등록
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @hsk1218 2020. 4. 27. 최초생성
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


var nowRowNum 	= 1;
var rowNum	 	= 0;

var myeditor = {};

for (var x = 1; x < 100; x++) {
	myeditor[x] = new cheditor();
}


var checkFlag = false;


	/* 글 등록 function */
	function fn_egov_save() {

		$('[name=nowRowNum]').val(nowRowNum);
		$('[name=rowNum]').val(rowNum);


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

			for (var x = 1; x < nowRowNum; x++) {
				myeditor+"x".outputBodyText();
				myeditor+"x".outputBodyHTML();
			}
			frm.action = "/_mngr_/module/${menuCode}_proc_newsletter.do?schM=proc";
			frm.submit();
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
	location.href="/_mngr_/module/${menuCode}_list_newsletter.do";
}

<c:if test="${searchVO.act == 'UPDATE' }">
	/* 게시글 삭제 function */
	function fn_goDel(){
		if(confirm("삭제하시겠습니까?")){
			var frm = document.bbsForm;
			frm.mode.value="delete";
			frm.encoding = "application/x-www-form-urlencoded";
			frm.action = "/_mngr_/module/${menuCode}_delete_newsletter.do";
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


function fn_changePhoto(val){
	if(val.files && val.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			$("#previewImg").attr("src", e.target.result);
		}
		reader.readAsDataURL(val.files[0]);
	}
}


var registCnInput = {

		init				: function() {
			var $headerButtons 			= $("#headerButtons"),
			    $footerButtons 			= $("#footerButtons");

			// 저장 목록 버튼
			$headerButtons.html($footerButtons.html());

			var act = "${searchVO.act}";
			if( act == "UPDATE" ){
				nowRowNum = '${resultListSize}';
				rowNum	 	= '${resultListSize - 1}';
			}
		},

		chkThumbTypeFn			: function() {
			var $elThumb 	= $("#nlThumb1");

			$elThumb.on("change", function(evt){
				var image= evt.target.files[0];

				//alert(bool);
				if (!fn_valideImageType(image)) {
					alert("썸네일 파일 타입은 이미지입니다.")
					return;
				}
			});
		},

		deleteSubmitFn			: function() {
			if(confirm("정말로 삭제하시겠습니까?\n삭제된 데이터는 복구 할 수 없습니다.\n삭제하시려면 [확인]을 클릭하세요.")){
				$("#bbsForm").attr("action", "<c:url value='/_mngr_/module/${menuCode}_delete_newsletter.do'/>");
				$("#bbsForm").submit();
			}

		},

		streSubmitFn			: function() {

			$('[name=nowRowNum]').val(nowRowNum);
			$('[name=rowNum]').val(rowNum);


			if (!this.chkEmptyFn()) {
				return;
			}

			if (!this.chkThumbFlFn()) {
				return;
			}

			frm = document.bbsForm;
			var act = '${searchVO.act}';

			<c:if test="${ufn:getProhibitRegEx() ne ''}" >
				var prohibitRegEx = /${ufn:getProhibitRegEx()}/gi;
				if (prohibitRegEx.test(frm.bdTitle.value)) {
					alert("제목에 금지어를 포함하고 있습니다.");
					return false;
				}
				prohibitRegEx = /${ufn:getProhibitRegEx()}/gi;
			</c:if>

			if(Validator.validate(frm)){

				for (var x = 1; x < nowRowNum; x++) {
					myeditor[x].outputBodyText();
					myeditor[x].outputBodyHTML();
				}

				if (act  == "UPDATE" ) {
					frm.action = "/_mngr_/module/${menuCode}_update_newsletter.do?schM=update";
				} else {
					frm.action = "/_mngr_/module/${menuCode}_proc_newsletter.do?schM=proc";
				}

				frm.submit();
			}

		},

		chkThumbFlFn			: function() {
			var bool		= true,
				nlThumbVal = $("#nlThumb1").val();
				oldNlThumbVal = $("#oldNlThumb1").val();

			if (bool === true && nlThumbVal === "" && oldNlThumbVal === "") {
				alert("썸네일 파일 업로드는 필수입니다.")

				bool = false;
			}

			return bool;
		},


		chkEmptyFn				: function() {
			var bool	= true;

			$(".empty").each(function() {
				var $this 			= $(this),
				    removeBlankData	= $this.val().replace(/(\s*)/g, "");

				$this.val(removeBlankData);

				if (bool === true && $this.val() === "") {
					alert($this.data("name") + " 은/는 입력 값입니다.")
					$this.focus();

					bool = false;
				}

			});

			return bool;
		}
}

var manageCntntInput = {

	aditRowFn			: function(no) {
		$("#cntnt").append(
							"<tr>" +
								"<td rowspan='2'><input type='checkbox' id='chk" + nowRowNum + "' name='chkId' value='" + nowRowNum + "' title='선택' /></td>" +
								"<td><input type='text' id='nlaSubject" + nowRowNum + "' name='nlaSubject" + nowRowNum + "' class='required form-control input-sm' style='width:100%;' /></td>" +
							"</tr>" +
							"<tr>" +
								"<td><textarea id='nlaContent" + nowRowNum + "' name='nlaContent" + nowRowNum + "' class='form-control' title='상세내용' style='width:100%; height:300px;'></textarea></td>" +
							"</tr>");

		        // 에디터 개체를 생성합니다.
        myeditor[nowRowNum].config.editorHeight = '300px';     // 에디터 세로폭입니다.
        myeditor[nowRowNum].config.editorWidth = '100%';        // 에디터 가로폭입니다.
        myeditor[nowRowNum].config.editorBgColor  = '#ffffff'; 	// 에디터 기본배경색입니다.
        myeditor[nowRowNum].inputForm = 'nlaContent' + nowRowNum;           // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
        myeditor[nowRowNum].run();                             // 에디터를 실행합니다. */

		nowRowNum++;
		rowNum++;

	},

	deleteRowFn			: function() {
		var i = 0;
		$('input[name=chkId]').each(function(){
			if(this.checked){
				i = i + 1;
			}
		});

		if(i < 1){
			alert("삭제할 게시물을 선택 해 주세요.");
			return false;
		}

		$('input[name=chkId]').each(function(){
			   if(this.checked){
			    	var clickedRow = $(this).parent().parent();
			    	var clickedRowNext = $(this).parent().parent().next();
			    	clickedRowNext.remove();
			    	clickedRow.remove();
			   }
		});
	}
}

$(function(){
	registCnInput.init();
	registCnInput.chkThumbTypeFn();

	ItgJs.fn_datePickerRange("#nlUseSdt", "#nlUseEdt");
})

</script>

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
							<form name="bbsForm" id="bbsForm" method="post" enctype="multipart/form-data">
								<input type="hidden" name="schStr" value="<c:out value='${searchVO.schStr }' />" />
								<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
								<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount }" />" />
								<input type="hidden" name="act" value="<c:out value="${searchVO.act}" />" />
								<input type="hidden" name="mode" value="${ufn:deCode(searchVO.act,'REGIST,insert,UPDATE,update,REPLY,reply', '')}" />
								<input type="hidden" name="nowRowNum" />
								<input type="hidden" name="rowNum" />
								<input type="hidden" name="nlIdx" value="<c:out value="${result.nlIdx }" />" />
								<input type="hidden" name="oldNlThumb1" id="nlThumb1" value="<c:out value="${result.nlThumb1 }" />" />
							<table class="table table-bordered tp2">
								<colgroup>
									<col style="width:15%"/>
									<col style="width:30%"/>
									<col style="width:15%"/>
									<col style="width:35%"/>
								</colgroup>
								<tbody>
									<tr>
										<th class="t"><label for="nlTitle">제목</label></th>
										<td colspan="3">
											<input type="text" name="nlTitle" id="nlTitle" class="required form-control input-sm f-wd-600" value="<c:out value="${result.nlTitle }"/>" maxlength="50" title="제목" />
										</td>
									</tr>
									<tr>
										<th class="t"><label for="nlCharger">담당자</label></th>
										<td colspan="3">
											<input type="text" name="nlCharger" id="nlCharger" class="required form-control input-sm f-wd-600" value="<c:out value="${result.nlCharger }"/>" maxlength="50" title="담당자" />
										</td>
									</tr>
									<tr>
									<c:set var="file" value="${result.nlThumb1 }" />
									<c:set var="alt" value="${result.nlThumb1Alt }" />
	                     				<th class="t"><label for="nlThumb1">썸네일 이미지</label></th>
		                     				<td>
		                     					<div>
													<c:choose>
														<c:when test="${not empty file }">
															<img id="previewImg" src="<c:url value='/comm/download.do?f=${ufn:getDownloadLink("","newsletter",file,file) }' />" alt="<c:out value='${ufn:quot(alt) }' />" width="200"/>
														</c:when>
														<c:otherwise>
															<img id="previewImg" src="" alt="" width="200">
														</c:otherwise>
													</c:choose>
												</div>
	                							<input type="file" id="nlThumb1" name="nlThumb1" class="validate-is-image" onchange="fn_changePhoto(this)" title="썸네일첨부" accept="image/png, image/jpeg"/>
											</td>
										<th class="t"><label for="nlThumb1Alt">대체 텍스트</label></th>
										<td>
											<textarea id="nlThumb1Alt" name="nlThumb1Alt"  class=" form-control required" maxlength="250" title="대체 텍스트"><c:out value="${alt}" /></textarea>
										</td>
									</tr>
								<tr>
									<th class="t"><label for="fileRelateId">비즈플라자 PDF</label></th>
									<td colspan="3">
										<!-- 파일업로드 폼 추가 시작 -->
										<c:import  url="/afile/fileuploadForm.do">
											<c:param name="formName" value="bbsForm" />
											<c:param name="objectId" value="upload1" />
											<c:param name="fileIdName" value="fileId" />
											<c:param name="fileIdValue" value="${result.fileId}" />
											<c:param name="fileTypes" value="pdf" />
											<c:param name="maxFileSize" value="50" />
											<c:param name="maxFileCount" value="1" />
											<c:param name="useSecurity" value="false" />
											<c:param name="uploadMode" value="db" />
										</c:import>
										<!-- 파일업로드 폼 추가 끝 -->
									</td>
								</tr>
									<tr>
										<th class="t"><label for="">기사제목</label>
											</br>
											<button type="button" onclick="manageCntntInput.aditRowFn()" class="btn btn-primary">추가</button>
											<button type="button" onclick="manageCntntInput.deleteRowFn()" class="btn btn-danger">삭제</button>
										</th>
										<td colspan="3" class="">
											<table class="table table-bordered tp2">
												<colgroup>
													<col width="20">
													<col>
												</colgroup>
												<tbody id="cntnt">
													<c:forEach items="${resultArticleList }" var="listMap" varStatus="status">
														<tr>
															<td rowspan='2'><input type="checkbox" id="chk${status.count }" name='chkId' /></td>
															<td><input type="text" id="nlaSubject${status.count }" name="nlaSubject${status.count }" class='required form-control input-sm' style='width:100%;' value="${listMap.nlaSubject }"/></td>
														</tr>
														<tr>
															<td>
																<textarea id="nlaContent${status.count }" name="nlaContent${status.count }" class='form-control' title='상세내용' style='width:100%; height:300px;'>
																	<c:out value="${ufn:decodeXss(listMap.nlaContent)}" escapeXml="false" />
																</textarea>
												                	<script type="text/javascript">

													            	myeditor[${status.count }].config.editorHeight = '300px';     // 에디터 세로폭입니다.
													            	myeditor[${status.count }].config.editorWidth = '100%';        // 에디터 가로폭입니다.
													            	myeditor[${status.count }].config.editorBgColor  = '#ffffff'; 	// 에디터 기본배경색입니다.
													            	myeditor[${status.count }].inputForm = 'nlaContent${status.count}';           // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
													            	myeditor[${status.count }].run();                             // 에디터를 실행합니다.
																	</script>
															</td>

														</tr>
													</c:forEach>
												</tbody>
											</table>
										</td>
									</tr>
									<tr>
										<th class="t"><label for="nlUseyn">게시여부</label></th>
										<td colspan="3">
											<div class="form-inline">
												<input type="radio" class="minimal" name="nlUseyn" id="nlUseyn1" value="Y" ${ufn:checked(result.nlUseyn, 'Y')} ${ufn:checked(result.nlUseyn, '')}/><label for="nlUseyn1">사용</label>
												<input type="radio" class="minimal" name="nlUseyn" id="nlUseyn2" value="N" ${ufn:checked(result.nlUseyn, 'N')}/><label for="nlUseyn2">중지</label>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

												<input type="checkbox" name="nlUseTermyn" id="nlUseTermyn" value="Y" ${ufn:checked(result.nlUseTermyn, 'Y') } onclick="if(this.checked){$('#nlUseSdt,#nlUseEdt').addClass('required validate-date');}else{$('#nlUseSdt,#nlUseEdt').removeClass('required validate-date');}" /><label for="nlUseTermyn">기간설정 사용</label>
												<input type="text" name="nlUseSdt" id="nlUseSdt" maxlength="10" title="게시기간 시작일" value="<c:out value="${result.nlUseSdt }" />" class="form-control input-sm f-wd-100" readonly="readonly" />
				                                    &nbsp;&nbsp;~&nbsp;&nbsp;
												<input type="text" name="nlUseEdt" id="nlUseEdt" maxlength="10" title="게시기간 종료일" value="<c:out value="${result.nlUseEdt}" />" class="form-control input-sm f-wd-100" readonly="readonly"  />
											</div>
										</td>
									</tr>
									<c:if test="${searchVO.act eq 'UPDATE' }">
										<tr>
											<th class="t"><span>등록자 정보</span></th>
											<td colspan="3"><strong>아이디 : </strong><c:out value="${result.regmemid }" />, <strong>등록일 : </strong><c:out value="${result.regdt }" /></td>
										</tr>
										<c:if test="${not empty result.updmemid }">
											<tr>
												<th class="t"><span>수정자 정보</span></th>
												<td colspan="3"><strong>아이디 : </strong><c:out value="${result.updmemid }" />, <strong>수정일 : </strong><c:out value="${result.upddt }" /></td>
											</tr>
										</c:if>
									</c:if>
								</tbody>
							</table>
							</form>
						</div><!-- /.col -->
					</div><!-- /inner row -->



					<div class="body-footer" id="footerButtons">
						<div class="pull-right">
								<button type="button" onclick="registCnInput.streSubmitFn()" class="btn btn-primary">저장</button>
							<c:if test="${searchVO.act eq 'UPDATE'}">
								<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
							</c:if>
								<button type="button" onclick="fn_goList(); return false;" class="btn btn-default">목록</button>
						</div>
					</div><!-- /.body-footer -->
			</div><!-- /.box-body -->

		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->