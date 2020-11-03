<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="header__wrap">
		<div class="header__inner">
			<h1 class="logo">
				<a href="/${siteCode }/main/index.do" aria-label="SeongNam Industry Promotion Agency">
					<img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/logo.png" alt="SeongNam Industry Promotion Agency"></a>
			</h1>

			<div class="mobile_menu_open_wrap">
				<div class="mobile_menu_open">
					<button>
						<span>모바일 메뉴열기</span>
					</button>
				</div>
			</div>

			<div class="header__wrap--bottom">
				<div class="header__wrap--inbox">
					<!-- gnb -->
					<div class="gnb_wrap">
						<!-- 모바일에서만 노출 -->
						<ul class="gnb_util">
							<li class="item item-language">
								<button class="mobile_language_btn" title="성남진흥원 다국어페이지 선택">Language</button>
								<div class="item-language_list">
									<ul>
										<li><a href="/SNIP/main/index.do" title="성남진흥원 한국어 페이지로 이동">한국어</a></li>
										<li><a href="/eng/main/index.do" title="성남진흥원 영문 페이지로 이동">English</a></li>
										<li><a href="/chi/html/00_main.html" title="성남진흥원 중문 페이지로 이동">中文</a></li>
									</ul>
								</div>
							</li>
							<li><a href="/${siteCode}/contents/aboutSnip43.do">organization chart</a></li>
						</ul>
						<!-- //모바일에서만 노출 -->

						<c:import url="/data/${siteCode}/user/include/Include_A_GNB.jsp" />

						<ul class="header__utils">
							<li class="item item-language">
								<button class="web_language_btn" title="성남진흥원 다국어페이지 선택">Language</button>
								<div class="item-language_list">
									<ul>
										<li><a href="/SNIP/main/index.do" title="성남진흥원 한국어 페이지로 이동">한국어</a></li>
										<li><a href="/eng/main/index.do" title="성남진흥원 영문 페이지로 이동">English</a></li>
										<li><a href="/chi/html/00_main.html" title="성남진흥원 중문 페이지로 이동">中文</a></li>
									</ul>
								</div>
							</li>
							<li>
								<a href="/${siteCode}/contents/aboutSnip43.do">snip organization chart</a>
							</li>
						</ul>

						<button class="mobile_menu_close">모바일메뉴닫기</button>
					</div>
					<!-- //gnb -->
				</div>
			</div>
		</div>
	</div>
