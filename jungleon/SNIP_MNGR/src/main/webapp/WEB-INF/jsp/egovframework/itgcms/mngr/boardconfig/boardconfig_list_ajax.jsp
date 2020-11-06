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
 * @파일명 : mngrBoardconfigListAjax.jsp
 * @파일정보 : 게시판관리 목록
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
<script>
var boardconfigList = [];
<c:forEach var="result" items="${resultList}" varStatus="status">
boardconfigList.push({
	"bcType": "${result.bcType}" ,
	"bcName": "${result.bcName}" ,
	"bcTopinfo": "${result.bcTopinfo}" ,
	"bcSkin": "${result.bcSkin}" ,
	"bcViewcount": "${result.bcViewcount}" ,
	"bcList": "${result.bcList}" ,
	"bcView": "${result.bcView}" ,
	"bcRegist": "${result.bcRegist}" ,
	"bcUpdate": "${result.bcUpdate}" ,
	"bcReply": "${result.bcReply}" ,
	"bcMngrList": "${result.bcMngrList}" ,
	"bcMngrView": "${result.bcMngrView}" ,
	"bcMngrRegist": "${result.bcMngrRegist}" ,
	"bcMngrUpdate": "${result.bcMngrUpdate}" ,
	"bcMngrReply": "${result.bcMngrReply}" ,
	"bcReplyyn" : "${result.bcReplyyn}" ,
	"bcFileyn" : "${result.bcFileyn}" ,
	"bcFilecount" : "${result.bcFilecount}" ,
	"bcFilesize" : "${result.bcFilesize}" ,
	"bcSecretyn" : "${result.bcSecretyn}" ,
	"bcNoticeyn" : "${result.bcNoticeyn}" ,
	"bcGroupyn" : "${result.bcGroupyn}" ,
	"bcEditoryn" : "${result.bcEditoryn}" ,
	"bcPrevnextyn" : "${result.bcPrevnextyn}" ,
	"bcRSS" : "${result.bcRSS}" ,
	"bcComment" : "${result.bcComment}" ,
	"bcKoglyn" : "${result.bcKoglyn}" ,
	"bcDefaultpage" : "${result.bcDefaultpage}",
	"bcThumbyn" : "${result.bcThumbyn}",
	"bcThumbwidth" : "${result.bcThumbwidth}",
	"bcThumbheight" : "${result.bcThumbheight}",
	"bcExtcolumninfo" : '<c:out value="${result.bcExtcolumninfo}" escapeXml="false"/>'
})
</c:forEach>
function fn_setBoardconfig(idx){
	if(confirm("설정한 내용이 사라집니다.\n선택 한 게시판 설정을 복사하시겠습니까?")){
		var bc = boardconfigList[idx];
		var f = document.bcform;
		var id = f.id.value;
		fn_setSkinOption(bc.bcSkin);
		f.bcName.value = bc.bcName;
		f.bcTopinfo.value = bc.bcTopinfo;
		f.bcSkin.value = bc.bcSkin;
		f.bcViewcount.value = bc.bcViewcount;
		f.bcList.value = bc.bcList;
		f.bcView.value = bc.bcView;
		f.bcRegist.value = bc.bcRegist;
		f.bcUpdate.value = bc.bcUpdate;
		f.bcReply.value = bc.bcReply;
		f.bcMngrList.value = bc.bcMngrList;
		f.bcMngrView.value = bc.bcMngrView;
		f.bcMngrRegist.value = bc.bcMngrRegist;
		f.bcMngrUpdate.value = bc.bcMngrUpdate;
		f.bcMngrReply.value = bc.bcMngrReply;
		f.bcReplyyn.value = bc.bcReplyyn;
		f.bcFileyn.value = bc.bcFileyn;
		f.bcFilecount.value = bc.bcFilecount;
		f.bcFilesize.value = bc.bcFilesize;
		f.bcSecretyn.value = bc.bcSecretyn;
		f.bcNoticeyn.value = bc.bcNoticeyn;
		//카테고리는 수정에서만 설정 가능
		if(id != ""){
			f.bcGroupyn.value = bc.bcGroupyn;
			changeGroupyn(f.bcGroupyn.value);
		}
		f.bcEditoryn.value = bc.bcEditoryn;
		f.bcPrevnextyn.value = bc.bcPrevnextyn;
		f.bcRSS.value = bc.bcRSS;
		f.bcComment.value = bc.bcComment;
		//f.bcKoglyn.value = bc.bcKoglyn;
		f.bcDefaultpage.value = bc.bcDefaultpage;
		f.bcThumbyn.value = bc.bcThumbyn;
		f.bcThumbwidth.value = bc.bcThumbwidth;
		f.bcThumbheight.value = bc.bcThumbheight;
		f.bcExtcolumninfo.value = bc.bcExtcolumninfo;

		//설정값이 Y일 경우 상세 설정 show
		changeReplyyn(f.bcReplyyn.value);
		changeFileyn(f.bcFileyn.value);
		changeThumbyn(f.bcThumbyn.value);
		fn_setCusColumn();

		alert("설정을 적용이 완료되었습니다.");
		$('#modalCopyContent').modal('hide')
	}

}
</script>
<div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">게시판 설정 가져오기</h4>
		  </div>
		  <div class="modal-body">
			  	<table id="example1" class="table table-bordered">
		        	<colgroup>
						<col width="*%" />
						<col width="20%" />
						<col width="30%" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">게시판 이름</th>
							<th scope="col">게시판 아이디</th>
							<th scope="col">게시판 스킨</th>
							<th scope="col">선택</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><c:out value="${result.bcName }" /></td>
							<td><c:out value="${result.bcId}" /></td>
							<td><c:out value="${skinResult[result.bcSkin]}" /></td>
							<td class="tac"><a href="#none" onclick="fn_setBoardconfig('${status.index}');return false;">설정 가져오기</a></td>
						</c:forEach>
						<c:if test="${fn:length(resultList ) == 0}">
							<tr><td colspan="4" class="tac">데이터가 없습니다.</td></tr>
						</c:if>
					</tbody>
		      </table>
		  </div>
		</div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
