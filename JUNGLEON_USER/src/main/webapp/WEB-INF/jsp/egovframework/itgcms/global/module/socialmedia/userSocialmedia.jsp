<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%@ taglib prefix="ora" uri="/WEB-INF/tlds/CustomTagSelectCodeList.tld" %>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

<%
/**
 * @파일명 : socialMedia.jsp
 * @파일정보 : 소셜허브
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @KYH 2017. 03. 00. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 3.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<div id="fb-root"></div>
<c:if test="${facebookInfo ne null}">
<script>
$(document).ready(function(){
	var fbCon = $("#facebookCon");
	showfacebook(fbCon.width());
});

(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.8";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));


function showfacebook(width){
	console.log("showfacebook : "+width);
	var htmlcode = "";
	var fbId = '${snsconfigVO.faceBookId}';
	htmlcode+='<div class="fb-page" data-href="https://www.facebook.com/${facebookInfo.accountId}" data-tabs="timeline" data-height="550" data-width="'+width+'"';
	htmlcode+='data-small-header="false" data-adapt-container-width="true" ';
	htmlcode+='data-hide-cover="false" data-show-facepile="true">';
	htmlcode+='<blockquote cite="https://www.facebook.com/${facebookInfo.accountId}" class="fb-xfbml-parse-ignore">';
	htmlcode+='<a href="https://www.facebook.com/${facebookInfo.accountId}">Facebook</a></blockquote></div>';
	$('.facebookCon').html(htmlcode);
}
</script>
</c:if>
<!-- <script type="text/javascript">
// 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('앱키');

    // 카카오톡 공유하기
    function sendKakaoTalk()
    {
    Kakao.Link.sendTalkLink({
      label: '공유 제목',
      image: {
        src: 'http://이미지경로',
        width: '300',
        height: '200'
      },
      webButton: {
        text: '공유제목',
        url: 'https://도메인' // 앱 설정의 웹 플랫폼에 등록한 도메인의 URL이어야 합니다.
      }
    });
    }

    // 카카오스토리 공유하기
      function shareStory() {
        Kakao.Story.share({
          url: '도메인',
          text: '공유제목'
        });
      }

    // send to SNS
    function toSNS(sns, strTitle, strURL) {
        var snsArray = new Array();
        var strMsg = strTitle + " " + strURL;
		var image = "이미지경로";

        snsArray['twitter'] = "http://twitter.com/home?status=" + encodeURIComponent(strTitle) + ' ' + encodeURIComponent(strURL);
        snsArray['facebook'] = "http://www.facebook.com/share.php?u=" + encodeURIComponent(strURL);
		snsArray['pinterest'] = "http://www.pinterest.com/pin/create/button/?url=" + encodeURIComponent(strURL) + "&media=" + image + "&description=" + encodeURIComponent(strTitle);
		snsArray['band'] = "http://band.us/plugin/share?body=" + encodeURIComponent(strTitle) + "  " + encodeURIComponent(strURL) + "&route=" + encodeURIComponent(strURL);
        snsArray['blog'] = "http://blog.naver.com/openapi/share?url=" + encodeURIComponent(strURL) + "&title=" + encodeURIComponent(strTitle);
        snsArray['line'] = "http://line.me/R/msg/text/?" + encodeURIComponent(strTitle) + " " + encodeURIComponent(strURL);
		snsArray['pholar'] = "http://www.pholar.co/spi/rephol?url=" + encodeURIComponent(strURL) + "&title=" + encodeURIComponent(strTitle);
		snsArray['google'] = "https://plus.google.com/share?url=" + encodeURIComponent(strURL) + "&t=" + encodeURIComponent(strTitle);
        window.open(snsArray[sns]);
    }

    function copy_clip(url) {
        var IE = (document.all) ? true : false;
        if (IE) {
            window.clipboardData.setData("Text", url);
            alert("이 글의 단축url이 클립보드에 복사되었습니다.");
        } else {
            temp = prompt("이 글의 단축url입니다. Ctrl+C를 눌러 클립보드로 복사하세요", url);
        }
    }
</script>
</head>
<body style="overflow:hidden;background-color:#f0f0f0;">
<div class="sns_wrap">
<p>SNS 공유하기</p>
<ul>
<li><a href="javascript:toSNS('facebook','공유제목!','http://http://.hoons.net/Board/asptip/Content/77332')" title="페이스북으로 가져가기"><img src="/img/facebook.jpg"></a></li>
<li><a href="javascript:toSNS('twitter','공유제목!','http://http://.hoons.net/Board/asptip/Content/77332')" title="트위터로 가져가기"><img src="/img/twitter.jpg"></a></li>
<li><a href="javascript:toSNS('line','공유제목!','http://http://.hoons.net/Board/asptip/Content/77332')" title="라인으로 가져가기"><img src="/img/line.jpg"></a></li>
<li><a href="javascript:sendKakaoTalk();" title="카카오톡으로 가져가기"><img src="/img/kakao.jpg"></a></li>
<li><a href="javascript:shareStory();" title="카카오스토리로 가져가기"><img src="/img/story.jpg"></a></li>
</ul>
<ul>
<li><a href="javascript:toSNS('pholar','공유제목!','http://.hoons.net/Board/asptip/Content/77332')" title="폴라로 가져가기"><img src="/img/pholar.jpg"></a></li>
<li><a href="javascript:toSNS('pinterest','공유제목!','http://.hoons.net/Board/asptip/Content/77332')" title="핀터레스트로 가져가기"><img src="/img/pinterest.jpg"></a></li>
<li><a href="javascript:toSNS('band','공유제목!','http://.hoons.net/Board/asptip/Content/77332')" title="밴드로 가져가기"><img src="/img/band.jpg"></a></li>
<li><a href="javascript:toSNS('google','공유제목!','http://http://.hoons.net/Board/asptip/Content/77332')" title="구글플러스로 가져가기"><img src="/img/google.jpg"></a></li>
<li><a href="javascript:toSNS('blog','공유제목!','http://http://.hoons.net/Board/asptip/Content/77332')" title="네이버블로그로 가져가기"><img src="/img/blog.jpg"></a></li>
</ul>
<ul>
<li><input type="text" value="http://도메인"><a href="javascript:copy_clip('http://도메인')"><img src="/img/sns_btn.jpg" class="sns_btn"></a></li>
</ul> -->




<div class="content">
	<div class="content_w">
	<!-- 본문영역 -->
	<div class="sub_inner">
		<div class="sns_wrap">
			<c:if test="${facebookInfo ne null}">
			<div class="sns facebook">
				<div class="sns_tit">
					<div class="s1">
						<p>${facebookInfo.smName}</p>
 						<a href="https://www.facebook.com/${facebookInfo.accountId}" target="_blank">https://www.facebook.com/${facebookInfo.accountId}</a>
					</div>
					<div class="s2">
						<p><img src="${ctx}/resource/common/img/sub/sns2_facebook.gif" alt="facebook"></p>
					<p><a href="https://www.facebook.com/${facebookInfo.accountId}" target="_blank">${facebookInfo.promText}</a></p>
					</div>
				</div>
				<div class="sns_box"><div class="facebookCon" id="facebookCon"></div></div>
			</div>
			</c:if>
			<c:if test="${twitterInfo ne null}">
			<div class="sns twitter">
				<div class="sns_tit">
					<div class="s1">
						<p>트위터</p>
						<a href="https://twitter.com/${twitterInfo.accountId}" target="_blank">https://twitter.com/${twitterInfo.accountId}</a>
					</div>
					<div class="s2">
						<p><img src="${ctx}/resource/common/img/sub/sns2_twitter.gif" alt="twitter"></p>
					<p><a href="https://twitter.com/${twitterInfo.accountId}" target="_blank">${twitterInfo.promText}</a></p>
					</div>
				</div>
				<div class="sns_box">
					<a class="twitter-timeline" href="https://twitter.com/${twitterInfo.accountId}" data-width="500" data-height="550">Tweets by ${twitterInfo.accountId}</a>
					<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
				</div>
			</div>
			</c:if>
			<c:if test="${instagramInfo ne null}">
			<div class="sns insta">
				<div class="sns_tit">
					<div class="s1">
						<p>인스타그램</p>
						<a href="https://www.instagram.com/${instagramInfo.accountId}" target="_blank">https://www.instagram.com/${instagramInfo.accountId}</a>
					</div>
					<div class="s2">
						<p><img src="${ctx}/resource/common/img/sub/sns2_insta.gif" alt="instagram"></p>
					<p><a href="https://www.instagram.com/${instagramInfo.accountId}" target="_blank">${instagramInfo.promText}</a></p>

					</div>
				</div>
				<div class="sns_box">
				<c:if test="${inError ne '1'}">
					<ul class="cf">
						<c:forEach var="inList" items="${inList }" varStatus="igStat">
							<li class="conbox"><a href="${inList.link }" target="_blank"><img src="${inList.enclosure }" alt="${inList.title }"></a></li>
						</c:forEach>
					</ul>
				</c:if>
				<c:if test="${inError eq '1'}">
					인스타그램 설정 정보가 올바르지 않습니다. 아이디를 확인해 주세요.
				</c:if>
				</div>
			</div>
			</c:if>
			<c:if test="${naverInfo ne null}">
				<div class="sns naver">
					<div class="sns_tit">
						<div class="s1">
							<p>네이버 블로그</p>
							<a href="http://blog.naver.com/${naverInfo.accountId}" target="_blank">http://blog.naver.com/${naverInfo.accountId}</a>
						</div>
						<div class="s2">
							<p><img src="${ctx}/resource/common/img/sub/sns2_naver.gif" alt="naverblog"></p>
						<p><a href="http://blog.naver.com/${naverInfo.accountId}" target="_blank">${naverInfo.promText}</a></p>
						</div>
					</div>
					<div class="sns_box">
						<div class="blog">
						<c:if test="${nbError ne '1'}">
							<ul>
								<c:forEach var="bList" items="${blogList }" varStatus="bStat">
									<li>
										<div class="b-tit">
											<a href="${bList.link}" target="_blank">${bList.title}</a>
										</div>
										<div class="b-con">${bList.description}</div>
										<div class="b-date">${bList.pubdate}</div>
									</li>
								</c:forEach>
							</ul>
						</c:if>
						<c:if test="${nbError eq '1'}">
							네이버블로그 설정 정보가 올바르지 않습니다. 아이디를 확인해 주세요.
						</c:if>
						</div>
					</div>
				</div>
			</c:if>
		</div>
		</div>
	</div>
</div>