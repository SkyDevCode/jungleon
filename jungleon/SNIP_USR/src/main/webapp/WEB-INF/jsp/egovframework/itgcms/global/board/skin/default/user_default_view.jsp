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
 * @파일명 : user_default_view.jsp
 * @파일정보 : 일반형게시판
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @hsk1218 2020. 4. 14. 최초생성
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
var checkFlag = false;
var query = "<c:out value="${searchVO.query}" escapeXml="false" />";

$(document).ready(function(){
});

function fn_goList(){
	query = ItgJs.fn_replaceQueryString(query, "id", "");
	query = ItgJs.fn_replaceQueryString(query, "schM", "list");
//	location.href="/user/board/${menuCode}_list_${bcid}.do?" + query
	location.href="?" + query
}

function fn_goView(id){
	query = ItgJs.fn_replaceQueryString(query, "id", id);
	query = ItgJs.fn_replaceQueryString(query, "schM", "view");
//	location.href="/user/board/${menuCode}_view_${bcid}.do?" + query
	location.href="?" + query
}
//]]>
</script>

<!-- 게시판상세 -->
<div class="board-wrap">
    <div class="board-view">
        <div class="view-info">
	            <strong class="title">
	                 <c:choose>
						<c:when test="${ufn:printDatePattern(boardMap.regdt, 'yyyy-MM-dd')>'2020-06-14'}">
							 <c:out value="${boardMap.bdTitle }" />
						</c:when>
						<c:otherwise>
							  <c:out value="${boardMap.bdTitle }" escapeXml="false"/>
						</c:otherwise>
					</c:choose>
            	</strong>
            <div class="other-info">
            <c:if test="${boardconfigVO.bcGroupyn eq 'Y' }">
				<span>분류 : <c:out value="${boardMap.bdCodeName }" /></span>
			</c:if>
                <span>담당자 : <c:out value="${boardMap.charger }" /></span>
                <span>작성일 : <c:out value="${ufn:printDatePattern(boardMap.regdt, 'yyyy-MM-dd')}" /> </span>
                <span>조회수 : <fmt:formatNumber value="${boardMap.bdReadnum }" /> </span>
            </div>
        </div><!--// view-info-->
		<div class="file-list">
            <dl>
                <dt>
                   	 첨부파일
     	       	</dt>
                <dd>
					<!-- 파일다운로드 폼 추가 시작 -->
					<c:import  url="/afile/filedownForm.do">
						<c:param name="formName" value="bbsForm" />
						<c:param name="objectId" value="download1122" />
						<c:param name="fileIdName" value="fileId" />
						<c:param name="fileIdValue" value="${boardMap.fileId}" />
						<c:param name="useSecurity" value="false" />
						<c:param name="uploadMode" value="db" />
					</c:import>
					<!-- 파일다운로드 폼 추가 끝  -->
                </dd>
            </dl>
        </div>
		<div class="view-content">
		<c:choose>
			<c:when test="${ufn:printDatePattern(boardMap.regdt, 'yyyy-MM-dd')>'2020-06-14'}">
				<c:choose>
				<c:when test="${boardMap.bdHtmlyn eq 'Y'}">
					<c:out value="${ufn:decodeXss(boardMap.bdContent)}" escapeXml="false" />
				</c:when>
				<c:otherwise>
					<c:out value="${ufn:stripXss(boardMap.bdContent) }" escapeXml="false" />
				</c:otherwise>
			</c:choose>
			</c:when>
			<c:otherwise>
				 <pre>${boardMap.bdContent}</pre>
			</c:otherwise>
		</c:choose>
		</div>
		<!--// view-content-->
		<!-- <div class="btn-wrap btn-appli">
			<a href="#" class="btn btn-blueline icon-check btn-block">신청하기</a>
			<a href="#" class="btn btn-blueline icon-book btn-block">세무회계 온라인제출</a>
		</div> -->
		<div class="btn-board_bottom">
			<a href="#" class="btn btn-list list-icon" onclick="fn_goList();return false;">목록</a>
		</div>
		<c:if test="${boardconfigVO.bcPrevnextyn eq 'Y' }">
			<div class="board-bottom">
				<ul class="prev-next-wrap">
		              <li class="prev">
		                  <strong>이전글</strong>
		                  <c:choose>
							<c:when test="${not empty prevBoardVO }">
								<a href="#none" onclick="fn_goView(${prevBoardVO.bdIdx}); return false;"><span>
								  <c:choose>
									<c:when test="${ufn:printDatePattern(boardMap.regdt, 'yyyy-MM-dd')>'2020-06-14'}">
										 <c:out value="${prevBoardVO.bdTitle }" />
									</c:when>
									<c:otherwise>
										  <c:out value="${prevBoardVO.bdTitle }" escapeXml="false"/>
									</c:otherwise>
								</c:choose>
								</span></a>
							</c:when>
							<c:otherwise>
								<a href="#none">이전글이 없습니다.</a>
							</c:otherwise>
						</c:choose>
		              </li>
		              <li class="next">
		                  <strong>다음글</strong>
		                  <c:choose>
							<c:when test="${not empty nextBoardVO }">
								<a href="#none" onclick="fn_goView(${nextBoardVO.bdIdx}); return false;"><span>
								<c:choose>
									<c:when test="${ufn:printDatePattern(boardMap.regdt, 'yyyy-MM-dd')>'2020-06-14'}">
										 <c:out value="${nextBoardVO.bdTitle }" />
									</c:when>
									<c:otherwise>
										  <c:out value="${nextBoardVO.bdTitle }" escapeXml="false"/>
									</c:otherwise>
								</c:choose></span></a>
							</c:when>
							<c:otherwise>
								<a href="#none">다음글이 없습니다.</a>
							</c:otherwise>
						</c:choose>
		              </li>
				</ul><!--// prev-next-wrap-->
			</div>
		</c:if>

    </div>
</div>

