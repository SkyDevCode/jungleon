<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="${ctx}/resource/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>

	var naver_id_login = new naver_id_login("${naver.smAppkey}", "${naver.etc1}");
	
	if (naver_id_login.oauthParams.code != null) {
		opener.nvResetAccessToken("${naver.smAccesstoken}", naver_id_login.getProfileData('email'), "Y", function(result){
			alert("로그인에 성공하였습니다.");
			window.close();
		});
	} else {
		alert("로그인에 실패하였습니다. 다시 시도해주세요.");
	}
	
	
</script>