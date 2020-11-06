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
 * @파일명 : userApplyConsultView.jsp
 * @파일정보 : 방산정책연구센터 > 자문단소개 > 자문신청 조회
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 04. 02. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<div class="board-wrap">
                    <div class="board-view">
                        <div class="view-info">
                            <strong class="title">
                                <c:out value="${result.title }" />
                            </strong>
                            <div class="w-data">
								<span class="line">상담인 : <c:out value="${result.name }" /></span>&nbsp;&nbsp;등록일 : <c:out value="${result.regDt }" /><span class="label-statu ${ufn:deCode(result.statusCd,'1103,end','') } ml-10"><c:out value="${result.statusName }" /></span>
                            </div>
                        </div><!--// view-info-->
                        <div class="file-list">
                            <dl>
                                <dt>첨부파일</dt>
                                <dd>
                                <c:forEach var="file" items="${userFileList }">
                                    <p>
                                		<img src="/resource/templete/cms1/src/img/common/icon_file.jpg" alt="첨부파일"> <c:out value="${file.orgFileNm }" /> (다운수 : <c:out value="${file.downCnt }" />)
	                                   	<a href="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',file.path1 ,file.orgFileNm ) }" class="btn btn-blue btn-file-down">다운로드</a>
	                                   	<a href="#none" onclick="javascript:preview('${file.path1 }','${file.path2 }');" class="btn btn-gray btn-file-down">바로보기</a>
									</p>
                                </c:forEach>
                                </dd>
                            </dl>
                        </div>
                        <div class="view-content">
                            <c:out value="${result.question }" escapeXml="false" />
						</div><!--// view-content-->
						<dl class="qan-anser">
                            <dt>
                                <span class="line">답변자 : <c:out value="${result.mgrName }" /></span>
                                <span>답변일 : <c:out value="${result.endDt }" /></span>
                            </dt>
                            <dd>
                                <c:out value="${result.reply }" escapeXml="false" />
                            </dd>
                        </dl>

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
			                                    <a href="#none" onclick="fn_goView('${prevVO.seq}'); return false;"><c:out value="${prevVO.title }" /></a>
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
                                                <a href="#none" onclick="fn_goView('${nextVO.seq}'); return false;"><c:out value="${nextVO.title }" /></a>
                                           </c:when>
                                           <c:otherwise>
                                                <a href="#none">다음글이 없습니다.</a>
                                           </c:otherwise>
                                        </c:choose>
                                </li>
                            </ul><!--// prev-next-wrap-->
						</div><!--// board-bottom-->

						<div class="btn-board_bottom">
							<a href="#none" onclick="fn_goList(); return false;" class="btn btn-list list-icon">목록</a>
						</div>

                    </div>
                </div>

<script>

	var query = "${searchVO.queryString()}";
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

function preview(path1,path2) {
	 $.ajax({
			type : "post"
			, url : "/web/link/userPreview2.ajax"
			, data : { "path1":path1,"path2" : path2  }
	        , cache: false
			, dataType : "json"
			, async: false
			, success : function(data){
				var mask = data.fileMaskExt;

				/* 로컬서버
				window.open("http://localhost/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); */

			 	/* 운영서버 */
			 	window.open("https://www.snip.or.kr/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );

				 	/* 개발서버 */
				 	/* window.open("http://snip.sitegood.co.kr/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); */

			}
			, error : function(jqXHR,textStatus,e){
				alert("문서변환 중 오류가 발생하였습니다. 관리자에게 문의해 주세요.");
				return;
			}
		});

}
</script>
