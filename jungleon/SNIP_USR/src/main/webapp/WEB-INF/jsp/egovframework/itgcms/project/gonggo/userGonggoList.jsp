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
 * @파일명 : userSOSQnaList.jsp
 * @파일정보 : 사업신청 > SOS현장기동대 > 나의 상담내역(Q&A)
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 04. 02. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>


                <!-- 게시판리스트 -->
                    <!-- board_top -->
                    <div class="board_top">
                        <form name="listForm" method="post" onsubmit="fn_search(); return false;">
                            <fieldset>
                                <legend>게시판 검색폼</legend>
                                <div class="inner">
                                    <label for="schOpt2" class="blind">검색조건</label>
                                    <select name="schOpt2" id="schOpt2" class="select_box" title="검색어 조건선택">
                                      <option value="1003" ${ufn:selected(searchVO.schOpt2, '1003') }>전체</option>
											<option value="1001" ${ufn:selected(searchVO.schOpt2, '1001') }>제목</option>
											<option value="1004" ${ufn:selected(searchVO.schOpt2, '1004') }>담당자</option>
											<option value="1002" ${ufn:selected(searchVO.schOpt2, '1002') }>내용</option>
                                    </select>
                                    <label for="schStr" class="blind">검색어</label>
                                    <input type="text" name="schStr" id="schStr"  class="search_txt"  value="<c:out value="${searchVO.schStr }" />"  title="검색어 입력" placeholder="검색어를 입력해주세요">
                                    <button type="submit" class="search"><span class="ir-text">검색</span></button>
                                </div>
                            </fieldset>
						</form>
                    </div>
                    <!-- //board_top -->
					<div class="total_list_number">
						전체게시글 <strong>${paginationInfo.totalRecordCount}</strong>개
					</div>
                    <!-- board-list -->
                    <div class="board-list_wrap">
                        <table class="board-list">
                             <caption>
						            <p class="ir-text">번호,상태,제목,접수기간,첨부,담당자,작성일,조회수로 구성된 <c:out value="${boardconfigVO.bcName }" /> 게시판 리스트</p>
						        </caption>
						            <colgroup class="n_mobile">
						                <col class="col1">
										<col class="col2">
						                <col class="col3">
						                <col class="col4">
						                	<col class="col5">
						                <col class="col6">
						                <col class="col7">
						                <col class="col8">
						            </colgroup>
						             <thead>
								         <tr>
								             	<th scope="col">번호</th>
								<%-- <c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
								             		<th scope="col">상태</th>
								</c:if> --%>
													<th scope="col">상태</th>
								             		<th scope="col">제목</th>
								             		<th scope="col">접수기간</th>
								           	  	<th scope="col">첨부</th>
								          		<th scope="col">담당자</th>
								          		<th scope="col">작성일</th>
								          		<th scope="col">조회수</th>
								         </tr>
                            		</thead>
                          <tbody>
                          	<c:forEach var="result" items="${resultList}" varStatus="status">
								<c:set var="lpadding" value="0" />
								<c:if test="${boardconfigVO.bcReplyyn eq 'Y'}">
				    				<c:set var="lpadding" value="${result.bdRelevel * 10 }" />
								</c:if>
								<tr>
				    				<td class="num"><c:out value="${listNo -(status.index) }" /></td>
									<%-- <c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
				    					<td class="num"><c:out value="${result.bdCodeName }" /></td>
									</c:if> --%>
									<c:choose>
										<c:when test="${result.stat eq 'ing' }">
											<td class="state"><span class="icon-state ing">진행</span></td>
										</c:when>
										<c:when test="${result.stat eq 'end' }">
											<td class="state"><span class="icon-state end">마감</span></td>
										</c:when>
										<c:when test="${result.stat eq 'fdaegi' }">
											<td class="state"><span class="icon-state" style="background-color: #ffa024;">대기</span></td>
										</c:when>
									</c:choose>
				    				<td class="subject">
				        				<a href="#none" onclick="fn_goView('<c:out value="${result.snp}" />')">
				       					 <c:out value="${result.title }" escapeXml="false"/>
				        				</a>
				        				<c:if test="${result.newYn eq 'Y' }"><img src="/resource/templete/cms1/src/img/common/icon_new.png" alt="새 글"/></c:if>
				    				</td>
				    				<td class="term">
				    					<fmt:parseDate var="startdt" pattern="yyyy-MM-dd" value="${result.startdt}"/>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${startdt}"/>
										~
										<fmt:parseDate var="enddt" pattern="yyyy-MM-dd" value="${result.enddt}"/>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${enddt}"/>
				    				</td>


				    					<td class="file">
									<c:if test="${result.fileSeq ne '-1'}">
				        					<img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/src/img/common/icon_down.png" alt="첨부된 파일이 있습니다."/>
									</c:if>
				    					</td>
				    				<td class="writer"><c:out value="${result.usernm }" /></td>
								    <td class="data"><c:out value="${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd')}" /></td>
								    <td class="hit">${result.readCnt }</td>
								</tr>
                              </c:forEach>

                              <c:if test="${fn:length(resultList ) == 0}">
								<tr><td colspan="8">등록 된 데이터가 없습니다.</td></tr>
							</c:if>
                          </tbody>
                        </table>
					</div>

					<!-- //board-list --><%--
                    <div class="paginate">
                        <ui:pagination paginationInfo = "${paginationInfo}" type="user" jsFunction="fn_egov_link_page" />
                    </div> --%>
