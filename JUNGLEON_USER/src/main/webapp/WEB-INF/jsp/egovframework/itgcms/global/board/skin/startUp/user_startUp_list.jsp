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
 * @파일명 : user_default_list.jsp
 * @파일정보 : 통합게시판 기본형 스킨
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
<script type="text/javascript">
//<[[!CDATA[
	$(document).ready(function(){
		var count = 0;
		$('th').each(function(){
			if ( $(this).css('display') == 'none'){
			}else{
				count++;
			}
			$('#noData').attr('colspan',count);
		});
	})

	var queryString = "${searchVO.query}";

	/* 글 조회 화면 function */
	function fn_goView(id, notice) {
		var tmpQuery = queryString;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schM", "view");
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "id", id);

		if (notice) {
			tmpQuery += "&notice="+notice;
		}

		//location.href="/user/board/${menuCode}_view_${bcid}.do?" + tmpQuery;
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
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

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

<c:if test="${boardAuthVO.regist == true}">
	/* 글 등록 화면 function */
	function fn_goRegist() {
		//location.href="/user/board/${menuCode}_input_${bcid}.do?schM=regist";
		location.href="?schM=input";
	}
</c:if>

<c:if test="${boardconfigVO.bcRSS eq 'Y'}">
	function getRSS(){
		window.open("./rss/${menuVO.menuCode}.do");
	}
</c:if>
//]]>
</script>

<div class="subcont">
    <!-- subcont -->
	<c:forEach items="${resultList }" var="result">
	<div class="business_guide">
	    <div class="gray-box type4 text-center mt30">
	       <c:out value="${result.meDescription }" />
	    </div>
		<div class="gray-box type2 type3 mt40 clfx">
			<%-- <c:if test="${result.fileCnt ne '0' }">
				<div class="business_guide_slide">
					<div class="slide">
						<div class="business_guide_slide_list">
							<c:forEach var="i" begin="1" end="${result.fileCnt}" >
								<div  class="list">
			    					<img src="/jFile/readAssociationImages.do?fileId=<c:out value='${result.fileId }' />&fileSeq=<c:out value='${i }' />" alt="<c:out value='${i }' />">
			    				</div>
			    			</c:forEach>
						</div>
						<ul class="slick-control">
							<li class="slick-prev"><button>이전 사진으로이동</button></li>
							<li class="slick-stop"><button>사진 자동 롤링 정지</button></li>
							<li class="slick-play"><button>사진 자동 롤링 시작</button></li>
							<li class="slick-next"><button>다음 사진으로이동</button></li>
						</ul>
	               </div>
	           </div>
           </c:if> --%>
           <div class="business_guide_slide">
					<div class="slide">
						<div class="business_guide_slide_list">
							<c:choose>
								<c:when test="${result.fileCnt eq '0' }">
									<div  class="list">
										<img src="${ctx}/resource/templete/cms1/src/img/common/defalut_sub.gif" alt="">
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach var="i" begin="1" end="${result.fileCnt}" >
										<div  class="list">
					    					<img src="/jFile/readAssociationImages.do?fileId=<c:out value='${result.fileId }' />&fileSeq=<c:out value='${i }' />" alt="<c:out value="${menuVO.menuName }" /> 사진 0<c:out value="${i}" />">
					    				</div>
					    			</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
						<ul class="slick-control">
							<li class="slick-prev"><button>이전 사진으로이동</button></li>
							<li class="slick-stop"><button>사진 자동 롤링 정지</button></li>
							<li class="slick-play"><button>사진 자동 롤링 시작</button></li>
							<li class="slick-next"><button>다음 사진으로이동</button></li>
						</ul>
	               </div>
	           </div>
           <div class="content">
               	<h4 class="title">${siteCode eq 'SNIP'? '사업소개':'Business Introduction'}</h4>
				<ul>
					<li class="text">
						<span class="sub-tit">${siteCode eq 'SNIP'? '대 상':'Target'}</span>
						<div class="txt">
							<c:out value="${ufn:stripXss(result.bsTarget)}" escapeXml="false" />
						</div>
					</li>
					<li class="text">
						<span class="sub-tit">${siteCode eq 'SNIP'? '내 용':'Content'}</span>
						<div class="txt">
							<c:out value="${ufn:stripXss(result.bsContent)}" escapeXml="false" />
						</div>
					</li>
					<li class="text">
						<span class="sub-tit">${siteCode eq 'SNIP'? '위 치':'Location'}</span>
						<div class="txt">
							<c:out value="${ufn:stripXss(result.ofLocation)}" escapeXml="false" />
						</div>
					</li>
					<li class="text">
						<span class="sub-tit">${siteCode eq 'SNIP'? '담당자':'Officer in charge'}</span>
						<div class="txt">
							<c:out value="${ufn:stripXss(result.cgInfo)}" escapeXml="false" />
						</div>
					</li>
				</ul>
				<c:if test="${siteCode eq 'SNIP' }">
	                <div class="btn-group mt25">
	                	<c:if test="${ not empty result.bsPuLiUrl}">
	                    	<a href="#" onclick="window.open('<c:out value="${result.bsPuLiUrl }" />')" class="btn btn-blue">사업공고 확인</a>
	                    </c:if>
	                    <c:if test="${ not empty result.hpGlLiUrl}">
	                    	<a href="#" onclick="window.open('<c:out value="${result.hpGlLiUrl }" />')" class="btn btn-dark-green">홈페이지 바로가기</a>
	                    </c:if>
	                </div>
				</c:if>
			</div>
        </div>

		<div class="gray-box busniess_guide-box mt60">
			<div class="busniess_guide-box_inner">
					<c:out value="${result.bdContent }" escapeXml="false" />
			</div>
		</div>
	</div>
	</c:forEach>
</div>