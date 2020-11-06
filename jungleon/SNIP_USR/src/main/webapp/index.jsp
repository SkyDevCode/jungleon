<%@page import="java.io.IOException"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String reqURL = request.getRequestURL().toString() ;

if ( reqURL.indexOf("www.snventure.net") > -1
    || reqURL.indexOf("m.snventure.net") > -1
    || reqURL.indexOf("snventure.net") > -1 ) {

    try {
%>
<script type="text/javascript">
        location.href = "https://www.snip.or.kr";
</script>
<%
        } catch (Exception e) {
%>
<script type="text/javascript">
        location.href = "/SNIP";
</script>
<%
        }
}
%>
<script type="text/javascript">
        location.href = "/SNIP";
</script>