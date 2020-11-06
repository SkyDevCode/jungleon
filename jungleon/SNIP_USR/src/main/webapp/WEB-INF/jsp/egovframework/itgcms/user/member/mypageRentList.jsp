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
                <!-- board_top -->
				<div class="board_top">
					<form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;">
						<fieldset>
							<legend>게시판 검색폼</legend>
							<div class="inner">
								<label for="schFld" class="blind">검색조건</label>
								<select name="schFld" id="schFld" class="select_box" title="검색어 조건선택">
									<option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
								<option value="1" ${ufn:selected(searchVO.schFld, '1') }>담당자</option>
								<option value="2" ${ufn:selected(searchVO.schFld, '2') }>이메일</option>
								</select>
								<label for="schStr" class="blind">검색어</label>
								<input type="text" name="schStr" id="schStr"  class="search_txt"  title="검색어 입력" value="${ufn:quot(searchVO.schStr )}" placeholder="검색어를 입력해주세요">
								<button type="submit" class="search"><span class="ir-text">검색</span></button>
							</div>
						</fieldset>
					</form>
				</div>
				<!-- //board_top -->
				<div class="total_list_number">
					전체게시글 <strong><fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /></strong>개
				</div>
				<!-- board-list -->
				<div class="board-list_wrap">
					<table class="board-list board-list_hall">
						<caption>
							<p class="ir-text">번호,담당자,대관장소,모임 분류,신청일,예약일,처리상태,사용료로 구성된 대관신청관리 리스트</p>
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
								<col class="col6">
								<col />
								<col class="col10">
								<col class="col10">
								<col class="col10">
								<col class="col10">
								<col class="col4">
							</colgroup>
						<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">담당자</th>
							<th scope="col">대관 장소</th>
							<th scope="col">모임 분류</th>
							<th scope="col">신청일</th>
							<th scope="col">예약일</th>
							<th scope="col">처리 상태</th>
							<th scope="col">사용료</th>
						</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="num"><c:out value="${listNo -(status.count-1) }" /></td>
									<td class="writer"><c:out value="${result.rName }" /></a></td>
									<td class="subject">
										<a href="#none" onclick="fn_goView('<c:out value="${result.rIdx }" />')"><c:out value="${result.rFacilityName }" /></a>
									</td>
									<td class="class"><c:out value="${result.rMeetTypeName }" /></td>
									<td class="date"><c:out value="${fn:substring(result.regdt, 0, 10) }" /></td>
									<td class="reservation_date"><c:out value="${fn:substring(result.rReserveDt, 0, 10) }" /></td>
									<td class="state"><span class="bus-state ${ufn:deCode(result.rStatus, 'rent0101,c-gray,rent0102,c-green,rent0103,c-blue,rent0104,c-gray,rent0105,c-org','') }"><c:out value="${result.rStatusName }" /></span></td>
									<td class="price"><fmt:formatNumber value="${result.rCharge}" type="number" /></td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(resultList ) == 0}">
								<tr><td colspan="8">등록 된 데이터가 없습니다.</td></tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<!-- //board-list -->

				<div class="paginate">
					<ui:pagination paginationInfo = "${paginationInfo}" type="user" jsFunction="fn_egov_link_page" />
				</div>
				<!-- //게시판리스트 -->
				<script>

				var queryString = "${searchVO.query}";


				/* 글 조회 화면 function */
				function fn_goView(id, notice) {
					var tmpQuery = queryString;
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", id);

					location.href= "?" + tmpQuery;
				}

				/* pagination 페이지 링크 function */
				function fn_egov_link_page(pageNo){
					location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
				}


				function fn_search(){
					var tmpQuery = queryString;
					var f = document.listForm;
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

					location.href="?" + tmpQuery;
				}
				</script>