<%@page import="egovframework.itgcms.util.AES256Cipher2"%>
<%@page import="egovframework.itgcms.user.member.web.UserLoginController"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String hash = (String) session.getAttribute("hash");
	String str="";
	String result="";
try {
	str = UserLoginController.replace(hash, "8B24C5B9F1174CA885DC28DF4820FB41", "+");
	result = AES256Cipher2.AES_Decode(str, "RiNo!@3ey^160909");
} catch (Exception var3) {
}
%>
<script src="/resource/templete_common/js/jquery-1.12.0.min.js"></script>
<script src="/resource/templete_common/js/jquery-ui.min.js"></script>
<script>
$(function(){
	var id="<%=result%>".split('---')[0];
	var pwd="<%=result%>".split('---')[1];
	$("#id2").val(id);
	$("#pwd2").val(pwd);
	document.dataForm2.submit();
});
</script>
<form name="dataForm2" id="dataForm" method="post" action="https://sub.snip.or.kr:4443/vnet/fe/login/NR_loginAction.do" title="아이디, 비밀번호 입력">
    <input type="hidden" name="menuNo" value="219" />
    <input type="text"  name="id" id="id2" title="아이디 입력"/>
    <input type="password" name="pwd" id="pwd2"  title="비밀번호 입력" />
</form>

<%--
<%@page import="net.imcore.AES256Cipher"%>
<%@page import="com.srpost.salmon.lang.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String hash = request.getParameter("hash");
	String str="";
	String result="";
try {
	str = StringUtil.replace(hash, "8B24C5B9F1174CA885DC28DF4820FB41", "+");
	result = AES256Cipher.AES_Decode(str, "RiNo!@3ey^160909");
} catch (Exception var3) {
}
%>
<script src="/resource/templete_common/js/jquery-1.12.0.min.js"></script>
<script src="/resource/templete_common/js/jquery-ui.min.js"></script>
<script>
$(function(){
	var id="<%=result%>".split('---')[0];
	var pwd="<%=result%>".split('---')[1];
	$("#id").val(id);
	$("#pwd").val(pwd);
	document.dataForm2.submit();
	self.close();
});
</script>
<form name="dataForm2" id="dataForm" method="post" action="https://www.snip.or.kr/vnet/fe/login/NR_loginAction.do">
    <input type="hidden" name="menuNo" value="219" />
    <input type="text"  name="id" id="id" title="아이디 입력"/>
    <input type="password" name="pwd" id="pwd"  title="비밀번호 입력" />
</form> --%>