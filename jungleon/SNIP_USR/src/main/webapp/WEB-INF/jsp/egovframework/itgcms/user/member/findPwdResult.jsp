<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>

<div class="login-tit">
                   <h3>2단계</h3>
                   <p><span class="point-color"><c:out value="${result.name }" /> (<c:out value="${result.id }" />)</span> 님 !! 아래 질문에 답해주세요.<br>
                    본인확인 질문 : <span class="point-color">
                    <c:forEach var="code" items="${pwdQuest }">
						<c:if test="${code.ccode eq result.pwdQuest }">
							<c:out value="${code.cname }" />
						</c:if>
					</c:forEach>
                    </span> </p>
			   </div>
			  
					<div class="login-wrap idpw-find mt-50">                   
							<form name="form1" method="post" onsubmit="fn_confirm();return false;">
							<input type="hidden" name="id" value="${result.id }"/>
							<input type="hidden" name="sch" />
							<input type="hidden" name="siteCode" value="${siteCode }"/>
								<fieldset>
									<legend>비밀번호 찾기</legend>
									<div class="member-help">
										<ul>
											<!-- <li class="id">
												<strong>질문</strong> 
												<span class="anser">답변입니다답변입니다답변입니다답변입니다</span>
											</li>      -->                                       
											<li class="id">
												<strong>답변</strong> 
												<input type="text" name="pwdAnswer" maxlength="20" class="inp_txt wd-350"  title="아이디를 입력하세요" >
											</li>
											<li class="pw">
												<strong>이메일</strong> 
												<input type="text" class="inp_txt wd-350" name="email" maxlength="50" title="이메일을 입력하세요" placeholder="임시 비밀번호 받을 이메일 주소를 입력해 주세요.">                                       
											</li>                                           
										</ul>                                    
									</div>
								</fieldset>
							</form>
					</div>
					<div class="btn-wrap text-c">                
						<a href="javascript:fn_confirm();" class="btn btn-blue btn-join ">비밀번호 받기</a>
					</div>
					
					
<script>
function fn_confirm(){
	var frm = document.form1;
	if(frm.pwdAnswer.value == "") {
		alert("답변을 입력하세요");
		return false;
	}
	if(frm.email.value == "") {
		alert("이메일을 입력하세요");
		return false;
	}
	frm.sch.value = "sendMail";
	frm.action = "find.do";
	frm.submit();
}

</script>