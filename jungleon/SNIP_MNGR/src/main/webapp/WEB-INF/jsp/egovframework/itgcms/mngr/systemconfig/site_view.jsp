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
 * @파일명 : site_view.jsp
 * @파일정보 : 시스템 환경설정
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2016. 3. 18. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<div class="row">
	<div class="col-md-12">
		<div class="box">
		<c:if test="${mngrSessionVO.currSiteCode == 'SYSTEM'}">
		<div class="box-header with-border">
				<div class="row">
					<div class="col-md-6 form-group">
						<select class="form-control select2" style="width: 100%;" name="schSiteCode" id="schSiteCode" onChange="fn_changeSite();">
						<c:forEach var="result" items="${siteList}" varStatus="status">
							<option ${ufn:selected(result.siteCode, mngrSiteVO.siteCode)} value="${result.siteCode}">${result.siteName}</option>
						</c:forEach>
						</select>
					</div>
				</div>
			</div>
			</c:if>
			<!-- <div class="box-header with-border"><h3 class="box-title">Title</h3></div> -->
			<div class="box-body">
				<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;" enctype="multipart/form-data">
				<input type="hidden" name="siteCode" value="${mngrSiteVO.siteCode}">
				<input type="hidden" name="sysName" value="${mngrSiteVO.siteName}">
				<input type="hidden" name="isEdit" value="0">
				<div class="row">
					<div class="col-xs-12 table-responsive">
		                <h4 class="box-title">기본설정</h4>
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:75%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="siteName">사이트명</label></th>
									<td>
							        	<div id="siteName" class="form-group" style="margin-bottom:0px">
							            		${mngrSiteVO.siteName}
							            </div>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="siteCode">사이트코드</label></th>
									<td>
							        	<div id="siteCode" class="form-group" style="margin-bottom:0px">
							            		${mngrSiteVO.siteCode}
							            </div>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="tempCode">템플릿선택</label></th>
									<td>
										<div id="tempCode" class="form-group" style="margin-bottom:0px">
										<c:forEach var="temp" items="${templeteList}" varStatus="status">
					                  		<label style="margin-right:20px">
												<input type="radio" name="tempCode" class="minimal" value="${temp.tempCode}" ${ufn:checked(siteconfigVO.tempCode, temp.tempCode) }> ${temp.tempName}
											</label>
										</c:forEach>
										</div>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="titleName">웹타이틀명</label></th>
									<td>
							        	<div id="titleName" class="form-group" style="margin-bottom:0px">
								        	<label style="margin-right:20px"">
						                    	<input type="radio" name="titleNameCode" class="minimal" value="1" ${ufn:checked(siteconfigVO.titleNameCode, '1') }> 현재위치
						                    </label>
						                    <label style="margin-right:10px">
						                        <input type="radio" name="titleNameCode" class="minimal" value="2" ${ufn:checked(siteconfigVO.titleNameCode, '2') }> 직접입력
						                    </label>
						                    <input type="text" style="display:inline-block" name="titleName" maxlength="20" class="required form-control input-sm f-wd-300" value="${siteconfigVO.titleName}">
							            </div>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="faviUrl">Favicon경로</label></th>
									<td>
							        	<div id="faviUrl" class="form-group" style="margin-bottom:0px">
							            	<input type="text" name="faviUrl" maxlength="60" class="required form-control input-sm f-wd-400" value="${siteconfigVO.faviUrl}">
							            </div>
							            <span class="help-block">Favicon은 실제 'icon'파일의 경로를 입력하셔야 등록됩니다
										</span>
