<%@page import="egovframework.itgcms.common.MemberType"%>
<%@page import="egovframework.itgcms.util.CustomUtil"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>

<script type="text/javascript" src="/resource/templete/cms1/src/js/jquery.ajax-cross-origin.min.js"></script>
<div class="board-wrap">
                    <div class="board-view">
                        <div class="view-info">
					            <strong class="title">
					               <c:out value="${result.title }" escapeXml="false"/>
				            </strong>

				            <div class="other-info">
				                <span class="bus-tit">사업명 : <c:out value="${result.biznm }" /> </span>
				                <span class="read">조회수 : <fmt:formatNumber value="${result.readcnt }" /> </span>
				                <span class="part">담당부서 : <c:out value="${result.usernm.split('/')[0] }"/></span>
				                <span class="manage">담당자 : <c:out value="${result.usernm.split('/')[1] }" /></span>
				                <span class="tel">연락처 : <c:out value="${result.usertel }"/></span>
				                <p class="tel">접수기간 :
				                		<fmt:parseDate var="startdt" pattern="yyyy-MM-dd" value="${result.startdt}"/>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${startdt}"/>
										~
										<fmt:parseDate var="enddt" pattern="yyyy-MM-dd" value="${result.enddt}"/>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${enddt}"/>. ${result.endtm + 1}시 까지
								</p>
				            </div>
				        </div><!--// view-info-->
                        <div class="file-list">
                            <dl>
                                <dt>
                                    첨부파일
                                </dt>
                                <dd>
                                 <c:forEach var="file" items="${userFileList }" varStatus="index">
                                	<p>
                                		<img src="/resource/templete/cms1/src/img/common/icon_file.jpg" alt="첨부파일"> <c:out value="${file.orgFileNm }" /> (다운수 : <span id="ff${index.count }"><c:out value="${file.downCnt }" /></span>)
	                                   	<a href="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',file.path1 ,file.orgFileNm ) }" onclick="down('${file.fileId}','${index.count}');" class="btn btn-blue btn-file-down">다운로드</a>
	                                   	<a href="#none" onclick="javascript:preview('${file.path1 }','${file.path2 }');" class="btn btn-gray btn-file-down">바로보기</a>
									</p>
                                </c:forEach>
                                </dd>
                            </dl>
                        </div>
                       <div class="view-content">
                       <c:forEach var="file" items="${userFileList }" varStatus="index">
	                       	<c:set value="${fn:toLowerCase(file.orgFileNm)}" var="filenm"/>
                         	<c:if test="${fn:contains(filenm,'jpg')||fn:contains(filenm,'png')||fn:contains(filenm,'bmp')||fn:contains(filenm,'jpeg')||fn:contains(filenm,'gif')}">
								<img alt="${file.orgFileNm }" src="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',file.path1 ,file.orgFileNm ) }">
                         	</c:if>
                        </c:forEach>
							 <c:choose>
		                <c:when test="${result.htmlyn == 'Y'}">
		                    <%-- 공고문에 포함된 온라인 사업신청 버튼 삭제 --%>
		                    ${fn:replace(result.contents,"width=\"108\" height=\"29\"","width=\"0\" height=\"0\"")}
		                </c:when>
		                <c:otherwise>
		                    <pre>${fn:replace(result.contents,"<","&lt;")}</pre>
		                </c:otherwise>
		                </c:choose>
						</div><!--// view-content-->
