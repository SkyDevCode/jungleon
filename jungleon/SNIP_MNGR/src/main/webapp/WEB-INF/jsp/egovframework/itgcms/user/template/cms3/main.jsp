<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="tempPath" value="WEB-INF/jsp/egovframework/itgcms/user/template"/>
<!DOCTYPE HTML>
<html lang="ko">
<head>
</head>
<body>
	<!--header-->
	<header>
		<div class="h_b">
			<div class="h_w">
				<h1>
					<a href="/${siteCode}/main/index.do">
			<c:if test="${siteconfigVO.siteLogogubun eq '2'}">
						<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','system',siteconfigVO.siteLogo,siteconfigVO.siteLogo) }"/>" alt="${siteconfigVO.sysName}"/></a></h1>
	        </c:if>
			<c:if test="${siteconfigVO.siteLogogubun eq '1'}">
						${siteconfigVO.sysName}
	        </c:if>
	        		</a>
	        	</h1>
				<div class="u_m">
					<ul class="u_l">
				<c:choose>
					<c:when test="${not empty userSessionVO }">
			            <li><a href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do?code=out">로그아웃</a></li>
					</c:when>
					<c:otherwise>
						<c:if test="${siteconfigVO.userLoginUseYn ne 'N'}">
						<li><a href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do">로그인</a></li>
						</c:if>
			            <c:if test="${siteconfigVO.joinUseYn ne 'N'}">
				    	<li><a href="/${siteCode}/contents/${siteconfigVO.memberRegMenuCode}.do">회원가입</a></li>
				    	</c:if>
					</c:otherwise>
				</c:choose>
				<c:if test="${siteconfigVO.siteMapUseYn ne 'N'}">
			            <li class="sitemap"><a href="/${siteCode}/contents/${siteconfigVO.sitemapMenuCode}.do">사이트맵</a></li>
			    </c:if>
			    <c:if test="${siteconfigVO.totalSearch ne '0'}">
						<li class="search">
							<a href="javascript:;"><span class="blind">검색</span></a>
							<div class="search-area">
								<form name="totSearch" method="post" onsubmit="ItgJs.fn_mainSearch('${siteconfigVO.totalSearchMenuCode}',this); return false;">
									<input type="hidden" name="searchCnd" value="${siteconfigVO.totalSearch}">
          							<input type="hidden" name="siteCode" value="${siteCode}">
				      				<input type="text" name="schStr" id="schStr" placeholder="검색어를 입력해주세요.">
				      				<button type="submit"></button>
				      				<button type="button" class="searchClose"></button>
			      				</form>
			      			</div>
						</li>
				</c:if>
					</ul>
				</div>
				<div class="m-menu">
				<c:if test="${siteconfigVO.totalSearch ne '0'}">
					<a href="javascript:;" class="m-search">검색</a>
				</c:if>
					<a href="javascript:;" class="m-gnb-open">메뉴 보기</a>
				</div>
				<c:if test="${siteconfigVO.totalSearch ne '0'}">
				<div class="m-search-area">
					<form name="totSearchM" method="post" onsubmit="ItgJs.fn_mainSearch('${siteconfigVO.totalSearchMenuCode}',this); return false;">
						<input type="hidden" name="searchCnd" value="${siteconfigVO.totalSearch}">
       					<input type="hidden" name="siteCode" value="${siteCode}">
	      				<input type="text" name="schStr" id="schStr" placeholder="검색어를 입력해주세요.">
	      				<button type="submit"></button>
	      				<button type="button" class="searchClose"></button>
      				</form>
      			</div>
      			</c:if>
			</div>
		</div>
		<div class="gnbBg"></div>
		<div id="gnb">
			<div class="g_w">
				<div class="m-gnbTop">
					<span class="m-gnb-close"><a href="javascript:;">메뉴 닫기</a></span>
					<span class="gnbLogo">
					<c:if test="${siteconfigVO.siteLogogubun eq '2'}">
						<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','system',siteconfigVO.siteLogo,siteconfigVO.siteLogo) }"/>" alt="${siteconfigVO.sysName}"/>
					</c:if>
					<c:if test="${siteconfigVO.siteLogogubun eq '1'}">
						${siteconfigVO.sysName}
			        </c:if>
					</span>

					<span class="m-topMenu">
				<c:choose>
					<c:when test="${not empty userSessionVO }">
			            <a href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do?code=out">로그아웃</a>
					</c:when>
					<c:otherwise>
						<c:if test="${siteconfigVO.userLoginUseYn ne 'N'}">
						<a href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do" class="login">로그인</a>
						</c:if>
			            <c:if test="${siteconfigVO.joinUseYn ne 'N'}">
				    	<a href="/${siteCode}/contents/${siteconfigVO.memberRegMenuCode}.do" class="login">회원가입</a>
				    	</c:if>
					</c:otherwise>
				</c:choose>
					</span>
				</div>
				<%-- S: GNB INCLUDE --%>
				<c:import url="/data/${siteCode}/user/include/Include_A_GNB.jsp" />
				<%-- E: GNB INCLUDE --%>
			</div>
		</div>
	</header>
	<!--//header-->

	<!-- visual -->
	<section id="visual">
		<div class="sliderWrap">
		<%-- S: 슬라이드 영역 --%>
			<c:import url="/module/slides/userInclude_SLIDES.do" >
				<c:param name="siteCode" value="${siteCode}"/>
			</c:import>
		<%-- E: 슬라이드 영역 --%>
		</div>
	</section>

	<!--container-->
	<section id="container" class="main">
		<div class="content">
			<div class="r1 w">
				<ul>
					<li class="n1"><a href="#"><span class="t1">반응형웹</span><span class="t2">어떠한 기기에도 알맞은 스크린(해상도)으로<br/>즉각 반응하도록 페이지를 제작합니다.</span><span class="btn">자세히보기</span></a></li>
					<li class="n2"><a href="#"><span class="t1">반응형웹</span><span class="t2">어떠한 기기에도 알맞은 스크린(해상도)으로<br/>즉각 반응하도록 페이지를 제작합니다.</span><span class="btn">자세히보기</span></a></li>
					<li class="n3"><a href="#"><span class="t1">반응형웹</span><span class="t2">어떠한 기기에도 알맞은 스크린(해상도)으로<br/>즉각 반응하도록 페이지를 제작합니다.</span><span class="btn">자세히보기</span></a></li>
				</ul>
			</div>

			<div class="r2 w">
				<div class="popupzone">
					<div class="popupcontroler"></div>
					<div class="popup_w">
			<c:forEach var="result" items="${popupzoneList}">
						<div class="item">
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
							<a href="<c:out value="${result.popupUrl }" />" onclick="ItgJs.popupCnt('${result.popupIdx}')" target="_blank">
			               	</c:when>
			           	</c:choose>
					</c:otherwise>
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
				</div>
				<div class="bbswrap">
					<!-- S : 최근글불러오기  -->
      					${ufn:mainPageBoard(mainPageBoard, 'tab', 100)}
      				<!-- E : 최근글불러오기  -->
				</div>
			</div>

			<div class="r3">
				<div class="w">
					<ul>
						<li class="n1"><a href="#">
							<div class="progress">
								<span class="progress-left">
									<span class="progress-bar"></span>
								</span>
								<span class="progress-right">
									<span class="progress-bar"></span>
								</span>
								<div class="progress-icon"><img src="/resource/templete/cms3/img/main/r3-icon-n1.png" alt="cube-cms"></div>
							</div>
							<span class="t1">CUBE-CMS</span>
							<span class="t2">표준적이고 유연한 설계를 바탕으로 개발된<br/>컨텐츠 관리 시스템 입니다.</span>
							<span class="btn"></span>
						</a></li>
						<li class="n2"><a href="#">
							<div class="progress">
								<span class="progress-left">
									<span class="progress-bar"></span>
								</span>
								<span class="progress-right">
									<span class="progress-bar"></span>
								</span>
								<div class="progress-icon"><img src="/resource/templete/cms3/img/main/r3-icon-n1.png" alt="cube-cms"></div>
							</div>
							<span class="t1">CUBE-CMS</span>
							<span class="t2">표준적이고 유연한 설계를 바탕으로 개발된<br/>컨텐츠 관리 시스템 입니다.</span>
							<span class="btn"></span>
						</a></li>
						<li class="n3"><a href="#">
							<div class="progress">
								<span class="progress-left">
									<span class="progress-bar"></span>
								</span>
								<span class="progress-right">
									<span class="progress-bar"></span>
								</span>
								<div class="progress-icon"><img src="/resource/templete/cms3/img/main/r3-icon-n1.png" alt="cube-cms"></div>
							</div>
							<span class="t1">CUBE-CMS</span>
							<span class="t2">표준적이고 유연한 설계를 바탕으로 개발된<br/>컨텐츠 관리 시스템 입니다.</span>
							<span class="btn"></span>
						</a></li>
						<li class="n4"><a href="#">
							<div class="progress">
								<span class="progress-left">
									<span class="progress-bar"></span>
								</span>
								<span class="progress-right">
									<span class="progress-bar"></span>
								</span>
								<div class="progress-icon"><img src="/resource/templete/cms3/img/main/r3-icon-n1.png" alt="cube-cms"></div>
							</div>
							<span class="t1">CUBE-CMS</span>
							<span class="t2">표준적이고 유연한 설계를 바탕으로 개발된<br/>컨텐츠 관리 시스템 입니다.</span>
							<span class="btn"></span>
						</a></li>
					</ul>
				</div>
			</div>

			<div class="r4">
				<div class="w">
					<p class="sec-tit">포트폴리오<span class="btn-more"><a href="#">더보기</a></span></p>
					<ul class="portfolio pc">
						<li><a href="#"><img src="/resource/templete/cms3/img/main/visual3.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
						<li><a href="#"><img src="/resource/templete/cms3/img/main/r4-n2-bg.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
						<li><a href="#"><img src="/resource/templete/cms3/img/main/r4-n3-bg.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
						<li><a href="#"><img src="/resource/templete/cms3/img/main/r4-n1-bg.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
						<li><a href="#"><img src="/resource/templete/cms3/img/main/r4-n2-bg.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
						<li><a href="#"><img src="/resource/templete/cms3/img/main/r4-n3-bg.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
					</ul>

					<ul class="portfolio mobile">
						<li><a href="#"><img src="/resource/templete/cms3/img/main/visual3.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
						<li><a href="#"><img src="/resource/templete/cms3/img/main/r4-n2-bg.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
						<li><a href="#"><img src="/resource/templete/cms3/img/main/r4-n3-bg.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
						<li><a href="#"><img src="/resource/templete/cms3/img/main/r4-n1-bg.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
						<li><a href="#"><img src="/resource/templete/cms3/img/main/r4-n2-bg.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
						<li><a href="#"><img src="/resource/templete/cms3/img/main/r4-n3-bg.jpg" alt="국립생태원 사이버 전시교육마당"><span class="btn">자세히보기</span><span class="t1">국립생태원 사이버 전시교육마당</span></a></li>
					</ul>
				</div>
			</div>

			<div class="r5 w">
				<p class="sec-tit">RECENT WORK</p>
				<p class="sec-txt">기획/디자인/개발 분야의 최고의 인적자원으로 구성된 전담 사업조직을 구성하여 최적의 웹솔루션을 제공하고 있습니다.</p>
				<ul>
					<li><a href="#">파노라마/VR</a></li>
					<li><a href="#">시스템 통합</a></li>
					<li><a href="#">웹보안</a></li>
				</ul>
			</div>
		</div>
	</section>
	<!--//container-->

	<!--banner-->
	<div id="banner">
		<div class="b_w">
			<div class="control">
				<ul class="c_l">
					<li><button type="button" class="bt t1"><span class="blind">이전</span></button></li>
					<li><button type="button" class="bt t2"><span class="blind">정지/시작</span></button></li>
					<li><button type="button" class="bt t3"><span class="blind">다음</span></button></li>
				</ul>
			</div>
			<div class="b_l">
					<c:forEach var="result" items="${popupBannerList }">
						<div class="item">
							 <c:choose>
									 <c:when test="${result.popupLinktype eq '0' }">
										 <a href="#none">
									 </c:when>
									 <c:when test="${result.popupLinktype eq '1' }">
										 <a href="<c:out value="${result.popupUrl }" />">
									 </c:when>
									 <c:when test="${result.popupLinktype eq '2' }">
										 <a href="<c:out value="${result.popupUrl }" />" target="_blank">
									 </c:when>
							 </c:choose>
							 <img src="${ctx}/comm/download.do?f=<c:out value="${ufn:getDownloadLink('','popup',result.popupImg,result.popupImg) }" />" alt="<c:out value="${result.popupAlt}" />"/></a></div>
					</c:forEach>
					</div>
		</div>
	</div>
	<!--//banner-->

	<!-- footer -->
	<footer>
		<div class="f_w">
			<div class="rel-w">
				<ul class="f_l">
					<li class="privacy"><a href="#">개인정보처리방침</a></li>
					<li><a href="#">이메일수집거부정책</a></li>
					<li><a href="#">저작권정책</a></li>
					<li><a href="#">찾아오시는 길</a></li>
				</ul>
				<div class="f_l mobile">
					<span class="rel-btn n1"><a href="javascript:;">개인정보처리방침</a></span>
					<div class="rel-list n1">
						<a href="#">개인정보처리방침</a>
						<a href="#">이메일수집거부정책</a>
						<a href="#">저작권정책</a>
						<a href="#">찾아오시는길</a>
					</div>
				</div>
				<div class="rel-site">
					<span class="rel-btn n2"><a href="javascript:;">관련사이트</a></span>
					<div class="rel-list n2">
						<a href="#">site1</a>
						<a href="#">site2</a>
						<a href="#">site3</a>
					</div>
				</div>
			</div>
			<div class="ft-logo">
			<c:if test="${siteconfigVO.siteLogogubun eq '2'}">
				<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','system',siteconfigVO.siteLogo,siteconfigVO.siteLogo) }"/>" alt="${siteconfigVO.sysName}"/>
			</c:if>
			<c:if test="${siteconfigVO.siteLogogubun eq '1'}">
				${siteconfigVO.sysName}
			</c:if>
			</div>
			<address class="ft-content">
				<p><span>경기도 안양시 동안구 시민대로 248번길 25 703호(관양동) 안양창조산업진흥원</span><span>TEL : 031-386-0651 사업자등록번호 : 138-81-50691 대표이사 : 배종현</span></p>
				<p class="copyright">Copyrightⓒ 2009~2018 ITGOOD Co.Ltd. All Right Reserved.</p>
			</address>
			<div class="snsBtn">
				<a href="#" class="kakao"></a>
				<a href="#" class="twitter"></a>
				<a href="#" class="face"></a>
			</div>
		</div>
	</footer>
	<!-- //footer -->

	<div class="bbg"></div>

	<!--modalpopup-->
