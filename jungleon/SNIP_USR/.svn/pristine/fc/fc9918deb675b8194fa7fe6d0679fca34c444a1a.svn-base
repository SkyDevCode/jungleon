<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- S: 추가 영역 --%>
<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />
<%-- E: 추가 영역 --%>
<c:set var="left" value="${fn:split(menuVO.menuPfullcode, '>') }" />
<!DOCTYPE html>
<html lang="kr">
<head>
</head>
<body>

   <div id="wrap">
       <!-- skip -->
	<div id="accessibility">
		<a href="#container">본문 바로가기</a>
		<a href="#gnb">주메뉴 바로가기</a>
	</div>
	<!-- //skip -->

	<!-- header -->
	<div class="header__wrap">
		<script src="${ctx }/resource/common/js/makePCookie.js"></script>
		<%-- body 내에 header. GNB까지 --%>
		<c:import url="include_body_header.jsp" />
	</div>
    <!-- //header -->

		<div class="sub-vlsual__area sub-visual__type1">
			<c:import url="/data/${siteCode}/user/include/Include_B_LEFT_${left[1]}.jsp" />
		</div>

		<div class="content__area">
			<div class="sub_navi_menu">
				<ul class="navi_list">
					<li><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/navi_home.png" alt="home" /></li>
                    <!-- <li>참여마당</li>
                    <li>온라인홍보관</li>
                    <li>보도자료</li> -->
                    <c:set var="arrFullName" value="${fn:split(menuVO.menuPfullname, '>') }" />
                    <c:forEach var="name" items="${arrFullName }" varStatus="status">
                        <c:if test="${status.count > 1 }">
                        <li>${name }</li>
                        </c:if>
                    </c:forEach>
				</ul>


				<div class="menu__set">
				<c:if test="${menuVO.menuSnsShareyn eq 'Y' }">
					<div class="menu__set-sns">
						<button  class="menu__set-sns_open" title="sns공유하기 팝업창열기">
							<span class="ir-text">sns공유</span>
						</button>
						<div class="menu__sns-group">
							<div class="menu__sns-group--inbox">
								<div class="sns_link_btn">
