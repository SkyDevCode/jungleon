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
 * @파일명 : userProductList.jsp
 * @파일정보 : 사업신청 > 성남기업소개 > 성남기업 및 상품안내 > 상품정보
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 04. 13. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<%--
				<!-- 4dep_menu -->
				<div class="sub-tab__4dep pd_0">
					<div class="slide">
						<div class="clfx sub-tab__4dep_list_row2">
							<div class="menu"><a href="/${siteCode}/contents/Business811.do">기업정보</a></div>
							<div class="menu active"><a href="/${siteCode}/contents/Business812.do">상품정보</a></div>
						</div>
					</div>
				</div>
				<!-- //4dep_menu -->

 --%>
				<div class="total_list_number">
					전체게시글 <strong><c:out value="${paginationInfo.totalRecordCount }" /></strong>개
				</div>

				<div class="search-form-detail_wrap">
					<form name="listForm" id="listForm" method="post" onsubmit="fn_search(); return false;">
						<fieldset>
							<legend>게시판 검색 조건별, 업종검색별, 지역검색을 할수 있는 검색폼</legend>
							<table>
								<caption>검색조건, 업종검색, 지역설정을 정하여 검색결과를 보여주는 표</caption>
								<tbody>
									<tr>
										<th scope="row"><label for="search_condition">검색조건</label></th>
										<td>
											<div class="search_list_w1">
												<select name="schFld" id="schFld" title="검색조건 선택">
													<option value="0" ${ufn:selected(searchVO.schFld, '0')}>전체</option>
													<option value="1" ${ufn:selected(searchVO.schFld, '1')}>상품명</option>
													<option value="2" ${ufn:selected(searchVO.schFld, '2')}>업체명</option>
												</select>
											</div>
											<div class="search_list_w4">
												<%-- <input type="text" name="schStr"  value="<c:out value="${searchVO.schStr }" escapeXml="false" />" onkeyup="charCheck(this);" onkeydown="if(ItgJs.fn_isEnter(event)) {fn_search(); return false;}" placeholder="검색어를 입력하세요." title="검색어 입력란" /> --%>
												<input type="text" name="schStr" value="<c:out value="${searchVO.schStr }" escapeXml="false" />" onkeyup="charCheck(this);" onkeydown="charCheck(this);" placeholder="검색어를 입력하세요." title="검색어 입력란" />
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">분류검색</th>
										<td>
											<div class="search_list_w1">
												<a href="javascript:void(0);" title="분류검색 레이어팝업창으로 이동" class="btn btn-modal-pop" id="ksic_popup">분류검색</a>
											</div>
											<!-- 분류검색 레이어팝업 -->
											<div class="layerpopup pop02 ksic_popup">
												<h3 class="pop-header"><strong>분류검색</strong></h3>
												<div class="pop-content">
													<ul class="ksic_info">
														<li>성남 벤처넷은 UNSPSC(United Nation Standard Products and Service Code)기준 하에 상품을 분류합니다.</li>
													</ul>
														<fieldset>
															<legend>1차, 2차, 3차, 4차 분류별 검색하는 폼</legend>
															<table>
																<caption>1차분류, 2차분류, 3차분류, 4차분류를 선택하는 표</caption>
																<tbody>
																	<tr>
																		<th scope="row"><label for="unspscDepth1">1차 분류 선택</label></th>
																		<td>
																			<select name="unspscDepth1" id="unspscDepth1" onchange="fn_searchUnspsc(this.value, 2);" class="unspscDepth">
																				<option value="">선택하세요.</option>
																			<c:forEach var="unspsc" items="${unspscList }">
																				<option value="<c:out value="${unspsc.unCd }" />"><c:out value="${unspsc.unNm }" /></option>
																			</c:forEach>
																			</select>
																		</td>
																	</tr>
																	<tr>
																		<th scope="row"><label for="unspscDepth2">2차 분류 선택</label></th>
																		<td>
																			<select name="unspscDepth2" id="unspscDepth2" onchange="fn_searchUnspsc(this.value, 3);" class="unspscDepth">
																				<option value="">선택하세요.</option>
																			</select>
																		</td>
																	</tr>
																	<tr>
																		<th scope="row"><label for="unspscDepth3">3차 분류 선택</label></th>
																		<td>
																			<select name="unspscDepth3" id="unspscDepth3" onchange="fn_searchUnspsc(this.value, 4);" class="unspscDepth">
																				<option value="">선택하세요.</option>
																			</select>
																		</td>
																	</tr>
																	<tr>
																		<th scope="row"><label for="unspscDepth4">4차 분류 선택</label></th>
																		<td>
																			<select name="unspscDepth4" id="unspscDepth4" onchange="fn_setUnspsc(this.value, 'unspscDepth4');">
																				<option value="">선택하세요.</option>
																			</select>
																		</td>
																	</tr>
																</tbody>
															</table>
															<div class="btn_area">
																<button onclick="fn_setKsicSelect(event);" class="small-btn-blue btn">적 용</button>
															</div>
															<button class="btn-pop-close" onclick="fn_popupClose(event);">
																팝업닫기
															</button>
														</fieldset>
												</div>
											</div>
											<!-- //분류검색 레이어팝업 -->
											<div class="search_list_w2">
												<input type="text" name="schKsicCd" id="schKsicCd" value="<c:out value="${searchVO.schKsicCd }" />" readonly="readonly" title="분류검색결과 값1" />
											</div>
											<div class="search_list_w3">
												<input type="text" name="schKsicNm" id="schKsicNm" value="<c:out value="${searchVO.schKsicNm }" />" readonly="readonly" title="분류검색결과 값2" />
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="area_select">지역설정</label></th>
										<td>
											<div class="search_list_w1">
												<select name="schArea" id="area_select">
													<option value="">전체</option>
													<c:forEach var="area" items="${areaList }">
														<option value="${area.value }" ${ufn:selected(area.value, searchVO.schArea)}>${area.text }</option>
													</c:forEach>
												</select>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="btn_area">
								<button onclick="fn_search();" class="btn-search"><span>검색</span></button>
							</div>
						</fieldset>
					</form>
				</div>

				<div class="gallery-list-type">
					<ul class="gallery-list clfx">
					<c:forEach var="result" items="${resultList }">
						<li>
							<div class="gallery-list_img">
								<a href="#none" title="새창열림" onclick="fn_goView('<c:out value="${result.prdNo }" />');return false;">
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
								</a>
							</div>
							<a href="#none" title="새창열림" onclick="fn_goView('<c:out value="${result.prdNo }" />');return false;">
								<div class="gallery-list_txt">
									<span class="gallery-list_title"><c:out value="${result.prdNm }" /> </span>
									<p>
										<c:out value="${result.comNm }" />
									</p>
									<ul class="gallery-list_info">
										<li><c:out value="${fn:substring( result.regDt, 0, 10) }" /></li>
										<li>조회수 : <c:out value="${result.hitsCnt }" /></li>
									</ul>
								</div>
								<span class="btn_more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/sub/gallery_more_btn.jpg" alt="뷰페이지로 이동" /></span>
							</a>
						</li>
					</c:forEach>
					<c:if test="${fn:length(resultList ) == 0}">
								<li>검색된 데이터가 없습니다.</li>
						</c:if>
					</ul>
				</div>

				<!-- paginate -->
				<%@ include file="/WEB-INF/jsp/egovframework/comm/pagination/comm_pagination_include.jsp" %>
				<!-- //paginate -->
				<!-- //게시판리스트 -->


