<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
                <!-- subcont -->
				<div class="total_list_number">
					전체게시글 <strong><c:out value="${paginationInfo.totalRecordCount }" /></strong>개
				</div>

				<!-- board_top -->
				<div class="board_top">
					<form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;">
						<fieldset>
							<legend>게시판 검색폼</legend>
							<div class="inner">
								<label for="schFld" class="blind">검색조건</label>
								<select name="schFld" id="schFld" class="select_box" title="검색어 조건선택">
									<option value="0" ${ufn:selected(searchVO.schFld, '0')}>전체</option>
									<option value="1" ${ufn:selected(searchVO.schFld, '1')}>상품명</option>
									<option value="2" ${ufn:selected(searchVO.schFld, '2')}>업체명</option>
								</select>
								<label for="schStr" class="blind">검색어</label>
								<input type="text" name="schStr" id="schStr" value="<c:out value="${searchVO.schStr }" />" onkeydown="if(ItgJs.fn_isEnter(event)) {fn_search(); return false;}"  class="search_txt"  title="검색어 입력" placeholder="검색어를 입력해주세요">
								<button type="submit" onclick="fn_search();"  class="search"><span class="ir-text">검색</span></button>
							</div>
						</fieldset>
					</form>
				</div>
				<!-- //board_top -->

				<div class="gallery-list-type">
					<ul class="gallery-list clfx">
					<c:forEach var="result" items="${resultList }">
						<li>
							<div class="gallery-list_img">
								<a href="#none" title="새창열림"  onclick="fn_goView('<c:out value="${result.prdNo }" />');return false;">
									<c:if test="${empty result.prdImg01 }">
										<img src="<c:url value="${ctx}/resource/templete/cms1/src/img/common/defalut_sub.gif" />" alt="이미지없음" />
									</c:if>
									<c:if test="${not empty result.prdImg01 }">
										<c:choose>
											<c:when test="${ufn:printDatePattern(result.regDt, 'yyyy-MM-dd')>='2020-06-14'}">
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath01,result.prdImg01) }" />" alt="" />
											</c:when>
											<c:otherwise>
												 <img src="<c:url value="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',fn:substring(result.prdImgPath01,1,fn:length(result.prdImgPath01)) ,result.prdImg01 ) }" />" alt="${result.prdNm }" />
											</c:otherwise>
										</c:choose>
									</c:if>
								<%-- <img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath01,result.prdImg01) }" />" alt="" /> --%>
								</a>
							</div>
							<div class="gallery-list_txt">
								<span class="gallery-list_title"><c:out value="${result.prdNm }" /> </span>
								<p>
									<c:out value="${result.comNm }" />
								</p>
								<ul class="gallery-list_info">
									<li><c:out value="${fn:substring( result.regDt, 0, 10) }" /></li>
								</ul>
							</div>
							<a href="#none" title="새창열림"  onclick="fn_goView('<c:out value="${result.prdNo }" />');return false;" class="btn_more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/sub/gallery_more_btn.jpg" alt="뷰페이지로 이동" /></a>
						</li>
					</c:forEach>
					<c:if test="${fn:length(resultList ) == 0}">
								<li>등록된 게시물이 없습니다.</li>
						</c:if>
					</ul>
				</div>

				<div class="paginate">
					<ui:pagination paginationInfo = "${paginationInfo}" type="user" jsFunction="fn_egov_link_page" />
				</div>
				<!-- //게시판리스트 -->

				<script>
				$(function(){
					$(".subcont").addClass("mypage-product_list")
				});
				var queryString = "${searchVO.query}";

				/* 글 조회 화면 function */
				function fn_goView(id) {
					var tmpQuery = queryString;
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", id);

					location.href="?" + tmpQuery;
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
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schArea", f.schArea.value);
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schKsicCd", f.schKsicCd.value);
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schKsicNm", f.schKsicNm.value);
					tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

					location.href="?" + tmpQuery;
				}


				</script>