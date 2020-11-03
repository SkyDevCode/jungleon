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
 * @파일명 : basic_view.jsp
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
			<div class="box-body">
				<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;" enctype="multipart/form-data">
				<div class="row">
					<div class="col-xs-12 table-responsive">
						<table id="systemConfig" class="table table-bordered tp2">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:75%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="sysName">시스템명</label></th>
									<td>
							        	<div id="sysName" class="form-group" style="margin-bottom:0px">
							            	<input type="text" name="sysName" maxlength="20" class="required form-control input-sm f-wd-300" value="${systemconfigVO.sysName}">
							            </div>
									</td>
								</tr>
								<tr>
									<th class="t"><label>관리자중복로그인</label></th>
									<td>
										<input class="minimal required" type="radio" name="mngrMultilogin" value="Y" ${ufn:checked(systemconfigVO.mngrMultilogin, 'Y')}/><label>허용</label>
										<input class="minimal required" type="radio" name="mngrMultilogin" value="N" ${ufn:checked(systemconfigVO.mngrMultilogin, 'N')}/><label>방지</label>
									</td>
								</tr>
								<c:if test="${mngrSessionVO.licenseType == 'M' }">
								<tr>
									<th class="t"><label for="siteGubun">사이트구분 방식</label></th>
									<td>
										<input type="radio" class="minimal" name="siteGubun" id="siteGubun1" value='1' ${ufn:checked('1',systemconfigVO.siteGubun) } ${ufn:checked('',systemconfigVO.siteGubun) } /><label for="siteGubun1">서브디렉토리방식</label>&nbsp;&nbsp;&nbsp;
										<input type="radio" class="minimal" name="siteGubun" id="siteGubun2" value='2' ${ufn:checked('2',systemconfigVO.siteGubun) } /><label for="siteGubun2">서브도메인방식</label>
							            <p style="margin-bottom:0;">
							            <span class="help-block" style="margin-bottom:0;">서브도메인방식 사용 시 주의사항.<br/>
							            	1. 사이트코드와 서브도메인주소는 동일하게 설정되어야 합니다. <br/>
							            	예) 사이트코드가 "cms" 이고 대표도메인주소가 "itgood.co.kr" 일 경우, 서브도메인 주소는 "cms.itgood.co.kr"<br/>
							            	2. 설정이 올바르지 않을 경우 사이트 표출이 정상적이지 않을 수 있습니다. <br/>  </span>
										</p>
									</td>
								</tr>
								<tr id="domainAddr" >
									<th class="t"><label for="domainAddr">대표도메인주소</label></th>
									<td>
							            <input type="text" name="domainAddr" maxlength="30" class="required form-control input-sm f-wd-300" value="${ufn:isNull(systemconfigVO.domainAddr, 'localhost')}">
							            <span class="help-block" style="margin-bottom:0;">최상위도메인을 입력해주세요. 예) www.itgood.co.kr 일 경우, itgood.co.kr 을 입력.</span>
									</td>
								</tr>
								<tr id="defaultSite" >
									<th class="t"><label for="defaultSite">기본사이트</label></th>
									<td>
							            <select name="defaultSite" title="기본사이트 선택" class="required form-control input-sm f-wd-200">
											<c:forEach var="site" items="${siteList }">
												<option value="<c:out value="${site.siteCode }" />" ${ufn:selected(site.siteCode, systemconfigVO.defaultSite) }><c:out value="${site.siteName }" /></option>
											</c:forEach>
										</select>
							            <span class="help-block" style="margin-bottom:0;">사용자 접속 시 기본으로 표출될 사이트를 선택해 주세요.</span>
									</td>
								</tr>
								</c:if>

								<%-- <tr>
									<th class="t"><label for="siteLogo">점검중페이지</label></th>
									<td>
										<div id="titleName" class="form-group" style="margin-bottom:0px">
								        	<label style="margin-right:20px">
						                    	<input type="radio" name="underConstr" id="underConstr1" class="minimal" value='1' ${ufn:checked('1',systemconfigVO.underConstr) } ${ufn:checked('',systemconfigVO.underConstr) }/><label for="underConstr1">사용</label>
						                    </label>
						                    <label style="margin-right:10px">
						                        <input type="radio" name="underConstr" id="underConstr2" class="minimal" value='2' ${ufn:checked('2',systemconfigVO.underConstr) } /><label for="underConstr2">미사용</label>
											</label>
						                </div>

										<span class="help-block">점검중페이지를 사용으로 하실경우, 메인 URL로 접근하는 사용자에 한해 점검중 페이지로 이동됩니다.
										</span>
										<input  type="file" name="underConstrImg" id="underConstrImg" class="underConstrImg f-wd-400 validate-is-image" title="이미지 첨부"/><input type="hidden" name="oldUnderConstrImg" id="oldUnderConstrImg" value="<c:out value="${systemconfigVO.underConstrImg }" />" />
				                             	<c:if test="${not empty systemconfigVO.underConstrImg }">
				                                 	첨부 이미지 :   <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','system',systemconfigVO.underConstrImg,systemconfigVO.underConstrImg) }" />" ><c:out value="${systemconfigVO.underConstrImg }" /></a>
				                                 	<p style="display: inline-block;"><img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','system',systemconfigVO.underConstrImg,systemconfigVO.underConstrImg) }" />" alt="<c:out value="${systemconfigVO.underConstrImg}" />" /></p>
				                               	</c:if>
									</td>
								</tr> --%>
							</tbody>
						</table>
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
<script type="text/javascript">
//<[[!CDATA[
/* 등록 function */
function fn_egov_save() {
	frm = document.form1;

	if($("#oldUnderConstrImg").val() != null && $("#oldUnderConstrImg").val() != ""){
		$("#underConstrImg").removeClass("required");
	}

	if(Validator.validate(frm)){
	  	frm.action = "basic_edit_proc.do";
	    frm.submit();
	}
}

//domainAddr outerHtml 가져오기
var domainAddr = $("#domainAddr").clone().wrapAll("<div/>").parent().html();
$("#domainAddr").remove();
var defaultSite = $("#defaultSite").clone().wrapAll("<div/>").parent().html();
$("#defaultSite").remove();

function fn_setSiteGubun(siteGubun){
	if("1" == siteGubun) {
		$("#systemConfig").append(defaultSite);
		if($("#domainAddr")) $("#domainAddr").remove();
	}else{
		$("#systemConfig").append(domainAddr);
		if($("#defaultSite")) $("#defaultSite").remove();
	}
}

fn_setSiteGubun("${systemconfigVO.siteGubun}");

//라디오버튼 값 변경 체크
$('input[type="radio"]').on('ifChecked', function(event){

	var opt = $(this).attr('name');

	if(opt == "siteGubun"){
		fn_setSiteGubun($(this).val());
	}else{

	}
});
//]]>
</script>