<c:if test="${not isMobile}">
  	<script>
    var leftPos=50;
    var topPos=50;
    var maxZ = 100;

	function fn_popupWin(obj,popupImg,popupAlt){
		var img = $(obj).find("img");
		var width,height;
		if(img){
			width = img[0].naturalWidth;
			height = img[0].naturalHeight;
		}else{
			width = 600;
			height = 600;
		}

		ItgJs.popupScrollbars('${ctx}/${siteCode}/popContents.do?url=popImg&opt1='+popupImg+'&opt2='+popupAlt,'popImg',width,height);
	}
  	</script>
    <c:forEach var="result" items="${popupWinList }" varStatus="status" >
	<div class="modalpopup" id="pop_${result.popupIdx}">
        <h2 class="tit"><c:out value="${result.popupTitle }" /></h2>
        <div class="popupBody" style="width:100%">

		<c:if test="${result.uploadType ne 'editor' }">
			<c:choose>
				<c:when test="${result.popupLinktype eq '0' }">
		<a href="#" onclick="fn_popupWin(this,'${result.popupImg}','${result.popupAlt}')">
				</c:when>
            	<c:when test="${result.popupLinktype eq '1' }">
		<a href="<c:out value="${result.popupUrl }" />" onclick="ItgJs.popupCnt('${result.popupIdx}')">
            	</c:when>
            	<c:when test="${result.popupLinktype eq '2' }">
		<a href="<c:out value="${result.popupUrl }" />" onclick="ItgJs.popupCnt('${result.popupIdx}')" target="_blank">
				</c:when>
			</c:choose>
		</c:if>
        <c:choose>
			<c:when test="${result.uploadType eq 'editor' }">
		<div class="cont"><c:out value="${result.edit_contents }" escapeXml="false"></c:out></div>
			</c:when>
	        <c:when test="${result.uploadType eq 'img' }">
			<img src="${ctx}/comm/viewImage.do?f=<c:out value="${ufn:getDownloadLink('','popup',result.popupImg,result.popupImg) }" />" alt="<c:out value="${result.popupAlt}" />" style="width:100%;max-height:100%"/></a>
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
		</div>
		<c:if test = "${result.popupFile != ''}">
		<div class="file">첨부 파일 : <a href="${ctx}/comm/download.do?f=<c:out value="${ufn:getDownloadLink('','popup',result.popupFile,result.popupFile) }" />" download>${result.oldFileNm} </a></div>
		</c:if>
        <div class="bot">
        	<input type="checkbox" class="t_c" id="t_c_${result.popupIdx}" onclick="ItgJs.fn_closeLayerPopup('pop_${result.popupIdx}',${result.expires});" />
        <c:choose>
	        <c:when test="${result.expires > 1}">
	            <label for="t_c_${result.popupIdx}">${result.expires}일간 열지 않음</label>
	        </c:when>
	        <c:otherwise>
	        	<label for="t_c_${result.popupIdx}">${ufn:deCode(result.expires,'0,다시 보지 않기,1,오늘하루 열지 않음','닫기')}</label>
	        </c:otherwise>
        </c:choose>
        </div>
        <a href="#" class="close" onclick="ItgJs.mainPopClose('pop_${result.popupIdx}');return false"><span class="blind">닫기</span></a>
	</div>

        <script>

			if("on" != ItgJs.fn_getCookie("pop_${result.popupIdx}")){
			    $("#pop_${result.popupIdx}").show();
			    $("#pop_${result.popupIdx}").draggable();
			    $("#pop_${result.popupIdx}").click(function(){
			    	$(this).css('z-index',maxZ++);
		    	});

			    $("#pop_${result.popupIdx}").css("width","${result.popupWidth}px");
			    $("#pop_${result.popupIdx} .popupBody").css("height","${result.popupHeight}px");
			    $("#pop_${result.popupIdx}").css("left",leftPos);
			    $("#pop_${result.popupIdx}").css("top",topPos);
			    $("#pop_${result.popupIdx}").css("z-Index",maxZ++);
			    $("#pop_${result.popupIdx}").css("overflow","hidden");
			    //alert($(window).width()+", ${left}");
			    leftPos = leftPos+${result.popupWidth}+10;
			    if(leftPos > $(window).width()){
			    	topPos = topPos+50;
			    	leftPos = topPos;
			     $("#pop_${result.popupIdx}").css("top",topPos);
			     $("#pop_${result.popupIdx}").css("left",leftPos);
			     leftPos = leftPos+${result.popupWidth}+10;
			    }

			    if($(window).width()<480){
			    	$("#pop_${result.popupIdx}").hide();
			    }
			}

  		</script>
    </c:forEach>
