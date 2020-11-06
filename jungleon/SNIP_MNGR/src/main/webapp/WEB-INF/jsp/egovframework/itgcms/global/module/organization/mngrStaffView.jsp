
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%@ taglib prefix="cct" uri="/WEB-INF/tlds/CreateCodeTag.tld"%>

<%
/**
 * @파일명 : mngrStaffView.jsp
 * @파일정보 : 조직및사무 직원 정보 등록/조회 페이지
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @jyl 2017. 10. 16. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>


<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

        <!-- Main content -->
        <section class="content">
        <form name="form1" id="form1" method="post" enctype="multipart/form-data">
		<input type="hidden" name="schId" value="<c:out value="${searchVO.schId }" />" />
		<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
		<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
		<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
		<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
		<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
		<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
		<input type="hidden" name="schOpt3" value="<c:out value="${searchVO.schOpt3 }" />" />
		<input type="hidden" name="menuCodes" />

			<div class="row">

				<div class="col-md-12">

						<!-- <div class="box-header with-border"><h3 class="box-title">Title</h3></div> -->

							<div class="row">

								<div class="col-xs-12 table-responsive">
									<table class="table table-bordered tp2">

										<tbody>
											<tr>
												<th class="t"><label for="instCenterNm">이름 *</label></th>
												<td colspan="10">
													<input type="text" name="staffNm" id="staffNm" maxlength="30" value="<c:out value="${employeeInfo.staffNm}"/>" class="form-control input-sm f-wd-400 required" title="이름" />
												</td>
											</tr>
											<tr>
												<th class="t" colspan="1">부서 *</th>
													<td style="border-right: 1px solid white;" colspan="2">
														<select id="staffDept" name="staffDept" title="부서" class="form-control validate-required-select input-sm f-wd-200 validate-required-select" ">
															<option value="">선택</option>
															<c:forEach var="codeList" items="${groupList}">
																<option value="${codeList.ccode}" <c:out value="${employeeInfo.staffDept eq codeList.ccode ? 'selected':''}"/>>${codeList.cname}</option>
															</c:forEach>
														</select>
													</td>
													<td style="border-left: 1px solid white;">
													</td>
											</tr>
											<tr>
												<th class="t" colspan="1">직책 *</th>
													<td style="border-right: 1px solid white;" colspan="2">
													<cct:codeTag tagName="staffPos" pcode="position" tagType="select" useNullOpt="선택" selectedValue="${employeeInfo.staffPos}" className="form-control input-sm f-wd-200 validate-required-select"/>
													</td>
													<td style="border-left: 1px solid white;">
													</td>
											</tr>
											<tr>
												<th class="t">전화번호</th>
												<td style="width:110px;">
													<cct:codeTag tagName="telNo1" pcode="telLoc" tagType="select" useNullOpt="선택" selectedValue="${telNo1}" className="form-control"/>
												</td>
												<td colspan="9"> -
													<input type="text" name="telNo2" id="telNo2" title="전화번호" value="<c:out value="${ufn:strSplitGetPhone(employeeInfo.telNo, '1')}"/>" size="5" maxlength="4" style="width:90px; border:1px solid #d2d6de;" class="input-sm validate-digits" /> -
													<input type="text" name="telNo3" id="telNo3" title="전화번호" value="<c:out value="${ufn:strSplitGetPhone(employeeInfo.telNo, '2')}"/>" size="5" maxlength="4" style="width:90px; border:1px solid #d2d6de;" class="input-sm validate-digits"/> ~
													<input type="text" name="telNo4" id="telNo4" title="전화번호" size="5" maxlength="4" style="width:90px; border:1px solid #d2d6de;" class="input-sm validate-digits"
													<c:if test="${employeeInfo.telNo.contains('~')}"> value="<c:out value="${ufn:strSplitGetPhone(employeeInfo.telNo, '3')}"/>"</c:if>/>
												</td>
											</tr>
											<tr>
												<th class="t">팩스 번호</th>
												<td style="width:110px;">
													<cct:codeTag tagName="faxNo1" pcode="telLoc" tagType="select" useNullOpt="선택" selectedValue="${faxNo1}" className="form-control"/>
												</td>
												<td> -
													<input type="text" name="faxNo2" id="faxNo2" title="전화번호" value="<c:out value="${ufn:strSplitGetPhone(employeeInfo.faxNo, '1')}"/>" size="5" maxlength="4" style="width:90px; border:1px solid #d2d6de;" class="input-sm validate-digits" /> -
													<input type="text" name="faxNo3" id="faxNo3" title="전화번호" size="5" maxlength="4" style="width:90px; border:1px solid #d2d6de;" class="input-sm validate-digits" value="<c:out value="${ufn:strSplitGetPhone(employeeInfo.faxNo, '2')}"/>"/>
												</td>
											</tr>
											<tr>
												<th class="t">모바일 번호</th>
												<td style="width:110px;">
													<cct:codeTag tagName="staffHp1" pcode="mobile" tagType="select" useNullOpt="선택" selectedValue="${staffHp1}" className="form-control"/>
												</td>
												<td> -
													<input type="text" name="staffHp2" id="staffHp2" title="전화번호" value="<c:out value="${ufn:strSplitGetPhone(employeeInfo.staffHp, '1')}"/>" size="5" maxlength="4" style="width:90px; border:1px solid #d2d6de;" class="input-sm validate-digits" /> -
													<input type="text" name="staffHp3" id="staffHp3" title="전화번호" size="5" maxlength="4" style="width:90px; border:1px solid #d2d6de;" class="input-sm validate-digits" value="<c:out value="${ufn:strSplitGetPhone(employeeInfo.staffHp, '2')}"/>"/>
												</td>
											</tr>
											<tr>
												<th class="t">호출번호</th>
												<td colspan="10">
													<input type="text" name="cellNo" id="cellNo" maxlength="30" value="<c:out value="${employeeInfo.cellNo}"/>" class="form-control input-sm f-wd-400" title="호출번호" />
												</td>
											</tr>
											<tr>
												<th class="t"><label for="staffWork">담당업무 *</label></th>
												<td colspan="10">
													<textarea name="staffWork" id="staffWork" rows="10" class="form-control required" maxlength="1000" title="담당업무" style="width: 750px"><c:out value="${employeeInfo.staffWork}"/></textarea>
												</td>
											</tr>
											<tr>
												<th class="t">이메일</th>
												<td colspan="10">
													<input type="text" name="staffEmail" id="staffEmail" maxlength="30" value="<c:out value="${employeeInfo.staffEmail}"/>" class="form-control input-sm f-wd-400" title="이메일" />
												</td>
											</tr>
											<tr>
												<th class="t"><label for="regDt">입사일자 </label></th>
												<td colspan="10">

													<input type="text" name="regDt" id="regDt" maxlength="10" title="시작일" value="<fmt:formatDate value='${employeeInfo.regDt}' pattern='yyyy-MM-dd' />" class="form-control input-sm f-wd-200" readonly="readonly" />
												</td>
											</tr>
											<tr>
												<th class="t">사진</th>
												<td id="staffImgRows" colspan="10">
													<div class="staffImgRow">
													<div class="col-xs-9">
													<input type="file" class="form-control" name="staffImg" id="staffImg"/>
															<input type="hidden" name="oldFile" id="oldFile" value="${employeeInfo.oldFile }" />
															<input type="hidden" name="staffImg" id="staffImg" value="${employeeInfo.staffImg}" />
													</div>
													<div class="col-xs-2" style="text-align: right;">
														<button type="button" class="btn btn-danger delImgBtn" onclick="delImg(this);">삭제</button>
													</div>
													<c:if test="${not empty employeeInfo.staffImg }">
													<div><br/><br/><br/>
				                                       	첨부 이미지 :   <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','staffImg',employeeInfo.staffImg,employeeInfo.staffImg) }" />" ><c:out value="${employeeInfo.oldFile }" /></a>
				                                      <p><br/><img src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','staffImg',employeeInfo.staffImg,employeeInfo.staffImg) }" />" alt="<c:out value="${employeeInfo.staffImg}" />" style="width:40%" /></p>
				                                    </div>
				                                    </c:if>
				                                    </div>
												</td>
											</tr>


										</tbody>
									</table>
								</div><!-- /.col -->

							</div>


						<div class="box-footer">
                  			<div class="pull-right">
								<a href="#none" onclick="fn_goList(); return false;" class="btn btn-default btn-sm">목록으로</a>
								<button href="#none" onclick="fn_egov_save(); return false;" class="btn btn-primary btn-sm">${ufn:deCode(searchVO.act,'UPDATE,저장','등록완료')}</button>
                  			</div>
                		</div><!-- /.box-footer -->

				</div>
			</div>
        </form>
        </section><!-- /.content -->


<script type="text/javascript">
//<[[!CDATA[
var nameChkFlag = false;
var comNochkFlag = false;
//R: 도로명, J: 지번
var addr = "R";
var queryString = '<c:out value="${searchVO.queryString()}" escapeXml="false" />';

$(document).ready(function(){
		ItgJs.fn_datePicker("#regDt");
});

function setUnlimit(){
	$("#regDt").val('<c:out value="${ufn:getDatePattern('yyyy-MM-dd')}" />');
}

/* 직원정보 등록,수정 프로세스 */
function fn_egov_save() {
	frm = document.form1;
	if(Validator.validate(frm)){
		if(frm.telNo1.value != '' || frm.telNo2.value != '' || frm.telNo3.value != ''){
		    if(frm.telNo1.value == '' || frm.telNo2.value == '' || frm.telNo3.value == ''){
		    	alert("정확한 전화번호를 입력해주세요.");
		    	return false;
		    }
		}
		if(frm.faxNo1.value != '' || frm.faxNo2.value != '' || frm.faxNo3.value != ''){
		    if(frm.faxNo1.value == '' || frm.faxNo2.value == '' || frm.faxNo3.value == ''){
		    	alert("정확한 팩스번호를 입력해주세요.");
		    	return false;
		    }
		}
		if(frm.staffHp1.value != '' || frm.staffHp2.value != '' || frm.staffHp3.value != ''){
		    if(frm.staffHp1.value == '' || frm.staffHp2.value == '' || frm.staffHp3.value == ''){
		    	alert("정확한 모바일번호를 입력해주세요.");
		    	return false;
		    }
		}
	    <c:if test="${searchVO.act == 'REGIST' }">
	    frm.action = "/_mngr_/module/mngrOrganization.do?schM=proc&act=REGIST&menuUrl=${menuCode}";
		</c:if>
		<c:if test="${searchVO.act == 'UPDATE' }">
		frm.action = "/_mngr_/module/mngrOrganization.do?schM=proc&act=UPDATE&menuUrl=${menuCode}";
		</c:if>

	    frm.submit();

	}
}


/* 목록 화면 이동 */
function fn_goList() {
	var tmpQuery = queryString;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schId", "");
		location.href = "?";
}

//]]>
</script>
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="daumPostLayer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer"
	     style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="ItgJs.getDaumAddressLayerClose()" alt="닫기 버튼">
</div>