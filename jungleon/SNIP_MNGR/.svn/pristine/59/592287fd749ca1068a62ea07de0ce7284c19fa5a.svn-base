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
				<c:if test="${siteconfigVO.siteLogogubun eq '2'}">
					<h1><a href="/${siteCode}/main/index.do"><img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','system',siteconfigVO.siteLogo,siteconfigVO.siteLogo) }"/>" alt="${siteconfigVO.sysName}"/></a></h1>
		        </c:if>
				<c:if test="${siteconfigVO.siteLogogubun eq '1'}">
					<h1><a href="/${siteCode}/main/index.do">${siteconfigVO.sysName}</a></h1>
		        </c:if>
				<div class="u_m">
					<ul class="u_l">
						<c:if test="${siteconfigVO.toHomeUseYn ne 'N'}">
			            <%-- <li><a href="/${siteCode}/main/index.do">HOME</a></li> --%>
			            </c:if>
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
			            <li><a href="/${siteCode}/contents/${siteconfigVO.sitemapMenuCode}.do">사이트맵</a></li>
			            </c:if>
					</ul>
			<c:if test="${siteconfigVO.totalSearch ne '0'}">
					<div class="search_wrap">
						<form name="totSearch" method="post" onsubmit="ItgJs.fn_mainSearch('${siteconfigVO.totalSearchMenuCode}'); return false;">
							<input type="hidden" name="siteCode" value="${siteCode}" />
							<input type="hidden" name="searchCnd" value="${siteconfigVO.totalSearch}" />
							<input type="text" name="schStr" id="searchTxt" class="searchTxt" title="검색어 입력" placeholder="통합검색">
							<button type="submit" class="btn btn_submit">
								<img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/common/search.png" alt="검색">
							</button>
						</form>
					</div>
			</c:if>
				</div>
				<button type="button" class="gnbOpen">
					<span class="line l1"></span>
					<span class="line l2"></span>
					<span class="line l3"></span>
					<span class="line l4"></span>
					<span class="blind">GNB열기</span>
				</button>
				<div class="gnbic">
					<ul>
			<c:choose>
				<c:when test="${not empty userSessionVO }">
		            <li><a href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do?code=out"><img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/common/ico_logout.png" alt="로그아웃" class="ico_logout"></a></li>
				</c:when>
				<c:otherwise>
					<c:if test="${siteconfigVO.joinUseYn ne 'N'}">
						<li><a href="/${siteCode}/contents/${siteconfigVO.memberRegMenuCode}.do"><img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/common/ic_join.png" alt="회원가입"></a></li>
					</c:if>
		  			<c:if test="${siteconfigVO.userLoginUseYn ne 'N'}">
						<li><a href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do"><img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/common/ic_login.png" alt="로그인"></a></li>
					</c:if>
				</c:otherwise>
			</c:choose>
			<c:if test="${siteconfigVO.totalSearch ne '0'}">
						<li><button style="background: none;" onClick="ItgJs.fn_mainSearch('${siteconfigVO.totalSearchMenuCode}'); return false;"><img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/common/ic_search.png" alt="통합검색"></button>
						</li>
			</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div id="gnb" class="mobile">
			<div class="g_w">
				<%-- S: 추가 영역 --%>
				<%-- <jsp:include page="/L:/DEV/CMS307/${siteCode}/user/include/Include_B_GNB.jsp"></jsp:include> --%>
				<c:import url="/data/${siteCode}/user/include/Include_B_GNB.jsp"/>
					<%-- ${ufn:getFileContents(siteCode,'/user/menufile/Include_B_GNB.jsp')} --%>
				<%-- E: 추가 영역 --%>
				<button type="button" class="allmenu">
					<span class="bar bar1"></span>
					<span class="bar bar2"></span>
					<span class="bar bar3"></span>
				</button>
			</div>
		</div>
		<div class="gnbBG"><div class="innering"></div></div>
		<div class="stmapBG">
			<div class="innering">
				<div class="stmap">
					<%-- S: 추가 영역 --%>
					<c:import url="/data/${siteCode}/user/include/Include_A_GNB.jsp" />
					<%-- E: 추가 영역 --%>
				</div>
			</div>
		</div>
	</header>
	<!--//header-->

	<!--slider-->
	<seiction id="visual">

	</section>
	<!-- //visual -->

	<section id="container">
		<div class="mbox t0">
			<div class="w">
				<div class="sliderWrap">
					<!-- <div class="s_w">
						<p class="txt"><img src="../../common_f/img/main/slideTxt.png" alt=""></p>
					</div> -->
					<%-- S: 슬라이드 영역 --%>
						<c:import url="/module/slides/userInclude_SLIDES.do" >
							<c:param name="siteCode" value="${siteCode}"/>
						</c:import>
					<%-- E: 슬라이드 영역 --%>
				</div>
				<!--//slider-->
				<div class="icbox">
					<ul>
						<li class="ibt1"><a href="#"><strong>CUBE-CMS</strong></a></li>
						<li class="ibt2"><a href="#"><strong>웹표준/반응형웹</strong></a></li>
						<li class="ibt3"><a href="#"><strong>도로교통시스템</strong></a></li>
						<li class="ibt4"><a href="#"><strong>시스템통합</strong></a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="mbox t1">
			<div class="w">
				<ul class="m_list">
					<li class="mlt1">
						<h3>회사소개</h3>
						<ul class="q_l">
							<li><a href="#">회사개요</a></li>
							<li><a href="#">아이티굿 연혁</a></li>
							<li><a href="#">아이티굿 파트너</a></li>
							<li><a href="#">찾아오시는길</a></li>
						</ul>
						<a href="#">+</a>
					</li>
					<li class="mlt2">
						<h3>비즈니스</h3>
						<ul class="q_l">
							<li><a href="#">콘텐츠관리시스템</a></li>
							<li><a href="#">반응형웹</a></li>
							<li><a href="#">웹표준/웹접근성</a></li>
							<li><a href="#">도로교통시스템</a></li>
						</ul>
						<a href="#">+</a>
					</li>
					<li class="mlt3">
						<h3>프로그램 제품</h3>
						<!--slider-->
						<div class="sliderWrap" style="width: 55%;float: left;">
							<!-- <div class="s_w">
								<p class="txt"><img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/main/slideTxt.png" alt=""></p>
							</div> -->
							<ul class="bg">
								<li class="st1">
									<div class="txt">
										<p>장애인 편의정보 및 접근성 정보제공 모바일 플랫폼 프로그램</p>
										<a href="#a">자세히보기</a>
									</div>
								</li>
								<li class="st2">
									<div class="txt">
										<p>JAVA 웹 컨텐츠 관리시스템 솔루션(웹표준 및 웹접근성 준수) 프로그램</p>
										<a href="#a">자세히보기</a>
									</div>
								</li>
								<li class="st3">
									<div class="txt">
										<p>워드프레스 기반의 소셜 커뮤니케이션 플랫폼 프로그램</p>
										<a href="#a">자세히보기</a>
									</div>
								</li>
							</ul>
						</div>
						<!--//slider-->
						<a href="#a">자세히보기</a>
					</li>
				</ul>
			</div>
		</div>

		<div class="mbox t2">
			<div class="w">
				<div class="adr">
					<!--slider-->
						<div class="sliderWrap">
							<!-- <div class="s_w">
								<p class="txt"><img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/main/slideTxt.png" alt=""></p>
							</div> -->
							<ul class="bg">
								<li class="st1">
									<div class="txt">
										<h3>포트폴리오1</h3>
										<p>포트폴리오1에 대한 리뷰<br/>내용입니다. 포트폴리오1에 대한 리뷰<br/>내용입니다.</p>
										<a href="#a">자세히보기</a>
									</div>
								</li>
								<li class="st2">
									<div class="txt">
										<h3>포트폴리오2</h3>
										<p>포트폴리오2에 대한 리뷰<br/>내용입니다. 포트폴리오2에 대한 리뷰<br/>내용입니다.</p>
										<a href="#a">자세히보기</a>
									</div>
								</li>
								<li class="st3">
									<div class="txt">
										<h3>포트폴리오3</h3>
										<p>포트폴리오3에 대한 리뷰<br/>내용입니다. 포트폴리오3에 대한 리뷰<br/>내용입니다.</p>
										<a href="#a">자세히보기</a>
									</div>
								</li>
							</ul>
						</div>
						<!--//slider-->
				</div>
				<div class="qib">
					<ul>
						<li class="qm1"><a href="#"><strong>프로젝트 요청</strong></a></li>
						<li class="qm2"><a href="#"><strong>공지사항</strong></a></li>
						<li class="qm3"><a href="#"><strong>솔루션프로그램</strong></a></li>
						<li class="qm4"><a href="#"><strong>솔루션R&amp;D</strong></a></li>
						<li class="qm5"><a href="#"><strong>사업영역</strong></a></li>
						<li class="qm6"><a href="#"><strong>수출바우처사업</a></li>
					</ul>
				</div>
				<div class="cb">
					<ul>
						<li>
							<div class="t">
								<p class="m">프로그램 제품</p>
								<h3>Infocess</h3>
								<p>장애인 편의시설 및 관련시설 위치정보제공<br/>주요시설물 장애인 접근성 지수 정보제공</p>
								<a href="#a">자세히보기</a>
							</div>
							<a href="#">+</a>
						</li>
						<li>
							<div class="t">
								<p class="m">프로그램 제품</p>
								<h3>CUBE CMS</h3>
								<p>손쉬운 메뉴 관리기능, 컨텐츠 관리기능<br/>회원 및 권한관리</p>
								<a href="#a">자세히보기</a>
							</div>
							<a href="#">+</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

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
			</div>
		</div>
		<!--//banner-->

		<!--footer-->
		<footer>
			<div class="f_l">
				<div class="f_w">
					<ul class="l">
						<li><a href="#">개인정보 처리방침</a></li>
						<li><a href="#">이용약관</a></li>
						<li><a href="#">사이트맵</a></li>
					</ul>
					<div class="info">
						<p class="logo">
							<c:if test="${siteconfigVO.siteLogogubun eq '2'}">
								<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','system',siteconfigVO.siteLogo,siteconfigVO.siteLogo) }"/>" width="220" alt="${siteconfigVO.sysName}"/>
							</c:if>
							<c:if test="${siteconfigVO.siteLogogubun eq '1'}">
								${siteconfigVO.sysName}
							</c:if>
						</p>
						<address>
							<p>경기도 안양시 동안구 시민대로 248번길 25 703호(관양동) 안양창조산업진흥원 TEL : 031-386-0651 사업자등록번호 : 138-81-50691  대표이사 : 배종현</p>
						</address>
						<p class="copyright">Copyrightⓒ 2009~2017 ITGOOD Co.Ltd. All Right Reserved.</p>
						<p class="email">본 웹사이트는 이메일 주소가 무단 수집되는 것을 거부하며, 이를 위반시 정보통신망법에 의해 처벌됨을 유념하시기 바랍니다.</p>
						<!-- <div class="qrcode"><img src="../../../templete_common/img/common/qrcode.png" alt=""></div> -->
					</div>
					<div class="fam">
						<span class="r_s">
							<a href="#" id="sel_btn">패밀리사이트</a>
							<span class="options">
								<a href="#" class="option">- aaa</a>
								<a href="#" class="option">- aaa</a>
							</span>
						</span>
					</div>
				</div>
			</div>
		</footer>
		<!--//footer-->
	</section>
	<!--//container-->

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