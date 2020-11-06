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
 * @파일명 : memberLoginConfig.jsp
 * @파일정보 : 회원 로그인 설정
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
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.exedit-3.5.js"></script>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-body">
				<div class="col-md-12" style="padding:0;">
					<form name="loginConfig" id="loginConfig" method="post" onsubmit="fn_egov_save(); return false;" class="form-horizontal">
						<input type="hidden" name="siteCode" value="${siteCode}"/>
						<table class="table table-bordered table tp2">
							<colgroup>
									<col style="width: 25%;" />
									<col style="width: 75%;" />
								</colgroup>
								<tr>
									<th style="vertical-align: middle;"><span>로그인 유효시간 (단위 : 초)</span></th>
									<td>
										<label><input class="from-control" type="number" name="sessionTime" max="10800" min="300" style="width: 100px; text-align: right;" value="${sessionTime}"/>&nbsp;&nbsp;초</label>
										<span class="help-block" style="margin:5px 0 0;">서버 안전성 및 보안을 위하여 로그인 유효시간은 최소 300~10800초만 가능합니다.</span>
									</td>
								</tr>
								<input type="hidden" name="returnType" value="1"/>
								<%--
								<tr>
									<th style="vertical-align: middle;"><span>로그인 후 리턴 페이지</span></th>
									<td>
										<input type="radio" class="rtType minimal" name="returnType" id="returnType0" <c:out value="${returnType==0?'checked':''}"/> value="0"/> <label for="returnType0">있던 페이지로 되돌아가기</label>
										<input type="radio" class="rtType minimal" name="returnType" id="returnType1" <c:out value="${returnType==1?'checked':''}"/> value="1"/> <label for="returnType1">메인페이지로</label>
										<input type="radio" class="rtType minimal" name="returnType" id="returnType2" <c:out value="${returnType==2?'checked':''}"/> value="2"/> <label for="returnType2">특정 메뉴로 가기</label>
									</td>
								</tr>
								<c:choose>
									<c:when test="${returnType==2}"><tr id="treeRow" ></c:when>
									<c:otherwise><tr id="treeRow" style="display:none;"></c:otherwise>
								</c:choose>
									<th><span>메뉴 선택</span></th>
									<td>
										<input type="text" readonly="readonly" class="form-control" name="menuName" value="${menuName}"/>
										<input type="hidden" readonly="readonly" class="form-control" name="returnMenu" value="${returnMenu}"/>
										<div class="ztree" id="rtMenuTree" style="max-height: 150px; height: 150px; overflow: auto; border : 1px solid #eee;border-top: none;" ></div>
									</td>
								</tr> --%>
						</table>
						<button type="submit" class="btn btn-primary pull-right">저장</button>
					</form>
				</div>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
<!-- /.content -->
<script type="text/javascript">
//<[[!CDATA[

/* 글 등록 function */
function fn_egov_save() {

	frm = document.loginConfig;
	if(Validator.validate(frm)){

		if (frm.returnType.value == 3) {
			if (frm.menuName.value=="" || frm.returnMenu.value=="") {
				alert("로그인 후 리턴 페이지를 <특정 메뉴로 가기>를 선택하시면 반드시 메뉴를 선택하셔야 합니다.");
				return false;
			}
		}

		$.ajax({
			url : '${urlInfo.menuCode}_edit_loginConfig_proc.ajax',
			data : $("#loginConfig").serialize(),
			type : "POST",
			success : function(data){
				if(data == 401){
					alert("해당 권한이 없습니다.");
					return false;
				} else if(data.status === "success") {
					alert(data.msg);
				} else {
					alert(data.msg+"\n 에러 상태 : "+data.status);
				}
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});

	}
}

var returnMenuTree = null;

var subTreeSetting = {
		view: {selectedMulti: false},
		data: {simpleData: {enable: true}},
		callback: {onClick : function(e,treeId, treeNode){
			if(treeNode.children != undefined && treeNode.children.length > 0){// 하위메뉴가 있으면 단순 폴더 오픈
				returnMenuTree.expandNode(treeNode); // 노드 오픈
			} else {
				$("input[name='returnMenu']").val(treeNode.id);
				$("input[name='menuName']").val(treeNode.name);
			}

		}}
	};


function initReturnMenuTree(){
	zNodes = [];
	$.ajax({
		url:"/_mngr_/menu/${urlInfo.menuCode}_comm_mngrMenuTree.ajax",
		data : {siteCode : "${siteCode}"},
		dataType : "json",
		async : false,
		success : function(data){
			zNodes = data;

			$.fn.zTree.init($("#rtMenuTree"), subTreeSetting, zNodes);
			returnMenuTree = $.fn.zTree.getZTreeObj("rtMenuTree");

		}
		, error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function selectNodeByNodeId(treeObj, nodeId){
	if (treeObj != null && nodeId != null && nodeId != "") {
		var nodes = treeObj.getNodes();
		var selectNode = treeObj.getNodesByParamFuzzy("id", nodeId);

		if (selectNode.length > 0) {

			var depth = selectNode[0].depth;
			var parentNodes = [];
			var tmpNode = selectNode[0].getParentNode();
			while (depth > 1) {
				depth--;
				parentNodes.push(tmpNode);
				tmpNode = tmpNode.getParentNode();
			}

			for (var i = parentNodes.length-1 ; i >=0; i--) {
				treeObj.expandNode(parentNodes[i]);
			}
			return selectNode[0].name;
		}

	}
	return "";
}


$(function(){
	initReturnMenuTree();
	$("input[name='menuName']").val(selectNodeByNodeId(returnMenuTree, $("input[name='returnMenu']").val()));

	$(".rtType").on("ifChecked", function(){
		if ($(this).val() == 2) {
			$("#treeRow").css("display", "table-row");

			if (returnMenuTree == null) {
				initReturnMenuTree();
			}
			$("input[name='menuName']").val(selectNodeByNodeId(returnMenuTree, $("input[name='returnMenu']").val()));

		} else {
			$("#treeRow").css("display", "none");
		}
	});

});

//]]>
</script>