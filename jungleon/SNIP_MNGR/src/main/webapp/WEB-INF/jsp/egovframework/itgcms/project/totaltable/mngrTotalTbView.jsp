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
 * @파일명 : mngrTotalTbView.jsp
 * @파일정보 : 관리자 사업안내 > 총괄표 조회
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

<script type="text/javascript">
<c:if test="${searchVO.act eq 'update' }">
/* 글 삭제 function */
function fn_goDel(){
	if(confirm("삭제하시겠습니까?")){
		var frm = document.tbForm;
		frm.encoding = "application/x-www-form-urlencoded";
		frm.action = "/_mngr_/module/${menuCode}_delete_totalTb.do";
		frm.submit();
	}
}
</c:if>
/* 글 등록 function */
function fn_egov_save() {
	frm = document.tbForm;

	if(Validator.validate(frm)){
		<c:if test="${searchVO.act eq 'regist' }">
			frm.action = "/_mngr_/module/${menuCode}_proc_totalTb.do";
		</c:if>
		<c:if test="${searchVO.act eq 'update' }">
			frm.action = "/_mngr_/module/${menuCode}_update_totalTb.do";
		</c:if>
   		frm.submit();
	}
}

/* 목록 이동 function */
function fn_goList(){
	var query = "${searchVO.query}";
	query = ItgJs.fn_replaceQueryString(query, "schId", "");
	location.href="/_mngr_/module/${menuCode}_list_totalTb.do?"+query;
}

function fn_chk(idx) {
	if(Number(idx) == 0) { //선택안함 이면 나머지 선택 취소
		$("input[name=grStep]").prop("checked", false);
 		$("input[id='grStep0']").prop("checked", true);
	} else {
		$("input[id='grStep0']").prop("checked", false);

	}
}


var registCnInput = {
		init				: function() {
			var $year = $("#bsYear");
			ItgJs.selectBoxGetYear($year.attr("id"),'${result.bsYear }');

			$("input[name=grStep]").prop("checked", false);
			var tmpGrStep = "${result.grStep}";

			if (!tmpGrStep) {
				$("#grStep0").prop("checked", true);
			} else {
				var array = tmpGrStep.split(",");
				$.each(array, function(index, item) {
					$("#grStep" + item).prop("checked", true);
				})
			}
		}
}

$(function() {
	registCnInput.init();

})

var oldMenuCode, oldMenuName
function selectMenu(code, depth) {
	var tmpDepth = depth;
	switch(depth) {
		case 1:
			$("#menuDepth" + (tmpDepth + 1) +" option").remove();
			$("#menuDepth" + (tmpDepth + 1)).append("<option value=''>선택</option>")
			tmpDepth++;
		case 2:
			$("#menuDepth" + (tmpDepth + 1) +" option").remove();
			$("#menuDepth" + (tmpDepth + 1)).append("<option value=''>선택</option>")
			tmpDepth++;
		case 3:
			$("#menuDepth" + (tmpDepth + 1) +" option").remove();
			$("#menuDepth" + (tmpDepth + 1)).append("<option value=''>선택</option>")
	}
	if(code == "") {
		$("#menuCode").val("");
		$("#menuName").val("");
		return;
	} else {
		var text = $("#menuDepth"+depth+" option:selected").text()
		oldMenuCode = code;
		oldMenuName = text;
	}
	$.ajax({
		url: "/_mngr_/module/${menuCode}_selectMenuSubList.ajax",
		data: "id=" + code,
		dataType: "json",
		success: function(resultData){
			if(resultData.length > 0) {
				for(var i = 0; i < resultData.length; i++) {
					$("#menuDepth" + (depth + 1)).append("<option value='"+resultData[i].menuCode+"'>"+resultData[i].menuName+"</option>");
				}
			} else {
				alert("더 이상 하위 메뉴가 없습니다.");
			}
		}
	})

}
var dept4="Y";
function fn_set4DeptMenu(code){
	dept4=code;
}
function fn_setMenu(){
	if (dept4=="Y") {
		$("#menuCode").val(oldMenuCode);
		$("#menuName").val(oldMenuName);
	}else{
		$("#menuCode").val(dept4);
		var text = $("#menuDepth4 option:selected").text();
		$("#menuName").val(text);
		dept4="Y";
	}
}
</script>

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
				<div class="col-md-12" style="padding:0;">
					<form name="tbForm" id="tbForm" method="post" class="form-horizontal">
						<input type="hidden" name="bsIdx" value="${result.bsIdx }" />
						<input type="hidden" name="schFld" value="${searchVO.schFld }" />
						<input type="hidden" name="schStr" value="${searchVO.schStr }" />
						<input type="hidden" name="page" value="${searchVO.page }" />
						<input type="hidden" name="act" value="${searchVO.act }" />

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
									<ora:selectCodeList selectName="gpName" selectedValue="${result.gpName }" codeList="${gpNameCodeList}" selectTitle="전체" className="required"/>
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
									<ora:selectCodeList selectName="cgName" selectedValue="${result.cgName }" codeList="${cgNameCodeList}" selectTitle="부서 선택" className="required"/>
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
								<th class="t"><label for="menuDepth1">메뉴 링크</label></th>
								<td colspan="3">
									<input type="hidden" name="menuCode" id="menuCode" value="<c:out value="${result.menuCode }" />" />
									<input type="text" name="menuName" id="menuName" value="<c:out value="${result.menuName}" />" readonly="readonly" class="form-control input-sm f-wd-200" style="display: inline-block" />
									<button type="button" onclick="fn_setMenu(); return false;" class="btn btn-success">메뉴 선택</button>
									<div>
									<select name="menuDepth1" id="menuDepth1" onchange="selectMenu(this.value, 1);">
										<option value="">선택</option>
									<c:forEach var="menu" items="${menuDepth1List }">
										<option value="${menu.menuCode }"><c:out value="${menu.menuName }" /></option>
									</c:forEach>
									</select>
									<select name="menuDepth2" id="menuDepth2" onchange="selectMenu(this.value, 2);">
										<option value="">선택</option>
									</select>
									<select name="menuDepth3" id="menuDepth3" onchange="selectMenu(this.value, 3);">
										<option value="">선택</option>
									</select>
									<select name="menuDepth4" id="menuDepth4" onchange="fn_set4DeptMenu(this.value)">
										<option value="">선택</option>
									</select>
									</div>
								</td>
							</tr>
						</table>
					</form>
					<div class="body-footer" id="footerButtons">
						<div class="pull-right">
								<button type="button" onclick="fn_egov_save(); return false;" class="btn btn-primary">저장</button>
								<c:if test="${searchVO.act eq 'update' }">
									<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
								</c:if>
								<button type="button" onclick="fn_goList(); return false;" class="btn btn-default">목록</button>
						</div>
					</div><!-- /.body-footer -->
				</div>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->




