<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<link rel="shortcut icon" type="image/x-icon" href="${systemconfigVO.faviUrl}"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="format-detection" content="telephone=no" />
	<link href="/resource/common_adm/css/login-base.css"  rel="stylesheet" type="text/css" />
	<link href="/resource/common_adm/css/login-layout.css"  rel="stylesheet" type="text/css" />
	<link href="/resource/common_adm/css/AdminLTE.css"  rel="stylesheet" type="text/css" />
	<script src="/resource/common/js/jquery-1.12.0.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resource/common/jquery_plugin/validation/validator.js"></script>
    <script type="text/javascript">

		//<![CDATA[
		function checkForm(){
			if(Validator.validate(document.form1)){
				document.form1.submit();
			}
		}
	//]]>
	</script>

<title>${systemconfigVO.sysName} 관리자 모드</title>
</head>

<body>

	<div id="accessibility">
		<a href="#container">본문 바로가기</a>
	</div>

	<div id="container">
		<div class="cmsVer">
			<h4></h4>
		</div>
		<div class="centerLogo">
		</div>
		<div class="loginBg">
			<div class="lBg">
				<div class="loginWrap">
					<div class="l">
						<img src="/resource/common_adm/img/common/login_cl_img01.png" alt="큐브씨엠에스 관리자 로그인">
						<div class="loginBoxTxt">
							<p class="tit">MEMBER<br/>LOGIN</p>
							<p class="txt"><span class="companyName">${systemconfigVO.sysName}</span> 관리자 로그인 <img src="/resource/common_adm/img/common/login_cl_img02.png" alt="관리자로그인"></p>
						</div>
					</div>
				</div>
			</div>
			<div class="rBg">
				<div class="loginWrap">
					<div class="r">
						<div class="login-box-body" style="background: none;overflow: hidden;">
							<form method="post" action="/_mngr_/main/loginProc.do" name="form1" onsubmit="checkForm(); return false;">
								<input type="hidden" name="referer" value="<c:out value="${referer }" />" />
								<div class="formWrap">
									<div class="inputWrap">
										<input type="text" name="mngId" id="mngId" title="아이디 입력" class="form-control inp-long" placeholder="USER ID" autocomplete="off">
										<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
										<input type="password" name="mngPass" id="mngPass" title="비밀번호 입력" class="form-control inp-long" placeholder="Password" autocomplete="off">
									  	<span class="glyphicon glyphicon-lock form-control-feedback"></span>
									</div>
								</div>
								<div class="submit-btn">
										<button type="submit" class="btn btn-primary btn-block btn-flat btn-login">LOGIN</button>
								</div>
      						</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>