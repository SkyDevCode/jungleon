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
	<div class="box-menu">
		<div class="box-header">
			<div class="row">
				<div class="col-md-6 form-group">
					<select class="form-control select2" style="width: 100%;" name="schSiteCode" id="schSiteCode" onChange="fn_changeSite();">
					<c:forEach var="result" items="${siteList}" varStatus="status">
						<option ${ufn:selected(result.siteCode, mngrSiteVO.siteCode)} value="${result.siteCode}">${result.siteName}</option>
					</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
	<div class="col-md-4">
		<div class="box">
		    <div class="box-body menu-tree-box" style="min-height:784px;">
				<!-- 사이트 분기용 form -->
				<form name="changeForm" id="changeForm" method="post" onsubmit="fn_egov_save(); return false;" enctype="multipart/form-data">
				<input type="hidden" name="siteCode" value="${mngrSiteVO.siteCode}">
				<input type="hidden" name="sysName" value="${mngrSiteVO.siteName}">
				</form>
				<div id="AXTreeTarget">
					<div id="zTree" class="ztree"></div>
				</div>
				<div class="callout callout-danger">
				    <p>&bull;메뉴를 추가/수정/삭제 하신 경우 실시간 적용이 되지 않습니다.</p>
					<p>&bull;사이트에 적용을 하실려면
						<span class="btn-apply">사이트적용</span>
						버튼을 클릭 해 주세요.
					</p>
				</div>
				<div style="height:35px;margin-top:5px">
					<%-- <button type="button"  class="btn btn-default btn-sm" onclick="fn_load('REGIST', '0');" title="최상위 추가">TOP <i class="glyphicon glyphicon-plus"></i></button> --%>
					<button type="button"  class="btn btn-warning btn-sm" onclick="fn_load('REGIST', '');" title="메뉴추가">메뉴추가</button>
					<button type="button"  class="btn btn-warning btn-sm" onclick="fn_load('UPDATE', '');" title="조회">메뉴조회</button>
					<button type="button"  class="btn btn-default btn-sm" id="expandAllBtn" onclick="expandAll();" title="모두열기/닫기"><i class="glyphicon glyphicon-folder-open"></i></button>
					<button type="button"  class="btn btn-default btn-sm" onclick="refreshNode();" title="새로고침"><i class="glyphicon glyphicon-refresh"></i></button>
					<button type="button"  class="btn btn-default btn-sm" onclick="fn_move('${mngrSiteVO.siteCode}');" title="이동"><i class="glyphicon glyphicon glyphicon-export"></i></button>
					<button type="button"  class="btn btn-default btn-sm" onclick="fn_swap('UP');" title="위로이동"><i class="glyphicon glyphicon-arrow-up"></i></button>
					<button type="button"  class="btn btn-default btn-sm" onclick="fn_swap('DOWN');" title="아래로이동"><i class="glyphicon glyphicon-arrow-down"></i></button>
					<button type="button"  class="btn btn-primary btn-sm" onclick="fn_createFile();" title="사이트적용">사이트적용</i></button>

					<!-- <button type="button"  class="AXButtonSmall Blue" onclick="fn_load('REGIST', '0');">최상위 추가</button>
					<button type="button"  class="AXButtonSmall Blue" onclick="fn_load('REGIST', '');">하위 추가</button>
					<button type="button"  class="AXButtonSmall Blue" onclick="fn_load('UPDATE', '');">조회</button>
					<button type="button"  class="AXButtonSmall" id="expandAllBtn" onclick="expandAll();">모두열기</button>
					<button type="button"  class="AXButtonSmall" onclick="refreshNode();" >새로고침</button>
					<button type="button"  class="AXButtonSmall Green" onclick="fn_move();">이동</button>
					<button type="button"  class="AXButtonSmall Green" onclick="fn_swap('UP');" > ▲ </button>
					<button type="button"  class="AXButtonSmall Green" onclick="fn_swap('DOWN');" > ▼ </button>

					<button type="button"  class="AXButtonSmall Red" onclick="fn_createFile();">메뉴 생성</button> -->
				</div>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
    <div class="col-md-8">
    	<div class="box">
        	<div class="box-body" style="padding: 25px 20px;min-height:784px;">
            	<div style="height:734px;overflow-y:auto;overflow-x:hidden;">
                	<!-- 메뉴상세정보 표시 -->
					<div id="contentDiv">
						<div class="error-content" style="margin: 50px auto 0 auto; max-width:500px;">
							<p style="text-align:center;margin-top:200px;"><img src="../../../../../../resource/common_adm/img/error-msg.png" alt="오류 메세지"></p>
							<p>원하시는 메뉴를 선택해주세요.</p>
						</div>
					</div>
				</div>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->

