<%@ page contentType="text/html;charset=UTF-8" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Pragma" content = "no-cache">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <title></title>
    <style type="text/css">
        *{-webkit-box-sizing:border-box; -moz-box-sizing:border-box; -ms-box-sizing:border-box; -o-box-sizing:border-box; box-sizing:border-box;}
        body,div,p{margin:0; padding:0; font-weight:normal; border:0}
        a{text-decoration:none; color:inherit; background-color: transparent; -webkit-text-decoration-skip: objects}
        body {font-family: Arial, Tahoma, sans-serif;font-size: 12px;color: #666;line-height: 1;vertical-align: baseline;background-color: #fff}
        .login-wrap {margin: 0 auto;width: 610px;height: 540px;text-align: center;background-color: #ecedef}
        .login-wrap > div {margin: 0 auto;width: 375px}
        .login-wrap > div > img {margin: 66px 0 35px}
        .login-wrap input {display: block;padding: 0 10px;width: 100%;height: 55px;font-size: 18px;color: #666;border: 0;border-bottom: 1px solid #ccc;background-color: #ecedef;border-radius: 0;outline: none;-webkit-touch-callout: default !important;-webkit-user-select: text !important}
        .login-wrap input:focus {border-color: #eb9f00}
        .login-wrap .btn-login {cursor:pointer;display: block;margin: 25px 0 30px;width: 100%;height: 60px;line-height: 60px;font-size: 20px;text-align: center;color: #fff;background-color: #eb9f00}
        .login-wrap .notice {position: relative;padding-right: 150px;font-size: 11px;text-align: left;line-height: 1.7em;word-break: keep-all}
        .login-wrap .btn-link {display: block;position: absolute;right: 0;bottom: 0;font-size: 14px;font-weight: bold}
    </style>
    <script src="/resource/common/js/jquery-1.12.0.min.js"></script>
    <script type="text/javascript">

        var jsConfirm = function() {
            if ( $("#id").val() == "" ) {
                alert("아이디를 입력하세요.");
                $("#id").focus(); return false;
            }
            if ( $("#pwd").val() == "" ) {
                alert("비밀번호를 입력하세요.");
                $("#pwd").focus(); return false;
            }
            return true;
        };
    </script>
</head>

<body>
<form name="dataForm" id="dataForm" method="post" action="ER_loginAction.do" onsubmit="return jsConfirm();">
    <input type="hidden" name="menuNo" value="219" />
    <div class="login-wrap">
        <div>

            <img src="/resource/templete/cms1/img/login_logo.png">

            <input type="text" name="id" id="id" placeholder="아이디" >
            <input type="password" name="pwd" id="pwd" placeholder="비밀번호">

            <input type="submit" class="btn-login" value="로그인">

            <div class="notice">
                <p>* 성남산업진흥원 홈페이지 계정으로 로그인하시면 됩니다.</p>
                <p>* 회원가입은 성남산업진흥원 홈페이지에서 해 주세요.</p>
                <a class="btn-link" href="/SNIP/contents/registration.do" target="_blank">성남산업진흥재단 홈페이지 바로가기 &gt;</a>
            </div>

        </div>
    </div>
</form>
</body>
</html>