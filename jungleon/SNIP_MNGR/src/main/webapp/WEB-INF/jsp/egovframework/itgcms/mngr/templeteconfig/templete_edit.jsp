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
 * @파일명 : templete_edit.jsp
 * @파일정보 : 탬플릿관리 등록
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
	<div class="col-md-12">
		<div class="box">
			<!-- <div class="box-header with-border"><h3 class="box-title">Title</h3></div> -->
			<div class="box-body">
				<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;">
				<input type="hidden" name="act" id="act" value="<c:out value="${searchVO.act}"/>"/>
				<input type="hidden" name="tempIdx" id="tempIdx" value="<c:out value="${result.tempIdx}"/>"/>
				<input type="hidden" name="siteCode" value="${searchVO.siteCode}">
				<input type="hidden" name="tempName">
				<input type="hidden" name="recentBdCnt">
				<div class="row">
					<div class="col-xs-12 table-responsive">
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:75%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="tempCode">템플릿 선택</label></th>
									<td>
										<select name="tempCode" id="tempCode" title="템플릿 선택" class="required form-control input-sm f-wd-200" onchange="fn_setTemplete(this.value)">
											<option>템플릿 선택</option>
											<c:forEach var="templete" items="${templeteList }">
												<option value="<c:out value="${templete.code }" />" data-recentbdcnt="${templete.recentBdCnt}" ${ufn:selected(result.tempCode, templete.code) }><c:out value="${templete.title }" /></option>
											</c:forEach>
										</select>
									</td>
								</tr>
<%-- 								<tr>
									<th class="t"><label for="tempName">템플릿 이름</label></th>
									<td>
											<input type="text" name="tempName" id="tempName" maxlength="60" value="<c:out value="${result.tempName}"/>" class="required form-control input-sm f-wd-400" title="템플릿 이름" />
											<span class="help-block" style="margin-bottom:0;">템플릿을 알아볼 수 있는 이름. 예) 기본템플릿</span>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="tempCode">템플릿 코드</label></th>
									<td>
											<input type="text" name="tempCode" id="tempCode" maxlength="60" value="<c:out value="${result.tempCode}"/>" class="required form-control input-sm f-wd-400" title="템플릿 코드" />
											<span class="help-block" style="margin-bottom:0;">실제 템플릿 파일의 코드 입력. 예) 템플릿 파일명이 templete_a 일경우 'a'만 입력</span>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="recentBdCnt">최근글 영역 개수</label></th>
									<td>
											<input type="text" name="recentBdCnt" id="recentBdCnt" maxlength="60" value="<c:out value="${result.recentBdCnt}"/>" class="required form-control input-sm f-wd-400 validate-digits" onkeydown="return ItgJs.fn_numberOnly(event,this);" title="최근글 영역 개수" />
											<span class="help-block" style="margin-bottom:0;">숫자만 입력, 최근글을 표시할 게시판의 개수. 예) 5 </span>
									</td>
								</tr> --%>
								<tr>
									<th class="t"><label for="preViewImage">미리보기 이미지 안내</label></th>
									<td>
											<span class="help-block" style="margin:0;">템플릿 별 이미지 폴더에 위치 하며 자동 인식됨. <br/>파일명 : preView.jpg, preView_s.jpg(썸네일)</span>
									</td>
								</tr>
								<c:if test="${searchVO.act eq 'UPDATE' }">
									<tr>
										<th class="t"><span>등록자 아이디 / 등록일</span></th>
										<td><c:out value="${result.regmemid }" /> / <fmt:formatDate value="${result.regdt }" type="date" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									</tr>
									<c:if test="${not empty result.upddt }">
										<tr>
											<th class="t"><span>수정자 아이디 / 등록일</span></th>
											<td><c:out value="${result.updmemid }" /> / <fmt:formatDate value="${result.upddt }" type="date" pattern="yyyy-MM-dd HH:mm:ss" /></td>
										</tr>
									</c:if>
								</c:if>
							</tbody>
						</table>
					</div><!-- /.col -->
				</div><!-- /row -->
				<div class="box-footer">
					<div class="pull-right">
						<button  type="submit" value="" class="btn btn-primary">저장</button>
<c:if test="${searchVO.act == 'UPDATE' }">
						<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
</c:if>
						<a href="#none" onclick="fn_goList('${searchVO.siteCode}'); return false;" class="btn btn-default">목록</a>
					</div>
				</div>
				</form>
			</div> <!-- /box-body -->
		</div> <!-- /box -->
	</div> <!-- /col -->
</div> <!-- /row -->

<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	fn_setTemplete("${result.tempCode}");
});

/* 글 등록 function */
function fn_egov_save() {
	frm = document.form1;
	if(Validator.validate(frm)){
/* 		var message = Validator["validate-max-length"](frm.tempName.value,"템플릿 이름",'60');
		if(message) {alert(message);frm.tempName.focus();return false;}
		message = Validator["validate-max-length"](frm.tempCode.value,"템플릿 코드",'60');
		if(message) {alert(message);frm.tempCode.focus();return false;}
		message = Validator["validate-max-length"](frm.recentBdCnt.value,"최근글 영역 개수",'60');
		if(message) {alert(message);frm.recentBdCnt.focus();return false;} */
	  	frm.action = "<c:url value="${searchVO.act == 'REGIST' ? 'templete_input_proc.do' : 'templete_edit_proc.do'}"/>";
	    frm.submit();
	}
}
var queryString = "${searchVO.query}";

function fn_setTemplete(code){
	frm = document.form1;
	frm.tempName.value = $("option[value="+code+"]").text();
	frm.recentBdCnt.value = $("option[value="+code+"]").attr("data-recentbdcnt");

	console.log("################## title : "+frm.tempName.value);
	console.log("################## bbscnt : "+frm.recentBdCnt.value);
}

function fn_goList(siteCode){
	location.href="templete_list.do?" + ItgJs.fn_replaceQueryString(queryString, "siteCode", siteCode);
}

<c:if test="${searchVO.act == 'UPDATE' }">
function fn_goDel(){
	if(confirm("삭제하시겠습니까?")){
		var frm = document.form1;
		frm.encoding = "application/x-www-form-urlencoded";
		frm.action = "templete_delete_proc.do";
		frm.submit();
	}
}
</c:if>
//]]>
</script>