<%-- 메뉴이동 트리레이어 --%>
<div class="modal" id="modalContent">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">메뉴 이동</h4>
			</div>
			<div class="modal-body">
				<div id="zTree2" class="ztree" style="background-color: #fff;height:400px;padding:20px;overflow-y:auto;"></div>
				<div style="text-align:center;margin-top:10px; padding:10px;">
					<button type="button"  class="btn btn-primary" onclick="fn_moveProc();">이동</button>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal mngrAuthorityMainModal" id="modalManagerContent">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">담당자 선택</h4>
			</div>
			<div class="modal-body">
				<div class="form-inline" style="margin-bottom:10px;">
					<div id="managerList" class="managerList">
						<input name="schManagerStr" id="schManagerStr" class="form-control input-sm" title="검색어 입력" onkeydown="if(ItgJs.fn_isEnter(event)) fn_searchManager(1);" />
						<button type="button" class="btn btn-default btn-sm btn-sm-search" style="margin-right:20px;" onclick="fn_searchManager(1);">검색</button>
						<span id="searchResult"></span>
					</div>
				</div>
				<div class="form-inline" style="padding-top:0;">
					<table \id="example1" class="table table-bordered">
	                    <colgroup>
							<col width="30%" />
							<col width="30%" />
							<col width="40%" />
						</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th scope="col">이름</th>
								<th scope="col">아이디</th>
								<th scope="col">부서명</th>
	                    	</tr>
						</thead>
	                    <tbody id="managerListTbody">
							<tr>
								<td colspan="3" class="tac">&nbsp; </td>
							</tr>
						</tbody>
					</table>
					<div id="managerListMoreBtn" style="text-align:center;margin-top:10px; padding:10px;display:none;">
						<button type="button" class="btn btn-default" onclick="fn_searManagerMore();">더보기</button>
					</div>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal" id="noticeDivContent">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">메뉴관리 주의사항</h4>
			</div>
			<div class="modal-body">
				<p style="padding:5px;"><span style="color:#cc3333">1. 메뉴를 추가/수정/삭제 하신 경우 실시간 적용이 되지 않습니다.</span></p>
				<p style="padding:5px;"><span style="color:#cc3333">2. 사이트에 적용을 하실려면 <i class="glyphicon glyphicon-floppy-save"></i>(사이트적용) 버튼을 클릭 해 주세요.</span></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<form name="formCreateFile" method="post">
	<input type="hidden" name="id" id="id"/>
</form>

