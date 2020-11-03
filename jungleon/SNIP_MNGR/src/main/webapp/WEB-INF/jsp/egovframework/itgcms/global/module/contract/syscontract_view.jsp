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
 * @파일명 : mngrBoardconfigList.jsp
 * @파일정보 : 게시판관리 목록
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 9. 4. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
				<form name="form1" id="form1" method="post" onsubmit="fn_egov_save(); return false;" class="form-horizontal">
				<input type="hidden" name="schFld" value="<c:out value="${searchVO.schFld}" />" />
				<input type="hidden" name="schStr" value="<c:out value="${searchVO.schStr}" />" />
				<input type="hidden" name="page" value="<c:out value="${searchVO.page}" />" />
				<input type="hidden" name="no" value="<c:out value="${searchVO.no}" />" />
				<input type="hidden" name="viewCount" value="<c:out value="${searchVO.viewCount}" />" />
				<input type="hidden" name="act" value="<c:out value="${searchVO.act}" />" />
				<input type="hidden" name="mode" value="${ufn:deCode(searchVO.act,'UPDATE,update,REGIST,insert', '')}" />
				<div class="row">
					<div class="col-xs-12 table-responsive">
						<table class="table table-bordered table tp2">
							<colgroup>
		          				<col style="width:15%;"/>
		          				<col style="width:35%;"/>
		          				<col style="width:15%;"/>
		          				<col style="width:35%;"/>
		          			</colgroup>

		          			<tbody>
		          				<tr>
			          				<th class="t"><span>제목</span></th>
			          				<td colspan="3"><input type="text" value="${searchVO.title}" name="title" class="form-control"/></td>
			          			</tr>
		          				<tr>
		          					<th class="t"><span>내용</span></th>
			          				<td colspan="3"><textarea id="contents" name="contents"><c:out value="${searchVO.contents}"/></textarea></td>
		          				</tr>
		          				<c:if test="${searchVO.act eq 'UPDATE' }">
			          				<tr>
			          					<th class="t"><span>등록자 아이디</span></th>
			          					<td><c:out value="${searchVO.regMemId}"/></td>
			          					<th class="t"><span>등록일</span></th>
			          					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${searchVO.regDt}"/></td>
			          				</tr>
			          				<tr>
			          					<th class="t"><span>수정자 아이디</span></th>
			          					<td><c:out value="${searchVO.updMemId}"/></td>
			          					<th class="t"><span>수정일</span></th>
			          					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${searchVO.updDt}"/></td>
			          				</tr>
			          			</c:if>
		          			</tbody>
						</table>
					</div>
				</div><!-- /.row -->
				<div class="box-footer">
					<div class="pull-right">
						<p>
							<button type="submit" class="btn btn-primary">저장</button>
						<c:if test="${searchVO.act eq 'UPDATE'}">
							<button class="btn btn-danger" type="button" onclick="contractDel(${searchVO.no})">삭제</button>
						</c:if>
							<a href="#none" onclick="fn_goList(); return false;" class="btn btn-default">목록</a>
						</p>
					</div>
				</div><!-- /.box-footer -->
				</form>
			</div> <!-- /box-body -->
		</div> <!-- /box -->
	</div> <!-- /col -->
</div> <!-- /row -->

<script type="text/javascript" src="<c:url value="/cheditor/cheditor.js" />"></script>
<script type="text/javascript">
	var queryString = "${searchVO.query}";
	var myeditor = new cheditor();              // 에디터 개체를 생성합니다.
	myeditor.config.editorHeight = '300px';     // 에디터 세로폭입니다.
	myeditor.config.editorWidth = '100%';        // 에디터 가로폭입니다.
	myeditor.config.editorBgColor  = '#fdfde4'; 	// 에디터 기본배경색입니다.
	myeditor.config.useImage = false;
	myeditor.inputForm = 'contents';           // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
	myeditor.run();

	function fn_goList(){
		location.href="/_mngr_/contract/contract_list.do?<c:out value="${searchVO.query}" escapeXml="false" />"
	}

	function fn_egov_save(){
		var frm = document.form1;
		if (Validator.validate(frm)) {

			if (frm.title.value.length == 0) {
				alert("약관의 제목을 입력하세요");
				contractTitle.focus();
				return false;
			}
			var message = Validator["validate-max-length"](frm.title.value,"제목",'135');
			if(message) {alert(message);frm.title.focus();return false;}
			if (myeditor.inputLength() == 0 && $("#contractContents").val()=="") {
				alert("약관의 내용을 입력하세요");
				myeditor.editAreaFocus();
				return false;
			} else {
				frm.contents.value = myeditor.outputBodyHTML();
			}

			frm.action = "contract_proc.do";
			frm.submit();
		}
	}

	function contractDel(no){
		location.href = "contract_delete_proc.do?${searchVO.query}";
	}
</script>
