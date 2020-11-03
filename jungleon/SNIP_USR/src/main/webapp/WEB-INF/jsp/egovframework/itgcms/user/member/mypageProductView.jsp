<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
                <h3><c:out value="${result.prdNm }" /> </h3>
				<div class="gallery-view_img_wrap clfx">
					<div class="gallery-view_rolling">
						<div class="slide">
							<div class="gallery-view_rolling_list">
								<%-- <div class="image_list"><div><img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath01,result.prdImg01) }" />" alt="<c:out value="${result.prdNm }" />  제품이미지1" /></div></div>
								<c:if test="${not empty result.prdImg02 }">
									<div class="image_list"><div><img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath02,result.prdImg02) }" />" alt="<c:out value="${result.prdNm }" />  제품이미지2" /></div></div>
								</c:if>
								<c:if test="${not empty result.prdImg03 }">
									<div class="image_list"><div><img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath03,result.prdImg03) }" />" alt="<c:out value="${result.prdNm }" />  제품이미지3" /></div></div>
								</c:if> --%>
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
								<video src="/comm/download.do?f=${ufn:getSnipErpFilePath(result.prdVideoPath01,result.prdVideo01 ) }" width="100%" controls>
										<source src="${result.prdVideo01}" type="video/mp4">
										<source src="${result.prdVideo01 }" type="video/WebM">
										<source src="${result.prdVideo01 }" type="video/ogg">
										해당 브라우져는 비디오태그를 지원하지 않습니다.
									</video>
							</c:if>
							<%-- <img src="../src/img/sub/gallery-list-vedio.jpg" alt="골밀도측정기 제품 동영상" /> --%>
						</div>
					</div>
				</div>

				<h4>기본 정보 </h4>
				<div class="table-list2 corporation-info_table">
					<table>
						<caption>상품분류, 홈페이지, 상세정보에 대한 정보가 기재된표</caption>
						<tbody>
							<tr>
								<th scope="row">상품분류</th>
								<td>
									<c:out value="${result.unNm }" />
								</td>
							</tr>
							<tr>
								<th scope="row">홈페이지</th>
								<td>
									<c:out value="${result.homePage }" />
								</td>
							</tr>
							<tr>
								<th scope="row">상세정보</th>
								<td>
									<c:out value="${result.prdDescShort }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<h4>담당자 정보</h4>
				<div class="table-list2 corporation-info_table">
					<table>
						<caption>담당자명, 전화번호, 팩스번호에 대한 정보가 기재된표</caption>
						<tbody>
							<tr>
								<th scope="row">담당자명</th>
								<td>
									<c:out value="${result.charger }" />
								</td>
							</tr>
							<tr>
								<th scope="row">전화번호</th>
								<td>
									<c:out value="${result.telNo }" />
								</td>
							</tr>
							<tr>
								<th scope="row">팩스번호 </th>
								<td>
									<c:out value="${result.faxNo }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="board-bottom_style1">
					<a href="#none" onclick="fn_goUpdate(); return false;" class="btn btn-blue">수정</a>
					<a href="#none" onclick="fn_goDelete(); return false;" class="btn btn-gray">삭제</a>
					<a href="#none" onclick="fn_goList(); return false;" class="btn list-icon">목록</a>
				</div>

				<script>
					$(function(){
						$(".subcont").addClass("mypage-product_list")
					});
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

					function fn_goUpdate(){
						query = ItgJs.fn_replaceQueryString(query, "schM", "update");
						location.href = "?" + query;
					}

					function fn_goDelete(){
						if(confirm("정말로 삭제하시겠습니까?\n\n삭제된 데이터는 복구 할 수 없습니다.")){
							query = ItgJs.fn_replaceQueryString(query, "schId", "<c:out value="${searchVO.schId}" />");
							query = ItgJs.fn_replaceQueryString(query, "schM", "delete");
							location.href = "?" + query;
						}
					}

				</script>