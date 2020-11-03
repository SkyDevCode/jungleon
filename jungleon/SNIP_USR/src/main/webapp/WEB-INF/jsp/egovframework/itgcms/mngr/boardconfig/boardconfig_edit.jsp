<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%@ taglib prefix="cct" uri="/WEB-INF/tlds/CreateCodeTag.tld" %>
<%
/**
 * @파일명 : mngrBoardconfigRegist.jsp
 * @파일정보 : 게시판관리 등록
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
<c:set var="lockCustom" value="N"/>
<fmt:formatNumber var="boardCnt" value="${result.boardCnt}" type="number" />
<c:if test="${searchVO.act eq 'UPDATE' and result.boardCnt > 0}"> 
	<c:set var="lockCustom" value="Y"/>
</c:if>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.exedit-3.5.js"></script>
<link rel="stylesheet" type="text/css" href="/resource/common/jquery_plugin/validation/validator.css" />
<script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-header">
				<div class="pull-right" id="headerButtons"></div>
				<script>$(function(){$("#headerButtons").html($("#footerButtons").html())})</script>
			</div>
			<div class="box-body" style="padding-top:10px;">
       		<form name="bcform" id="bcform" method="post">
				<input type="hidden" name="bcType" value="1" />
				<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
				<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
				<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
				<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
				<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
				<input type="hidden" name="id" value="<c:out value="${searchVO.id}" />" />
				<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
				<input type="hidden" name="bcExtcolumninfo" value="<c:out value="${result.bcExtcolumninfo}"/>" />
				<input type="hidden" name="schId" value="<c:out value="${categoryInfo.cidx}"/>" />
				<div class="row">
					<div class="col-xs-12 table-responsive">
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:15%"/>
								<col style="width:35%"/>
								<col style="width:15%"/>
								<col style="width:35%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="bcId">게시판 아이디[${boardCnt}]</label></th>
									<td>
									<c:choose>
										<c:when test="${searchVO.act eq 'REGIST' }">
										<div class="form-inline">
											<input type="text" name="bcId" id="bcId" maxlength="40" value="<c:out value="${result.bcId}"/>" class="required form-control input-sm f-wd-200" title="게시판 아이디" onchange="fn_checkId(this.value);" />
											<span id="idHelp" class="help-block" style="display: inline-block;margin-left: 10px;">영문자 20자 이내</span>
										</div>
										</c:when>
										<c:when test="${searchVO.act eq 'UPDATE' }">
										<c:out value="${result.bcId}"/>
										</c:when>
									</c:choose>
									</td>
									<th class="t"><label for="bcName">게시판 이름</label></th>
									<td><input type="text" name="bcName" id="bcName" maxlength="50" value="<c:out value="${result.bcName}"/>" class="required form-control input-sm f-wd-200" title="게시판 이름" /></td>
								</tr>
								<tr>
									<th class="t"><label for="bcTopinfo">게시판 상단 정보</label></th>
									<td colspan="3">
										<textarea name="bcTopinfo" id="bcTopinfo" class="form-control" title="게시판 상단 정보" maxlength="1000" ><c:out value="${result.bcTopinfo }" /></textarea>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="bcSkin">게시판스킨</label></th>
									<td>
										<select name="bcSkin" id="bcSkin"  title="게시판 스킨" class="required form-control input-sm f-wd-200" onchange="fn_setSkinOption(this.value)">
											<option>게시판 스킨</option>
											<c:forEach var="skin" items="${skinList }">
												<option value="<c:out value="${skin.code }" />" ${ufn:selected(result.bcSkin, skin.code) }><c:out value="${skin.name }" /></option>
											</c:forEach>
										</select>
									</td>
									<th class="t"><label for="bcViewcount">목록갯수</label></th>
									<td>
										<input type="text" name="bcViewcount" id="bcViewcount" maxlength="4" value="<c:out value="${result.bcViewcount}"/>" onkeydown="return ItgJs.fn_numberOnly(event)" class="required validate-digits form-control input-sm f-wd-100" title="목록갯수" />
									</td>
								</tr>
								<tr>
									<th class="t" colspan="4"><span>권한설정</span></th>
								</tr>
								<tr>
									<th class="t"><label for="bcList">목록 권한</label></th>
									<td>
									  <div class="form-inline">
											<select name="bcMngrList" id="bcMngrList" title="관리자 목록 권한" class="required form-control input-sm f-wd-200">
												<c:forEach var="auth" items="${mngrAuthList }">
													<option value="<c:out value="${auth.code }" />" ${ufn:selected(result.bcMngrList, auth.code) }><c:out value="${auth.name }" /></option>
												</c:forEach>
											</select>
											<select name="bcList" id="bcList" title="사용자 목록 권한" class="required form-control input-sm f-wd-200">
												<c:forEach var="auth" items="${userAuthList }">
													<option value="<c:out value="${auth.code }" />" ${ufn:selected(result.bcList, auth.code) }><c:out value="${auth.name }" /></option>
												</c:forEach>
											</select>
										</div>
									</td>
									<th class="t"><label for="bcView">뷰 조회 권한</label></th>
									<td>
									  <div class="form-inline">
											<select name="bcMngrView" id="bcMngrView" title="관리자 뷰 조회 권한" class="required form-control input-sm f-wd-200">
												<c:forEach var="auth" items="${mngrAuthList }">
													<option value="<c:out value="${auth.code }" />" ${ufn:selected(result.bcMngrView, auth.code) }><c:out value="${auth.name }" /></option>
												</c:forEach>
											</select>
											<select name="bcView" id="bcView" title="사용자 뷰 조회 권한" class="required form-control input-sm f-wd-200">
												<c:forEach var="auth" items="${userAuthList }">
													<option value="<c:out value="${auth.code }" />" ${ufn:selected(result.bcView, auth.code) }><c:out value="${auth.name }" /></option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="bcRegist">등록 권한</label></th>
									<td>
									  <div class="form-inline">
											<select name="bcMngrRegist" id="bcMngrRegist" title="관리자 등록 권한" class="required form-control input-sm f-wd-200">
												<c:forEach var="auth" items="${mngrRegistAuthList }">
													<option value="<c:out value="${auth.code }" />" ${ufn:selected(result.bcMngrRegist, auth.code) }><c:out value="${auth.name }" /></option>
												</c:forEach>
											</select>
											<select name="bcRegist" id="bcRegist" title="사용자 등록 권한" style="display: none;" class="form-control input-sm f-wd-200 _SKINOPTION_ forDEFAULT forQNA forCUSTOM">
												<c:forEach var="auth" items="${userRegistAuthList }">
													<option value="<c:out value="${auth.code }" />" ${ufn:selected(result.bcRegist, auth.code) }><c:out value="${auth.name }" /></option>
												</c:forEach>
											</select>
										</div>
									</td>
									<th class="t"><label for="bcUpdate">수정(삭제) 권한</label></th>
									<td>
									  <div class="form-inline">
											<select name="bcMngrUpdate" id="bcMngrUpdate" title="관리자 수정 권한" class="required form-control input-sm f-wd-200">
												<c:forEach var="auth" items="${mngrAuthList }">
													<option value="<c:out value="${auth.code }" />" ${ufn:selected(result.bcMngrUpdate, auth.code) }><c:out value="${auth.name }" /></option>
												</c:forEach>
											</select>
											<select name="bcUpdate" id="bcUpdate" title="사용자 수정 권한" style="display: none;" class="required form-control input-sm f-wd-200 _SKINOPTION_ forDEFAULT forQNA forCUSTOM">
												<c:forEach var="auth" items="${userDeleteAuthList }">
													<option value="<c:out value="${auth.code }" />" ${ufn:selected(result.bcUpdate, auth.code) }><c:out value="${auth.name }" /></option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr class="_SKINOPTION_ forDEFAULT forGALLERY forGALLERY2 forMOVIE" style="display: none;">
									<th class="t"><label for="bcReply">답변 권한</label></th>
									<td colspan="3">
										<div class="form-inline">
											<label><input type="radio" name="bcReplyyn" id="bcReplyyn1" title="답변 사용 여부" value="Y" ${ufn:checked(result.bcReplyyn, 'Y') }/> 사용</label>
											<label><input type="radio" name="bcReplyyn" id="bcReplyyn2" title="답변 사용 여부" value="N" ${ufn:checked(result.bcReplyyn, 'N') } ${ufn:checked(result.bcReplyyn, '') }/> 미사용</label>
											<select name="bcMngrReply" id="bcMngrReply" title="관리자 답변 권한" class="form-control input-sm f-wd-200" style="margin-left:10px;">
												<c:forEach var="auth" items="${mngrRegistAuthList }">
													<option value="<c:out value="${auth.code }" />" ${ufn:selected(result.bcMngrReply, auth.code) }><c:out value="${auth.name }" /></option>
												</c:forEach>
											</select>
											<select name="bcReply" id="bcReply" title="사용자 답변 권한" style="display: none;" class="form-control input-sm f-wd-200 _SKINOPTION_ forDEFAULT">
												<c:forEach var="auth" items="${userRegistAuthList }">
													<option value="<c:out value="${auth.code }" />" ${ufn:selected(result.bcReply, auth.code) }><c:out value="${auth.name }" /></option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th class="t" colspan="4"><span>기능설정</span></th>
								</tr>
								<tr>
									<th class="t"><label for="bcFileyn1">첨부파일 기능</label></th>
									<td colspan="3">
										<div class="form-inline">
											<label><input type="radio" name="bcFileyn" id="bcFileyn1" title="첨부파일 기능" value="Y" ${ufn:checked(result.bcFileyn, 'Y') }/> 사용</label>
											<label><input type="radio" name="bcFileyn" id="bcFileyn2" title="첨부파일 기능" value="N" ${ufn:checked(result.bcFileyn, 'N') } ${ufn:checked(result.bcFileyn, '') }/> 미사용</label>
											<select name="bcFilecount" id="bcFilecount" title="첨부파일 갯수" class="form-control input-sm f-wd-200" style="margin-left:10px;">
												<option value="">첨부파일 갯수</option>
												<option value="1" ${ufn:selected(result.bcFilecount, '1') }>1</option>
												<option value="2" ${ufn:selected(result.bcFilecount, '2') }>2</option>
												<option value="3" ${ufn:selected(result.bcFilecount, '3') }>3</option>
												<option value="4" ${ufn:selected(result.bcFilecount, '4') }>4</option>
												<option value="5" ${ufn:selected(result.bcFilecount, '5') }>5</option>
												<option value="10" ${ufn:selected(result.bcFilecount, '10') }>10</option>
												<option value="15" ${ufn:selected(result.bcFilecount, '15') }>15</option>
												<option value="20" ${ufn:selected(result.bcFilecount, '20') }>20</option>
											</select>
											<select name="bcFilesize" id="bcFilesize" title="첨부파일 용량 제한" class="form-control input-sm f-wd-200" >
												<option value="">첨부파일 용량 제한</option>
												<option value="1" ${ufn:selected(result.bcFilesize, '1') }>1 MB</option>
												<option value="3" ${ufn:selected(result.bcFilesize, '3') }>3 MB</option>
												<option value="5" ${ufn:selected(result.bcFilesize, '5') }>5 MB</option>
												<option value="10" ${ufn:selected(result.bcFilesize, '10') }>10 MB</option>
												<option value="20" ${ufn:selected(result.bcFilesize, '20') }>20 MB</option>
												<option value="30" ${ufn:selected(result.bcFilesize, '30') }>30 MB</option>
												<option value="50" ${ufn:selected(result.bcFilesize, '50') }>50 MB</option>
												<option value="100" ${ufn:selected(result.bcFilesize, '100') }>100 MB</option>
												<option value="200" ${ufn:selected(result.bcFilesize, '200') }>200 MB</option>
												<option value="300" ${ufn:selected(result.bcFilesize, '300') }>300 MB</option>
												<option value="500" ${ufn:selected(result.bcFilesize, '500') }>500 MB</option>
												<option value="1000" ${ufn:selected(result.bcFilesize, '1000') }>1000 MB</option>
											</select><br/>
											<span id="fileType" style="display:inline-block;margin-top:10px;">
												<label onclick="ItgJs.fn_checkAll($('#fileTypeAll')[0], 'fileType')"><input type="checkbox" value="all" id="fileTypeAll"/> 모든 파일</label>&nbsp;&nbsp;
												<label onclick="ItgJs.fn_check('fileType', 'fileTypeAll');"><input type="checkbox" name="fileType" value="image"/> 이미지</label>&nbsp;&nbsp;
												<label onclick="ItgJs.fn_check('fileType', 'fileTypeAll');"><input type="checkbox" name="fileType" value="doc"/> 문서</label>&nbsp;&nbsp;
												<label onclick="ItgJs.fn_check('fileType', 'fileTypeAll');"><input type="checkbox" name="fileType" value="video"/> 동영상</label>&nbsp;&nbsp;
												<label onclick="ItgJs.fn_check('fileType', 'fileTypeAll');"><input type="checkbox" name="fileType" value="audio"/> 음악</label>&nbsp;&nbsp;
												<label onclick="ItgJs.fn_check('fileType', 'fileTypeAll');"><input type="checkbox" name="fileType" value="cmpf"/> 압축</label>
												<input type="hidden" name="bcFiletypedesc" value="${result.bcFiletypedesc}" id="fileTypeDesc"/>
											</span>
										</div>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="bcSecretyn">비밀글 기능</label></th>
									<td>
										<label><input type="radio" name="bcSecretyn" id="bcSecretyn1" title="비밀글 사용 여부" value="Y" ${ufn:checked(result.bcSecretyn, 'Y') }/> 사용</label>
										<label><input type="radio" name="bcSecretyn" id="bcSecretyn2" title="비밀글 사용 여부" value="N" ${ufn:checked(result.bcSecretyn, 'N') } ${ufn:checked(result.bcSecretyn, '') }/> 미사용</label>
									</td>
									<th class="t"><label for="bcNoticeyn">공지글 기능</label></th>
									<td>
										<label><input type="radio" name="bcNoticeyn" id="bcNoticeyn1" title="공지글 사용 여부" value="Y" ${ufn:checked(result.bcNoticeyn, 'Y') }/> 사용</label>
										<label><input type="radio" name="bcNoticeyn" id="bcNoticeyn2" title="공지글 사용 여부" value="N" ${ufn:checked(result.bcNoticeyn, 'N') } ${ufn:checked(result.bcNoticeyn, '') }/> 미사용</label>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="bcGroupyn">카테고리 기능</label></th>
									<td><c:if test="${searchVO.act eq 'UPDATE' }">
										<label><input type="radio" name="bcGroupyn" id="bcGroupyn1" title="카테고리 사용 여부" value="Y" ${ufn:checked(result.bcGroupyn, 'Y') }/> 사용</label>
										<label><input type="radio" name="bcGroupyn" id="bcGroupyn2" title="카테고리 사용 여부" value="N" ${ufn:checked(result.bcGroupyn, 'N') } ${ufn:checked(result.bcGroupyn, '') }/> 미사용</label>
										<div style="display:inline-block;margin-left: 10px;"><button id="bcGroupynBtn" type="button" class="btn btn-default btn-xs " style="margin-right:20px;" onclick="fn_openCate();">카테고리관리</button></div>
										</c:if>
										<c:if test="${searchVO.act ne 'UPDATE' }">
										<input type="hidden" name="bcGroupyn" value="N">
										<div class="help-block" style="display:inline-block">게시판 등록 시에는 카테고리기능을 관리할 수 없습니다. 카테고리 사용을 원하시면 게시판 등록 후 수정 화면에서 진행해 주세요.</div>
										</c:if>
									</td>
									<th class="t"><label for="bcEditoryn">에디터 기능</label></th>
									<td>
										<label><input type="radio" name="bcEditoryn" id="bcEditoryn1" title="에디터 사용 여부" value="Y" ${ufn:checked(result.bcEditoryn, 'Y') }/> 사용</label>
										<label><input type="radio" name="bcEditoryn" id="bcEditoryn2" title="에디터 사용 여부" value="N" ${ufn:checked(result.bcEditoryn, 'N') } ${ufn:checked(result.bcEditoryn, '') }/> 미사용</label>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="bcPrevnextyn1">이전/다음글 기능</label></th>
									<td>
										<label><input type="radio" name="bcPrevnextyn" id="bcPrevnextyn1" title="이전/다음글 사용 여부" value="Y" ${ufn:checked(result.bcPrevnextyn, 'Y') }/> 사용</label>
										<label><input type="radio" name="bcPrevnextyn" id="bcPrevnextyn2" title="이전/다음글 사용 여부" value="N" ${ufn:checked(result.bcPrevnextyn, 'N') } ${ufn:checked(result.bcPrevnextyn, '') }/> 미사용</label>
									</td>
									<th class="t"><label for="bcRSS">게시글 RSS 제공</label></th>
									<td>
										<label><input type="radio" name="bcRSS" id="bcRSS1" title="RSS 사용 여부" value="Y" ${ufn:checked(result.bcRSS, 'Y') }/> 사용</label>
										<label><input type="radio" name="bcRSS" id="bcRSS2" title="RSS 사용 여부" value="N" ${ufn:checked(result.bcRSS, 'N') } ${ufn:checked(result.bcRSS, '') }/> 미사용</label>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="bcKoglyn1">공공누리 기능</label></th>
									<td>
										<label><input type="radio" name="bcKoglyn" id="bcKoglyn1" title="공공누리 사용 여부" value="Y" ${ufn:checked(result.bcKoglyn, 'Y') }/> 사용</label>
										<label><input type="radio" name="bcKoglyn" id="bcKoglyn2" title="공공누리 사용 여부" value="N" ${ufn:checked(result.bcKoglyn, 'N') } ${ufn:checked(result.bcKoglyn, '') }/> 미사용</label>
									</td>
								</tr>
								<tr class="_SKINOPTION_ forGALLERY forWEBZINE forMOVIE forCUSTOM forPHOTO1 forPHOTO2 forPHOTO3 forVOD forFILE2 forFILE3 forCUSTOM6 forNORMAL03 forNORMAL01 forCOLLECTION" style="display: none;">
									<th class="t"><label for="bcThumbyn1">썸네일</label></th>
									<td colspan="3">
									    <div class="form-inline">
										    <label><input type="radio" name="bcThumbyn" id="bcThumbyn1" title="썸네일 기능" value="Y" ${ufn:checked(result.bcThumbyn, 'Y') } /> 사용</label>
                          						<label><input type="radio" name="bcThumbyn" id="bcThumbyn1" title="썸네일 기능" value="N" ${ufn:checked(result.bcThumbyn, 'N') } ${ufn:checked(result.bcThumbyn, '') } ${ufn:readOnly(result.bcSkin, 'gallery')} ${ufn:readOnly(result.bcSkin, 'gallery2')}/> 미사용</label>
                                              </div>
                        						<div class="form-inline" id="bcThumbOptn">
                        							<%-- <strong>썸네일 개수</strong> :
												    <select name="bcThumbcount" id="bcThumbcount" title="썸네일 갯수" class="form-control input-sm f-wd-200" style="margin-right:10px;">
						                              <option value="1" ${ufn:selected(result.bcThumbcount, '1') }>1</option>
						                              <option value="2" ${ufn:selected(result.bcThumbcount, '2') }>2</option>
						                              <option value="3" ${ufn:selected(result.bcThumbcount, '3') }>3</option>
						                            </select> --%>
                          						<strong>가로 사이즈(10~999)</strong> : <input type="text" name="bcThumbwidth" id="bcThumbwidth" maxlength="3" value="<c:out value="${result.bcThumbwidth}"/>" onkeydown="return ItgJs.fn_numberOnly(event)" class="form-control input-sm f-wd-200" title="썸네일 가로 사이즈" style="margin-right:10px;"/>
                          						<strong>세로 사이즈(10~999)</strong> : <input type="text" name="bcThumbheight" id="bcThumbheight" maxlength="3" value="<c:out value="${result.bcThumbheight}"/>" onkeydown="return ItgJs.fn_numberOnly(event)" class="form-control input-sm f-wd-200" title="썸네일 세로 사이즈" style="margin-right:10px;"/>
                          						<input type="checkbox" name="bcThumbratioyn" id="bcThumbratioyn" ${ufn:checked(result.bcThumbratioyn, 'Y') } title="비율유지" value="Y" /><label for="bcThumbratioyn">비율 유지</label>
                        						</div>
									</td>
								</tr>
								<tr>
									<th class="t"><span>댓글 기능</span></th>
									<td colspan="3">
										<input type="radio" name="bcComment" value="1" id="commentOn" <c:out value="${result.bcComment == 1 ? 'checked' : '' }"/>/> <label for="commentOn">사용</label>
										<input type="radio" name="bcComment" value="0" id="commentOff" <c:out value="${result.bcComment == 0 ? 'checked' : '' }"/>/> <label for="commentOff">미사용</label>
									</td>
								</tr>
								<tr class="_SKINOPTION_ forDEFAULT forQNA" style="display: none;">
									<th class="t"><label for="bcDefaultpage">기본페이지</label></th>
									<td colspan="3">
									    <select name="bcDefaultpage" id="bcDefaultpage" title="기본페이지" class="required form-control input-sm f-wd-200">
									        <option value="list" ${ufn:selected(result.bcDefaultpage, 'list') }>목록페이지</option>
									        <option value="input" ${ufn:selected(result.bcDefaultpage, 'input') }>등록페이지</option>
									    </select>
<%-- 													<input type="text" name="bcDefaultpage" id="bcDefaultpage" maxlength="50" value="<c:out value="${result.bcDefaultpage}"/>" class="required form-control input-sm f-wd-200" title="기본페이지" /> --%>
									</td>
								</tr>
								<tr class="_SKINOPTION_ forCUSTOM customColumnHeaderTr" style="display: none;">
									<th class="t" colspan="4">
										<span>커스텀컬럼</span> <span><button type="button" onclick="fn_addCusColumn();" class="btn btn-warning btn-xs">추가</button></span>
										<c:if test="${lockCustom eq 'Y' }">
											<br/>
											<div class="help-block" style="display:inline-block">
												해당 게시판에 게시글이 존재합니다. 기존 컬럼에 대한 일부 기능은 사용에 제한이 있습니다.<br/>
												제한기능 : 컬럼타입변경, 컬럼삭제
											</div>
										</c:if>
									</th>
								</tr>
								<tr class="_SKINOPTION_ forCUSTOM customColumnLowTr" style="display: none; background-color:white;">
									<td colspan="4" id="customColumnLowTd">
										<div class="customColumnLowDiv default bdContent">
											<!-- <span><label>코드</label> : <input type="text" name="columnCode" value="bdContent" class="required form-control input-sm f-wd-100" title="컬럼코드" readonly="readonly"/></span> -->
											<input type="hidden" name="columnCode" value="bdContent"/>
											<span><label>컬럼명</label> : <input type="text" name="columnName" maxlength="30" value="" class="required form-control input-sm f-wd-200" title="컬럼명" /></span>
											<span><label>컬럼타입</label> : <input type="text" name="columnType" maxlength="30" value="내용(기본)" class="required form-control input-sm f-wd-150" title="컬럼타입" readonly="readonly"/></span>
											<span class="size"><label>컬럼길이</label> : <input type="text" name="columnSize" maxlength="5" value="0" class="form-control input-sm f-wd-60 validate-digits" title="컬럼길이" /></span>
											<span><label>기본값</label> : <input type="text" name="defaultVal" maxlength="30" value="" class="form-control input-sm f-wd-200" title="기본값" /></span>
											<span class="check-group"><input type="checkbox" name="isRequired" value="Y" title="필수값여부" onclick="fn_requiredCusColumn(this);" checked="checked"/><label for="isRequired">필수값</label></span>
											<!-- <span><input type="checkbox" name="isUsed" value="Y" title="사용여부" checked="checked" onclick="fn_useCusColumn(this);"/> 사용</span> -->
											<span class="btn-group">
												<button type="button" onclick="fn_upCusColumn(this);" class="btn btn-warning btn-xs"><i class="fa fa-arrow-up"></i></button>
												<button type="button" onclick="fn_downCusColumn(this);" class="btn btn-warning btn-xs"><i class="fa fa-arrow-down"></i></button>
												<!-- <button type="button" onclick="fn_delCusColumn(this);" class="btn btn-warning btn-xs">삭제</button> -->
											</span>
										</div>
										<div class="customColumnLowDiv default bdThumb">
											<!-- <span><label>코드</label> : <input type="text" name="columnCode" value="bdThumb" class="required form-control input-sm f-wd-100" title="컬럼코드" readonly="readonly"/></span> -->
											<input type="hidden" name="columnCode" value="bdThumb"/>
											<span><label>컬럼명</label> : <input type="text" name="columnName" maxlength="30" value="" class="required form-control input-sm f-wd-200" title="컬럼명" /></span>
											<span><label>컬럼타입</label> : <input type="text" name="columnType" maxlength="30" value="썸네일(기본)" class="required form-control input-sm f-wd-150" title="컬럼타입" readonly="readonly"/></span>
											<span class="size"><label>컬럼길이</label> : <input type="text" name="columnSize" maxlength="4" value="0" class="form-control input-sm f-wd-60 validate-digits" title="컬럼길이" disabled="disabled"/></span>
											<span><label>기본값</label> : <input type="text" name="defaultVal" maxlength="30" value="" class="form-control input-sm f-wd-200" title="기본값" disabled="disabled"/></span>
											<span class="check-group"><input type="checkbox" name="isRequired" value="Y" title="필수값여부" /><label for="isRequired">필수값</label></span>
											<span class="btn-group">
												<button type="button" onclick="fn_upCusColumn(this);" class="btn btn-warning btn-xs"><i class="fa fa-arrow-up"></i></button>
												<button type="button" onclick="fn_downCusColumn(this);" class="btn btn-warning btn-xs"><i class="fa fa-arrow-down"></i></button>
												<!-- <button type="button" onclick="fn_delCusColumn(this);" class="btn btn-warning btn-xs">삭제</button> -->
											</span>
										</div>
										<div class="customColumnLowDiv default fileId">
											<!-- <span><label>코드</label> : <input type="text" name="columnCode" value="fileId" class="required form-control input-sm f-wd-100" title="컬럼코드" readonly="readonly"/></span> -->
											<input type="hidden" name="columnCode" value="fileId"/>
											<span><label>컬럼명</label> : <input type="text" name="columnName" maxlength="30" value="" class="required form-control input-sm f-wd-200" title="컬럼명" /></span>
											<span><label>컬럼타입</label> : <input type="text" name="columnType" maxlength="30" value="첨부파일(기본)" class="required form-control input-sm f-wd-150" title="컬럼타입" readonly="readonly"/></span>
											<span class="size"><label>컬럼길이</label> : <input type="text" name="columnSize" maxlength="4" value="0" class="form-control input-sm f-wd-60 validate-digits" title="컬럼길이" disabled="disabled"/></span>
											<span><label>기본값</label> : <input type="text" name="defaultVal" maxlength="30" value="" class="form-control input-sm f-wd-200" title="기본값" disabled="disabled"/></span>
											<span class="check-group"><input type="checkbox" name="isRequired" value="Y" title="필수값여부" /><label for="isRequired">필수값</label></span>
											<span class="btn-group">
												<button type="button" onclick="fn_upCusColumn(this);" class="btn btn-warning btn-xs"><i class="fa fa-arrow-up"></i></button>
												<button type="button" onclick="fn_downCusColumn(this);" class="btn btn-warning btn-xs"><i class="fa fa-arrow-down"></i></button>
												<!-- <button type="button" onclick="fn_delCusColumn(this);" class="btn btn-warning btn-xs">삭제</button> -->
											</span>
										</div>
										<div class="customColumnLowDiv custom">
											<input type="hidden" name="columnCode" value=""/>
											<span><label>컬럼명</label> : <input type="text" name="columnName" maxlength="30" value="" class="required form-control input-sm f-wd-200" title="컬럼명" /></span>
											<span><label>컬럼타입</label> : <cct:codeTag pidx="72" tagType="select" tagName="columnType" addOptData="data-type,etc1" tagTitle="컬럼타입" className="form-control input-sm f-wd-150 typeSelect required columnType" useNullOpt="N"/></span>
											<span class="size"><label>컬럼길이</label> : <input type="text" name="columnSize" maxlength="4" value="0" class="form-control input-sm f-wd-60 validate-digits_4000" title="컬럼길이" /></span>
											<span><label>기본값</label> : <input type="text" name="defaultVal" maxlength="30" value="" class="form-control input-sm f-wd-200" title="기본값" /></span>
											<span class="check-group"><input type="checkbox" name="isRequired" value="Y" title="필수값여부"/><label for="isRequired">필수값</label>
											<input type="checkbox" name="isUsed" value="Y" title="사용여부" checked="checked" onclick="fn_useCusColumn(this);"/><label for="isRequired">사용</label></span>
											<span class="btn-group">
												<button type="button" onclick="fn_upCusColumn(this);" class="btn btn-warning btn-xs"><i class="fa fa-arrow-up"></i></button>
												<button type="button" onclick="fn_downCusColumn(this);" class="btn btn-warning btn-xs"><i class="fa fa-arrow-down"></i></button>
												<button type="button" onclick="fn_delCusColumn(this);" class="btn btn-warning btn-xs delete">삭제</button>
											</span>
										</div>
									</td>
								</tr>
						<c:if test="${searchVO.act eq 'UPDATE' }">
								<tr>
									<th class="t" colspan="4"><span>등록정보</span></th>
								</tr>
								<tr>
									<th class="t"><span>등록일</span></th>
									<td><c:out value="${result.regdt }" /></td>
									<th class="t"><span>등록자아이디</span></th>
									<td><c:out value="${result.regmemid }" /></td>
								</tr>
								<c:if test="${not empty result.upddt }">
								<tr>
									<th class="t"><span>수정일</span></th>
									<td><c:out value="${result.upddt }" /></td>
									<th class="t"><span>수정자아이디</span></th>
									<td><c:out value="${result.updmemid }" /></td>
								</tr>
								</c:if>
							</c:if>
							</tbody>
						</table>
					</div><!-- /.col -->
				</div>
				</form>
				<div class="pull-right" id="footerButtons">
					<button type="button" onclick="fn_getBoardconfigList();" class="btn btn-warning">게시판 설정 가져오기</button>
					<button type="button" onclick="fn_egov_save(); return false;" class="btn btn-primary">저장</button>
				<c:if test="${searchVO.act == 'UPDATE' }">
					<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
				</c:if>
					<button type="button" onclick="fn_goList(); return false;" class="btn btn-default">목록</a>
				</div>
			</div>
		</div><!-- /.box -->
	</div><!-- /.col-md-12 -->
</div><!-- /.row -->

<script type="text/javascript">
//<[[!CDATA[
var checkFlag = false;

$(document).ready(function(){
	$(".for${fn:toUpperCase(result.bcSkin)}").show();
	$(".for${fn:toUpperCase(result.bcSkin)}").addClass("required");

	//커스텀기능요소세팅
	fn_initCustom();

	//게시판기능세팅
	changeReplyyn("${result.bcReplyyn}");
	changeFileyn("${result.bcFileyn}");
	changeGroupyn("${result.bcGroupyn}");
	changeThumbyn("${result.bcThumbyn}");
	fn_setSkinOption('${result.bcSkin}');

	$("input[name=bcReplyyn]").change(function(){
		changeReplyyn(this.value);
	});
	$("input[name=bcFileyn]").change(function(){
		changeFileyn(this.value);
	});
	$("input[name=bcGroupyn]").change(function(){
		changeGroupyn(this.value);
	});
	$("input[name=bcThumbyn]").change(function(){
		changeThumbyn(this.value);
	});
	//커스텀컬럼타입변경이벤트
	$("select[name=columnType]").change(function(){
		changeColumnType(this);
	});

});

/* 기능 조건별 표출 function */
function changeReplyyn(value){
	if(value == 'Y'){
		$("#bcReply").show();
		$("#bcMngrReply").show();
		$("#bcReply").addClass("required");
	}else{
		$("#bcReply").hide();
		$("#bcMngrReply").hide();
		$("#bcReply").removeClass("required");
	}
}

