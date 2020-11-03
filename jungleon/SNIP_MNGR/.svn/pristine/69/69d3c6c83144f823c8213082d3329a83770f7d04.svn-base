<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>

<script type="text/javascript">
$(function(){
	if(collapseStat == true){
		if($("#colOpen").hasClass("in") === true){
			return false;
		}
		else{
			$("#colOpen").addClass("in");
		}
	}
	else{
		if($("#colOpen").hasClass("in") === true){
			$("#colOpen").removeClass("in");
		}
		else{
			return false;
		}
	}
});
function fn_modalOpenManager(groupCode){
	$("#modalManagerContent").modal("show");
	if(oldModalManagerContent == "") oldModalManagerContent = $("#modalManagerContent").html();
	else $("#modalManagerContent").html(oldModalManagerContent);
	document.managerForm.groupCode.value = groupCode;
	fn_searchManager(1);
}

var oldModalManagerContent = "";
var searchManagerPage = 1; //더보기용 페이지 저장
function fn_searManagerMore(){ //더보기용 페이지 증가
	searchManagerPage++;
	fn_searchManager(searchManagerPage);
}

function fn_searchManager(page){//검색결과 조회
	searchManagerPage = page;
	var dataStr = "groupCode="+document.managerForm.groupCode.value+"&schFld="+$("#schFld").val()+"&schStr="+encodeURIComponent($("#schManagerStr").val())+"&page="+page;

	$.ajax({
		url:"${menuCode}_list_organization_allManager.ajax",
		data : dataStr,
		dataType : "json",
		async : false,
		success : function(data){
			str = "";
			var color = (page % 2 == 0)? "#fafafa":"#fafaff";
			for(i = 0; i < data.result.length; i++){
				str += "<tr>";
				str += "<td class='tac'><input type=\"checkbox\" name=\"chkMngId\" title=\"\" onclick=\"\" value=\""+data.result[i].mngId+"\"/></td>";
				str += "<td class='tac'>"+data.result[i].mngId+"</td>";
				str += "<td class='tac'>"+data.result[i].mngName+"</td>";
				str += "<td class='tac'>"+data.result[i].orName+"</td>";
				str += "<td class='tac'>"+data.result[i].cName+"</td>";
				str += "<td class='tac'>"+data.result[i].mngPhone+"</td>";
				str += "</tr>";
			}
			if(str == ""){
				str = "<tr><td colspan='6' class='tac'>검색 결과가 없습니다.</td></tr>";
				searchManagerPage = 0;
			}
			if(parseInt(data.currentPage) < parseInt(data.totalPage)){ // 페이지 더 있으면 더보기 버튼 보여줌
				$("#managerListMoreBtn").show();
				$("#managerListMoreBtn").text(data.currentPage +"/"+ data.totalPage + " 더보기");
			}else{
				$("#managerListMoreBtn").hide();
				$("#managerListMoreBtn").text("더보기");
			}
			if(page == 1){ // 첫페이지는 지우고 출력
				$("#managerListTbody").html(str);
			}else{ // 2페이지 이상은 추가
				$("#managerListTbody").append(str);
			}
		}
		, error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function fn_registManagerOrgAll(){
	if($("input[name=chkMngId]:checked:enabled").size() == 0){alert('부서에 추가할 관리자를 선택 해 주세요.'); return false;}
	if(confirm("선택된 관리자(들)일괄 추가 하시겠습니까?")){
		var frm = document.managerForm;
		var strData = $("#managerForm").serialize();
		$.ajax({
			url : "${menuCode}_input_organization_mngGroup.ajax"
			, data : strData
			, type : "post"
			, dataType : "json"
			, async : false
			, success : function(data){
				if(data.result == "1"){
					alert("추가가 완료 되었습니다.");
					$("#modalManagerContent").modal("hide");
					page = 1;
					fn_load('VIEW', '${orgResult.orCode}');
					return false;
				}else if(data.result == "2"){
					alert("추가할 관리자를 선택 해 주세요.");
					return false;
				}else{
					alert("처리중 오류가 발생했습니다. 다시 시도해 주세요");
					return false;
				}
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
}

function fn_deleteManagerOrgAll(){
	if($("input[name=chkId]:checked:enabled").size() == 0){alert('부서에서 제외할 관리자를 선택 해 주세요.'); return false;}
	if(confirm("선택된 관리자(들)일괄 제외 하시겠습니까?")){
		var frm = document.managerOrgForm;
		var strData = $("#managerOrgForm").serialize();
		$.ajax({
			url : "${menuCode}_delete_organization_mngGroup.ajax"
			, data : strData
			, type : "post"
			, dataType : "json"
			, async : false
			, success : function(data){
				if(data.result == "1"){
					alert("제외가 완료 되었습니다.");
					$("#modalManagerContent").modal("hide");
					page = 1;
					fn_load('VIEW', '${orgResult.orCode}');
					return false;
				}else if(data.result == "2"){
					alert("제외할 관리자를 선택 해 주세요.");
					return false;
				}else{
					alert("처리중 오류가 발생했습니다. 다시 시도해 주세요");
					return false;
				}
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
}

function fn_egov_link_page(num){
	page = num;
	fn_load('VIEW', '${orgResult.orCode}');
}

function collapseStatus(){
	if(collapseStat == true){
		collapseStat = false;
	}
	else{
		collapseStat = true;
	}
}

function fn_orderCngSave() {
	var managerList = fn_getJsonEntry();
	console.log(managerList);
	if(managerList.length == 0){alert('순서를 변경할 관리자가 없습니다.'); return false;}
	if(confirm("순서 변경 내역을 저장 하시겠습니까?")){

		$.ajax({
			url : "${menuCode}_edit_organization_mngOrder.ajax"
			, data : "managerList="+managerList
			, type : "post"
			, dataType : "json"
			, async : false
			, success : function(data){
				if(data.result == "1"){
					alert("저장이 완료 되었습니다.");
					return false;
				}else if(data.result == "2"){
					alert("순서를 변경할 관리자가 없습니다.");
					return false;
				}else{
					alert("처리중 오류가 발생했습니다. 다시 시도해 주세요");
					return false;
				}
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
}

function fn_getJsonEntry(){
	var entryList = new Array();

	$(".manager_list").each(function(index){
		var mngId = $(this).find("input[name=mngId]").val();
		var entryInfo = new Object();
		entryInfo.order = index;
		entryInfo.mngId = mngId;
		entryList.push(entryInfo);
	});

	if(entryList.length > 0){
		return JSON.stringify(entryList);
	}else{
		return "";
	}
}

function moveUpOrder(el){
	var $tr = $(el).parent().parent(); // 클릭한 버튼이 속한 tr 요소
	$tr.prev().before($tr); // 현재 tr 의 이전 tr 앞에 선택한 tr 넣기
	orderReset();
}

function moveDownOrder(el){
	var $tr = $(el).parent().parent(); // 클릭한 버튼이 속한 tr 요소
	$tr.next().after($tr); // 현재 tr 의 다음 tr 뒤에 선택한 tr 넣기
	orderReset();
}

function orderReset(){
	$(".manager_list").each(function(index){
		$(this).find(".group_order").text(index+1);
	});
}
</script>
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

	<input type="hidden" name="orCode" value="<c:out value="${orgResult.orCode}" />" />
	<div class="row">
		<div class="col-xs-12 table-responsive">
			<div class="form-inline org_cont">
				<section class="form-group">
					<h1 class="form-group" style="margin-bottom:15px">부서 기본 정보</h1>
				</section>
			<button type="button" class="btn btn-primary pull-right colOpenBtn" data-toggle="collapse" onclick="collapseStatus()" data-target="#colOpen" aria-expanded="true">접기/펴기</button>
			</div>
			<div id="colOpen" class="collapse in" aria-expanded="true">
				<table class="table table-bordered tp2">
					<colgroup>
						<col style="width:15%"/>
						<col style="width:35%"/>
						<col style="width:15%"/>
						<col style="width:35%"/>
					</colgroup>
					<tbody>
						<tr>
							<th class="t"><span>부서 코드 </span></th>
							<td>
								<c:out value="${orgResult.orCode }" />
							</td>
							<th class="t"><label for="tel">부서명</label></th>
							<td>
								<c:out value="${orgResult.orName}" escapeXml="false" />
							</td>

						</tr>
						<tr>
							<th class="t"><label for="tel">부서 전화</label></th>
							<td>
								<c:out value="${orgResult.orTel}" />
							</td>
							<th class="t"><label for="tel">부서 팩스</label></th>
							<td>
								<c:out value="${orgResult.orFax}" />
							</td>
						</tr>
						<tr>
							<th class="t"><label for="exp1">부서 소개</label></th>
							<td colspan="3">
								<c:out value="${ufn:stripXss(orgResult.orMemo)}" escapeXml="false" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div><!-- /.col -->
		<div class="col-xs-12 table-responsive">
			<div class="form-inline org_cont">
				<section class="form-group">
					<h1 class="form-group" style="margin-bottom:15px">부서 소속 관리자</h1>
				</section>
			<button type="button" class="btn btn-danger pull-right colOpenBtn" style="margin-right:3px" onclick="fn_deleteManagerOrgAll()">관리자 삭제</button>
			<button type="button" class="btn btn-primary pull-right colOpenBtn" style="margin-right:3px" onclick="fn_modalOpenManager('<c:out value="${orgResult.orCode}" />');">관리자 추가</button>
			<button type="button" class="btn btn-info pull-right colOpenBtn" style="margin-right:3px" onclick="fn_orderCngSave()">순서변경 저장</button>
			</div>
			<div>
				<form name="managerOrgForm" id="managerOrgForm" method="post" action="">
				<table class="table table-bordered tp2">
					<colgroup>
						<col style="width:5%;align:center;"/>
						<col style="width:5%;"/>
						<col style="width:10%;"/>
						<col style="width:10%;"/>
						<col style="width:10%;"/>
						<col style="width:10%;"/>
						<col />
						<col style="width:10%;"/>
					</colgroup>
					<thead>
						<tr style="text-align:center;font-weight:bold;">
							<th><input type="checkbox" name="chkall" id="chkAll" onclick="ItgJs.fn_checkAll(this, 'chkId')" title="전체선택" /></td>
							<th>번호</td>
							<th>아이디</td>
							<th>이름</td>
							<th>전화번호</td>
							<th>직급</td>
							<th>담당업무</td>
							<th>순서</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${mngResult}" varStatus="status">
						<tr class="manager_list">
							<td style="text-align:center;"><input type="checkbox" name="chkId" id="chkId" value="<c:out value="${result.mngId }" />" title="전체선택" /></td>
							<td style="text-align:center;" class="group_order"><c:out value="${status.count }" /></td>
							<td style="text-align:center;"><c:out value="${result.mngId }" /><input type="hidden" name="mngId" value="${result.mngId }"/></td>
							<td style="text-align:center;">
								<a href="#" onclick="showInfomation('${result.mngId }');"><c:out value="${result.mngName }" /></a>
							</td>
							<td style="text-align:center;"><c:out value="${result.mngPhone }" /></td>
							<td style="text-align:center;"><c:out value="${result.cName }" /></td>
							<td style="word-break:break-all;white-space:pre-line;"><c:out value="${result.mngWork}" /></td>
							<td style="text-align:center;">
								<button type="button" class="btn" onclick="moveUpOrder(this)">▲</button>
								<button type="button" class="btn" onclick="moveDownOrder(this)">▼</button>
							</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(mngResult) == 0}">
							<tr><td colspan="8" class="tac">관리자가 없습니다.</td></tr>
						</c:if>
					</tbody>
				</table>
				</form>
			</div>
			<div class ="row">
				<div class="col-sm-5 text-left">
					<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">총 페이지 : <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
				</div>
				<div class="col-sm-7">
					<div class="text-center dataTables_paginate paging_simple_numbers" id="example1_paginate">
						<ul class="pagination">
							<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
						</ul>
					</div>
				</div>

			</div>
		</div><!-- /.col2 -->
	</div>
</form>

<div class="modal mnauthgroupListModal" id="modalManagerContent">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">관리자 목록</h4>
			</div>
			<div class="modal-body">
				<div class="form-inline" style="margin-bottom:30px;">
					<select name="schFld" id="schFld" class="form-control input-sm">
						<option value="0">전체</option>
						<option value="1">아이디</option>
						<option value="2">이름</option>
						<option value="3">부서명</option>
					</select>
					<input name="schManagerStr" id="schManagerStr" class="form-control input-sm" title="검색어 입력" onkeydown="if(ItgJs.fn_isEnter(event)) fn_searchManager(1);" />
					<button type="button" class="btn btn-default btn-sm btn-sm-search" style="margin-right:20px;" onclick="fn_searchManager(1);">검색</button>
				</div>
				<form name="managerForm" id="managerForm" method="post" action="">
					<input type="hidden" name="groupCode" />

					<table class="table table-bordered table-organ">
			        	<colgroup>
							<col style="width:5%"/>
							<col style="width:15%"/>
							<col style="width:15%"/>
							<col style="width:30%"/>
							<col style="width:15%"/>
							<col style="width:20%"/>
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><input type="checkbox" name="chkall" id="chkAll" onclick="ItgJs.fn_checkAll(this, 'chkMngId')" title="전체선택" /></th>
								<th scope="col">아이디</th>
								<th scope="col">이름</th>
								<th scope="col">부서명</th>
								<th scope="col">직급</th>
								<th scope="col">전화번호</th>
							</tr>
						</thead>
						<tbody id="managerListTbody">
							<tr>
								<td colspan="6" class="tac">&nbsp; </td>
							</tr>
						</tbody>
					</table>
				</form>
				<div>
					<button type="button" id="managerListMoreBtn" class="btn btn-default moreBtn" onclick="fn_searManagerMore();">더보기</button>
				</div>
				<div style="text-align:center;margin-top:10px; padding:10px;">
					<button type="button" class="btn btn-primary" onclick="fn_registManagerOrgAll();">관리자 추가</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close">닫기</button>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
