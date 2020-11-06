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
 * @파일명 : user_custom_view.jsp
 * @파일정보 : 일반형 게시판 사용자 상세보기
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
<script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>
<script type="text/javascript">
//<[[!CDATA[
var query = "<c:out value="${searchVO.query}" escapeXml="false" />";

$(document).ready(function(){
});

function fn_goList(){
	query = ItgJs.fn_replaceQueryString(query, "id", "");
	query = ItgJs.fn_replaceQueryString(query, "schM", "list");
	location.href="?" + query;
}

function fn_goView(id){
	query = ItgJs.fn_replaceQueryString(query, "id", id);
	query = ItgJs.fn_replaceQueryString(query, "schM", "view");
	location.href="?" + query;
}
//]]>
</script>

<form name="form1" id="form1" method="post">
	<input type="hidden" name="mode" value="" />
</form>

<div class="boardView">
	<h3><c:out value="${boardMap.bdTitle }" /></h3>
<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
	<dl class="infor">
		<dt class="t">구분</dt>
		<dd class="writer"><c:out value="${boardMap.bdCodeName }" /></dd>
	</dl>
</c:if>
	<dl class="infor">
		<dt class="t">작성자</dt>
		<dd class="writer"><c:out value="${boardMap.bdWriter }" /></dd>
		<dt class="t">작성일</dt>
		<dd class="date"><c:out value="${ufn:printDatePattern(boardMap.regdt, 'yyyy-MM-dd HH:mm:ss') }" /></dd>
		<dt class="t">조회수</dt>
		<dd class="count"><c:out value="${boardMap.bdReadnum }" /></dd>
	</dl>
<c:if test="${isMobile }">
	<div class="m_info">
		<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }"><span class="sort"><c:out value="${boardMap.bdCodeName }" /></span></c:if>
		<span class="writer">작성자 : <c:out value="${boardMap.bdWriter }" /></span>
		<span class="date">작성일 : <c:out value="${ufn:printDatePattern(boardMap.regdt, 'yyyy-MM-dd hh:mm:ss') }" /></span>
	</div>
</c:if>
<c:forEach var="column" items="${customColumnList}" varStatus="status">
	<c:choose>
		<c:when test="${column.code eq 'bdContent'}">
	<div class="txt">
			<c:choose>
				<c:when test="${boardconfigVO.bcEditoryn eq 'Y'}">
					<c:out value="${ufn:decodeXss(boardMap.bdContent)}" escapeXml="false" />
				</c:when>
				<c:otherwise>
					<c:out value="${ufn:stripXss(boardMap.bdContent) }" escapeXml="false" />
				</c:otherwise>
			</c:choose>
	</div>
		</c:when>
		<c:when test="${column.code eq 'fileId'}">
	<div class="txt">
			<c:if test="${boardconfigVO.bcFileyn eq 'Y' and not empty boardMap.fileId }" >
			<%-- src/main/webapp/WEB-INF/jsp/egovframework/com/ext/jfile/jfiledownloadForm.jsp 폼이 로딩 된다. --%>
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
			</c:if>
	</div>
		</c:when>
		<c:when test="${column.code eq 'bdThumb'}">
	<div class="txt">
			<c:forEach var="i" begin="1" end="${boardconfigVO.bcThumbcount }">
				<c:set var="file" value="${boardMap['bdThumb'.concat(i)]}" />
				<c:set var="alt" value="${boardMap['bdThumb'.concat(i).concat('Alt')]}" />
				<c:if test="${not empty file }">
		<dl>
			<%-- <dt class="t"><label for="bdThumb${i}"><c:out value="${column.name}"/>${i}</label></dt> --%>
			<dd>
				<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','gallery',file,file) }" />" alt="<c:out value="${ufn:quot(alt) }" />" />
			</dd>
		</dl>
				</c:if>
			</c:forEach>
	</div>
		</c:when>
		<c:otherwise>
			<c:if test="${column.used eq 'Y'}">
	<div class="txt">
		<%-- <p class="t"><c:out value="${column.name}" /></p> --%>
		<c:if test="${column.type eq 'columnType01'}">
			<c:out value="${boardMap[column.code]}" />
		</c:if>
		<c:if test="${column.type eq 'columnType02'}">
			<c:out value="${ufn:stripXss(boardMap[column.code]) }" escapeXml="false" />
		</c:if>
		<c:if test="${column.type eq 'columnType03'}">
			<c:out value="${ufn:decodeXss(ufn:getLobContents(boardMap.bdIdx,column.code))}" escapeXml="false" />
		</c:if>
		<c:if test="${column.type eq 'columnType04'}">
			<c:out value="${boardMap[column.code]}" />
		</c:if>
	</div>
			</c:if>
		</c:otherwise>
	</c:choose>
