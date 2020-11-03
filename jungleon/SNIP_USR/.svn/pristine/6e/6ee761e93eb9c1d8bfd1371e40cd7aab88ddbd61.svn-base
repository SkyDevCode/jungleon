<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.itgcms.common.MngrSessionVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>

<!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            컨텐츠관리
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li class="active">컨텐츠관리</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
			<ul class="nav nav-tabs">
				<c:forEach var="result" items="${siteList}" varStatus="status">
					<li class="<c:if test = "${result.siteCode eq siteCode}">active</c:if>">
						<a id="${result.siteCode}" data-toggle="tab">${result.siteName}</a>
					</li>
				</c:forEach>
			</ul>
			<div class="row">
				<div class="col-md-3">
					<div class="box">
						<!-- <div class="box-header with-border"><h3 class="box-title">Title</h3></div> -->
						<div class="box-body menu-tree-box">

							<div id="AXTreeTarget" style="height:700px;">
								<div id="zTree" class="ztree"></div>
							</div>


						</div> <!-- /box-body -->
					</div> <!-- /box -->
				</div> <!-- /col -->

				<div class="col-md-9">
					<div class="box">
						<div class="box-header with-border">
							<h3 class="box-title"><c:out value="${menuVO.menuName }" />
								<small>
									(<c:out value="${ufn:deCode(menuVO.menuType, '0,폴더,1,CMS 컨텐츠,2,프로그램,3,게시판,4,링크,5,없음,6,리비전관리,7,인클루드링크', '-') }" />)
								</small>
							</h3>
						</div>
						<div class="box-body" style="padding: 25px 35px;">
						<div id="contentsFormWarpper" style="float:left;width:100%;min-height:648px;/*overflow-y:auto;overflow-x:hidden;*/">
						<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;" enctype="multipart/form-data">
							<c:forEach var="entry" items="${param}" varStatus="status">
								<input type="hidden" name="${entry.key}" value="${ufn:stripXssScript(entry.value)}"/>
						    </c:forEach>
						  <%-- 0:폴더, 1:CMS 컨텐츠, 2:프로그램, 3:게시판, 4:링크, 5:컨텐츠없음 --%>
							<c:set var="callMenuBody" value="N"/>
							<c:choose>
								<c:when test="${menuVO.menuType eq '1'  }">
										<input type="hidden" name="id" value="<c:out value="${menuVO.menuCode }"  />" />
										<input type="hidden" name="url" value="/_mngr_/menu/mngrContentsUpdate.do" />
										<c:set var="callMenuBody" value="Y"/>
								</c:when>
								<c:when test="${menuVO.menuType eq '2'  }">
									<c:if test="${menuVO.menuMngurl ne '-' }">
								  		<input type="hidden" name="siteCode" value="${siteCode}" />
								  		<input type="hidden" name="menuCode" value="${menuVO.menuCode}"  />
								  		<input type="hidden" name="progIdx" value="${menuVO.menuSubType}"  />
										<input type="hidden" name="url" value="${menuVO.menuMngurl }" />
										<c:set var="callMenuBody" value="Y"/>
									</c:if>
									<c:if test="${menuVO.menuMngurl eq '-' or menuVO.menuMngurl eq ''}">
							 			<div class="error-content" style="margin: 50px auto 0 auto; max-width:500px;">
							              <p style="text-align:center;margin-top:200px;"><img src="/resource/common_adm/img/error-msg.png" alt="오류 메세지"></p>
							              <h3>관리자 페이지 사용안함</h3>
							              <p>이 프로그램은 관리자 페이지가 사용되지 않는 프로그램입니다.<br/>관리자페이지 설정 옵션을 변경 하시려면, <a href="/_mngr_/program/mngrProgramList.do">프로그램관리</a> 메뉴를 이용해 주세요.
							              </p>
							            </div>
									</c:if>
								</c:when>
								<c:when test="${menuVO.menuType eq '3'  }">
								  	<input type="hidden" name="siteCode" value="${siteCode}"  />
								  	<input type="hidden" name="menuCode" value="${menuVO.menuCode}"  />
									<input type="hidden" name="url" value="${menuVO.menuMngurl }" />
									<c:set var="callMenuBody" value="Y"/>
								</c:when>
								<c:when test="${menuVO.menuType eq '0' or menuVO.menuType eq '4' or menuVO.menuType eq '5'   }">
									<input type="hidden" name="id" value="${menuVO.menuCode}"  />
									<input type="hidden" name="url" value="/_mngr_/menu/mngrContentsView.do" />
									<c:set var="callMenuBody" value="Y"/>
								</c:when>
								<c:when test="${menuVO.menuType eq '6' }">
									<input type="hidden" name="menuCode" value="${menuVO.menuCode}"  />
									<input type="hidden" name="url" value="/_mngr_/revision/revisionList.do" />
									<c:set var="callMenuBody" value="Y"/>
								</c:when>
								<c:when test="${menuVO.menuType eq '7'  }">
									<div class="error-content" style="margin: 50px auto 0 auto; max-width:500px;">
						              <p style="text-align:center;margin-top:200px;"><img src="../../../../../../resource/common_adm/img/error-msg.png" alt="오류 메세지"></p>
						              <h3>인클루드 링크 페이지</h3>
						              <p>외부링크 페이지를 삽입한 메뉴입니다.<br/>관리기능은 제공되지 않습니다.</p>
						            </div>
								</c:when>
								<c:otherwise>
									<div class="error-content" style="margin: 50px auto 0 auto; max-width:500px;">
						              <p style="text-align:center;margin-top:200px;"><img src="../../../../../../resource/common_adm/img/error-msg.png" alt="오류 메세지"></p>
									  <p>원하시는 메뉴를 선택해주세요.</p>
						            </div>
								</c:otherwise>
							</c:choose>
							</form>
						</div>

						</div> <!-- /box-body -->
					</div> <!-- /box -->
				</div> <!-- /col -->

			</div> <!-- /row -->


        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->