</c:if>
<c:if test="${isMobile}">
	<c:forEach var="result" items="${popupWinList }" varStatus="status" >
		<c:if test="${result.popupMobile eq 'Y'}">
			<div class="mPopup" id="mpop_${result.popupIdx}">
				<div class="mPopupBody">
					<div class="mPopupContents">
						<c:choose>
			               <c:when test="${result.popupLinktype eq '0' }">
			                   <a href="#">
			               </c:when>
			               <c:when test="${result.popupLinktype eq '1' }">
			                   <a href="<c:out value="${result.popupUrl }" />">
			               </c:when>
			               <c:when test="${result.popupLinktype eq '2' }">
			                   <a href="<c:out value="${result.popupUrl }" />" target="_blank">
			               </c:when>
			           </c:choose>
	           			<img src="${ctx}/comm/download.do?f=<c:out value="${ufn:getDownloadLink('','popup',result.popupImg,result.popupImg) }" />" alt="<c:out value="${result.popupAlt}" />"/></a>

					</div>
				</div>
				<div class="mPopupBtn">
					<ul>
						<li class="n1"><a href="#" onclick="ItgJs.fn_closeLayerPopup('mpop_${result.popupIdx}',1);">오늘 하루 보지 않기</a></li>
						<li class="n2"><a href="#" onclick="ItgJs.mainPopClose('mpop_${result.popupIdx}');return false">닫기</a></li>
					</ul>
				</div>
			</div>
			<script>
				if("on" != ItgJs.fn_getCookie("mpop_${result.popupIdx}")){
				    $("#mpop_${result.popupIdx}").show();
				}else{
					$("#mpop_${result.popupIdx}").remove();
				}
			</script>
		</c:if>
	</c:forEach>
</c:if>

	<script>
		m_broshur();
		main4popupzone();

		/**
		 * <a href="#">링크</a>
		 * 위와 같은 형태로 된 링크를 '#'동작이 먹지 않게 막는다.
		 */
		$(document).delegate("a[href='#']","click",function(event){
			event.preventDefault();
		});

		$(function(){
			$(".sel_btn").on("click",function(){
				$(this).next().toggleClass("on");
				return false;
			})
		});
	</script>
</body>
</html>