</c:forEach>
<c:if test="${boardconfigVO.bcComment eq 1 && searchVO.schM eq 'view'}">
	<jsp:include page="../boardReple.jsp"/>
</c:if>

<c:if test="${boardconfigVO.bcPrevnextyn eq 'Y' }">
	<dl class="pnList">
		<dt class="p">이전글</dt>
		<dd>
			<c:choose>
				<c:when test="${not empty prevBoardVO }">
					<a href="#none" onclick="fn_goView(${prevBoardVO.bdIdx}); return false;"><c:out value="${prevBoardVO.bdTitle }" /></a>
				</c:when>
				<c:otherwise>
										이전글이 없습니다.
				</c:otherwise>
			</c:choose>
		</dd>
	</dl>

	<dl class="pnList last">
		<dt class="d">다음글</dt>
		<dd>
			<c:choose>
				<c:when test="${not empty nextBoardVO }">
					<a href="#none" onclick="fn_goView(${nextBoardVO.bdIdx}); return false;"><c:out value="${nextBoardVO.bdTitle }" /></a>
				</c:when>
				<c:otherwise>
										다음글이 없습니다.
				</c:otherwise>
			</c:choose>
		</dd>
	</dl>
</c:if>
</div>
<div class="boardBtnBox">
	<ul class="list_btn">
<c:if test="${boardAuthVO.update eq true and (ufn:getUserSessionVO().id eq boardMap.regmemid or '' eq boardMap.regmemid)}">
		<script type="text/javascript">
			function fn_goUpdate(){
				query = ItgJs.fn_replaceQueryString(query, "schM", "edit");
//				location.href="/user/board/${bcid}_update.do?" + query
				location.href="?" + query;
			}

			function fn_goDelete(){
				if(confirm("정말로 삭제하시겠습니까?\n삭제된 데이터는 복구 할 수 없습니다.\n삭제하시려면 [확인]을 클릭하세요.")){
					query = ItgJs.fn_replaceQueryString(query, "mode", "delete");
					query = ItgJs.fn_replaceQueryString(query, "siteCode", "${siteCode}");
					location.href="/user/board/${menuCode}_proc_${bcid}.do?" + query;
				}
			}
		</script>
		<li class="update"><a href="#none" onclick="fn_goUpdate();">저장</a></li>
		<li class="delete"><a href="#none" onclick="fn_goDelete();">삭제</a></li>
</c:if>
<c:if test="${boardconfigVO.bcReplyyn eq 'Y' and boardAuthVO.reply eq true }">
		<script type="text/javascript">
			function fn_goReply(){
				query = ItgJs.fn_replaceQueryString(query, "schM", "reply");
//				location.href="/user/board/${menuCode}_reply_${bcid}.do?" + query
				location.href="?" + query;
			}
		</script>
		<li class="update"><a href="#none" onclick="fn_goReply();">답글</a></li>
</c:if>
		<li class="list"><a href="#none" onclick="fn_goList();return false;">목록</a></li>
	</ul>
</div>
