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
 * @파일명 : mngrTotalTbRegist.jsp
 * @파일정보 : 총괄표 관리자 등록
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @hsk1218 2020. 4. 27. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<!-- AX5-UI -->
<script src="${ctx}/resource/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/ax5core.min.js"></script>
<script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/ax5ui.itg.js"></script>
<script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/jquery-direct.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/resource/plugins/ax5ui/ax5ui.itg.css"/>
<script type="text/javascript">

/* 글 등록 function */
function fn_egov_save() {

	frm = document.tbForm;

	if (Validator.validate(frm)) {
		frm.action = "/_mngr_/module/Guidance5_proc_totalTb.do";
    	frm.submit();
	}
}

/* 목록 이동 function */
function fn_goList(){
	location.href="/_mngr_/module/Guidance5_list_totalTb.do"
}

function fn_chk(idx) {
	if(Number(idx) == 0) { //선택안함 이면 나머지 선택 취소
		$("input[name=grStep]").prop("checked", false);
 		$("input[id='grStep0']").prop("checked", true);
	} else {
		$("input[id='grStep0']").prop("checked", false);

	}
}



$(function() {
	ItgJs.selectBoxGetYear($("#bsYear").attr("id"),'${result.pubYear }');

});

</script>

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
				<div class="col-md-12" style="padding:0;">
					<form name="tbForm" id="tbForm" method="post" class="form-horizontal">
						<table class="table table-bordered table tp2">
							<colgroup>
								<col style="width: 25%;" />
								<col style="width: 75%;" />
							</colgroup>
							<tr>
								<th class="t"><label for="bsyear">사업년도</label></th>
								<td colspan="3">
									<select data-name="년" id="bsYear" name="bsYear" class="required empty" style="width:100px;">
										<option value="">선택</option>
									</select> 년&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							<tr>
								<th class="t"><label for="gpName">구분</label></th>
								<td colspan="3">
									<select name="gpName" id="gpName" class="required form-control input-sm f-wd-100" title="구분">
										<option value="">전체</option>
										<c:forEach var="code" items="${gpNameCodeList }">
											<option value="<c:out value="${code.ccode }" />" ${ufn:selected(code.ccode, result.gpName) }><c:out value="${code.cname }" /> </option>
										</c:forEach>
									</select>
								</td>
							</tr>


							<tr>
								<th class="t"><label for="">성장단계</label></th>
								<td colspan="3">
									<c:forEach var="result" items="${grstep }" varStatus="status">
										<input type="checkbox" name="grStep" id="grStep${status.count }"  value="${result.value }" onclick="fn_chk(${status.count})"/>
										<label for="grStep${status.count }">${result.name }</label>
									</c:forEach>
									<input type="checkbox" name="grStep" id="grStep0" value="" checked="checked"  onclick="fn_chk(0)" />
									<label for="grStep0">해당없음</label>
								</td>
							</tr>


							<tr>
								<th class="t"><label for="cgName">부서 선택</label></th>
								<td colspan="3">
									<select name="cgName" id="cgName" class="required form-control input-sm f-wd-100" title="부서">
										<option value="">전체</option>
										<c:forEach var="code" items="${cgNameCodeList }">
											<option value="<c:out value="${code.ccode }" />" ${ufn:selected(code.ccode, result.cgName) }><c:out value="${code.cname }" /> </option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th class="t"><label for="bsName">사업명</label></th>
								<td colspan="3">
									<input type="text" name="bsName" id="bsName" class="required form-control input-sm f-wd-600" value="<c:out value="${result.bsName }"/>" maxlength="50" title="사업명" />
								</td>
							</tr>
							<tr>
								<th class="t"><label for="bsLocation">장소</label></th>
								<td colspan="3">
									<input type="text" name="bsLocation" id="bsLocation" class="form-control input-sm f-wd-600" value="<c:out value="${result.bsLocation }"/>" maxlength="50" title="장소" />
								</td>
							</tr>
							<tr>
								<th class="t"><label for="bsPeriod">기간</label></th>
								<td colspan="3">
									<input type="text" name="bsPeriod" id="bsPeriod" class="form-control input-sm f-wd-600" value="<c:out value="${result.bsPeriod }"/>" maxlength="50" title="기간" />
								</td>
							</tr>
							<tr>
								<th class="t"><label for="menuCode">메뉴 링크</label></th>
								<td colspan="3">
									<input type="hidden" name="menuCode" />
									<input type="text" name="menuName" readonly="readonly" />
									<input type="text" name="bsPeriod" id="bsPeriod" class="form-control input-sm f-wd-600" value="<c:out value="${result.bsPeriod }"/>" maxlength="50" title="기간" />
								</td>
							</tr>
						</table>
					</form>
					<div class="body-footer" id="footerButtons">
						<div class="pull-right">
								<button type="button" onclick="fn_egov_save(); return false;" class="btn btn-primary">저장</button>
								<button type="button" onclick="fn_goList(); return false;" class="btn btn-default">목록</button>
						</div>
					</div><!-- /.body-footer -->
				</div>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->