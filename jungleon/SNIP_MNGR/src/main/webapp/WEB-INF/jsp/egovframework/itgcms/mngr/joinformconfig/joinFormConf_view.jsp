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
 * @파일명 : mngrManagerRegist.jsp
 * @파일정보 : 관리자관리 등록
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

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
			<form name="joinFormConfig" id="joinFormConfig" method="post" onsubmit="fn_egov_save(); return false;" class="form-horizontal">
				<input type="hidden" name="progIdx" value="<c:out value="${urlInfo.menuSubType }" />" />
				<input type="hidden" name="siteCode" value="${siteCode}"/>
				<input type="hidden" name="no" value="<c:out value="${searchVO.no}" />" />
				<input type="hidden" name="contractDesc" id="contractDesc" value="${searchVO.contractDesc}" />
				<table class="table table-bordered table tp2">
					<colgroup>
						<col style="width: 25%;" />
						<col style="width: 75%;" />
					</colgroup>
					<tr>
						<th id="contractNameWrapper" rowspan="${searchVO.cntContract+1}" style="vertical-align: middle;">
							<span>약관 정보</span>
						</th>

						<td>
							<select class="form-control" id="contractSelect">
								<option value="none"><span>약관 추가</span></option>
								<c:forEach items="${contractList}" var="cont">
									<option value="${cont.no}">${cont.title}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<c:forEach var="contract" items="${searchVO.contractList}" varStatus="stat">
						<tr class="contractName" id="contract_${contract.no}" no="${contract.no}">
							<td>${contract.title}&nbsp;&nbsp;
								<span class="pull-right">
									<button type="button" class="btn btn-danger" onclick="contractDel('${contract.no}')">삭제</button>
								</span>
							</td>
						</tr>
					</c:forEach>
				</table>


				<table class="table table-bordered table tp2">
					<colgroup>
						<col style="width: 12%;" />
						<col style="width: 13%" />
						<col style="width: 31%" />
						<col style="width: 13%" />
						<col style="width: 31%" />
					</colgroup>
					<tbody>
						<tr>
							<th rowspan="6"
								style="vertical-align: middle;"><span>회원정보</span>
							</th>
							<th class="t"><span>아이디</span></th>
							<td><select class="form-control" disabled="disabled">
									<option>사용(필수)</option>
							</select><span class="help-block" style="margin-bottom:0;">아이디는 항상 입력받아야 하는 기본 입력 사항입니다.</span></td>
							<th class="t">패스워드</th>
							<td><select class="form-control" disabled="disabled">
									<option>사용(필수)</option>
							</select><span class="help-block" style="margin-bottom:0;">패스워드는 항상 입력받아야 하는 기본 입력 사항입니다.</span></td>
						</tr>
						<tr>
							<th class="t"><span>이름</span></th>
							<td><select class="form-control" name="name">
									<option value="0" <c:out value="${searchVO.name == 0 ? 'selected' : ''}"/>>미사용</option>
									<option value="1" <c:out value="${searchVO.name == 1 ? 'selected' : ''}"/>>사용(필수)</option>
									<option value="2" <c:out value="${searchVO.name == 2 ? 'selected' : ''}"/>>사용(선택)</option>
							</select></td>
							<th class="t"><span>별명</span></th>
							<td><select class="form-control" name="nickName">
									<option value="0" <c:out value="${searchVO.nickName == 0 ? 'selected' : ''}"/>>미사용</option>
									<option value="1" <c:out value="${searchVO.nickName == 1 ? 'selected' : ''}"/>>사용(필수)</option>
									<option value="2" <c:out value="${searchVO.nickName == 2 ? 'selected' : ''}"/>>사용(선택)</option>
							</select></td>
						</tr>
						<tr>
							<th class="t"><span>전화번호</span></th>
							<td><select class="form-control" name="phone">
									<option value="0" <c:out value="${searchVO.phone == 0 ? 'selected' : ''}"/>>미사용</option>
									<option value="1" <c:out value="${searchVO.phone == 1 ? 'selected' : ''}"/>>사용(필수)</option>
									<option value="2" <c:out value="${searchVO.phone == 2 ? 'selected' : ''}"/>>사용(선택)</option>
							</select></td>
							<th class="t"><span>휴대전화번호</span></th>
							<td><select class="form-control" name="mobile">
									<option value="0" <c:out value="${searchVO.mobile == 0 ? 'selected' : ''}"/>>미사용</option>
									<option value="1" <c:out value="${searchVO.mobile == 1 ? 'selected' : ''}"/>>사용(필수)</option>
									<option value="2" <c:out value="${searchVO.mobile == 2 ? 'selected' : ''}"/>>사용(선택)</option>
							</select></td>
						</tr>
						<tr>
							<th class="t"><span>이메일</span></th>
							<td><select class="form-control" name="email">
									<option value="0" <c:out value="${searchVO.email == 0 ? 'selected' : ''}"/>>미사용</option>
									<option value="1" <c:out value="${searchVO.email == 1 ? 'selected' : ''}"/>>사용(필수)</option>
									<option value="2" <c:out value="${searchVO.email == 2 ? 'selected' : ''}"/>>사용(선택)</option>
							</select></td>
							<th class="t"><span>fax</span></th>
							<td><select class="form-control" name="fax">
									<option value="0" <c:out value="${searchVO.fax == 0 ? 'selected' : ''}"/>>미사용</option>
									<option value="1" <c:out value="${searchVO.fax == 1 ? 'selected' : ''}"/>>사용(필수)</option>
									<option value="2" <c:out value="${searchVO.fax == 2 ? 'selected' : ''}"/>>사용(선택)</option>
							</select></td>
						</tr>
						<tr>
							<th class="t"><span>주소</span></th>
							<td><select class="form-control" name="address">
									<option value="0" <c:out value="${searchVO.address == 0 ? 'selected' : ''}"/>>미사용</option>
									<option value="1" <c:out value="${searchVO.address == 1 ? 'selected' : ''}"/>>사용(필수)</option>
									<option value="2" <c:out value="${searchVO.address == 2 ? 'selected' : ''}"/>>사용(선택)</option>
							</select></td>
							<th class="t"><span>생년월일</span></th>
							<td>
								<select class="form-control" name="birth">
									<option value="0" <c:out value="${searchVO.birth == 0 ? 'selected' : ''}"/>>미사용</option>
									<option value="1" <c:out value="${searchVO.birth == 1 ? 'selected' : ''}"/>>사용(필수)</option>
									<option value="2" <c:out value="${searchVO.birth == 2 ? 'selected' : ''}"/>>사용(선택)</option>
								</select>
								<span class="help-block" style="margin-bottom:0;">생년월일을 사용하지 않을 경우, 통계관리>연령대별접속통계가 집계되지 않습니다.</span>
							</td>
						</tr>
						<tr>
							<th class="t"><span>성별</span></th>
							<td><select class="form-control" name="sex">
									<option value="0" <c:out value="${searchVO.sex == 0 ? 'selected' : ''}"/>>미사용</option>
									<option value="1" <c:out value="${searchVO.sex == 1 ? 'selected' : ''}"/>>사용(필수)</option>
									<option value="2" <c:out value="${searchVO.sex == 2 ? 'selected' : ''}"/>>사용(선택)</option>
							</select></td>
							<th class="t"><span>그룹</span></th>
							<td><select class="form-control" name="grp">
									<option value="0" <c:out value="${searchVO.grp == 0 ? 'selected' : ''}"/>>미사용</option>
									<option value="1" <c:out value="${searchVO.grp == 1 ? 'selected' : ''}"/>>사용(필수)</option>
									<option value="2" <c:out value="${searchVO.grp == 2 ? 'selected' : ''}"/>>사용(선택)</option>
							</select></td>
						</tr>
						<tr>
							<th style="vertical-align: middle;"><span>가입 승인</span></th>
							<td colspan="4">
								<label><input type="radio" name="useJoinwait" value="1" <c:out value="${searchVO.useJoinwait == 1 ? 'checked' : ''}"/> />&nbsp;&nbsp;수동</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<label><input type="radio" name="useJoinwait" value="0" <c:out value="${searchVO.useJoinwait == 0 ? 'checked' : ''}"/> />&nbsp;&nbsp;자동</label>
							</td>
						</tr>
						<tr>
							<th style="vertical-align: middle;"><span>탈퇴시 데이터 처리 방식</span></th>
							<td colspan="4">
								<label><input type="radio" name="tempVal" value="0"  />DB 완전 삭제(복구 불가)</label>
								<label><input type="radio" name="tempVal" value="1" />6개월 보관</label>
								<label><input type="radio" name="tempVal" value="2" 'checked' />영구 보관</label>
							</td>
						</tr>
					</tbody>
				</table>
			</form>

			<div class="pull-right">
				<button type="button" onclick="fn_egov_save();"
					class="btn btn-primary">저장</button>
			</div>
	</form>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
