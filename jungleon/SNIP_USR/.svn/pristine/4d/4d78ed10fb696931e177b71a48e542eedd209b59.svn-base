<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>


<div class="login-tit">
                   <h3>아이디 확인란 입니다.</h3>
                   <p>아래 항목을 입력하시면 이메일로 아이디를 발송해 드립니다. </p>
			   </div>
			   <div class="tab--menu tab-row2 mt-50">
					<ul>
						<li class="active"><a href="#none" onclick="fn_clickTap(event, this, 'C');return false;"><span>기업회원</span></a></li>
						<li><a href="#none" onclick="fn_clickTap(event, this, 'N');return false;"><span>개인회원</span></a></li>
					</ul>
				</div>
				<div id="displayLayer_C">
					<div class="login-wrap idpw-find">
						<form name="findIdFormCom" onsubmit="findIdProc('C'); return false;" method="post">
                        	<input type="hidden" name="sch" />
                        	<input type="hidden" name="siteCode" value="${siteCode }"/>
                        	<input type="hidden" name="idtype" value="C" />
							<fieldset>
								<legend>아이디 찾기</legend>
								<div class="member-help">
									<ul>
										<li class="id">
											<strong>회사명</strong>
											<input type="text" name="comNm" maxlength="50" class="inp_txt wd-350"  title="회사명을 입력하세요" >
										</li>
										<li class="pw">
											<strong>사업자등록번호</strong>
											<input type="text" name="busiRegNo" maxlength="10" class="inp_txt wd-350" title="사업자등록번호를 입력하세요">
										</li>
									</ul>
								</div>
							</fieldset>
						</form>
				   </div>
				   <div class="btn-wrap text-c">
						<a href="javascript:findIdProc('C');" class="btn btn-blue btn-join ">아이디 찾기</a>
				   </div>
				</div>
				<div id="displayLayer_N" style="display: none;">
					<div class="login-wrap idpw-find">
						<form name="findIdFormMem" onsubmit="findIdProc('N'); return false;" method="post">
							<input type="hidden" name="sch" />
                        	<input type="hidden" name="siteCode" value="${siteCode }"/>
                        	<input type="hidden" name="idtype" value="N" />
							<fieldset>
								<legend>아이디 찾기</legend>
								<div class="member-help">
									<ul>
										<li class="id">
											<strong>성명</strong>
											<input type="text" name="name" maxlength="20" class="inp_txt wd-350"  title="성명을 입력하세요" >
										</li>
										<li class="pw">
											<strong>이메일</strong>
											<input type="text" name="email" maxlength="50" class="inp_txt wd-350" title="이메일을 입력하세요">
										</li>
									</ul>
								</div>
							</fieldset>
						</form>
					</div>
					<div class="btn-wrap text-c">
						<a href="javascript:findIdProc('N');" class="btn btn-blue btn-join ">아이디 찾기</a>
					</div>
				</div>
<script type="text/javascript">
	function fn_clickTap(event, obj, tp) {
		$("div.tab--menu > ul > li").removeClass("active");
		$(obj).parent("li").addClass("active");
		$("div[id^='displayLayer_']").css("display", "none");
		$("#displayLayer_" + tp).css("display", "block");
	}
	function findIdProc(tp) {
		var frm;
		if(tp == "C") {
			frm = document.findIdFormCom;
			if(frm.comNm.value =="") {
				alert("회사명을 입력해주세요.");
				return false;
			}

			if(frm.busiRegNo.value =="") {
				alert("사업자등록번호를 입력해주세요.");
				return false;
			}
		} else {
			frm = document.findIdFormMem;
			if(frm.name.value =="") {
				alert("이름을 입력해주세요.");
				return false;
			}

			if(frm.email.value =="") {
				alert("이메일을 입력해주세요.");
				return false;
			}
		}
		frm.sch.value = "id";
		frm.submit();
	}

</script>
