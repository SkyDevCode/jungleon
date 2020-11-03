
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
 * @파일명 : mngrSlidesRegist.jsp
 * @파일정보 : 메인 슬라이드 셋 등록
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 4. 11. 최초생성
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
				<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;">
				<input type="hidden" name="act" id="act" value="<c:out value="${searchVO.act}"/>"/>
				<input type="hidden" name="slidesIdx" id="slidesIdx" value="<c:out value="${result.slidesIdx}"/>"/>
				<input type="hidden" name="siteCode" id="siteCode" value="<c:out value="${mngrSessionVO.currSiteCode}"/>"/>
				<div class="row">
					<div class="col-xs-12 table-responsive">
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:75%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="slidesName">슬라이드셋 이름</label></th>
									<td>
										<input type="text" name="slidesName" id="slidesName" maxlength="50" value="<c:out value="${result.slidesName}"/>" class="required form-control input-sm f-wd-400" title="슬라이드셋 이름" style="margin-right:10px;"/>
										<span class="help-block" style="display:inline-block;margin:0;">슬라이드 셋을 구별 할 수 있는 이름. 예) 아이티굿메인, 템플릿a용 등</span>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="slidesCode">슬라이드셋 코드</label></th>
									<td>
										<input type="text" name="slidesCode" id="slidesCode" maxlength="100" value="<c:out value="${result.slidesCode}"/>" onChange="return ItgJs.fn_engNumberOnly(this);" class="required form-control input-sm f-wd-400 validate-id-format" title="슬라이드셋 코드"  style="margin-right:10px;"/>
										<span class="help-block" style="display:inline-block;margin:0;">영문 코드 입력. 예) itgoodmain, templetea 등</span>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="useyn">사용여부</label></th>
									<td>
										<label><input type="radio" name="useyn" id="useyn1" class="required" title="사용여부" value="Y" ${ufn:checked(result.useyn, 'Y')} ${ufn:checked(result.useyn, '')} />사용</label>
						            	<label><input type="radio" name="useyn" id="useyn2" class="required" title="사용여부" value="N" ${ufn:checked(result.useyn, 'N')} />사용 안함</label>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="itemImage">슬라이드 개별 이미지 추가</label></th>
									<td>
											<span class="help-block" style="margin:0;">목록 화면에서 <i class="fa  fa-plus-square-o"></i>아이콘을 클릭하여 추가 </span>
									</td>
								</tr>
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
						<a href="#none" onclick="fn_goList(); return false;" class="btn btn-default">목록</a>
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
	});

	/* 글 등록 function */
	function fn_egov_save() {
		frm = document.form1;

		if(Validator.validate(frm)){
		  	frm.action = "<c:url value="${searchVO.act == 'REGIST' ? 'slides_input_proc.do' : 'slides_edit_proc.do'}"/>";
		    frm.submit();
		}
	}

	function fn_goList(){
		location.href="slides_list.do"
	}

	<c:if test="${searchVO.act == 'UPDATE' }">
	function fn_goDel(){
		if(confirm("삭제하시겠습니까?")){
			var frm = document.form1;
			frm.encoding = "application/x-www-form-urlencoded";
			frm.action = "slides_delete_proc.do";
			frm.submit();
		}
	}
	</c:if>
//]]>
</script>

