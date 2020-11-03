<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<!--banner-->

			<div class="family_site_list_wrap rolling-slide">
				<div class="family_site_list">
				<c:forEach var="result" items="${popupBannerList}">
			        <div class="family_logo_list">
			           <c:choose>
			           		 <c:when test="${result.popupLinktype eq '0' }">
				               		<c:if test="${result.uploadType ne 'editor' }">
										 <a href="#none">
									</c:if>
									<c:if test="${result.uploadType eq 'editor' }">
										<div><c:out value="${result.edit_contents }" escapeXml="false"></c:out></div>
									</c:if>
				               </c:when>
				               <c:when test="${result.popupLinktype eq '1' }">
				               		<c:if test="${result.uploadType ne 'editor' }">
									 <a href="<c:out value="${result.popupUrl }" />" onclick="ItgJs.popupCnt('${result.popupIdx}')">
									</c:if>
									<c:if test="${result.uploadType eq 'editor' }">
										<div><c:out value="${result.edit_contents }" escapeXml="false"></c:out></div>
									</c:if>
				               </c:when>
				               <c:when test="${result.popupLinktype eq '2' }">
				               		<c:if test="${result.uploadType ne 'editor' }">
										<a href="<c:out value="${result.popupUrl }" />" onclick="ItgJs.popupCnt('${result.popupIdx}')" target="_blank">
									</c:if>
									<c:if test="${result.uploadType eq 'editor' }">
										<div><c:out value="${result.edit_contents }" escapeXml="false"></c:out></div>
									</c:if>
				               </c:when>
			           </c:choose>
			           <c:choose>
				           <c:when test="${result.uploadType eq 'img' }">
				         		  <img src="${ctx}/comm/download.do?f=<c:out value="${ufn:getDownloadLink('','popup',result.popupImg,result.popupImg) }" />" alt="<c:out value="${result.popupAlt}" />"/></a>
						   </c:when>
						   <c:when test="${result.uploadType eq 'mv' }">
							    <video src="/comm/download.do?f=${ufn:getDownloadLink('','movie',result.mvFile ,result.mvFile) }" width="100%" height="100%" controls>
								  <source src="${result.mvFile}" type="video/mp4">
								  <source src="${result.mvFile}" type="video/WebM">
								  <source src="${result.mvFile}" type="video/ogg">
								  Your browser does not support the video tag.
								</video></a>
							</c:when>
							<c:when test="${result.uploadType eq 'stream' }">
								<iframe width="100%" height="100%" src="https://www.youtube.com/embed/${result.streamUrl}" frameborder="1" allowfullscreen></iframe></a>
							</c:when>
						</c:choose>
					    <c:if test = "${result.popupFile != ''}">
							첨부 파일 : <a href="${ctx}/comm/download.do?f=<c:out value="${ufn:getDownloadLink('','popup',result.popupFile,result.popupFile) }" />" download>${result.oldFileNm} </a>
					    </c:if>
			         </div>
		        </c:forEach>
				</div>
				<div class="slick-control type-s">
					<button type="button" class="slick-prev">이전</button>
					<button type="button" class="slick-play">재생</button>
					<button type="button" class="slick-stop">정지</button>
					<button type="button" class="slick-next">다음</button>
				</div><!--//slick-control-->
			</div>
				<script>
				// partner slider

			        $('.family_site_list').slick({
			            slidesToShow:6,
			            autoplaySpeed:6000,
			            //speed:2000,
			            infinite:true,
			            prevArrow: '.family_site_list_wrap .slick-prev',
			            nextArrow: '.family_site_list_wrap .slick-next',
			            autoplay:true,
			            responsive: [
			                {
			                  breakpoint: 1240,
			                  settings: {
			                    slidesToShow:5
			                  }
			                },
			                {
			                  breakpoint: 1000,
			                  settings: {
			                    slidesToShow:4
			                  }
			                },
							{
			                  breakpoint: 768,
			                  settings: {
			                    slidesToShow:3
			                  }
			                },
			                {
			                  breakpoint: 520,
			                  settings: {
			                    slidesToShow:2
			                  }
			                }
			            ]
			        });

					if($('.family_site_list_wrap .slick-prev').hasClass('slick-hidden')) {
						$('.family_site_list_wrap .slick-play, .family_site_list_wrap .slick-stop').addClass('slick-hidden');
					}
			        /*control*/
			        $('.family_site_list_wrap .slick-stop').on('click', function() {
			        	$('.family_site_list').slick('slickPause');
			            $(this).hide();
			            $('.family_site_list_wrap .slick-play').show();
			        });
			        $('.family_site_list_wrap .slick-play').on('click', function() {
			        	$('.family_site_list').slick('slickPlay');
			            $(this).hide();
			            $('.family_site_list_wrap .slick-stop').show();
			        });
				</script>
