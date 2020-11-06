<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%@ taglib prefix="cct" uri="/WEB-INF/tlds/CreateCodeTag.tld"%>
<%
/**
 * @파일명 : menu_edit.jsp
 * @파일정보 : 메뉴관리 등록 레이어
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 12. 13. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<script type="text/javascript">
//<![CDATA[
<c:choose>
	<c:when test="${searchVO.act eq 'REGIST' }">
		<c:set var="parentCode" value="${result2.menuPfullcode}" />
		<c:set var="parentName" value="${result2.menuPfullname}" />
		<c:set var="menuCode" value="" />
		<c:set var="menuName" value="" />
		<c:set var="title" value="메뉴 등록" />

		var codeCheck = false; //코드 중복검사, 등록일때는 중복검사 필요함
		$(function(){
			$("#menuCode").focus();
			fn_setMenutype("0","R");//메뉴 타입에 따라 설정 글쓰기는 폴더 선택
		});
	</c:when>
	<c:when test="${searchVO.act eq 'UPDATE' }">
		<c:set var="parentCode" value="${result.menuPfullcode}" />
		<c:set var="parentName" value="${result.menuPfullname}" />
		<c:set var="menuCode" value="${result.menuCode}" />
		<c:set var="menuName" value="${result.menuName}" />
		<c:set var="title" value="메뉴 수정" />

		var codeCheck = true;//코드 중복검사, 수정일때는 코드 중복검사 필요없음.
		$(function(){
			$("#menuName").focus();
			fn_setMenutype("<c:out value="${result.menuType}" />","U");//메뉴 타입에 따라 설정
		});
	</c:when>
</c:choose>

$(document).ready(function(){
	fn_setCharge("<c:out value="${result.menuChargeuseyn}" />");//담당자 사용여부값에 따라 담당자 값 오류체크 설정
});

function fn_menuDuplCheck(menuCode){
	$.ajax({
		url:"menu_comm_dupleCheck.ajax"
		, data : "id=<c:out value="${searchVO.id}" />&menuCode="+menuCode+"&act=<c:out value="${searchVO.act}" />"
		, type : "post"
		, dataType : "json"
		, async : "false"
		, success : function(data){
			fn_printHelp(data.result);
		}
		, error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function fn_printHelp(result){
	if(result == 0){
		codeCheck = true;
		$("#ccodeHelp").text("사용가능한 메뉴코드 입니다.");
	}else{
		codeCheck = false;
		$("#ccodeHelp").text("중복된 메뉴코드 입니다.");
	}
}

$(function(){
	/*
		코드 중복 검사
	*/
	$("#menuCode").on("change",function(){
		var ptrn1 = /^[^a-zA-Z]/; //false가 정상
		var ptrn2 = /[^a-zA-Z0-9-]/; //false가 정상 +
		var str = $(this).val();
		if(str == ""){
			fn_printHelp(1);
			$(this).focus();
			return false;
		}
		if(ptrn1.test(str)){
			alert("메뉴코드명은 영문자로 시작해야 합니다.");
			//codeCheck = false;
			$(this).focus();
			return false;
		}
		if(ptrn2.test(str)){
			alert("메뉴코드명은 영문(대소문자), 숫자, -(하이픈) 만 입력 할 수 있습니다.");
			$(this).focus();
			return false;
		}
		fn_menuDuplCheck($(this).val());
	});
})