function changeFileyn(value){
	checkFileType();
	if(value == 'Y'){
		$("#bcFilecount").show();
		$("#bcFilesize").show();
		$("#fileType").show();
		fn_addFileColumn();
	}else{
		$("#bcFilecount").hide();
		$("#bcFilesize").hide();
		$("#fileType").hide();
		fn_removeFileColumn();
	}
}

function changeGroupyn(value){
	if(value == 'Y'){
		$("#bcGroupynBtn").show();
	}else{
		$("#bcGroupynBtn").hide();
	}
}

function changeThumbyn(value){
	if(value == 'Y'){
		$("#bcThumbOptn").show();
		$("#bcThumbwidth").addClass('required');
		$("#bcThumbheight").addClass('required');
		fn_addThumbColumn();
	}else{
		$("#bcThumbOptn").hide();
		$("#bcThumbwidth").removeClass('required');
		$("#bcThumbheight").removeClass('required');
		fn_removeThumbColumn();
	}
}

function checkFileType() {
	var descStr = $("#fileTypeDesc").val();
	var desc = descStr.split(";");

	var tmp = undefined;
	for (var i = 0 ; i < desc.length ; i++) {
		if (desc[i] === "all" || desc[i] === "") {
			$("#fileType").find("input:checkbox").attr("checked", "checked");
			break;
		}
		tmp = $("#fileType").find("[value='"+desc[i]+"']:checkbox");
		if (tmp != undefined) {
			tmp.attr("checked", "checked");
		}
	}
}

