<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="tempPath" value="WEB-INF/jsp/egovframework/itgcms/user/template"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<script src="${ctx }/resource/common/js/makePCookie.js"></script>
</head>
<body>
<div id="wrap">
	<!-- skip -->
	<div id="accessibility">
		<a href="#section0">본문 바로가기</a>
		<a href="#gnb">주메뉴 바로가기</a>
	</div>
	<!-- //skip -->

	<!-- header -->
	<div class="header__wrap main_header__wrap"> <%-- 메인페이지에만 클래스 추가부탁드립니다 --%>
		<c:import url="include_body_header.jsp" />
	</div>
	<!-- //header -->
<!-- 20200601 태그 위치 이동 및 아이디 추가 -->
<div class="main-anchor" id="container">
	<ul id="menu">
		<li data-menuanchor="main-section_1" class="active"><a href="#main-section_1"><span>Main</span></a></li>
		<li data-menuanchor="main-section_2" ><a href="#main-section_2"><span>사업공고</span></a></li>
		<li data-menuanchor="main-section_3" ><a href="#main-section_3"><span>사업안내</span></a></li>
		<li data-menuanchor="main-section_4" ><a href="#main-section_4"><span>특화사업</span></a></li>
		<li data-menuanchor="main-section_5" ><a href="#main-section_5"><span>전자도서관</span></a></li>
		<li data-menuanchor="main-section_6" ><a href="#main-section_6"><span>팝업존/SNS</span></a></li>
	</ul>
</div>
<!-- //20200601 태그 위치 이동 -->

<div id="fullpage">
		<!-- content -->
		<section class="main-visual_list main-visual sc-box section" id="section0">
			<div class="web">
				<div class="rolling-slide">
				<c:forEach var="result" items="${slidesItemList }">
					<c:choose>
						<c:when test="${result.slitemLinkgubun eq '1' }">
						<a href="#" onclick="window.open('${result.slitemLinkurl}')" title="새창열림"><img style="cursor: pointer;" src="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />" alt="<c:out value="${result.slitemImgalt }" />" /></a>
						</c:when>
						<c:otherwise>
						<div><img src="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />" alt="<c:out value="${result.slitemImgalt }" />" /></div>
						</c:otherwise>
					</c:choose>

				</c:forEach>
				</div>
			</div>

			<div class="mobile">
				<div class="rolling-slide">
					<c:forEach var="result" items="${slidesItemList }">
					<c:choose>
						<c:when test="${result.slitemLinkgubun eq '1' }">
						<a href="#" onclick="window.open('${result.slitemLinkurl}')" title="새창열림"><img style="cursor: pointer;" src="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />" alt="<c:out value="${result.slitemImgalt }" />" /></a>
						</c:when>
						<c:otherwise>
						<div><img src="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />" alt="<c:out value="${result.slitemImgalt }" />" /></div>
						</c:otherwise>
					</c:choose>
					<%-- <div><img src="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />" alt="<c:out value="${result.slitemImgalt }" />" /></div> --%>
				</c:forEach>

				</div>
			</div>
		</section>

		<section class="main_news sc-box section" id="section1">
			<div class="inner">
				<div class="main-cont">
					<div class="title_area">
						<h2 class="main_title">사업공고</h2>
						<p class="main_top_txt">성남 중소기업의 새로운 소식을 만나보세요.</p>
					</div>
					<ul class="main_news-btn-list">
						<li>
							<a href="/${siteCode }/contents/Business1.do">
								<strong>사업공고</strong><span class="more">전체보기</span>
								<span class="lineborder brline-top"></span>
								<span class="lineborder brline-right"></span>
								<span class="lineborder brline-btm"></span>
								<span class="lineborder brline-left"></span>
							</a>
						</li>
						<li class="type2">
							<a href="/${siteCode }/contents/notice11.do">
								<strong>공지사항</strong><span class="more">전체보기</span>
								<span class="lineborder brline-top"></span>
								<span class="lineborder brline-right"></span>
								<span class="lineborder brline-btm"></span>
								<span class="lineborder brline-left"></span>
							</a>
						</li>
						<li class="type3">
							<a href="/${siteCode }/contents/notice12.do">
								<strong>입찰공고</strong><span class="more">전체보기</span>
								<span class="lineborder brline-top"></span>
								<span class="lineborder brline-right"></span>
								<span class="lineborder brline-btm"></span>
								<span class="lineborder brline-left"></span>
							</a>
						</li>
					</ul>
					<ul class="main_news-list">
					<c:forEach var="result" items="${boardList }" end="1">
						<li>
							<a href="https://www.snip.or.kr/${siteCode }/contents/Business1.do?schM=view&schId=${result.snp}" class="more" title="사업공고 더보기">
<%-- 							<c:out value="${result.menuName }" /> 더보기 --%>
								<span class="category cate-purple">사업공고</span>
								<h3><c:out value="${result.title }" /></h3>
								<p>
									<c:out value="${fn:substring(ufn:getAntiHtml(result.contents, '1'), 0, 100) }" />
								</p>
								<span class="date"><c:out value="${fn:substring(result.startdt, 0, 10) }" /> ~ <c:out value="${fn:substring(result.enddt, 0, 10) }" />. ${result.endtm + 1}시 까지</span>
								<span class="lineborder brline-top"></span>
								<span class="lineborder brline-right"></span>
								<span class="lineborder brline-btm"></span>
								<span class="lineborder brline-left"></span>
							</a>
						</li>
					</c:forEach>
					<c:forEach var="result" items="${boardList }" begin="4" end="4">
						<li>
							<a href="/${siteCode }/contents/${result.menuCode}.do?schM=view&id=${result.bdIdx}" class="more" title="${result.menuName } 더보기">
