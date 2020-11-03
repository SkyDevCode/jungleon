<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
									<c:if test="${ not empty paginationInfo.totalRecordCount and paginationInfo.totalRecordCount ne 0 }">
									<script>
									function fn_page_prev(page) {
										if (page > 1) fn_egov_link_page(page - 1);
										else {
											alert("첫페이지 입니다.");
											return;
										}
									}
									function fn_page_next(page) {
										if (page < ${ paginationInfo.totalPageCount})
											fn_egov_link_page(page + 1);
										else {
											alert("마지막 페이지 입니다.");
											return;
										}
									}
									function fn_page_move() {
										var page = $(".paginate_input").val();
										if (isNaN(page)) {
											$(".paginate_input").val('');
											alert("숫자만 입력하세요.");
											$(".paginate_input").focus();
											return;
										}
										if (page == "" || page < 1) {
											$(".paginate_input").val('1');
											alert("1페이지 부터 입력할 수 있습니다.");
											$(".paginate_input").focus();
											return;
										}
										if (page > ${ paginationInfo.totalPageCount}) {
											$(".paginate_input").val('${ paginationInfo.totalPageCount}');
											alert("총 페이지수 초과할 수 없습니다.");
											$(".paginate_input").focus();
											return;
										}
										fn_egov_link_page(page);
									}
									</script>
									<div class="paginate">
									<c:if test="${'1' ne paginationInfo.currentPageNo}">
										<a href="#" onclick="fn_egov_link_page(1);" class="sp sp_start" aria-label="맨 처음 페이지로"></a>
									</c:if>
									<c:if test="${'1' eq paginationInfo.currentPageNo}">
										<a href="#" onclick="alert('첫페이지 입니다.');" class="sp sp_start" aria-label="맨 처음 페이지로"></a>
									</c:if>
										<a href="#" onclick="fn_page_prev(${ paginationInfo.currentPageNo });" class="sp sp_prev" aria-label="이전 페이지로"></a>
										<div class="paginate_input_wrap">
											<input type="text" onkeydown="if(event.keyCode === 13){fn_page_move(); return false;}" class="paginate_input" aria-label="현재 페이지" title="현재 페이지" value="${ paginationInfo.currentPageNo }">
											<span>/</span>
											<span class="ir_text"></span>
											<span class="total_num">${ paginationInfo.totalPageCount }</span>
											<a href="#" onclick="fn_page_move();" class="btn_page_go">이동</a>
										</div>
										<a href="#" onclick="fn_page_next(${ paginationInfo.currentPageNo });" class="sp sp_next" aria-label="다음 페이지로"></a>
									<c:if test="${paginationInfo.totalPageCount ne paginationInfo.currentPageNo}">
										<a href="#" onclick="fn_egov_link_page(${ paginationInfo.totalPageCount } );" class="sp sp_finish" aria-label="맨 마지막 페이지로"></a>
									</c:if>
									<c:if test="${paginationInfo.totalPageCount eq paginationInfo.currentPageNo}">
										<a href="#" onclick="alert('마지막 페이지 입니다.');" class="sp sp_finish" aria-label="맨 마지막 페이지로"></a>
									</c:if>
									</div>
									</c:if>