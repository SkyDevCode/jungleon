<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
<form name="form1" id="form1" method="post">
		<input type="hidden" name="menuCode" value="<c:out value="${menuCode}" />" />
		<input type="hidden" name="menuMemo" id="menuMemo" value="<c:out value="${result.menuMemo}" />" />
			<div class="row">
				<div class="col-xs-12 table-responsive">
					<table class="table table-bordered tp2">
						<colgroup>
							<col style="width:25%"/>
							<col/>
							<col/>
						</colgroup>
						<tbody>
							<tr>
								<th class="t"><span>메뉴 타입</span></th>
								<td class="bdrn">
									<c:out value="${ufn:deCode(result.menuType, '0,폴더,1,CMS 컨텐츠,2,프로그램,3,게시판,4,링크,5,컨텐츠 없음,revision,CMS 컨텐츠(리비전)', '-') }" />
								</td>
								<td class="bdln">
									<div class="pull-right">
									<span id="temporarySaveResult" style="margin-right: 20px;">
									<c:if test="${tempSaved != null and tempSaved.regdt != ''}">
										<c:out value="${ufn:printDatePattern(tempSaved.regdt, 'yyyy-MM-dd HH:mm:ss')}"/>에 임시저장 된 글이 있습니다.
									</c:if>
									</span>
									<c:if test="${tempSaved != null and tempSaved.regdt != ''}">
									<button type="button" onclick="callTemporaryContents();" class="btn btn-warning btn-sm">불러오기</button>
									<button type="button" onclick="resetContents();" class="btn btn-warning btn-sm">되돌리기</button>
									</c:if>
									<button type="button" onclick="temporarySave();" class="btn btn-info btn-sm">임시저장</button>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<textarea id="menuContents" name="menuContents" title="컨텐츠 내용" class="required"><c:out value="${result.menuContents }" /></textarea>
									<script type="text/javascript">
										var myeditor = new cheditor();              // 에디터 개체를 생성합니다.
										myeditor.config.editorHeight = '450px';     // 에디터 세로폭입니다.
										myeditor.config.editorWidth = '100%';        // 에디터 가로폭입니다.
										myeditor.config.splitUse = true;			// 버튼을 두줄로 나눠주는 용
										myeditor.config.usePreview = false;         // 미리보기 버튼을 사용하지 않습니다.
										myeditor.config.usePrint = true;			// 인쇄 버튼을 사용합니다.
										myeditor.config.useNewDocument = true;		// 새문서 버튼을 사용합니다.
										myeditor.config.useUndo = true;				// 되돌리기 버튼을 사용합니다.
										myeditor.config.useRedo = true;				// 다시 실행 버튼을 사용합니다.
										myeditor.config.useStrikethrough = true;	// 취소선 버튼을 사용합니다.
										myeditor.config.useUnderline = true;		// 밑줄 버튼을 사용합니다.
										myeditor.config.useItalic = true;			// 이탤릭체 버튼을 사용합니다.
										myeditor.config.useJustifyLeft = true;		// 좌측정렬 버튼을 사용합니다.
										myeditor.config.useJustifyCenter = true;	// 중앙정렬 버튼을 사용합니다.
										myeditor.config.useJustifyRight = true;		// 우측정렬 버튼을 사용합니다.
										myeditor.config.useJustifyFull = true;		// 양쪽정렬 버튼을 사용합니다.
										myeditor.config.useOrderedList = true;		// 문단번호 버튼을 사용합니다.
										myeditor.config.useUnOrderedList = true;	// 글머리표 버튼을 사용합니다.
										myeditor.config.useOutdent = true;			// 왼쪽여백 줄이기 버튼을 사용합니다.
										myeditor.config.useIndent = true;			// 왼쪽여백 늘이기 버튼을 사용합니다
										myeditor.config.useFontName = true;			// 글꼴 버튼을 사용합니다.
										myeditor.config.useFormatBlock = true;		// 스타일 버튼을 사용합니다.
										myeditor.config.useFontSize = true;			// 글꼴 크기 버튼을 사용합니다.
										myeditor.config.useLineHeight = true;		// 줄간격 버튼을 사용합니다
										myeditor.config.useBackColor = true;		// 형광펜 버튼을 사용합니다.
										myeditor.config.useRemoveFormat = true;		// 서식 지우기 버튼을 사용합니다.
										myeditor.config.useClearTag = true;			// 태그 지우기 버튼을 사용합니다.
										myeditor.config.useSmileyIcon = true;		// 표정 아이콘 버튼을 사용합니다.
										myeditor.inputForm = 'menuContents';             // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
										myeditor.run();                             // 에디터를 실행합니다.
									</script>
								</td>
							</tr>
							<c:if test="${result.revisionNum > 1}">
								<tr>
									<th class="t"><span>리비전 개수</span></th>
									<td class="bdrn">${result.revisionNum}</td>
									<td class="bdln"><button type="button" onclick="revisionList();" class="pull-right btn btn-default btn-sm">리비전 목록 보기</button></td>
								</tr>
							</c:if>
							<c:if test="${isRevision}">
								<tr>
									<th class="t"><span>리비전 정보</span></th>
									<td class="bdrn">${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd HH:mm:ss')}에 작성한 글입니다.</td>
									<td class="bdln">
										<button type="button" onclick="revisionDelete(${result.id});" class="pull-right btn btn-danger btn-sm">리비전 삭제</button>
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div><!-- /.col -->
			</div><!-- /inner row -->
			<div class="pull-right">
				<c:if test="${result.revisionNum > 1||opt2 eq '설문조사미리보기'}">
					<button  type="button" class="btn btn-success" onclick="contentsPreview('${result.menuCode}')">미리보기</button>
				</c:if>
				<c:if test="${result.revisionNum < 1}">
					<button  type="button" class="btn btn-success" onclick="Previewnull()">미리보기</button>
				</c:if>
				<c:if test="${result.revisionNum == 1&&opt2 ne '설문조사미리보기'}">
					<button  type="button" class="btn btn-success" onclick="contentsPreview1('${result.menuCode}')">미리보기</button>
				</c:if>
				<c:choose>
					<c:when test="${result.revisionLogNum > 0}">
						<button type="submit" onclick="fn_save('edit')" class="btn btn-primary">${isRevision ? '현재 리비전 반영하기' : '저장'}</button>
					</c:when>
					<c:otherwise>
						<button type="submit" onclick="fn_save('input')" class="btn btn-primary">등록</button>
					</c:otherwise>
				</c:choose>
            </div>
			<div style="display: none;" id="temporaryHtml">
				<c:out value="${tempSaved == null ? '' : tempSaved.menuContents}"/>
			</div>
	</form>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->

<script type="text/javascript">
//<![CDATA[

var tmpStr = $("#menuContents").val();
var tempVal = $("#temporaryHtml").text().trim();
$("#temporaryHtml").remove();
function callTemporaryContents() {
	if (myeditor) {
		if (confirm("임시 저장 내용을 불러오시겠습니까?")) {
			tmpStr = myeditor.outputBodyHTML();
			myeditor.putContents("");
			myeditor.insertHTML(tempVal);
			//myeditor.putContents(myeditor.outputBodyText());
		}
	}
}

var resetment = "임시 저장 내용을 불러오기 전";
function resetContents() {
	if (confirm("컨텐츠를 \""+resetment+"\"(으)로 되돌립니다.\n실행하시겠습니까?")) {
		myeditor.putContents(tmpStr);
	}
}


var temporarySaveInterval = setInterval(function(){
	temporarySave();
}, 1000*60*5);


function temporarySave(callback){
	$("#menuMemo").val(myeditor.outputBodyText());
	$("#menuContents").val(myeditor.outputBodyHTML());
	$.ajax({
		url : "/_mngr_/contents/contents_comm_temporarySave_proc.do",
		data : $(document.form1).serialize(),
		type : "POST",
		success : function(data){
			$("#temporarySaveResult").html(data.date + "에 임시 저장되었습니다.");
			tempVal = data.contents;
			if (callback) {
				callback();
			}
		},
		error : function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}



function fn_save(act){
	var frm = document.form1;
	$("#menuMemo").val(myeditor.outputBodyText());
	$("#menuContents").val(myeditor.outputBodyHTML());
	if(Validator.validate(frm)){
		if(confirm("저장하시겠습니까?")){
			if(act == "input"){
				frm.action="/_mngr_/contents/${menuCode}_input_proc.do";
			}else{
				frm.action="/_mngr_/contents/${menuCode}_edit_proc.do";
			}
			frm.submit();
		}
	}
}
//var queryStr = "${mngrMenuVO.query}";
function revisionList(){
	var frm = document.form1;
	frm.action="/_mngr_/contents/${menuCode}_list_revision.do";
	frm.submit();
}

function revisionDelete(idx){
	var totCnt = ${result.revisionNum};
	if(totCnt > 1){
		var frm = document.form1;
		frm.action="/_mngr_/contents/${result.menuCode}_delete_revision_proc.do?chkId="+idx;
		frm.submit();
	}else{
		alert("리비전은 2개 이상일 경우 삭제가능합니다.");
		return false;
	}
}

function Previewnull(){
	 var frm = document.form1;
		$("#menuMemo").val(myeditor.outputBodyText());
		$("#menuContents").val(myeditor.outputBodyHTML());
		if(Validator.validate(frm)){
			if(confirm("리비전이 없어서 저장을 한 후 미리보기가 가능합니다. \n저장을 하시겠습니까?")){
				frm.action="/_mngr_/contents/${menuCode}_input_proc.do";
				frm.submit();
			}
		}

}
function contentsPreview1(code){
	temporarySave();
	var popOption = "width=900, height=800, resizable=no, scrollbars=no, status=no;";
	window.open(encodeURI("/${result.siteCode}/popContents.do?opt2=preview&url=/contents/"+code+"_view_preview.do"), "", popOption);

}
function contentsPreview(code){
	 if(confirm("임시 저장을 한 후 미리보기가 가능합니다. \n임시 저장을 하시겠습니까?")){
		temporarySave(function(){
			var popOption = "width=900, height=800, resizable=no, scrollbars=no, status=no;";
			window.open(encodeURI("/${result.siteCode}/popContents.do?opt2=preview&url=/contents/"+code+"_view_preview.do"), "", popOption);

		});
	}
}

//]]>
</script>
