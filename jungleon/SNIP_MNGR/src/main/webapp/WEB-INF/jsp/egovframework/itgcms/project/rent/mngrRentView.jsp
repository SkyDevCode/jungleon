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
<%@ page import="egovframework.itgcms.project.rent.service.RentEnum.RENT_MEET" %>
<%
/**
 * @파일명 : mngrRentView.jsp
 * @파일정보 : 관리자 사업신청 > 대관신청 조회 
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 4. 15. 최초생성
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
				<form name="form1" id="form1" method="post">
					<input type="hidden" name="schStatus" value="<c:out value="${searchVO.schStatus }" />" />
					<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
					<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
					<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
					<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
					<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
					<input type="hidden" name="schId" value="<c:out value="${searchVO.schId}" />" />
						<div class="row">
							<div class="col-xs-12 table-responsive">
								<h4><i class="fa fa-circle-o"></i> 상세 정보</h4>
								<table class="table table-bordered tp2">
									<colgroup>
										<col style="width:15%"/>
										<col style="width:35%"/>
										<col style="width:15%"/>
										<col style="width:35%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="t"><label for="rName">담당자</label></th>
											<td>
												<c:out value="${result.rName }"/>
											</td>
											<th class="t">신청자 ID</th>
											<td>
												<c:out value="${result.rId }" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="rTel">연락처</label></th>
											<td>
												<c:out value="${result.rTel }"/>
											</td>
											<th class="t"><label for="rEmail">이메일</label></th>
											<td>
												<c:out value="${result.rEmail }"/>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="rAddr">소재지</label></th>
											<td>
												<c:out value="${result.rAddr }"/>
											</td>
											<th class="t"><label for="rCustType">고객 구분</label></th>
											<td>
												<c:out value="${result.rCustTypeName }" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="rComName">회사명/단체명</label></th>
											<td>
												<c:out value="${result.rComName }"/>
											</td>
											<th class="t"><label for="rMeetType">모임분류</label></th>
											<td>
												<c:out value="${result.rMeetTypeName }" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="rPersonNum">인원</label></th>
											<td colspan="3">
												<c:out value="${result.rPersonNum }"/>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="rCarry">반입 물품</label></th>
											<td colspan="3">
												<c:out value="${result.rCarry }"/>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="fileId">파일업로드</label></th>
											<td colspan="3">
												<!-- 파일업로드 폼 추가 시작 -->
												<c:import  url="/afile/filedownForm.do">
													<c:param name="formName" value="form1" />
													<c:param name="objectId" value="upload1" />
													<c:param name="fileIdName" value="fileId" />
													<c:param name="fileIdValue" value="${result.fileId}" />
													<c:param name="fileTypes" value="all" />
													<c:param name="maxFileSize" value="50" />
													<c:param name="maxFileCount" value="5" />
													<c:param name="useSecurity" value="false" />
													<c:param name="uploadMode" value="db" />
												</c:import>
												<!-- 파일업로드 폼 추가 끝 -->
											</td>
										</tr>
									</tbody>
								</table>
								<h4><i class="fa fa-circle-o"></i> 대관 예약</h4>
								<table class="table table-bordered tp2">
									<colgroup>
										<col style="width:15%"/>
										<col style="width:35%"/>
										<col style="width:15%"/>
										<col style="width:35%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="t"><label for="rFacility">대관 장소</label></th>
											<td>
												<c:out value="${result.rFacilityName }" />
											</td>
											<th class="t"><label for="rEquipment">장비 선택</label></th>
											<td>
												<c:out value="${result.rEquipmentName }" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="rReserveDt">예약 날짜</label></th>
											<td colspan="3">
												<c:out value="${result.rReserveDt }"/>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="rReserveTm">예약 시간</label></th>
											<td colspan="3">
												<c:set var="arrReserveTm" value="${fn:split(result.rReserveTm , ',')}" />
												<c:forEach var="tm" items="${arrReserveTm }">
													<c:out value="${tm }"/>:00 ~ <c:out value="${tm + 1}"/>:00 <br />
												</c:forEach>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="rCharge">사용료</label></th>
											<td colspan="3">
												<fmt:formatNumber value="${result.rCharge }" type="number" /> 원 (부가세 별도)
											</td>
										</tr>
									</tbody>
								</table>
								<h4><i class="fa fa-circle-o"></i> 접수 처리 결과</h4>
								<table class="table table-bordered tp2">
									<colgroup>
										<col style="width:15%"/>
										<col style="width:85%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="t"><label for="rStatus">처리 상태</label></th>
											<td colspan="3">
												<select name="rStatus" id="rStatus" class="required form-control input-sm f-wd-100" title="처리 상태">
													<option value="">선택하세요</option>
													<c:forEach var="code" items="${statusCodeList }">
														<option value="<c:out value="${code.ccode }" />" ${ufn:selected(code.ccode, result.rStatus) }><c:out value="${code.cname }" /> </option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th class="t">등록자 정보</th>
											<td colspan="3">
												<strong>아이디</strong> : <c:out value="${result.regid }" />, <strong>등록일</strong> : <c:out value="${result.regdt }" />
											</td>
										</tr>
										<c:if test="${not empty result.updid }">
										<tr>
											<th class="t">수정자 정보</th>
											<td colspan="3">
												<strong>아이디</strong> : <c:out value="${result.updid }" />, <strong>수정일</strong> : <c:out value="${result.upddt }" />
											</td>
										</tr>
										</c:if>
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
		if("${result.rStatus}" == frm.rStatus.value) {
			alert("수정사항이 없습니다.");
			return false;
		}
		if(confirm("처리상태를 수정하시겠습니까?")){
			frm.action = "/_mngr_/module/${menuCode}_mngrRentUpdateStatusProc.do" ;
			frm.submit();
		}
	}
}
function fn_goDel(){
	var frm = document.form1;
	if(confirm("삭제하시겠습니까?")) {
		frm.action="/_mngr_/module/${menuCode}_mngrRentDeleteProc.do"
		frm.submit();
	}
}

function checkFileChangeSubmit(title){
	//alert(title+" : "+${objectId}_delIdxs.length+","+ ${objectId}_fileChange+","+(${objectId}_delIdxs.length + ${objectId}.uploadedFiles.length > 0 && ${objectId}_fileChange));
	if(upload1_delIdxs.length > 0 || upload1_fileChange){
		alert(title+" 추가/삭제 내역이 있습니다.\n적용버튼을 클릭하여 변경사항을 적용하여 주시기 바랍니다.");
		return false;
		//return (confirm(title+" 추가/삭제 내역이 있습니다.\n적용버튼을 클릭하여 변경사항을 적용하여 주시기 바랍니다.\n무시하고 계속 저장하실 경우 변경 내역은 사라집니다.\n(확인:무시 하고 저장, 취소:취소하고 나가기)"));
	}
	return true;
}

//]]>
</script>