<%-- 										            <div id="faviUrl" class="form-group" style="margin-bottom:0px">
											        	<label style="margin-right:20px">
									                    	<input type="radio" name="faviUrlgubun" id="faviUrlgubun1" class="minimal" value='1' onclick="setFaviUrlgubun('1');" ${ufn:checked('1',siteconfigVO.faviUrlgubun) } ${ufn:checked('',siteconfigVO.faviUrlgubun) }/><label for="faviUrlgubun1">URL 지정</label>
									                    </label>
									                    <label style="margin-right:10px">
									                        <input type="radio" name="faviUrlgubun" id="faviUrlgubun2" class="minimal" value='2' onclick="setFaviUrlgubun('2');" ${ufn:checked('2',siteconfigVO.faviUrlgubun) } /><label for="faviUrlgubun2">이미지등록</label>
														</label>
									                </div>

													<span class="help-block">템플릿별로 로고의 권장사이즈가 다를 수 있습니다. 템플릿 권장 사이즈와 다를경우 로고 이미지가 왜곡되어 보일 수 있습니다.<br/>
														로고이미지가 등록되지 않을경우 사이트명이 표시 됩니다.
													</span>
													<input  type="file" name="siteLogo" id="siteLogo" class="siteLogo validate-is-image" title="이미지 첨부"/><input type="hidden" name="oldsiteLogo" id="oldsiteLogo" value="<c:out value="${siteconfigVO.siteLogo }" />" />
				                                	<c:if test="${not empty siteconfigVO.siteLogo }">
				                                    	첨부 이미지 :   <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','system',siteconfigVO.siteLogo,siteconfigVO.siteLogo) }" />" ><c:out value="${siteconfigVO.siteLogo }" /></a>
				                                    	<p style="display: block;max-width: 300px;margin-top: 10px;"><img style="max-width: 100%;" src="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','system',siteconfigVO.siteLogo,siteconfigVO.siteLogo) }" />" alt="<c:out value="${siteconfigVO.siteLogo}" />" /></p>
				                                  	</c:if> --%>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="siteLogo">점검중페이지</label></th>
									<td>
										<div id="titleName" class="form-group" style="margin-bottom:0px">
								        	<label style="margin-right:20px">
						                    	<input type="radio" name="underConstr" id="underConstr1" class="minimal" value='1' ${ufn:checked('1',siteconfigVO.underConstr) } ${ufn:checked('',siteconfigVO.underConstr) }/><label for="underConstr1">사용</label>
						                    </label>
						                    <label style="margin-right:10px">
						                        <input type="radio" name="underConstr" id="underConstr2" class="minimal" value='2' ${ufn:checked('2',siteconfigVO.underConstr) } /><label for="underConstr2">미사용</label>
											</label>
						                </div>
										<span class="help-block">점검중페이지를 사용으로 하실경우, 메인 URL로 접근하는 사용자에 한해 점검중 페이지로 이동됩니다.
										</span>
										<input  type="file" name="underConstrImg" id="underConstrImg" class="underConstrImg f-wd-400 validate-is-image" title="이미지 첨부"/><input type="hidden" name="oldUnderConstrImg" id="oldUnderConstrImg" value="<c:out value="${siteconfigVO.underConstrImg }" />" />
	                                	<c:if test="${not empty siteconfigVO.underConstrImg }">
	                                    	첨부 이미지 :   <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','system',siteconfigVO.underConstrImg,siteconfigVO.underConstrImg) }" />" ><c:out value="${siteconfigVO.underConstrImg }" /></a>
	                                    	<br />
	                                    	<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','system',siteconfigVO.underConstrImg,siteconfigVO.underConstrImg) }" />" alt="<c:out value="${siteconfigVO.underConstrImg}" />" style="max-width:500px;max-height:300px;"/>
	                                  	</c:if>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="siteLogo">로고설정</label></th>
									<td>
										<div id="titleName" class="form-group" style="margin-bottom:0px">
								        	<label style="margin-right:20px">
						                    	<input type="radio" name="siteLogogubun" id="siteLogogubun1" class="minimal" value='1' onclick="setSiteLogogubun('1');" ${ufn:checked('1',siteconfigVO.siteLogogubun) } ${ufn:checked('',siteconfigVO.siteLogogubun) }/><label for="siteLogogubun1">사이트명사용</label>
						                    </label>
						                    <label style="margin-right:10px">
						                        <input type="radio" name="siteLogogubun" id="siteLogogubun2" class="minimal" value='2' onclick="setSiteLogogubun('2');" ${ufn:checked('2',siteconfigVO.siteLogogubun) } /><label for="siteLogogubun2">이미지사용</label>
											</label>
						                </div>
										<span class="help-block">템플릿별로 로고의 권장사이즈가 다를 수 있습니다. 템플릿 권장 사이즈와 다를경우 로고 이미지가 왜곡되어 보일 수 있습니다.<br/>
											로고이미지가 등록되지 않을경우 사이트명이 표시 됩니다. 권장 사이즈(230*58px)
										</span>
										<input  type="file" name="siteLogo" id="siteLogo" class="siteLogo validate-is-image" title="이미지 첨부"/><input type="hidden" name="oldsiteLogo" id="oldsiteLogo" value="<c:out value="${siteconfigVO.siteLogo }" />" />
	                                	<c:if test="${not empty siteconfigVO.siteLogo }">
	                                    	첨부 이미지 :   <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','system',siteconfigVO.siteLogo,siteconfigVO.siteLogo) }" />" ><c:out value="${siteconfigVO.siteLogo }" /></a>
	                                    	<br />
	                                    	<img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','system',siteconfigVO.siteLogo,siteconfigVO.siteLogo) }" />" alt="<c:out value="${siteconfigVO.siteLogo}" />"  style="max-width:500px;max-height:300px;"/>
	                                  	</c:if>
									</td>
								</tr>
								<tr>
									<th class="t"><span>회원 독립 사용</span></th>
									<td>
										<label style="margin-right:20px"><input class="minimal" type="radio" name="memIndependent" value="true" <c:out value="${siteconfigVO.memIndependent ? 'checked' : ''}"/>/> 예</label>
										<label style="margin-right:10px"><input class="minimal" type="radio" name="memIndependent" value="false" <c:out value="${siteconfigVO.memIndependent ? '' : 'checked'}"/>/> 아니오</label>
									</td>
								</tr>
								<tr>
									<th class="t"><span>기본페이지타입</span></th>
									<td>
										<label style="margin-right:20px"><input class="minimal" type="radio" name="sitePageType" value="0" ${ufn:checked(siteconfigVO.sitePageType, '0')} ${ufn:checked(siteconfigVO.sitePageType, '')}/> BOX형</label>
										<label style="margin-right:10px"><input class="minimal" type="radio" name="sitePageType" value="1" ${ufn:checked(siteconfigVO.sitePageType, '1') }/> WIDE형</label>
									</td>
								</tr>
							</tbody>
						</table>
						<h4 class="box-title">헤더 설정</h4>
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:75%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="totalSearch">통합검색</label></th>
									<td>
										<select name="totalSearch" id="totalSearch" class="form-control input-sm f-wd-200" title="통합검색">
							        		<option value="0" ${ufn:selected(siteconfigVO.totalSearch, '0') }>미사용</option>
							        		<option value="all" ${ufn:selected(siteconfigVO.totalSearch, 'all') }>전체 검색</option>
							        		<option value="onlyMe" ${ufn:selected(siteconfigVO.totalSearch, 'onlyMe') }>${mngrSiteVO.siteName}만 검색</option>
							        	</select>
									</td>
								</tr>
