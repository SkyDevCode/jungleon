<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<%--<c:set var="userSessionVO" value="${ufn:getUserSessionVO() }" />--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
<!-- daum 도로명 주소 api -->
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

    <script>
	    function fn_init() {
			$("#oldPost").hide();
			$("#oldAddr1").hide();
			$("#oldAddr2").hide();

			ItgJs.selectBoxLocalNumber($("#phone1").attr("id"), "${memberInfo.phone1}");
			ItgJs.selectBoxMobileLocalNumber($("#mobile1").attr("id"), "${memberInfo.mobile1}");
			ItgJs.selectBoxEmail($("#email3").attr("id"), "${memberInfo.email2}");
			ItgJs.selectBoxLocalNumber($("#fax1").attr("id"), "${memberInfo.fax1}");
			ItgJs.selectBoxGetYear($("#year").attr("id"), "${memberInfo.year}");
			ItgJs.selectBoxGetMonth($("#month").attr("id"), "${memberInfo.month}");
			ItgJs.selectBoxGetDay($("#day").attr("id"), "${memberInfo.date}");
	    }

	    function fn_save(){

	    	var frm = document.correctjoin;

	    	if($("#position").val() === "" ) {
    			alert("직급은 필수 값입니다.\n직급을 확인해주세요.");
    			return false;
    		}

	    	<c:if test="${joinForm.phone == '1'}">
	    		if($("#phone1").val() === "" || $("#phone2").val() === "" || $("#phone3").val() === "") {
	    			alert("전화번호는 필수 값입니다.\n전화번호를 확인해주세요.");
	    			return false;
	    		} else if (isNaN($("#phone1").val())|| isNaN($("#phone2").val())|| isNaN($("#phone3").val())) {
	    			alert("전화번호는 숫자만 입력 가능합니다.\n전화번호를 확인해주세요.");
	    			return false;
	    		}
	    	</c:if>

	    	<c:if test="${joinForm.mobile == '1'}">
	    		if($("#mobile1").val() === "" || $("#mobile2").val() === "" || $("#mobile3").val() === "") {
	    			alert("휴대폰 번호는 필수 값입니다.\n휴대폰 번호를 확인해주세요.");
	    			return false;
	    		} else if (isNaN($("#mobile1").val())||isNaN($("#mobile2").val())||isNaN($("#mobile3").val())) {
	    			alert("휴대폰 번호는 숫자만 입력 가능합니다.\n휴대폰 번호를 확인해주세요.");
	    			return false;
	    		}
	    	</c:if>


	    	<c:if test="${joinForm.email == '1'}">
	    		if($("#email1").val() === "" || $("#email2").val() === "" ) {
	    			alert("이메일은 필수 값입니다.\n이메일을 확인해주세요.");
	    			return false;
	    		}
	    	</c:if>

	    	<c:if test="${joinForm.address == '1'}">
	    		if("" != $("#newPost").val()) {
	    			if ($("#newAddr1").val()=="" || $("#newAddr2").val()=="") {
	    				alert("주소가 입력되지 않았습니다.\n주소를 확인해주세요.");
	    				return false;
	    			}
	    		} else if ("" != $("#oldPost").val()) {
	    			if ($("#oldAddr1").val()=="" || $("#oldAddr2").val()=="") {
	    				alert("주소가 입력되지 않았습니다.\n주소를 확인해주세요.");
	    				return false;
	    			}
	    		} else {
	    			alert("주소가 입력되지 않았습니다.\n주소를 확인해주세요.");
	    			return false;
	    		}
	    	</c:if>


	    	<c:if test="${joinForm.fax == '1'}">
	    		if($("#fax1").val() === "" || $("#fax2").val() === "" || $("#fax3").val() === "") {
	    			alert("팩스 번호는 필수 값입니다.\n팩스 번호를 확인해주세요.");
	    			return false;
	    		} else if (isNaN($("#fax1").val())||isNaN($("#fax2").val())||isNaN($("#fax3").val())) {
	    			alert("팩스 번호는 숫자만 입력 가능합니다.\n팩스 번호를 확인해주세요.");
	    			return false;
	    		}
	    	</c:if>

	    	var date = $("#year > option:selected").val() + "-" + $("#month > option:selected").val() + "-" + $("#day > option:selected").val();
			if (frm.birth.required) {
				if ($.trim($("#month > option:selected").val()) == "") {
					alert("월을 선택해 주세요.");
					$("select[id=month]").focus();
					return false;
				}
				if ($.trim($("#day > option:selected").val()) == "") {
					alert("일을 선택해 주세요.");
					$("select[id='day']").focus();
					return false;
				}

				if (!ItgJs.fn_chkDate(date)) {
					alert("생년월일이 올바르지 않습니다.");
					return false;
				} else {
					$("#birth").val(date);
				}
			}

			if (ItgJs.fn_chkDate(date)) {
				$("#birth").val(date);
			}


	    	frm.submit();
	    }

	    function fn_emailChange() {
			if ($("#email3 > option:selected").val() == "") {
				$("#email2").show();
			}
			else {
				$("#email2").hide();
			}
			$("#email2").val($("#email3").val());
		}

	    $(function(){
	    	fn_init();
	    });


    </script>

	<div class="fixwidth">
		<div class="userInfo">
			<form action="/${siteCode}/module/${menuVO.menuCode}_update_memberinfo.do" name="correctjoin" method="post">
			<div class="tableform">
				<table class="table_style2 mt30">
					<caption>회원정보</caption>
					<colgroup>
						<col width="23%" style="min-width:100px;">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">아이디</th>
							<td class="user_data">
								<c:out value="${memberInfo.id}"/>
								<input type="hidden" value="${memberInfo.status}" name="status"/>
								<input type="hidden" value="${memberInfo.id}" name="id"/>
							</td>
						</tr>
						<tr ${ufn:styleDisplayNone(joinForm.name)}>
							<th scope="row">성명</th>
							<td class="user_data"><c:out value="${memberInfo.name}"/></td>
						</tr>
						<tr ${ufn:styleDisplayNone(joinForm.nickName)}>
							<th scope="row">별명</th>
							<td class="user_data">
								<c:out value="${memberInfo.nickName}"/>
								<input type="hidden" value="${memberInfo.nickName}" name="nickName"/>
							</td>
						</tr>

						<tr ${ufn:styleDisplayNone(joinForm.birth)}>
							<th scope="row">생년월일</th>
							<td class="user_data">
								<p class="anc f">
										<label for="year" class="blind">년도</label>
										<select class="inp_s" id="year" name="year"></select> 년
										<label for="month" class="blind">월</label>
										<select class="inp_s" id="month" name="month"></select> 월
										<label for="day" class="blind">일</label>
										<select class="inp_s" id="day" name="day"></select> 일
										<input type="hidden" id="birth" name="birth" required="required">
									</p>
							</td>
						</tr>
						<tr ${ufn:styleDisplayNone(joinForm.phone)}>
							<th scope="row">전화번호<c:out value="${joinForm.phone == 1 ? '   *' : ''}"/></th>
							<td class="user_data">
								<select id="phone1" class="inp_s" name="phone1" title="전화번호 처음 3자리 선택"></select> &nbsp;-&nbsp;
								<input id="phone2" class="inp_s num4" name="phone2" type="text" value="${memberInfo.phone2}" title="전화번호 중간자리 입력" maxlength="4"> &nbsp;-&nbsp;
								<input id="phone3" class="inp_s num4" name="phone3" type="text" value="${memberInfo.phone3}" title="전화번호 뒷자리 입력" maxlength="4"></td>
						</tr>
						<tr ${ufn:styleDisplayNone(joinForm.mobile)}>
							<th scope="row">휴대폰 번호<c:out value="${joinForm.mobile == 1 ? '   *' : ''}"/></th>
							<td class="user_data">
								<select id="mobile1" name="mobile1" title="핸드폰 번호 처음 3자리 선택" class="inp_s">
	                         	</select> &nbsp;-&nbsp;
                         		<input id="mobile2" class="inp_s num4" name="mobile2" type="text" value="${memberInfo.mobile2}" title="핸드폰 번호 중간 3~4자리 입력" maxlength="4"> &nbsp;-&nbsp;
		                         <input id="mobile3" class="inp_s num4" name="mobile3" type="text" value="${memberInfo.mobile3}" title="핸드폰 번호 뒷 4자리 입력" maxlength="4">
		                         <%-- <p class="anc crb">
									<input type="checkbox" id="smsYn" name="smsYn" value="Y" <c:out value="${memberInfo.smsYn eq 'Y' ? 'checked':''}"/>/><label for="smsYn">SMS수신</label>
								</p> --%>
                         	</td>
						</tr>
						<tr ${ufn:styleDisplayNone(joinForm.email)}>
							<th scope="row">이메일<c:out value="${joinForm.email == 1 ? '   *' : ''}"/></th>
							<td class="user_data">
								<input id="email1" class="inp_s" name="email1" type="text" value="${memberInfo.email1}" title="기본 이메일 주소">&nbsp;@&nbsp;
								<input type="text" id="email2" class="inp_s mr10 num5" name="email2" style="display: inline-block;" value="${memberInfo.email2}">
								<select id="email3" class="inp_s" name="email3" onchange="fn_emailChange();">	</select>
								<%-- <p class="anc crb">
									<input type="checkbox" id="emailYn" name="emailYn" value="Y" <c:out value="${memberInfo.emailYn eq 'Y' ? 'checked':''}"/>/><label for="emailYn">이메일 수신</label>
								</p> --%>
							</td>
						</tr>
						<tr ${ufn:styleDisplayNone(joinForm.fax)}>
							<th scope="row">팩스<c:out value="${joinForm.fax == 1 ? '   *' : ''}"/></th>
							<td class="user_data">
								<select id="fax1" name="fax1" title="팩스 번호 처음 3자리 선택" class="inp_s">
	                         	</select> &nbsp;-&nbsp;
		                         <input id="fax2" class="inp_s" name="fax2" type="text" value="${memberInfo.fax2}" title="팩스 번호 중간 3~4자리 입력" maxlength="4"> &nbsp;-&nbsp;
		                         <input id="fax3" class="inp_s" name="fax3" type="text" value="${memberInfo.fax3}" title="팩스 번호 뒷 4자리 입력" maxlength="4">
		                   </td>
						</tr>

						<tr ${ufn:styleDisplayNone(joinForm.address)}>
							<th class="th">주소</th>
							<td class="user_data">
								<p class="mb5">
									<label for="newPost" class="blind">우편번호</label>
									<input type="text" id="oldPost" name="oldPost" class="num5" readonly="readonly" value="${memberInfo.oldPost}"/>
									<input type="text" id="newPost" name="newPost" class="num5" readonly="readonly" value="${memberInfo.newPost}"/>
									<!-- <a href="javascript:void(0);" class="formBtn btnDgray" onclick="ItgJs.getDaumAddressPopup();">주소찾기[팝업]</a> -->
									<a href="javascript:void(0);" class="formBtn btnDgray" onclick="ItgJs.getDaumAddressLayer();">주소찾기[레이어]</a>

								</p>
								<p class="mb5">
									<label for="newAddr1" class="blind">기본주소</label>
									<input type="text" name="newAddr1" id="newAddr1" title="주소" class="solo" readonly="readonly" value="${memberInfo.newAddr1}" />
									<input type="text" name="oldAddr1" id="oldAddr1" title="주소" class="solo" readonly="readonly" value="${memberInfo.oldAddr1}" />
								</p>
								<p>
									<label for="newAddr2" class="blind">상세주소</label>
									<input type="text" name="newAddr2" id="newAddr2" title="상세주소" class="solo"  value="${memberInfo.newAddr2}"/>
									<input type="text" name="oldAddr2" id="oldAddr2" title="상세주소" class="solo"  value="${memberInfo.oldAddr2}"/>
									<span id="guide" style="color:#999"></span>
								</p>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btnwrap">
					<ul class="btn2">
						<li><a href="#a" onclick="fn_save();return false;">수정</a></li>
						<li><a href="/${siteCode}/contents/${siteconfigVO.passChangeMenuCode}.do">비밀번호 수정</a></li>
					</ul>
				</div>
			</div>
			</form>
		</div>
	</div>
<div id="daumPostLayer" style="display:none;position:fixed;overflow:hidden;z-index:2;-webkit-overflow-scrolling:touch;">
    <a href="#none" id="btnCloseLayer"
	     style="cursor:pointer;display:block;position:absolute;right:-3px;top:-3px;z-index:100" onclick="ItgJs.getDaumAddressLayerClose()"><img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png"  alt="닫기 버튼"></a>
</div>