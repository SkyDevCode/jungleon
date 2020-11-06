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
 * @파일명 : user_movie_view.jsp
 * @파일정보 : 사용자 동영상 게시판 조회 스킨
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

  <!-- 게시판리스트 -->
               <!-- 게시판상세 -->
<div class="board-wrap">
     <div class="board-view">
         <div class="view-info">
	        <strong class="title"><c:out value="${boardMap.bdTitle }" /></strong>
            <div class="other-info">
                <span class="manage">담당자 : <c:out value="${boardMap.charger }" /></span>
                <span>작성일 : <c:out value="${ufn:printDatePattern(boardMap.regdt, 'yyyy-MM-dd')}" /> </span>
                <span>조회수 : <fmt:formatNumber value="${boardMap.bdReadnum }" /> </span>
            </div>
   		</div><!--// view-info-->

		<div class="view-content">
		     <%--  <c:if test="${boardconfigVO.bcThumbyn eq 'Y' }">
				  <c:forEach var="i" begin="1" end="${boardconfigVO.bcThumbcount }">
				    <c:set var="file" value="" />
				    <c:set var="alt" value="" />
				    <c:choose>
				      <c:when test="${i eq 1 }">
				        <c:set var="file" value="${boardMap.bdThumb1 }" />
				        <c:set var="alt" value="${boardMap.bdThumb1Alt }" />
						<p>
						<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','gallery',file,file) }" />" alt="<c:out value="${ufn:quot(alt) }" />"/>
						<c:choose>
							<c:when test="${fn:contains(file,'WEBROOT_NEW')}">
								<img src="<c:url value="/comm/viewImage2.do?f=${ufn:getDownloadLink('','gallery',file,'thumb') }" />" class="img" alt="<c:out value="${ufn:quot(alt) }" />">
							</c:when>
							<c:otherwise>
						        <img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','gallery',file,'thumb') }" />" class="img" alt="<c:out value="${ufn:quot(alt) }" />">
							</c:otherwise>
						</c:choose>
						</p>
				      </c:when>
				      <c:when test="${i eq 2 }">
				        <c:set var="file" value="${boardMap.bdThumb2 }" />
				        <c:set var="alt" value="${boardMap.bdThumb2Alt }" />
						<p><img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','gallery',file,file) }" />" alt="<c:out value="${ufn:quot(alt) }" />"/></p>
				      </c:when>
				      <c:when test="${i eq 3 }">
				        <c:set var="file" value="${boardMap.bdThumb3 }" />
				        <c:set var="alt" value="${boardMap.bdThumb3Alt }" />
						<p><img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','gallery',file,file) }" />" alt="<c:out value="${ufn:quot(alt) }" />"/></p>
				      </c:when>
				    </c:choose>
				  </c:forEach>
			</c:if>
			<br/>--%>
			<c:choose>
				<c:when test="${boardMap.howUpload eq '1'}">
					<c:choose>
						<c:when test="${fn:contains(boardMap.bdMovie,'WEBROOT_NEW')}">
							<video src="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',boardMap.bdMovie ,boardMap.bdMovie ) }" width="100%" height="600" controls>
								<source src="${boardMap.bdMovie }" type="video/mp4">
								<source src="${boardMap.bdMovie }" type="video/WebM">
								<source src="${boardMap.bdMovie }" type="video/ogg">
								해당 브라우져는 비디오태그를 지원하지 않습니다.
							</video>
						</c:when>
						<c:otherwise>
					       	<video src="/comm/download.do?f=${ufn:getDownloadLink('','movie',boardMap.bdMovie ,boardMap.bdMovie ) }" width="100%" height="600" controls>
								<source src="${boardMap.bdMovie }" type="video/mp4">
								<source src="${boardMap.bdMovie }" type="video/WebM">
								<source src="${boardMap.bdMovie }" type="video/ogg">
								해당 브라우져는 비디오태그를 지원하지 않습니다.
							</video>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<iframe width="100%" height="480"   title="유튜브 영상 연결"  src="https://www.youtube.com/embed/${boardMap.bdMovie }" frameborder="1" allowfullscreen></iframe>
				</c:otherwise>
			</c:choose>
			<br/>
			<c:choose>
				<c:when test="${boardMap.bdHtmlyn eq 'Y'}">
					<c:out value="${ufn:decodeXss(boardMap.bdContent)}" escapeXml="false" />
				</c:when>
				<c:otherwise>
					<c:out value="${ufn:stripXss(boardMap.bdContent) }" escapeXml="false" />
				</c:otherwise>
			</c:choose>
		</div><!--// view-content-->

        <div class="btn-board_bottom">
			<a href="#" class="btn btn-list list-icon" onclick="fn_goList();return false;">목록</a>
		</div>
    </div>
</div>