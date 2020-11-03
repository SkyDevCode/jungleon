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
 * @파일명 : orgBizList.jsp
 * @파일정보 : 사업안내 > 부서별 사업안내
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
<script>
$(function(){
	var full_location = window.location.href;
	var array_location = full_location.split('#');
	var y = "#" + array_location[1];
    if (!($("" + y + "").size())) {
        return;
    }
	var ofset = $("" + y + "").offset().top;
	var h = 0;
	if (matchMedia("screen and (min-width: 1241px)").matches) {
        h = $(".header__wrap").height();
	} else {
		h = $(".header__wrap").height() * 2;
	}
	var topy = ofset - h;
	setTimeout(function() {$(window).scrollTop(topy)},500);
});
</script>
            <!-- 4dep_menu -->
				<div class="sub-tab__4dep focus-tab">
					<div class="slide">
						<div class="clfx sub-tab__4dep_list">
						<c:forEach var="code" items="${groupList }" varStatus="status">
							<div class="menu ${ufn:IIF(status.count eq 1, 'active', '')}"><a href="#<c:out value="${code.ccode }" />"><c:out value="${code.cname }" /></a></div>
						</c:forEach>
						</div>
						<ul>
							<li class="slick-prev"><button>이전목록으로</button></li>
							<li class="slick-next"><button>다음목록으로</button></li>
						</ul>
					</div>
				</div>
				<!-- //4dep_menu -->

                <div class="table table-list3 mt40" id="<c:out value="${resultList[0].cgName }" />">
                    <table>
                        <caption><span class="blind"><c:out value="${resultList[0].strCgName }" /> 사업안내 표</span></caption>
                        <colgroup>
                        <col width="100%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th><c:out value="${resultList[0].strCgName }" /></th>
                            </tr>
                            <tr>
                                <td>
                                    <ul class="list-dot">
                <c:set var="oldCgName" value="" />
          	<c:forEach var="result" items="${resultList}" varStatus="status">
          		<c:if test="${status.count ne 1 and oldCgName ne result.cgName}">
                                    </ul>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="table table-list3 mt40" id="<c:out value="${result.cgName }" />">
                    <table>
                        <caption><span class="blind"><c:out value="${result.strCgName }" /> 사업안내 표</span></caption>
                        <colgroup>
                        <col width="100%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th><c:out value="${result.strCgName }" /></th>
                            </tr>
                            <tr>
                                <td>
                                    <ul class="list-dot">
                 </c:if>

                                        <li>
                                        <c:if test="${not empty result.menuCode }">
	                                    	<c:set var="linkUrl" value="/${siteCode}/contents/${result.menuCode}.do" />
	                                    	 <a href="${linkUrl}" class="text-link"><c:out value="${result.bsName }" /></a>
                                        </c:if>
                                        <c:if test="${empty result.menuCode }">
	                                    	 <c:out value="${result.bsName }" />
                                        </c:if>
	                                       </li>
               		<c:set var="oldCgName" value="${result.cgName }" />
               </c:forEach>
                                    </ul>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>



