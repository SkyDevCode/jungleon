<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<c:set var="mngrSessionVO" value="${mngrSessionVO}"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%--
	<c:if test="${fn:indexOf(systemconfigVO.faviUrl, '.') > 0}">
    	<link rel="shortcut icon" type="image/x-icon" href="${systemconfigVO.faviUrl}" />
    </c:if>
    <link rel="shortcut icon" type="image/x-icon" href="/resource/cube.ico" />
    <title>${systemconfigVO.sysName} 관리자 모드</title>
     --%>
	<script>
		var isOldIe = false;
	</script>
	<!--[if lt IE 10]>
		<script>
			isOldIe = true;
		</script>
	<![endif]-->
    <!-- jQuery 2.1.4 -->
    <script src="${ctx}/resource/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <script src="${ctx}/resource/plugins/jQueryUI/jquery-ui.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="${ctx}/resource/bootstrap/js/bootstrap.min.js"></script>
    <!-- Morris.js charts -->
    <script src="${ctx}/resource/plugins/morris/raphael-min.2.2.7.js"></script>
	<script src="${ctx}/resource/plugins/morris/morrish.min.js"></script>
	<%-- <script src="${ctx}/resource/plugins/morris/morris.js"></script> --%>
    <!-- DataTables -->
    <script src="${ctx}/resource/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="${ctx}/resource/plugins/datatables/dataTables.bootstrap.min.js"></script>
    <!-- SlimScroll -->
    <script src="${ctx}/resource/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="${ctx}/resource/plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="${ctx}/resource/dist/js/app.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="${ctx}/resource/dist/js/demo.js"></script>
        <!-- iCheck 1.0.1 -->
		<script src="${ctx}/resource/plugins/iCheck/icheck.min.js"></script>
		<!-- user/admin common -->
		<script src="${ctx}/resource/templete_common/js/common.js"></script>
		<!-- //user/admin common -->
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="${ctx}/resource/bootstrap/css/bootstrap.css">
    <!-- Morris chart -->
    <link rel="stylesheet" href="${ctx}/resource/plugins/morris/morris.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${ctx}/resource/font/font-awesome-4.7.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="${ctx}/resource/font/ionicons-2.0.1/css/ionicons.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="${ctx}/resource/plugins/datatables/dataTables.bootstrap.css">

    <!-- cms style -->
    <link rel="stylesheet" href="${ctx}/resource/common/jquery_plugin/zTree/zTreeStyle/zTreeStyle.css" type="text/css" />

	<!-- Select2 -->
	<link rel="stylesheet" href="${ctx}/resource/plugins/select2/select2.min.css">
	<script src="${ctx}/resource/plugins/select2/select2.full.min.js"></script>

    <!-- Theme style -->
    <link rel="stylesheet" href="${ctx}/resource/dist/css/AdminLTE.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <!-- <link rel="stylesheet" href="${ctx}/resource/dist/css/skins/_all-skins.min.css"> -->

    <link rel="stylesheet" href="${ctx}/resource/dist/css/skins/skin-orange.css">
    <link rel="stylesheet" href="${ctx}/resource/common/css/loading-spiner.css">

    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${ctx}/resource/plugins/iCheck/all.css">
    <!-- Bootstrap datepicker -->
    <link type="text/css" href="${ctx}/resource/plugins/datepicker/datepicker3.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx}/resource/plugins/datepicker/bootstrap-datepicker.js"></script>

    <link rel="stylesheet" type="text/css" href="${ctx}/resource/common/jquery_plugin/validation/validator.css" />
	<script type="text/javascript" src="${ctx}/resource/common/jquery_plugin/validation/validator.js"></script>
	<script type="text/javascript" src="${ctx}/resource/common/jquery_plugin/validation/accessability.js"></script>

	<!--  colorpicker spectrum-master -->
	<link rel="stylesheet" type="text/css" href="${ctx}/resource/common/jquery_plugin/spectrum/spectrum.css" />
	<script type="text/javascript" src="${ctx}/resource/common/jquery_plugin/spectrum/spectrum.js"></script>
	<script class='daum_roughmap_loader_script' src='https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js'></script>

	<!--  cms scripts -->
	<script src="${ctx}/resource/common/jquery_plugin/common_functions.js"></script>
	<script type="text/javascript" src="${ctx}/resource/common/jquery_plugin/popWin.js"></script>

    <!-- AX5-UI -->
    <link rel="stylesheet" type="text/css" href="${ctx}/resource/plugins/ax5ui/ax5ui.itg.css"/>
    <script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/ax5core.min.js"></script>
    <script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/ax5ui.itg.js"></script>
    <script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/jquery-direct.js"></script>

	<c:if test="${mngrSessionVO.currSiteCode ne 'SYSTEM'}">
		<%-- 관리자가 아닐경우 초록색 헤더가 되도록 하는 css --%>
 		<style>
			.skin-orange .main-header .navbar {
			  background-color: #009551;
			}
			.skin-orange .main-header .logo {
			  background-color: #009551;
			  color: #ffffff;
			  border-bottom: 0 solid transparent;
			}
			.skin-orange .main-header .logo:hover {
			  background-color: #009551;
			}
 		</style>
	</c:if>

  </head>
  <body class="hold-transition skin-orange sidebar-mini">
  <form name="formSite" id="formSite" method="post">
			<input type="hidden" name="pmenu">
		</form>
    <div class="wrapper">

      <header class="main-header">
        <!-- Logo -->
        <a href="${ctx}/_mngr_/main/index.do" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b></b></span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg">${systemconfigVO.sysName}</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a>
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <li>
                <!-- <a href="#none" data-toggle="control-sidebar" onclick="print();return false;"><i class="fa fa-print"> 인쇄</i></a> -->
                <!-- <a href="/resource/manual/cubecms_admin_manual3.0.pdf" target="_blank"><i class="fa fa-book"> 관리자메뉴얼</i></a> -->
              </li>
            </ul>
          </div>
        </nav>
      </header>
      <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
          <!-- Sidebar user panel -->
          <div class="user-panel">
            <div class="image">
              <%-- <img src="${ctx}/resource/dist/img/user1-128x128.jpg" class="img-circle" alt="User Image" onClick = ""> --%>
              	<form name="myInfo" method="post" action="/_mngr_/manager/manager_edit.do" >
		      		<input type="hidden" name="id" id="id" value="<c:out value="${mngrSessionVO.id}"/>"/>
		      		<input type="hidden" name="isMyInfo" id="isMyInfo" value="Y"/>
	            	<input type="image" src="${ctx}/resource/dist/img/cube_cms.png" class="img-circle" alt="User Image">
	      		</form>
	      		<div class="info">
	      			<span>${mngrSessionVO.name}</span><br/>
	      			<span>[ ${mngrSessionVO.currSiteName} ]</span>
	      		</div>
            </div>
            <div class="info">
              <a href="${ctx}/_mngr_/main/logout.do">로그아웃</a>
              <a href="#none" onclick="fn_siteMngModal();">사이트이동</a>
            </div>
          </div>
          <!-- /.search form -->
          <!-- sidebar menu: : style can be found in sidebar.less -->
          <ul class="sidebar-menu">
			<%-- ${resultStr} --%>
			<c:import url="/WEB-INF/jsp/egovframework/itgcms/mngr/_include/Include_mngr_MENU.jsp" ></c:import>
          </ul>
        </section>
        <!-- /.sidebar -->
      </aside>

