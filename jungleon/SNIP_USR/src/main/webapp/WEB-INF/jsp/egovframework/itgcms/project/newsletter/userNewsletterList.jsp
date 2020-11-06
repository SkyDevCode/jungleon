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
 * @파일명 : userNewsletterList.jsp
 * @파일정보 : 사용자 참여마당 > 진흥원소식지
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @hsk1218 2020. 5. 7. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>


<script type="text/javascript">


function fn_orderby(fld, orderby) {
	var tmpQuery = "";
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordFld", fld);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "ordBy", orderby);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");
	location.href="?" + tmpQuery;
}

function fn_getExcel() {
	/* var tmpQuery = queryString; */
	var tmpQuery = "";
	if(confirm("검색된 목록을 엑셀로 저장하시겠습니까?")) {
		location.href="/_mngr_/module/${menuCode}_mngrNewsletterExcelDown.do?" + tmpQuery;
	}
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	var queryString = "";
	location.href="?" + ItgJs.fn_replaceQueryString(queryString, "page", pageNo);
}

/* 글 등록 화면 function */
function fn_goRegist() {
	location.href = "?schM=regist";
}


/* 글 삭제 function */
function fn_chkDel(){
	var frm = document.listForm;
	if($("input[name=chkId]:checked").size() == 0){
		alert("삭제할 게시물을 선택 해 주세요.");
		return false;
	}else{
		if(confirm("선택한 게시물을 삭제하시겠습니까?")){
			frm.mode.value="delete";
			frm.action = "/_mngr_/module/${menuCode}_multiDelete_newsletter.do";
			frm.submit();
		}
	}

}

function fn_view(){
}

/* function fn_newsArticleDetail(nlaIdxStr) {

	var menuCode 	= '${menuCode}';

	$.ajax({
		url 		: "/${siteCode}/module/${menuCode}_view_newsletterArticle.ajax",
		type 		: "POST",
		data 		: { "menuCode" 	: menuCode,
						"nlaIdxStr" : nlaIdxStr},

		success 	: function(data)
						{
							if ( data == null )
							{
								alert("해당되는 데이터가 없습니다.");
							}
							else
							{
								$("#nlaSubjectModel").text(data.nlaSubject);
								$("#nlaContentModel").html(data.nlaContent);
								fn_view();

							}
						},
		error		: function(request, status, error)
						{
							alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
	});
} */
var pop = null;
function fn_newsArticleDetail(nlaIdxStr) {

	var menuCode 	= '${menuCode}';
/* 	var popupHeight = 500;
	var popupWidth = 500;
	var popupX = 500;
	var popupY = 500;
	var popOption = 'status=no, scrollbars=1, resizable=no, height='+ popupHeight  + ', width=' + popupWidth  + ', left=' + popupX + 'px, top='+ popupY+'px';
	window.open("/${siteCode}/module/${menuCode}_view_newsletterArticle.do?nlaIdxStr=" + nlaIdxStr, "", popOption); */

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

	var url="/${siteCode}/module/${menuCode}_view_newsletterArticle.do?nlaIdxStr=" + nlaIdxStr;

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

</script>

<div class="board_top">
    <form name="listForm" method="post" onsubmit="fn_search(); return false;">
        <fieldset>
            <legend>게시판 검색폼</legend>
            <div class="inner">
				<c:if test="${boardconfigVO.bcGroupyn eq  'Y' }">
	                <label for="schBdcode" class="blind">검색구분</label>
	                <ora:selectCodeList selectName="schBdcode" selectedValue="${searchVO.schBdcode }" codeList="${codeList }" selectTitle="구분" className="select_box"/>
				</c:if>
                <label for="schFld" class="blind">검색조건</label>
                <select name="schFld" id="schFld" class="select_box" title="검색어 조건선택">
	                  <%-- <option value="0" ${ufn:selected(searchVO.schFld, '0') }>전체</option> --%>
				      <option value="1" ${ufn:selected(searchVO.schFld, '1') }>제목</option>
				      <%-- <option value="3" ${ufn:selected(searchVO.schFld, '3') }>내용</option> --%>
                </select>
                <label for="schStr2" class="blind">검색어</label>
                <input type="text" name="schStr" id="schStr2" class="search_txt"  value="<c:out value="${searchVO.schStr }" />" title="검색어 입력" placeholder="검색어를 입력해주세요">
                <button type="submit" class="search"><span class="ir-text">검색</span></button>
            </div>
        </fieldset>
    </form>
</div>

<div class="text-r">
    <a href="#" class="btn btn-blue btn-magegin btn-modal-pop" id="pop01">이전 Biz  Plaza 보기</a>
</div>
<table class="table table-magegin">
    <caption>번호,제목,이미지,기사제목으로 구성된 진흥원소식지</caption>
    <colgroup class="n_mobile">
        <col class="col1">
        <col class="col2">
        <col class="col3">
        <col class="col4">
    </colgroup>
    <thead>
        <th scope="col">번호</th>
        <th scope="col">제목</th>
        <th scope="col">이미지</th>
        <th scope="col">기사제목</th>
    </thead>
    <tbody>
    	<c:forEach items="${resultList }" var="result" varStatus="status" >
        <tr>
            <td class="num"><c:out value="${listNo -(status.count-1) }" /></td>
            <td class="cate"><c:out value="${result.nlTitle }" /></td>
            <c:set var="fileImg" value="${result.nlThumb1 }" />
			<c:set var="alt" value="${result.nlThumb1Alt }" />

            <td class="thum-img">
            	<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','newsletter',fileImg,'nlThumb1') }" />"  alt="<c:out value="${result.nlTitle }" /> 표지" />
				<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
				<c:set var="fileMask" value="${result.fileMask}"/>
				<c:set var="fileSrc" value="${result.fileName}"/>
                <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc)}" />" class="btn btn-blue btn-icon__down">PDF 다운받기</a>
            </td>

            <td class="list">
                <ul class="magegin-subject__list">
                	<c:forEach items="${result.subList }" var="sub">
                    	<li>
                    		<a href="javascript:void(0);" title="새창 열림" onclick="fn_newsArticleDetail('${sub.nlaIdx}')" class="" id="pop02">${sub.nlaSubject }</a>
                    	</li>
                    </c:forEach>
                </ul>
            </td>
         </tr>
         </c:forEach>
    </tbody>
