
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
 * @파일명 : snsConfig_view.jsp
 * @파일정보 : 소셜페이지 설정
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
<!-- Content Wrapper. Contains page content -->
        <!-- Content Header (Page header) -->
        <!-- Main content -->
        <section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box">
						<!-- <div class="box-header with-border"><h3 class="box-title">Title</h3></div> -->
						<div class="box-body">
							<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;">
							<input type="hidden" name="siteCode" value="${siteCode}">
							<input type="hidden" name="menuCode" value="<c:out value="${urlInfo.menuCode}" />" />
							<input type="hidden" name="progIdx" value="<c:out value="${urlInfo.menuSubType }" />" />
							<input type="hidden" name="smNum" value="${smNum}">
							<div class="row">
								<div class="col-xs-12 table-responsive">
									<table class="table table-bordered tp2">
										<colgroup>
											<col style="width:15%"/>
											<col style="width:20%"/>
											<col style="width:15%"/>
											<col style="width:45%"/>
										</colgroup>
										<tbody>
											<!-- SNS페이지 관리 -->
											<tr>
												<th class="t"><label for="tempCode">SNS페이지 폼 선택</label></th>
												<td colspan="3">
													<div id="formCode" class="form-group" style="margin-bottom:0px">
														<input type="radio" name="formCode" class="minimal" value="sns1" ${ufn:checked(snsconfigVO.formCode, 'sns1') }><label>A형</label>
								                    	<input type="radio" name="formCode" class="minimal" value="sns2" ${ufn:checked(snsconfigVO.formCode, 'sns2') }><label>B형</label>
													</div>
												</td>
											</tr>
											<c:forEach var="result" items="${resultList}" varStatus="i">
											<input type="hidden" name="smkeyIdx${i.count}" value="${result.smkeyIdx}">
											<input type="hidden" name="smproIdx${i.count}" value="${ufn:isNull(result.smproIdx, '')}">
												<tr class="smList">
												<th class="t"><c:out value="${result.smName}" /></th>
													<td>
														<label style="margin-right:40px">
															<input type="radio" class="flat-green" name="useyn${i.count}" value="Y" ${ufn:checked(result.useyn, 'Y') }/><label>사용</label>
														</label>
														<label>
										            		<input type="radio" class="flat-green" name="useyn${i.count}" value="N" ${ufn:checked(result.useyn, 'N') }/><label>미사용</label>
										            	</label>
													</td>
													<td>
											        	<div id="accountId" class="form-group" style="margin-bottom:0px">${result.accountId}</div>
													</td>
													<td>
											        	<div id="promText" class="form-group" style="margin-bottom:0px">
											            	<input type="text" name="promText${i.count}" value="${result.promText}" maxlength="60" class="form-control input-sm f-wd-500" placeholder="홍보문구">
											            </div>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div><!-- /.col -->
							</div><!-- /row -->
							<div class="box-footer">
                  				<div class="pull-right">
									<button  type="submit" value="" class="btn btn-primary btn-sm">저장</button>
                  				</div>
                  			</div>
							</form>
						</div> <!-- /box-body -->
					</div> <!-- /box -->
				</div> <!-- /col -->
			</div> <!-- /row -->
        </section><!-- /.content -->

<script type="text/javascript">
//<[[!CDATA[
/* 글 등록 function */
function fn_egov_save() {
	frm = document.form1;
	if(Validator.validate(frm)){
		frm.smNum.value = $(".smList").length;
	  	frm.action = "/_mngr_/module/${menuCode}_edit_snsConfig_proc.do";
	    frm.submit();
	}
}
//]]>
</script>

