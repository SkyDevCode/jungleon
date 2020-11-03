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
 * @파일명 : userCominfoList.jsp
 * @파일정보 : 사업신청 > 성남기업소개 > 성남기업 및 상품안내 > 기업정보
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 04. 12. 최초생성
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
							<div class="menu active"><a href="#">기업정보</a></div>
							<div class="menu"><a href="${ctx }/${siteCode}/contents/Business812.do">상품정보</a></div>
						</div>
					</div>
				</div>
				<!-- //4dep_menu -->
 --%>
				<div class="total_list_number">
					전체게시글 <strong><c:out value="${paginationInfo.totalRecordCount }" /></strong>개
				</div>

				<div class="search-form-detail_wrap">
					<form name="listForm" method="post" onsubmit="fn_search();return false;">
						<fieldset>
							<legend>게시판 검색 조건별, 업종검색별, 지역검색을 할수 있는 검색폼</legend>
							<table>
								<caption>검색조건, 업종검색, 지역설정을 정하여 검색결과를 보여주는 표</caption>
								<tbody>
									<tr>
										<th scope="row"><label for="schFld">검색조건</label></th>
										<td>
											<div class="search_list_w1">
												<select name="schFld" id="schFld" title="검색조건 선택">
													<option value="0" ${ufn:selected(searchVO.schFld, '0')}>전체</option>
													<option value="1" ${ufn:selected(searchVO.schFld, '1')}>업체명</option>
													<option value="2" ${ufn:selected(searchVO.schFld, '2')}>주요생산품</option>
												</select>
											</div>
											<div class="search_list_w4">
												<%-- <input type="text" name="schStr"  value="<c:out value="${searchVO.schStr }" />" onkeydown="if(ItgJs.fn_isEnter(event)) {fn_search(); return false;}" placeholder="검색어를 입력하세요." title="검색어 입력란" /> --%>
												<input type="text" name="schStr" value="<c:out value="${searchVO.schStr }" escapeXml="false" />" onkeyup="charCheck(this);" onkeydown="charCheck(this);" placeholder="검색어를 입력하세요." title="검색어 입력란" />
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">업종검색</th>
										<td>
											<div class="search_list_w1">
												<a href="#none" title="분류검색 레이어팝업창으로 이동" class="btn btn-modal-pop" id="ksic_popup">분류검색</a>
											</div>
											<!-- 분류검색 레이어팝업 -->
											<div class="layerpopup pop02 ksic_popup" >
												<h3 class="pop-header"><strong>표준산업분류 명칭</strong></h3>
												<div class="pop-content">
													<ul class="ksic_info">
														<li>검색할 표준산업분류코드(KSIC) 명칭을 입력한 후 검색 버튼을 누르세요.</li>
														<li>보기 : 통신, 의료, 소프트웨어</li>
													</ul>
														<fieldset>
															<legend>표준산업분류 명칭 검색하는 폼</legend>
															<div class="ksic_search">
																<label for="ksic_name">표준산업분류 명칭</label>
																<input type="text" id="ksic_name" onkeydown="if(ItgJs.fn_isEnter(event)) {fn_searchKsic(event); return false;}" />
																<button class="ksic_search_btn" onclick="fn_searchKsic(event)">검색</button>
															</div>
															<div class="ksic_list" id="ksic_list">
															</div>
															<div class="btn-wrap">
																<button onclick="fn_setKsicSelect(event);" class="btn type2">적 용</button>
															</div>
															<button class="btn-pop-close" onclick="fn_ksicPopupClose(event);">
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
										<th scope="row"><label for="schArea">지역설정</label></th>
										<td>
											<div class="search_list_w1">
												<select name="schArea" id="schArea">
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

				<!-- board-list -->
				<div class="board-list_wrap product_info-board_wrap">
					<table class="board-list">
						<caption>
							<p class="ir-text">번호,업체명,상품명,전화번호,홈페이지로 구성된 사업공고 리스트</p>
						</caption>
							<colgroup class="product_info_col n_mobile">
								<col class="col1">
								<col class="col2">
								<col class="col3">
								<col class="col4">
								<col class="col5">
							</colgroup>
						<thead>
						<tr>
							<th scope="col" class="num">번호</th>
							<th scope="col" class="name">업체명</th>
							<th scope="col" class="product_name">상품명</th>
							<th scope="col" class="tel">전화번호</th>
							<th scope="col" class="homepage">홈페이지</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td class="num"><c:out value="${listNo -(status.count-1) }" /></td>
								<td class="name"><a href="#none" onclick="fn_goView('${result.busiRegNo}'); return false;"><c:out value="${result.comNm }" /> </a></td>
								<td class="product_name">
									<a href="#none" onclick="fn_goView('${result.busiRegNo}'); return false;"><c:out value="${result.mainProduct }" /></a>
								</td>
								<td class="tel"><c:out value="${result.officeTel01 }" />-<c:out value="${result.officeTel02 }" />-<c:out value="${result.officeTel03 }" /></td>
								<td class="homepage"><c:out value="${result.hPage }" /></td>
							</tr>
						</c:forEach>
						<c:if test="${fn:length(resultList ) == 0}">
							<tr>
								<td colspan="5">검색된 데이터가 없습니다.</td>
							</tr>
						</c:if>
						</tbody>
					</table>
				</div>
				<!-- //board-list -->
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

	function fn_searchKsic(event) {
		bSelect = false;
		event.preventDefault();
		var ksicName = $("#ksic_name").val();
		if(ksicName == "") {
			alert("검색 할 표준산업분류 명칭을 입력 해 주세요");
			return false;
		}
		$.ajax({
			url: "/${siteCode}/cominfo/userKsicSearch.ajax",
			data: "schStr=" + encodeURIComponent(ksicName),
			dataType: "json",
			success: function(resultData) {
				if(resultData.result == "1") {
					var html = "";
					for(var i = 0; i < resultData.data.length; i++ ) {
						html += "<li>";
						html += "<button onclick=\"fn_selectKsic(event, '"+resultData.data[i].ksicCd+"','"+resultData.data[i].ksicNm+"')\">";
						html += resultData.data[i].ksicNm
// 						html += "</td>";
// 						html += "<td><a href='#' onclick=\"fn_setKsic('" + resultData.data[i].ksicCd + "','" + resultData.data[i].ksicNm + "')\">";
// 						html += resultData.data[i].ksicNm
// 						html += "</a>";
						html += "</button>";
						html += "</li>";
					}
					if(resultData.data.length == 0){
						html = "<li>검색된 데이터가 없습니다</li>";
					}
					$("#ksic_list").html("<ul>" + html + "</ul>");
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

	var ksicCd = "";
	var ksicNm = "";
	var bSelect = false;
	function fn_selectKsic(event, cd, nm){
		event.preventDefault();
		ksicCd = cd;
		ksicNm = nm;
		bSelect = true;

		var thisEle = event.target;
		$(thisEle).closest('ul').find('button').css('color','#595959');
		$(thisEle).css('color','#0080c9');
	}
	function fn_setKsicSelect(event) {
		event.preventDefault();
		if(!bSelect) {
			alert("적용할 항목을 선택 해 주세요");
			return false;
		}
		$("#schKsicCd").val(ksicCd);
		$("#schKsicNm").val(ksicNm);
		bSelect = false;
		fn_ksicPopupClose(event);
	}
	function fn_ksicPopupClose(event){
		event.preventDefault();
		$('.ksic_popup').removeAttr("tabindex").hide();
        $('.pop-bg').remove();
        $(".btn-modal-pop#ksic_popup").focus();
	}

	function charCheck(ele){
		var regExp = /[~!@\#$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}]/gi;
		if(regExp.test($(ele).val())){
			alert("특수문자는 입력하실 수 없습니다.");
			$(ele).val($(ele).val().substring(0, $(ele).val().length - 1)); //특수문자를 지우는 구문
		}
	}
//]]>
</script>