function buildFiletypedesc(){
	var descStr = "";
	var objArr = $("#fileType").find("input:checkbox:checked");

	if (objArr.length == 0) {
		return descStr;
	}
	var value="";
	for (var i = 0; i < objArr.length ; i++) {
		value = objArr[i].value;
		if (value==="all") {
			return value;
		}

		if (descStr != "") {
			descStr += ";";
		}

		descStr += value;
	}

	return descStr;
}

/* 글 등록 function */
function fn_egov_save() {
	var frm = document.bcform;
	$("._SKINOPTION_:hidden").val("");//사용하지 않는 옵션에 대해 빈값처리
	var fileTypeDesc = "";
    if($("#bcFileyn1").is(":checked") == true) {
    	$("#bcFilecount, #bcFilesize").addClass("required");
    	fileTypeDesc = buildFiletypedesc();
    	if ("" === fileTypeDesc) {
    		alert("최소한 한가지 이상의 첨부파일 타입을 선택하셔야합니다.");
    		return false;
    	} else {
    		$("#fileTypeDesc").val(fileTypeDesc);
    	}
    }

    if($("#bcFileyn2").is(":checked") == true) {$("#bcFilecount, #bcFilesize").removeClass("required")}
    var bcThumbwidth = $("#bcThumbwidth").val();
    var bcThumbheight = $("#bcThumbheight").val();
    if($("input[name=bcThumbyn]:checked").val()=='Y'){
        if(bcThumbwidth == ""||bcThumbwidth < 10){
        	alert("썸네일 가로 사이즈는 최소 10이상이어야 합니다");
        	$("#bcThumbwidth").val('10');
        	return false;
        }
        if(bcThumbheight == ""||bcThumbheight < 10){
        	alert("썸네일 세로 사이즈는 최소 10이상이어야 합니다");
        	$("#bcThumbheight").val('10');
        	return false;
        }
    }else{
    	if(bcThumbwidth == ""){$("#bcThumbwidth").val('100')};
    	if(bcThumbheight == ""){$("#bcThumbheight").val('100')};
    }

    if(frm.bcSkin.value != "custom") $("#customColumnLowTd").html("");
   	frm.bcExtcolumninfo.value = fn_getJsonCusColumn();

	if(Validator.validate(frm)){
		<c:if test="${searchVO.act eq 'REGIST'}">
		if(!checkFlag){
			alert("게시판 아이디를 다시 입력 해 주세요.");
			return false;
		}
		</c:if>
		frm = document.bcform;
	  	frm.action = "<c:url value="${searchVO.act == 'REGIST' ? 'boardconfig_input_proc.do' : 'boardconfig_edit_proc.do'}"/>";
	    frm.submit();
	}
}

