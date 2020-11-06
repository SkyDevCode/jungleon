<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld"%>

<%
/**
 * @파일명 : mngrPwdChange.jsp
 * @파일정보 : 관리자패스워드변경
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

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>비밀번호 변경</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<!-- Bootstrap 3.3.5 -->
	<link rel="stylesheet"	href="${ctx}/resource/bootstrap/css/bootstrap.css">
	<!-- Font Awesome -->
	<link rel="stylesheet"	href="${ctx}/resource/font/font-awesome-4.7.0/css/font-awesome.min.css">
	<!-- Ionicons -->
	<link rel="stylesheet"	href="${ctx}/resource/font/ionicons-2.0.1/css/ionicons.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" 	href="${ctx}/resource/common_adm/css/AdminLTE.css">
	<link rel="stylesheet"	href="${ctx}/resource/common_adm/css/skins/skin-orange.css">
	<!-- iCheck for checkboxes and radio inputs -->
	<link rel="stylesheet" 	href="${ctx}/resource/plugins/iCheck/all.css">

    <link rel="stylesheet" type="text/css" href="${ctx}/resource/common/jquery_plugin/validation/validator.css" />

	<!--[if lt IE 9]>
	        <script src="${ctx}/resource/common/js/html5shiv.js"></script>
    <![endif]-->
</head>
<body class="hold-transition login-page">
	<div class="login-box">
		<div class="login-logo">
			<b>비밀번호</b>변경
		</div>
		<div class="login-box-body">
			<p class="login-box-msg">비밀번호를 변경해 주세요</p>
			<form name="updatePassForm" id="updatePassForm" method="post" onsubmit="fn_save(); return false;">
				<input type="hidden" name="id" value="${mngId}">
				<div class="form-group has-feedback">
					<input type="password" class="form-control required" id="curPass" name="curPass" title="현재비밀번호" placeholder="현재비밀번호">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<span id="pwHelp" class="help-block">(영문, 숫자, 특수문자조합 9자이상)</span>
				<div class="form-group has-feedback">
					<input type="password" class="form-control required" id="pass1" name="pass1" title="신규비밀번호" placeholder="신규비밀번호">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="password" class="form-control required" id="pass2" name="pass2" title="신규비밀번호확인" placeholder="신규비밀번호확인">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<button type="submit" class="btn btn-primary btn-block btn-flat">수정</button>
					</div>
					<!-- /.col -->
				</div>
			</form>

			<div class="social-auth-links text-center">
				<p>- OR -</p>
				<a href="/_mngr_/main/index.do" class="btn btn-default btn-block btn-flat">나가기</a>
			</div>
		</div>
	</div>

	<!-- jQuery 2.1.4 -->
	<script src="${ctx}/resource/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<!-- Bootstrap 3.3.5 -->
	<script src="${ctx}/resource/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/resource/plugins/datepicker/bootstrap-datepicker.js"></script>
	<!-- iCheck 1.0.1 -->
	<script src="${ctx}/resource/plugins/iCheck/icheck.min.js"></script>
	<!--  validator -->
	<script type="text/javascript" src="${ctx}/resource/common/jquery_plugin/validation/validator.js"></script>
	<!--  cms scripts -->
    <script type="text/javascript" src="${ctx}/resource/common/jquery_plugin/common_functions.js"></script>
	<script>
		$(function () {
	        $('input').iCheck({
				checkboxClass: 'icheckbox_square-blue',
				radioClass: 'iradio_square-blue',
				increaseArea: '20%' // optional
	        });
		});

    	//<[[!CDATA[
      	var checkFlag = false;

      	$(document).ready(function(){

      	});

		function fn_save(){
			var frm = document.updatePassForm;
			if(Validator.validate(frm)){
				var msg = ItgJs.fn_checkPass($("#pass1").val(), $("#pass2").val());
				if (msg == "") {
					$.ajax({
						url : "/_mngr_/main/loginMngrPwdChangeAjax.ajax",
						data : $("#updatePassForm").serialize(),
						type : "POST",
						success : function(result){
							console.log(result);
							alert(result.msg);
							//$("#curPass").val("");
							//$("#pass1").val("");
							//$("#pass2").val("");

							if (result.code == "200") {
								location.href="/_mngr_/main/logout.do";
							}else if (result.code == "403") {
								$("#curPass").focus();
							}else if (result.code == "404") {
								$("#pass2").focus();
							}else if (result.code == "405") {
								$("#pass1").focus();
							}else if (result.code == "406") {
								location.href="/_mngr_/main/login.do";
							}
						}
					});
				} else {
					alert(msg);
					$("#pass1").focus();
				}
			}
      	}
    //]]]>
    </script>
</body>
</html>

