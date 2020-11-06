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
<%
/**
 * @파일명 : userTotalTb.jsp
 * @파일정보 : 사업안내 > 총괄표
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 04. 13. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

            <div class="all-table-wrap">
            	<div class="all-table_sub-title">성남산업진흥원 중소벤처기업 혁신성장 지원사업 (2020년)</div>

                <div class="all-table__title">
                    <ul class="ir-text">
                        <li>구분</li>
                        <li>창업아이템 사업화<span>(예비창업)</span></li>
                        <li>생존과 성장<span>(창업~창업3년미만)</span></li>
                        <li>혁신 성장<span>(창업3년이상~창업7년미만)</span></li>
                        <li>도약·글로벌 진출<span>(창업7년이상)</span></li>
                    </ul>
                </div>
                <div class="all-table__body">
                    <ul class="all-table-list">

                <c:set var="oldGpName" value="" />
                     <li>
                            <div class="tit">
                                <c:out value="${resultList[0].strGpName }" />
                            </div>
                            <div class="all-table__cont">
                            	<ul class="all-table__item">
				<c:forEach var="result" items="${resultList }" varStatus="status">
					<c:if test="${status.count ne 1 and oldGpName ne result.gpName }">
								</ul>
						   </div>
						</li>
                     	<li>
                            <div class="tit">
                                <c:out value="${result.strGpName }" />
                            </div>
                            <div class="all-table__cont">
                                <ul class="all-table__item">
                     </c:if>
                     <c:set var="arrGrStep" value="${fn:split(result.grStep , ',')}" />
                     <c:set var="stepStart" value="" />
                     <c:set var="stepEnd" value="" />
                     <c:set var="lastPostion" value="${fn:length(arrGrStep) - 1 }" />
                     <c:choose>
                     	<c:when test="${fn:length(arrGrStep) eq 1 }">
		                     <c:set var="stepEnd" value="start0${arrGrStep[0] }" />
		                     <c:set var="stepEnd" value="end0${arrGrStep[0] }" />
                     	</c:when>
                     	<c:when test="${fn:length(arrGrStep) > 1 }">
		                     <c:set var="stepStart" value="start0${arrGrStep[0] }" />
		                     <c:set var="stepEnd" value="end0${arrGrStep[lastPostion]}" />
                     	</c:when>
                     </c:choose>
                    			  <c:set var = "length" value = "${fn:length(result.cgName)}"/>
                                    <li class="type0<c:out value="${fn:substring(result.cgName, length -1, length)} " />  <c:out value="${stepStart} " />   <c:out value="${stepEnd} " />">
                                    	<c:set var="linkUrl" value="#none" />
                                    	<c:if test="${not empty result.menuCode }">
	                                    	<c:set var="linkUrl" value="/${siteCode}/contents/${result.menuCode}.do" />
                                        </c:if>
	                                        <a href="${linkUrl}">
                                        <c:out value="${result.bsName }" />
                                        <c:choose>
                                        	<c:when test="${not empty result.bsLocation and not empty result.bsPeriod}">
		                                        [<c:out value="${result.bsLocation }" /> | <c:out value="${result.bsPeriod }" />]
                                        	</c:when>
                                        	<c:when test="${not empty result.bsLocation and empty result.bsPeriod}">
		                                        [<c:out value="${result.bsLocation }" /> ]
                                        	</c:when>
                                        	<c:when test="${empty result.bsLocation and not empty result.bsPeriod}">
		                                        [<c:out value="${result.bsPeriod }" />]
                                        	</c:when>
                                        </c:choose>
                                       	</a>
									</li>
						<c:set var="oldGpName" value="${result.gpName }" />
					</c:forEach>
                                </ul>
                            </div>
						</li>

               <!--

                        <li>
                            <div class="tit">
                                공간
                            </div>
                            <div class="all-table__cont">
                                <ul class="all-table__item">
                                    <li class="type01 star01 end03">
                                        <a href="#">성남콘텐츠캠퍼스[정자동 | 수시]</a>
									</li>
                                    <li class="type02 star01 end03">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type03  star01 end04">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type04 star02 end04">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type05 star02 end04">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type06 star03 end04">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
                                    </li>
                                </ul>
                            </div>
						</li>
						<li>
                            <div class="tit">
                                기술개발
                            </div>
                            <div class="all-table__cont">
                                <ul class="all-table__item">
                                    <li class="type07 star04 end01">
                                        <a href="#">성남콘텐츠캠퍼스[정자동 | 수시]</a>
									</li>
                                    <li class="type08 star02 end04">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type09 star02 end04">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type09 star02 end04">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type05 star03 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type06 star03 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
                                    </li>
                                </ul>
                            </div>
						</li>
						<li>
                            <div class="tit">
                                자금지원
                            </div>
                            <div class="all-table__cont">
                                <ul class="all-table__item">
                                    <li class="type01 star03 end01">
                                        <a href="#">성남콘텐츠캠퍼스[정자동 | 수시]</a>
									</li>
                                    <li class="type01 star03 end04">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type09 star03 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type09 star03 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type05 star03 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type06 star03 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
                                    </li>
                                </ul>
                            </div>
						</li>
						<li>
                            <div class="tit">
                                사업화
                            </div>
                            <div class="all-table__cont">
                                <ul class="all-table__item">
                                    <li class="type01 star02 end01">
                                        <a href="#">성남콘텐츠캠퍼스[정자동 | 수시]</a>
									</li>
                                    <li class="type01 star02 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type09 star02 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type09 star02 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type05 star02 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type06 star02 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
                                    </li>
                                </ul>
                            </div>
						</li>
						<li>
                            <div class="tit">
                                네트워크
                            </div>
                            <div class="all-table__cont">
                                <ul class="all-table__item">
                                    <li class="type01 star02 end01">
                                        <a href="#">성남콘텐츠캠퍼스[정자동 | 수시]</a>
									</li>
                                    <li class="type01 star02 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type09 star01 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type09 star02 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type05 star02 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
									</li>
                                    <li class="type06 star02 end01">
                                        <a href="#">메이커 스페이스 [상대원동 | 5월~]</a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                 -->
                    </ul>
                </div>
				<div class="all-table-info gray-box type2 mt60 bottom-info">
					<ul>
						<li>
							<span class="info-color_1">외부자원 유치단</span>
						</li>
						<li>
							<span class="info-color_2">경영기획부</span>
						</li>
						<li>
							<span class="info-color_3">정책연구부</span>
						</li>
						<li>
							<span class="info-color_4">사업지원부</span>
						</li>
						<li>
							<span class="info-color_5">기업성장부</span>
						</li>
						<li>
							<span class="info-color_6">창업성장부</span>
						</li>
						<li>
							<span class="info-color_7">ICT산업부</span>
						</li>
						<li>
							<span class="info-color_8">바이오헬스 산업부</span>
						</li>
						<li>
							<span class="info-color_9">콘텐츠 산업부</span>
						</li>
					</ul>
				</div>
				<div class="all-table-info gray-box type2 mt60 right-info">
					<ul>
						<li>
							<span class="info-color_1">외부자원 유치단</span>
						</li>
						<li>
							<span class="info-color_2">경영기획부</span>
						</li>
						<li>
							<span class="info-color_3">정책연구부</span>
						</li>
						<li>
							<span class="info-color_4">사업지원부</span>
						</li>
						<li>
							<span class="info-color_5">기업성장부</span>
						</li>
						<li>
							<span class="info-color_6">창업성장부</span>
						</li>
						<li>
							<span class="info-color_7">ICT산업부</span>
						</li>
						<li>
							<span class="info-color_8">바이오헬스 산업부</span>
						</li>
						<li>
							<span class="info-color_9">콘텐츠 산업부</span>
						</li>
					</ul>
				</div>
            </div>

            <script>
            	$(function(){
					$(window).scroll(function(){
						/*if($(window).scrollTop() > $('.all-table-info').offset().top + $('.header_fixed').offset().top) {*/
						if($(window).scrollTop() > 788 && $(window).scrollTop() < 2285) {
							$('.all-table-info.right-info').removeClass('fixed2');
							$('.all-table-info.right-info').addClass('fixed');
						} else if($(window).scrollTop() >= 2285){
							$('.all-table-info.right-info').removeClass('fixd');
							$('.all-table-info.right-info').addClass('fixed2');
						} else {
							$('.all-table-info.right-info').removeClass('fixed fixd2');
						}
					});
            	});
            </script>