<form name="formContents" id="formContents" method="post">
	<input type="hidden" name="mngrSiteCode"/>
</form>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="/resource/common/jquery_plugin/zTree/jquery.ztree.exedit-3.5.js"></script>
<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
    	fn_setTree("${siteCode}");
	});
    /* 탭메뉴 클릭 */
	$("a[data-toggle='tab']").on("show.bs.tab", function(e) {
		//e.preventDefault();
		fn_setTree(e.target.id);
	});

	function fn_setTree(siteCode) {
		var frm1 = document.formSite;
		var frm2 = document.formContents;
		frm1.pmenu.value = siteCode;
		frm2.mngrSiteCode.value=siteCode;
		initTree();
	}
<c:if test="${callMenuBody eq 'Y' }">
	$(function(){
		callMenuBodyHTML();
	});

	function callMenuBodyHTML () {
		var frm = document.form1;
		var data = $(frm).serialize();
		<c:forEach var="id" items="${chkId}">
			data += "&chkId="+${id};
 		</c:forEach>
		<c:forEach var="site" items="${externalSite}">
			data += "&postingExternalSite=${site}";
		</c:forEach>
		$.ajax({
			url:frm.url.value,
			data : data,
			dataType : "html",
			type : "POST",
			async : false,
			success : function(data){
				$("#contentsFormWarpper").html(data);
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
</c:if>


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
			if(expandFlag){
				$("#expandAllBtn").text("모두닫기")
			}else{
				$("#expandAllBtn").text("모두열기")
			}
		}
		function onClick(e,treeId, treeNode) {
			if(treeNode.children != undefined && treeNode.children.length > 0){// 하위메뉴가 있으면 단순 폴더 오픈
				zTree.expandNode(treeNode); // 노드 오픈
				fn_clear();
			}else{//하위메뉴가 없는 메뉴는 내용 수정
				//fn_load("UPDATE", "");
				var frm = document.formContents;
				frm.action = "/_mngr_/mngrContents/" + treeNode.id + ".do";
				frm.submit();
			}

		}


		var zTree, zTree2;

		var zNodes = [];
		function initTree(){
			zNodes = [];
			$.ajax({
				url:"/_mngr_/menu/selectMngrMenuAuthTreeList.ajax",
				data : $("#formSite").serialize(),
				dataType : "json",
				async : false,
				success : function(data){
					for(i = 0; i < data.result.length; i++){
						if(data.result[i].useType == "2"){
							data.result[i]["font"] = {"color":"red"};
						}
					}
					zNodes = data.result;
					$.fn.zTree.init($("#zTree"), setting, zNodes);
					zTree = $.fn.zTree.getZTreeObj("zTree");
					selNode = zTree.getNodeByParam("id", '<c:out value="${sc}" />', null);
					zTree.selectNode(selNode);
					zTree.expandAll(true);

				}
				, error:function(request,status,error){
					alert("Ztree Error code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
			}
			if(code == "") return alert("메뉴정보가 없습니다. 다시 시도해 주세요.");

			$("#contentDiv").load("selectMngrMenuRegistAjax.do", "id="+code+"&act="+mode, function(responseTxt,statusTxt,xhr){
			     if(statusTxt=="success")
			    	 $(this).html(responseTxt)
			     if(statusTxt=="error")
			       alert("Error: "+xhr.status+": "+xhr.statusText);
			   });
		}
		/* 편집 레이어 초기화 */
		function fn_clear(){
			$("#contentDiv").html("");
		}
	//]]>
	</script>