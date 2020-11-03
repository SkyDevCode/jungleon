<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%@ taglib prefix="ora" uri="/WEB-INF/tlds/CustomTagSelectCodeList.tld" %>
<%
/**
 * @파일명 : userRentRegistStep2.jsp
 * @파일정보 : 사업신청 > 대관신청 > 상세정보 입력
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 04. 21. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<link rel="stylesheet" type="text/css" href="/resource/plugins/ax5ui/ax5ui.itg.css"/>
<script type="text/javascript" src="/resource/plugins/ax5ui/ax5core.min.js"></script>
<script type="text/javascript" src="/resource/plugins/ax5ui/ax5ui.itg.js"></script>
<script type="text/javascript" src="/resource/plugins/ax5ui/jquery-direct.js"></script>
               <div class="tab--menu tab-row2">
					<ul>
						<li><a href="/${siteCode }/contents/${menuCode}.do?schM=regist"><span>01. 대관 예약</span></a></li>
						<li class="active"><a href="/${siteCode }/contents/${menuCode}.do?schM=step2"><span>02. 상세 정보 입력</span></a></li>
					</ul>
				</div>
				<div class="hall-apply_detail">
					<form name="form1" id="form1" method="post" onsubmit="fn_goRegist(); return false;" enctype="multipart/form-data">
						<fieldset>
							<legend>대관신청 예약의 상세 정보를 입력하는 폼</legend>
							<div class="filedset">
								<div class="top_title_area">
									<h3>예약내용</h3>
									<div class="right_txt">
										<p>*모든 항목은 필수 입력 항목입니다. </p>
									</div>
								</div>

								<div class="board-list01">
									<table>
										<caption>대관신청예약의 담당자, 연락처, 이메일, 소재지, 고객구분, 회사명/단체명, 모임분류,인원, 반입물품, 첨부파일의 정보를 기재하는 표</caption>
										<tbody>
											<tr>
												<th scope="row"><label for="rName" class="tit">담당자</label></th>
												<td><input type="text" name="rName" id="rName" class="required" title="담당자" maxlength="10"/></td>
											</tr>
											<tr>
												<th scope="row"><label for="rTel" class="tit">연락처</label></th>
												<td><input type="text" name="rTel" id="rTel" class="validate-tel-num required" title="연락처" maxlength="20" placeholder="예 ) 010-1234-5678" /></td>
											</tr>
											<tr>
												<th scope="row"><label for="rEmail" class="tit">이메일</label></th>
												<td><input type="text" name="rEmail" id="rEmail" class="validate-email required" title="이메일" maxlength="50" placeholder="예) jo@snip.co.kr" /></td>
											</tr>
											<tr>
												<th scope="row"><label for="rAddr" class="tit">소재지</label></th>
												<td><input type="text" name="rAddr" id="rAddr" class="required" maxlength="50" title="소재지" placeholder="예) 경기도 성남시 분당구" /></td>
											</tr>
											<tr>
												<th scope="row"><span  class="tit">고객 구분</span></th>
												<td>
													<ul class="radio_list">
													<c:forEach var="customer" items="${custType}" varStatus="status">
														<li>
															<input type="radio" name="rCustType" id="rCustType${status.count }" ${ufn:checked('1', customer.value) } value="${customer.value }" />
															<label for="rCustType${status.count }">${customer.name }</label>
														</li>
													</c:forEach>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><label for="rComName">회사명 / 단체명</label></th>
												<td><input type="text" name="rComName" id="rComName" class="required" title="회사명 / 단체명" maxlength="50" /></td>
											</tr>
											<tr>
												<th scope="row"><span class="tit">모임 분류</span></th>
												<td>
													<ul class="radio_list">
													<c:forEach var="meet" items="${meetType}" varStatus="status">
														<li>
															<input type="radio" name="rMeetType" id="rMeetType${status.count}" ${ufn:checked('1', meet.value) } value="${meet.value }" />
															<label for="rMeetType${status.count}">${meet.name }</label>
														</li>
													</c:forEach>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><label for=rPersonNum class="tit">인원</label></th>
												<td><input type="text" name="rPersonNum"  class="required"id="rPersonNum" title="인원" maxlength=50" placeholder="예 ) 50명" /></td>
											</tr>
											<tr>
												<th scope="row"><label for="rCarry" class="tit">반입물품</label></th>
												<td><input type="text" id="rCarry" class="required" name="rCarry" maxlength="100" title="반입물품" placeholder="예) 55인치 스크린 6대, 빔프로젝트, 음향기기 등" /></td>
											</tr>
											<tr>
												<th scope="row"><span class="tit">파일업로드 <br />(사업자등록증, 공문 등)</span></th>
												<td>
														<!-- 파일업로드 폼 추가 시작 -->
												<c:import  url="/afile/fileuploadForm.do">
													<c:param name="formName" value="form1" />
													<c:param name="objectId" value="upload1" />
													<c:param name="fileIdName" value="fileId" />
													<c:param name="fileIdValue" value="${result.fileId}" />
													<c:param name="fileTypes" value="all" />
													<c:param name="maxFileSize" value="50" />
													<c:param name="maxFileCount" value="5" />
													<c:param name="useSecurity" value="false" />
													<c:param name="uploadMode" value="db" />
												</c:import>
												<!-- 파일업로드 폼 추가 끝 -->
													<div class="txt_help">

													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>

								<div class="top_title_area">
									<h3>대관시설 동의서</h3>
								</div>
								<div class="terms__box">
<pre>
1. 시설사용을 예약하면서 신청자는 아래 각호에 해당하는 시설 사용 준칙을 지킬 것을 동의합니다.
가. 예약한 시설물은 신청한 사용 목적으로만 사용하며, 시설물 사용 권리를 전대하거나 양도하지 않는다.
나. 시설물을 사용하면서 소음과 소란을 발생하지 않으며, 시설물을 훼손하지 않도록 주의한다.
다. 시설물을 분실 또는 훼손, 파손한 경우에는 정히 배상한다.
라. 주류(술), 음식 및 건물 손상이 우려되는 장비, 화기, 위험물 반입금지
마. 킨스타워 공용시설 대관 신청은 대관 희망 일자로부터 7일 전 완료
바. 킨스타워 공용시설 대관료 납부는 대관 희망 일자로부터 5일 전(주말 및 공휴일 제외) 완납 (※ 5일 전 미납 시 대관 취소)
완납된 대관료는 천재지변이나 시, 진흥원의 부득이한 사정으로 중지되는 경우 외에는 반환 불가
사. 킨스타워 정기대관(2일 이상 연속사용)의 경우는 반드시 담당자와 협의 후 진행
아. 킨스타워 대관 기간은 준비 시간부터 종료 후 퇴실 시간까지이며,
사용자가 직접 정리정돈을 하여야 한다.
자. 행사 종료 시 행사장 및 주변을 깨끗하게 뒷정리하여야 한다.
(쓰레기와 폐기물은 신청자가 직접 처리)
차. 시설 사용준칙과 관리자 지시에 적극적으로 협조한다.

2. 상기 제1항의 각호에 해당하는 사항이 발생할 경우 진흥원의 정당한 시정요구에 응하며 불응할 경우에는 진흥원으로부터 경고 조치를 받을 수 있으며 진흥원시설이용을 제한받을 수 있다.

이상 신청자는 선량한 공공기관 시설물 이용자로서 의무를 다하며 상기 사항을 지킬 것을 정히 동의합니다.
</pre>
								</div>
								<div class="terms-agree_txt">
									<input type="checkbox" name="agree1" value="Y" id="agree_txt_1" />
									<label for="agree_txt_1"><strong>동의</strong>합니다. </label>
									<span class="c-blue">(필수)</span>
								</div>

								<div class="top_title_area">
									<h3>개인정보 수집 및 이용</h3>
								</div>
								<div class="terms__box">
<pre>
▣ 개인정보 수집 및 이용(제공)에 대한 동의
1. 개인정보의 수집 및 이용 목적
    성남산업진흥원은 귀하의 기업 정보 및 개인 정보를 다음과 같은 목적으로 수집 및 이용합니다.
  1) 킨스타워 공용시설 사용 서비스 제공
  2) 기타 진흥원의 지원 사업 정보 제공

2. 개인정보 수집 항목
  필수항목 : 신청인, 성명, 사업장주소,(대표자)핸드폰,전화번호,이메일,사업자등록증,

3. 개인정보의 보유 및 이용기간
  수집된 정보는 관련 법령에 준하여 보유합니다. 단, 수집 목적이 달성된 경우에도 보존의
  필요성이 있는 경우에는 개인정보를 보유할 수 있습니다.

4. 성남산업진흥원은 귀하의 개인정보를 귀하의 동의 없이 제3자에게 제공하지 않습니다.
   다만, 아래의 경우에는 예외로 합니다.
 1) 법령의 규정에 의거하거나, 수사목적으로 적법한 절차에 따른 수사기관의 요구가 있는 경우
 2) 통계, 교육, 학술연구를 위해 특정 개인을 식별할 수 없는 형태로 가공된 정보를
    제공하는 경우

5. 위 사항에 대하여 동의를 거부할 권리가 있으며 동의 거부시에는 지원 서비스 제공이
   제한됩니다.
</pre>
								</div>
								<div class="terms-agree_txt">
									<input type="checkbox" name="agree2" value="Y" id="agree_txt_2" />
									<label for="agree_txt_2"><strong>동의</strong>합니다. </label>
									<span class="c-blue">(필수)</span>
								</div>

								<div class="btn-wrap">
									<button class="btn btn-gray_light btn-cencel larger-btn" onclick="if(confirm('입력한 내용을 모두 지우시겠습니까?')) document.form1.reset(); return false;">취소하기</button>
									<input type="submit" value="신청하기" class="btn larger-btn btn-apply btn-blue2"  />
								</div>

							</div>

						</fieldset>
					</form>
				</div>


 <script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>
<script>
$(function(){
	$(".subcont").addClass("hall-apply_detail_wrap");
})

function fn_goRegist(){
	var frm = document.form1;
	if(Validator.validate(frm)){
		if(frm.agree1.checked == false) {
			alert("대관시설 동의서에 동의해주세요.");
			return false;
		}

		if(frm.agree2.checked == false) {
			alert("개인정보 수집 및 이용에 동의해주세요.");
			return false;
		}
		if(!upload1_checkFileChangeSubmit("파일업로드")){
			return false;
		}
		if(confirm("신청하시겠습니까?")){
			frm.action = "/${siteCode}/module/${menuCode}_userRentRegistStep2Proc.do" ;
			frm.submit();
		}
	}
}
/*
window.onbeforeunload = function (e) {
  var message = "페이지를 이동하면 대관예약 신청이 취소됩니다.",
  e = e || window.event;
  // For IE and Firefox
  if (e) {
    e.returnValue = message;
  }

  // For Safari
  return message;
}; */
</script>