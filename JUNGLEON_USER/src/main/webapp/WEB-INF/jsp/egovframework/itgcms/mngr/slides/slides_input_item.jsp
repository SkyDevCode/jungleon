
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>

<%
/**
 * @파일명 : mngrSlideItemRegist.jsp
 * @파일정보 : 메인 슬라이드 아이템 등록
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 4. 11. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-header with-border"><h3 class="box-title">슬라이드 아이템 <c:out value="${ufn:deCode(searchVO.act, 'UPDATE,수정', '등록') }" /></h3></div>
			<div class="box-body">
				<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;" enctype="multipart/form-data">
				<input type="hidden" name="act" id="act" value="<c:out value="${searchVO.act}"/>"/>
				<input type="hidden" name="slidesIdx" id="slidesIdx" value="<c:out value="${searchVO.slidesIdx}"/>"/>
				<input type="hidden" name="slitemIdx" id="slitemIdx" value="<c:out value="${result.slitemIdx}"/>"/>
				<div class="row">
					<div class="col-xs-12 table-responsive">
						<table class="table table-bordered tp2">
							<colgroup>
								<col style="width:15%"/>
								<col style="width:85%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="t"><label for="slitemTitle">제목</label></th>
									<td><input type="text" name="slitemTitle" id="slitemTitle" maxlength="50" value="<c:out value="${result.slitemTitle}"/>" class="form-control input-sm f-wd-600 required" title="제목" /></td>
								</tr>
								<tr>
									<th class="t"><label for="useyn">사용여부</label></th>
									<td>
										<input type="radio" name="useyn" id="useyn1" value='Y' ${ufn:checked('Y',result.useyn) } ${ufn:checked('',result.useyn) } /><label for="useyn1">사용</label>&nbsp;&nbsp;&nbsp;
										<input type="radio" name="useyn" id="useyn2" value='N' ${ufn:checked('N',result.useyn) } /><label for="useyn2">사용안함</label>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="slitemLinkgubun">링크구분</label></th>
									<td>
										<input type="radio" name="slitemLinkgubun" id="slitemLinkgubun0" value='0' onclick="setLinkgubun('0');" ${ufn:checked('0',result.slitemLinkgubun) } ${ufn:checked('',result.slitemLinkgubun) }/><label for="slitemLinkgubun0">링크없음</label>&nbsp;&nbsp;&nbsp;
										<input type="radio" name="slitemLinkgubun" id="slitemLinkgubun1" value='1' onclick="setLinkgubun('1');" ${ufn:checked('1',result.slitemLinkgubun) } /><label for="slitemLinkgubun1">메인이미지링크</label>&nbsp;&nbsp;&nbsp;
										<input type="radio" name="slitemLinkgubun" id="slitemLinkgubun2" value='2' onclick="setLinkgubun('2');" ${ufn:checked('2',result.slitemLinkgubun) } /><label for="slitemLinkgubun2">메인이미지+링크아이템</label>&nbsp;&nbsp;&nbsp;
									</td>
								</tr>
								<tr>
									<th class="t"><label for="slitemImg">메인이미지</label></th>
									<td>
										<input  type="file" name="slitemImg" id="slitemImg" class="${searchVO.act == 'REGIST'?'required ':''}validate-is-image" title="이미지 첨부"/><input type="hidden" name="oldItemFile" id="oldItemFile" value="<c:out value="${result.slitemImg }" />" />
	                                	<c:if test="${not empty result.slitemImg }">
	                                    	첨부 이미지 :   <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />" ><c:out value="${result.slitemImg }" /></a>
	                                    	<br />
	                                    	<img class="transbg" src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }" />" alt="<c:out value="${result.slitemImgalt}" />" style="max-width:600px;max-height:400px;"/>
	                                  	</c:if>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="slitemImgalt">메인이미지 대체텍스트</label></th>
									<td>
										<textarea name="slitemImgalt" id="slitemImgalt" title="대체텍스트" class="form-control required f-wd-400" maxlength="1000"><c:out value="${result.slitemImgalt}"/></textarea>
										<span class="help-block" style="margin-bottom:0;">첨부한 이미지의 모든 글자를 입력해주세요.(1000자 제한)</span>
									</td>
								</tr>
								<%-- <tr class="forLinkgubun2">
									<th class="t"><label for="slitemLinktext">링크텍스트</label></th>
									<td>
										<textarea name="slitemLinktext" id="slitemLinktext" title="링크텍스트" class="form-control required forLinkgubun2" maxlength="1000"><c:out value="${result.slitemLinktext}"/></textarea>
										<span class="help-block">메인 이미지 위에 표시될 링크텍스트를 입력해 주세요(1000자 제한)</span>
									</td>
								</tr> --%>
								<tr class="forLinkgubun2">
									<th class="t"><label for="slitemLinktimg">링크아이템 타이틀이미지</label></th>
									<td>
										<input  type="file" name="slitemLinktimg" id="slitemLinktimg" class="validate-is-image forLinkgubun2" title="이미지 첨부"/><input type="hidden" name="oldItemLinkTFile" id="oldItemLinkTFile" value="<c:out value="${result.slitemLinktimg }" />" />
	                                	<c:if test="${not empty result.slitemLinktimg }">
	                                    	첨부 이미지 :   <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemLinktimg,result.slitemLinktimg) }" />" ><c:out value="${result.slitemLinktimg }" /></a>&nbsp;&nbsp;
	                                    	<input type="checkbox" name="delTimg" id="delTimg" value='Y' /><label for="delTimg">삭제</label>&nbsp;&nbsp;
	                                    	<br />
	                                    	<img class="transbg" src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','slides',result.slitemLinktimg,result.slitemLinktimg) }" />" alt="<c:out value="${result.slitemLinkttxt}" />" style="max-width:600px;max-height:400px;"/>
	                                  	</c:if>
									</td>
								</tr>
								<tr class="forLinkgubun2">
									<th class="t"><label for="slitemLinkttxt">링크아이템 타이틀텍스트</label></th>
									<td>
										<input type="text" name="slitemLinkttxt" id="slitemLinkttxt" title="링크아이템 타이틀텍스트" class="form-control input-sm f-wd-400 forLinkgubun2" maxlength="100" value="<c:out value="${result.slitemLinkttxt}"/>"/>
										<input type='text' id="slitemLinktcolor" name="slitemLinktcolor" class='basic' value='<c:out value="${result.slitemLinktcolor}"/>'/>
										<span class="help-block" style="margin-bottom:0;">타이틀에 사용될 텍스트를 입력해주세요.(단, 타이틀 이미지를 사용하지 않을 경우에만 노출됩니다.)</span>
									</td>
								</tr>
								<tr class="forLinkgubun2">
									<th class="t"><label for="slitemLinksimg">링크아이템 설명글이미지</label></th>
									<td>
										<input  type="file" name="slitemLinksimg" id="slitemLinksimg" class="validate-is-image forLinkgubun2" title="이미지 첨부"/><input type="hidden" name="oldItemLinkSFile" id="oldItemLinkSFile" value="<c:out value="${result.slitemLinksimg }" />" />
	                                	<c:if test="${not empty result.slitemLinksimg }">
	                                    	첨부 이미지 :   <a href="<c:url value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemLinksimg,result.slitemLinksimg) }" />" ><c:out value="${result.slitemLinksimg }" /></a>&nbsp;&nbsp;
	                                    	<input type="checkbox" name="delSimg" id="delSimg" value='Y' /><label for="delSimg">삭제</label>&nbsp;&nbsp;
	                                    	<br />
	                                    	<img class="transbg" src="<c:url value="/comm/viewImage.do?f=${ufn:getDownloadLink('','slides',result.slitemLinksimg,result.slitemLinksimg) }" />" alt="<c:out value="${result.slitemLinkstxt}" />" style="max-width:600px;max-height:400px;"/>
	                                  	</c:if>
									</td>
								</tr>
								<tr class="forLinkgubun2">
									<th class="t"><label for="slitemLinkstxt">링크아이템 설명글텍스트</label></th>
									<td>
										<textarea name="slitemLinkstxt" id="slitemLinkstxt" title="링크아이템 설명글텍스트" class="form-control f-wd-400 forLinkgubun2" maxlength="200"><c:out value="${result.slitemLinkstxt}"/></textarea>
										<input type='text' id ="slitemLinkscolor" name="slitemLinkscolor" class='basic' value='<c:out value="${result.slitemLinkscolor}"/>' />
										<span class="help-block" style="margin-bottom:0;">설명글에 사용될 텍스트를 입력해주세요.(단, 설명글이미지를 사용하지 않을 경우에만 노출됩니다.)</span>
									</td>
								</tr>
								<tr class="forLinkgubun2">
									<th class="t"><label for="slitemLinkbtn">링크아이템 바로가기버튼 텍스트</label></th>
									<td>
										<input type="text" name="slitemLinkbtn" id="slitemLinkbtn" title="링크아이템 바로가기버튼 텍스트" class="form-control input-sm f-wd-200 forLinkgubun2" maxlength="50" value="<c:out value="${result.slitemLinkbtn}"/>"/>
										<span class="help-block" style="margin-bottom:0;">바로가기 버튼에 사용될 텍스트를 입력해주세요.(단, 입력하지 않으면 노출되지 않습니다.)</span>
									</td>
								</tr>
								<tr class="forLinkgubun2 forLinkgubun2">
									<th class="t"><label for="slitemLinkpos">링크위치</label></th>
									<td>
										<div class="form-inline" id="slitemLinkpos">
                          					<strong>가로정렬</strong> :
                          					<input type="radio" name="slitemLinkposhor" id="slitemLinkPosL" value='l' ${ufn:checked('l',result.slitemLinkposhor) } ${ufn:checked('',result.slitemLinkposhor) }/><label for="slitemLinkPosL">왼쪽</label>&nbsp;&nbsp;&nbsp;
											<input type="radio" name="slitemLinkposhor" id="slitemLinkPosC" value='c' ${ufn:checked('c',result.slitemLinkposhor) } /><label for="slitemLinkPosC">가운데</label>&nbsp;&nbsp;&nbsp;
											<input type="radio" name="slitemLinkposhor" id="slitemLinkPosR" value='r' ${ufn:checked('r',result.slitemLinkposhor) } /><label for="slitemLinkPosR">오른쪽</label>
											<br/>
                          					<strong>세로정렬</strong> :
                          					<input type="radio" name="slitemLinkposver" id="slitemLinkPosT" value='t' ${ufn:checked('t',result.slitemLinkposver) } ${ufn:checked('',result.slitemLinkposver) }/><label for="slitemLinkPosT">상단</label>&nbsp;&nbsp;&nbsp;
											<input type="radio" name="slitemLinkposver" id="slitemLinkPosM" value='m' ${ufn:checked('m',result.slitemLinkposver) } /><label for="slitemLinkPosM">중앙</label>&nbsp;&nbsp;&nbsp;
											<input type="radio" name="slitemLinkposver" id="slitemLinkPosB" value='b' ${ufn:checked('b',result.slitemLinkposver) } /><label for="slitemLinkPosB">하단</label>
                          				</div>
                          				<span class="help-block" style="margin-bottom:0;">템플릿 별로 기본위치는 다를 수 있습니다.</span>
									</td>
								</tr>
								<tr class="forLinkgubun1 forLinkgubun2">
									<th class="t"><label for="slitemLinktype">링크타입</label></th>
									<td>
										<input type="radio" name="slitemLinktype" id="slitemLinktype2" value='1' onclick="setLinktype('1');" ${ufn:checked('1',result.slitemLinktype) } ${ufn:checked('',result.slitemLinktype) }/><label for="slitemLinktype2">현재창</label>&nbsp;&nbsp;&nbsp;
										<input type="radio" name="slitemLinktype" id="slitemLinktype3" value='2' onclick="setLinktype('2');" ${ufn:checked('2',result.slitemLinktype) } /><label for="slitemLinktype3">새창</label>
									</td>
								</tr>
								<tr class="forLinkgubun1 forLinkgubun2">
									<th class="t"><label for="slitemLinkurl">링크주소</label></th>
									<td>
										<input type="text" name="slitemLinkurl" id="slitemLinkurl" maxlength="100" title="링크주소" value="<c:out value="${result.slitemLinkurl}"/>" class="form-control input-sm f-wd-400 forLinkgubun1 forLinkgubun2" /><p></p>
										<span class="help-block" style="margin-bottom:0;">http:// 또는 https:// 를 포함한 전체 주소를 입력 해 주세요.</span>
									</td>
								</tr>
								<tr>
									<th class="t"><label for="slitemOrder">순서</label></th>
									<td>
										<input type="text" name="slitemOrder" id="slitemOrder" maxlength="100" value="<c:out value="${result.slitemOrder}"/>" class="required form-control input-sm f-wd-400 validate-digits" onkeydown="return ItgJs.fn_numberOnly(event,this);" title="순서" />
										<span class="help-block" style="margin-bottom:0;">숫자만 입력</span>
									</td>
								</tr>
						<c:if test="${searchVO.act eq 'UPDATE' }">
								<tr>
									<th class="t">등록자 아이디 / 등록일</th>
									<td><c:out value="${result.regmemid }" /> / <fmt:formatDate value="${result.regdt }" type="date" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								</tr>
							<c:if test="${not empty result.upddt }">
								<tr>
									<th class="t">수정자 아이디 / 등록일</th>
									<td><c:out value="${result.updmemid }" /> / <fmt:formatDate value="${result.upddt }" type="date" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								</tr>
							</c:if>
						</c:if>
							</tbody>
						</table>
					</div><!-- /.col -->
				</div><!-- /row -->
				<div class="box-footer">
               				<div class="pull-right">
<c:if test="${searchVO.act == 'UPDATE' }">
							<button type="button" onclick="fn_goDel();" class="btn btn-danger">삭제</button>
</c:if>
							<button  type="submit" value="" class="btn btn-primary">저장</button>
							<a href="#none" onclick="fn_goList(); return false;" class="btn btn-default">목록</a>
               				</div>
               			</div>
				</form>
			</div> <!-- /box-body -->
		</div> <!-- /box -->
	</div> <!-- /col -->
</div> <!-- /row -->

<script type="text/javascript">
//<[[!CDATA[

$(document).ready(function(){
	setLinkgubun(${result.slitemLinkgubun});

	$("#slitemLinktcolor").spectrum({
	    showAlpha: true,
	    preferredFormat: "rgb",
	    showInput: true
	});
	$("#slitemLinkscolor").spectrum({
	    showAlpha: true,
	    preferredFormat: "rgb",
	    showInput: true
	});
});

/* 글 등록 function */
function fn_egov_save() {
	frm = document.form1;

	if(Validator.validate(frm)){
	  	frm.action = "<c:url value="${searchVO.act == 'REGIST' ? 'slides_input_item_proc.do' : 'slides_update_item_proc.do'}"/>";
	    frm.submit();
	}
}

