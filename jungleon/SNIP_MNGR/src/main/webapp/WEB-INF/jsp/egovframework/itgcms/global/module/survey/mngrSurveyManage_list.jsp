<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 * @파일명 : eduSurvey.jsp
 * @파일정보 : 교육만족도조사 목록
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @hjw 2017. 7. 17. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

        <!-- Main content -->
        <section class="content">
          <div class="row">
            <div class="col-xs-12">
              <div class="box">
                <div class="box-body">
                <form name="listForm" method="post" onsubmit="fn_search(); return false;">
                	<input type="hidden" name="svIdx"/>
                	<input type="hidden" name="page" value="${searchVO.page}"/>
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
						<select name="schFld" id="schFld" class="form-control input-sm">
							<option value="" <c:out value="${searchVO.schFld eq '' ? 'selected' : '' }" />>전체</option>
							<option value="1" <c:out value="${searchVO.schFld eq '1' ? 'selected' : '' }" />>설문조사명</option>
						</select>
						<label for="schStr" class="sr-only">검색어</label>
						<input name="schStr" id="schStr"  class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>
						<button class="btn btn-default btn-sm btn-sm-search">검색</button>
					</div>

					<div class="col-sm-4 text-right">
						<button type="button" onclick="location.href='/_mngr_/survey/mngrSurvey_regist.do'" class="btn btn-primary">등록</button>
					</div>
				</div>

	                <div class="row">
	                	<div class="col-sm-12">
			                  <table id="example1" class="table table-bordered">
			                  	<colgroup>
			                  		<col style="width:60px;"/>
			                  		<col/>
			                  		<col style="width:15%;"/>
			                  		<col style="width:10%;"/>
			                  		<col style="width:150px;"/>
			                  		<col style="width:150px;"/>
			                  	</colgroup>
			                    <thead>
									<tr>
										<th scope="col" class="text-center">번호</th>
										<th scope="col" class="text-center">설문조사명</th>
										<th scope="col" class="text-center">설문기간</th>
										<th scope="col" class="text-center">설문 참여자수</th>
										<th scope="col" class="text-center">진행상태</th>
										<th scope="col" class="text-center">통계</th>
									</tr>
								</thead>
			                    <tbody>
			                    	<c:forEach var="result" items="${resultList}" varStatus="status">
			                    		<tr>
				                    		<td class="text-center" style="vertical-align:middle">
				                    			<c:out value="${listNo -(status.count-1) }" />
				                    		</td>
				                    		<td class="text-center" style="vertical-align:middle">
				                    			<a href="/_mngr_/survey/mngrSurvey_regist.do?schId=${result.svIdx}">${result.svTitle}</a>
				                    		</td>
				                    		<td class="text-center" style="vertical-align:middle">
				                    			<fmt:formatDate value="${result.svStartdate}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${result.svEnddate}" pattern="yyyy-MM-dd"/>
				                    		</td>
				                    		<td class="text-center" style="vertical-align:middle">
				                    			<a href="javascript:fn_viewAnswerList('${result.svIdx}');">${result.saNum}</a>
				                    		</td>
				                    		<td class="text-center" style="vertical-align:middle">
		                    					<c:choose>
		                    						<c:when test="${result.useyn eq 'svstatus01'}">
		                    							<span class="text-red">${result.etc1 }</span><br/>
				                    					<c:if test="${result.saNum<1 }">
			                    							<button type="button" onclick="fn_chkDel('${result.svIdx}');" class="btn btn-danger btn-xs">삭제</button>
				                    					</c:if>
				                    				</c:when>
				                    				<c:when test="${result.useyn eq 'svstatus02'}">
		                    							<span class="text-orange">${result.etc1 }</span><br/>
				                    					<button type="button" onclick="fn_changeStatus('${result.svIdx}','svstatus04');" class="btn btn-success btn-xs">시작</button>
				                    					<c:if test="${result.saNum<1 }">
			                    							<button type="button" onclick="fn_chkDel('${result.svIdx}');" class="btn btn-danger btn-xs">삭제</button>
				                    					</c:if>
				                    				</c:when>
				                    				<c:when test="${result.useyn eq 'svstatus03'}">
		                    							<span class="text-blue">${result.etc1 }</span><br/>
				                    					<button type="button" onclick="fn_changeStatus('${result.svIdx}','svstatus04');" class="btn btn-success btn-xs">재시작</button>
				                    					<button type="button" onclick="fn_changeStatus('${result.svIdx}','svstatus01');" class="btn btn-primary btn-xs">종료</button>
				                    					<c:if test="${result.saNum<1 }">
			                    							<button type="button" onclick="fn_chkDel('${result.svIdx}');" class="btn btn-danger btn-xs">삭제</button>
				                    					</c:if>
				                    				</c:when>
				                    				<c:when test="${result.useyn eq 'svstatus04'}">
		                    							<span class="text-blue">${result.etc1 }</span><br/>
				                    					<button type="button" onclick="fn_changeStatus('${result.svIdx}','svstatus03');" class="btn btn-primary btn-xs">일시정지</button>
				                    					<button type="button" onclick="fn_changeStatus('${result.svIdx}','svstatus01');" class="btn btn-success btn-xs">종료</button>
				                    				</c:when>
				                    			</c:choose>
				                    		</td>
				                    		<td class="text-center">
				                    			<button type="button" class="btn btn-success btn-xs"
				                    				onclick="fn_view_result(${result.svIdx}, '<fmt:formatDate value="${result.svStartdate}" pattern="yyyy-MM-dd"/>', '<fmt:formatDate value="${result.svEnddate}" pattern="yyyy-MM-dd"/>')" <c:out value="${result.saNum>0 ? '' : 'disabled'}"/> >
				                    				문항별 통계
				                    			</button>
				                    		</td>
				                    	</tr>
			                    	</c:forEach>
									<c:if test="${fn:length(resultList ) == 0}">
										<tr><td class="text-center" colspan="6">데이터가 없습니다.</td></tr>
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


 <div class="modal" id="survAnswerMemberList">
   <div class="modal-dialog">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="fn_closeModal();"><span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title"><span id="surveyName"></span> - 설문 참여자 목록</h4>
       </div>
       <div class="modal-body">
         <table id="example1" class="table table-bordered table-striped">
			<colgroup>
				<col style="width:50px;"/>
				<col/>
				<col/>
				<col/>
				<col/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="text-center">번호</th>
					<th scope="col" class="text-center">참여자</th>
					<th scope="col" class="text-center">답변일</th>
				</tr>
			</thead>
			<tbody id="answerMemberList">
			</tbody>
		</table>
       </div>
       <div class="modal-footer">
       	 <button type="button" class="btn btn-primary" data-dismiss="modal" id="excelDownBtn" onclick="memListExcelDownload();"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button>
         <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="fn_closeModal();">닫기</button>
       </div>
     </div><!-- /.modal-content -->
   </div><!-- /.modal-dialog -->
 </div><!-- /.modal -->



  <div class="modal" id="surveyResultModal">
   <div class="modal-dialog" style="width: 900px;">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="fn_closeModal();"><span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title"><span id="surveyName"></span> 설문 결과</h4>
       </div>
       <div class="modal-body">
         <div class="resultHead">
         	<table style="width: 100%;">
         		<tr>
         			<td>
         				<span class="input-daterange input-group">
			         		<input type="text" class="form-control required" id="strDt" readOnly="readOnly"/>
					    	<span class="input-group-addon">~</span>
					    	<input type="text" class="form-control required" id="endDt" readOnly="readOnly" />
					    </span>
         			</td>
         			<td style="text-align: right"><button class="btn btn-info" onclick="fn_changeResultDate();">날짜 재설정</button></td>
         		</tr>
         	</table>
         	<input type="hidden" id="resultSvIdx" value=""/>
         </div>
         <hr/>
         <div class="resultBody" style="max-height: 500px; overflow-y: auto; padding: 5px 20px;">
         </div>
       </div>
       <div class="modal-footer">
       	 <a class="btn btn-primary" id="resultExcel">엑셀 다운로드</a>
         <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="fn_closeModal();">닫기</button>
       </div>
     </div><!-- /.modal-content -->
   </div><!-- /.modal-dialog -->
 </div><!-- /.modal -->