<%-- 								<tr>
									<th class="t"><label for="toHomeUseYn">홈으로</label></th>
									<td>
									<label style="margin-right:20px;">
				                    	<input type="radio" name="toHomeUseYn" class="minimal" value="Y" ${ufn:checked(siteconfigVO.toHomeUseYn, 'Y') }> 사용
				                    </label>
				                    <label>
				                    	<input type="radio" name="toHomeUseYn" class="minimal" value="N" ${ufn:checked(siteconfigVO.toHomeUseYn, 'N') }> 미사용
				                    </label>
				                    </td>
								</tr> --%>
								<tr>
									<th class="t"><label for="siteMapUseYn">사이트맵</label></th>
									<td>
									<label style="margin-right:20px;">
				                    	<input type="radio" name="siteMapUseYn" class="minimal" value="Y" ${ufn:checked(siteconfigVO.siteMapUseYn, 'Y') }> 사용
				                    </label>
				                    <label>
				                    	<input type="radio" name="siteMapUseYn" class="minimal" value="N" ${ufn:checked(siteconfigVO.siteMapUseYn, 'N') }> 미사용
				                    </label>
				                    </td>
								</tr>
								<tr>
									<th class="t"><label for="userLoginUseYn">로그인</label></th>
									<td>
									<label style="margin-right:20px;">
				                    	<input type="radio" name="userLoginUseYn" class="minimal" value="Y" ${ufn:checked(siteconfigVO.userLoginUseYn, 'Y') }> 사용
				                    </label>
				                    <label>
				                    	<input type="radio" name="userLoginUseYn" class="minimal" value="N" ${ufn:checked(siteconfigVO.userLoginUseYn, 'N') }> 미사용
				                    </label>
				                    </td>
								</tr>
								<tr>
									<th class="t"><label for="joinUseYn">회원가입</label></th>
									<td>
									<label style="margin-right:20px;">
				                    	<input type="radio" name="joinUseYn" class="minimal" value="Y" ${ufn:checked(siteconfigVO.joinUseYn, 'Y') }> 사용
				                    </label>
				                    <label>
				                    	<input type="radio" name="joinUseYn" class="minimal" value="N" ${ufn:checked(siteconfigVO.joinUseYn, 'N') }> 미사용
				                    </label>
				                    </td>
								</tr>
							</tbody>
						</table>
						<h4 class="box-title">메인페이지 설정</h4>
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:75%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="slides">메인슬라이드</label></th>
									<td>
							        	<div id="slides" class="form-group" style="margin-bottom:0px">
											<select name="slidesIdx" id="slidesIdx" class="form-control input-sm f-wd-200" title="슬라이드 선택" onchange="fn_setSlides(this.value)" >
								        		<option value="0">슬라이드 선택</option>
								        		<c:forEach var="list" items="${slidesList }">
								        			<option value="<c:out value="${list.slidesIdx}"/>" ${ufn:selected(siteconfigVO.slidesIdx, list.slidesIdx) }><c:out value="${list.slidesName }" /></option>
								        		</c:forEach>
								        	</select>
							            </div>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="mainPageBoard">메인페이지 게시판</label></th>
									<td id="mainPageBoard"></td>
								</tr>
							</tbody>
						</table>
						<%-- <h4 class="box-title">SNS 페이지 공유 설정</h4>
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:75%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="slides">SNS 설정</label></th>
									<td>
									<c:forEach var="smkeyList" items="${smkeyList}" varStatus="i">
										<label>
											<input type="checkbox" name="userSnsShareYn" class="minimal" value="${smkeyList.smName}"
											<c:if test="${ufn:strInArrChk(siteconfigVO.userSnsShareYn, smkeyList.smName)}">checked</c:if>>&nbsp;&nbsp;${smkeyList.smName} &nbsp;&nbsp;
										</label>
									</c:forEach>
									</td>
								</tr>
							</tbody>
						</table> --%>
					</div><!-- /.col -->
				</div><!-- /row -->
				<div class="box-footer">
               		<div class="pull-right">
						<button  type="submit" value="" class="btn btn-primary">저장</button>
               		</div>
               	</div>
				</form>
			</div> <!-- /box-body -->
		</div> <!-- /box -->
	</div> <!-- /col -->
