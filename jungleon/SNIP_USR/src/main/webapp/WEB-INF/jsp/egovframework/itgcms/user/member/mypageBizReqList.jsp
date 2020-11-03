<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
                <!-- board_top -->
                    <div class="board_top">
                        <form name="form1" method="post" action="?">
                        <input type="hidden" name="page" value="1" />
                            <fieldset>
                                <legend>게시판 검색폼</legend>
                                <div class="inner">
                                    <strong class="tit">신청년도</strong>
                                    <select name="schOpt2" id="schOpt2" class="select_box" title="신청년도 선택" onchange="document.form1.submit();">
                                    	<option value="">년도</option>
                                    	<c:forEach var="year" items="${yearList }" >
                                        <option value="${year }" ${ufn:selected(year , searchVO.schOpt2) }>${year }년</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </fieldset>
						</form>
                    </div>
                    <!-- //board_top -->
					<div class="total_list_number">
						전체게시글 <strong><c:out value="${paginationInfo.totalRecordCount }" /></strong>개
					</div>
                    <!-- board-list -->
                    <div class="board-list_wrap mypage_bus_list">
                        <table class="board-list">
                            <caption>
                                <p class="ir-text">번호,제목,상태,작성일로 구성된 사업신청관리 리스트</p>
                            </caption>
                                <!--[if lt IE 9]>
                                    <colgroup>
                                            <col style="width:7%"  class="num">
                                            <col style="width:auto"  class="subject">
                                            <col style="width:11%" class="data">
                                            <col style="width:11%"  class="hit">
                                    </colgroup>
								<![endif]-->
								<colgroup class="n_mobile">
                                    <col class="col1">
                                    <col>
                                    <col style="width:150px">
                                    <col style="width:150px">
                                </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">제목</th>
                                <th scope="col">상태</th>
                                <th scope="col">작성일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="result" items="${resultList}" varStatus="status">
                                <tr>
                                    <td class="num"><c:out value="${listNo -(status.count-1) }" /></td>
                                    <td class="subject">
                                    <a href="#none" onclick="fn_goView('<c:out value="${result.snp}" />')"><c:out value="${result.title }" /></a></td>
                                    <td class="state">
                                    <c:choose>
                                    	<c:when test="${result.reqStatus eq '2423'}"><span class="bus-state c-green">선정 </span></c:when>
										<c:when test="${result.reqStatus eq '2424'}"><span class="bus-state c-dblue">탈락 	 </span></c:when>
										<c:when test="${result.reqStatus eq '2425'}"><span class="bus-state c-blue">중도포기  </span></c:when>
										<c:when test="${result.reqStatus eq '2420'}"><span class="bus-state c-org">접수중  </span></c:when>
										<c:when test="${result.reqStatus eq '2419'}"><span class="bus-state c-org">작성중	 </span></c:when>
										<c:when test="${result.reqStatus eq '2426'}"><span class="bus-state c-blue">사업실패 </span></c:when>
										<c:when test="${result.reqStatus eq '2422'}"><span class="bus-state c-blue">신청취소 </span></c:when>
										<c:when test="${result.reqStatus eq '2427'}"><span class="bus-state c-gray">정상완료  </span></c:when>
										<c:when test="${result.reqStatus eq '2421'}"><span class="bus-state c-gray">접수완료  </span></c:when>
                                    </c:choose>
                                    </td>
                                    <td class="data mobile"><c:out value="${fn:substring(result.regDt, 0,10) }" /></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
					<!-- //board-list -->
                    <div class="paginate">
                        <ui:pagination paginationInfo = "${paginationInfo}" type="user" jsFunction="fn_egov_link_page" />
                    </div>
                <!-- //게시판리스트 -->

                <p class="y-subpage-tit mt-50">진행상태 설명</p>
                <div class="box box-line">
                    <ul class="bus-state__list">
                        <li>
                            <span class="bus-state c-org">작성중</span>
                            <span class="text">사업 신청서를 작성중인 상태</span>
                        </li>
                        <li>
                            <span class="bus-state c-org">접수중</span>
                            <span class="text">사업 신청서 작성을 완료하였고, 사업 담당자가 신청내역을 확인 중인 상태 </span>
                        </li>
                        <li>
                            <span class="bus-state c-gray">접수중</span>
                            <span class="text">신청내역을 확인하여 접수가 완료된 상태  </span>
                        </li>
                        <li>
                            <span class="bus-state c-blue">신청취소</span>
                            <span class="text">신청이 취소된 상태  </span>
                        </li>
                        <li>
                            <span class="bus-state c-green">선정</span>
                            <span class="text">지원사업에 선정된 상태 </span>
                        </li>
                        <li>
                            <span class="bus-state c-dblue">탈락</span>
                            <span class="text">지원사업에 탈락된 상태  </span>
                        </li>
                        <li>
                            <span class="bus-state c-blue">중도포기</span>
                            <span class="text">사업진행중 사업을 포기한 상태  </span>
                        </li>
                        <li>
                            <span class="bus-state c-blue">사업실패</span>
                            <span class="text">사업이 정상적으로 완료되지 않은 상태 </span>
                        </li>
                        <li>
                            <span class="bus-state c-gray">정상완료</span>
                            <span class="text">사업이 정상적으로 완료된 상태  </span>
                        </li>
                    </ul>
                </div>

                <script>
                var queryString = "${searchVO.queryString()}";
                /* pagination 페이지 링크 function */
				function fn_egov_link_page(pageNo){
					location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
				}
				function fn_goView(id) {
					var tmpQuery = queryString;
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", id);

					location.href="https://www.snip.or.kr/SNIP/contents/Business1.do?" + tmpQuery;
				}
                </script>