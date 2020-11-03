<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ctt" uri="/WEB-INF/tlds/CreateTreeTag.tld"%>
<script>

function fn_goMenu(menuCode,menuType,menuMngurl){

// 	'0,폴더,1,CMS 컨텐츠,2,프로그램,3,게시판,4,링크,5,없음,6,리비전관리,7,인클루드링크'
	if(menuType != "0"){
		location.href=menuMngurl;
	}
}
</script>
<c:choose>
	<c:when test="${mngrSessionVO.currSiteCode == 'SYSTEM'}">
		<!-- 시스템메뉴(총괄) -->
		<ctt:getSysMenuTree tagOption="sys" menuList="${mngrSessionVO.mngSysMenuList}"/>
	</c:when>
	<c:otherwise>
		<!-- 사용자 메뉴 -->
		<ctt:getSysMenuTree tagOption="mngr" menuList="${mngrSessionVO.mngMenuList}"/>

		<!-- 사이트관리메뉴 -->
		<ctt:getSysMenuTree tagOption="sys" menuList="${mngrSessionVO.mngSysMenuList}"/>
	</c:otherwise>
</c:choose>
<script>ItgJs.NowPageById("${urlInfo.menuPfullcode}");</script>