function fn_goList(){
	location.href="boardconfig_list.do?<c:out value="${searchVO.query}" escapeXml="false" />";
}

function fn_checkId(id){
	var ptrn1 = /^[^a-zA-Z]/; //false가 정상
	var ptrn2 = /[^a-zA-Z0-9._]/; //false가 정상 +
	if(id == ""){
		return false;
	}
	if(ptrn1.test(id)){
		alert("게시판 아이디는 영문(대소문)자로 시작해야 합니다.");
		return false;
	}
	if(ptrn2.test(id)){
		alert("게시판 아이디는 영문(대소문자), 숫자, ., _ 만 입력 할 수 있습니다.");
		return false;
	}
	$.ajax({
		url : "boardconfig_comm_chkId.ajax"
		, data : "id="+id
		, type : "post"
		, dataType : "json"
		, success : function(data){
			if(data.result == "0"){
				alert(data.message);//
				return false;
			}else if(data.result == "1"){
				$("#idHelp").text("사용가능한 게시판 아이디 입니다.");
				checkFlag = true;
			}else if(data.result == "2"){
				$("#idHelp").text("중복된 게시판 아이디 입니다.");
				checkFlag = false;
			}else{
				$("#idHelp").text("게시판 아이디를 다시 입력 해 주세요.");
				checkFlag = false;
			}
		}
		, error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

<c:if test="${searchVO.act == 'UPDATE' }">
function fn_goDel(){
	if(confirm("삭제하시겠습니까?")){
		var frm = document.bcform;
		frm.encoding = "application/x-www-form-urlencoded";
		frm.action = "boardconfig_delete_proc.do";
		frm.submit();
	}
}
</c:if>

function fn_getBoardconfigList(){
	$("#modalCopyContent").load("boardconfig_list_ajax.ajax", "", function(){$('#modalCopyContent').modal('show');	});
}

function fn_setSkinOption(skin){
	$("._SKINOPTION_").hide();
	$("._SKINOPTION_").removeClass("required");
	$(".for"+ skin.toUpperCase()).show();
	$(".for"+ skin.toUpperCase()).addClass("required");
	changeReplyyn($("input[name=bcReplyyn]:checked").val());
	//console.log(skin);

	if("CUSTOM" == skin.toUpperCase()){ fn_setCustomSkin();}
	else{ fn_resetCustomSkin();}
}

/************************************************ S : 커스텀스킨 ******************************************/
var columnCodeArray=["bdExt1","bdExt2","bdExt3","bdExt4","bdExt5","bdExt6","bdExt7","bdExt8","bdExt9","bdExt10","bdExt11","bdExt12"];
var $contentsColumnLowDiv = $(".customColumnLowDiv.bdContent").clone();
var $thumbColumnLowDiv = $(".customColumnLowDiv.bdThumb").clone();
var $fileColumnLowDiv = $(".customColumnLowDiv.fileId").clone();
var $customColumnLowDiv = $(".customColumnLowDiv.custom").clone();

function fn_setCustomSkin(){
	var frm = document.bcform;
	$(".customColumnLowTr").removeClass("required");
	frm.bcType.value = "2";
}

function fn_resetCustomSkin(){
	var frm = document.bcform;
	frm.bcType.value = "1";
}

function fn_initCustom(){

	<c:if test="${searchVO.act eq 'REGIST'}">
	$(".customColumnLowDiv.custom").remove();
	</c:if>
	<c:if test="${searchVO.act eq 'UPDATE'}">
	fn_setCusColumn();
	</c:if>
}

function fn_setCusColumn(){

	var frm = document.bcform;
	var columnJsonData = frm.bcExtcolumninfo.value;
	$("#customColumnLowTd").html("");

	if(columnJsonData != ""){
		var columnList = null;
		try {
			columnList = JSON.parse(columnJsonData);
			$(columnList).each(function(index){
				var $tempDiv;
				if(this.code == "bdContent"){
					$tempDiv = $contentsColumnLowDiv.clone();
				}else if(this.code == "bdThumb"){
					$tempDiv = $thumbColumnLowDiv.clone();
				}else if(this.code == "fileId"){
					$tempDiv = $fileColumnLowDiv.clone();
				}else{
					$tempDiv = $customColumnLowDiv.clone();
					//console.log(columnCodeArray.toString());
					columnCodeArray.splice(columnCodeArray.indexOf(this.code),1);
					//console.log(columnCodeArray.toString());
				}
				$tempDiv.find("input[name=columnCode]").val(this.code);
				$tempDiv.find("input[name=columnName]").val(this.name);
				$tempDiv.find("input[name=columnType]").val(this.type);
				$tempDiv.find("select[name=columnType]").val(this.type);
				$tempDiv.find("input[name=columnSize]").val(this.size);
				$tempDiv.find("input[name=defaultVal]").val(this.defaultVal);
				$tempDiv.find("input:checkbox[name=isRequired]").prop('checked', (this.required == "Y" ? true : false));
				$tempDiv.find("input:checkbox[name=isUsed]").prop('checked', (this.used == "Y" ? true : false));
				changeColumnType($tempDiv.find("select[name=columnType]"));

				<c:if test="${lockCustom eq 'Y'}">
				$tempDiv.find("select[name=columnType] option").not(":selected").remove();
				$tempDiv.find("button.delete").remove();
				</c:if>

				$("#customColumnLowTd").append($tempDiv);
			});
		} catch (error) {
			console.log("Error : \n"+error);
			if(columnList == null){
				console.log("Parse ERROR");
			} else if($("#customColumnLowTd").html() == "") {
				fn_setDefaultColumn();
				console.log(columnList);
			} else {
			}
		}
	}else{
		fn_setDefaultColumn();
	}
}

function fn_setDefaultColumn(){
	var frm = document.bcform;
	fn_addContentsColumn();
	if(frm.bcThumbyn.value == "Y")	fn_addThumbColumn();
	if(frm.bcFileyn.value == "Y") fn_addFileColumn();

}

function fn_addContentsColumn(){
	//$contentsColumnLowDiv.find("input[name=isUsed]").prop('checked', true);
	$("#customColumnLowTd").append($contentsColumnLowDiv);
}

function fn_addThumbColumn(){
	if($(".customColumnLowDiv.bdThumb").size() < 1){
		//$("#customColumnLowTd").append($thumbColumnLowDiv);
		$(".customColumnLowDiv.bdContent").after($thumbColumnLowDiv);
	}
}
function fn_removeThumbColumn(){
	$thumbColumnLowDiv = $(".customColumnLowDiv.bdThumb");
	$(".customColumnLowDiv.bdThumb").remove();
}

function fn_addFileColumn(){
	if($(".customColumnLowDiv.fileId").size() < 1){
		//$("#customColumnLowTd").append($fileColumnLowDiv);
		$(".customColumnLowDiv.bdContent").after($fileColumnLowDiv);
	}
}
function fn_removeFileColumn(){
	$fileColumnLowDiv = $(".customColumnLowDiv.fileId");
	$(".customColumnLowDiv.fileId").remove();
}

function fn_addCusColumn(){
	if($(".customColumnLowDiv.custom").size() < 12){
		$tempDiv = $customColumnLowDiv.clone();
		$tempDiv.find("input[name=columnCode]").val(columnCodeArray.shift());
		//$tempDiv.find("input[name=isUsed]").prop('checked', true);
		$("#customColumnLowTd").append($tempDiv);
		$("select[name=columnType]").change(function(){
			changeColumnType(this);
		});
	}else{
		alert("기본컬럼을 제외한 커스텀컬럼 추가는 최대 12개까지 가능합니다.");
		return false;
	}
}

function fn_requiredCusColumn(obj){
	var columnCode = $(obj).parent().parent().find("input[name=columnCode]").val();
	if(columnCode == "bdContent"){
		alert("내용(기본) 컬럼은 필수항목입니다. 변경할 수 없습니다.");
		obj.checked = true;
		return false;
	}
}

function fn_useCusColumn(obj){
	var columnCode = $(obj).parent().parent().find("input[name=columnCode]").val();
	if(columnCode == "bdContent"){
		alert("내용(기본) 컬럼은 필수항목입니다.");
		obj.checked = true;
		return false;
	}else if(columnCode == "bdThumb"){
		alert("썸네일(기본) 컬럼을 사용하지 않으시려면,\n위의 기능설정 중 썸네일을 미사용으로 선택해 주세요.");
		obj.checked = true;
		return false;
	}else if(columnCode == "fileId"){
		alert("첨부파일(기본) 컬럼을 사용하지 않으시려면,\n위의 기능설정 중 첨부파일 기능을 미사용으로 선택해 주세요.");
		obj.checked = true;
		return false;
	}else{
		if(!obj.checked && !confirm("'사용'을 체크해제 하면, 더 이상 게시판에 노출이 되지 않습니다. 계속 하시겠습니까?")){
			obj.checked = true;
			return false;
		}
	}
}

function fn_delCusColumn(obj){
	var columnCode = $(obj).parent().parent().find("input[name=columnCode]").val();
	if(columnCode == "bdContent"){
		alert("내용(기본) 컬럼은 삭제할 수 없습니다.");
		return false;
	}else if(columnCode == "bdThumb"){
		alert("썸네일(기본) 컬럼은 삭제할 수 없습니다.\n제거를 원하시면, 위의 기능설정 중 썸네일을 미사용으로 선택해 주세요.");
		return false;
	}else if(columnCode == "fileId"){
		alert("첨부파일(기본) 컬럼은 삭제할 수 없습니다.\n제거를 원하시면, 위의 기능설정 중 첨부파일 기능을 미사용으로 선택해 주세요.");
		return false;
	}
	$(obj).parent().parent().remove();
	columnCodeArray.unshift(columnCode);
	columnCodeArray.sort(function(a, b) {
		return parseInt(a.replace("bdExt","")) - parseInt(b.replace("bdExt",""));
	});
}

function fn_upCusColumn(obj){
	var selIndex = $(".customColumnLowDiv").index($(obj).parent().parent());
	if(0 == selIndex){
		alert("더 이상 위로 올라갈 수 없습니다.");
		return false;
	}

	var tempEle = $(".customColumnLowDiv:eq("+(selIndex-1)+")");
	$($(obj).parent().parent()).after(tempEle);
}

function fn_downCusColumn(obj){
	var selIndex = $(".customColumnLowDiv").index($(obj).parent().parent());
	if( ($(".customColumnLowDiv").length-1) == selIndex){
		alert("더 이상 아래로 내려갈 수 없습니다.");
		return false;
	}
	var tempEle = $(".customColumnLowDiv:eq("+(selIndex+1)+")");
	$($(obj).parent().parent()).before(tempEle);
}

function fn_getJsonCusColumn(){
	var columnList = new Array();

	$(".customColumnLowDiv").each(function(index){
		var columnInfo = new Object();
		columnInfo.code = $(this).find("input[name=columnCode]").val();
		columnInfo.name = $(this).find("input[name=columnName]").val();
		columnInfo.type = $(this).find((columnInfo.code.startsWith("bdExt") ?"select":"input")+"[name=columnType]").val();
		columnInfo.size = $(this).find("input[name=columnSize]").val() == "" ? "0" : $(this).find("input[name=columnSize]").val();
		columnInfo.defaultVal = $(this).find("input[name=defaultVal]").val();
		columnInfo.required = ($(this).find("input[name=isRequired]").is(":checked")?"Y":"N");
		columnInfo.used = ($(this).find("input[name=isUsed]").is(":checked")?"Y":"N");
		columnList.push(columnInfo);
	});

	if(columnList.length > 0){
		return JSON.stringify(columnList);
	}else{
		return "";
	}
}

function changeColumnType(obj){
	var type = $(obj).find("option:selected").attr("data-type");
	if(type == "number"){
		$(obj).parent().parent().find("input[name=columnSize]").removeClass("validate-digits_4000");
		$(obj).parent().parent().find("input[name=columnSize]").addClass("validate-digits");
		$(obj).parent().parent().find("input[name=columnSize]").attr("maxlength","6");
		$(obj).parent().parent().find("input[name=defaultVal]").addClass("validate-digits");
		$(obj).parent().parent().find("input[name=defaultVal]").attr("maxlength","6");
		$(obj).parent().parent().find(".size label").text("최대값");
		if($(obj).parent().parent().find("input[name=columnSize]").val() == "") $(obj).parent().parent().find("input[name=columnSize]").val("0");
	}else if(type == "editor"){
		$(obj).parent().parent().find("input[name=columnSize]").removeClass("validate-digits_4000");
		$(obj).parent().parent().find("input[name=columnSize]").addClass("validate-digits");
		$(obj).parent().parent().find("input[name=columnSize]").attr("maxlength","5");
		$(obj).parent().parent().find("input[name=defaultVal]").removeClass("validate-digits");
		$(obj).parent().parent().find("input[name=defaultVal]").removeAttr("maxlength");
		$(obj).parent().parent().find(".size label").text("컬럼길이");
	}else{
		$(obj).parent().parent().find("input[name=columnSize]").removeClass("validate-digits");
		$(obj).parent().parent().find("input[name=columnSize]").addClass("validate-digits_4000");
		$(obj).parent().parent().find("input[name=columnSize]").attr("maxlength","4");
		$(obj).parent().parent().find("input[name=defaultVal]").removeClass("validate-digits");
		$(obj).parent().parent().find("input[name=defaultVal]").removeAttr("maxlength");
		$(obj).parent().parent().find(".size label").text("컬럼길이");
	}
}

/************************************************ E : 커스텀스킨 ******************************************/

//]]>
</script>

<c:if test="${searchVO.act == 'UPDATE' }">
<script type="text/javascript">
//<![CDATA[

/************************************************ 카테고리 ******************************************/
function fn_openCate(){
	initTree();
	//fnObj.modalOpenCategory();
	$('#modalCategoryContent').modal('show');
}

/**************************** 트리  ***********************************/
 var setting = {
			view: {
				selectedMulti: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onClick : onClick
				,beforeRename: fn_updateProc

			}
		};

	function refreshNode() {
		nodes = zTree.getSelectedNodes();

		initTree();

		if (nodes.length != 0) {
			zTree.selectNode(nodes[0]);

		}
	}

	var expandFlag = false;
	function expandAll(){
		expandFlag = !expandFlag
		zTree.expandAll(expandFlag);
		if(expandFlag){
			$("#expandAllBtn").text("모두닫기")
		}else{
			$("#expandAllBtn").text("모두열기")
		}
	}
	function onClick(e,treeId, treeNode) {
		zTree.expandNode(treeNode); // 노드 오픈
	}

	var zTree;

	var zNodes = [];
	function initTree(){
		zNodes = [];
		$.ajax({
			url:"/commons/code/code_comm_list.ajax",
			data : "useType=board&schCode=_<c:out value="${result.bcId}" />",
			dataType : "json",
			async : false,
			success : function(data){
				zNodes = data;
				$.fn.zTree.init($("#zTree"), setting, zNodes);
				zTree = $.fn.zTree.getZTreeObj("zTree");
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}

	function fn_addCode(){
		/* nodes = zTree.getSelectedNodes();
		if(nodes.length == 0){
			alert("카테고리를 선택 해 주세요.");
			return false;
		} */
		var cpcode = "_<c:out value="${result.bcId}" />";//nodes[0].id;
		var cname = $("#cname").val();
		if(cname == ""){
			alert("카테고리명을 입력 해 주세요.");
			return false;
		}
		document.cateForm.cpidx.value = "<c:out value="${categoryInfo.cidx}" />";
		document.cateForm.cpcode.value = cpcode;
		document.cateForm.cname.value = cname;
		$.ajax({
			url:"/_mngr_/boardconfig/boardconfig_input_category.ajax",
			data:$("#cateForm").serialize(),
			type:"post",
			dataType:"json",
			success : function(data){
				if(data.result == "0"){
					alert("알수없는 오류가 발생했습니다. 다시 시도해 주세요.");
					return false;
				}else if(data.result == "1"){
					alert("카테고리가 추가되었습니다.");
					initTree();
					$("#cname").val("");
					return false;
				}else if(data.result == "2"){
					alert("게시판 아이디정보가 없습니다. 다시 시도해 주세요.");
					return false;
				}else if(data.result == "3"){
					alert("선택한 카테고리 정보가 없습니다. 다시 시도해 주세요.");
					return false;
				}else if(data.result == "4"){
					alert("카테고리명 정보가 없습니다. 다시 시도해 주세요.");
					return false;
				}
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	function fn_update(){
		nodes = zTree.getSelectedNodes();
		if(nodes.length == 0){
			alert("카테고리를 선택 해 주세요.");
			return false;
		}
		if(nodes[0].depth < 3){
			alert("수정 할 수 없는 카테고리 입니다.");
			return false;
		}
		var schCode = nodes[0].id;
		zTree.editName(nodes[0])
	}

	function fn_updateProc(treeId, treeNode, newName) {
		if(!confirm("카테고리명을 수정하시겠습니까?")){
			return true;;
		}
		if (newName.length == 0) {
			alert("카테고리명을 입력 해 주세요.");
			setTimeout(function(){zTree.editName(treeNode)}, 10);
			return false;
		}
		if(newName.length > 50){
			alert("카테고리명은 50자 이내로 입력 해 주세요.");
			setTimeout(function(){zTree.editName(treeNode)}, 10);
			return false;
		}
		document.cateForm.act.value = "UPDATE";
		document.cateForm.schCode.value = treeNode.id;
		document.cateForm.cname.value = newName;
		$.ajax({
			url : "/_mngr_/code/code_edit_proc.ajax"
			, type : "post"
			, data :  $("#cateForm").serialize()
			, dataType : "json"
			, success : function(data){
				if(data.result == 0){
					alert(data.message); //alert("데이터 저장 중 오류가 발생했습니다. 다시 시도해 주세요");
					return false;
				}else if(data.result == 1){
					alert("저장 되었습니다.");
				}else if(data.result == 2){
					alert(data.message); //alert("코드가 중복 되었습니다. 확인 후 다시 시도해 주세요");
					return false;
				}
			}
		});
	}

	function fn_delete(){
		nodes = zTree.getSelectedNodes();
		if(nodes.length == 0){
			alert("카테고리를 선택 해 주세요.");
			return false;
		}
		if(nodes[0].depth < 3){
			alert("삭제 할 수 없는 카테고리 입니다.");
			return false;
		}
		var schCode = nodes[0].id;
		if(confirm("카테고리를 삭제하시겠습니까?")){
			$.ajax({
				url : "/_mngr_/code/code_delete_proc.ajax"
				, data : "schCode="+ schCode
				, dataType : "json"
				, type : "post"
				, success : function(data){
					if(data.result == 0){
						alert("삭제 중 오류가 발생했습니다. 다시 시도해 주세요");
						return false;
					}else if(data.result == 1){
						alert("삭제가 완료 되었습니다.");
						initTree();
						zTree.cancelSelectedNode();
					}else if(data.result == 2){
						alert("카테고리에 포함된 하위카테고리가 있어서 삭제 할 수 없습니다.\n하위카테고리를 먼저 삭제 해 주세요.");
						return false;
					}
				}
				, error:function(request,status,error){
		   		   alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		}
	}

	function fn_checkKrEnNo(obj) {
        var deny_pattern = /[^(ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9)]/;
        //var deny_pattern = /[^(0-9)]/;  //숫자만 허용 하고 싶을때
		var inText = obj.value;
        if(deny_pattern.test(inText)){
			alert("카테고리명은 영문자와 한글, 숫자 만 허용됩니다.");
			obj.value = inText.substr(0, inText.length-1);
			obj.focus();
	       	return false;
        }
        return true;
	}
	/**************************** 트리  ***********************************/
//]]>
</script>
<div class="modal mngrAuthorityMainModal" id="modalCategoryContent"><%-- 카테고리관리 레이어 팝업 --%>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">카테고리관리</h4>
			</div>
			<div class="modal-body">
				<div id="categoryList" class="categoryList">
					<div class="form-inline" style="margin-bottom:10px;">
						<strong>카테고리명</strong> : <input name="cname" id="cname" class="form-control input-sm f-wd-200" title="카테고리명"  maxlength="15" onkeyup="fn_checkKrEnNo(this);" onkeydown="if(ItgJs.fn_isEnter(event)) fn_addCode();" />
						<button type="button" class="btn btn-primary btn-sm"  onclick="fn_addCode();" style="margin-right:10px;">등록</button> (영문,숫자,한글만 허용 15자 이내)
					</div>
					<div style="padding:10px 20px;">
						<div id="AXTreeTarget" style="width:100%;border:1px solid #cbcbcb;overflow-y:auto;height:200px;">
							<div id="zTree" class="ztree" style="margin:10px;overflow-y:unset;height:initial;"></div>
						</div>
					</div>
					<div id="managerListMoreBtn" style="clear:both; text-align:center;padding:5px;">
						<button type="button" class="btn btn-primary btn-sm" onclick="fn_update();">이름변경</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="fn_delete();">삭제</button>
					</div>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<form name="cateForm" id="cateForm" method="post" >
	<input type="hidden" name="cpidx" />
	<input type="hidden" name="cpcode" />
	<input type="hidden" name="act" />
	<input type="hidden" name="schCode" />
	<input type="hidden" name="cname" />
</form>
</c:if>
<div class="modal" id="modalCopyContent"></div><!-- /.modal -->