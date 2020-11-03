<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>처리 안내 알림</title>
    <script type="text/javascript">
<!--//
    	<c:if test="${not empty message}">
            alert("${message}");
        </c:if>
        history.back();
//-->
        </script>
</head>
<body>
<noscript><p>${message} <a href="<%=request.getHeader("REFERER")%>" >이전으로 돌아가기 클릭</a></p></noscript>
</body>
</html>