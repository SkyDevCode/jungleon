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
 * @파일명 : contract.jsp
 * @파일정보 : 약관관리 컨텐츠 관리자 페이지
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 6. 4. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

<script type="text/javascript">
//<![CDATA[

function fn_save(){
	var frm = document.form1;

	var contractNo = "";

	if ($(".contractName").length > 0) {
		$(".contractName").each(function(){
			contractNo += $(this).attr("no")+",";
		});
	} else {
		alert("약관은 반드시 한개 이상 선택되어야 합니다.");
		return false;
	}

	$("#contractNo").val(contractNo.substring(0,contractNo.length-1)); //끝의 '콤마(,)' 제거

	if(Validator.validate(frm)){
		$.ajax({
			url : "/_mngr_/module/${menuCode}_edit_contract_proc.ajax"
			, data : $("#form1").serialize()
			, dataType : "json"
			, type : "post"
			, success : function(data){
				if(data == 401){
					alert("해당 권한이 없습니다.");
					return false;
				}else if(data.result == 0){
					alert(data.message); //alert("데이터 저장 중 오류가 발생했습니다. 다시 시도해 주세요");
					return false;
				}else if(data.result == 1){
					alert("저장 되었습니다.");
					//refreshNode();
				}else if(data.result == 2){
					alert(data.message); //alert("코드가 중복 되었습니다. 확인 후 다시 시도해 주세요");
					return false;
				}
				console.log(data);

			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
}

$(function(){
	var form1 = $("#form1").serialize();
	$.ajax({
		 dataType: "json",
	     url:"/_mngr_/module/${menuCode}_comm_contractListByMenu.ajax",
	     data: form1,
	     success:function(data){
	    	 console.log(data.contractResultList);
	    	 if(data.contractResultList){
		    	 var list = data.contractResultList;
		    	 var contractNo = data.contractNo;
		    	 var str = "";
		    	 $(list).each(function (index, item) {
		    		str += "<tr class=\"contractName\" id=\"contract_" + item.no  + "\" no=\"" + item.no  + "\">\r\n" +
		    		"							<td>" + item.title  + "&nbsp;&nbsp;\r\n" +
		    		"								<span class=\"pull-right\">\r\n" +
		    		"									<button type=\"button\" class=\"btn btn-danger btn-sm\" onclick=\"contractDel('" + item.no  + "')\">삭제</button>\r\n" +
		    		"								</span>\r\n" +
		    		"							</td>\r\n" +
		    		"						</tr>";
		    	 });
				 $("#contractNo").val(contractNo);
		    	 $("#contractNameWrapper").attr("rowspan", list.length+1);
		    	 $('#contractTb > tbody:first').append(str);
	    	 }
	      },
			error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
	});
});

//]]>
</script>
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
<form name="form1" id="form1" method="post" onsubmit="fn_save(); return false;">
	<input type="hidden" name="menuCode" value="<c:out value="${urlInfo.menuCode}" />" />
	<input type="hidden" name="progIdx" value="<c:out value="${urlInfo.menuSubType }" />" />
	<input type="hidden" name="contractNo" id="contractNo" value="" />
	<div class="row">
		<div class="col-xs-12 table-responsive">
<%-- 			<table class="table table-bordered tp2">
				<colgroup>
					<col style="width:25%"/>
					<col style="width:75%"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="t">메뉴코드</th>
						<td><c:out value="${menuCode}" /></td>
					</tr>
					<tr>
						<th class="t">프로그램ID</th>
						<td><c:out value="${progIdx}" /></td>
					</tr>
					<tr>
						<th class="t"><label for="tel">약관선택</label></th>
						<td>
							<select name="contractNo" id="contractNo" class="required form-control input-sm f-wd-200" title="약관선택" >
				        		<option value="">약관선택</option>
				        		<c:forEach var="list" items="${contractList }">
				        			<option value="${list.no }" ${ufn:selected(result.contractNo,list.no) }><c:out value="${list.title }" /></option>
				        		</c:forEach>
					        </select>
						</td>
					</tr>
				</tbody>
			</table> --%>

			<table id="contractTb" class="table table-bordered table tp2">
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: 90%;" />
				</colgroup>
				<tbody>
					<tr>
						<th class="t">메뉴코드</th>
						<td><c:out value="${urlInfo.menuCode}" /></td>
					</tr>
					<tr>
						<th class="t">프로그램ID</th>
						<td><c:out value="${urlInfo.menuSubType}" /></td>
					</tr>
					<tr>
						<th id="contractNameWrapper" rowspan="${fn:length(contractResultList)+1}" style="text-align: center; vertical-align: middle; background-color: #FAFAFA;">
							약관<br />정보
						</th>
						<td>
							<select class="form-control" id="contractSelect">
								<option value="none">약관 추가</option>
								<c:forEach items="${contractList}" var="cont">
									<option value="${cont.no}">${cont.title}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<%-- <c:forEach var="contract" items="${list}" varStatus="stat">
						<tr class="contractName" id="contract_${contract.no}" no="${contract.no}">
							<td>${contract.title}&nbsp;&nbsp;
								<span class="pull-right">
									<button type="button" class="btn btn-danger btn-sm" onclick="contractDel('${contract.no}')">삭제</button>
								</span>
							</td>
						</tr>
					</c:forEach> --%>
					</tbody>
				</table>

		</div><!-- /.col -->

	</div>
	<button type="submit" class="btn btn-primary pull-right">저장</button>
</form>
			</div> <!-- /box-body -->
		</div> <!-- /box -->
	</div> <!-- /col -->
</div> <!-- /row -->

<script type="text/javascript">
//<[[!CDATA[

function contractDel(no){
	var contractArray = $("#contractNo").val().split(",");
	contractArray[contractArray.indexOf(no.toString())] = 0;
	$("#contract_"+no).remove();
}

$(function(){
	$("#contractSelect").on("change", function(){
		var no = $(this).val();
		if (isNaN(no)) {
			return false;
		}

		var contractArray = $("#contractNo").val().split(",");
		if (contractArray.indexOf(no.toString()) > -1) {
			alert("이미 적용된 약관입니다.");
			return false;
		}

		var title = $(this).find("[value='"+$(this).val()+"']").html();
		$("#contractNameWrapper").attr("rowspan", ($("#contractNameWrapper").attr("rowspan")+1));
		var trHtml = "<tr class='contractName' id='contract_"+no+"' no='"+no+"'><td>"+title+
		"<span class='pull-right'>"+
			"<button type='button' class='btn btn-danger btn-sm' onclick='contractDel("+no+")'>삭제</button>"+
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