<script type="text/javascript">
//<![CDATA[
	var setting = {
			view: {
					selectedMulti: false
					,fontCss: function (treeId, node) { //트리 색상 변경
						return node.font ? node.font : {};
					}
			},
			data: {simpleData: {enable: true}},
			callback: {onClick : onClick}
		};
	var setting2 = {
			view: {selectedMulti: false},
			data: {simpleData: {enable: true}},
			callback: {onClick : function (e,treeId, treeNode) {
				zTree2.expandNode(treeNode); // 노드 오픈
				}
			}
	}

	function refreshNode() {
		nodes = zTree.getSelectedNodes();
		initTree('${mngrSiteVO.siteCode}');
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
		fn_load('UPDATE', '');
		fn_clear();
	}

	var zTree, zTree2;
	$(document).ready(function(){
		initTree('${mngrSiteVO.siteCode}');
		//$("#noticeDivContent").modal("show");
	});

	var zNodes = [];
	function initTree(siteCode){
		var para = document.location.href;
		para = para.substring(para.lastIndexOf("/")+1, para.lastIndexOf("."));
		zNodes = [];
		$.ajax({
			url:"/commons/menu/menu_comm_list.ajax",
			data : {
				siteCode : siteCode,
				pcode : "",
				url : para
			},
			dataType : "json",
			async : false,
			success : function(data){
				for(i = 0; i < data.length; i++){
					if(data[i].useType == "2"){
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
	/** 등록, 수정 모드에 따라 해당 메뉴코드의 데이터를 가져와서 레이어에 로딩한다. */
	function fn_load(mode, code){
		if(mode == "") return false;
		if(code == ""){ //메뉴코드가 없으면 메뉴코드가 선택 됐는지 확인.
			nodes = zTree.getSelectedNodes();
			if(nodes == 0){
				alert("메뉴를 선택 해 주세요.");
				return false;
			}
			code = nodes[0].id;
			if(mode == "REGIST" && nodes[0].depth > 4){
				alert("메뉴는 4뎁스까지만 등록 가능합니다.");
				return false;
			}
		}
		//if(code == "") return alert("메뉴정보가 없습니다. 다시 시도해 주세요.");

		$("#contentDiv").load("menu_edit.ajax", "id="+code+"&act="+mode, function(responseTxt,statusTxt,xhr){
		     /* if(statusTxt=="success")
		    	 $(this).html(responseTxt)
		     if(statusTxt=="error")
		       alert("Error: "+xhr.status+": "+xhr.statusText); */
		   });
	}

	/* 편집 레이어 초기화 */
	function fn_clear(){
		$("#contentDiv").html("");
	}
	function fn_swap(type){
		nodes = zTree.getSelectedNodes();
		if(nodes == 0){
			alert("메뉴를 선택 해 주세요.");
			return false;
		}
		if(nodes[0].depth == 1){
			alert("최상위 메뉴는 순서를 변경 할 수 없습니다.");
			return false;
		}
		$.ajax({
			url:"/_mngr_/menu/menu_edit_updown.ajax",
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

	function fn_move(siteCode){
		nodes = zTree.getSelectedNodes();
		if(nodes == 0){
			alert("이동 할 메뉴를 선택 해 주세요.");
			return false;
		}
		if(nodes[0].depth == 1){
			alert("최상위 메뉴는 이동 할 수 없습니다.");
			return false;
		}
		$.ajax({
			url:"/commons/menu/menu_comm_list.ajax",
			data : {
				siteCode : siteCode,
				pcode : ""
			},
			dataType : "json",
			async : false,
			success : function(data){
				$.fn.zTree.init($("#zTree2"), setting2, data);
				zTree2 = $.fn.zTree.getZTreeObj("zTree2");
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		$("#modalContent").modal("show")
		fnObj.modalOpenDiv();
	}

	function fn_moveProc(){
		nodesA = zTree.getSelectedNodes();
		nodesB = zTree2.getSelectedNodes();
		if(nodesA == 0){
			alert("이동할 메뉴를 선택 해 주세요.");
		}else if(nodesB == 0){
			alert("이동할 메뉴를 선택 해 주세요.");
			return false;
		}else{
			if(confirm("메뉴를 이동하시겠습니까?\n대상 메뉴의 하위폴더로 이동됩니다.")){
				$.ajax({
					url:"/_mngr_/menu/menu_edit_move.ajax",
					data : "originalCode="+nodesA[0].id + "&targetCode="+nodesB[0].id,
					dataType : "json",
					type : "POST",
					async : true,
					success : function(data){
						if(data.result == "1"){
							alert("메뉴가 이동 되었습니다.");
						}else if(data.result == "2"){
							alert("대상 메뉴 정보가 없습니다.");
							return false;
						}else if(data.result == "3"){
							alert("원본 메뉴 정보가 없습니다.");
							return false;
						}else if(data.result == "4"){
							alert("최상위 메뉴는 이동 할 수 없습니다.!!");
							return false;
						}else if(data.result == "5"){
							//alert("최상위 메뉴는 이동 할 수 없습니다.!!");
							console.log("동일한 위치로의 이동입니다. (변화없음)");
							return false;
						}else{
							alert("알수 없는 오류가 발생했습니다. 다시 시도해 주세요.");
							return false;
						}
						refreshNode();
						$("#modalContent").modal("hide")
					}
					, error:function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			}
		}
		fnObj.modalClose();
	}

	/** 담당자 설정 관련 함수 */
	function fn_setManager(id, name){
		if(confirm(name + " 님을 담당자로 설정하시겠습니까?")){
			$("#mngId").val(id);
			$("#mngName").val(name);
			$("#modalManagerContent").modal("hide");
		}
	}

	var searchManagerPage = 1; //더보기용 페이지 저장
	function fn_searManagerMore(){ //더보기용 페이지 증가
		searchManagerPage++;
		fn_searchManager(searchManagerPage);
	}

	function fn_searchManager(page){//검색결과 조회
/* 			if($("#schManagerStr").val() == ""){
			alert("아이디 또는 이름 또는 부서명을 입력해 주세요.");
			return false;
		}*/
		searchManagerPage = page;
		$.ajax({
			url:"/_mngr_/manager/manager_list.ajax",
			data : "schStr="+encodeURIComponent($("#schManagerStr").val()) + "&page=" + page,
			dataType : "json",
			async : false,
			success : function(data){
				str = "";
				var color = (page % 2 == 0)? "#fafafa":"#fafaff";
				for(i = 0; i < data.result.length; i++){
					str += "<tr>";
					str += "<td><a href=\"#none\" onclick=\"fn_setManager('"+data.result[i].mngId+"','"+data.result[i].mngName+"')\">"+data.result[i].mngName+"</a></td>";
					str += "<td>"+data.result[i].mngId+"</td>";
					str += "<td>"+data.result[i].groupCodeName+"</td>";
					str += "</tr>";
				}
				//검색결과 표시
				$("#searchResult").text("검색결과 : " + data.total + " 건 " +  data.currentPage +"/"+ data.totalPage);
				if(str == ""){
					str = "<tr><td colspan='3'>검색 결과가 없습니다.</td></tr>";
					searchManagerPage = 0;
				}
				if(parseInt(data.currentPage) < parseInt(data.totalPage)){ // 페이지 더 있으면 더보기 버튼 보여줌
					$("#managerListMoreBtn").show();
					$("#managerListMoreBtn button").text(data.currentPage +"/"+ data.totalPage + " 더보기");
				}else{
					$("#managerListMoreBtn").hide();
					$("#managerListMoreBtn button").text("더보기");
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

	/** 담당자 설정 관련 함수 */
	function fn_createFile(){
		//nodes = zTree.getSelectedNodes();
		console.log(zTree);
		nodes = zTree.getNodesByParam("depth",1);
		if(nodes == 0){
			alert("메뉴를 선택 해 주세요.");
			return false;
		}
		if(nodes[0].depth != "1"){
			alert("최상위 메뉴를 선택 해 주세요.")
			return false;
		}
		if(confirm("사이트에 메뉴를 적용 하시겠습니까? 확인을 누르시면 메뉴 파일이 배포됩니다.")){
			$.ajax({
				url:"/_mngr_/menu/menu_edit_create.ajax",
				type:"POST",
				data : "id="+nodes[0].id+"&siteCode=${mngrSiteVO.siteCode}",
				dataType : "json",
				//async : false, //로딩이미지 미노출로 인한 주석처리
				success : function(data){
					if(data.result == "0"){
						alert("알수없는 오류가 발생했습니다.");
						return false;
					}else if(data.result == "2"){
						alert("선택된 최상위 메뉴 정보가 없습니다.");
						return false;
					}else if(data.result == "1"){
						alert("메뉴 파일이 생성 됐습니다.");
						return false;
					}
				}
				, error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	}

	function fn_changeSite(){
		var frm = document.changeForm;
		frm.siteCode.value=$("#schSiteCode").val();
		frm.action = "?";
		frm.submit();
	}

	//]]>
</script>