function fn_goList(){

	frm = document.form1;
	frm.action = "slides_list.do"
    frm.submit();
}


<c:if test="${searchVO.act == 'UPDATE' }">
function fn_goDel(){
	if(confirm("삭제하시겠습니까?")){
		var frm = document.form1;
		frm.encoding = "application/x-www-form-urlencoded";
		frm.action = "slides_delete_item_proc.do";
		frm.submit();
	}
}
</c:if>

/* 링크 구분 세팅 function */
function setLinkgubun(gubun) {

	$(".forLinkgubun1").hide();
	$("input.forLinkgubun1").removeClass("required");
	$(".forLinkgubun2").hide();

	if(gubun == '1'){
		$(".forLinkgubun1").show();
		$("input.forLinkgubun1").addClass("required");
	}else if(gubun == '2'){
		$(".forLinkgubun2").show();
		$("#slitemLinkurl").addClass("required");
	}
}

/* 링크 타입 세팅 function */
function setLinktype(opt){
	if(opt == "0"){
		$("#linkTr").hide();
		$("#popupUrl").removeClass("required validate-url").attr("readonly",true);
	}else if(opt == "1"){
		$("#linkTr").show();
		$("#popupUrl").addClass("required validate-url").attr("readonly",false);
	}else if(opt == "2"){
		$("#linkTr").show();
		$("#popupUrl").addClass("required validate-url").attr("readonly",false);
	}
}


//]]>
</script>



