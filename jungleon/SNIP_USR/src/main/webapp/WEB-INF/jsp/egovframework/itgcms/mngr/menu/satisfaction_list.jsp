<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.exedit-3.5.js"></script>

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
				<form name="listForm" id="listForm" method="post" action="?">
				<div class="row margin-bottom">
					<div class="col-sm-8 form-inline">
						<label for="viewCount" class="sr-only">사이트 선택</label>
						<select name="schSitecode" id="schSitecode" class="form-control input-sm" onchange="document.listForm.submit();">
							<c:forEach var="site" items="${siteList }">
							<option value="<c:out value="${site.siteCode }" />" ${ufn:selected(searchVO.schSitecode, site.siteCode) }><c:out value="${site.siteName }" /></option>
							</c:forEach>
						</select>
					</div>
				</div>
				</form>
				<table id="example1" class="table table-bordered table-striped sati mainform">
					<colgroup>
						<col width="30%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">메뉴명</th>
							<th scope="col">매우만족</th>
							<th scope="col">다소만족</th>
							<th scope="col">보통</th>
							<th scope="col">다소불만족</th>
							<th scope="col">매우불만족</th>
							<th scope="col">점수 합계</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList }">
							<tr>
								<td><c:out value="${fn:substring(result.menuPfullname, 1, fn:length(result.menuPfullname))  }" /></td>
								<td><c:out value="${result.satis15 }" /></td>
								<td><c:out value="${result.satis14 }" /></td>
								<td><c:out value="${result.satis13 }" /></td>
								<td><c:out value="${result.satis12 }" /></td>
								<td><c:out value="${result.satis11 }" /></td>
								<td><c:out value="${result.answer1 }" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div> <!-- /box-body -->
		</div> <!-- /box -->
	</div> <!-- /col -->
</div> <!-- /row -->

<div class="modal" id="modalMenuSatisfaction">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="modal_menuName"></h4>
			</div>
			<div class="modal-body">
				<div id="managerList" class="managerList" style="margin-bottom:5px;">
					<table id="example1" class="table table-bordered table-striped sati">
						<colgroup>
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
							<col width="40%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">매우만족</th>
								<th scope="col">다소만족</th>
								<th scope="col">보통</th>
								<th scope="col">다소불만족</th>
								<th scope="col">매우불만족</th>
								<th scope="col">점수 합계</th>
								<th scope="col">의견</th>
							</tr>
						</thead>
						<tbody id="managerListTbody">
							<tr>
								<td colspan="7">&nbsp; </td>
							</tr>
						</tbody>
					</table>
					<div id="managerListMoreBtn" style="text-align:center;margin-top:10px; padding:10px;display:none;">
						<button type="button" class="btn btn-default btn-sm" onclick="fn_searManagerMore();">더보기</button>
					</div>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
function fn_viewSatisfaction(menuCode){
	$.ajax({
		url : "satisfaction_comm_opinion.ajax",
		data : "id=" + menuCode,
		dataType : "json",
		success : function(data){
			if(data.result.length > 0){
				$("#modal_menuName").text(data.result[0].menuName)
				var str = "";
				for(i = 0; i < data.result.length; i++){
					var result = data.result[i];
					str += "<tr>";
					str += "<td>" + result.satis15 + "</td>";
					str += "<td>" + result.satis14 + "</td>";
					str += "<td>" + result.satis13 + "</td>";
					str += "<td>" + result.satis12 + "</td>";
					str += "<td>" + result.satis11 + "</td>";
					str += "<td>" + result.answer1 + "</td>";
					str += "<td>" + result.answer6 + "</td>";
					str += "</tr>";
				}
				$("#managerListTbody").html(str);
				$("#modalMenuSatisfaction").modal("show");
			}else{
				alert("응답 데이터가 없습니다.");
			}
		}
	});
}
</script>
