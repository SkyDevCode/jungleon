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
 * @파일명 : mnauthindividual_input.jsp
 * @파일정보 : 개별권한관리 등록
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2018. 12. 14. 최초생성
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
			<div class="col-md-12">
				<div class="box">
					<div class="box-body">
						<div id="authLayer" style="height:100%; min-height:470px;">
							<div class="col-md-12" id="registLayer">
								<form name="form1" id="form1" method="post" onsubmit="fn_save(); return false;">
									<input type="hidden" name="menuCodes" id="menuCodes" />
									<p style="text-align:right">
										<button type="button" onclick="fn_save();" class="btn btn-primary">저장</button>
										<button type="button" onclick="fn_list();" class="btn btn-default">목록으로</button>
									</p>
									<table class="table table-bordered tp2">
										<colgroup>
											<col style="width:160px"/>
											<col/>
										</colgroup>
										<tbody>
											<tr>
												<th class="t">관리자명</th>
												<td>${mngrInfo.mngName}
													<input type="hidden" name="mngId" id="mngId" title="관리자아이디" value="${mngrInfo.mngId}" /></td>
											</tr>
											<tr>
												<th class="t">관리사이트</th>
												<td>
													${siteInfo.siteName}
													<input type="hidden" name="menuAuthSitecode" id="menuAuthSitecode" value="${siteInfo.siteCode}"/>
												</td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
							<div class="col-md-12">
								<button type="button"  class="btn btn-default btn-sm" id="expandAllBtn" onclick="expandAll();" title="모두열기/닫기"><i class="glyphicon glyphicon-folder-open"></i></button>
								<div id="AXTreeTarget" style="width:100%;height: 500px; border:1px solid #dadada;background-color:#e9ecf0;margin-bottom:0;">
									<div id="zTree" class="ztree" style="padding:10px 20px;"></div>
								</div>
							</div>
						</div>
					</div><!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
		</div><!-- /.row -->

<form:form name="searchForm" id="searchForm" method="post">
	<input type="hidden" name="schSiteCode" value="<c:out value="${siteInfo.siteCode}"/>"/>
</form:form>

