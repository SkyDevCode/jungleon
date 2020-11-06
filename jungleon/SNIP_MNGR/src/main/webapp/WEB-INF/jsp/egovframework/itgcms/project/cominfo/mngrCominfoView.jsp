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

<%
/**
 * @파일명 : userCominfoView.jsp
 * @파일정보 : 관리자 성남기업소개 > 성남기업 및 상품소개 > 기업정보 조회
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 4. 8. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<head>
<script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
</head>

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
				<div class="body-header">
					<div class="pull-right margin-bottom" id="headerButtons"></div>
					<script>$(function(){$("#headerButtons").html($("#footerButtons").html())})</script>
				</div>
				<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;">
					<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld }" />" />
					<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr }" />" />
					<input type="hidden" name="page" value="<c:out value="${searchVO.page }" />" />
					<input type="hidden" name="ordFld" value="<c:out value="${searchVO.ordFld }" />" />
					<input type="hidden" name="ordBy" value="<c:out value="${searchVO.ordBy }" />" />
					<input type="hidden" name="schId" value="<c:out value="${searchVO.schId}" />" />
						<div class="row">
							<div class="col-xs-12 table-responsive">
								<table class="table table-bordered tp2">
									<colgroup>
										<col style="width:15%"/>
										<col style="width:35%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="t"><label for="comNm">회사명</label></th>
											<td>
												<input type="text" name="comNm" id="comNm" class="required form-control input-sm f-wd-600" value="<c:out value="${result.comNm }"/>" maxlength="50" title="제목" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="zip">회사주소</label></th>
											<td>
												<input type="text" name="zip" id="zip" maxlength="6" value="<c:out value="${result.zip}"/>"  style="display:inline-block" title="우편번호" class="form-control input-sm f-wd-100 required" readonly="readonly" />
												<button type="button" class="btn btn-default btn-sm" onclick="ItgJs.getDaumAddressStreet({zip:'zip',addr1:'addr01',addr2:'addr02'});">우편번호 찾기<!-- [다음(레이어)] --></button>
												<input type="text" name="addr01" id="addr01" class="required form-control input-sm f-wd-600" value="<c:out value="${result.addr01 }"/>" maxlength="50" title="회사주소" readonly="readonly"/>
												<input type="text" name="addr02" id="addr02" class="required form-control input-sm f-wd-600" value="<c:out value="${result.addr02 }"/>" maxlength="50" title="회사 상세주소" />
											</td>
										</tr>
										<tr>
											<th class="t">기업분류</th>
											<td>
												<label><input type="radio" name="comTp" id="comTp1" value="V006000001" ${ufn:checked(result.comTp, 'V006000001')}> 개인기업</label>
												<label><input type="radio" name="comTp" id="comTp2" value="V006000002" ${ufn:checked(result.comTp, 'V006000002')}> 법인기업</label>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="comNm">산업분류</label></th>
											<td>
												<input type="hidden" name="unCd" id="unCd" value="<c:out value="${result.unCd }" />" />
												<span id="unNm"><c:out value="${result.unNm }" /></span>
												<button type="button" class="btn btn-default btn-sm" onclick="fn_showKsicSearchLayer();" style="margin-left: 10px;">산업분류 검색</button>
											</td>
										</tr>
										<tr>
											<th class="t"><label for="mainProduct">주요제품</label></th>
											<td>
												<input type="text" name="mainProduct" id="mainProduct" class="form-control input-sm f-wd-600" value="<c:out value="${result.mainProduct }" />" maxlength="50" title="주요제품" />
											</td>
										</tr>
										<tr>
											<th class="t"><label for="officeTel01">회사 전화번호</label></th>
											<td>
												<select name="officeTel01" id="officeTel01" class="required form-control f-wd-100" style="display: inline-block;" title="회사 전화번호 국번"></select>
												<input type="text" name="officeTel02" id="officeTel02" class="required form-control input-sm f-wd-100" style="display: inline-block;" value="<c:out value="${result.officeTel02 }" />" maxlength="4" title="회사 전화번호 앞자리" />
												<input type="text" name="officeTel03" id="officeTel03" class="required form-control input-sm f-wd-100" style="display: inline-block;" value="<c:out value="${result.officeTel03 }" />" maxlength="4" title="회사 전화번호 뒷자리" />
												
											</td>
										</tr>
										<tr>
											<th class="t"><label for="faxNo01">회사 팩스번호</label></th>
											<td>
												<select name="faxNo01" id="faxNo01" class="form-control f-wd-100" style="display: inline-block;"  title="회사 팩스번호 국번"></select>
												<input type="text" name="faxNo02" id="faxNo02" class="form-control input-sm f-wd-100" style="display: inline-block;" value="<c:out value="${result.faxNo02 }" />" maxlength="4" title="회사 팩스번호 앞자리" />
												<input type="text" name="faxNo03" id="faxNo03" class="form-control input-sm f-wd-100" style="display: inline-block;" value="<c:out value="${result.faxNo03 }" />" maxlength="4" title="회사 팩스번호 뒷자리" />
												
											</td>
										</tr>
										<tr>
											<th class="t"><label for="hPage">회사 홈페이지</label></th>
											<td>
												<input type="text" name="hPage" id="hPage" class="form-control input-sm f-wd-600" value="<c:out value="${result.hPage }" />" maxlength="50" title="회사 홈페이지" />
											</td>
										</tr>
									</tbody>
								</table>
							</div><!-- /.col -->
						</div><!-- /inner row -->
					</form>
					<div class="body-footer" id="footerButtons">
						<div class="pull-right">
								<button type="button" onclick="fn_egov_save(); return false;" class="btn btn-primary">수정</button>
								<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
								<button type="button" onclick="fn_goList(); return false;" class="btn btn-default">목록</button>
						</div>
					</div><!-- /.body-footer -->
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="daumPostLayer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer"
	     style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="ItgJs.getDaumAddressLayerClose()" alt="닫기 버튼">
</div>
<div class="modal " id="ksicSearchLayer">
  <div class="modal-dialog " style="width: 1300px;">
  <div class="modal-content">
    <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="fn_closeModal();"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title">산업분류 검색</h4>
    </div>
    <div class="modal-body">
    	<div class="row margin-bottom">
					<div class="col-sm-12 form-inline text-right">
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schKsicStr" id="schKsicStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" onkeydown="if(ItgJs.fn_isEnter()) fn_ksicSearch();" title="코드, 산업분류 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search" onclick="fn_ksicSearch();">검색</button>
					</div>
				</div>
    	<div class="modalScr" style="">
        <table id="example1" class="table table-bordered tac">
            <colgroup>
          <col width="20%" />
          <col width="80%" />
        </colgroup>
        <thead>
          <tr>
            <th scope="col">산업분류 코드</th>
            <th scope="col">산업분류 명</th>
          </tr>
        </thead>
        <tbody id="ksicSearchLayerBody">
          <tr>
            <td colspan="2" class="tac">산업분류 코드 또는 산업분류 명을 입력해 주세요.</td>
          </tr>
        </tbody>
        </table>
      </div>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="fn_closeModal();">닫기</button>
    </div>
  </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script type="text/javascript">
//<[[!CDATA[
$(document).ready(function(){
	ItgJs.selectBoxLocalNumber($("#officeTel01").attr("id"), "");
	ItgJs.selectBoxLocalNumber($("#faxNo01").attr("id"), "");
	
	var officeTel01 = "<c:out value="${fn:split(result.officeTel01,'-')[0]}"/>";
	if(officeTel01){
		$('#officeTel01> option[value='+officeTel01+']').prop("selected", true);
	}
	var faxNo01 = "<c:out value="${fn:split(result.faxNo01,'-')[0]}"/>";
	if(faxNo01){
		$('#faxNo01> option[value='+faxNo01+']').prop("selected", true);
	}
});
var query = "<c:out value="${searchVO.query}" escapeXml="false" />";

/* 목록 이동 function */
function fn_goList(){
	query = ItgJs.fn_replaceQueryString(query, "schId", "");
	query = ItgJs.fn_replaceQueryString(query, "schM", "list");
	location.href="/_mngr_/module/${menuCode}_mngrCominfoList.do?" + query;
}

