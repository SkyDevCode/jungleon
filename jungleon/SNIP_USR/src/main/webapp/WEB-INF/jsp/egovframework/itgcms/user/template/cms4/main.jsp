<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="tempPath" value="WEB-INF/jsp/egovframework/itgcms/user/template"/>

<!DOCTYPE html>
<html lang="kr">
<head>
	<script src="${ctx }/resource/common/js/makePCookie.js"></script>
</head>
<body>
<div id="wrap">
	<!-- skip -->
	<div id="skip" class="skip">
		<a href="#container">본문 바로가기</a>
		<a href="#gnb">주메뉴 바로가기</a>
	</div>
	<!-- //skip -->

	<!-- header -->
	<div class="header__wrap main_header__wrap"> <%-- 메인페이지에만 클래스 추가부탁드립니다 --%>
		<c:import url="include_body_header.jsp" />
	</div>


	<!-- main_container -->
	<div class="main_visual main_visual_web">
		<div class="slide">
			<div class="main_visual_list">
				<c:forEach var="result" items="${slidesItemList }">
					<c:choose>
						<c:when test="${result.slitemLinkgubun eq '1' }">
							<div onclick="window.open('${result.slitemLinkurl}')" class="list" style="background:url(<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />) no-repeat center 0; background-size:cover; cursor: pointer;">
								<h1>SNIP Programs</h1>
								<p>
									People are precious to the business, healthy, and enrich the region.
								</p>
							</div>
						</c:when>
						<c:otherwise>
							<div class="list" style="background:url(<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />) no-repeat center 0; background-size:cover; ">
								<h1>SNIP Programs</h1>
								<p>
									People are precious to the business, healthy, and enrich the region.
								</p>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</div>

	<div class="main_visual main_visual_mobile">
		<div class="slide">
			<div class="main_visual_list">
				<c:forEach var="result" items="${slidesItemList }">
					<c:choose>
						<c:when test="${result.slitemLinkgubun eq '1' }">
							<div class="list"><img onclick="window.open('${result.slitemLinkurl}')" style="cursor: pointer;" src="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />" alt="SNIP Programs People are precious to the business, healthy, and enrich the region." /></div>
						</c:when>
						<c:otherwise>
							<div class="list"><img src="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />" alt="SNIP Programs People are precious to the business, healthy, and enrich the region." /></div>
						</c:otherwise>
					</c:choose>
				</c:forEach>

			</div>
		</div>
	</div>

	<div class="main_startup">
		<div class="main_cont">
			<h1 class="main_title">Start up</h1>
			<div class="rolling-slide">
				<div class="m_startup_list clfx">
					<c:forEach items='${engStartup.boardList }' var='result'>
						<div class="list">
							<div class="img_area">
								<a href="/eng/contents/${result.menuCode }.do">
									<c:set var="alt" value="${result.menuName }" />
									<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
									<c:set var="fileMask" value="${result.fileMask}"/>
									<c:set var="fileSrc" value="${result.fileName}"/>
									<c:choose>
										<c:when test="${result.fileName eq null || result.fileName eq '' }">
											<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
										</c:when>
										<c:otherwise>
											<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
										</c:otherwise>
									</c:choose>
								</a>
							</div>
							<div class="txt_area">
								<div class="title">${result.menuName }</div>
								<div class="btn_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />"><span>more</span></a>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<ul class="slick-arrow-wrap">
					<li class="slick-prev"><button>이전목록으로</button></li>
					<li class="slick-next"><button>다음목록으로</button></li>
				</ul>
			</div>
			<a href="<c:out value='/eng/contents/programsSnip11.do' />" class="more">more</a>
		</div>
	</div>

	<div class="main_cooperative">
		<div class="main_cont">
			<h1 class="main_title">Cooperative ecosystem</h1>
			<div class="rolling-slide">
				<div class="m_cooperative_list">
					<c:forEach items='${engCooper.boardList }' var='result'>
						<div class="list">
							<div class="img_area">
								<a href="/eng/contents/${result.menuCode }.do">
				                  <c:set var="alt" value="${result.menuName }" />
				                  <c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
				                  <c:set var="fileMask" value="${result.fileMask}"/>
				                  <c:set var="fileSrc" value="${result.fileName}"/>
				                  <c:choose>
				                    <c:when test="${result.fileName eq null || result.fileName eq '' }">
				                      <img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
				                    </c:when>
				                    <c:otherwise>
				                      <img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
				                    </c:otherwise>
				                  </c:choose>
				                </a>
							</div>
							<div class="txt_area">
								<div class="title">${result.menuName }</div>
								<div class="btn_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />"><span>more</span></a>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<ul class="slick-arrow-wrap">
					<li class="slick-prev"><button>이전목록으로</button></li>
					<li class="slick-next"><button>다음목록으로</button></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="main_tab_area">
		<div class="main_cont">
			<div class="main_tab_list">
				<!-- all -->
				<div class="main_all main_tabCont tabOn">
					<h1 class="main_tab_title"><a href="#none"><span>ALL</span></a></h1>
					<ul class="main_btm_list clfx">
						<c:forEach items='${engStartup.boardList }' var='result'>
							<li class="blue">
								<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<div class="category">
											Start up
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</div>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
							</li>
						</c:forEach>
						<c:forEach items='${engCooper.boardList }' var='result'>
							<li class="green">
								<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<div class="category">
											Cooperative ecosystem
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</div>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
							</li>
						</c:forEach>
						<c:forEach items='${engRd.boardList }' var='result'>
							<li class="yellow">
								<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<div class="category">
											R&D
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</div>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
							</li>
						</c:forEach>
						<c:forEach items='${engTech.boardList }' var='result'>
							<li class="sky">
								<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<div class="category">
											Technical commercialization
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</div>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
							</li>
						</c:forEach>
						<c:forEach items='${engInvest.boardList }' var='result'>
							<li class="purple">
								<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<div class="category">
											Investment fund
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</div>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
							</li>
						</c:forEach>
						<c:forEach items='${engScaleup.boardList }' var='result'>
							<li class="orange">
								<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<div class="category">
											Scaleup
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</div>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!-- //all -->

				<!-- Start up -->
				<div class="main_start_up main_tabCont">
					<h1 class="main_tab_title"><a href="#none"><span>Start up</span></a></h1>
					<ul class="main_btm_list clfx">
						<c:forEach items='${engStartup.boardList }' var='result'>
						<li class="blue">
							<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<span class="category">
											Start up
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</span>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
						</li>
						</c:forEach>
					</ul>
				</div>
				<!-- //Start up -->

				<!-- Cooperative ecosystem -->
				<div class="main_ecosystem main_tabCont">
					<h1 class="main_tab_title"><a href="#none"><span>Cooperative <br/ >ecosystem</span></a></h1>
					<ul class="main_btm_list clfx">
						<c:forEach items='${engCooper.boardList }' var='result'>
						<li class="green">
							<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<div class="category">
											Cooperative ecosystem
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</div>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
						</li>
						</c:forEach>
					</ul>
				</div>
				<!-- //Cooperative ecosystem-->

				<!-- R&D -->
				<div class="main_rnd main_tabCont">
					<h1 class="main_tab_title"><a href="#none"><span>R&amp;D</span></a></h1>
					<ul class="main_btm_list clfx">
						<c:forEach items='${engRd.boardList }' var='result'>
						<li class="yellow">
							<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<span class="category">
											R&D
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</span>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
						</li>
						</c:forEach>
					</ul>
				</div>
				<!-- //R&D-->

				<!-- Technical commercialization -->
				<div class="main_technical main_tabCont">
					<h1 class="main_tab_title"><a href="#none"><span>Technical <br />commercialization</span></a></h1>
					<ul class="main_btm_list clfx">
						<c:forEach items='${engTech.boardList }' var='result'>
						<li class="sky">
							<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<span class="category">
											Technical commercialization
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</span>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
						</li>
						</c:forEach>
					</ul>
				</div>
				<!-- //Technical commercialization -->

				<!-- Investment fund -->
				<div class="main_investment main_tabCont">
					<h1 class="main_tab_title"><a href="#none"><span>Investment fund</span></a></h1>
					<ul class="main_btm_list clfx">
						<c:forEach items='${engInvest.boardList }' var='result'>
							<li class="purple">
								<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<span class="category">
											Investment fund
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</span>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!-- //Investment fund -->

				<!-- Scaleup -->
				<div class="main_scaleup main_tabCont">
					<h1 class="main_tab_title"><a href="#none"><span>Scaleup</span></a></h1>
					<ul class="main_btm_list clfx">
						<c:forEach items='${engScaleup.boardList }' var='result'>
							<li class="orange">
								<div class="img_area">
									<a href="<c:out value='/eng/contents/${result.menuCode }.do' />">
										<c:set var="alt" value="${result.menuName }" />
										<c:set var="fileFolder" value="jfile/${result.fileFolder}"/>
										<c:set var="fileMask" value="${result.fileMask}"/>
										<c:set var="fileSrc" value="${result.fileName}"/>
										<c:choose>
											<c:when test="${result.fileName eq null || result.fileName eq '' }">
												<img src="${ctx}/resource/templete/cms4/src/img/common/defalut_main.gif" alt="">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('',fileFolder,fileMask,fileSrc) }" />"  alt="<c:out value="${ufn:quot(alt) }" />" />
											</c:otherwise>
										</c:choose>
										<span class="category">
											Scaleup
											<span class="more"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/main/main_plus.png" alt="more" /></span>
										</span>
									</a>
								</div>
								<div class="txt_area"><a href="<c:out value='/eng/contents/${result.menuCode }.do' />">${result.menuName }</a></div>
						</c:forEach>
					</ul>
				</div>
				<!-- //Scaleup -->
			</div>
		</div>
	</div>
	<!-- //main_container -->


	<!-- footer -->
	<c:import url="include_body_footer.jsp" />
	<!-- //footer -->
   </div>
<script>
$(document).ready(function(){

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
							dateStr = getDate4FB(resultPosts[i].created_time, "mm월dd일 HH시 MM분", 12);
						}
						html += "<div class=\"list\">" +
						"									<div class=\"img_area\">" +
						"										<a href=\""+result[j].url+"\" target=\"_blank\">" +
						"											<img src=\""+result[j].media.image.src+"\" alt=\""+desc+"\" />" +
						"										</a>" +
						"									</div>" +
						"									<div class=\"txt_area\">" +
						"										<a href=\""+result[j].url+"\" class=\"title\"  target=\"_blank\" title=\"해당게시물 페이스북 페이지로 새창으로 이동\" target=\"_blank\">" +
						"											"+desc+"" +
						"										</a>" +
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
	//mainSlider('.main_sns-list_1','4','3','2',false,true,false); //facebook sns
	mainSlider('.main_sns-list_2','4','3','2',false,true,false); //sns
	mainSlider('.main_sns-list_3','4','3','2',false,true,false); //sns
	mainSlider('.main_sns-list_4','4','3','2',false,true,false); //sns
})

</script>

</body>
</html>
