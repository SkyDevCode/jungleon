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
 * @파일명 : userRentRegist.jsp
 * @파일정보 : 사업신청 > 대관신청 > 신청하기
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 04. 17. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
               <div class="tab--menu tab-row2">
					<ul>
						<li class="active"><a href="/${siteCode }/contents/${menuCode}.do?schM=regist"><span>01. 대관 예약</span></a></li>
						<li><a href="/${siteCode }/contents/${menuCode}.do?schM=step2"><span>02. 상세 정보 입력</span></a></li>
					</ul>
				</div>
				<form name="form1" method="post" onsubmit="fn_goRegist(); return false;">
					<input type="hidden" name="year" />
					<input type="hidden" name="month" />
					<fieldset>
						<legend>대관장소 ,장비 , 날짜, 시간을 선택할수 있는 폼</legend>
						<div class="clfx">
							<div class="hall-apply_reservation_step hall-apply_reservation_step1">
								<div>
									<h3 class="title">1. 대관 장소 선택</h3>
									<div class="step_innner">
										<ul>
										<c:forEach var="fac" items="${facility }" varStatus="status">
											<li>
												<input type="radio" name="rFacility" id="rFacility${status.count }" value="${fac.value }" onclick="fn_selectItem( 'rFacility', ${status.count} )" />
												<label for="rFacility${status.count }">${fac.name }</label>
											</li>
										</c:forEach>
										</ul>
									</div>
								</div>
							</div>

								<div class="hall-apply_reservation_step hall-apply_reservation_step2">
									<h3 class="title">2. 장비선택 (*중복선택 가능)</h3>
									<div class="step_innner">
										<ul>
										<c:forEach var="equip" items="${equipment }" varStatus="status">
											<li class="${ufn:IIF(equip.value eq '1', 'checked', '') }">
												<input type="checkbox" name="rEquipment" id="rEquipment${status.count }" ${ufn:checked(equip.value, '1') } value="${equip.value }" onclick="fn_selectItem( 'rEquipment', ${status.count} )"/>
												<label for="rEquipment${status.count }">${equip.name }</label>
											</li>
										</c:forEach>
											<li>
												<input type="checkbox" name="rEquipment" id="rEquipment0" value="" onclick="fn_selectItem( 'rEquipment', 0 )"/>
												<label for="rEquipment0">선택안함</label>
											</li>
										</ul>
									</div>
								</div>

								<div class="hall-apply_reservation_step hall-apply_reservation_step3">
									<h3 class="title">3. 날짜선택</h3>
									<div class="step_innner" id="dateListLayer">
									</div>
								</div>

								<div class="hall-apply_reservation_step hall-apply_reservation_step4">
									<h3 class="title">4. 시간선택 (*2시간부터 신청가능)</h3>
									<div class="step_innner" id="timeListLayer">
									</div>
								</div>
							</div>
			<div class="impossibility_txt_wrap">
				<div class="impossibility_txt">
					<span>예약불가</span>
				</div>
				<div class="impossibility_txt type2">
					<span>예약불가</span>
				</div>
			</div>
						<div class="hall-apply_reservation_table">
							<table>
								<caption>예약장소, 예약장비, 예약날짜, 예약시간, 사용료에 대한 정보가 기재된 표</caption>
								<colgroup>
									<col class="col1" />
									<col class="col2" />
									<col class="col1" />
									<col class="col2" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="print_rFacility">예약장소</label></th>
										<td colspan="3">
											<input type="text" title="예약장소" name="print_rFacility" id="print_rFacility" class="w50" readonly="readonly"/>
											<div class="btn_link_wrap">
												<a href="/${siteCode}/contents/Guidance41.do" class="btn_link"><span>킨스타워 센터소개</span></a>
												<a href="/${siteCode}/contents/Guidance42.do" class="btn_link"><span>제1비즈니스센터 소개</span></a>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="print_rEquipment">예약장비</label></th>
										<td>
											<input type="text" name="print_rEquipment" id="print_rEquipment" title="예약장비" readonly="readonly"/>
										</td>
										<th scope="row"><label for="print_rReserveDt">예약날짜</label></th>
										<td>
											<input type="text" name="print_rReserveDt" id="print_rReserveDt" title="예약날짜" readonly="readonly"/>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="print_rReserveTm">예약시간</label></th>
										<td>
											<input type="text" name="print_rReserveTm" id="print_rReserveTm" title="예약시간" readonly="readonly"/>
										</td>
										<th scope="row" class="price_input_tit"><label for="print_rCharge">사용료</label></th>
										<td class="price_input">
											<input type="text" name="print_rCharge" id="print_rCharge" title="사용료" readonly="readonly"/>
											<span class="c-red">※ 부가세 포함</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="btn-wrap">
							<a href="javascript:fn_goRegist();" class="btn btn-blueline icon-check">다음단계</a>
						</div>
					</fieldset>
				</form>


