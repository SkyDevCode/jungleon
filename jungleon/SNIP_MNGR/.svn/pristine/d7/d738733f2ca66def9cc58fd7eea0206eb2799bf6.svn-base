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
        function jsGoPart() {
            window.open('/vnet/fe/snv/magazine/PR_partFrm.do', '_blank', '');
            window.open('about:blank','_self').close();
        }
    </script>
</head>

<body>
<img src="/new/img/main/190422_pop.jpg" border="0" style="cursor:pointer" onclick="jsGoPart()" alt="SAE MOBILUS TECHNICAL PAPER
서비스 이용안내


본 서비스는 성남산업진흥원이 SAE 컨텐츠(SAE MOBILUS TECHNICAL PAPER) 서비스를 
성남벤처넷(www.snip.or.kr)을 통해서 성남벤처넷 성남기업회원에게 제공하고자 SAE 
미국본사와 직접 체결하여 SAE로부터 독점권을 부여받은 국내 기업을 통하여서비스를 
진행하게 되었습니다.  

SAE 컨텐츠(SAE MOBILUS TECHNICAL PAPER) 서비스는 성남벤처넷 성남 기업회원분들께서 
무료로 사용하실 수 있도록 제공하고 있습니다. 성남 관내 기업회원께서도 SAE 콘텐츠 
사용에 있어서 해당 의무조항들을 준수할 수 있도록 협조바랍니다. 

성남 기업회원에서 의무조항을 불이행시 발생되는 책임 소재는 성남산업진흥원은 제외되며 
해당 기업에 책임이 있음을 공지드립니다.     




SAE MOBILUS 이용자 의무사항 


1. 성남벤처넷 성남기업회원만 사용가능

  : 성남벤처넷 성남기업회원으로 등록된 회사 주소인 장소에서만 접속하셔야 하며, 
    대표 회사 ID로 접속하여 이용하셔야 합니다.

2. 자료에 대한 판매, 재판매, 임대,임대, 재라이선스, 양도 금지

3. 자료에 기초한 변경,수정,개조,각색 등의 파생작업 금지

4. 자료내에 저작권 정보나 공지의 삭제 또는 누락 금지

5. 대량 다운로드의 제한 

   : 30분이내에 50건 이상을 다운로드 받았을 경우 경고성 메일이 자동 발송

   : 30분 이내에 100건 이상을 다운로드 받으셨을 경우 서비스가 자동 차단


※ 사용하기 버튼을 통해 온라인 서비스를 이용한 경우에는 이용안내에 동의한 것으로 간주함 


온라인 동의 후 사용하기


SNIP 성남산업진흥원 로고 

">
</body>
</html>
</c:if>