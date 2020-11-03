<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="salmon" %>
<%@ page import="com.srpost.salmon.lang.DateFormatUtil" %>
<%@ page import="com.srpost.salmon2.lang.CookieUtil" %>                                     


<c:if test="${isInnerCom == 'A' || isInnerCom == 'N'}">
<html>
<head>
    <title></title>    
    <script type="text/javascript">
    <!-- 
    <c:if test="${isInnerCom == 'A'}">
    alert("성남시 관내 기업회원에게만 제공되는 서비스입니다. 기업회원 로그인 후 이용바랍니다.");
    </c:if>
    
    <c:if test="${isInnerCom == 'N'}">
    alert("성남시 관내 기업회원에게만 제공되는 서비스입니다. 감사합니다.");
    </c:if>
    
    window.open('about:blank','_self').close();
    //-->
    </script>
</head>

<body></body>
</html>
</c:if>
                                       
<c:if test="${isInnerCom == 'Y'}">
<%
//CookieUtil.setCookie(response, "__utmsp", DateFormatUtil.getToday(), 10); //10분
%>
<html>
<head>
    <title></title>    
    <script type="text/javascript">
        function goUrl() {
            document.frm.submit();
        }
    </script>
</head>

<body onload="goUrl()">

<form name="frm" method="post" action="https://saemobilus.sae.org">
    <input type="hidden" name="KEY" value="14B3727472D314AB12B508192D7B431A" />
    <input type="hidden" name="uid" value="${sessionScope['__usk'].id}" />
</form>

</body>
</html>
</c:if>