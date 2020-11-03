<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.exedit-3.5.js"></script>

<div class="row">
	<div class="col-md-4">
		<div class="box">
			<div class="box-body menu-tree-box">
				<div id="AXTreeTarget" style="min-height: 660px;">
					<div id="zTree" class="ztree"></div>
				</div>
				<div style="height: 35px; margin-top: 5px">
					<button type="button" class="btn btn-warning btn-sm" onclick="fn_load('REGIST', '0');" title="최상위 추가">
						TOP <i class="glyphicon glyphicon-plus"></i>
					</button>
					<button type="button" class="btn btn-warning btn-sm" onclick="fn_load('REGIST', '');" title="하위 추가">
						SUB <i class="glyphicon glyphicon-plus"></i>
					</button>
					<button type="button" class="btn btn-primary btn-sm" onclick="fn_load('UPDATE', '');" title="수정/삭제">수정/삭제</button>
					<button type="button" class="btn btn-default btn-sm" id="expandAllBtn" onclick="expandAll();" title="모두열기/닫기">
						<i class="glyphicon glyphicon-folder-open"></i>
					</button>
					<button type="button" class="btn btn-default btn-sm" onclick="refreshNode();" title="새로고침">
						<i class="glyphicon glyphicon-refresh"></i>
					</button>
					<button type="button" class="btn btn-default btn-sm" onclick="fn_move('UP');" title="위로 이동">
						<i class="glyphicon glyphicon-arrow-up"></i>
					</button>
					<button type="button" class="btn btn-default btn-sm" onclick="fn_move('DOWN');" title="아래로 이동">
						<i class="glyphicon glyphicon-arrow-down"></i>
					</button>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- /.box -->
	</div>
	<!-- /.col -->
	<div class="col-md-8">
		<div class="box">
			<div class="box-body menu-tree-box">
				<div style="height: 710px; overflow-x: hidden; overflow-y: auto;">
					<div id="contentDiv"></div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- /.box -->
	</div>
	<!-- /.col -->
</div>
<!-- /.row -->

<!-- 정보수정 모달창 S-->
<div class="modal" id="infomationModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" onclick="hideInfomation()" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">정보수정</h4>
			</div>
			<div class="modal-body col-xs-12">
				<form name="memberFrm" id="memberFrm">
				<div class="col-xs-12" id="cngInfomation">
				</div>
				</form>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