<script type="text/javascript">

	var queryString = "${searchVO.queryString}";

	// 진행상태 submit 처리
	function fn_changeStatus(no, stat) {
		var frm = document.listForm;

		if (no != null) {
			frm.svIdx.value = no;
		} else {
			return false;
		}

		frm.action = "/_mngr_/module/surveyStat/"+stat+".do";
		frm.submit();
	}

	// 진행상태 변경(설문 삭제)
	function fn_chkDel(no){
		var frm = document.listForm;
		if (no != null) {
			frm.svIdx.value = no;
		}
		frm.action = "survey_delete_proc.do";
		frm.submit();
	}


	// 설문 참여자 목록 조회
	function fn_viewAnswerList(no){
		$("#answerMemberList").attr("no", no);
		$.ajax({
			url : '/_mngr_/survey/survey_list_AnswerMemList.ajax',
			type : "GET",
			data : {
				svIdx : no
			},
			success : function(data){

				$("#surveyName").html(data.svTitle);
				var memList = data.answerMemList;
				var memListHTML = "";
				for (var i = 0; i < memList.length ; i++) {
					var mem = memList[i];
					memListHTML += "<tr><td style='text-align:center;'>"+(memList.length-i)+
						"</td><td style='text-align:center;'><a href='/_mngr_/survey/"+no+"/"+mem.memid+"/survey_view_answer.do' target='_blank'>"+
						mem.memid+"</a></td><td style='text-align:center;'>"+mem.answerdate+"</td></tr>"
				}
				if (memList.length == 0) {
					memListHTML = "<tr><th colspan='4' class='text-center'>설문에 참여한 사람이 없습니다.</th></tr>";
					$("#excelDownBtn").attr("disabled", "disabled");
				} else {
					$("#excelDownBtn").removeAttr("disabled");
				}

				$("#answerMemberList").html(memListHTML);
				$("#survAnswerMemberList").show();

			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});

	}

	function fn_closeModal() {
		$(".modal").hide();
	}


	//  통계 모달 통계 날짜 변경
	function fn_changeResultDate() {
		var svIdx = $("#resultSvIdx").val();
		var strDt = $("#strDt").val();
		var endDt = $("#endDt").val();

		if (svIdx && strDt && endDt) {
			fn_view_result(svIdx, strDt, endDt);
		}else {
			alert("날짜가 입력되어 있는지 확인해주세요.");
		}
	}

	// 문항별 통계 모달 보기
	function fn_view_result(svIdx, strDt, endDt) {

		$("#resultSvIdx").val(svIdx);
		$("#surveyResultModal").find(".resultBody").html("<p style='text-align:center;'>통계자료 작성 중 입니다<br/>잠시만 기다려주세요</p>");
		$("#strDt").val(strDt);
		$("#endDt").val(endDt);
		$("#resultExcel").attr("href", "/excel/surveyResult_down_excel.do?strDt="+strDt+"&endDt="+endDt+"&svIdx="+svIdx);

		$.ajax({
			url : "/_mngr_/survey/"+svIdx+"/survey_view_result.ajax",
			type : "GET",
			data : {
				strDt : strDt ? strDt : "",
				endDt : endDt ? endDt : ""
			},
			success : function(data){
				$("#surveyResultModal").find(".resultBody").html(data);
				$("#surveyResultModal").show();
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}

	function fn_egov_link_page(page) {
		var tmpQuery = queryString;
		tmpQuery = ItgJs.fn_replaceQueryString(tmpQuery, "page", page);
		location.href="?" + tmpQuery;
	}

	function memListExcelDownload() {
		location.href="/excel/surveyMemList_down_excel.do?svIdx="+$("#answerMemberList").attr("no");
	}

	$.fn.datepicker.dates['kr'] = {
			days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
			daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
			daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
			months: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
			monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
		};
		$('.input-daterange').datepicker({
	    	format: "yyyy-MM-dd",
	    	language: "kr",
	    	autoclose: true,
	    	todayHighlight: true
		});
</script>

