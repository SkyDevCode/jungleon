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

	<!-- AX5-UI -->
    <link rel="stylesheet" href="${ctx}/resource/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${ctx}/resource/common_adm/css/skins/skin-orange.css">

     <link rel="stylesheet" type="text/css" href="${ctx}/resource/plugins/ax5ui/ax5ui.itg.css"/>
    <script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/ax5core.min.js"></script>
    <script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/ax5ui.itg.js"></script>
    <script type="text/javascript" src="${ctx}/resource/plugins/ax5ui/jquery-direct.js"></script>

    <script type="text/javascript">

    $(document).ready(function(){

    	$.ajax({
	  		  url : "/_mngr_/main/loginExtraNotice_popup.do"
	  		, dataType : "html"
	  		, success : function(data){
	  			$("#popDiv").html(data);
	  		}
	  		, error : function(jqXHR,textStatus,e){
	  		}
	  	});

    	$("#popModal").show();


    	/* var popOption = "resizable=yes,status=yes,resizable=yes,scrollbars=yes, width=676,height=800,left=0,top=0";
        window.open("/_mngr_/main/loginExtraNotice_popup.do","공지",popOption); */
    });

		//<![CDATA[
		function checkForm(){
			if(Validator.validate(document.form1)){
				document.form1.submit();
			}
		}
	//]]>
	</script>

<title>국립중앙도서관 외부도서관사서 모드</title>
<style>
#container .loginBg > div.lBg {
    background-color: #00a65a;
}
#container .l .loginBoxTxt .tit {
	font-size:73px
}
@media screen and (max-width: 1400px) {
	#container .l .loginBoxTxt .tit {font-size:53px}
}
/*#container .l {padding-top:0}
#container .l > img {margin-top:70px}
#container .l .loginBoxTxt .subTit {
	font-size:30px;
    font-weight: bold;
    line-height:35px;
    margin-bottom: 15px;
}
#container .l .loginBoxTxt .subTit2 {
	display:inline-block;
	font-size:20px;
    font-weight: bold;
	border-bottom:1px solid #fff;
}

#container .l .loginBoxTxt .subTxt {
	font-size:15px;
	line-height:25px;
}
#container .centerLogo {background-image: url(/resource/common_adm/img/common/nl_center-logo2.png); background-size:100% auto}*/
/*#container .centerLogo {background-image: url(/resource/common_adm/img/common/nl_center-logo3.png); background-size:100% auto}*/
</style>
</head>

<body>

	<div id="accessibility">
		<a href="#container">본문 바로가기</a>
	</div>

	<div id="container">
		<div class="cmsVer">
			<h4>국립중앙도서관</h4>
		</div>
		<div class="centerLogo">
		</div>
		<div class="loginBg">
			<div class="lBg">
				<div class="loginWrap">
					<div class="l">
						<img src="/resource/common_adm/img/common/login_cl_img01.png" alt="관리자용 로그인">
						<div class="loginBoxTxt">
							<%--<p class="tit">MEMBER<br/>LOGIN</p> --%>
							<p class="tit">사서에게<br>물어보세요</p>
							<p class="txt"><span class="companyName">관리자용 로그인</span><img src="/resource/common_adm/img/common/login_cl_img02.png" alt="관리자용 로그인"></p>
						</div>
					</div>
				</div>
			</div>
			<div class="rBg">
				<div class="loginWrap">
					<div class="r">
						<div class="login-box-body" style="background: none;overflow: hidden;">
							<form method="post" action="/_mngr_/main/loginExtraProc.do" name="form1" onsubmit="checkForm(); return false;">
								<input type="hidden" name="referer" value="<c:out value="${referer }" />" />
								<div class="formWrap">
									<div class="inputWrap">
										<input type="text" name="loginId" id="loginId" title="아이디 입력" class="form-control inp-long" placeholder="USER ID" autocomplete="off">
										<%--<span class="glyphicon glyphicon-envelope form-control-feedback"></span> --%>
										<span class="glyphicon form-control-feedback"></span>
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
<div class="modal" id="popModal">
	<div class="modal-dialog">
		<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="$('#popModal').hide();"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">공지</h4>
		</div>
		<div class="modal-body"  id="popDiv" style="height: 700px; overflow: scroll;">
		</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</html>