//<![CDATA[
		var page = 1;
		var collapseStat = true;
		var setting = {
				view: {
					selectedMulti: false,
					fontCss: function (treeId, node) { //트리 색상 변경
						return node.font ? node.font : {};
					}
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					onClick : onClick
				}
			};

		function refreshNode() {
			nodes = zTree.getSelectedNodes();
			initTree();
			if (nodes.length != 0) {
				zTree.selectNode(nodes[0]);
			}
		}

		var expandFlag = false;
		function expandAll(){
			expandFlag = !expandFlag
			zTree.expandAll(expandFlag);
		}
		function onClick(e,treeId, treeNode) {
			zTree.expandNode(treeNode); // 노드 오픈
			fn_load('VIEW', '');
			fn_clear();
		}

		var zTree;
		$(document).ready(function(){
			initTree();
			fn_clear();
		});

		var zNodes = [];
		function initTree(){
			zNodes = [];
			$.ajax({
				url:"${menuCode}_list_organization.ajax",
				data : "",
				dataType : "json",
				async : false,
				success : function(data){
					for(i = 0; i < data.length; i++){
						if(data[i].code.charAt(0) == "_"|| data[i].code == "board"){
						data[i]["font"] = {"color":"red"}
						//console.debug(data[i]);
						}
					}
					zNodes = data;
					$.fn.zTree.init($("#zTree"), setting, zNodes);
					zTree = $.fn.zTree.getZTreeObj("zTree");
				}
				, error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}

		/* 페이지 함수 */
		/** 피이지 로드 */
		<%-- [D]해당 부서 정보 및 회원 정보 로드 --%>
		function fn_load(mode, code){
			if(mode == "") return false;
			if(code == ""){ //코드가 없으면 코드가 선택 됐는지 확인.
				nodes = zTree.getSelectedNodes();
				if(nodes == 0){
					alert("코드를 선택 해 주세요.");
					return false;
				}
				code = nodes[0].id;
			}
			if(code == "") return alert("코드정보가 없습니다. 다시 시도해 주세요.");
			if(mode == "REGIST"){
				$("#contentDiv").load("${menuCode}_input_organization.ajax", "schCode="+code, function(responseTxt,statusTxt,xhr){
				     if(statusTxt=="success")
				    	 $(this).html(responseTxt)
				     if(statusTxt=="error")
				       alert("Error: "+xhr.status+": "+xhr.statusText);
				});
			}
			else if(mode == "UPDATE"){
				$("#contentDiv").load("${menuCode}_edit_organization.ajax", "schCode="+code, function(responseTxt,statusTxt,xhr){
				     if(statusTxt=="success")
				    	 $(this).html(responseTxt)
				     if(statusTxt=="error")
				       alert("Error: "+xhr.status+": "+xhr.statusText);
				});
			}
			else if(mode == "VIEW"){
				$("#contentDiv").load("${menuCode}_view_organization.ajax", "schCode="+code+"&page="+page, function(responseTxt,statusTxt,xhr){
				     if(statusTxt=="success")
				    	 $(this).html(responseTxt)
				     if(statusTxt=="error")
				       alert("Error: "+xhr.status+": "+xhr.statusText);
				});
			}
		}

		/* 편집 레이어 초기화 */
		function fn_clear(){
			var msg = "<div class='error-content' style='margin: 50px auto 0 auto; max-width:500px;'>"+
						"<p style='text-align:center;margin-top:200px;'><img src='../../../../../../resource/common_adm/img/error-msg.png' alt='오류 메세지'></p>"+
						"<p>부서를 선택해 주세요.</p>"+
          			  "</div>";

			$("#contentDiv").html(msg);
		}

		/* 새로고침 */
		function refreshNode() {
			nodes = zTree.getSelectedNodes();
			initTree();
			if (nodes.length != 0) {
				zTree.selectNode(nodes[0]);
			}
		}

		/* 위로이동&아래로이동 */
		function fn_move(type){
			nodes = zTree.getSelectedNodes();
			if(nodes == 0){
				alert("메뉴를 선택 해 주세요.");
				return false;
			}

			$.ajax({
				url:"${menuCode}_edit_organization_updown.ajax",
				data : "id="+nodes[0].id + "&swaptype="+type,
				dataType : "json",
				async : false,
				success : function(data){
					if(data.result == "0"){
						alert("알수없는 오류가 발생했습니다. 다시 시도해 주세요.")
					} else if (data.result == "2") {
						alert((type == "UP" )? "더이상 위로 이동할 수 없습니다." : "더이상 아래로 이동할 수 없습니다.");
						return false;
					} else if(data.result == "3"){
						alert("최상위 메뉴는 순서를 변경 할 수 없습니다.!!");
						return false;
					}
					refreshNode();
					//S:이동완료 후 재 선택 2016-03-16 장
					var tNode = zTree.getNodeByParam("id",nodes[0].id);
					zTree.selectNode(tNode);
					//E:이동완료 후 재 선택 2016-03-16 장
					//zTree.cancelSelectedNode();//이동완료 후 재 선택 유지를 위한 주석처리
				}
				, error:function(request,status,error){
			   		   alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				   }
			});
		}

		function showInfomation(mngId) {
			$("#cngInfomation").html("");
			$("#infomationModal").show();
			$("#cngInfomation").load("${menuCode}_edit_organization_member.ajax", "id="+mngId, function(responseTxt,statusTxt,xhr){
			     if(statusTxt=="success")
			    	 $(this).html(responseTxt)
			     if(statusTxt=="error")
			       alert("Error: "+xhr.status+": "+xhr.statusText);
			});
		}
		function hideInfomation() {
			$("#infomationModal").hide();
		}
		function saveMemberInfo() {
			var params = jQuery("#memberFrm").serialize();
			$.ajax({
				url:"${menuCode}_edit_organization_member_proc.ajax",
				data : params,
				success : function(data){
					alert("저장 하였습니다.");
					$("#infomationModal").hide();
					fn_load('VIEW', '');
				}
				, error:function(request,status,error){
			   		   alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				   }
			});
		}
	//]]>
</script>