<script>
	var selectedFacility;
	var selYear = "${year}";
	var selMonth = "${month}";

	var oldSelItems = ["","","",""];// 0:장소, 1:장비, 2: 날짜, 3:시간

	// 장소선택이나 날짜의 이전/다음달 선택
	function fn_getCalendarTableRegist(year, month) {
		var schFacility = $("input[name='rFacility']:checked").val();
		if(schFacility == "") {
			alert("대관 장소를 선택 해 주세요.");
			return;
		}
		selYear = year;
		selMonth = month;
		oldSelItems[0] = schFacility;
		var data = "year=" + year + "&month=" + month + "&regist=Regist&schFacility="+schFacility;
		$("#dateListLayer").load("/${siteCode}/module/${menuCode}_userPrintCalendar.ajax", data);
		selectedFacility = schFacility;
		fn_unCheckItem("rFacility");
		fn_updateSelectItems();
		$("#timeListLayer").html("");
	}
	// 시간 목록
	function fn_getTimeList(date) {
		var data = "year=" + selYear + "&month=" + selMonth + "&date=" + date + "&schFacility="+selectedFacility;
		$("#timeListLayer").load("/${siteCode}/module/${menuCode}_userPrintTimeList.ajax", data);
	}

	$(function(){
		$(".subcont").addClass("hall-apply_reservation_wrap");
	})
	function fn_check(obj, checkFlag) {
		if(!checkFlag) {
			$(obj).attr("checked", true);
			$(obj).parent("li").addClass("checked");
		} else {
			$(obj).parent("li").removeClass("checked");
			$(obj).attr("checked", false);
		}
	}

	function fn_selectItem(nm, idx) {
		if("rFacility" == nm) { // radio 재선택해도 변동이 없음
			$("input[name='" + nm + "']:not("+idx+")").parent("li").removeClass("checked");
			$("#" + nm + idx).parent("li").addClass("checked");

			fn_getCalendarTableRegist(selYear, selMonth, ''); //날짜 목록 출력
			$("#timeListLayer").html("");
		} else if("rEquipment" == nm) { // checkbox 재선택하면 해제되어야 함.
			var checkFlag = $("#" + nm + idx).parent("li").hasClass("checked");

			if(Number(idx) == 0) { //선택안함 이면 나머지 선택 취소
				fn_check($("input[name='" + nm + "']:not("+idx+")"), true);
			} else { //장비선택이면 '선택안함' 선택 취소
				fn_check($("#" + nm + "0").parent("li"), true);
				fn_check($("#" + nm + idx), checkFlag);
			}
		} else if("rReserveDt" == nm) {
			$("input[name='" + nm + "']:not("+idx+")").parent("li").removeClass("checked");
			$("#" + nm + idx).parent("li").addClass("checked");

			fn_getTimeList($("#rReserveDt" + idx).val());
		} else if("rReserveTm" == nm) {
			// 체크가능한 시간인지 확인
			var oldTm = 0;
			var msg = "";
			//if($("#" + nm +""+ idx).attr("checked") != "checked") {
				$("input[name='rReserveTm']:checked").each(function(n, obj){
					var selTm = Number(obj.value);
					console.log(selTm)
					if(oldTm != 0) {
						if(selTm - oldTm != 1){
							//alert("시간선택은 연속으로 선택해주세요");
							msg = "시간선택은 연속으로 선택해주세요";
							return false;
						}
					}
					oldTm = selTm;
				});
				if(msg != "") {
						var ele  = document.getElementById(nm + idx);
						ele.checked = !ele.checked;
					if($("#" + nm +""+ idx).attr("checked") == "checked") { //체크된 상태이면 체크를 해제하려는 액션
					} else {

						$("#" + nm +""+ idx).parent("li").removeClass("checked");
					}

					alert(msg);
					return false;
				}
			//}
			var checkFlag = $("#" + nm + idx).parent("li").hasClass("checked");
			//checked class있으면 true이고. 액션은 체크 해제.
			fn_check($("#" + nm + idx), checkFlag);
		}
		fn_unCheckItem(nm);
		fn_updateSelectItems();
		fn_calculate();
	}

	function fn_unCheckItem(nm) {
		switch(nm) {
			case "rFacility":
				$("input[name='rReserveDt']").attr("checked", false);
			case "rReserveDt":
				$("input[name='rReserveTm']").attr("checked", false);
		}
	}
	// 하단 선택항목 출력부분
	function fn_updateSelectItems() {

		//예약장소명 출력
		$("#print_rFacility").val($("input[name='rFacility']:checked").next("label").text());
		//예약장비명 출력
		var strValue = "";
		$("input[name='rEquipment']:checked").each(function(){
			strValue += $(this).next("label").text() + ", ";
		});
		if(strValue.length > 0) strValue = strValue.substring(0, strValue.length -2);
		$("#print_rEquipment").val(strValue);
		//예약날짜 출력
		$("#print_rReserveDt").val($("input[name='rReserveDt']:checked").next("label").text());
		//예약시간 출력
		strValue = "";
		$("input[name='rReserveTm']:checked").each(function(){
			strValue += $(this).next("label").text() + "/";
		});
		if(strValue.length > 0) strValue = strValue.substring(0, strValue.length -1);
		$("#print_rReserveTm").val(strValue);
	}
	var bNext = false;
	function fn_calculate() {
		//
		$("#print_rCharge").val("");
		bNext = false;
		var rFacility = $("input[name='rFacility']:checked").val();
		var rEquipment = "";
		$("input[name='rEquipment']:checked").each(function(n){
			rEquipment += $(this).val();
			if(n < $("input[name='rEquipment']:checked").size() - 1) {
				rEquipment += ",";
			}
		});
		var rReserveDt = $("input[name='rReserveDt']:checked").val();
		var rReserveTm = "";
		$("input[name='rReserveTm']:checked").each(function(n){
			rReserveTm += $(this).val();
			if(n < $("input[name='rReserveTm']:checked").size() - 1) {
				rReserveTm += ",";
			}
		});
		if(rFacility == undefined) rFacility = "";
		if(rReserveDt == undefined) rReserveDt = "";

		if(rFacility == "" || rReserveDt == "" || rReserveTm == ""){
			return false;
		}

		// 신청규칙에 맞는지 확인
		var arrSelTime = rReserveTm.split(",");
		var first = arrSelTime[0];
		var last = arrSelTime[arrSelTime.length - 1];

		if(arrSelTime.length < 2 || Number(last) - Number(first) != arrSelTime.length - 1) {
			return false;
		}

		var data = "rFacility="+rFacility+"&rEquipment="+rEquipment+"&rReserveDt="+rReserveDt+"&rReserveTm="+rReserveTm+"&year="+selYear+"&month="+selMonth;
		$.ajax({
	        url: "/${siteCode}/module/${menuCode}_userRentCalculate.ajax"
	        , data: data
	        , type: "post"
	        , dataType: "json"
	        , cache: false
	        , success: function (data) {
	            if (data.result == "1") {
	            	$("#print_rCharge").val(data.charge)
	            	bNext = true;
	            } else if(data.result == "2") {//예약시간 중복 된 경우만 알려주고 시간리스트를 초기화 함.
	                alert(data.message);
                	$("#timeListLayer").html("");
                	$("input[name='rReserveTm']").attr("checked", false);
	                return false;
	            }
	        }
	        , error: function (request, status, error) {
	            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	        }
	    });

	}
	function fn_goRegist() {
		var frm = document.form1;
		if(!bNext) {
			alert("사용료가 정상적으로 계산되지 않았습니다. 선택사항을 확인 해 주세요.");
			return false;
		}
		if(confirm("신청하시겠습니까?")){
			frm.year.value = selYear;
			frm.month.value = selMonth;
			frm.action = "/${siteCode}/module/${menuCode}_userRentRegistProc.do";
			frm.submit();
		}
	}
	// 페이지 로딩 시 기본 설정. 킨스타워 대강당. 오늘날짜.
	$(function(){
		fn_selectItem("rFacility", "1");
		selectedFacility = "1";
		$("#rFacility1").attr("checked", true);
		var timer = setTimeout("triggerSelDate();", 500);
	});
	function triggerSelDate() {
		var d = new Date();
		var d = d.getDate() + 1;
		if($("#rReserveDt" + d) == undefined) {
			triggerSelDate()
		} else {
			$("#rReserveDt" + d).trigger("click");
			$("#rReserveDt" + d).attr("checked", true);

			timer = null;
		}
	}
</script>