<!-- 									<span>SNS공유하기</span> -->
									<ul>
										<li><a href="#" id="facebookId" title="페이스북 공유하기 (새창열림)"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/sns_facebook.jpg" alt="페이스북" /></a></li>
										<li><a href="#" id="twitterId" title="트위터 공유하기 (새창열림)"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/sns_twitter.jpg" alt="트위터" /></a></li>
										<li><a href="#" id="naverBlogId" title="블로그 공유하기 (새창열림)"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/sns_blog.jpg" alt="블로그" /></a></li>
										<li><a href="#" id="bandPcId"  title="밴드 공유하기 (새창열림)"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/sns_band.jpg" alt="밴드" /></a></li>
										<li><a id="kakaoId" href="#" title="카카오톡 공유하기 (새창열림)"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/sns_kakaotalk.jpg" alt="카카오톡" /></a></li>
									</ul>
								</div>
								<div class="sns_link_input">
									<input type="text" title="sns 공유 url 주소" id="copytarget" />
									<button class="btn_copy_url" onclick="ItgJs.copyClipboard('copytarget');return false;">URL복사</button>
								</div>
								<button class="menu__set-sns_close" title="sns공유하기 팝업창 닫기"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/icon_share_close.jpg" alt="" /></button>
							</div>
						</div>
					</div>
					</c:if>
					<a href="javascript:window.print();" class="menu__set-print"><span class="ir-text">프린트</span></a>
				</div>
			</div>

            <div class="page__title" id="container">
            	<a href="#" onClick="history.back(); return false;" class="btn-backpage" title="이전페이지로 이동"><img src="/resource/templete/${siteconfigVO.tempCode }/src/img/common/btn_backpage.gif" alt="바로 이전페이지로 이동" /> </a>
				<h2><c:out value="${menuVO.menuName }" /></h2>
            </div>
             <div class="subcont">
             <c:if test="${not empty left[4] }" >
              <div class="sub-tab__4dep">
				<div class="slide">
             		<c:import url="/data/${siteCode}/user/include/Include_A_TAB_${left[3]}.jsp" />
             	</div>
             </div>
             </c:if>
                <!-- subcont -->
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

				<c:if test="${menuVO.menuResearchuseyn eq 'Y' }" >
					 <!-- 평가 -->
                <div class="appraisal">
                        <form name="satisForm" id="satisForm" method="post">
                        	<input type="hidden" name="menuCode" id="menuCode" value="<c:out value="${menuVO.menuCode }" />" />
                            <h4 class="blind">페이지 만족도 조사</h4>
                            <div class="page-apraisal-tit">
                                <div class="tit">이 페이지에서 제공하는 정보에 대하여 어느정도 만족하셨습니까?</div>
                                <div class="porson-info">
                                <c:if test="${menuVO.menuChargeuseyn eq 'Y' }" >
                                    <span class="name">담당자 : <c:out value="${menuVO.mngrManagerVO.mngName }" /></span>
                                    <c:if test="${not empty menuVO.mngrManagerVO.groupCodeName }">
                                    	<span class="part">담당부서 : <c:out value="${menuVO.mngrManagerVO.groupCodeName }" /></span>
                                    </c:if>
                                    <c:if test="${empty menuVO.mngrManagerVO.groupCodeName }">
                                    	 <c:if test="${not empty menuVO.mngrManagerVO.groupCode }">
	                                    	<span class="part">담당부서 : <c:out value="${menuVO.mngrManagerVO.groupCode }" /></span>
	                                    </c:if>
                                    </c:if>
                                    <span class="tel">문의 :
                                    	<c:if test="${not empty menuVO.mngrManagerVO.mngPhone }">
	                                    	<c:out value="${menuVO.mngrManagerVO.mngPhone }" />
                                    	</c:if>
                                    	<c:if test="${not empty menuVO.mngrManagerVO.mngEmail }">
    	                                	<a href="mailto:<c:out value="${menuVO.mngrManagerVO.mngEmail }" />"><img style="margin-left: 5px;" src="${ctx}/resource/templete_common/img/common/appraisal_ic_mail.png" alt="메일보내기" class="ml5"></a>
                                    	</c:if>
                                    </span>
                                </c:if>
                                    <span class="data">최종수정일 :
                                   		<c:choose>
											<c:when test="${not empty menuVO.upddt }">
												<c:out value="${ufn:printDatePattern(menuVO.upddt, 'yyyy-MM-dd hh:mm') }" />
											</c:when>
											<c:otherwise>
												<c:out value="${ufn:printDatePattern(menuVO.upddt, 'yyyy-MM-dd hh:mm') }" />
											</c:otherwise>
										</c:choose>
                                    </span>
                                </div>
                            </div>
                            <ul class="chk">
                                <li class="crb star5"><input type="radio" name="answer1" id="answer11" value="5"><label for="answer11">매우만족</label></li>
                                <li class="crb star4"><input type="radio" name="answer1" id="answer12" value="4"><label for="answer12">다소만족</label></li>
                                <li class="crb star3"><input type="radio" name="answer1" id="answer13" value="3"><label for="answer13">보통</label></li>
                                <li class="crb star2"><input type="radio" name="answer1" id="answer14" value="2"><label for="answer14">다소불만족</label></li>
                                <li class="crb star1"><input type="radio" name="answer1" id="answer15" value="1"><label for="answer15">매우불만족</label></li>
                            </ul>
                            <div class="area">
                                <textarea name="answer6" id="answer6" maxlength="200" title="의견 남기기"></textarea>
                                <button type="button" onclick="ItgJs.fn_sendSatis(); return false;">의견남기기</button>
                            </div>
                        </form>
                </div>
                <!-- //평가 -->
				</c:if>


                <!-- //subcont -->
            </div>

		  </div>
       <!-- //content -->

            <a href="#wrap" class="fixed_btn_wrap"  style="position: fixed; opacity: 1;">
            	TOP
           		<!-- <img src="/resource/templete/cms1/src/img/sub/btn_gotop.png" alt="위로"> -->
            </a>


				<!-- family_site -->
		<div class="family_site_wrap " id="bannerDiv">
		</div>
		<!-- //family_site -->

	   <c:import url="include_body_footer.jsp" />

   </div>
<form name="saeForm" method="post" target="_blank" action="https://saemobilus.sae.org">
    <input type="hidden" name="KEY" value="14B3727472D314AB12B508192D7B431A" />
    <input type="hidden" name="uid" value="${sessionScope['__usk'].id}" />
</form>
<form name="moaForm" method="post" target="_blank" action="https://snip.moazine.com/default.asp">
    <input type="hidden" name="dl" value="9MtJb2T3nzH3jRbso2JB3tu1yuIBr2QcWqj1" />
    <input type="hidden" name="snipYn" id="snipYn" value="N" />
</form>


