<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
                <div class="board-wrap">
                    <div class="board-view">
                        <div class="view-info">                            
                            <strong class="title">
                                <c:out value="${result.title }" /> <span class="label-statu <c:out value="${ufn:IIF(result.statusCd eq '1103', 'end', '') }" />"><c:out value="${result.statusNm }" /></span>
                            </strong>
                            <div class="other-info">
                                <span>등록일 : <c:out value="${fn:substring(result.regDt, 0, 4) }" />-<c:out value="${fn:substring(result.regDt, 4, 6) }" />-<c:out value="${fn:substring(result.regDt, 6, 8) }" />  </span>
                            </div>
                        </div><!--// view-info-->
                        <div class="view-content">
                            <c:out value="${fn:replace(result.qstSummary, '\\\n' , '<br />') }" escapeXml="false"/>
						</div><!--// view-content-->

                        <div class="btn-wrap text-r">
							<button type="button" onclick="fn_goList(); return false;" class="btn btn-default">목록</button>
						</div>


                        <div class="board-bottom">
                        <c:set var="prev" value="" />
						<c:set var="next" value="" />
						<c:forEach var="pn" items="${prevNext }">
							<c:if test="${pn.prevnext eq 'PREV' }">
								<c:set var="prev" value="${pn }" />
							</c:if>
							<c:if test="${pn.prevnext eq 'NEXT' }">
								<c:set var="next" value="${pn }" />
							</c:if>
						</c:forEach>
                            <ul class="prev-next-wrap">
                                <li class="prev">
                                    <strong>이전글</strong>
                                    <c:if test="${empty prev }">
										<a href="#none">이전글이 없습니다.</a>
									</c:if>
									<c:if test="${not empty prev }">
										<a href="#none" onclick="fn_goView('<c:out value="${prev.bbsSeq }" />'); return false;"><c:out value="${prev.title }" /></a>
									</c:if>
                                </li>
                                <li class="next">
                                    <strong>다음글</strong>
                                    <c:if test="${empty next }">
										<a href="#none">다음글이 없습니다.</a>
									</c:if>
									<c:if test="${not empty next }">
										<a href="#none" onclick="fn_goView('<c:out value="${next.bbsSeq }" />'); return false;"><c:out value="${next.title }" /></a>
									</c:if>
                                </li>
                            </ul><!--// prev-next-wrap-->
						</div><!--// board-bottom-->      
						


                    </div>
                </div>    
                
                
                <script>
                var query = "<c:out value="${searchVO.queryString()}" escapeXml="false" />";


                /* 목록 이동 function */
                function fn_goList(){
                	query = ItgJs.fn_replaceQueryString(query, "schId", "");
                	query = ItgJs.fn_replaceQueryString(query, "schM", "list");
                	location.href="?" + query;
                }
                function fn_goView(idx) {
            		query = ItgJs.fn_replaceQueryString(query, "schId", idx);
            		query = ItgJs.fn_replaceQueryString(query, "schM", "view");
            		location.href = "?" + query;
            	}
                </script>