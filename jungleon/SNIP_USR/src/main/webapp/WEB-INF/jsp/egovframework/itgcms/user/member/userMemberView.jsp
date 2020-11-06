<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
	<div class="form-must-notic mt-0"> <a href="/${siteCode}/contents/member-edit.do" class="btn btn-blue btn-join ">수정(비밀번호 변경)</a> </div>
                <table class="table table-join">
                    <caption class="ir-text">회원가입 테이블</caption>
                    <colgroup class="n_mobile">
                        <col width="15%">
                        <col width="35%">
                        <col width="15%">
                        <col width="">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="row">아이디</th>
                            <td colspan="3">
                                <c:out value="${memberVO.id }" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">비밀번호 힌트</th>
                            <td>
                            	<c:out value="${memberVO.pwdQuestName }" />
                            </td>
                            <th scope="row">비밀번호 답변</th>
                            <td>
                                 <c:out value="${memberVO.pwdAnswer }" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">성명</th>
                            <td><c:out value="${memberVO.name }" /></td>
                            <th scope="row">성별</th>
                            <td>
                            	<c:out value="${ufn:deCode(memberVO.sex, 'M,남자,F,여자','-') }" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">생년월일</th>
                            <td colspan="3">
                                <c:out value="${memberVO.birth }" />   <span class="ml-10"><c:out value="${ufn:deCode(memberVO.birthType, '1,양력,0,음력','-') }" />   </span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">전화번호</th>
                            <td>
                                <c:out value="${memberVO.phone }" />
                            </td>
                            <th scope="row">핸드폰번호</th>
                            <td>
                                <c:out value="${memberVO.mobile }" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">이메일</th>
                            <td colspan="3">
                                 <c:out value="${memberVO.email }" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">주소</th>
                            <td colspan="3">
                                <c:out value="${memberVO.areaCdName }" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">메일링서비스</th>
                            <td colspan="3">
                               	 <c:out value="${ufn:deCode(memberVO.emailYn, 'Y,수신합니다.,N,수신하지 않습니다.','-') }" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">관심사업</th>
                            <td colspan="3">
                                <c:set var="arrConcern" value="${fn:split(memberVO.concerns, ',') }" />
	                            <c:set var="strConcern" value="" />
	                            <c:forEach var="concern" items="${arrConcern }">
	                            	<c:set var="strConcern" value="${strConcern } / ${concernsMap[concern] }" />
	                            </c:forEach>
	                            <c:out value="${fn:substring(strConcern, 2, fn:length(strConcern)) }" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">성남벤처넷을 어떻게<br> 알게 되셨나요?</th>
                            <td colspan="3">
                            	<c:out value="${ufn:deCode(memberVO.knowpath, '1,포털사이트(검색),2,이메일,3,팩스/방문,4,유관기관(배너),5,언론매체,6,기타', '-') }" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                 <div class="btn-wrap text-c">
                     <a href="/${siteCode}/contents/member-withdrawal.do" class="btn btn-gray btn-join ">탈퇴</a>
                 </div>