<%-- 							<c:out value="${result.menuName }" /> 더보기 --%>
								<span class="category <c:out value="${ufn:deCode(result.menuCode, 'notice11,cate-blue,Business1,cate-purple,notice12,cate-green', 'cate-blue') }" />"><c:out value="${result.menuName }" /></span>
								<h3><c:out value="${result.bdTitle }" /></h3>
								<p>
									<c:out value="${fn:substring(ufn:getAntiHtml(result.bdContent, '1'), 0, 100) }" />
								</p>
								<span class="date"><c:out value="${fn:substring(result.regdt, 0, 10) }" /></span>
								<span class="lineborder brline-top"></span>
								<span class="lineborder brline-right"></span>
								<span class="lineborder brline-btm"></span>
								<span class="lineborder brline-left"></span>
							</a>
						</li>
					</c:forEach>
					<c:forEach var="result" items="${boardList }" begin="2" end="3">
						<li>
							<a href="https://www.snip.or.kr/${siteCode }/contents/Business1.do?schM=view&schId=${result.snp}" class="more" title="사업공고 더보기">
<%-- 							<c:out value="${result.menuName }" /> 더보기 --%>
								<span class="category cate-purple">사업공고</span>
								<h3><c:out value="${result.title }" /></h3>
								<p>
									<c:out value="${fn:substring(ufn:getAntiHtml(result.contents, '1'), 0, 100) }" />
								</p>
								<span class="date"><c:out value="${fn:substring(result.startdt, 0, 10) }" /> ~ <c:out value="${fn:substring(result.enddt, 0, 10) }" />. ${result.endtm }시 까지</span>
								<span class="lineborder brline-top"></span>
								<span class="lineborder brline-right"></span>
								<span class="lineborder brline-btm"></span>
								<span class="lineborder brline-left"></span>
							</a>
						</li>
					</c:forEach>
					<c:forEach var="result" items="${boardList }" begin="5" end="5">
						<li>
							<a href="/${siteCode }/contents/${result.menuCode}.do?schM=view&id=${result.bdIdx}" class="more" title="${result.menuName } 더보기">
