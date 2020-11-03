<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : adminMainIndex.jsp
  * @Description : 관리자 메인 화면
  * @Modification Information
  * 
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  */  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><c:out value="${message.title }"/></title>
</head>
<body>
<form id="messageForm" name="messageForm" method="post">
	<c:forEach var="entry" items="${param}" varStatus="status">
		<input type="hidden" name="${entry.key}" value="${entry.value}"/> 
    </c:forEach>
</form>

<script type="text/javascript">
//<![CDATA[
<c:if test="${message.msg != ''}"> 
	alert("<c:out value="${message.msg}"/>");
</c:if>
try{
	goMessageFormUrl();
}catch(e){
	//location.href="/";
}
//]]>

function goMessageFormUrl(){
	var frm = document.messageForm;
	frm.action="${message.url}";
	frm.submit();
}
</script>
</body>
</html>