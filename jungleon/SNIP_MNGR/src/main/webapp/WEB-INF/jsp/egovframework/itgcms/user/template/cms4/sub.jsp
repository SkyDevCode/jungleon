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
	<span id="top">맨위</span>
	<!--header-->
	<header class="sub header">
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
						<li><button style="background: none;" onClick="location.href='${siteconfigVO.totalSearchMenuCode}.do';"><img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/common/ic_search.png" alt="통합검색"></button>
						</li>
			</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div id="gnb" class="gnb">
			<div class="g_w">
				<c:import url="/data/${siteCode}/user/include/Include_C_GNB.jsp" />
				<a class="allmenu" href="/${siteCode}/contents/${siteconfigVO.sitemapMenuCode}.do">
					<span class="bar bar1"></span>
					<span class="bar bar2"></span>
					<span class="bar bar3"></span>
				</a>
			</div>
		</div>
		<div class="gnb_bg">
			<div class="inner">
				<button type="button" class="gnbClose">메뉴 닫기</button>
			</div>
		</div>
	</header>
	<!--//header-->
	<!--container-->
	<section id="container" class="sub">

		<div class="neviTop">
			<div class="n_w">
				<div class="flR">
					<p class="nevi">
						<img src="${ctx}/resource/templete/${siteconfigVO.tempCode}/img/common/icon_H.png" alt="홈">&nbsp;${ufn:getUserNavigation(menuVO.menuPfullname,'1') }
					</p>
					<ul class="icList">
						<!-- <li><a href="#" class="ic print"><span class="blind">프린트하기</span></a></li> -->
						<c:if test="${menuVO.menuSnsShareyn eq 'Y' }">
						<li><a href="#" class="ic sharing"><span class="blind">공유하기</span></a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>

		<div class="content ${ufn:IIF('1' eq menuVO.menuUseFixwidth or ('0' eq menuVO.menuUseFixwidth and '1' ne siteconfigVO.sitePageType),'fixwidth','')}">
		<c:if test="${'N' ne menuVO.menuLnbuseyn}">
    			<div id="lnb">
<%-- S: 추가 영역 --%>
	        		<c:set var="left" value="${fn:split(menuVO.menuPfullcode, '>') }" />
	        		<c:import url="/data/${siteCode}/user/include/Include_B_LEFT_${left[1]}.jsp" />
<%-- E: 추가 영역 --%>
      			</div>
			  </c:if>
			
			<c:if test="${not empty tabMenuList}">
				<ul class="subTab c${fn:length(tabMenuList)}">
				<c:forEach var="tabmenu" items="${tabMenuList }" varStatus="status">
					<li>${ufn:getMenuLink2(tabmenu,siteCode)}</li>
					<%-- <li>    ${ufn:getMenuLink(tabmenu.menuCode, tabmenu.menuName, tabmenu.menuType, tabmenu.menuUrl, tabmenu.menuShowType, 'web'}</li> --%>
					<%-- <li>${tabmenu.menuCode} ${tabmenu.menuName} ${tabmenu.menuType} ${tabmenu.menuUrl} ${tabmenu.menuShowtype }</li> --%>
				</c:forEach>
				</ul>
			</c:if>

			<div class="content_w">
				<div class="subTop">
					<h2 class="tit"><c:out value="${menuVO.menuName }" /></h2>
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
				<!-- 본문 영역 -->
				<div class="sub_inner">
					<%-- S: 추가 영역 --%>
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
				</div> <!-- //sub_inner -->
			</div> <!-- //본문 -->
		</div> <!-- //container -->
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

	<!--footer-->
	<footer>
		<div class="f_w">
			<div class="info">
				<address>
					<p>경기도 안양시 동안구 시민대로 248번길 25 703호(관양동) 안양창조산업진흥원 TEL : 031-386-0651 사업자등록번호 : 138-81-50691  대표이사 : 배종현</p>
					<p>Copyrightⓒ 2009~2017 ITGOOD Co.Ltd. All Right Reserved.</p>
				</address>
				<p class="email">본 웹사이트는 이메일 주소가 무단 수집되는 것을 거부하며, 이를 위반시 정보통신망법에 의해 처벌됨을 유념하시기 바랍니다.</p>
			</div>
			<div class="fam">
<%-- S: 추가 영역 --%>
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
<%-- E: 추가 영역 --%>

					</div>
		</div>
	</footer>
	<!--//footer-->

	<p class="bottom"><a href="#top">TOP</a></p>

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