<%-- 							<c:out value="${result.menuName }" /> 더보기 --%>
								<span class="category <c:out value="${ufn:deCode(result.menuCode, 'notice11,cate-blue,Business1,cate-purple,notice12,cate-green', 'cate-blue') }" />"><c:out value="${result.menuName }" /></span>
								<h3><c:out value="${result.bdTitle }" /></h3>
								<p>
									<c:out value="${fn:substring(ufn:getAntiHtml(result.bdContent, '1'), 0, 100) }" />
								</p>
								<span class="date"><c:out value="${fn:substring(result.regdt, 0, 10) }" /></span>
								<span class="lineborder brline-top"></span>
								<span class="lineborder brline-right"></span>
								<span class="lineborder brline-btm"></span>
								<span class="lineborder brline-left"></span>
							</a>
						</li>
					</c:forEach>
					</ul>
				</div>
			</div>
		</section>

		<section class="main_mission sc-box section"  id="section2">
			<div class="main-cont">
				<div class="title_area">
					<h2 class="main_title">사업안내</h2>
					<p class="main_top_txt">2020 중소벤처기업 혁신성장 지원사업 안내</p>
				</div>

				<div class="main_mission-cont">
					<!-- 성장 단계별 지원 -->
					<h3 class="main_mission_title1"><a href="#" class="main_mission_title tabOn">성장 단계별 지원</a></h3>
					<div class="main-mission_step main-mission_cont tabOn">
						<!-- 창업아이템 사업화 -->
						<h4 class="main-mission_step_title1"><a href="#" class="main-mission_step_title tabOn"><span>창업아이템 사업화 <br />(예비창업)</span></a></h4>
						<div class="main-mission_item tabOn main-mission_step_cont">
							<!-- 공간 -->
							<h5 class="main-mission_item_title1 on"><a href="#" class="main-mission_item_title tabOn">공간</a></h5>
							<div class="main_mission_step main-mission_item_cont tabOn">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_1">
									<c:forEach var="result" items="${totalTB_1 }">
									<c:if test="${'section0101' eq result.gpName }">
										<div class="list">
											<div class="list-inner">
												<h6><c:out value="${result.bsName }" /></h6>
												<span class="area_month">
												<c:choose>
		                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
				                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
		                                        	</c:when>
		                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
				                                        [<c:out value="${result.bsLocation }" /> ]
		                                        	</c:when>
		                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
				                                        [<c:out value="${result.bsPeriod }" />]
		                                        	</c:when>
		                                        </c:choose>
												</span>
											</div>
											<c:if test="${not empty result.menuCode }">
												<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
											</c:if>
										</div>
									</c:if>
									</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 공간 -->

							<!-- 기술개발 -->
							<h5 class="main-mission_item_title2"><a href="#" class="main-mission_item_title">기술개발</a></h5>
							<div class="main_mission_step main-mission_item_cont main-mission_step_cont">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_2">
									<c:forEach var="result" items="${totalTB_1 }">
									<c:if test="${'section0102' eq result.gpName }">
										<div class="list">
											<div class="list-inner">
												<h6><c:out value="${result.bsName }" /></h6>
												<span class="area_month">
												<c:choose>
		                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
				                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
		                                        	</c:when>
		                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
				                                        [<c:out value="${result.bsLocation }" /> ]
		                                        	</c:when>
		                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
				                                        [<c:out value="${result.bsPeriod }" />]
		                                        	</c:when>
		                                        </c:choose>
												</span>
											</div>
											<c:if test="${not empty result.menuCode }">
												<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
											</c:if>
										</div>
									</c:if>
									</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 기술개발 -->

							<!-- 자금지원 -->
							<h5 class="main-mission_item_title3"><a href="#" class="main-mission_item_title">자금지원</a></h5>
							<div class="main_mission_step main-mission_item_cont main-mission_step_cont">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_3">
										<c:forEach var="result" items="${totalTB_1 }">
										<c:if test="${'section0103' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 자금지원 -->

							<!-- 사업화 -->
							<h5 class="main-mission_item_title4 "><a href="#" class="main-mission_item_title">사업화</a></h5>
							<div class="main_mission_step main-mission_item_cont main-mission_step_cont">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_4">
										<c:forEach var="result" items="${totalTB_1 }">
										<c:if test="${'section0104' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 사업화 -->

							<!-- 네트워크 -->
							<h5 class="main-mission_item_title5"><a href="#" class="main-mission_item_title">네트워크</a></h5>
							<div class="main_mission_step main-mission_item_cont">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_5">
										<c:forEach var="result" items="${totalTB_1 }">
										<c:if test="${'section0105' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 네트워크 -->
						</div>
						<!-- //창업아이템 사업화 -->

						<!-- 생존과 성장 -->
						<h4 class="main-mission_step_title2"><a href="#" class="main-mission_step_title"><span>생존과 성장 <br />(창업 ~ 창업 3년 미만)</span></a></h4>
						<div class="main-mission_item main-mission_step_cont">
							<!-- 공간 -->
							<h5 class="main-mission_item_title1 on "><a href="#" class="main-mission_item_titleA tabOn">공간</a></h5>
							<div class="main_mission_step main-mission_item_contA tabOn">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_6">
										<c:forEach var="result" items="${totalTB_2 }">
										<c:if test="${'section0101' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 공간 -->

							<!-- 기술개발 -->
							<h5 class="main-mission_item_title2"><a href="#" class="main-mission_item_titleA">기술개발</a></h5>
							<div class="main_mission_step main-mission_item_contA">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_7">
										<c:forEach var="result" items="${totalTB_2 }">
										<c:if test="${'section0102' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 기술개발 -->

							<!-- 자금지원 -->
							<h5 class="main-mission_item_title3"><a href="#" class="main-mission_item_titleA">자금지원</a></h5>
							<div class="main_mission_step main-mission_item_contA">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_8">
										<c:forEach var="result" items="${totalTB_2 }">
										<c:if test="${'section0103' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 자금지원 -->

							<!-- 사업화 -->
							<h5 class="main-mission_item_title4"><a href="#" class="main-mission_item_titleA">사업화</a></h5>
							<div class="main_mission_step main-mission_item_contA">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_9">
										<c:forEach var="result" items="${totalTB_2 }">
										<c:if test="${'section0104' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 사업화 -->

							<!-- 네트워크 -->
							<h5 class="main-mission_item_title5"><a href="#" class="main-mission_item_titleA">네트워크</a></h5>
							<div class="main_mission_step main-mission_item_contA">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_10">
										<c:forEach var="result" items="${totalTB_2 }">
										<c:if test="${'section0105' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 네트워크 -->
						</div>
						<!-- //생존과 성장 -->

						<!-- 혁신성장 -->
						<h4 class="main-mission_step_title3"><a href="#" class="main-mission_step_title"><span>혁신성장 <br />(창업 3년 이상 ~  <br />창업 7년 미만)</span></a></h4>
						<div class="main-mission_item main-mission_step_cont">
							<!-- 공간 -->
							<h5 class="main-mission_item_title1 on"><a href="#" class="main-mission_item_titleB tabOn">공간</a></h5>
							<div class="main_mission_step main-mission_item_contB tabOn">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_11">
										<c:forEach var="result" items="${totalTB_3 }">
										<c:if test="${'section0101' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 공간 -->

							<!-- 기술개발 -->
							<h5 class="main-mission_item_title2"><a href="#" class="main-mission_item_titleB">기술개발</a></h5>
							<div class="main_mission_step main-mission_item_contB">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_12">
										<c:forEach var="result" items="${totalTB_3 }">
										<c:if test="${'section0102' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 기술개발 -->

							<!-- 자금지원 -->
							<h5 class="main-mission_item_title3"><a href="#" class="main-mission_item_titleB">자금지원</a></h5>
							<div class="main_mission_step main-mission_item_contB">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_13">
										<c:forEach var="result" items="${totalTB_3 }">
										<c:if test="${'section0103' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 자금지원 -->

							<!-- 사업화 -->
							<h5 class="main-mission_item_title4"><a href="#" class="main-mission_item_titleB">사업화</a></h5>
							<div class="main_mission_step main-mission_item_contB">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_14">
										<c:forEach var="result" items="${totalTB_3 }">
										<c:if test="${'section0104' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 사업화 -->

							<!-- 네트워크 -->
							<h5 class="main-mission_item_title5"><a href="#" class="main-mission_item_titleB">네트워크</a></h5>
							<div class="main_mission_step main-mission_item_contB">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_15">
										<c:forEach var="result" items="${totalTB_3 }">
										<c:if test="${'section0105' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 네트워크 -->
						</div>
						<!-- //혁신성장 -->

						<!-- 도약 글로벌 진출 -->
						<h4 class="main-mission_step_title4"><a href="#" class="main-mission_step_title"><span>도약 글로벌 진출 <br />(창업 7년 이상)</span></a></h4>
						<div class="main-mission_item main-mission_step_cont">
							<!-- 공간 -->
							<h5 class="main-mission_item_title1 on"><a href="#" class="main-mission_item_titleC tabOn">공간</a></h5>
							<div class="main_mission_step main-mission_item_contC tabOn">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_16">
										<c:forEach var="result" items="${totalTB_4 }">
										<c:if test="${'section0101' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 공간 -->

							<!-- 기술개발 -->
							<h5 class="main-mission_item_title2"><a href="#" class="main-mission_item_titleC">기술개발</a></h5>
							<div class="main_mission_step main-mission_item_contC">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_17">
										<c:forEach var="result" items="${totalTB_4 }">
										<c:if test="${'section0102' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 기술개발 -->

							<!-- 자금지원 -->
							<h5 class="main-mission_item_title3"><a href="#" class="main-mission_item_titleC">자금지원</a></h5>
							<div class="main_mission_step main-mission_item_contC">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_18">
										<c:forEach var="result" items="${totalTB_4 }">
										<c:if test="${'section0103' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 자금지원 -->

							<!-- 사업화 -->
							<h5 class="main-mission_item_title4 "><a href="#" class="main-mission_item_titleC">사업화</a></h5>
							<div class="main_mission_step main-mission_item_contC">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_19">
										<c:forEach var="result" items="${totalTB_4 }">
										<c:if test="${'section0104' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 사업화 -->

							<!-- 네트워크 -->
							<h5 class="main-mission_item_title5"><a href="#" class="main-mission_item_titleC">네트워크</a></h5>
							<div class="main_mission_step main-mission_item_contC">
								<div class="rolling-slide">
									<div class="main_mission_step_list main_mission_step_list_20">
										<c:forEach var="result" items="${totalTB_4 }">
										<c:if test="${'section0105' eq result.gpName }">
											<div class="list">
												<div class="list-inner">
													<h6><c:out value="${result.bsName }" /></h6>
													<span class="area_month">
													<c:choose>
			                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
					                                        [<c:out value="${result.bsLocation }" /> ]
			                                        	</c:when>
			                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
					                                        [<c:out value="${result.bsPeriod }" />]
			                                        	</c:when>
			                                        </c:choose>
													</span>
												</div>
												<c:if test="${not empty result.menuCode }">
													<div class="more"><a href="/${siteCode}/contents/${result.menuCode}.do" title="해당게시물 페이지로 이동">자세히보기</a></div>
												</c:if>
											</div>
										</c:if>
										</c:forEach>
									</div>
									<ul class="slick-arrow-wrap">
										<li><button type="button" class="slick-prev">이전목록으로</button></li>
										<li><button type="button" class="slick-next">다음목록으로</button></li>
									</ul>
								</div>
							</div>
							<!-- 네트워크 -->
						</div>
						<!-- //도약 글로벌 진출 -->

						<div class="total_table_link">
							<a href="/${siteCode}/contents/Guidance5.do" title="총괄표 페이지로 이동"><span>총괄표</span></a>
						</div>
					</div>
					<!-- //성장 단계별 지원 -->

					<!-- 분야별 솔루션 -->
					<h3 class="main_mission_title2"><a href="#" class="main_mission_title">분야별 솔루션</a></h3>
					<div class="main_department_wrap main-mission_cont">
						<ul class="main-mission_list main_department_list clfx">
							<li>
								<a href="/SNIP/contents/Guidance11.do">
									<span class="title">스타트업</span>
									<span class="en_title">
										LH창업지원주택'창업지원시설'운영성남창업센터 운영 <br />성남 창업경연대회 개회
									</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance71.do">
									<span class="title">기술 개발</span>
									<span class="en_title">
										차세대 ICT연구센터 운영  <br />
										K-GLOBAL 사업 <br />
										메디바이오 헬스케어 융합지원
									</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance82.do">
									<span class="title">기술 사업화</span>
									<span class="en_title">
										기관 연계 기술 및 장비 활용 <br />
										Bio헬스케어산업 성장단계별 육성 <br />
										지역혁신형 스마트시티 기반 조성
									</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance91.do">
									<span class="title">펀드투자</span>
									<span class="en_title">
										성남창업펀드 <br />
										성남벤처펀드
									</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance21.do">
									<span class="title">스케일업</span>
									<span class="en_title">
										글로벌 수출기업 육성 / 해외 전시 성남관 등 운영 <br />
										국내 유망전시회 참가 지원 <br />
										성남특허은행 운영
									</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance101.do">
									<span class="title">협력 생태계조성</span>
									<span class="en_title">
										드론사업 미니클러스터 <br />
										메디바이오 미니클로스터 <br />
										성남 e스포츠페스티벌
									</span>
								</a>
							</li>
						</ul>
					</div>
					<!-- //분야별 솔루션 -->

					<!-- 부서별 접수 -->
					<h3 class="main_mission_title3"><a href="#" class="main_mission_title">부서별 접수</a></h3>
					<div class="main_department_wrap main-mission_cont">
						<ul class="main_department_list clfx">
							<li>
								<a href="/SNIP/contents/Guidance6.do#totalgroup01" class="inner">
									<span class="title">외부자원유치단</span>
									<span class="en_title">Business Partnership Department</span>
								</a>
							</li>
							<!-- <li>
								<a href="/SNIP/contents/Guidance6.do#totalgroup02" class="inner">
									<span class="title">경영기획부</span>
									<span class="en_title">Administration &amp; Planning Department</span>
								</a>
							</li> -->
							<li>
								<a href="/SNIP/contents/Guidance6.do#totalgroup03" class="inner">
									<span class="title">정책연구부</span>
									<span class="en_title">Policy Research Department</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance6.do#totalgroup04" class="inner">
									<span class="title">사업지원부</span>
									<span class="en_title">Business Partnership Department</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance6.do#totalgroup05" class="inner">
									<span class="title">기업성장부</span>
									<span class="en_title">Administration &amp; Planning Department</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance6.do#totalgroup06" class="inner">
									<span class="title">창업성장부</span>
									<span class="en_title">Policy Research Department</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance6.do#totalgroup07" class="inner">
									<span class="title">ICT산업부</span>
									<span class="en_title">Business Partnership Department</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance6.do#totalgroup08" class="inner">
									<span class="title">바이오헬스산업부</span>
									<span class="en_title">Administration &amp; Planning Department</span>
								</a>
							</li>
							<li>
								<a href="/SNIP/contents/Guidance6.do#totalgroup09" class="inner">
									<span class="title">콘텐츠산업부</span>
									<span class="en_title">Policy Research Department</span>
								</a>
							</li>
						</ul>
					</div>
					<!-- //부서별 접수 -->
				</div>
			</div>
		</section>

		<section class="main_business sc-box section" id="section3">
			<div class="main-cont">
				<div class="title_area">
					<h2 class="main_title">특화사업</h2>
				</div>
				<div class="rolling-slide">
					<div class="main_business-list">
						<div class="list">
							<h3><span>성남 벤처펀드</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img1.jpg" alt="성남 벤처펀드 썸네일" />
							</div>
							<div class="more">
								<a href="/SNIP/contents/Guidance91.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>

						<div class="list">
							<h3><span>성남 특허은행</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img2.jpg" alt="성남 특허은행 썸네일" />
							</div>
							<div class="more">
								<a href="/SNIP/contents/Guidance21.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>

						<div class="list">
							<h3><span>SOS 현장 기동대</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img3.jpg" alt="SOS 현장 기동대썸네일" />
							</div>
							<div class="more">
								<a href="/SNIP/contents/Guidance107.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>

						<div class="list">
							<h3><span>글로벌 수출기업 육성</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img4.jpg" alt="글로벌 수출기업 육성 썸네일" />
							</div>
							<div class="more">
								<a href="/SNIP/contents/Guidance221.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>

						<div class="list">
							<h3><span>국내 판로 개척 지원</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img5.jpg" alt="국내 판로 개척 지원 썸네일" />
							</div>
							<div class="more">
								<a href="/SNIP/contents/Guidance231.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>

						<div class="list">
							<h3><span>글로벌 콘텐츠 육성 지원</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img6.jpg" alt="글로벌 콘텐츠 육성 지원 썸네일" />
							</div>
							<div class="more">
								<a href="/SNIP/contents/Guidance116.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>

						<div class="list">
							<h3><span>콘텐츠 기업 종합지원</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img7.jpg" alt="콘텐츠 기업 종합지원 썸네일" />
							</div>
							<div class="more">
								<a href="/SNIP/contents/Guidance87.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>

						<div class="list">
							<h3><span>콘텐츠기업 특별금융지원</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img8.jpg" alt="콘텐츠기업 특별금융지원 썸네일" />
							</div>
							<div class="more">
								<a href="/SNIP/contents/Guidance92.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>

						<div class="list">
							<h3><span>성남 바이오헬스<br>생태계 육성</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img9.jpg" alt="성남 바이오헬스 생태계 육성 썸네일" />
							</div>
							<div class="more">
								<a href="/SNIP/contents/Guidance101.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>

						<div class="list">
							<h3><span>창업기업 멘토링 지원</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img10.jpg" alt="창업기업 멘토링 지원 썸네일" />
							</div>
							<div class="more">
								<a href="/SNIP/contents/Guidance17.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>

						<div class="list">
							<h3><span>비즈메이트</span></h3>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_business_img11.jpg" alt="비즈메이트 썸네일" />
							</div>
							<div class="more">
								<a href="https://snbizmate.snventure.net/app/main/main.php" target="_blank" title="새창열림"><span>바로가기</span></a>
							</div>
						</div>
					</div>
					<ul class="slick-arrow-wrap">
						<li><button type="button" class="slick-prev">이전목록으로</button></li>
						<li><button type="button" class="slick-next">다음목록으로</button></li>
					</ul>
				</div>
			</div>
		</section>

		<section class="main_library sc-box section" id="section4">
			<div class="main-cont">
				<div class="title_area">
					<h2 class="main_title">전자도서관</h2>
				</div>
				<div class="rolling-slide">
					<div class="main_library-list">
					<%-- 단순히 두번 반복을 위한 Loop. 롤링이 되게하려면 두배로 출력해야 함. --%>
					<c:forEach var="i" begin="1" end="2" step="1">
						<div class="list">
							<h3>SAE MOBILUS</h3>
							<p>글로벌 기술표준정보<br />(무료 SAE)</p>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_library_img1.jpg" alt="SAE MOBILUS 썸네일" />
							</div>
							<div class="more">
								<a href="/${siteCode}/contents/Participation24.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>
						<div class="list">
							<h3>e-Magazine</h3>
							<p>전자 잡지 <br />(무료 모아진) </p>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_library_img2.jpg" alt="e-Magazine 썸네일" />
							</div>
							<div class="more">
								<a href="/${siteCode}/contents/Participation23.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>
						<div class="list">
							<h3>e-Book</h3>
							<p>전자 도서 <br />(무료 교보문고)</p>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_library_img3.jpg" alt="e-Book 썸네일" />
							</div>
							<div class="more">
								<a href="/${siteCode}/contents/Participation21.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>
							</div>
						</div>
						<div class="list">
							<h3>SERICEO</h3>
							<p>영상 콘텐츠 <br />(무료 세리시이오)</p>
							<div class="img_area">
								<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_library_img4.jpg" alt="e-Book 썸네일" />
							</div>
							<div class="more">
								<a href="/${siteCode}/contents/Participation22.do" title="해당 게시물 페이지로 이동"><span>바로가기</span></a>

							</div>
						</div>
					</c:forEach>
					</div>
					<ul class="slick-arrow-wrap">
						<li><button type="button" class="slick-prev">이전목록으로</button></li>
						<li><button type="button" class="slick-next">다음목록으로</button></li>
					</ul>
				</div>
			</div>
		</section>
		<section class="main_popupzone sc-box section"  id="section5">
			<div class="main-cont">
				<div class="title_area">
					<h2 class="main_title">팝업존 / SNS</h2>
				</div>
				<div class="clfx">
					<!-- popupzone -->
					<div class="m_popupzone">
						<h3>POPUPZONE</h3>
						<div class="rolling-slide">
							<div class="m_popupzone_list">
							<c:forEach var="result" items="${popupzoneList}">
									<div class="list">
									<c:choose>
										<c:when test="${result.uploadType eq 'editor' }">
												<c:out value="${result.edit_contents }" escapeXml="false"></c:out>
										</c:when>
										<c:otherwise>
											<c:choose>
								               	<c:when test="${result.popupLinktype eq '0' }">
												<a href="#none">
								               	</c:when>
								               	<c:when test="${result.popupLinktype eq '1' }">
												<a href="<c:out value="${result.popupUrl }" />" onclick="ItgJs.popupCnt('${result.popupIdx}')">
								               	</c:when>
								               	<c:when test="${result.popupLinktype eq '2' }">
												<a href="<c:out value="${result.popupUrl }" />" onclick="ItgJs.popupCnt('${result.popupIdx}')" target="_blank" title="새창열림">
								               	</c:when>
								           	</c:choose>
										</c:otherwise>
									</c:choose>
									<c:choose>
									    <c:when test="${result.uploadType eq 'img' }">
													<img src="${ctx}/comm/download.do?f=<c:out value="${ufn:getDownloadLink('','popup',result.popupImg,result.popupImg) }" />" alt="<c:out value="${result.popupAlt}" />"></a>
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
													첨부 파일 : <a href="${ctx}/comm/download.do?f=<c:out value="${ufn:getDownloadLink('','popup',result.popupFile,result.popupFile) }" />" download title="파일다운">${result.oldFileNm} </a>
									</c:if>
											</div>
							</c:forEach>
							</div>
							<!-- 20200527 재생 정지버튼 추가 -->
							<div class="main_popupzone_controll">
								<ul>
									<li><button class="slick-stop">일시정지</button></li>
									<li><button class="slick-play">자동재생</button></li>
								</ul>
							</div>
							<!-- //20200527 재생 정지버튼 추가 -->
						</div>
					</div>
					<!-- //popupzone -->

					<!-- news -->
					<div class="m_btm_news">
						<h3>NEWS</h3>
						<div class="m_news_list_wrap">
							<div class="rolling-slide">
								<div class="m_news_list">
								<c:forEach var="result" items="${newBoardList }" >
									<div class="list">
										<div class="img_area">
											<a href="/${siteCode}/contents/Participation12.do?id=${result.bdIdx}&schM=view">
											<c:set var="file" value="${result.bdThumb1 }" />
											<c:set var="alt" value="${result.bdTitle }" />
												<c:choose>
													<c:when test="${fn:contains(file,'WEBROOT_NEW')}">
														<img src="<c:url value="/comm/viewImage2.do?f=${ufn:getDownloadLink('','gallery',file,'thumb') }" />" class="img" alt="<c:out value="${ufn:quot(alt) } 행사사진" />">
													</c:when>
													<c:otherwise>
												        <img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','gallery',file,'thumb') }" />" class="img" alt="<c:out value="${ufn:quot(alt) } 행사사진" />">
													</c:otherwise>
												</c:choose>
											</a>
										</div>
										<div class="txt_area">
											<div class="txt">${result.bdTitle }</div>
											<span class="date"><c:out value="${fn:substring(result.regdt, 0, 10) }" /></span>
											<a href="/${siteCode}/contents/Participation12.do?id=${result.bdIdx}&schM=view" class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_more.png" alt="해당게시물 페이지로 이동" /></a>
										</div>
									</div>
								</c:forEach>
								</div>
								<!-- 20200527 재생 정지버튼 추가 -->
								<ul class="slick-arrow-wrap">
									<li><button type="button" class="slick-prev">이전목록으로</button></li>
									<li><button type="button" class="slick-next">다음목록으로</button></li>
									<li><button type="button" class="slick-stop">일시정지</button></li>
									<li><button type="button" class="slick-play">자동재생</button></li>
								</ul>
								<!-- //20200527 재생 정지버튼 추가 -->
							</div>
						</div>

						<div class="more2"><a href="/${siteCode}/contents/Participation12.do" title="news 페이지로 이동"><span>더보기</span></a></div>
					</div>
					<!-- //news -->
				</div>

				<div class="main_sns_area">
					<div class="title_area">
						<h3>SNS</h3>
					</div>


					<!-- facebook -->
					<h4 class="m_sns_title1"><a href="#" class="tabOn m_sns_title"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/sns_facebook.png" alt="성남진흥원 facebook" /></a></h4>
					<div class="m_sns_cont main_facebook tabOn">
						<div class="rolling-slide">
							<div class="main_sns-list main_sns-list_1" id="facebook-list">

							</div>
							<ul class="slick-arrow-wrap">
								<li><button type="button" class="slick-prev">이전목록으로</button></li>
								<li><button type="button" class="slick-next">다음목록으로</button></li>
							</ul>
							<!-- 20200527 재생 정지버튼 추가 -->
							<ul class="slick-arrow-controll">
								<li><button type="button" class="slick-stop">일시정지</button></li>
								<li><button type="button" class="slick-play">자동재생</button></li>
							</ul>
							<!-- //20200527 재생 정지버튼 추가 -->
						</div>
					</div>
					<!-- facebook -->

					<!-- twitter -->
 					<h4 class="m_sns_title2"><a href="#" class="m_sns_title"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/sns_twitter.png" alt="성남진흥원 twitter" /></a></h4>
 					<div class="m_sns_cont main_twitter">
 						<div class="rolling-slide">
							<div class="main_sns-list main_sns-list_2">
 								<c:out value="${twitterRss }" escapeXml="false" />
							</div>
							<ul class="slick-arrow-wrap">
								<li><button type="button" class="slick-prev">이전목록으로</button></li>
								<li><button type="button" class="slick-next">다음목록으로</button></li>
							</ul>
							<!-- 20200527 재생 정지버튼 추가 -->
							<ul class="slick-arrow-controll">
								<li><button type="button" class="slick-stop">일시정지</button></li>
								<li><button type="button" class="slick-play">자동재생</button></li>
							</ul>
							<!-- //20200527 재생 정지버튼 추가 -->
						</div>
 					</div>
					<!-- twitter -->

					<!-- blog -->
					<h4  class="m_sns_title3"><a href="#" class="m_sns_title"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/sns_blog.png" alt="성남진흥원 blog" /></a></h4>
					<div class="m_sns_cont main_blog">
						<div class="rolling-slide">
							<div class="main_sns-list main_sns-list_3">
 								<c:out value="${naverBlog }" escapeXml="false" />
							</div>
							<ul class="slick-arrow-wrap">
								<li><button type="button" class="slick-prev">이전목록으로</button></li>
								<li><button type="button" class="slick-next">다음목록으로</button></li>
							</ul>
							<!-- 20200527 재생 정지버튼 추가 -->
							<ul class="slick-arrow-controll">
								<li><button type="button" class="slick-stop">일시정지</button></li>
								<li><button type="button" class="slick-play">자동재생</button></li>
							</ul>
							<!-- //20200527 재생 정지버튼 추가 -->
						</div>
					</div>
					<!-- blog -->

					<!-- youtube -->
					<h4 class="m_sns_title4"><a href="#" class="m_sns_title"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/sns_youtube.png" alt="성남진흥원 youtube" /></a></h4>
					<div class="m_sns_cont main_youtube">
						<div class="rolling-slide ">
							<div class="main_sns-list main_sns-list_4">
								<c:out value="${youtubePlayList }" escapeXml="false" />
							</div>
							<ul class="slick-arrow-wrap">
								<li><button type="button" class="slick-prev">이전목록으로</button></li>
								<li><button type="button" class="slick-next">다음목록으로</button></li>
							</ul>
							<!-- 20200527 재생 정지버튼 추가 -->
							<ul class="slick-arrow-controll">
								<li><button type="button" class="slick-stop">일시정지</button></li>
								<li><button type="button" class="slick-play">자동재생</button></li>
							</ul>
							<!-- //20200527 재생 정지버튼 추가 -->
						</div>
					</div>
					<!-- youtube -->
				</div>
			</div>
		</section>
		<!-- //content -->

	<div class="footer_area fp-auto-height section">
		<section class="main-link" id="section6">
			<div class="main-cont">
				<ul class="main-link_list clfx">
					<li class="main_link_icon1"><a href="/SNIP/contents/Guidance41.do">비즈니스센터</a></li>
					<li class="main_link_icon2"><a href="/SNIP/contents/Guidance44.do">성남창업센터</a></li>
					<li class="main_link_icon3"><a href="/SNIP/contents/Guidance43.do">성남메디바이오 <br />캠퍼스</a></li>
					<li class="main_link_icon4"><a href="http://www.connect21.or.kr/kr/" target="_blank" title="새창연결">성남 차세대 융합 <br />콘텐츠 캠퍼스</a></li>
					<li class="main_link_icon5"><a href="/SNIP/contents/Guidance46.do">콘텐츠 특화 <br />지원센터</a></li>
					<li class="main_link_icon6"><a href="/SNIP/contents/Guidance491.do">소공인 특화 <br />지원센터</a></li>
				</ul>
			</div>
		</section>

		<!-- family_site -->
		<div class="family_site_wrap" id="bannerDiv">
		</div>
		<!-- //family_site -->

		<c:import url="include_body_footer.jsp" />
	</div>
