<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<c:set var="mngrSessionVO" value="${ufn:getMngrSessionVO() }" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<c:if test="${fn:indexOf(siteconfigVO.faviUrl, '.') > 0}">
			<link rel="shortcut icon" type="image/x-icon" href="${siteconfigVO.faviUrl}" />
		</c:if>
		<title>테스트페이지</title>
		<!-- Tell the browser to be responsive to screen width -->
		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

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
		<script src="${ctx}/resource/dist/js/app.min.js"></script>
		<!-- AdminLTE for demo purposes -->
		<script src="${ctx}/resource/dist/js/demo.js"></script>
		    <!-- iCheck 1.0.1 -->
		<script src="${ctx}/resource/plugins/iCheck/icheck.min.js"></script>

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

		<!-- Theme style -->
		<link rel="stylesheet" href="${ctx}/resource/dist/css/AdminLTE.css">

		<link rel="stylesheet" href="${ctx}/resource/dist/css/skins/skin-orange.css">

		<!-- iCheck for checkboxes and radio inputs -->
		<link rel="stylesheet" href="${ctx}/resource/plugins/iCheck/all.css">
		<!-- Bootstrap datepicker -->
		<link type="text/css" href="${ctx}/resource/plugins/datepicker/datepicker3.css" rel="stylesheet" />
		<script type="text/javascript" src="${ctx}/resource/plugins/datepicker/bootstrap-datepicker.js"></script>

		<link rel="stylesheet" type="text/css" href="${ctx}/resource/common/jquery_plugin/validation/validator.css" />
		<script type="text/javascript" src="${ctx}/resource/common/jquery_plugin/validation/validator.js"></script>

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

	</head>
	<body>
		<form id="testForm" name="testForm" method="post">
			<input type="hidden" name="param1" />
			sPlainText : <input class="form-control input-sm f-wd-600" type="text" name="param2" />
			<a href="#none" onclick="submit(1)" class="btn btn-default">암호화</a>
			<a href="#none" onclick="submit(2)" class="btn btn-default">복호화</a><br/>
			sCipherText : <input class="form-control input-sm f-wd-200" type="text" name="result" />
		</form>

		<input class="test" type="radio" name="test" value="1" checked="checked"/>aaaaa
		<input class="test" type="radio" name="test" value="2" />bbbbb
		<input class="test" type="radio" name="test" value="3" />ccccc

		<script type="text/javascript">
			function submit(opt){
				var frm = document.testForm;
				frm.param1.value = opt;
				if(opt == 2) frm.param2.value = frm.result.value;
				$.ajax({
					url : "/comm/testproc.do"
					, data : $("#testForm").serialize()
					, dataType : "json"
					, type : "post"
					, success : function(data){
						console.log(data);
						frm.result.value = data.result;
					}
				});
			}


			$(".test").on("click",function(e){
				console.log(e);
				console.log(this.value);
				return false;

			});

		</script>




	</body>
</html>