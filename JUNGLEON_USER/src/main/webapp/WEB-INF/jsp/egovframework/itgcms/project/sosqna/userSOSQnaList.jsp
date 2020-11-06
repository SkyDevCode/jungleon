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
					<div class="btn-wrap text-r">
						<a href="javascript:fn_goRegist();" class="btn btn-blueline icon-check btn-block" title="새창 열림">신청하기</a>
					</div>
                    <!-- board_top -->
                    <div class="board_top">
                        <form name="listForm" method="post" onsubmit="fn_search(); return false;">
                            <fieldset>
                                <legend>게시판 검색폼</legend>
                                <div class="inner">
                                    <label for="schFld" class="blind">검색조건</label>
                                    <select name="schFld" id="schFld" class="select_box" title="검색어 조건선택">
                                      <option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
											<option value="1" ${ufn:selected(searchVO.schFld, '1') }>제목</option>
											<option value="2" ${ufn:selected(searchVO.schFld, '2') }>담당자명</option>
											<option value="3" ${ufn:selected(searchVO.schFld, '3') }>신청인명</option>
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
                                <p class="ir-text">번호,제목,등록일,상담인,답변자,처리상태로 구성된 나의 상담내역(Q&A) 리스트</p>
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
                                      <a href="#none" onclick="fn_goView('${result.seq}'); return false;"><c:out value="${result.title }" />
                                      <c:if test="${ufn:dateDiff(ufn:getDatePattern('yyyy-MM-dd'), result.regDt, 'yyyy-MM-dd', 'd') <= 1}">
                                      	<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/icon_new.png" alt="새 글">
                                      </c:if>
                                      </a>
                                  </td>
								  		<td class="data mobile"><c:out value="${result.regDt}" /></td>
                                  <td class="writer no-line n_mobile"><c:out value="${result.name}" /></td>
                                  <td class="data n_mobile"><c:out value="${result.mgrName}" /></td>
                                  <td class="writer status"><span class="label-statu ${ufn:deCode(result.statusCd,'1103,end','') }"><c:out value="${result.statusName}" /></span></td>
                              </tr>
                              </c:forEach>

                              <c:if test="${fn:length(resultList ) == 0}">
								<tr><td colspan="6">등록 된 데이터가 없습니다.</td></tr>
							</c:if>
                          </tbody>
                        </table>
					</div>

					<!-- //board-list -->
                    <!-- paginate -->
					<%@ include file="/WEB-INF/jsp/egovframework/comm/pagination/comm_pagination_include.jsp" %>
					<!-- //paginate -->
                <!-- //게시판리스트 -->

		<style>
#hidden
{
width:1px;
height:1px;
border:0;
}
</style>
		<iframe id="hidden"  title="내용없음" name="hiddenifr" src="https://www.snip.or.kr/iframe.jsp">
</iframe>
     <script type="text/javascript">
//<[[!CDATA[
            var queryString = "${searchVO.queryString()}";

    var pop = null;
	function fn_goRegist() {

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

		// var url="https://www.snip.or.kr/iframe2.jsp";
		var url = "https://sub.snip.or.kr:4443/vnet/fe/snv/voc/PR_insertForm.do?menuNo=193";

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
	}



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

	function fn_orderby(fld, orderby){
		var tmpQuery = queryString;
		var f = document.listForm;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordFld", fld);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordBy", orderby);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

		location.href="?" + tmpQuery;
	}

	function fn_search(){
		var tmpQuery = queryString;
		var f = document.listForm;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
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
