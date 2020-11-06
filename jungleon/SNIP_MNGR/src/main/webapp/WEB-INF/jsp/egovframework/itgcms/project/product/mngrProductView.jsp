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
 * @파일명 : mngrProductView.jsp
 * @파일정보 : 관리자 성남기업소개 > 성남기업 및 상품소개 > 상품정보
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 4. 8. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
				<div class="body-header">
					<div class="pull-right margin-bottom" id="headerButtons"></div>
					<script>$(function(){$("#headerButtons").html($("#footerButtons").html())})</script>
				</div>
				<form name="form1" id="form1" method="post" enctype="multipart/form-data">
					<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
					<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
					<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
					<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
					<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
					<input type="hidden" name="schId" value="<c:out value="${searchVO.schId}" />" />
						<div class="row">
							<div class="col-xs-12 table-responsive">
								<table class="table table-bordered tp2">
									<colgroup>
										<col style="width:15%"/>
										<col style="width:85%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="t"><label for="prdNm">상품명</label></th>
											<td>
												<input type="text" name="prdNm" id="prdNm" class="required form-control input-sm f-wd-600" value="<c:out value="${result.prdNm }"/>" maxlength="50" title="상품명" />
											</td>
										</tr>
										<tr>
											<th class="t">상품이미지1</th>
											<td>
											<c:if test="${not empty result.prdImg01 }">
												<p>
												<img width="300" src="<c:url value="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',fn:substring(result.prdImgPath01,1,fn:length(result.prdImgPath01)) ,result.prdImg01 ) }" />" alt="${result.prdNm }" />
												<%-- <img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath01,result.prdImg01) }" />" width="300" alt="상품 이미지1"/></a> --%>
													<input type="hidden" name="prdImg01Old" value="<c:out value="${result.prdImg01 }" />" />
												</p>
											</c:if>
												<p><input type="file" name="prdImg01" id="prdImg01" class="validate-is-image" title="상품 이미지1" /></p>
											</td>
										</hr>
										<tr>
											<th class="t">상품이미지2</th>
											<td>
											<c:if test="${not empty result.prdImg02 }">
												<p>
												<img width="300" src="<c:url value="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',fn:substring(result.prdImgPath02,1,fn:length(result.prdImgPath02)) ,result.prdImg02 ) }" />" alt="${result.prdNm }" />
												<%-- <img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath02,result.prdImg02) }" />" width="300" alt="상품 이미지2"/></a> --%>
													<input type="hidden" name="prdImg02Old" value="<c:out value="${result.prdImg02 }" />" />
												</p>
											</c:if>
												<p><input type="file" name="prdImg02" id="prdImg02" class="validate-is-image" title="상품 이미지2" /></p>
											</td>
										</hr>
										<tr>
											<th class="t">상품이미지3</th>
											<td>
											<c:if test="${not empty result.prdImg03 }">
												<p>
												<img width="300" src="<c:url value="/comm/download2.do?f=${ufn:getDownloadLink('','gallery',fn:substring(result.prdImgPath03,1,fn:length(result.prdImgPath03)) ,result.prdImg03 ) }" />" alt="${result.prdNm }" />
												<%-- <img src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdImgPath03,result.prdImg03) }" />" width="300" alt="상품 이미지3"/></a> --%>
													<input type="hidden" name="prdImg03Old" value="<c:out value="${result.prdImg03 }" />" />
												</p>
											</c:if>
												<p><input type="file" name="prdImg03" id="prdImg03" class="validate-is-image" title="상품 이미지3" /></p>
											</td>
										</hr>
										<tr>
											<th class="t">동영상 첨부</th>
											<td>
												<c:if test="${not empty result.prdVideo01 }">
													<p><video src="/comm/download.do?f=${ufn:getSnipErpFilePath(result.prdVideoPath01,result.prdVideo01 ) }" width="400" controls>
															<source src="${result.prdVideo01}" type="video/mp4">
															<source src="${result.prdVideo01 }" type="video/WebM">
															<source src="${result.prdVideo01 }" type="video/ogg">
															해당 브라우져는 비디오태그를 지원하지 않습니다.
														</video>
													</p>
												</c:if>
												<p><input type="file" name="prdVideo01" id="prdVideo01" class="" title="상품 소개 동영상" /></p>
											</td>
										</tr>
										<tr>
											<th class="t">썸네일 이미지</th>
											<td>
												<c:if test="${not empty result.prdThumb01 }">
													<p><img id="prevImg" src="<c:url value="/comm/viewImage.do?f=${ufn:getSnipErpFilePath(result.prdThumbPath01,result.prdThumb01) }" />" width="300" alt="썸네일 이미지"/></a>
														<input type="hidden" name="prdThumb01" value="<c:out value="${result.prdThumb01 }" />" />
													</p>
												</c:if>
												<p>가로: px 세로: px</p>
												<p><input type="file" name="prdThumb01" id="prdThumb01" class="validate-is-image" title="썸네일 이미지" onchange="handImgFileSelect(event, 'prevImg')" /></p>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="prdDescShort">제품소개</label></th>
											<td>
												<textarea name="prdDescShort" id="prdDescShort" class="required form-control input-sm f-wd-600" maxlength="200" rows="5">${result.prdDescShort }</textarea>
											</td>
										</tr>
										<tr>
											<th class="t">회사명</th>
											<td>
												<c:out value="${result.comNm }" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="telNo">전화번호</label></th>
											<td>
												<input type="text" name="telNo" id="telNo" class="form-control input-sm f-wd-600" value="<c:out value="${result.telNo }"/>" maxlength="20" title="전화번호" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="faxNo">팩스번호</label></th>
											<td>
												<input type="text" name="faxNo" id="faxNo" class="form-control input-sm f-wd-600" value="<c:out value="${result.faxNo }"/>" maxlength="20" title="팩스번호" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="homePage">홈페이지</label></th>
											<td>
												<input type="text" name="homePage" id="homePage" class="form-control input-sm f-wd-600" value="<c:out value="${result.homePage }"/>" maxlength="50" title="상품명" />
											</td>
										</tr>
									</tbody>
								</table>
							</div><!-- /.col -->
						</div><!-- /inner row -->
					</form>
					<div class="body-footer" id="footerButtons">
						<div class="pull-right">
								<button type="button" onclick="fn_egov_save(); return false;" class="btn btn-primary">저장</button>
								<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
								<button type="button" onclick="fn_goList(); return false;" class="btn btn-default">목록</button>
						</div>
					</div><!-- /.body-footer -->
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
<script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>
<script type="text/javascript">
//<[[!CDATA[
var query = "<c:out value="${searchVO.query}" escapeXml="false" />";


/* 목록 이동 function */
function fn_goList(){
	query = ItgJs.fn_replaceQueryString(query, "schId", "");
	query = ItgJs.fn_replaceQueryString(query, "schM", "list");
	location.href="?" + query;
}

function fn_egov_save() {
	var frm = document.form1;
	if(Validator.validate(frm)){
		if(confirm("수정하시겠습니까?")){
			frm.action = "/_mngr_/module/${menuCode}_mngrProductUpdateProc.do" ;
			frm.submit();
		}
	}
}
function fn_goDel(){
	var frm = document.form1;
	if(confirm("삭제하시겠습니까?")) {
		frm.action="/_mngr_/module/${menuCode}_mngrProductDeleteProc.do"
		frm.submit();
	}
}

var sel_file;
function handImgFileSelect(e, prevId) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")) {
			return;
		}
		sel_file = f;
		var reader = new FileReader();
		reader.onload = function(e){
			$("#" + prevId).attr("src", e.target.result);
		}
		reader.readAsDataURL(f);
	})
}
//]]>
</script>