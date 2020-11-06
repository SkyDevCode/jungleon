<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
				<div class="caution-box">
					<span class="caution-title">주의!</span>
					<span class="caution-content">사이트 삭제시 등록된 메뉴가 모두 삭제 됩니다.</span>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<table id="example1" class="table table-bordered">
							<colgroup>
								<col style="width:40%;">
								<col style="width:40%;">
								<col style="width:20%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">사이트 이름</th>
									<th scope="col">사이트 코드</th>
									<th scope="col">표출 순서</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td><a href="#none" onclick="fn_goView('<c:out value="${result.siteCode}" />');return false;"><c:out value="${result.siteName}" /></a></td>
										<td><c:out value="${result.siteCode}" /></td>
										<td><c:out value="${result.siteOrder}" /></td>
									</tr>
								</c:forEach>
								<c:if test="${fn:length(resultList ) == 0}">
									<tr><td colspan="2" class="tac">데이터가 없습니다.</td></tr>
								</c:if>
							</tbody>
						</table>
					</div> <!-- .col-sm-12 -->
				</div> <!--  .row -->
				<div class="row margin-bottom">
					<div class="col-sm-8 form-inline"></div>
					<div class="col-sm-4 text-right">
						<button type="button" onclick="fn_goRegist();" class="btn btn-primary">등록</button>
					</div>
				</div>
			</div> <!-- /box-body -->
		</div> <!-- /box -->
	</div> <!-- /col -->
</div> <!-- /row -->

<script type="text/javascript">
//<![CDATA[
    var queryString = "${searchVO.query}";

	/* 등록 화면 function */
	function fn_goRegist() {
		location.href="sitemng_input.do";
	}
	/* 글 수정 화면 function */
	function fn_goView(id) {
		location.href="sitemng_edit.do?" + ItgJs.fn_replaceQueryString(queryString, "id", id);
	}
//]]>
</script>
