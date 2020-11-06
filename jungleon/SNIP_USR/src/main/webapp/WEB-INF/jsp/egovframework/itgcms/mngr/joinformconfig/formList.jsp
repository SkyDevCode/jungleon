
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
<!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            회원가입 폼 관리
            <!-- <small>관리자 회원 목록</small> -->
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li>시스템관리</li>
            <li class="active">회원가입 폼 관리</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <div class="row">
            <div class="col-xs-12">
              <div class="box">
                <div class="box-body">
                <form name="listForm" method="post" onsubmit="fn_search(); return false;">
                <div class="row margin-bottom">
					<div class="col-sm-8 form-inline">

						<label for="viewCount" class="sr-only">리스트 갯수</label>
						<select name="viewCount" id="viewCount" class="form-control input-sm">
							<option value="10" ${ufn:selected(searchVO.viewCount, '10') }>10</option>
							<option value="30" ${ufn:selected(searchVO.viewCount, '30') }>30</option>
							<option value="50" ${ufn:selected(searchVO.viewCount, '50') }>50</option>
							<option value="100" ${ufn:selected(searchVO.viewCount, '100') }>100</option>
						</select>

						<label for="schFld" class="sr-only">검색조건</label>
						<select name="schFld" id="schFld" class="form-control input-sm" readonly="readonly">
								<option value="2">제목</option>
							</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>

						<button class="btn btn-default btn-sm">검색</button>
					</div>
					<div class="col-sm-4 text-right">
						<button type="button" onclick="fn_goRegist();" class="btn btn-primary btn-sm">등록</button>
						<button type="button" onclick="fn_chkDel();" class="btn btn-danger btn-sm">삭제</button>
					</div>
				</div>

	                <div class="row">
	                	<div class="col-sm-12">
			                  <table id="example1" class="table table-bordered table-striped">
			                    <thead>
									<tr>
												<th scope="col" rowspan="2"><input type="checkbox" name="chkAll" id="chkAll" value="Y" title="전체선택/해제" onclick="ItgJs.fn_checkAll(this, 'chkId');" /></th>
												<th scope="col" rowspan="2">번호</th>
												<th scope="col" rowspan="2">제목</th>
												<th scope="col" rowspan="2">약정 개수</th>
												<th scope="col" colspan="9">항 목</th>
											</tr>
											<tr>
<!-- 												<th scope="col">목록</th> -->
<!-- 												<th scope="col">조회</th> -->
<!-- 												<th scope="col">등록</th> -->
<!-- 												<th scope="col">수정</th> -->
<!-- 												<th scope="col">답변</th> -->

												<th scope="col">이름</th>
												<th scope="col">별명</th>
												<th scope="col">전화번호</th>
												<th scope="col">휴대전화번호</th>
												<th scope="col">이메일</th>
												<th scope="col">팩스</th>
												<th scope="col">주소</th>
												<th scope="col">생년월일</th>
												<th scope="col">성별</th>
											</tr>
								</thead>
			                    <tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
											<tr>
												<td><input type="checkbox" name="no" value="<c:out value="${result.no}" />" title="선택" /></td>
												<td class="tb_left bg_id"><c:out value="${listNo -(status.count-1) }" /></td>
												<td class="bg_name"><a href="#none" onclick="fn_goView('<c:out value="${result.no}" />'); return false;"><c:out value="${result.title}" /></a></td>
												<td><c:out value="${result.cntContract}" /></td>
												<th><span class="label label-<c:out value="${result.name == 0?'danger':result.name == 1?'success':'info'}" />"><c:out value="${result.name == 0?'미사용':result.name == 1?'필수':'선택'}" /></span></th>
												<th><span class="label label-<c:out value="${result.nickName == 0?'danger':result.nickName == 1?'success':'info'}" />"><c:out value="${result.nickName == 0?'미사용':result.nickName == 1?'필수':'선택'}" /></span></th>
												<th><span class="label label-<c:out value="${result.phone == 0?'danger':result.phone == 1?'success':'info'}" />"><c:out value="${result.phone == 0?'미사용':result.phone == 1?'필수':'선택'}" /></span></th>
												<th><span class="label label-<c:out value="${result.mobile == 0?'danger':result.mobile == 1?'success':'info'}" />"><c:out value="${result.mobile == 0?'미사용':result.mobile == 1?'필수':'선택'}" /></span></th>
												<th><span class="label label-<c:out value="${result.email == 0?'danger':result.email == 1?'success':'info'}" />"><c:out value="${result.email == 0?'미사용':result.email == 1?'필수':'선택'}" /></span></th>
												<th><span class="label label-<c:out value="${result.fax == 0?'danger':result.fax == 1?'success':'info'}" />"><c:out value="${result.fax == 0?'미사용':result.fax == 1?'필수':'선택'}" /></span></th>
												<th><span class="label label-<c:out value="${result.address == 0?'danger':result.address == 1?'success':'info'}" />"><c:out value="${result.address == 0?'미사용':result.address == 1?'필수':'선택'}" /></span></th>
												<th><span class="label label-<c:out value="${result.birth ==  0?'danger':result.birth == 1?'success':'info'}" />"><c:out value="${result.birth == 0?'미사용':result.birth == 1?'필수':'선택'}" /></span></th>
												<th><span class="label label-<c:out value="${result.sex == 0?'danger':result.sex == 1?'success':'info'}" />"><c:out value="${result.sex == 0?'미사용':result.sex == 1?'필수':'선택'}" /></span></th>
											</tr>
											</c:forEach>
											<c:if test="${fn:length(resultList ) == 0}">
												<tr><td colspan="15">데이터가 없습니다.</td></tr>
											</c:if>
								</tbody>
			                  </table>
		                  </div> <!-- .col-sm-12 -->
	                  </div> <!--  .row -->
	                  <div class ="row">
	                  	<div class="col-sm-5 text-left">
	                  		<div class="dataTables_info" id="example1_info" role="status" aria-live="polite">게시물 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" type="number" /> 건, 페이지 : <fmt:formatNumber value="${paginationInfo.currentPageNo}" type="number" /> / <fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number" /></div>
	                  	</div>
	                  	<div class="col-sm-7">
	                  		<div class="text-center dataTables_paginate paging_simple_numbers" id="example1_paginate">
	                  			<ul class="pagination">
	                  				<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	                  			</ul>
	                  		</div>
	                  	</div>
	                  </div>
	              </form>
                </div><!-- /.box-body -->
              </div><!-- /.box -->
            </div><!-- /.col -->
          </div><!-- /.row -->
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->


<script type="text/javascript">
var queryString = "${searchVo.query}";


function fn_goView(no) {
	location.href="mngrJoinFormView.do?schFid=1&" + ItgJs.fn_replaceQueryString(queryString, "no", no);
}

function fn_goRegist() {
   	location.href="joinFormConf_view.do";
}

function fn_search(){
	var tmpQuery = queryString;
	var f = document.listForm;
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "viewCount", f.viewCount.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schFld", f.schFld.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "schStr", f.schStr.value);
	tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", "1");

	location.href="?" + tmpQuery;
}

function fn_chkDel(){

}

</script>