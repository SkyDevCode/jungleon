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
 * @파일명 : userCominfoView.jsp
 * @파일정보 : 사업신청 > 성남기업소개 > 성남기업 및 상품안내 > 기업정보 조회
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @yjy 2020. 3. 5. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<div class="corporation-top_box">
					<p>
						이곳에 게제 된 기업정보는 회원 여러분들께서 직접 올려 주신 자료를 기반으로 생성되었습니다.  이에, 잘못된 정보를 포함하고 있을 수 있으니 정보 활용에 유의하여 주시기 바라며, 성남산업진흥재단은 그에 따른 법적 책임이 없음을 알려드립니다.  
					</p>
				</div>

				<div class="table-list2 corporation-info_table">
					<table>
						<caption>기업의 회사명, 회사주소, 기업분류, 산업분류, 주요제품,  전화번호 , 팩스번호, 홈페이지주소에 대한 정보가 기재된표</caption>
						<tbody>
							<tr>
								<th scope="row">회사명</th>
								<td>
									<c:out value="${result.comNm }"  />
								</td>
							</tr>
							<tr>
								<th scope="row">회사주소</th>
								<td>
									[<c:out value="${result.zip }" />] <c:out value="${result.addr01 }" /> <c:out value="${result.addr02 }" />
								</td>
							</tr>
							<tr>
								<th scope="row">기업분류</th>
								<td>
									<c:out value="${ufn:deCode(result.comTp, 'V006000001,개인기업,V006000002,법인기업','-') }" />
								</td>
							</tr>
							<tr>
								<th scope="row">산업분류</th>
								<td>
									<c:out value="${result.unNm }" />
								</td>
							</tr>
							<tr>
								<th scope="row">주요제품</th>
								<td>
									<c:out value="${result.mainProduct }" />
								</td>
							</tr>
							<tr>
								<th scope="row">회사 전화번호</th>
								<td>
									<c:out value="${result.officeTel01 }" />-<c:out value="${result.officeTel02 }" />-<c:out value="${result.officeTel03 }" />
								</td>
							</tr>
							<tr>
								<th scope="row">회사 팩스번호 </th>
								<td>
									<c:out value="${result.faxNo01 }" />-<c:out value="${result.faxNo02 }" />-<c:out value="${result.faxNo03 }" />
								</td>
							</tr>
							<tr>
								<th scope="row">회사 홈페이지 </th>
								<td>
									<c:out value="${result.hPage }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-wrap text-r">
                   <a href="#" onclick="fn_goList(); return false;" class="btn btn-gray">목록</a>
               </div>
				<div class="board-bottom">
				<c:set var="prev" value="" />
				<c:set var="next" value="" />
				<c:forEach var="pn" items="${prevNext }">
					<c:if test="${pn.prevnext eq 'PREV' }">
						<c:set var="prev" value="${pn }" />
					</c:if>
					<c:if test="${pn.prevnext eq 'NEXT' }">
						<c:set var="next" value="${pn }" />
					</c:if>
				</c:forEach>
					<ul class="prev-next-wrap">
						<li class="prev">
							<strong>이전글</strong>
							<c:if test="${empty prev }">
								<a href="#none">이전글이 없습니다.</a>
							</c:if>
							<c:if test="${not empty prev }">
								<a href="#none" onclick="fn_goView('<c:out value="${prev.busiRegNo }" />'); return false;"><c:out value="${prev.comNm }" /></a>
							</c:if>
						</li>
						<li class="next">
							<strong>다음글</strong>
							<c:if test="${empty next }">
								<a href="#none">다음글이 없습니다.</a>
							</c:if>
							<c:if test="${not empty next }">
								<a href="#none" onclick="fn_goView('<c:out value="${next.busiRegNo }" />'); return false;"><c:out value="${next.comNm }" /></a>
							</c:if>
						</li>
					</ul><!--// prev-next-wrap-->
				</div><!--// board-bottom-->
				
				
<script>

	var query = "${searchVO.query}";
	function fn_goList(){
		query = ItgJs.fn_replaceQueryString(query, "schM", "list");
		location.href = "?" + query;
	}
	function fn_goView(idx) {
		query = ItgJs.fn_replaceQueryString(query, "schId", idx);
		query = ItgJs.fn_replaceQueryString(query, "schM", "view");
		location.href = "?" + query;
	}

	<c:if test="${isEdit}">
	function fn_goUpdate(){
		query = ItgJs.fn_replaceQueryString(query, "schM", "update");
		location.href = "?" + query;
	}

	</c:if>


</script>