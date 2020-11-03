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
<!-- <link href="/resource/common/css/jquery-ui.css"  rel="stylesheet" type="text/css" /> -->
<!-- <link href="/resource/common/css/owl.carousel.css"  rel="stylesheet" type="text/css" /> -->
	<link href="/resource/common_adms/css/base.css"  rel="stylesheet" type="text/css" />
	<link href="/resource/dist/css/AdminLTE.css"  rel="stylesheet" type="text/css" />
	<link href="/resource/common_adms/css/layout.css"  rel="stylesheet" type="text/css" />
	<script src="/resource/common/js/jquery-1.12.0.min.js"></script>
<!-- <script src="/resource/common/js/jquery-ui.min.js"></script> -->
<!-- <script src="/resource/common/js/owl.carousel.min.js"></script> -->
<!-- <script src="/resource/common/js/jquery.js"></script> -->
<!--[if lte IE 9]><script src="../../js/html5shiv.js"></script><![endif]-->
	<script type="text/javascript" src="<%= request.getContextPath() %>/resource/common/jquery_plugin/validation/validator.js"></script>


<title>${systemconfigVO.sysName} 관리자 모드</title>
</head>

<body>

	<div id="accessibility">
		<a href="#container">본문 바로가기</a>
	</div>

	<div id="container">
		<div class="cmsVer">
			<h4>큐브씨엠에스 v3.05</h4>
		</div>
		<div class="centerLogo">
		</div>
		<div class="loginBg">
			<div class="lBg">
				<div class="loginWrap">
					<div class="l">
						<img src="/resource/common_adms/img/common/login_cl_img01.png" alt="큐브씨엠에스 관리자 로그인">
						<div class="loginBoxTxt">
							<p class="tit">MEMBER<br/>LOGIN</p>
							<p class="txt"><span class="companyName">${systemconfigVO.sysName}</span> 관리자 로그인 <img src="/resource/common_adms/img/common/login_cl_img02.png" alt="관리자로그인"></p>
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
									<!-- <div class="userSel">
										<p class="state">
											<input type="checkbox" id="loginChk" name="ID_auto">
											<label for="loginChk">
											<span class="check_box"></span>
											ID 저장
											</label>
										</p>
										<ul class="userJoin">
											<li><a href="#">ID<span class="hide">찾기</span></a>/<a href="#">비밀번호 찾기</a></li>
											<li><a href="#">회원가입</a></li>
										</ul>
									</div> -->
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
<script type="text/javascript" src="/resource/templete/cms1/src/js/rsa/jsbn.js"></script>
<script type="text/javascript" src="/resource/templete/cms1/src/js/rsa/rsa.js"></script>
<script type="text/javascript" src="/resource/templete/cms1/src/js/rsa/prng4.js"></script>
<script type="text/javascript" src="/resource/templete/cms1/src/js/rsa/rng.js"></script>

    <script type="text/javascript">

		//<![CDATA[
		function checkForm(){
			if(Validator.validate(document.form1)){
				 var rsa = new RSAKey();
			    rsa.setPublic("${RSAModulus}", "${RSAExponent}");
			    //RSA 암호화 전송
			    var id = rsa.encrypt($("#mngId").val());
			    var pwd = rsa.encrypt($("#mngPass").val());
			    $("#mngId").val(id);
			    $("#mngPass").val(pwd);
				document.form1.submit();
			}
		}
	//]]>
	</script>
</body>
</html>