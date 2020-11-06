<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
				<form name="form1" method="post" onsubmit="fn_goCheck(); return false;">
				<div class="login-tit">
                    <h3>회원 비밀번호 확인</h3>
                    <p>비밀번호를 입력해주세요. </p>
                </div>
                <div class="login-wrap">                   
                     <form>
                         <fieldset>
                             <legend>회원 비밀번호 확인</legend>
                             <div class="member-help mypage">
                                 <ul>
                                     <li class="id">
                                         <strong>아이디</strong> 
                                         <span class="text"><c:out value="${ufn:getUserSessionVO().id }" /></span>
                                     </li>
                                     <li class="pass">
                                         <strong>비밀번호</strong> 
                                         <input type="password" name="pass" id="pass" maxlength="20" autocomplete="false" class="inp_txt wd-160" title="비밀번호를 입력하세요">
                                     </li>                                        
                                 </ul>                                    
                             </div>
                         </fieldset>
                     </form>
                 </div>
                 <div class="btn-wrap text-c">                
                     <a href="#none" onclick="fn_goCheck(); return false;" class="btn btn-blue btn-join ">확인</a>
                 </div>   
                 </form>    
                 <script>
                 	function fn_goCheck(){
                 		var frm = document.form1;
                 		if(frm.pass.value == "") {
                 			alert("비밀번호를 입력 해 주세요.");
                 			return false;
                 		}
                 		frm.action="?";
                 		frm.submit();
                 	}
                 </script>