</div> <!-- /row -->

<%--       <%@ include file="../../global/module/socialmedia/connectScript.jsp" %> --%>

<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	setSiteLogogubun("${siteconfigVO.siteLogogubun}");
});

/* 글 등록 function */
function fn_egov_save() {
	frm = document.form1;

	if($("#oldsiteLogo").val() != null && $("#oldsiteLogo").val() != ""){
		$("#siteLogo").removeClass("required");
	}

	if(Validator.validate(frm)){
	  	frm.action = "site_edit_proc.do";
	    frm.submit();
	}
}

/* 글 등록 function */
function fn_change_tab(siteCode) {
	frm = document.form1;

	$("#siteLogo").removeClass("required");

	if(frm.isEdit.value == "1"){
		if(confirm('탭 이동 시 저장되지 않은 정보는 사라집니다.\n계속 하시겠습니까?')){
			frm.siteCode.value = siteCode;
			if(Validator.validate(frm)){
			  	frm.action = "?";
			    frm.submit();
			}
		}
	} else {
		frm.siteCode.value = siteCode;
		if(Validator.validate(frm)){
		  	frm.action = "?";
		    frm.submit();
		}
	}
	return false;
}

function fn_mainPageBoardAjax(siteCode, tempCode) {
	$.ajax({
		url : "/_mngr_/mainboard_comm_check.ajax",
		type : "post" ,
		data : {
			siteCode : siteCode,
			templCode : tempCode
		}, success : function(result){
			var mainPageboard = $("#mainPageBoard").empty();
			var html = "";
			for (var x =0; x < result.boardNum; x++){
				html += "<select class=\"form-control\" style=\"display:inline-block; width : 200px;\" name=\"mainPageBoard\" id=\"board_"+x+"\">";
				for (var y=0; y < result.menuDesc.length;y++) {
					html += "<option id=\""+result.menuDesc[y].menuCode+x+"_op\" value=\""+result.menuDesc[y].menuCode+"\">"+result.menuDesc[y].menuName+"</option>";
				}
				html += "</select>&nbsp;&nbsp;<input name=\"mainPageBoardLimit\" type=\"number\" value=\"5\" style=\"width:40px;\"/>&nbsp;개<br/>";
			}
			mainPageboard.append($(html));

			if (result.selectedMenu != null) {
				var descSplit;
				for (var i = 0; i < result.selectedMenu.length; i++) {
					dsecSplit = result.selectedMenu[i].split("/");
					$("#"+dsecSplit[0]+i+"_op").attr("selected", "selected").parent().next().val(dsecSplit[1]);
				}
			}

		}, error:function(request,status,error){
	   		   alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    }
	});
}