function fn_showKsicSearchLayer() {
	$("#ksicSearchLayer").modal('show');
}

function fn_ksicSearch() {
	if($("#schKsicStr").val() == "") {
		alert("산업분류 코드 또는 산업분류 명을 입력해 주세요");
		return false;
	}
	$.ajax({
		url: "/_mngr_/module/${menuCode}_mngrKsicSearch.ajax",
		data: "schStr="+ $("#schKsicStr").val(),
		type: "post",
		dataType: "json",
		success: function(resultData) {
			if(resultData.result == "1") {
				var html = "";
				for(var i = 0; i < resultData.data.length; i++ ) {
					html += "<tr>";
					html += "<td>";
					html += resultData.data[i].ksicCd
					html += "</td>";
					html += "<td><a href='#' onclick=\"fn_setKsic('" + resultData.data[i].ksicCd + "','" + resultData.data[i].ksicNm + "')\">";
					html += resultData.data[i].ksicNm
					html += "</a></td>";
					html += "</tr>";
				}
				if(resultData.data.length == 0){
					html = "<tr><td colspan='2'>데이터가 없습니다.</td></tr>";
				}
				$("#ksicSearchLayerBody").html(html);
			} else {
				alert(resultData.message);
				return;
			}
		},
		error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function fn_setKsic(cd, nm) {
	if(confirm("선택하신 산업분류[" + nm + "]를 적용하시겠습니까?")) {
		$("#unCd").val(cd);
		$("#unNm").text(nm);
		$("#ksicSearchLayer").modal('hide');
	}
}


function fn_egov_save(){
	var frm = document.form1;
	if(Validator.validate(frm)){
		if(frm.unCd.value == "") {
			alert("산업분류를 선택해 주세요");
			return false;
		}
		
		if(confirm("수정하시겠습니까?")) {
			frm.action="/_mngr_/module/${menuCode}_mngrCominfoUpdateProc.do"
			frm.submit();
		}
		
	}
}

function fn_goDel(){
	var frm = document.form1;
	if(confirm("삭제하시겠습니까?")) {
		frm.action="/_mngr_/module/${menuCode}_mngrCominfoDeleteProc.do"
		frm.submit();
	}
}

//]]>
</script>