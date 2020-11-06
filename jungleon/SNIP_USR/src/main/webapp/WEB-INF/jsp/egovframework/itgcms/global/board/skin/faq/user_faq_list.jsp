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
 * @파일명 : user_faq_list.jsp
 * @파일정보 : 사용자 FAQ 게시판 목록 스킨
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
<script type="text/javascript">
//<[[!CDATA[
var queryString = "${searchVO.query}";

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
  location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}


function fn_goView(id, notice) {
	var tmpQuery = queryString;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "id", id);

	if (notice) {
		tmpQuery += "&notice="+notice;
	}

	location.href="?" + tmpQuery;
}

function fn_search(){
  var tmpQuery = queryString;
  var f = document.listForm;
  tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
  tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
  tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
  tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schBdcode", $("#schBdcode").val()  );
</c:if>
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



	<div class="boardTop">
      	<div class = "topInfo">
			${boardconfigVO.bcTopinfo}
		</div>
        <form name="listForm" method="post" onsubmit="fn_search(); return false;">
          <fieldset>
            <legend>게시판 검색폼</legend>
            <div class="l">

<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
            <label for="schBdcode" class="blind">검색구분</label>
            <ora:selectCodeList selectName="schBdcode" selectedValue="${searchVO.schBdcode }" codeList="${codeList }" selectTitle="구분" className="select_box100"/>
</c:if>
              <label for="schFld" class="blind">검색조건</label>
              <select name="schFld" id="schFld" class="select_box100" title="검색어 조건선택">
                <option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option>
                <option value="1" ${ufn:selected(searchVO.schFld, '1') }>제목</option>
                <option value="3" ${ufn:selected(searchVO.schFld, '3') }>내용</option>
              </select>

              <label for="schStr" class="blind">검색어</label>
              <input type="text" name="schStr" id="schStr" class="searchTxt" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력" placeholder="검색어를 입력해주세요" />
              <button type="submit" class="search">검색</button>
            </div>
            <div class="r">
              <%-- <span  class="pageTotal">총 게시물 수 <strong id="totalArticles">${paginationInfo.totalRecordCount}</strong> / 총 페이지 수 <strong id="totalPages">${paginationInfo.totalPageCount}</strong></span> --%>
              <span  class="pageTotal">전체 <strong id="totalArticles">${paginationInfo.totalRecordCount}</strong>개</span>
              <%-- <select name="viewCount" id="viewCount" title="목록 갯수" onchange="fn_viewcount();">
                <option value="10" ${ufn:selected(searchVO.viewCount, '10') }>10</option>
                <option value="30" ${ufn:selected(searchVO.viewCount, '30') }>30</option>
                <option value="50" ${ufn:selected(searchVO.viewCount, '50') }>50</option>
                <option value="100" ${ufn:selected(searchVO.viewCount, '100') }>100</option>
              </select> --%>
            </div>
          </fieldset>
        </form>
      </div>

      <div class="boardBox">
      <table class="board tb01">
          <caption>공지사항 리스트</caption>
          <colgroup>
          	<col style="width: 75px;" class="n_mobile"/>
          	<col />
            <col style="width: 100px;"/>
            <col style="width: 150px;"/>
          </colgroup>
          <tbody>
            <c:forEach var="result" items="${noticeList}" varStatus="status">
              <tr style="background-color:#fafafa;font-weight:bold;">
                <td class="n_mobile">
                      <strong>공지</strong>
                </td>
                <td class="subj">
                	<a href="#none" onclick="fn_goView('<c:out value="${result.bdIdx}" />', '<c:out value="${result.bcId}" />')">
                		<c:out value="${result.bdTitle }" />
                	</a>
				</td>
                <td><c:out value="${result.bdWriter }" /></td>
                <td><c:out value="${ufn:printDatePattern(result.regdt, 'yyyy-MM-dd')}"/></td>
              </tr>
            </c:forEach>
            <c:if test="${fn:length(noticeList) eq 0 }">
			  <tr><td colspan="4" style="padding:0px;"></td></tr>
			</c:if>
          </tbody>
        </table>


	      <ul class="board_qna">

	<c:forEach var="boardMap" items="${resultList}" varStatus="status">
	          <li>
	            <div class="head">
	              <dl class="quest">
	                <dt><span class="blind">질문</span></dt>
	<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
	                <dd class="cate"><strong><c:out value="${boardMap.bdCodeName }" /></strong></dd>
	</c:if>
	                <dd class="que"><a href="#" class="answOpen"><c:out value="${boardMap.bdTitle }" /></a></dd>
	              </dl>
	            </div>
	            <div class="answ">
	              <dl class="answer">
	                <dt><span class="blind">답변</span></dt>
	                <dd class="ans">
	                  <div class="txt">
						<c:choose>
						  <c:when test="${boardMap.bdHtmlyn eq 'Y'}">
						    <c:out value="${boardMap.bdContent }" escapeXml="false" />
						    <c:out value="${ufn:decodeXss(boardMap.bdContent)}" escapeXml="false" />
						  </c:when>
						  <c:otherwise>
						    <c:out value="${ufn:stripXss(boardMap.bdContent) }" escapeXml="false" />
						  </c:otherwise>
						</c:choose>
	                  </div>
<c:if test="${boardconfigVO.bcFileyn eq 'Y' and not empty boardMap.fileId }" >
	                  <div>
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
	                  </div>
</c:if>
	                </dd>
	              </dl>
	            </div>
	          </li>
	</c:forEach>
<c:if test="${fn:length(resultList) eq 0 }">
  <li style="text-align: center;"><div class="head"><dl class="quest"><dd class="que">등록 된 데이터가 없습니다.</dd></dl></div></li>
</c:if>
	      </ul>
      </div>

      <div class="pagingWrap">
        <ui:pagination paginationInfo = "${paginationInfo}" type="user" jsFunction="fn_egov_link_page" />
      </div>



      <script>
      qnaTabs(".board_qna");
      </script>





