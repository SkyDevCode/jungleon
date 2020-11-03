<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

				<div class="login-tit">
                   <h3>SNIP 방문을 환영합니다!</h3>
                   <p>회원 로그인 후 성남산업진흥원의 다양한 혜택과 서비스를 이용하실 수 있습니다. </p>
               </div>
               <div class="login-wrap">
                   <div class="login-formbox">
                       <form id="loginForm" name="loginForm" method="post" action="" onsubmit="fn_login(); return false;">
                           <fieldset>
                               <legend>로그인 서비스</legend>
                                <div class="login--fm">
                                    <ul>
                                        <li class="id">
                                            <input type="text" id="id" name="id" title="아이디 입력하세요" maxlength="20" placeholder="아이디">
                                        </li>
                                        <li class="pw">
                                            <input type="password"  id="pass" name="pass"  title="비밀번호 입력하세요" maxlength="20" autocomplete="off" placeholder="비밀번호">
                                        </li>
                                    </ul>
                                    <button type="submit" d="btnSubmit" name="btnSubmit" class="btn btn-login">로그인</button>
                                </div>
                            </fieldset>
                       </form>
                       <ul class="login-help">
                           <li><span class="text">아직 성남산업진흥원 회원이 아니신가요?</span> <span class="btn-area"><a href="/${siteCode}/contents/registration.do" class="btn btn-blue btn-join">회원가입</a> </span></li>
                           <li><span class="text">아이디와 비밀번호를 잊어버리셨나요? </span>  <span  class="btn-area"><a href="/${siteCode}/contents/find.do" class="btn btn-gray btn-member-help">아이디찾기</a> <a href="/${siteCode}/contents/find-pass.do" class="btn btn-gray btn-member-help">비밀번호찾기</a></span></li>
                       </ul>
                   </div>
               </div>
<div class="login-setup-box">
					<div class="login-setup-top">
						<h4>키보드보안프로그램 설치</h4>
						<ul>
							<li>키보드로 입력되는 정보가 유출되거나 변조되지 않도록 보호해주는 프로그램입니다. </li>
							<li>설치하지 않으셔도 홈페이지 이용에 아무런 지장이 없으나 보다 안전한 개인정보 보호를 위해설치를 권장합니다.</li>
						</ul>
						<button type="button" class="btn btn-setup" onclick="raon();">설치하기</button>
					</div>
					<div class="login-setup-bottom">
키보드 보안프로그램 설치 후 키보드 입력이 안되는 경우 “제어판>프로그램 및 기능”에서 “nProtect Online Security V1.0” 삭제<br>
※ 계속 문제 발생시 ㈜잉카인터넷FAQ참조(<a href="http://www.nprotect.com" target="_blank">http://www.nprotect.com</a>) 또는 고객센터 문의 1566-0808
					</div>
				</div>

		<form id="referForm" name="referForm" method="post">
			<c:forEach var="entry" items="${param}" varStatus="status">
				<input type="hidden" name="${entry.key}" value="${entry.value}"/>
		    </c:forEach>
		</form>


<script type="text/javascript" src="/resource/templete/cms1/src/js/rsa/jsbn.js"></script>
<script type="text/javascript" src="/resource/templete/cms1/src/js/rsa/rsa.js"></script>
<script type="text/javascript" src="/resource/templete/cms1/src/js/rsa/prng4.js"></script>
<script type="text/javascript" src="/resource/templete/cms1/src/js/rsa/rng.js"></script>
<script type="text/javascript">
function raon() {
	 window.open("/resource/raonsecure/raonnx/install/install.html", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
}
var rsa = new RSAKey();
rsa.setPublic("${RSAModulus}", "${RSAExponent}");

function fn_login(){
	var frm = document.loginForm;
    if (!ItgJs.fn_chkValue(frm.id, "아이디를 입력해 주세요.")) {
        return false;
    }
    if (!ItgJs.fn_chkValue(frm.pass, "비밀번호를 입력해 주세요.")) {
        return false;
    }
    //RSA 암호화 전송
    var id = rsa.encrypt($("#id").val());
    var pwd = rsa.encrypt($("#pass").val());
    $("#id").val(id);
    $("#pass").val(pwd);
    $.ajax({
        url: "/${siteCode}/module/${menuVO.menuCode}_loginProc.ajax"
        , data: $("#loginForm").serialize()
        , type: "post"
        , dataType: "json"
        , async: false
        , cache: false
        , success: function (data) {
            if (data.result != "2") {
            	$("#id").val('');
                $("#pass").val('');
                alert(data.message);
                return false;
            }
            else {
            	$("#id").val('');
                $("#pass").val('');
            	if (data.returnType==0) {
            		if (document.referrer) {
            			var frm = document.referForm;
            			if(document.referrer.indexOf("Business1.do") != -1&&document.referrer.indexOf("schM=view") != -1) {
            				location.href=document.referrer;
           				}else if(document.referrer.indexOf("Business21.do") != -1&&document.referrer.indexOf("schM=view") != -1) {
            				location.href=document.referrer;
           				}else if(document.referrer.indexOf("Business31.do") != -1&&document.referrer.indexOf("schM=view") != -1) {
            				location.href=document.referrer;
           				}else if(document.referrer.indexOf("Business54.do") != -1) {
            				location.href=document.referrer;
           				}else{
	            			frm.action=document.referrer;
           				}
            			frm.submit();
                    }
                    else {
                        document.location.href = "/${siteCode}/main/index.do";
                    }
            	} else {
            		document.location.href  = data.url;
            	}

            }
        }
        , error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}
</script>
