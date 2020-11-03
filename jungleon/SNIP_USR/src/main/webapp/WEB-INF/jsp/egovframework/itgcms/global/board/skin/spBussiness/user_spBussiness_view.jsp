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
 * @파일명 : user_spBussiness_view.jsp
 * @파일정보 : 지원사업게시판
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

<!-- 게시판상세 -->
<div class="board-wrap">
    <div class="board-view">
        <div class="view-info">
	        <strong class="title">
	               <c:out value="${boardMap.bdTitle }" />
            </strong>
            <div class="other-info">
                <c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
                	<c:choose>
                        	<c:when test="${boardconfigVO.bcId eq 'emptyRoom' || boardconfigVO.bcId eq 'bsnsCtApply'}">
                        		<span class="bus-tit">센터명 : <c:out value="${boardMap.bdCodeName }" /> </span>
                        	</c:when>
                        	<c:otherwise>
                        		<span class="bus-tit">사업명 : <c:out value="${boardMap.bdCodeName }" /> </span>
                        	</c:otherwise>
               	   	</c:choose>
				</c:if>
                <span class="read">조회수 : <fmt:formatNumber value="${boardMap.bdReadnum }" /> </span>
                <span class="part">담당부서 : <c:out value="${boardMap.cgDept }"/></span>
                <span class="manage">담당자 : <c:out value="${boardMap.charger }" /></span>
                <span class="tel">연락처 : <c:out value="${boardMap.cttPc }"/></span>
                <c:choose>
                       	<c:when test="${boardconfigVO.bcId eq 'emptyRoom'}">
                     	</c:when>
                       	<c:otherwise>
                       		 <p>접수기간 :
			                		<fmt:parseDate var="recSdt" pattern="yyyy-MM-dd" value="${boardMap.recSdt}"/>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${recSdt}"/>
									~
									<fmt:parseDate var="recEdt" pattern="yyyy-MM-dd" value="${boardMap.recEdt}"/>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${recEdt}"/>
							</p>
                       	</c:otherwise>
                </c:choose>
            </div>
        </div><!--// view-info-->
         <c:choose>
               	<c:when test="${boardconfigVO.bcId eq 'emptyRoom'}">
              	</c:when>
               	<c:otherwise>
                   		<div class="file-list">
				            <dl>
				                <dt>
				                   	 첨부파일
				     	       	</dt>
				                <dd>
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
				                </dd>
				            </dl>
				        </div>
              	</c:otherwise>
		</c:choose>

		<div class="view-content">
				<c:choose>
					<c:when test="${boardMap.bdHtmlyn eq 'Y'}">
						<c:out value="${ufn:decodeXss(boardMap.bdContent)}" escapeXml="false" />
					</c:when>
					<c:otherwise>
						<c:out value="${ufn:stripXss(boardMap.bdContent) }" escapeXml="false" />
					</c:otherwise>
				</c:choose>
		</div><!--// view-content-->


		<c:choose>
			<c:when test="${boardMap.recStat eq '대기' }">
			</c:when>
			<c:when test="${boardMap.recStat eq '마감' }">
			</c:when>
			<c:when test="${boardconfigVO.bcId eq 'emptyRoom'}">
            </c:when>
			<c:otherwise>
				<div class="btn-wrap btn-appli">
					<a href="#" class="btn btn-blueline icon-check btn-block"  title="새창연결">신청하기</a>
					<a href="/${siteCode}/contents/Guidance3.do" class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
				</div>
			</c:otherwise>
		</c:choose>


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
								<a href="#none" onclick="fn_goView(${prevBoardVO.bdIdx}); return false;"><span><c:out value="${prevBoardVO.bdTitle }" /></span></a>
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
								<a href="#none" onclick="fn_goView(${nextBoardVO.bdIdx}); return false;"><span><c:out value="${nextBoardVO.bdTitle }" /></span></a>
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