<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<style>
.org_cont > section > h1 {
  position: relative;
  padding-left: 25px;
  font-size: 21px;
  font-weight: 500;
}
.org_cont > section > h1:before {
  content: "";
  display: block;
  width: 25px;
  height: 100%;
  background: url('/resource/common_adm/img/content-header-bg.png') 0 2px no-repeat;
  position: absolute;
  left: 0;
  top: 0;
}
.org_cont .colOpenBtn{
  margin-block-start: 1em;
  margin-block-end: 1em;
}
.moreBtn{
  width:100%;
}
</style>

	<input type="hidden" name="id" value="<c:out value="${result.mngId}" />" />
	<div class="row">
		<div class="col-xs-12 table-responsive">
			<div class="form-inline org_cont">
				<section class="form-group">
					<h1 class="form-group" style="margin-bottom:15px">${result.mngName}님</h1>
				</section>
			</div>
			<div id="colOpen" class="collapse in" aria-expanded="true">
				<table class="table table-bordered tp2">
					<colgroup>
						<col style="width:30%"/>
						<col style="width:70%"/>
					</colgroup>
					<tbody>
						<tr>
							<th class="t"><span>직위</span></th>
							<td>
								<select name="positionCode" id="positionCode" title="직위" class="form-control input-sm f-wd-200">
									<option value="">직위 선택</option>
									<c:forEach var="code" items="${positionList }">
										<option value="<c:out value="${code.ccode }" />" ${ufn:selected(result.positionCode, code.ccode )}><c:out value="${code.cname }" /></option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th class="t"><span>전화번호</span></th>
							<td>
								<input type="text" name="mngPhone" id="mngPhone" maxlength="16" value="<c:out value="${result.mngPhone}"/>" onkeydown="return ItgJs.fn_phone(event)" class="form-control input-sm f-wd-200 required" title="전화번호" />
							</td>
						</tr>
						<tr>
							<th class="t"><label for="tel">이메일</label></th>
							<td>
								<input type="text" name="mngEmail" id="mngEmail" maxlength="50" value="<c:out value="${ufn:seedDec256(result.mngEmail)}"/>" class="form-control input-sm f-wd-600 required validate-email" title="이메일주소" />
							</td>
						</tr>
						<tr>
							<th class="t"><span>담당업무</span></th>
							<td>
								<textarea name="mngWork" id="mngWork" class="form-control required" title="담당업무"><c:out value="${result.mngWork }" /></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="box-footer" style="margin-top:15px;">
				<div class="pull-right">
					<button  type="button" onclick="saveMemberInfo()" class="btn btn-primary">저장</button>
					<button type="button" onclick="hideInfomation()" class="btn btn-danger">닫기</button>
				</div>
			</div><!-- /.box-footer -->
		</div><!-- /.col -->
	</div>