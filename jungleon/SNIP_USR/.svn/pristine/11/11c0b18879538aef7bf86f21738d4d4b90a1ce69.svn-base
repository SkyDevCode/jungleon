<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<div class="header__wrap--utill">
			<div class="header__inner">
				<h1 class="logo">
					<a href="/${siteCode }/main/index.do" aria-label="성남산업진흥원 메인페이지로 이동"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/logo.png" alt="성남산업진흥원 로고"></a>
				</h1>

				<button class="search_mb_open"><span class="ir-text">검색창열기</span></button>

				<!-- 상단 검색 -->
				<div class="search-form_wrap" >
					<div class="search-form_inner">
						<div class="search-form">
							<form name="mainSearch" method="post" onsubmit="ItgJs.fn_mainSearch('totalSearch',this); return false;">
								<fieldset>
									<legend>상단의 전체 검색영역</legend>
									<input type="hidden" name="siteCode" value="SNIP">
									<input type="hidden" name="searchCnd" value="onlyMe">
									<!-- 입력 폼 영역 -->
									<div class="search-form_group">
										<div class="search-form_text">
											<input type="search" id="sschStr2" name="schStr" aria-label="검색어 입력" placeholder="검색어를 입력하세요.">
											<label for="sschStr2" class="ir-text">검색어를 입력하세요.</label>
										</div>
										<button type="submit" class="btn-search">검색하기</button>
									</div>
									<!-- //입력 폼 영역 -->
								</fieldset>
							</form>
						</div>
					</div>
				</div>
				<!-- //상단 검색 -->

				<ul class="header__utils">
					<c:choose>
						<c:when test="${empty userSessionVO }">
							<li class="item"><a href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do" class="login" title="로그인페이지로 이동">로그인</a></li>
							<li class="item"><a href="/${siteCode}/contents/registration.do" title="회원가입 페이지로 이동">회원가입</a></li>
							<li class="item"><a href="/${siteCode}/contents/mypage-qna.do" title="QNA 페이지로 이동">Q&A</a></li>
						</c:when>
						<c:otherwise>
							<li class="item"><a href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do?code=out" class="login" title="로그아웃">로그아웃</a></li>
							<li class="item"><a href="/${siteCode}/contents/member-view.do" class="login" title="마이페이지로 이동">마이페이지</a></li>
							<li class="item"><a href="/${siteCode}/contents/mypage-qna.do" title="QNA 페이지로 이동">Q&A</a></li>
						</c:otherwise>
					</c:choose>
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
					<li class="item"><a href="/${siteCode}/contents/Introduce32.do" title="조직도 페이지로 이동">조직도</a></li>
					<!-- 20200603 추가 -->
					<li class="item top_font_set">
						<button class="btn_font_plus"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/font_plus.gif" alt="폰트크게" /></button>
						<button class="btn_font_minus"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/font_minus.gif" alt="폰트작게" /></button>
						<button class="btn_refresh"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/btn_refresh.gif" alt="새로고침" /></button>
					</li>
					<!-- //20200603 추가 -->
				</ul>
			</div>
			<div class="mobile_menu_open_wrap">
				<div class="mobile_menu_open">
					<button>
						<span>모바일 메뉴열기</span>
					</button>
				</div>
			</div>
		</div>
		<div class="header__wrap--bottom">
			<div class="header__wrap--inbox">
				<!-- gnb -->
				<div class="gnb_wrap">
					<!-- 모바일에서만 노출 -->
					<ul class="gnb_util">
						<c:choose>
						<c:when test="${empty userSessionVO }">
							<li class="item"><a href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do" class="login" title="로그인페이지로 이동">로그인</a></li>
							<li class="item"><a href="/${siteCode}/contents/registration.do" title="회원가입 페이지로 이동">회원가입</a></li>
						</c:when>
						<c:otherwise>
							<li class="item mW100"><a href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do?code=out" class="login" title="로그아웃">로그아웃</a></li>
						</c:otherwise>
					</c:choose>
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
						<li class="item"><a href="/${siteCode}/contents/Introduce32.do" title="조직도 페이지로 이동">조직도</a></li>
					</ul>
					<!-- //모바일에서만 노출 -->
						<c:import url="/data/${siteCode}/user/include/Include_A_GNB.jsp" />
					<button class="mobile_menu_close">모바일메뉴닫기</button>
				</div>
				<!-- //gnb -->
			</div>
			<!-- 전체메뉴 -->
			<%-- <div class="all-menu__wrap">
				<div class="all-menu__inner">
					<h1>전체메뉴</h1>

					<c:import url="/data/${siteCode}/user/include/Include_B_GNB.jsp" />
					<button class="total_menu_close"><img src="${ctx }/resource/templete/${siteconfigVO.tempCode }/src/img/common/total_menu_close.jpg" alt="전체메뉴 닫기" /></button>
				</div>
			</div> --%>
			<!-- //전체메뉴 -->
		</div>