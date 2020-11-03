<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!-- footer -->
		<div class="subfooter__wrap footer-wrap rolling-slide-con">
			<div class="subfooter__wrap__inner">
				<div class="info-wrap">
					<div class="subfooter__top__inner">
						<ul>
							<li class="c-red"><a href="/${siteCode}/contents/notice214.do">개인정보처리방침</a></li>
							<li><a href="/${siteCode}/contents/notice216.do">영상정보기기운영방침</a></li>
							<li><a href="/${siteCode}/contents/registration.do?stp=agree">이용약관 </a></li>
							<li><a href="/${siteCode}/contents/notice32.do">윤리경영</a></li>
							<li><a href="/${siteCode}/contents/Introduce351.do">오시는길</a></li>
							<li><a href="/${siteCode}/contents/Introduce32.do">조직도</a></li>
							<li class="mb_hide"><a href="https://www.mois.go.kr/frt/sub/a08/viewerDownload/screen.do" target="_blank">뷰어다운</a></li>
						</ul>
                    </div>
					<span class="ft_logo"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/footer_logo.png" alt="성남산업진흥원 로고" /></span>
					<div class="ft_txt">
						<div class="cs_info">
							<address>(우.13558)경기도 성남시 분당구 성남대로 331번길 8, 7층(정자동)</address>
							<span class="tel_number">TEL. 1588-4130, 031-782-3000</span>
							<span>FAX. 031-782-3030</span>
						</div>
						<p class="copyright">&copy; SeongNam Industry Promotion Agency. <br />All rights reserved. </p>
					</div>
				</div>
				<div class="ft_site_area">
					<div class="ft_mark_sns">
						<!--  <div class="ft_wa_mark"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/footer_wa_mark.png" alt="WA 웹접근성 마크 취득" /></div>-->
						<div class="ft_sns_share">
							<ul>
								<li class="wa"><a href="http://www.webwatch.or.kr/Situation/WA_Situation.html?MenuCD=110" title="국가 공인 인증기관 : 웹와치">
<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/wa.png" border="0" alt="과학기술정보통신부 WEB ACCESSIBILITY 마크(웹 접근성 품질인증 마크)"/></a></li>
								<li><a href="https://www.facebook.com/snsmallgiants" target="_blank" title="성남산업진흥원 페이스북 (새창으로 열림)"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/footer_sns_facebook.jpg" alt="성남산업진흥원 페이스북" /></a></li>
								<li><a href="https://twitter.com/snventure" target="_blank" title="성남산업진흥원 트위터 (새창으로 열림)"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/footer_sns_twitter.jpg" alt="성남산업진흥원 트위터" /></a></li>
								<li><a href="https://blog.naver.com/snsnip2001" target="_blank" title="성남산업진흥원 블로그 (새창으로 열림)"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/footer_sns_blog.jpg" alt="성남산업진흥원 블로그" /></a></li>
								<li><a href="https://www.youtube.com/channel/UCy2B_otmd0jzXv35IDf6fyA" target="_blank" title="성남산업진흥원 유튜브 (새창으로 열림)"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/footer_sns_youtube.jpg" alt="성남산업진흥원 유튜브" /></a></li>
							</ul>
						</div>
					</div>
					<div class="relate-site major-site">
						<select id="link1" title="관내 유관기관 선택">
							<option value="">관내 유관기관</option>
							<option value="http://www.seongnam.go.kr">성남시</option>
							<option value="http://www.sncouncil.go.kr">성남시의회</option>
							<option value="http://www.isdc.co.kr">성남도시개발공사</option>
							<option value="http://www.snic.or.kr">성남산업단지관리공단</option>
							<option value="http://www.snart.or.kr">성남문화재단</option>
							<option value="http://www.sncci.net">성남상공회의소</option>
							<option value="http://www.keti.re.kr">전자부품연구원</option>
							<option value="http://www.tta.or.kr">정보통신기술협회</option>
						</select>
						<button class="btn_go txt_out" title="선택한 관내 유관기관 사이트 새창으로 이동">go</button>
					</div>
					<div class="relate-site major-site">
						<select id="link2" title ="중소기업 지원기관 선택" >
							<option value="">중소기업 지원기관</option>
							<option value="https://www.kised.or.kr">창업진흥원</option>
							<option value="http://www.smba.go.kr">중소기업청</option>
							<option value="http://www.smba.go.kr/gyeonggi">경기지방중소기업청</option>
							<option value="http://www.sbc.or.kr">중소기업진흥공단</option>
							<option value="https://gsgc.modoo.at/">경기중소기업지원센터</option>
							<option value="http://www.sbiz.or.kr">소상공인포털</option>
						</select>
						<button class="btn_go txt_out" title="선택한 중소기업 지원기관 사이트 새창으로 이동">go</button>
					</div>
				</div>
			</div>
		</div>
		<!-- //footer -->