<script type="text/javascript">
//<[[!CDATA[
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

	function fn_searchUnspsc(unCd, depth) {
		if(unCd == "") {
			for(var i = depth; i < 5; i++){
				$("#unspscDepth" + i).empty();
				$("#unspscDepth" + i).append("<option value=''>선택하세요.</option>");
			}
			return;
		}
		// 선택 설정.
		fn_setUnspsc(unCd, 'unspscDepth' + (depth - 1));
		var data="unCd="+unCd+"&depth="+depth;
		$.ajax({
			url: "/${siteCode}/product/userUnspscSearch.ajax",
			data: data,
			dataType: "json",
			success: function(resultData) {
				if(resultData.result == "1") {
					$("#unspscDepth" + depth).empty();
					$("#unspscDepth" + depth).append("<option value=''>선택하세요.</option>");
					for(var i = 0; i < resultData.data.length; i++ ) {
						var option = "<option value='"+resultData.data[i].unCd+"'>"+resultData.data[i].unNm+"</option>";
						$("#unspscDepth" + depth).append(option)
					}
				} else {
					alert(resultData.message);
					return;
				}
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
	}

	function fn_setUnspsc(unCd, objId) {
		$("#schKsicCd").val(unCd);
		$("#schKsicNm").val($("#" + objId + " option:selected").text());
	}

	function charCheck(ele){
		var regExp = /[~!@\#$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}]/gi;
		if(regExp.test($(ele).val())){
			alert("특수문자는 입력하실 수 없습니다.");
			$(ele).val($(ele).val().substring(0, $(ele).val().length - 1)); //특수문자를 지우는 구문
		}
	}

	var ksicCd = "";
	var ksicNm = "";
	function fn_setKsicSelect(event) {
		event.preventDefault();
		var first = $('#unspscDepth1').val();
		if(first == "") {
			$("#schKsicCd").val('');
			$("#schKsicNm").val('');
		}

		fn_popupClose(event);
	}

	function fn_popupClose(event){
		event.preventDefault();
		$('.ksic_popup').removeAttr("tabindex").hide();
        $('.pop-bg').remove();
        $("body").removeAttr("style");
        $(".btn-modal-pop#ksic_popup").focus();
	}

	function fn_reboot() {
		event.preventDefault();
		$('.unspscDepth').find('option:first').attr('selected', 'selected');
		$("#schKsicCd").val('');
		$("#schKsicNm").val('');
	}



//]]>
</script>
