<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

<script>
	function fn_save(){

		var msg = ItgJs.fn_checkPass($("#pass1").val(), $("#pass2").val());

		if ($("#curPass").val()=="") {
			msg = "현재 비밀번호를 입력해주세요.";
		}

		if (msg == "") {
			$.ajax({
				url : "/${siteCode}/module/${menuVO.menuCode}_updatePassword.ajax",
				data : $("#updatePassForm").serialize(),
				type : "POST",
				success : function(result){
					alert(result.msg);
					$("#curPass").val("");
					$("#pass1").val("");
					$("#pass2").val("");

					if (result.code == "200") {
						location.href="/${siteCode}/contents/${siteconfigVO.loginMenuCode}.do?code=out";
					}
				},
				 error: function (request, status, error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		} else {
			alert(msg);
		}

	}
</script>

<div class="fixwidth">
	<div class="userInfo">
		<form id="updatePassForm" onsubmit="return false;" method="post">
			<input type="hidden" name="id" value="${userId}"/>
			<div class="tableform">
				<table class="table_style2 mt30">
					<caption>회원정보</caption>
					<colgroup>
						<col width="23%" style="min-width:100px;">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th  class="th" scope="row"><label for="curPass">현재 비밀번호</label></th>
							<td>
								<p class="mb5"><input type="password" id="curPass" name="curPass" maxlength="20" class="solo" placeholder="현재 비밀번호" title="비밀번호" required="required"/></p>
							</td>
						</tr>
						<tr>
						<th class="th"><label for="pass">변경할 비밀번호</label></th>
						<td>
							<p class="mb5"><input type="password" id="pass1" name="pass1" maxlength="20" class="solo" placeholder="변경할 비밀번호"  title="비밀번호" required="required"/></p>
						</td>
					</tr>
					<tr>
						<th class="th"><label for="pass2">비밀번호 확인</label></th>
						<td>
							<input type="password" id="pass2" name="pass2" maxlength="20" class="solo" placeholder="비밀번호 확인" title="비밀번호 확인" required="required"/>
						</td>
					</tr>
					<tr>
						<th>&nbsp;</th>
						<td>
							<p class="mb5">※ 비밀번호는 영문 + 숫자 조합으로 8자리 이상</p>
							<p class="mb5">※ 일련번호, 전화번호 등 단순한 문자열은 포함하지 마십시오</p>
							<p>※ 잘 알려진 단어, 키보드 상에서 나란히 있는 문자열은 포함하지 마십시오</p>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</form>
		<div class="btn_wrap center">
			<a href="javascript:fn_save();" class="btn" role="button">수정</a>
		</div>
	</div>
</div>