<script src="/resource/common/js/kakao.min.js"></script>
   <script type="text/javascript">
   function download1() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','mean.ai','mean.ai') }";}
   function download2() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','mean_IMG.zip','mean_IMG.zip') }";}
   function download3() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','mark.ai','mark.ai') }";}
   function download4() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','mark_IMG.zip','mark_IMG.zip') }";}
   function download5() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','color.ai','color.ai') }";}
   function download6() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','color.jpg','color.jpg') }";}
   function download7() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','utilize.ai','utilize.ai') }";}
   function download8() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','utilize.jpg','utilize.jpg') }";}
   function download9() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','up_down.ai','up_down.ai') }";}
   function download10() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','up_down_IMG.zip','up_down_IMG.zip') }";}
   function download11() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','right_left.ai','right_left.ai') }";}
   function download12() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','right_left_IMG.zip','right_left_IMG.zip') }";}
   function download13() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','emblem.ai','emblem.ai') }";}
   function download14() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','emblem_IMG.zip','emblem_IMG.zip') }";}
   function download15() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','motive.ai','motive.ai') }";}
   function download16() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','motive.jpg','motive.jpg') }";}
   function download17() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','11083_1.hwp','11083_1.hwp') }";}
   function download18() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','11083_2.hwp','11083_2.hwp') }";}
   function download19() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','11083_3.hwp','11083_3.hwp') }";}
   function download20() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','11083_4.hwp','11083_4.hwp') }";}
   function download21() {location.href="/comm/download.do?f=${ufn:getDownloadLink('','snip','11083_5.hwp','11083_5.hwp') }";}

$(function(){
	<%-- GNB 활성화 --%>
	/* $("#GNB_${left[1]}").parent("li").addClass("on"); */
	$("#GNB_${left[1]}").addClass("on");
	$("#GNB_${left[1]}").next("div").addClass("on");

	<%-- SNB 활성화 --%>
	$("#SNB_${left[2]}").parent("li").addClass("active");
	<c:if test="${fn:length(left) >= 3}">
		$("#SNB_${left[3]}").parent("div").addClass("s_active");
	</c:if>
	<c:if test="${fn:length(left) >= 4}">
		$("#TAB_${left[4]}").addClass("active");
	</c:if>
	$("div.gnb_dep4_list").prev().addClass("gnb_dep4_open");

	// $(".dep5_menu > a").removeClass("gnb_dep4_open");

	$("#bannerDiv").load("/comm/banner.ajax")

	<%-- 개인/기업 마이페이지 메뉴 조절 --%>
	<c:if test="${fn:indexOf(menuVO.menuPfullcode, 'SNIP>Mypage') > 0 }">
		<c:choose>
			<c:when test="${sessionScope.memType eq 'C'}">
				$("#SNB_mypage-clean").parent("li").remove();<%-- 클린신고 --%>
			</c:when>
			<c:when test="${sessionScope.memType eq 'N'}">
				$("#SNB_mypage-product").parent("li").remove();<%-- 제품정보관리 --%>
				/* $("#SNB_mypage-biz").parent("li").remove(); */<%-- 사업신청관리 --%>
			</c:when>
		</c:choose>
		<%-- 2뎁스 메뉴 갯수에 따라 길이 조절--%>
		$(".sub-tab__menu_inner").each(function(){
			var sub_tab_3dep_idx = $(this).find(">ul>li").length;
			var sub_tab_3dep_width = 100/sub_tab_3dep_idx;
			//console.log(sub_tab_3dep_idx , sub_tab_3dep_width);
			$(this).find(">ul>li").css({"width":sub_tab_3dep_width+"%"});
		});
	</c:if>

	var shareURL = location.href
	var arr = shareURL.split('/');
	var domainURL = arr[0] + "//" + arr[2]

	<c:if test="${menuVO.menuSnsShareyn eq 'Y' }">
		Kakao.init('76e802bf0d97154ded9cbff44ef496e2')
		Kakao.Link.createDefaultButton({
		      container: '#kakaoId',
		      objectType: 'feed',
		      content: {
		        title: "",
		        description: '',
		        imageUrl: domainURL + '/resource/common/img/defalut_kakao.jpg',
		        link: {
		          mobileWebUrl: shareURL,
		          webUrl: shareURL
		        }
		      }
		});
	</c:if>

	$("#facebookId").click(function () {
		ItgJs.sendSns('facebook', shareURL, '${title }')
	})

	$("#twitterId").click(function () {
		ItgJs.sendSns('twitter', shareURL, '${title }')
	})

	$("#bandPcId").click(function () {
		ItgJs.sendSns('bandPc', shareURL, shareURL)
	})

	$("#naverBlogId").click(function () {
		var url = encodeURI(encodeURIComponent(shareURL));
		var title = encodeURI( '공유하기' );
		var passURL = "https://share.naver.com/web/shareView.nhn?url=" + url + "&title=" + title;
		window.open( passURL, 'share', 'width=500, height=500' );
	})

	$("#copytarget").val(shareURL);

    if($('#SNB_${left[2]}').next().length>0){
		$('.sub-tab__menu').addClass('on');
	}
})
</script>

</body>
</html>