fn_mainPageBoardAjax('${mngrSiteVO.siteCode}', '${siteconfigVO.tempCode}');

//라디오버튼 값 변경 체크
/* $('input').on('ifChanged', function(event){
	frm = document.form1;
	frm.isEdit.value = "1";
}); */

$('input[type="radio"]').on('ifChanged', function(event){

	frm = document.form1;
	frm.isEdit.value = "1";
	var opt = $(this).attr('name');
	if(opt == "siteLogogubun"){
		setSiteLogogubun($(this).val());
	}else if(opt == "tempCode"){
		var siteCode = $("#siteCode").html().trim();
		var tempCode = $(this).val();
		fn_mainPageBoardAjax(siteCode, tempCode);
	}else{

	}
});

//텍스트박스 값 변경 체크
$('input').change(function(event){
	frm = document.form1;
	frm.isEdit.value = "1";
});

/* 링크 구분 세팅 function */
function setSiteLogogubun(gubun) {
	if(gubun == '1'){
		$("input.siteLogo").removeClass("required");
	}else if(gubun == '2'){
		$("input.siteLogo").addClass("required");
	}
}

function fn_changeSite(){
	var frm = document.form1;
	frm.siteCode.value=$("#schSiteCode").val();
	frm.action = "?";
	frm.submit();
}

//]]>
</script>