<c:if test="${result.stat=='ing'}">
<div class="btn-wrap btn-appli">
	                <c:choose>
                    <c:when test="${result.onlineyn == 'Y'}">
                                <c:choose>
                                    <c:when test="${result.reqtarget == 10}">
                                       <c:if test="${not empty userSessionVO}">
                                       		   <%if(!CustomUtil.checkMemberType(MemberType.Company)) {
                               			%>
                               		<a href="#this" onclick="if(confirm('기업회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false; self.close(); " class="btn btn-blueline icon-check btn-block"  title="새창연결">신청하기</a>
					<a href="#this" onclick="if(confirm('기업회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false; self.close(); " class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
                               		<%
                               		} else{
                               		%>
                             				<a href="javascript:fn_goRegist();" class="btn btn-blueline icon-check btn-block" title="새창 열림">신청하기</a>
											<a href="https://www.snip.or.kr/SNIP/contents/Guidance3.do" target="_blank" class="btn btn-blueline2 icon-book btn-block"  title="새창 열림">세무회계 온라인제출</a>
                               		<%
                               		}%>
                                        </c:if>
                                      <c:if test="${empty userSessionVO}">
                                        <a href="#this" onclick="if(confirm('기업회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;" class="btn btn-blueline icon-check btn-block">신청하기</a>
					<a href="#this" onclick="if(confirm('기업회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;" class="btn btn-blueline2 icon-book btn-block"  title="새창 열림">세무회계 온라인제출</a>
                                        </c:if>
                                    </c:when>
                                    <c:when test="${result.reqtarget == 20}">
                                       <c:if test="${not empty userSessionVO}">
                                       		 <%if(CustomUtil.checkMemberType(MemberType.Company)) {
	                               			%>
	                               		<a href="#this" onclick="if(confirm('개인회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;self.close(); " class="btn btn-blueline icon-check btn-block"  title="새창연결">신청하기</a>
						<a href="#this" onclick="if(confirm('개인회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;self.close(); " class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
	                               		<%
	                               		} else{
	                               		%>
	                             				<a href="javascript:fn_goRegist2();" class="btn btn-blueline icon-check btn-block"  title="새창연결">신청하기</a>
								<a href="https://www.snip.or.kr/SNIP/contents/Guidance3.do" target="_blank" class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
	                               		<%
	                               		}%>
                                        </c:if>
                                      <c:if test="${empty userSessionVO}">
                                      		<a href="#this" onclick="if(confirm('개인회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;" class="btn btn-blueline icon-check btn-block"  title="새창연결">신청하기</a>
						<a href="#this" onclick="if(confirm('개인회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;" class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
                                        </c:if>
                                    </c:when>
                                    <c:when test="${result.reqtarget == 30}">
                                        <c:if test="${sessionScope.memType eq 'N'}">
	                                         <c:if test="${empty userSessionVO}">
	                                      		<a href="#this" onclick="onclick="if(confirm('로그인이 필요한 서비스입니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;" class="btn btn-blueline icon-check btn-block"  title="새창연결">신청하기</a>
							<a href="#this" onclick="onclick="if(confirm('로그인이 필요한 서비스입니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;" class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
	                                        </c:if>
	                                         <c:if test="${not empty userSessionVO}">
	                                      		 <%if(CustomUtil.checkMemberType(MemberType.Company)) {
	                               			%>
	                               		<a href="#this" onclick="if(confirm('개인회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;self.close(); " class="btn btn-blueline icon-check btn-block"  title="새창연결">신청하기</a>
						<a href="#this" onclick="if(confirm('개인회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;self.close(); " class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
	                               		<%
	                               		} else{
	                               		%>
	                             				<a href="javascript:fn_goRegist2();" class="btn btn-blueline icon-check btn-block"  title="새창연결">신청하기</a>
								<a href="https://www.snip.or.kr/SNIP/contents/Guidance3.do" target="_blank" class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
	                               		<%
	                               		}%>

	                                        </c:if>
                                        </c:if>
                                        <c:if test="${sessionScope.memType eq 'C' || empty sessionScope.memType}">
                                        	 <c:if test="${empty userSessionVO}">
	                                      		<a href="#this" onclick="if(confirm('로그인이 필요한 서비스입니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;" class="btn btn-blueline icon-check btn-block">신청하기</a>
							<a href="#this" onclick="if(confirm('로그인이 필요한 서비스입니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false;" class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
	                                        </c:if>
	                                         <c:if test="${not empty userSessionVO}">
	                                      		<%if(!CustomUtil.checkMemberType(MemberType.Company)) {
                               			%>
                               		<a href="#this" onclick="if(confirm('기업회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false; self.close(); " class="btn btn-blueline icon-check btn-block">신청하기</a>
					<a href="#this" onclick="if(confirm('기업회원으로 로그인 후 이용바랍니다. 로그인페이지로 이동하시겠습니까')){location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do'} return false; self.close(); " class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
                               		<%
                               		} else{
                               		%>
                             				<a href="javascript:fn_goRegist();" class="btn btn-blueline icon-check btn-block" title="새창 열림">신청하기</a>
							<a href="https://www.snip.or.kr/SNIP/contents/Guidance3.do" target="_blank" class="btn btn-blueline2 icon-book btn-block"  title="새창연결">세무회계 온라인제출</a>
                               		<%
                               		}%>
	                                        </c:if>
                                        </c:if>
                                    </c:when>
                                </c:choose>
	                </c:when>
                    </c:choose>
</div>
                </c:if>
					<div class="btn-board_bottom">
						<a href="#" class="btn btn-list list-icon" onclick="fn_goList();return false;">목록</a>
					</div>
					<div class="board-bottom">
					<c:set var="prevVO" value="" />
                        <c:set var="nextVO" value="" />
                        	<c:forEach var="pn" items="${prevnextVO }">
                        			<c:if test="${pn.prevnext eq 'PREV' }">
                        					<c:set var="prevVO" value="${pn }" />
                        			</c:if>
                        			<c:if test="${pn.prevnext eq 'NEXT' }">
                        			     <c:set var="nextVO" value="${pn }" />
                        			</c:if>
                        	</c:forEach>
					 <ul class="prev-next-wrap">
                                <li class="prev">
                                    <strong>이전글</strong>
                                    	<c:choose>
                                    	   <c:when test="${not empty prevVO  }">
			                                    <a href="#none" onclick="fn_goView('${prevVO.snp}'); return false;"><c:out value="${prevVO.title }" /></a>
                                    	   </c:when>
                                    	   <c:otherwise>
			                                    <a href="#none">이전글이 없습니다.</a>
                                    	   </c:otherwise>
                                    	</c:choose>
                                </li>
                                <li class="next">
                                    <strong>다음글</strong>
                                            <c:choose>
                                           <c:when test="${not empty nextVO  }">
                                                <a href="#none" onclick="fn_goView('${nextVO.snp}'); return false;"><c:out value="${nextVO.title }" /></a>
                                           </c:when>
                                           <c:otherwise>
                                                <a href="#none">다음글이 없습니다.</a>
                                           </c:otherwise>
                                        </c:choose>
                                </li>
                            </ul><!--// prev-next-wrap-->
                            </div>
                    </div>
                </div>
		<style>
#hidden
{
width:1px;
height:1px;
border:0;
}
</style>
<c:if test="${not empty userSessionVO}">
		<iframe id="hidden"  title="내용없음" name="hiddenifr" src="https://www.snip.or.kr/iframe.jsp">
</iframe>
</c:if>
<script>
function down(fileId,ind) {
	$.ajax({
		url : "https://www.snip.or.kr/web/real/downCntUpdate.ajax"
		, dataType : "json"
		, data : "fileId="+fileId
		, type : "post"
		, success : function(data){
			$("#ff"+ind).text(Number($("#ff"+ind).text())+1);
		}
	});
}
var pop = null;
function fn_goRegist() {
	var child = "new_win";
	var wd = 1178;
	var he = 660;

	// 듀얼 모니터 기준
	var le = (screen.availWidth - wd) / 2;
	if( window.screenLeft < 0){
	le += window.screen.width*-1;
	}
	else if ( window.screenLeft > window.screen.width ){
	le += window.screen.width;
	}

	var tp = (screen.availHeight - he) / 2 - 10;

	var url="https://www.snip.or.kr/iframe4.jsp?snp=${result.snp }";

	var option = "resizable=no, scrollbars=1, status=no, location=no, derectories=no, width="+wd+", height=" + he + ", left="+le+", top="+tp +", screenX="+le ;
	if(pop){
		if(pop.closed){
			pop = window.open(url, child, option);
		}else{
			if(url == pop.location){
				pop.focus();
				return;
			}else{
				pop.close();
				pop = window.open(url, child, option);
			}
		}
	}else{
		pop = window.open(url, child, option);
	}
	child = pop;
}
var pop2 = null;
function fn_goRegist2() {
	var child = "new_win2";
	var wd = 1178;
	var he = 660;

	// 듀얼 모니터 기준
	var le = (screen.availWidth - wd) / 2;
	if( window.screenLeft < 0){
	le += window.screen.width*-1;
	}
	else if ( window.screenLeft > window.screen.width ){
	le += window.screen.width;
	}

	var tp = (screen.availHeight - he) / 2 - 10;

	var url="https://www.snip.or.kr/iframe5.jsp?snp=${result.snp }";

	var option = "resizable=no, scrollbars=1, status=no, location=no, derectories=no, width="+wd+", height=" + he + ", left="+le+", top="+tp +", screenX="+le ;
	if(pop2){
		if(pop2.closed){
			pop2 = window.open(url, child, option);
		}else{
			if(url == pop2.location){
				pop2.focus();
				return;
			}else{
				pop2.close();
				pop2 = window.open(url, child, option);
			}
		}
	}else{
		pop2 = window.open(url, child, option);
	}
	child = pop2;
}

	var query = "${searchVO.queryString()}";
	function fn_goList(){

		query = ItgJs.fn_replaceQueryString(query, "schOpt4", "s${searchVO.schOpt4 }");
		query = ItgJs.fn_replaceQueryString(query, "schM", "list");
		location.href = "https://www.snip.or.kr/SNIP/contents/Business21.do?" + query;
	}
	function fn_goView(idx) {
		query = ItgJs.fn_replaceQueryString(query, "schId", idx);
		query = ItgJs.fn_replaceQueryString(query, "schM", "view");
		location.href = "https://www.snip.or.kr/SNIP/contents/Business21.do?" + query;
	}

	<c:if test="${isEdit}">
	function fn_goUpdate(){
		query = ItgJs.fn_replaceQueryString(query, "schM", "update");
		location.href = "?" + query;
	}

	</c:if>

	function preview(path1,path2) {

		window.open("https://www.snip.or.kr/iframe7.jsp?path1="+path1+"&path2="+path2, "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );

	}
</script>