<!-- paginate -->
  <%@ include file="/WEB-INF/jsp/egovframework/comm/pagination/comm_pagination_include.jsp" %>
<!-- //paginate -->
                <!-- //게시판리스트 -->
<%-- <form name="dataForm3" id="dataForm3" method="post" target="_blank" action="/iframe.jsp">
		</form>
		<style>
#hidden
{
width:1px;
height:1px;
border:0;
}
</style>
		<iframe id="hidden" name="hiddenifr" src="/iframe.jsp">
</iframe> --%>
     <script type="text/javascript">
//<[[!CDATA[
            var queryString = "${searchVO.queryString()}";

    /* var pop = null;
	function fn_goRegist() {
		form = document.dataForm3;
		form.target = "hiddenifr"
		form.submit();
		var child = "new_win";
		var wd = 800;
		var he = 660;

		// 듀얼 모니터 기준
		var le = (screen.availWidth - wd) / 2;
		if( window.screenLeft < 0){
		le += window.screen.width*-1;
		}
		else if ( window.screenLeft > window.screen.width ){
		le += window.screen.width;
		}

		var tp = (screen.availHeight - he) / 2 - 10;

		var url="/iframe2.jsp";

		var option = "resizable=no, scrollbars=1, status=no, location=no, derectories=no, width="+wd+", height=" + he + ", left="+le+", top="+tp +", screenX="+le ;
		if(pop){
			if(pop.closed){
				pop = window.open(url, child, option);
			}else{
				if(url == pop.location){
					pop.focus();
					return;
				}else{
					pop.close();
					pop = window.open(url, child, option);
				}
			}
		}else{
			pop = window.open(url, child, option);
		}
		child = pop;
	} */



	/* 글 조회 화면 function */
	function fn_goView(id) {
		var tmpQuery = queryString;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", id);

		location.href="https://www.snip.or.kr/SNIP/contents/Business1.do?" + tmpQuery
	}

	/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo){
		location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
	}


	function fn_search(){
		var tmpQuery = queryString;
		var f = document.listForm;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schOpt2", f.schOpt2.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

		location.href="?" + tmpQuery;
	}

	function fn_viewcount(){
		var tmpQuery = queryString;
		var f = document.listForm;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

		location.href="?" + tmpQuery;
	}



//]]>
</script>