</table>
<!-- paginate -->
<%@ include file="/WEB-INF/jsp/egovframework/comm/pagination/comm_pagination_include.jsp" %>
<!-- //paginate -->

  <!-- modal1 -->
		<div  class="layerpopup pop01" style="display:none; width: 800px;height: 660px;">
			<div class="pop-header">
				<strong>이전 Biz Plaza 보기</strong>
			</div>
			<div class="pop-content">
				<div class="table popup-list">
					<table class="table-list">
						<caption>
							<p class="ir-text">번호,제목,이미지,기사제목,PDF 다운로드 버튼으로 구성된 이전 Biz Plaza 보기 리스트</p>
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
								<col class="col4">
								<col class="col5 n_mobile"  style="width:13%;">
								<col class="col5 n_mobile">
								<col class="col5" style="width:13%;">
							</colgroup>
						<thead>
						<tr>
							<th scope="col" class="n_mobile">번호</th>
							<th scope="col" class="no-left-line">제목</th>
							<th scope="col" class="n_mobile">등록자</th>
							<th scope="col" class="n_mobile">등록일</th>
							<th scope="col">PDF<br> 다운로드</th>
						</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultOldnewsList }" var="oldList">
								<tr>
									<td class="num n_mobile">${oldList.bbsSeq }</td>
									<td class="subject no-left-line">
										<a href="#">${oldList.title }</a>
									</td>
									<td class="writer n_mobile">${oldList.writerNm }</td>
									<td class="data n_mobile">${oldList.regdt }</td>
									<td class="file text-center">
										<c:set var="oldFileFolder" value="oldNews/${oldList.fileUrlCms}"/>
										<c:set var="oldFileMask" value="${oldList.fileNm}"/>
										<c:set var="oldFileSrc" value="${oldList.orgFileNm}"/>
										<a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('',oldFileFolder,oldFileMask,oldFileSrc)}" />">
											<img src="${ctx}/resource/templete/cms1/src/img/common/icon_down.png" alt="PDF 다운받기">
										</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<button type="button"  class="lastClose btn-pop-close"><span>팝업 창닫기</span></button>
			</div>
		</div>
	<!-- //modal1 -->

	<!-- //modal2 -->
	<!--   <div  class="layerpopup pop02" style="display:none">
		<div class="pop-header">
			<strong id="nlaSubjectModel">
			</strong>
		</div>
		<div class="pop-content">
			<div class="news--box" id="nlaContentModel">
			</div>
			<button type="button"  class="lastClose btn-pop-close"><span>팝업 창닫기</span></button>
		</div>
	</div>
	-->
	<!-- //modal2 -->