</div>
</div>

<script>
$(document).ready(function(){

	$("#bannerDiv").load("/comm/banner.ajax");

	$.ajax({
		url: "/comm/getFB.ajax",
		data: "",
		dataType: "json",
		type: "post",
		success: function(resultData) {
			if(resultData.data.length > 0) {
				var resultPosts = resultData.data;
				var html = "";
				for(var i = 0; i < resultPosts.length; i++) {
					for(var j = 0; j < resultPosts[i].attachments.data.length; j++) {
						result = resultPosts[i].attachments.data;
						if(result[j].media == undefined) continue;
						var desc = "";
						if(result[j].description != undefined && result[j].description != ""){
							var arrDesc = result[j].description.split("\n");
							var descCnt = 0;
							for(kk = 0; kk < arrDesc.length; kk++) {
								if(arrDesc[kk].length > 0 && arrDesc[kk].charAt(0) != "#") {
									desc += arrDesc[kk] + " ";
									descCnt ++;
								}
								if(descCnt > 2) break;
							}
						}
						var dateStr = "";
						if(resultPosts[i].created_time != undefined) {
							dateStr = getDate4FB(resultPosts[i].created_time, "mm월 dd일 HH시 MM분", 12);
						}
						html += "<div class=\"list\">" +
						"									<div class=\"img_area\">" +
						"										<a href=\""+result[j].url+"\" target=\"_blank\">" +
						"											<img src=\""+result[j].media.image.src+"\" alt=\""+desc+"\" />" +
						"										</a>" +
						"									</div>" +
						"									<div class=\"txt_area\">" +
						//"										<a href=\""+result[j].url+"\" class=\"title\"  target=\"_blank\" title=\"해당게시물 페이스북 페이지로 새창으로 이동\" target=\"_blank\">" +
						"											"+desc.substring(0,30)+"..."+
						//"										</a>" +
						"										<span class=\"date\">" + dateStr + "</span>" +
						"									</div>" +
						"								</div>";
					}
				}
				$("#facebook-list").html(html);
				mainSlider('.main_sns-list_1','4','3','2',false,true,false); //sns
			} else {

			}
		}
	});

	mainSlider('.m_popupzone_list','1','1','1',false,true,true); //POPUPZONE
	mainSlider('.m_news_list','3','3','2',false,true,false); //news
	/*mainSlider('.main_sns-list_1','4','3','2',false,true,false); //facebook sns */
	mainSlider('.main_sns-list_2','4','3','2',false,true,false); //sns
	mainSlider('.main_sns-list_3','4','3','2',false,true,false); //sns
	mainSlider('.main_sns-list_4','4','3','2',false,true,false); //sns
})

