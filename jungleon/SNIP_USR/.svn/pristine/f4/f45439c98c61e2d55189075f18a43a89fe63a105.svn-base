<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
	<div class="login-tit">
                    <h3>안녕하십니까? 성남산업진흥원입니다.</h3>
                    <p>회원님께서 성남산업진흥원 웹사이트를 이용하시는데 불편한 점 및 개선 사항이 있으셨다면, <br>
                        언제라도 웹사이트 운영자에게 이메일을 보내주시기 바랍니다.<br>
                        건의주신 내용은 적극 수렴하여 더 나은 서비스를 제공드리는데 있어 반영토록 노력하겠습니다.<br>
                        회원탈퇴를 하시면 성남산업진흥원 사이트의 서비스가 중지됩니다.<br>또한 회원가입시 입력하셨던 회원님의 아이디는 더 이상 사용할 수 없으며 <br>
                        회원님의 모든 정보는 삭제되니, 유의하시기 바랍니다.
                         </p>
                </div>
                <div class="login-wrap">                   
                     <form name="loginForm" id="loginForm" method="post" onsubmit="fn_checkUser();return false;">
                         <fieldset>
                             <legend>회원 비밀번호 확인</legend>
                             <div class="member-help mypage">
                                 <ul>
                                     <li class="id">
                                         <strong>아이디</strong> 
                                         <input type="text" id="id" name="id" maxlength="20" value="<c:out value="${ufn:getUserSessionVO().id}" />" readonly="readonly" class="inp_txt wd-160" title="아이디를 입력하세요">
                                     </li>
                                     <li class="pass">
                                         <strong>비밀번호</strong> 
                                         <input type="password"  id="pass" name="pass" maxlength="20" autocomplete="off" class="inp_txt wd-160" title="비밀번호를 입력하세요">
                                                      
                                     </li>                                        
                                 </ul>                                    
                             </div>
                         </fieldset>
                     </form>
                 </div>
                 <div class="btn-wrap text-c">                
                     <button type="button" onclick="fn_checkUser()" class="btn btn-blue btn-join " id="pop01">확인</button>
                 </div>      
                 <script>
                 function fn_checkUser(){
                		var frm = document.loginForm;
                		if(frm.id.value == "") {
                			alert("아이디를 입력해 주세요.");
                			return false;
                		}
                		if(frm.pass.value == "") {
                			alert("비밀번호를 입력해 주세요.");
                			return false;
                		}
                		if(confirm("정말로 탈퇴 하시겠습니까?")) {
	                	    frm.action = "/${siteCode}/module/${menuCode}_withdrawalProc.do";
	                	    frm.submit();
                		}
                	}
                 </script>