<script type="text/javascript">
//<![CDATA[

	$(document).ready(function(){
		fn_setMenuAuthSitecode('${siteInfo.siteCode}','${mngrInfo.mngId}');
	})

	var authList = new ArrayList();
	var authNode = new Map();

	/**************************** 등록 수정 삭제 취소  ***********************************/
	function fn_save(){
		var frm = document.form1;

		if(Validator.validate(frm)){
			var menuCodes = "";
			var trees = zTree.getCheckedNodes(true);
			if(trees == ""){
				alert("선택된 메뉴가 없습니다.")
				return false;
			}
			for(i = 0; i < trees.length; i++){
				menuCodes += (trees[i].id+"::"+trees[i].authNdv);
				if(i < trees.length -1 ){
					menuCodes += ":::";
				}
			}

			frm.menuCodes.value = menuCodes;
			if(confirm("등록 하시겠습니까?")){
 				frm.action="/_mngr_/menuauth/mnauthindiv_input_proc.do";
				frm.submit();
			}
		}
	}

	function fn_list(){
		var frm = document.searchForm;
		//frm.schSiteCode.value=$("#schSiteCode").val();
		frm.action = "mnauthindividual_list.do";
		frm.submit();
	}

	var testlist

	function fn_setMenuAuthSitecode(siteCode, id){
		var formSite = document.formSite;
		formSite.pmenu.value = siteCode;
		var resultData;

		$.ajax({
			url: "mnauth_comm_itemlist.ajax"
			, data : "id="+id+"&code="+siteCode+"&schType=0"
			, type : "POST"
			, dataType : "json"
			, async : false
			, success : function(data){
				resultData = data[0];
				if(resultData.result == "0"){
					alert("알수 없는 오류가 발생했습니다. 다시 시도해 주세요.");
					return false;
				}else if(resultData.result == "2"){
					alert("권한 롤 정보가 없습니다. 다시 시도해 주세요.");
					return false;
				}else if(resultData.result == "3"){
					alert("메뉴 권한 정보가 없습니다. 다시 시도해 주세요.");
					return false;
				}else if(resultData.result == "5"){
					alert("파라메터 정보가 올바르지 않습니다.");
					return false;
				}
			}, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"error:"+error+"\n"+"message:"+request.responseText);
			}
		});

		initTree(resultData.authItemListT, resultData.menuAuthListT[0],resultData.authItemList,resultData.menuAuthList[0]);
	}

	/**************************** S : ax5 모달  ***********************************/
	var authmodal = new ax5.ui.modal();

	function showModal(treeId, treeNode, isCheck){
		//var dataId = $(this).attr("data-dId");
		authmodal.open({
			width:400,
			height:400
		},function(){

			this.$["body"].append('<div class="box"><div class="box-body"><form name="auth-form" class="auth-form">');
			var bodyBox = this.$["body"].find(".box-body");
			var authForm = bodyBox.find(".auth-form");
			var title = jQuery('<div class="caution-box"><span class="caution-title">권한을 선택해주세요</span></div>');
			$(authForm) .append(title);

			var authStrR = jQuery('<input name="auth" type="checkbox" class="minimal" value="R"><label>읽기</label>');
			var authStrC = jQuery('<input name="auth" type="checkbox" class="minimal" value="C"><label>쓰기</label>');
			var authStrU = jQuery('<input name="auth" type="checkbox" class="minimal" value="U"><label>수정</label>');
			var authStrD = jQuery('<input name="auth" type="checkbox" class="minimal" value="D"><label>삭제</label>');
			$(authForm) .append(authStrR).append(authStrC).append(authStrU).append(authStrD);

			var subTitle = jQuery('<div class="caution-box"><span class="caution-title">적용범위</span></div>');
			var boundStr = '<input name="bound-child" type="checkbox" class="minimal" value="Y"><label>하위메뉴 모두포함</label>';
			var boundbody =	jQuery(boundStr);
			$(authForm)	.append(subTitle).append(boundbody);

			var button = jQuery('<div id="buttonSet"></div>');
			var button_submit = jQuery('<button class="btn btn-primary" type="button">저장</button>');
			var button_cancel = jQuery('<button class="btn btn-default" type="button">취소</button>');
			button.append(button_submit).append(button_cancel);

			$(bodyBox)	.append(authForm)
						.append(button);

			//체크박스에 iCheck스타일 적용
			$(bodyBox).find('input[type="checkbox"].minimal').iCheck({
				checkboxClass: 'icheckbox_minimal-red',
				increaseArea: '20%' // optional
			});
			$(bodyBox).find('label').css("margin","0 10px 0 5px");
			title.css({"text-align":"left"});
			subTitle.css({"text-align":"left", "margin-top":"20px"});
			button.css({"margin-top":"40px"});
			authmodal.css({height:$(bodyBox).outerHeight()});

			//체크박스를 클릭하여 들
			if(isCheck){
				$("input[name=bound-child]").iCheck('check');
			}

			$('input[name=auth].minimal').on('ifChanged', function() {
				if(this.value == "R" && this.checked == false){
					$("input[name=auth]").iCheck('unCheck');
				}else if(this.value != "R" && this.checked == true){
					$("input[name=auth][value=R]").iCheck('check');
				};
			});

			var defaultAuth = ""+treeNode.authGrp;
			if(defaultAuth.length > 0){
				defaultAuth.split(",").forEach(function(value,idx, arr){
					$("input[name=auth][value="+value+"]").iCheck('check').iCheck('disable');
				});
			}
			var nodeAuth = ""+treeNode.authNdv;
			if(nodeAuth.length > 0){
				nodeAuth.split(",").forEach(function(value,idx, arr){
					$("input[name=auth][value="+value+"]").iCheck('check');
				});
			}

			button_submit.click(function(){
				//var data = $(authForm).serialize();
				//console.log(data);
				var authNdv = new Array;
				$(authForm).find("input[name=auth]:checked").filter(function() {
					return !this.disabled && this.checked;
				}).each(function(){
					authNdv.push(this.value);
				});

				var isBound = false;

				if($(authForm).find("input[name=bound-child]:checked").length > 0) isBound = true;

				submitModal(treeId, treeNode, authNdv, isBound);
			});
			button_cancel.click(closeModal);
		});
	}

	function submitModal(treeId, treeNode, authNdv, isBound){
		console.log(treeNode);
		setChildAuth(treeNode, authNdv, isBound);
		if(treeNode.pId != null){
			setParentRead(treeNode.getParentNode(), authNdv);
		}
		zTree.refresh();
		authmodal.close();
	}

	function setChildAuth(treeNode, authNdv, isBound){

		var childAuthNdv = null;
		if(treeNode.authGrp !='') childAuthNdv = treeNode.authGrp.split(',').concat(authNdv);
		else childAuthNdv = authNdv;

		if(authNdv.length > 0){
			treeNode.checked = true;
			treeNode.open = true;
			treeNode.name = treeNode.defaultName+setNodeName(authNdv.toString());
			if(isBound){
				if(treeNode.isParent){
					for(var i=0;i<treeNode.children.length;i++){
						setChildAuth(treeNode.children[i], childAuthNdv, isBound);

					}
				}
			}
		}else{
			treeNode.name = treeNode.defaultName;
			treeNode.checked = false;
			if(isBound){
				if(treeNode.isParent){
					for(var i=0;i<treeNode.children.length;i++){
						setChildAuth(treeNode.children[i], childAuthNdv, isBound);
					}
				}
			}else{
				if(!treeNode.authGrp){
					if(isChildChecked(treeNode)){
						alert("하위메뉴에 권한이 설정되어 있습니다. 이 경우 선택하신 메뉴에 읽기 권한이 자동 부여됩니다. 만약 해당 메뉴에 모든권한을 제거 하고자 하신다면, 하위메뉴 포함 옵션을 체크하여 주시기 바랍니다.");
						setReadAuth(treeNode);
						return ;
					}
				}
			}
		}
		treeNode.authNdv = authNdv.toString();
		console.log(treeNode.id+" : "+treeNode.authNdv);
	}

	function setReadAuth(treeNode){
		treeNode.authNdv = "R";
		treeNode.checked = true;
		treeNode.name = treeNode.defaultName+setNodeName(treeNode.authNdv);
	}

	function isChildChecked(treeNode){
		var checkedCount = 0;
		if(treeNode.isParent){
			for(var i=0;i<treeNode.children.length;i++){
				if(treeNode.children[i].checked) checkedCount++;
			}
		}
		return (checkedCount == 0) ? false : true;
	}

	function setParentRead(treeNode, authNdv){

		console.log("==================================== setParentRead ============================");
		console.log(treeNode);

		if(treeNode.authGrp.length == 0 && treeNode.authNdv.length == 0){
			if(authNdv.length > 0){
				setReadAuth(treeNode);
			}else{
				treeNode.checked = false;
				treeNode.authNdv = "";
				treeNode.name = treeNode.defaultName;
			}
		}

		//자식노드중에 체크된 노드가 있는지 확인하여 없을경우 언체크 처리

		if(!isChildChecked(treeNode)){
			treeNode.checked = false;
			treeNode.authNdv = "";
			treeNode.name = treeNode.defaultName;
		}

		//부모아이디가 존재하면 재귀호출
		if(treeNode.pId != null){
			setParentRead(treeNode.getParentNode(), authNdv);
		}
	}

	function closeModal(treeId, treeNode){

		zTree.refresh();
		console.log("closeModal");
		authmodal.close();
	}
	/**************************** E : ax5 모달  ***********************************/

	/**************************** S : 트리  ***********************************/
	var setting = {
/* 			check: {
				enable: true
			}, */
			view: {
				selectedMulti: false
				,nameIsHTML: true
				,fontCss: function (treeId, node) { //트리 색상 변경
					return node.font ? node.font : {};
				}
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick : beforeClick
				,onClick : onClick
				,beforeCheck : beforeCheck
				,onCheck : onCheck
			}
		};

	function onClick(e,treeId, treeNode) {
		//zTree.expandNode(treeNode); // 노드 오픈
		showModal(treeId, treeNode, false);
		//console.log("Start onClick : "+treeId);
		//console.log(treeNode);
		//console.log(e);
		//console.log("End onClick : "+treeId);
	}
	function onCheck(e,treeId, treeNode) {
		if(treeNode.checked){
			showModal(treeId, treeNode, true);
		};
	}
	function beforeClick(treeId, treeNode) {

	}
	function beforeCheck(treeId, treeNode) {

	}

	var expandFlag = false;
	function expandAll(){
		expandFlag = !expandFlag
		zTree.expandAll(expandFlag);
	}

	var zTree;
	var zNodes = [];
	function initTree(totMenuItems, totMenuItemAuths, grpMenuItems, grpMenuItemAuths){
		zNodes = [];
		$.ajax({
			url:"/common/comm_treemenu_list.ajax",
			data : $("#formSite").serialize(),
			dataType : "json",
			async : false,
			success : function(data){

					var regExTot = eval("/^(" +totMenuItems+ ")$/"); //코드체크 정규식 ^시작 $끝을 지정해야 정확하게 코드를 비교한다 예) web, web01, web02 도 true가 될수있음
					var regExGrp = eval("/^(" +grpMenuItems+ ")$/"); //코드체크 정규식 ^시작 $끝을 지정해야 정확하게 코드를 비교한다 예) web, web01, web02 도 true가 될수있음
					var newData = [];
					console.log("regExTot : ");
					console.log(regExTot);
					console.log("regExGrp : ");
					console.log(regExGrp);
					for(i = 0; i < data.length; i++){
						var checked = false;
						var opened = false;
						var authTot = "";
						var authGrp = "";
						var authNdv = "";
						var name = data[i].name;
						var defaultName = data[i].name;
						if(regExTot.test(data[i].id)){
							checked = true;
							opened = true;
							authTot = totMenuItemAuths[data[i].id];
							console.log("authTot : ");
							console.log(authTot);
							if(regExGrp.test(data[i].id)){
								checked = false;
								authGrp = grpMenuItemAuths[data[i].id];
								console.log("authGrp : ");
								console.log(authGrp);
								authNdv = authTot.replace(authGrp,"");
								if(authNdv.startsWith( ',', 0 )) authNdv = authNdv.replace(",",""); //권한이 ',(콤마)'로 시작될 경우 첫번째 콤마를 지우기 위함
								name += setNodeName(authGrp,"gray");
							}else{
								authNdv = authTot;
							}
							defaultName = name;
							name += setNodeName(authNdv);
						}
						data[i].defaultName = defaultName;
						data[i]["checked"] = checked;
						data[i]["open"] = opened;
						data[i].authTot = authTot;
						data[i].authGrp = authGrp;
						data[i].authNdv = authNdv;
						data[i].name = name;

						if(data[i].useType == "2"){
							data[i]["font"] = {"color":"red"};
						}
					}

				zNodes = data;

				$.fn.zTree.init($("#zTree"), setting, zNodes);
				zTree = $.fn.zTree.getZTreeObj("zTree");
				//zTree.expandAll(true);
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}

	function setNodeName(auth,color){
		var name = "";
		if(!color) color = "burlywood";
		if(auth){
			name = "<span style='color: "+color+";'>("+auth.replace('C','쓰기').replace('R','읽기').replace('U','수정').replace('D','삭제')+")</span>";
		}
		return name;
	}
	/**************************** E : 트리  ***********************************/
//]]>
</script>