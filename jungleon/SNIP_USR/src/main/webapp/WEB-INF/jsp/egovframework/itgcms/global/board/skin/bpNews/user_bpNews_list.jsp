<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>

<%
/**
 * @파일명 : user_default_view.jsp
 * @파일정보 : 일반형 게시판 사용자 상세보기
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 9. 4. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<!-- AX5-UI -->
<script src="${ctx}/resource/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/ax5core.min.js"></script>
<script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/ax5ui.itg.js"></script>
<script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/jquery-direct.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/resource/plugins/ax5ui/ax5ui.itg.css"/>
<script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>
<script type="text/javascript">
//<[[!CDATA[
var checkFlag = false;
var query = "<c:out value="${searchVO.query}" escapeXml="false" />";

$(document).ready(function(){
});

function fn_goList(){
	query = ItgJs.fn_replaceQueryString(query, "id", "");
	query = ItgJs.fn_replaceQueryString(query, "schM", "list");
//	location.href="/user/board/${menuCode}_list_${bcid}.do?" + query
	location.href="?" + query
}

function fn_goView(id){
	query = ItgJs.fn_replaceQueryString(query, "id", id);
	query = ItgJs.fn_replaceQueryString(query, "schM", "view");
//	location.href="/user/board/${menuCode}_view_${bcid}.do?" + query
	location.href="?" + query
}
//]]>
</script>

 <!-- board_top -->
                    <div class="board_top">
                        <form>
                            <fieldset>
                                <legend>게시판 검색폼</legend>
                                <div class="inner">
                                    <label for="schFld" class="blind">검색조건</label>
                                    <select name="schFld" id="schFld" class="select_box" title="검색어 조건선택">
                                        <option value="0">전체</option>
                                        <option value="1">제목</option>
                                        <option value="2">내용</option>
                                        <option value="3">제목 + 내용</option>
                                    </select>
                                    <label for="schStr" class="blind">검색어</label>
                                    <input type="text" class="search_txt"  title="검색어 입력" placeholder="검색어를 입력해주세요">
                                    <button type="submit" class="search"><span class="ir-text">검색</span></button>
                                </div>
                            </fieldset>
						</form>
                    </div>
                    <!-- //board_top -->
                    <div class="text-r">
                        <a href="#" class="btn btn-blue btn-magegin btn-modal-pop" id="pop01">이전 Biz  Plaza 보기</a>
                    </div>
                    <table class="table table-magegin">
                        <caption>번호,제목,이미지,기사제목으로 구성된 진흥원소식지</caption>
                        <colgroup class="n_mobile">
                            <col class="col1">
                            <col class="col2">
                            <col class="col3">
                            <col class="col4">
                        </colgroup>
                        <thead>
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">이미지</th>
                            <th scope="col">기사제목</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="num">1</td>
                                <td class="cate">105</td>
                                <td class="thum-img"><img src="${ctx}/resource/templete/cms1/src/img/temp/@magegin.jpg" alt="105호 매거진">
                                    <a href="#" class="btn btn-blue btn-icon__down">PDF 다운받기</a>
                                </td>
                                <td class="list">
                                    <ul class="magegin-subject__list">
                                        <li><a href="#">새로운 기회의 해, 2020년을 시작하다.</a></li>
                                        <li><a href="#">성남산업진흥원 제 10대 류해필 원장 취임</a></li>
                                        <li><a href="#">2020년 경자년 쥐띠해, 쥐띠 CEO의 새해 소망</a></li>
                                        <li><a href="#">한 해의 주요일정과 협력사업 모집 일정을 안내합니다.</a></li>
                                        <li><a href="#">한눈에 보는 2020년 글로벌 진출 기반 조성, sw/ict 트렌드쇼</a></li>
                                        <li><a href="#">자가줄기세포이식용 바오 키트로 해외시장을 노린다.</a></li>
                                        <li><a href="#">인공지능 기술을 활용하여 산업과 사회 문제를 해결하는, 인공지능</a></li>
                                        <li><a href="#">변화하는 시장에서 소비자 </a></li>
                                    </ul>

                                </td>
                             </tr>
                             <tr>
                                <td class="num">2</td>
                                <td class="cate">105</td>
                                <td class="thum-img"><img src="${ctx}/resource/templete/cms1/src/img/temp/@magegin.jpg" alt="105호 매거진">
                                    <a href="#" class="btn btn-blue btn-icon__down">PDF 다운받기</a>
                                </td>
                                <td class="list">
                                    <ul class="magegin-subject__list">
                                        <li><a href="#">새로운 기회의 해, 2020년을 시작하다.</a></li>
                                        <li><a href="#">성남산업진흥원 제 10대 류해필 원장 취임</a></li>
                                        <li><a href="#">2020년 경자년 쥐띠해, 쥐띠 CEO의 새해 소망</a></li>
                                        <li><a href="#">한 해의 주요일정과 협력사업 모집 일정을 안내합니다.</a></li>
                                        <li><a href="#">한눈에 보는 2020년 글로벌 진출 기반 조성, sw/ict 트렌드쇼</a></li>
                                        <li><a href="#">자가줄기세포이식용 바오 키트로 해외시장을 노린다.</a></li>
                                        <li><a href="#">인공지능 기술을 활용하여 산업과 사회 문제를 해결하는, 인공지능</a></li>
                                        <li><a href="#">변화하는 시장에서 소비자 </a></li>
                                    </ul>

                                </td>
                             </tr>
                        </tbody>
                    </table>

                    <div class="paginate">
                        <a href="#" class="sp sp_start" aria-label="맨 처음 페이지로"></a>
                        <a href="#" class="sp sp_prev" aria-label="이전 페이지로"></a>
                        <div class="paginate_input_wrap">
                            <input type="text" class="paginate_input paginate_input2" aria-label="현재 페이지" value="1">
                            <span>/</span>
                            <span class="blind">총 페이지</span>
                            <span class="total_num">10</span>
                            <a href="#" class="btn_page_go">이동</a>
                        </div>
                        <a href="#" class="sp sp_next" aria-label="다음 페이지로"></a>
                        <a href="#" class="sp sp_finish" aria-label="맨 마지막 페이지로"></a>
                    </div>

