<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%
/**
 * @파일명 : userCominfoView.jsp
 * @파일정보 : 사업신청 > 성남기업소개 > 성남기업 및 상품안내 > 기업정보 조회
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @yjy 2020. 3. 5. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

				<div class="corporation-top_box">
					<p>
						이곳에 게재 된 상품정보는 회원 여러분들께서 직접 올려 주신 자료를 기반으로 생성되었습니다.  이에, 잘못 된 정보를 포함하고 있을 수 있으니 정보 활용에 유의하여 주시기 바라며 성남산업진흥재단은 그에 따른 법적 책임이 없음을 알려드립니다.
					</p>
				</div>

				<div class="gallery-view_img_wrap clfx">
					<div class="gallery-view_rolling">
						<div class="slide">
							<div class="gallery-view_rolling_list">
								<c:if test="${empty result.prdImg01 }">
									<div class="image_list"><div><img src="<c:url value="${ctx}/resource/templete/cms1/src/img/common/defalut_sub.gif" />" alt="<c:out value="${result.prdNm }" />  제품이미지" /></div></div>
								</c:if>
								<c:if test="${not empty result.prdImg01 }">
									<c:choose>
										<c:when test="${ufn:printDatePattern(result.regDt, 'yyyy-MM-dd')>='2020-06-14'}">
											<img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath01,result.prdImg01) }" />" alt="<c:out value="${result.prdNm }" />  제품이미지1" />
										</c:when>
										<c:otherwise>
											<div class="image_list"><div><img src="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',fn:substring(result.prdImgPath01,1,fn:length(result.prdImgPath01)) ,result.prdImg01 ) }" alt="<c:out value="${result.prdNm }" />  제품이미지" /></div></div>
										</c:otherwise>
									</c:choose>
								</c:if>
								<c:if test="${not empty result.prdImg02 }">
									<c:choose>
										<c:when test="${ufn:printDatePattern(result.regDt, 'yyyy-MM-dd')>='2020-06-14'}">
											<img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath02,result.prdImg02) }" />" alt="<c:out value="${result.prdNm }" />  제품이미지1" />
										</c:when>
										<c:otherwise>
											<div class="image_list"><div><img src="<c:url value="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',fn:substring(result.prdImgPath02,1,fn:length(result.prdImgPath02)) ,result.prdImg02 ) }" />" alt="<c:out value="${result.prdNm }" />  제품이미지" /></div></div>
										</c:otherwise>
									</c:choose>
								</c:if>
								<c:if test="${not empty result.prdImg03 }">
									<c:choose>
										<c:when test="${ufn:printDatePattern(result.regDt, 'yyyy-MM-dd')>='2020-06-14'}">
											<img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath03,result.prdImg03) }" />" alt="<c:out value="${result.prdNm }" />  제품이미지1" />
										</c:when>
										<c:otherwise>
											<div class="image_list"><div><img src="<c:url value="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',fn:substring(result.prdImgPath03,1,fn:length(result.prdImgPath03)) ,result.prdImg03 ) }" />" alt="<c:out value="${result.prdNm }" />  제품이미지" /></div></div>
										</c:otherwise>
									</c:choose>

								</c:if>
							</div>
							<ul class="slick-control clfx">
								<li class="slick-prev"><button>이전 이미지</button></li>
								<li class="slick-stop"><button>일시정지</button></li>
								<li class="slick-next"><button>다음 이미지</button></li>
							</ul>
						</div>
					</div>

					<div class="gallery-view_video">
						<div class="gallery-view_video_inner">
							<c:if test="${not empty result.prdVideo01 }">
								<video src="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',fn:substring(result.prdVideoPath01,1,fn:length(result.prdVideoPath01)) ,result.prdVideo01 ) }" width="100%" controls>
										<source src="${result.prdVideo01}" type="video/mp4">
										<source src="${result.prdVideo01 }" type="video/WebM">
										<source src="${result.prdVideo01 }" type="video/ogg">
										해당 브라우져는 비디오태그를 지원하지 않습니다.
									</video>
							</c:if>
						</div>
					</div>
				</div>

				<div class="table-list2 corporation-info_table">
					<table>
						<caption>상품의 상품명, 제품소개, 회사명, 전화번호, 팩스번호, 홈페이지주소에 대한 정보가 기재된표</caption>
						<tbody>
							<tr>
								<th scope="row">상품명</th>
								<td>
									<c:out value="${result.prdNm }" />
								</td>
							</tr>
							<tr>
								<th scope="row">제품소개</th>
								<td>
									<c:out value="${result.prdDescShort }" />
								</td>
							</tr>
							<tr>
								<th scope="row">회사명</th>
								<td>
									<c:out value="${result.comNm }" />
								</td>
							</tr>
							<tr>
								<th scope="row">전화번호</th>
								<td>
									<c:out value="${result.telNo }" />
								</td>
							</tr>
							<tr>
								<th scope="row">팩스번호</th>
								<td>
									<c:out value="${result.faxNo }" />
								</td>
							</tr>
							<tr>
								<th scope="row">회사 홈페이지 </th>
								<td>
									<c:out value="${result.homePage }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-wrap text-r">
                   <a href="#" onclick="fn_goList(); return false;" class="btn btn-gray">목록</a>
               </div>
				<div class="board-bottom">
					<ul class="prev-next-wrap">
					<c:set var="prev" value="" />
					<c:set var="next" value="" />
					<c:forEach var="pn" items="${prevNext }">
						<c:if test="${pn.prevnext eq 'PREV' }">
							<c:set var="prev" value="${pn }" />
						</c:if>
						<c:if test="${pn.prevnext eq 'NEXT' }">
							<c:set var="next" value="${pn }" />
						</c:if>
					</c:forEach>
						<li class="prev">
							<strong>이전글</strong>
							<c:if test="${empty prev }">
								<a href="#none">이전글이 없습니다.</a>
							</c:if>
							<c:if test="${not empty prev }">
								<a href="#none" onclick="fn_goView('<c:out value="${prev.prdNo }" />'); return false;"><c:out value="${prev.prdNm }" /></a>
							</c:if>
						</li>
						<li class="next">
							<strong>다음글</strong>
							<c:if test="${empty next }">
								<a href="#none">다음글이 없습니다.</a>
							</c:if>
							<c:if test="${not empty next }">
								<a href="#none" onclick="fn_goView('<c:out value="${next.prdNo }" />'); return false;"><c:out value="${next.prdNm }" /></a>
							</c:if>
						</li>
					</ul><!--// prev-next-wrap-->
				</div><!--// board-bottom-->

<script>

	var query = "${searchVO.query}";
	function fn_goList(){
		query = ItgJs.fn_replaceQueryString(query, "schM", "list");
		location.href = "?" + query;
	}
	function fn_goView(idx) {
		query = ItgJs.fn_replaceQueryString(query, "schId", idx);
		query = ItgJs.fn_replaceQueryString(query, "schM", "view");
		location.href = "?" + query;
	}

	document.addEventListener("DOMContentLoaded", function(){
		var length = $(".gallery-view_rolling .slick-slide").length;
		if(length == 1){
			$(".gallery-view_rolling .slick-control").hide();
		}
	});

</script>