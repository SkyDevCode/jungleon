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
                 <div class="board_top">
                    <form name="listForm" method="post" onsubmit="fn_search(); return false;">
                        <fieldset>
                            <legend>게시판 검색폼</legend>
                            <div class="inner">
                                <label for="schFld" class="blind">검색조건</label>
                                <select name="schFld" id="schFld" class="select_box" title="검색어 조건선택">
                                    <option value="1" ${ufn:selected(searchVO.schFld, '1') }>제목</option>
									<option value="2" ${ufn:selected(searchVO.schFld, '2') }>담당자명</option>
									<option value="3" ${ufn:selected(searchVO.schFld, '3') }>신청인명</option>
                                </select>
                                <label for="schStr" class="blind">검색어</label>
                                <input type="text" name="schStr" id="schStr" value="<c:out value="${searchVO.schStr }" />" class="search_txt"  title="검색어 입력" placeholder="검색어를 입력해주세요">
                                <button type="submit" class="search"><span class="ir-text">검색</span></button>
                            </div>
                        </fieldset>
                    </form>
                </div>
                <!-- //board_top -->
                <div class="total_list_number">
                    전체게시글 <strong><c:out value="${paginationInfo.totalRecordCount }" /></strong>개
                </div>
                <!-- board-list -->
                <div class="board-list_wrap">
                    <table class="board-list">
                        <caption>
                            <p class="ir-text">번호,상태,등록일,상담인,답변자,처리상태로 구성된 Q&A 리스트</p>
                        </caption>
                            <!--[if lt IE 9]>
                                <colgroup>
                                        <col style="width:7%"  class="num">
                                        <col style="width:auto"  class="subject">
                                        <col style="width:11%" class="data">
                                         <col style="width:11%" class="data">
                                        <col style="width:11%"  class="hit">
                                </colgroup>
                            <![endif]-->
                            <colgroup class="n_mobile">
                                <col class="col1">
                                <col class="col9">
                                <col class="col4">
                                <col class="col8">
                                <col class="col4">
                                <col class="col10">
                            </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">등록일</th>
                            <th scope="col">상담인</th>
                            <th scope="col">답변자</th>
                            <th scope="col">처리상태</th>
                        </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="result" items="${resultList}" varStatus="status">
                              <tr>
                                  <td class="num-ty2"><c:out value="${listNo -(status.count-1) }" /></td>
                                  <td class="subject subject-ty2">
                                      <a href="#none" onclick="fn_goView('${result.seq}'); return false;"><c:out value="${result.title }" /> </a>
                                      <c:if test="${ufn:dateDiff(ufn:getDatePattern('yyyy-MM-dd'), result.regDt, 'yyyy-MM-dd', 'd') <= 1}">
                                      	<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/icon_new.png" alt="새 글">
                                      </c:if>
                                  </td>
								  		<td class="data mobile"><c:out value="${result.regDt}" /></td>
                                  <td class="data n_mobile"><c:out value="${result.mgrName}" /></td>
                                  <td class="writer no-line n_mobile"><c:out value="${result.name}" /></td>
                                  <td class="writer status"><span class="label-statu ${ufn:deCode(result.statusCd,'1103,end','') }"><c:out value="${result.statusName}" /></span></td>
                              </tr>
                              </c:forEach>

                              <c:if test="${fn:length(resultList ) == 0}">
								<tr><td colspan="6">등록 된 데이터가 없습니다.</td></tr>
							</c:if>
                        </tbody>
                    </table>
                </div>
                <div class="btn-wrap">
                    <a href="#" class="btn btn-blueline icon-check btn-block"  title="새창연결">신청하기</a>
                </div>
                <!-- //board-list -->
                <div class="paginate">
                    <ui:pagination paginationInfo = "${paginationInfo}" type="user" jsFunction="fn_egov_link_page" />
                </div>


	            <script>

					var queryString = "${searchVO.queryString()}";


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