function fn_save(){
	var frm = document.form1;
/* 	if(frm.menuType.value == "1"){//cms컨텐츠이면 에디터 내용 적용
		myeditor.outputBodyHTML();
	} */
	if(Validator.validate(frm)){
		if(!codeCheck){
			alert("중복된 메뉴코드입니다. 확인 후 다시 시도해주세요.");
			return false;
		}
		if(frm.tempSchType.value != ""){
			var cidx = $("#tempSchType").find("option:selected").attr("data-idx");
			var curl = $("#tempSchType").find("option:selected").attr("data-url");
			frm.menuSchType.value=frm.tempSchType.value+"|"+cidx+"|"+curl;
		}
		$.ajax({
			url : "menu_edit_proc.ajax"
			, data : $("#form1").serialize()
			, dataType : "json"
			, type : "post"
			, success : function(data){
				if(data.result == 0){
					alert(data.message); //alert("데이터 저장 중 오류가 발생했습니다. 다시 시도해 주세요");
					return false;
				}else if(data.result == 1){
					if("<c:out value="${searchVO.act}" />" == "REGIST"){
						if(confirm("등록되었습니다.\n계속해서 같은 레벨의 메뉴를 등록 하시겠습니까?")){
							fn_load("REGIST", "<c:out value="${searchVO.id}" />");
						}else{
							fn_clear();
						}
					}else if("<c:out value="${searchVO.act}" />" == "UPDATE"){
						alert("저장 되었습니다.");
						fn_load("UPDATE", "<c:out value="${searchVO.id}" />");
					}
					refreshNode();
				}else if(data.result == 2){
					alert(data.message); //alert("코드가 중복 되었습니다. 확인 후 다시 시도해 주세요");
					return false;
				}else{
					alert(data.message);
					return false;
				}
			}
			, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
}

function fn_chkDel(){
	if(confirm("메뉴를 삭제하시겠습니까?")){
		$.ajax({
			url : "menu_delete_proc.ajax"
			, data : $("#form1").serialize()
			, dataType : "json"
			, type : "post"
			, success : function(data){
				if(data.result == 0){
					alert("삭제 중 오류가 발생했습니다. 다시 시도해 주세요");
					return false;
				}else if(data.result == 1){
					alert("삭제가 완료 되었습니다.");
					fn_clear();
					refreshNode();
					zTree.cancelSelectedNode();
				}else if(data.result == 2){
					alert("메뉴에 포함된 하위메뉴가 있어서 삭제 할 수 없습니다.\n하위메뉴를 먼저 삭제 해 주세요.");
					return false;
				}
			}
			, error:function(request,status,error){
	   		   alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
}

function fn_setMenutype(strVal,type){ //0폴더,1CMS,2프로그램,3게시판,4링크,5컨텐츠없음
	//
	//$("#programList").hide().val("");
	//$("#boardList").hide().val("");
	//$("#subMenuList").hide().val("");
/* $(".htmlEditor").hide(); */
	/* $("#menuContents").removeClass("required"); */
	if(type == "R"){
		$("#menuUrl").val('');
		$("#menuMngurl").val('');
	}
	switch(strVal){
		case "0" ://폴더
			$("#menuUrl").removeClass("required").prop("readonly","readonly");
			$("#menuMngurl").removeClass("required").prop("readonly","readonly");
			//$("#subMenuList").addClass("required");
			$("#programListTmp").removeClass("required").hide().val("");
			$("#boardList").removeClass("required").hide().val("");
			$("#subMenuList").show();
			break;
		case "1" ://CMS
			$("#menuUrl").removeClass("required").prop("readonly","readonly");
			$("#menuMngurl").removeClass("required").prop("readonly","readonly");
			/* $("#menuContents").addClass("required"); */
			$("#subMenuList").removeClass("required").hide().val("");
			$("#programListTmp").removeClass("required").hide().val("");
			$("#boardList").removeClass("required").hide().val("");
			/* $(".htmlEditor").show(); */
			break;
		case "2" ://프로그램
			$("#menuUrl").addClass("required").prop("readonly","readonly");
			$("#menuMngurl").addClass("required").prop("readonly","readonly");
			$("#programListTmp").addClass("required");
			$("#subMenuList").removeClass("required").hide().val("");
			$("#boardList").removeClass("required").hide().val("");
			$("#programListTmp").show();
			break;
		case "3" ://게시판
			$("#menuUrl").addClass("required").prop("readonly","readonly");
			$("#menuMngurl").addClass("required").prop("readonly","readonly");
			$("#boardList").addClass("required");
			$("#subMenuList").removeClass("required").hide().val("");
			$("#programListTmp").removeClass("required").hide().val("");
			$("#boardList").show();
			break;
		case "4" ://링크
			$("#menuUrl").addClass("required").prop("readonly","");
			$("#menuMngurl").addClass("required").prop("readonly","");
			$("#subMenuList").removeClass("required").hide().val("");
			$("#programListTmp").removeClass("required").hide().val("");
			$("#boardList").removeClass("required").hide().val("");
			break;
		case "5" ://컨텐츠없음
			$("#menuUrl").removeClass("required").prop("readonly","readonly");
			$("#menuMngurl").removeClass("required").prop("readonly","readonly");
			$("#subMenuList").removeClass("required").hide().val("");
			$("#programListTmp").removeClass("required").hide().val("");
			$("#boardList").removeClass("required").hide().val("");
			break;
/* 		case "7" ://인클루드링크 - 3.07주소체계변경으로 인한 미사용처리
			$("#menuUrl").addClass("required").prop("readonly","");
			$("#menuMngurl").addClass("required").prop("readonly","");
			$("#subMenuList").removeClass("required").hide().val("");
			$("#programListTmp").removeClass("required").hide().val("");
			$("#boardList").removeClass("required").hide().val("");
			break; */
	}
}

function fn_setProgram(strVal){
	var arrProgram = strVal.split("|");
	var userUrl = "";
	var mngrUrl = "";
	var progIdx = "";
	if(arrProgram.length >= 3){
		userUrl = arrProgram[0];
		mngrUrl = arrProgram[1];
		progIdx = arrProgram[2];
	}
	$("#programList").val(progIdx);
	$("#menuUrl").val(userUrl);
	$("#menuMngurl").val(mngrUrl);
}

function fn_setSubMenuList(strVal){
	var arrCode = strVal.split("|");
	var fullcode = "";
	var code = "";
	if(arrCode.length >= 2){
		fullcode = arrCode[0];
		code = arrCode[1];
	}
	var arrUser = fullcode.split(">");
	var url = "";
	if(arrUser.length >1)	url = "/" + arrUser[1] + "/contents/" + code + ".do";
	$("#menuUrl").val(url);
	$("#menuMngurl").val('-');
}

function fn_setBoard(obj){
	var selOpt = obj[obj.selectedIndex]; //선택된 옵션
	var bcId = selOpt.value; //옵션값(게시판아이디)
	var bcDefaultpage = selOpt.dataset.page; //data-page(기본페이지)

	$("#menuUrl").val(bcDefaultpage+"_"+bcId);
	$("#menuMngurl").val(bcDefaultpage+"_"+bcId);
}

function fn_setCharge(strVal){
	if(strVal == "Y"){
		$("#mngNameTr").show();
		$("#mngName").addClass("required");
		$("#mngId").addClass("required");
	}else{
		$("#mngName").removeClass("required");
		$("#mngId").removeClass("required");
		$("#mngNameTr").hide();
	}
}
//]]>
</script>

<form name="form1" id="form1" method="post" onsubmit="fn_save(); return false;">
	<input type="hidden" name="id" value="<c:out value="${searchVO.id }" />" />
	<input type="hidden" name="act" value="<c:out value="${searchVO.act }" />" />
	<input type="hidden" name="menuPfullname" value="<c:out value="${parentName }" />" />
	<input type="hidden" name="menuOldpfullname" value="<c:out value="${parentName }>${result.menuName}" />" />
	<input type="hidden" name="menuPfullcode" value="<c:out value="${parentCode }" />" />
	<input type="hidden" name="menuFullorder" value="<c:out value="${result.menuFullorder }" />" />
	<input type="hidden" name="menuDepth" value="<c:out value="${result.menuDepth}" />" />
	<input type="hidden" name="programList" id="programList"  value="<c:out value="${result.menuSubType }" />"/>
	<div class="row">
		<div class="col-xs-12 table-responsive">
			<table class="table table-bordered tp2">
				<colgroup>
					<col style="width:25%"/>
					<col style="width:75%"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="t"><span>상위메뉴코드</span></th>
						<td>Home<c:out value="${parentCode}" /></td>
					</tr>
					<tr>
						<th class="t"><span>상위메뉴명</span></th>
						<td>홈<c:out value="${parentName}" /></td>
					</tr>
					<tr>
						<th class="t"><label for="menuCode">메뉴코드</label></th>
						<td>
							<div class="form-inline">
								<c:choose>
					        		<c:when test="${searchVO.act eq 'REGIST' }">
							            <input type="text" name="menuCode" id="menuCode" maxlength="20" class="required validate-code-format form-control input-sm f-wd-200" title="메뉴코드" value="<c:out value="${menuCode }" />" />
					        		</c:when>
					        		<c:otherwise>
					        			<c:out value="${menuCode }" />
					        			<input type="hidden" name="menuCode" value="<c:out value="${result.menuCode }" />" />
					        		</c:otherwise>
					        	</c:choose>
					            <span id="ccodeHelp" class="help"><c:if test="${searchVO.act eq 'REGIST' }">영문, 숫자, '-' 가능 (등록 후에 수정 할 수 없습니다.)</c:if></span>
							</div>
						</td>
					</tr>
					<tr>
						<th class="t"><label for="menuName">메뉴이름</label></th>
						<td>
						<c:choose>
							<c:when test="${result.menuDepth eq '1' }">
								<c:out value="${result.menuName }" />
								<input type="hidden" name="menuName" id="menuName" value="<c:out value="${result.menuName }" />">
							</c:when>
							<c:otherwise>
								<input type="text" name="menuName" id="menuName" maxlength="200" class="required form-control input-sm f-wd-200" title="메뉴이름" value="<c:out value="${result.menuName }" />" />
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					<tr>
						<th class="t"><label for="fax">메뉴설명</label></th>
						<td>
							<textarea name="menuMemo" id="menuMemo" rows="5" class="form-control" title="메뉴설명" ><c:out value="${result.menuMemo }" /></textarea>
							<span class="help-block" style="margin: 0;">html코딩 필수</span>
						</td>
					</tr>
					<tr>
						<th class="t"><label for="gd">메뉴타입</label></th>
						<td>
							<div class="form-inline">
								<select name="menuType" id="menuType"class="required form-control input-sm f-wd-200" title="메뉴타입" onchange="fn_setMenutype(this.value,'R');">
					        		<option value="0" ${ufn:selected(result.menuType, '0') } ${ufn:selected(result.menuType, '') } >폴더</option>
					        		<c:if test="${(result2.menuDepth > 1) or (result.menuDepth > 2)}">
					        		<option value="1" ${ufn:selected(result.menuType, '1') }>CMS 컨텐츠</option>
					        		<option value="2" ${ufn:selected(result.menuType, '2') }>프로그램</option>
					        		<option value="3" ${ufn:selected(result.menuType, '3') }>게시판</option>
					        		</c:if>
					        		<option value="4" ${ufn:selected(result.menuType, '4') }>외부링크</option>
					        		<%-- <option value="7" ${ufn:selected(result.menuType, '7') }>인클루드링크</option> //- 3.07주소체계변경으로 인한 미사용처리 --%>
					        		<option value="5" ${ufn:selected(result.menuType, '5') }>컨텐츠없음</option>
					        	</select>
					        	<select name="subMenuList" id="subMenuList" class="form-control input-sm f-wd-200" title="서브메뉴 선택" onchange="fn_setSubMenuList(this.value)" >
					        		<option value="">서브메뉴 선택</option>
					        		<c:forEach var="list" items="${subMenuList }">
					        			<c:set var="optionValue" value="${list.menuPfullcode }|${list.menuCode }" />
					        			<option value="<c:out value="${optionValue }" />" ${ufn:selected(result.menuSubType, optionValue) }><c:out value="${list.menuName }" /></option>
					        		</c:forEach>
					        	</select>
					        	<select name="programListTmp" id="programListTmp" class="form-control input-sm f-wd-200" title="프로그램 선택" onchange="fn_setProgram(this.value)" >
					        		<option value="">프로그램 선택</option>
					        		<c:forEach var="list" items="${programList }">
					        			<c:set var="optionValue" value="${list.progUserurl }|${list.progMngrurl }|${list.progIdx}" />
					        			<%-- <c:set var="optionValue" value="${list.progIdx}" /> --%>
					        			<option value="<c:out value="${optionValue }"/>" ${ufn:selected(result.menuSubType, list.progIdx) }><c:out value="${list.progName }" /></option>
					        		</c:forEach>
					        	</select>
					        	<select name="boardList" id="boardList" class="form-control input-sm f-wd-200" title="게시판 선택" onchange="fn_setBoard(this)" >
					        		<option value="">게시판 선택</option>
					        		<c:forEach var="list" items="${boardList }">
					        			<option value="${list.bcId}" data-page="${list.bcDefaultpage}" ${ufn:selected(result.menuSubType, list.bcId) }><c:out value="${list.bcName }" /></option>
					        		</c:forEach>
					        	</select>
							</div>
						</td>
					</tr>
<%-- 					<tr class="htmlEditor">
				    	<td colspan="2">
				    		<div class="htmlEditor">
					    		<textarea id="menuContents" name="menuContents" title="CMS 컨텐츠" ><c:out value="${result.menuContents }" /></textarea>
								<script type="text/javascript">
									var myeditor = new cheditor();              // 에디터 개체를 생성합니다.
									myeditor.config.editorHeight = '300px';     // 에디터 세로폭입니다.
									myeditor.config.editorWidth = '100%';        // 에디터 가로폭입니다.
									myeditor.inputForm = 'menuContents';             // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
									myeditor.run();
								</script>
							</div>
				    	</td>
				    </tr> --%>
					<tr>
						<th class="t"><label for="menuUrl">사용자 링크주소</label></th>
						<td><input type="text" name="menuUrl" id="menuUrl" maxlength="100" class="form-control input-sm" title="사용자 링크주소" value="<c:out value="${result.menuUrl }" />" /></td>
					</tr>
					<tr>
						<th class="t"><label for="menuUrl">관리 링크주소</label></th>
						<td><input type="text" name="menuMngurl" id="menuMngurl" maxlength="100" class="form-control input-sm" title="관리 링크주소" value="<c:out value="${result.menuMngurl }" />" /></td>
					</tr>
					<tr>
						<th class="t"><label for="menuShowtype1">링크타입</label></th>
						<td>
						     <label><input type="radio" name="menuShowtype" id="menuShowtype1" class="required" title="현재창" value="0" ${ufn:checked(result.menuShowtype, '0')} ${ufn:checked(result.menuShowtype, '')} />현재창</label>
                            <label style="margin-left:20px;"><input type="radio" name="menuShowtype" id="menuShowtype2" class="required" title="새창" value="1" ${ufn:checked(result.menuShowtype, '1')} />새창</label>
                            <%-- <label><input type="radio" name="menuShowtype" id="menuShowtype3" class="required" title="관리자" value="2" ${ufn:checked(result.menuShowtype, '2')} />레이어 팝업</label> --%>
						</td>
					</tr>
					<tr>
						<th class="t"><label for="menuUsetype0">메뉴 사용타입</label></th>
						<td>
						    <label><input type="radio" name="menuUsetype" id="menuUsetype0" class="required" title="사용자(메뉴 노출)" value="0" ${ufn:checked(result.menuUsetype, '0')} ${ufn:checked(result.menuUsetype, '')} />사용자(메뉴 노출)</label>
                            <label style="margin-left:20px;"><input type="radio" name="menuUsetype" id="menuUsetype1" class="required" title="사용자(GNB만숨김)" value="1" ${ufn:checked(result.menuUsetype, '1')} />사용자(GNB만숨김)</label>
                            <label style="margin-left:20px;"><input type="radio" name="menuUsetype" id="menuUsetype3" class="required" title="사용자(메뉴숨김)" value="3" ${ufn:checked(result.menuUsetype, '3')} />사용자(메뉴숨김)</label>
                            <label style="margin-left:20px;"><input type="radio" name="menuUsetype" id="menuUsetype2" class="required" title="관리자" value="2" ${ufn:checked(result.menuUsetype, '2')} />관리자</label>
				        	<span class="help-block" style="margin: 0;">사용자/관리자 선택, 사용자메뉴의 메뉴 표시 여부 선택</span>
						</td>
					</tr>
					<tr>
						<th class="t"><label for="menuUseFixwidth0">페이지타입</label></th>
						<td>
						    <label><input type="radio" name="menuUseFixwidth" id="menuUseFixwidth0" class="required" title="BOX" value="0" ${ufn:checked(result.menuUseFixwidth, '0')} ${ufn:checked(result.menuUseFixwidth, '')} />사이트 설정에 따름</label>
						    <label style="margin-left:20px;"><input type="radio" name="menuUseFixwidth" id="menuUseFixwidth1" class="required" title="BOX" value="1" ${ufn:checked(result.menuUseFixwidth, '1')} />BOX</label>
                            <label style="margin-left:20px;"><input type="radio" name="menuUseFixwidth" id="menuUseFixwidth2" class="required" title="WIDE" value="2" ${ufn:checked(result.menuUseFixwidth, '2')} />WIDE</label>
				        	<span class="help-block" style="margin: 0;">페이지 구성 형태 선택, BOX:해당 템플릿에서 정한 fixWidth값, WIDE:100% width</span>
						</td>
					</tr>
					<%-- <tr>
						<th class="t"><label for="menuNavi">메뉴 네비게이션</label></th>
						<td>
							<input type="text" name="menuNavi" id="menuNavi" maxlength="150" class="required form-control input-sm" title="메뉴 네비게이션" value="<c:out value="${result.menuNavi }" />" />
						</td>
					</tr> --%>
					<tr>
						<th class="t"><label for="menuUseyn1">사용여부</label></th>
						<td>
							<label><input type="radio" name="menuUseyn" id="menuUseyn1" class="required" title="사용여부" value="Y" ${ufn:checked(result.menuUseyn, 'Y')} ${ufn:checked(result.menuUseyn, '')} />사용</label>
			            	<label><input type="radio" name="menuUseyn" id="menuUseyn2" class="required" title="사용여부" value="N" ${ufn:checked(result.menuUseyn, 'N')} />미사용</label>
						</td>
					</tr>
					<tr>
						<th class="t"><label for="menuChargeuseyn">담당자 표시 여부</label></th>
						<td>
							<label><input type="radio" name="menuChargeuseyn" id="menuChargeuseyn1" class="required" title="담당자 표시 여부" value="Y" onclick="fn_setCharge('Y')" ${ufn:checked(result.menuChargeuseyn, 'Y')} />사용</label>
			            	<label><input type="radio" name="menuChargeuseyn" id="menuChargeuseyn2" class="required" title="담당자 표시 여부" value="N" onclick="fn_setCharge('N')" ${ufn:checked(result.menuChargeuseyn, 'N')} ${ufn:checked(result.menuChargeuseyn, '')} />미사용</label>
			        	</td>
					</tr>
					<tr id="mngNameTr">
						<th class="t"><label for="mngName">담당자</label></th>
						<td>
							<div class="form-inline">
								<input type="text" name="mngName" id="mngName" maxlength="20" class="form-control input-sm f-wd-200" title="담당자" value="<c:out value="${result.mngName }" />" readonly/>
				           		<input type="hidden" name="mngId" id="mngId" maxlength="20" title="담당자" value="<c:out value="${result.mngId }" />" />
				            	<div style="display:inline-block"><button type="button" class="btn btn-default btn-sm" style="margin-right:20px;" onclick="$('#modalManagerContent').modal('show');">담당자 선택</button></div>
			            	</div>
			        	</td>
					</tr>
					<tr>
						<th class="t"><label for="menuResearchuseyn">서브메뉴 표시 여부</label></th>
						<td>
							<label><input type="radio" name="menuLnbuseyn" id="menuLnbuseyn1" class="required" title="서브메뉴 사용 여부" value="Y" ${ufn:checked(result.menuLnbuseyn, 'Y')} ${ufn:checked(result.menuLnbuseyn, '') }/>사용</label>
			            	<label><input type="radio" name="menuLnbuseyn" id="menuLnbuseyn2" class="required" title="서브메뉴 사용 여부" value="N" ${ufn:checked(result.menuLnbuseyn, 'N')}/>미사용</label>
				        	<span class="help-block" style="margin: 0;">사용자메뉴의 서브 메뉴 표시 여부 선택<br/> (기본적으로 서브메뉴가 없는 레이아웃의 경우 설정값에 상관없이 서브 메뉴는 표시되지 않습니다.)</span>
			        	</td>
					</tr>
					<tr>
						<th class="t"><label for="menuResearchuseyn">만족도조사 사용 여부</label></th>
						<td>
							<label><input type="radio" name="menuResearchuseyn" id="menuResearchuseyn1" class="required" title="만족도조사 사용 여부" value="Y" ${ufn:checked(result.menuResearchuseyn, 'Y')}/>사용</label>
			            	<label><input type="radio" name="menuResearchuseyn" id="menuResearchuseyn2" class="required" title="만족도조사 사용 여부" value="N" ${ufn:checked(result.menuResearchuseyn, 'N')} ${ufn:checked(result.menuResearchuseyn, '') }/>미사용</label>
			        	</td>
					</tr>
					<%--<tr>
						<th class="t"><label for="menuQruseyn">QR코드 사용 여부</label></th>
						<td>
							<label><input type="radio" name="menuQruseyn" id="menuQruseyn1" class="required" title="QR코드 사용 여부" value="Y" ${ufn:checked(result.menuQruseyn, 'Y')}/>사용</label>
			            	<label><input type="radio" name="menuQruseyn" id="menuQruseyn2" class="required" title="QR코드 사용 여부" value="N" ${ufn:checked(result.menuQruseyn, 'N')} ${ufn:checked(result.menuQruseyn, '') }/>미사용</label>
			        	</td>
					</tr> --%>
					<tr>
						<th class="t"><label for="menuSnsShareyn">SNS공유 사용 여부</label></th>
						<td>
							<label><input type="radio" name="menuSnsShareyn" id="menuSnsShareyn1" class="required" title="SNS공유 사용 여부" value="Y" ${ufn:checked(result.menuSnsShareyn, 'Y')}/>사용</label>
			            	<label><input type="radio" name="menuSnsShareyn" id="menuSnsShareyn2" class="required" title="SNS공유 사용 여부" value="N" ${ufn:checked(result.menuSnsShareyn, 'N')} ${ufn:checked(result.menuSnsShareyn, '') }/>미사용</label>
			        	</td>
					</tr>
					<tr>
						<th class="t"><label for="menuSnsShareyn">SMS통합관리메뉴 여부</label></th>
						<td>
							<label><input type="radio" name="menuUsesmsyn" id="menuUsesmsyn1" class="required" title="SMS통합관리메뉴 여부" value="Y" ${ufn:checked(result.menuUsesmsyn, 'Y')}/>사용</label>
			            	<label><input type="radio" name="menuUsesmsyn" id="menuUsesmsyn2" class="required" title="SMS통합관리메뉴 여부" value="N" ${ufn:checked(result.menuUsesmsyn, 'N')} ${ufn:checked(result.menuUsesmsyn, '') }/>미사용</label>
			        	</td>
					</tr>
					<tr>
						<th class="t"><label for="menuSnsShareyn">메일통합관리메뉴 여부</label></th>
						<td>
							<label><input type="radio" name="menuUsemailyn" id="menuUsemailyn1" class="required" title="메일통합관리메뉴 여부" value="Y" ${ufn:checked(result.menuUsemailyn, 'Y')}/>사용</label>
			            	<label><input type="radio" name="menuUsemailyn" id="menuUsemailyn2" class="required" title="메일통합관리메뉴 여부" value="N" ${ufn:checked(result.menuUsemailyn, 'N')} ${ufn:checked(result.menuUsemailyn, '') }/>미사용</label>
			        	</td>
					</tr>
					<tr>
						<th class="t"><label for="menuLoginyn">로그인 사용 여부</label></th>
						<td>
							<label><input type="radio" name="menuLoginyn" id="menuLoginyn1" class="required" title="로그인 사용 여부" value="Y" ${ufn:checked(result.menuLoginyn, 'Y')}/>사용</label>
			            	<label><input type="radio" name="menuLoginyn" id="menuLoginyn2" class="required" title="로그인 사용 여부" value="N" ${ufn:checked(result.menuLoginyn, 'N')} ${ufn:checked(result.menuLoginyn, '') }/>미사용</label>
			        	</td>
					</tr>
					<!-- <tr>
						<th class="t"><label for="menuSchyn1">검색바 표출 여부</label></th>
						<td>
							<label><input type="radio" name="menuSchyn" id="menuSchyn1" class="required" title="검색바 표출 여부" value="Y" ${ufn:checked(result.menuSchyn, 'Y')}/>사용</label>
			            	<label><input type="radio" name="menuSchyn" id="menuSchyn2" class="required" title="검색바 표출 여부" value="N" ${ufn:checked(result.menuSchyn, 'N')} ${ufn:checked(result.menuSchyn, '') }/>미사용</label>
			        	</td>
					</tr> -->
					<tr>
						<th class="t"><label for=tempSchType>검색바 구분</label></th>
						<td>
							<input type="hidden" name="menuSchType" value="" />
							<c:set var="menuSchType" value="${fn:split(result.menuSchType, '|') }" />
							<cct:codeTag tagName="tempSchType" tagId="tempSchType" pidx="2600" tagType="select" useNullOpt="선택" selectedValue="${menuSchType[0]}" addOptData="data-idx,cidx,data-url,etc1" className="form-control f-wd-200"/>
			        	</td>
					</tr>
					<tr>
						<th class="t"><label for="menuParam">파라미터</label></th>
						<td>
							<input type="text" name="menuParam" id="menuParam" maxlength="100" class="form-control input-sm" title="파라미터" value="<c:out value="${result.menuParam }" />" />
			        	</td>
					</tr>
					<tr>
						<th class="t"><label for="menuScript">스크립트</label></th>
						<td>
							<input type="text" name="menuScript" id="menuScript" maxlength="150" class="form-control input-sm" title="스크립트" value="<c:out value="${result.menuScript }" />" />
			        	</td>
					</tr>
<c:if test="${searchVO.act == 'UPDATE' }">
					<tr>
						<th class="t"><span>짧은 URL 코드</span></th>
						<td><c:out value="${shortUrlCode}" /></td>
					</tr>
					<tr>
						<th class="t"><span>등록자 아이디 / 등록일</span></th>
						<td><c:out value="${result.regmemid }" /> / <c:out value="${result.regdt }" /></td>
					</tr>
					<tr>
						<th class="t"><span>수정자 아이디 / 수정일</span></th>
						<td><c:out value="${result.updmemid }" /> / <c:out value="${result.upddt }" /></td>
					</tr>
</c:if>
				</tbody>
			</table>
		</div><!-- /.col -->

	</div>
		<div class="text-right">
			<button type="submit" class="btn btn-primary">저장</button>
<c:if test="${searchVO.act == 'UPDATE' and result.subtree == 0 and result.menuPcode != '0'}">
			<button type="button" onclick="fn_chkDel();" class="btn btn-danger">삭제</button>
</c:if>
		</div>

</form>
