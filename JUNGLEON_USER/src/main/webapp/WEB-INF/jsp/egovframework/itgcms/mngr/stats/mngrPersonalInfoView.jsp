<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<%
/**
 * @파일명 : mngrStatsTermView.jsp
 * @파일정보 : 통계관리 기간별 접속통계 뷰
 * @수정이력
 * @수정자     수정일       수정내용
 * @--------- ------------- ---------------
 * @ bluejick  2016. 3. 30. 최초생성
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
            개인정보취급이력
            <!-- <small>관리자 회원 목록</small> -->
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="#">회원관리</a></li>
            <li class="active">개인정보취급이력</li>
          </ol>
        </section>

        <!-- Main content -->
         <section class="content">

			<div class="row">
				<div class="col-md-12">
					<div class="box">
						<div class="box-body">
							<div class="row margin-bottom">
								<div class="col-sm-8 form-inline">
									<div class="col-sm-8 form-inline">
										<label for="viewCount" class="sr-only">리스트 갯수</label>
										<select name="viewCount" id="viewCount" class="form-control input-sm">
											<option value="10" ${ufn:selected(searchVO.viewCount, '10') }>10</option>
											<option value="30" ${ufn:selected(searchVO.viewCount, '30') }>30</option>
											<option value="50" ${ufn:selected(searchVO.viewCount, '50') }>50</option>
											<option value="100" ${ufn:selected(searchVO.viewCount, '100') }>100</option>
										</select>

										<label for="schFld" class="sr-only">검색조건</label>
										<select name="schFldSub" id="schFldSub" class="form-control input-sm">
											<option value="" ${ufn:selected(searchVO.schFldSub, '') }>전체</option>
											<option value="0" ${ufn:selected(searchVO.schFldSub, '0') }>관리자</option>
											<option value="1" ${ufn:selected(searchVO.schFldSub, '1') }>조회대상자</option>
										</select>

										<label for="schStr" class="sr-only">검색어</label>
										<input name="schStr" id="schStr" class="form-control input-sm" value="<c:out value="${searchVO.schStr }" />" title="검색어 입력"/>

										<button class="btn btn-default btn-sm">검색</button>
									</div>
								</div>
								<div class="col-sm-4 text-right">
									<button type="button" class="btn btn-default btn-sm"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;엑셀다운로드</button>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
								      <table id="example1" class="table table-bordered table-striped">
								        <thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">관리자</th>
												<th scope="col">조회 대상자</th>
												<th scope="col">조회 사유</th>
												<th scope="col">조회 일자</th>
											</tr>
										</thead>
								        <tbody>
								        	<tr>
												<td>10</td>
												<td>admin</td>
												<td>test123</td>
												<td>회원 승인 처리</td>
												<td>2017-11-21 09:15:11</td>
											</tr>
											<tr>
												<td>9</td>
												<td>admin</td>
												<td>test123</td>
												<td>회원 승인 처리</td>
												<td>2017-11-01 19:55:45</td>
											</tr>
											<tr>
												<td>8</td>
												<td>admin</td>
												<td>test123</td>
												<td>회원 승인 처리</td>
												<td>2017-10-30 10:44:11</td>
											</tr>
											<tr>
												<td>7</td>
												<td>tpf</td>
												<td>test2</td>
												<td>회원 정보 조회</td>
												<td>2017-10-21 09:28:01</td>
											</tr>
											<tr>
												<td>6</td>
												<td>admin</td>
												<td>test3</td>
												<td>회원 승인 처리</td>
												<td>2017-09-14 14:44:44</td>
											</tr>
											<tr>
												<td>5</td>
												<td>admin</td>
												<td>test3</td>
												<td>회원 정보 조회</td>
												<td>2017-08-01 11:47:56</td>
											</tr>
											<tr>
												<td>4</td>
												<td>admin</td>
												<td>hjw5073</td>
												<td>회원 승인 처리</td>
												<td>2017-07-01 11:44:12</td>
											</tr>
											<tr>
												<td>3</td>
												<td>admin</td>
												<td>hjw5073</td>
												<td>회원 정보 조회</td>
												<td>2017-07-01 11:31:41</td>
											</tr>
											<tr>
												<td>2</td>
												<td>admin</td>
												<td>hjw5073</td>
												<td>회원 정보 조회</td>
												<td>2017-07-01 11:25:21</td>
											</tr>
											<tr>
												<td>1</td>
												<td>admin</td>
												<td>hjw5073</td>
												<td>회원 정보 조회</td>
												<td>2017-07-01 11:21:13</td>
											</tr>
										</tbody>
								      </table>
								<div class="row">
									<div class="col-sm-5 text-left">
										&nbsp;
									</div>
									<div class="col-sm-7">
										<div
											class="text-center dataTables_paginate paging_simple_numbers"
											id="example1_paginate" style="text-align: right;">
											<ul class="pagination">
												<li class="paginate_button active on "><a href="#none">1</a></li>

											</ul>
										</div>
									</div>
								</div>
							</div> <!-- .col-sm-12 -->
								</div> <!--  .row -->


						</div> <!-- /box-body -->
					</div> <!-- /box -->
				</div> <!-- /col -->
			</div> <!-- /row -->


	          </div><!-- /.box -->
	        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->




<script type="text/javascript">

//]]>
</script>