<!-- 사이트선택 모달창 S-->
<div class="modal" id="siteModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" onclick="fn_closeSiteMngModal()" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">사이트관리</h4>
			</div>
			<div class="modal-body col-xs-12">
				<div class="col-xs-12">
					<div class="col-xs-8" style="text-align:left;padding-left:0px;padding-top:12px">
						<span>관리하고자 하시는 사이트를 선택하세요.</span>
					</div>
					<div class="col-xs-4" style="padding-bottom: 15px;background-color: #fff;padding-right:0px;margin-bottom: 0 !important;text-align: right;">
						<c:if test="${mngrSessionVO.mngAuth == '99'}">
							<a href="#none" onclick="fn_changeMngsite('SYSTEM','시스템관리');" class="btn btn-default">시스템관리</a>
						</c:if>
					</div>
				</div>
				<div class="col-xs-12">
				<form name="siteMngForm" id="siteMngForm" method="post" style="height:630px; background:white; overflow-y: auto;">
					<input type="hidden" name="siteCode" />
					<input type="hidden" name="siteName" />

					<table class="table table-bordered">
			        	<colgroup>
							<col style="width:50%;">
							<col style="width:50%;">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">사이트 이름</th>
								<th scope="col">사이트 코드</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="mngSite" items="${mngrSessionVO.mngSiteList}" varStatus="status">
								<tr>
									<td><a href="#none" onclick="fn_changeMngsite('${mngSite.siteCode}','${mngSite.siteName}');"><c:out value="${mngSite.siteName}" /></a></td>
									<td><c:out value="${mngSite.siteCode}" /></td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(mngrSessionVO.mngSiteList ) == 0}">
								<tr><td colspan="2" class="tac">데이터가 없습니다.</td></tr>
							</c:if>
						</tbody>
					</table>
				</form>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>

	function fn_siteMngModal(){
		$("#siteModal").show();
	}

	function fn_closeSiteMngModal() {
		$("#siteModal").hide();
	}

	function fn_changeMngsite(siteCode,siteName){
		var frm = document.siteMngForm;
		frm.siteCode.value = siteCode;
		frm.siteName.value = siteName;
		frm.action = "/_mngr_/menu/menu_comm_changeMngSite_proc.do";
		frm.submit();
	}

	$(function() {
		var authCode = "<c:out value='${mngrSessionVO.mngAuth}' />"
		if (authCode === '80') {
			$("#LEFT_SITEMNG").hide();
		}
	})

</script>
<!-- 사이트선택 모달창 E-->