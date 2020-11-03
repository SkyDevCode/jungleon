<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
</head>
<body>
	<!--header-->
	<header id="sub">
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

	<!--container-->
	<section id="container" class="sub">
		<div class="content">

			<div class="subVisual m2">
				<p>회사소개</p>
				<div class="lnb" id="navbar">
					<div class="w">
						<ul>
							<li class="home"><a href="/">홈</a></li>
							<%-- S: SNB INCLUDE --%>
							<c:set var="left" value="${fn:split(menuVO.menuPfullcode, '>') }" />
							${ufn:getMenuTag(siteCode,menuVO.menuPfullcode,"SNB")}
							<%-- S: SNB INCLUDE --%>
						</ul>
						<div class="page-btn">
							<ul>
								<!-- <li class="print"><a href="javascript:;">프린트</a></li> -->
								<li class="sns"><a href="javascript:;">sns공유</a></li>
							</ul>
						</div>

					</div>
				</div>
			</div>

			<div class="pageTit w">
				<p class="tit"><c:out value="${menuVO.menuName }" /></p>
			<c:if test="${not empty menuVO.menuMemo }">
				<p class="subtit"><c:out value="${menuVO.menuMemo }" escapeXml="false" /></p>
			</c:if>
				<div class="s-naviBox">
					<form name="snsShare" method="post">
						<input type="hidden" name="siteCode" value="${siteCode}" />
						<input type="hidden" name="menuCode" value="${code}" />
						<ul class="snsList">
							<input type="hidden" name="kakaoAppkey" value="${kakao.smAppkey}" />
						<c:if test="${ufn:strInArrChk(siteconfigVO.userSnsShareYn, 'facebook')}">
							<li><a href="javascript://" onclick="ItgJs.sendSns('facebook', '${currentUrl}', '내용 입력')" target="_blank" class="ico fb"><span class="blind">페이스북</span></a></li>
						</c:if>
						<c:if test="${ufn:strInArrChk(siteconfigVO.userSnsShareYn, 'twitter')}">
							<li><a href="javascript://" onclick="ItgJs.sendSns('twitter', '${currentUrl}', '내용 입력')" target="_blank" class="ico tw"><span class="blind">트위터</span></a></li>
						</c:if>
						<c:if test="${ufn:strInArrChk(siteconfigVO.userSnsShareYn, 'naver')}">
							<li><a href="javascript://" onclick="ItgJs.sendSns('naverBlog', '${currentUrl}', '제목 입력')" target="_blank" class="ico nb"><span class="blind">네이버블로그</span></a></li>
						</c:if>
						<c:if test="${ufn:strInArrChk(siteconfigVO.userSnsShareYn, 'kakao')}">
							<li><a href="javascript://" onclick="ItgJs.sendSns('kakaostoryW', '${currentUrl}', '제목 입력')" target="_blank" class="ico ks"><span class="blind">카카오스토리</span></a></li>
						</c:if>
						<c:if test="${ufn:strInArrChk(siteconfigVO.userSnsShareYn, 'instagram')}">
							<li><a href="javascript://" onclick="ItgJs.sendSns('instagram', '${currentUrl}', '제목 입력')" target="_blank" class="ico in"><span class="blind">인스타그램</span></a></li>
						</c:if>
						</ul>
					</form>
				</div>
			</div>

			<div class="sub_inner">
				<div class="w">
					<%--
						0 : 폴더
						1 : CMS 컨텐츠
						2 : 프로그램
						3 : 게시판
						4 : 링크
						5 : 컨텐츠 없음
						6 : 리비전컨텐츠
					 --%>
				<c:choose>
					<c:when test="${menuVO.menuType eq '0'  }">
						<c:redirect url="${menuVO.menuUrl2}" />
					</c:when>
					<c:when test="${menuVO.menuType eq '1'  }">
						<c:out value="${menuVO.menuContents }" escapeXml="false" />
					</c:when>
					 <c:when test="${menuVO.menuType eq '2'  }">
						<c:import url="/${menuVO.menuUrl2}">
							<c:param name="progIdx">${menuVO.menuSubType}</c:param>
							<c:param name="code">${param.code}</c:param>
						</c:import>
					</c:when>
					<c:when test="${menuVO.menuType eq '3'  }">
						<c:choose>
							<c:when test="${param.schM ne null and param.schM ne ''}">
								<c:set var="menuUrl" value="user/board/${menuVO.menuCode}_${param.schM}_${menuVO.menuSubType}.do"/>
								<c:if test="${param.notice ne null and param.notice ne ''}">
									<c:set var="menuUrl" value="user/board/${menuVO.menuCode}_${param.schM}_${menuVO.menuSubType}_notice.do"/>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:set var="menuUrl" value="${menuVO.menuUrl2}"/>
							</c:otherwise>
						</c:choose>
						<c:import url="/${menuUrl}">
							<c:param name="siteCode">${siteCode}</c:param>
							<c:param name="menuCode">${menuVO.menuCode}</c:param>
						</c:import>
					</c:when>
				</c:choose>
					<%-- E: 추가 영역 --%>

					<%-- S: 담당자/만족도조사 --%>
				<c:if test="${menuVO.menuChargeuseyn eq 'Y' or menuVO.menuResearchuseyn eq 'Y'  }" >
					<div class="appraisal">
					<c:if test="${menuVO.menuChargeuseyn eq 'Y' }" >
						<div class="t">
							<ul class="adm">
								<li>담당 : <c:out value="${menuVO.mngrManagerVO.mngName }" /></li>
								<li>담당부서 : <c:out value="${menuVO.mngrManagerVO.groupCodeName }" /></li>
								<li>문의 : <c:out value="${menuVO.mngrManagerVO.mngPhone }" /> <a href="mailto:<c:out value="${menuVO.mngrManagerVO.mngEmail }" />"><img src="${ctx}/resource/templete_common/img/common/appraisal_ic_mail.png" alt="메일보내기" class="ml5"></a></li>
								<li>수정 :
									<c:choose>
											<c:when test="${not empty menuVO.upddt }">
												<c:out value="${menuVO.upddt }" />
											</c:when>
											<c:otherwise>
												<c:out value="${menuVO.regdt }" />
											</c:otherwise>
										</c:choose>
								</li>
							</ul>
						</div>
					</c:if>
					<c:if test="${menuVO.menuResearchuseyn eq 'Y' }" >
						<div class="b">
							<form name="satisForm" id="satisForm" method="post">
								<input type="hidden" name="menuCode" id="menuCode" value="<c:out value="${menuVO.menuCode }" />" />
								<h4 class="blind">페이지 만족도 조사</h4>
								<p class="tit">해당 페이지의 만족도와 소중한 의견 남겨주세요.</p>
								<ul class="chk">
									<li class="crb"><input type="radio" name="answer1" id="answer11" value="5" /><label for="answer11">매우만족</label></li>
									<li class="crb"><input type="radio" name="answer1" id="answer12" value="4" /><label for="answer12">다소만족</label></li>
									<li class="crb"><input type="radio" name="answer1" id="answer13" value="3" /><label for="answer13">보통</label></li>
									<li class="crb"><input type="radio" name="answer1" id="answer14" value="2" /><label for="answer14">다소불만족</label></li>
									<li class="crb"><input type="radio" name="answer1" id="answer15" value="1" /><label for="answer15">매우불만족</label></li>
								</ul>
								<div class="area">
									<textarea name="answer6" id="answer6" maxlength="200"></textarea>
									<button type="button" onclick="ItgJs.fn_sendSatis(); return false;">의견남기기</button>
								</div>
							</form>
						</div>
					</c:if>
					</div>
				</c:if><%-- E: 담당자/만족도조사 --%>
				</div><!-- //w -->
			</div><!-- //sub_inner -->
		</div><!-- //content -->
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
			<c:if test="${menuVO.menuQruseyn eq 'Y'}">
			<div class="qrcode">
						<img id="qrImg" src="" alt="${menuVO.menuName } QR코드" />
						<script type="text/javascript">
							$(function(){
								$("#qrImg").prop("src", "/comm/qr.do?url=" + escape(location.href));
							})
						</script>
			</div>
			</c:if>
		</div>
	</footer>
	<!-- //footer -->

	<div class="bbg"></div>

	<script>
		//nowpage(2,1,2);
			var depth1 = "${left[1]}";
			var depth2 = "${left[2]}";
			var depth3 = "${left[3]}";
			var depth4 = "${left[4]}";

			var d1index = $("#SNB_"+depth1).parent().index();
			var d2index = $("#SNB_"+depth2).parent().index();
			var d3index = $("#GNB_"+depth3).parent().index();
			var d4index = $("#SNB_"+depth4).parent().index();

			$("ul.lnb_l li.dp").eq(1).children('a').text($("ul.lnb_l li.dp").eq(1).find('ul.dp2 li').eq(d2index).text())

			if(d1index != -1) d1index ++;
			if(d2index != -1) d2index ++;
			if(d3index != -1) d3index ++;

			//nowpage(d1index, d2index, d3index, );

			$("#SNB_" + depth1).addClass("active");
			$("#SNB_" + depth2).addClass("active");
			$("#SNB_" + depth2).parent().find("ul").show();
			$("#SNB_" + depth3).addClass("active");
			$("#SNB_" + depth4).addClass("active");

		/**
		 * <a href="#">링크</a>
		 * 위와 같은 형태로 된 링크를 '#'동작이 먹지 않게 막는다.
		 */
		$(document).delegate("a[href='#']","click",function(event){
			event.preventDefault();
		});
	</script>
</body>
</html>