<script type="text/javascript">
//<[[!CDATA[

/* 글 등록 function */
function fn_egov_save() {
	var contractDesc = "";

	if ($(".contractName").length > 0) {
		$(".contractName").each(function(){
			contractDesc += $(this).attr("no")+",";
			$("#contractDesc").val(contractDesc);
		});
	} else {
		$("#contractDesc").val(contractDesc);
	}


	frm = document.joinFormConfig;
	if(Validator.validate(frm)){

		var contractChk = true;
		if ($("#contractDesc").val()=="") {
			contractChk = confirm("약관을 선택하지 않으셨습니다. \n이대로 진행하시겠습니까?");
		}
		if (contractChk) {
			$.ajax({
				url : '/_mngr_/module/${urlInfo.menuCode}_edit_joinFormConf_proc.ajax',
				data : $("#joinFormConfig").serialize(),
				type : "POST",
				success : function(data){
					if(data == 401){
						alert("해당 권한이 없습니다.");
						return false;
					}else if(data == 1){
						alert("성공적으로 수정되었습니다.");
					}else if(data == 2){
						alert("성공적으로 등록되었습니다."); //alert("코드가 중복 되었습니다. 확인 후 다시 시도해 주세요");
					}else{
						alert("오류가 발생하였습니다. 새로고침 후 재시도하십시오");
						return false;
					}
// 					switch (data) {
// 					case 1 : alert("성공적으로 수정되었습니다.");
// 						break;
// 					case 2 : alert("성공적으로 등록되었습니다.");
// 						break;
// 					case 401 : alert("해당 권한이 없습니다.");
// 						break;
// 					default : alert("오류가 발생하였습니다. 새로고침 후 재시도하십시오");
// 						break;
// 					}
				},
				error : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}

	}
}

var contractArray = $("#contractDesc").val().split(",");

function contractDel(no){
	contractArray[contractArray.indexOf(no.toString())] = 0;
	$("#contract_"+no).remove();
}

$(function(){

	$("#contractSelect").on("change", function(){
		var no = $(this).val();
		if (isNaN(no)) {
			return false;
		}

		if (contractArray.indexOf(no.toString()) > -1) {
			alert("이미 적용된 약관입니다.");
			return false;
		}
		var title = $(this).find("[value='"+$(this).val()+"']").html();
		$("#contractNameWrapper").attr("rowspan", ($("#contractNameWrapper").attr("rowspan")+1));
		var trHtml = "<tr class='contractName' id='contract_"+no+"' no='"+no+"'><td>"+title+
		"<span class='pull-right'>"+
			"<button type='button' class='btn btn-danger' onclick='contractDel("+no+")'>삭제</button>"+
		"</span></td>";
		contractArray.push(no);
		if ($(".contractName").length > 0 ) {
			$(".contractName").last().after(trHtml);
		} else {
			$("#contractNameWrapper").parent().after(trHtml);
		}

	});
});

//]]>
</script>