</script>
<script type="text/javascript">
function windowOpenLoginPage()
{
	//var url = "https://www.snventure.net/vnet/fe/login/ER_loginForm.do?return_url="+Url.get_origin()+"/kr/login/login.html";
	var url = "http://localhost/SNIP/module/open_loginForm.do?return_url=https://www.jungleon.or.kr/kr/login/login.html";
	var objArgument = {
						'method'	: 'get',	// 디폴트: 'data' 존재 O => post, 존재 X => get
						'action'	: url,
						'data'		: '',
						'target'	: 'login_form',	// _blank, _parent, _self, _top, 이름
						'specs'		: { 'left'		: 10,
										'top'		: 100,
										'width'		: 610,
										'height'	: 540
										}
					};
	open_popup(objArgument);
}
function __extend_html_url(page_url,input_param)
{
	var page_full_url = '';

	var argument_list = "";
	if( typeof input_param ==='undefined' )
		argument_list = "";
	else if( typeof input_param ==='object' )
		argument_list = $.param(input_param);
	else if( typeof input_param ==='string' )
		argument_list = input_param;
	else
		argument_list = "";

	if( argument_list!="" )
	{
		var index_of_question = page_url.lastIndexOf('?');
		if( index_of_question < 0 )
			page_full_url = page_url+"?"+argument_list;
		else
			page_full_url = page_url+"&"+argument_list;
	}
	else
	{
		page_full_url = page_url;
	}
	return page_full_url;
}
function open_popup(objArgument)
{
	// method(post, get) 결정
	var method = objArgument.method;
	if( typeof method==='undefined' || method==='' )
	{
		if( typeof objArgument.data==='object' )
			method = 'post';
		else
			method = 'get';
	}

	if( typeof objArgument.target==='undefined' )
		objArgument.target = '_blank';

	if( method.toLowerCase()=="get" )
		open_popup_by_get(objArgument);
}
function open_popup_by_get(objArgument)
{
	// 호출할 페이지 전체 주소
	var page_full_url = __extend_html_url(objArgument.action,objArgument.data);

	if( typeof objArgument.specs==='object' )
		return window.open(page_full_url, objArgument.target, determine_specs_param(objArgument.specs));
	else
		return window.open(page_full_url, objArgument.target);
}

function determine_specs_param(objSpecs)
{
	// 디폴트 값 설정
	if( typeof objSpecs.scroll==='undefined' )
		objSpecs.scroll = 'yes';

	if( typeof objSpecs.scrollbars==='undefined' )
		objSpecs.scrollbars = 'yes';

	if( typeof objSpecs.status==='undefined' )
		objSpecs.status = 'yes';

	if( typeof objSpecs.resizable==='undefined' )
		objSpecs.resizable = 'yes';

	// 값 반환
	var specs_param = '';
	for( var key in objSpecs )
	{
		if( specs_param=='' )
			specs_param += key+'='+objSpecs[key];
		else
			specs_param += ','+key+'='+objSpecs[key];
	}
	return specs_param;
}
</script>
</body>
</html>
