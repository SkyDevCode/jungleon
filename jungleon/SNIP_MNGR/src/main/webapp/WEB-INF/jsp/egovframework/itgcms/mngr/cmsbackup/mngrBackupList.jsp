<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>

	<!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            CMS 백업
            <!-- <small>관리자 회원 목록</small> -->
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li class="active">CMS 백업</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">

			<div class="row">
				<div class="col-md-12">
					<div class="box">
						<div class="box-body">
							<div class="row margin-bottom">
								<div class="col-sm-8 form-inline"></div>
								<div class="col-sm-4 text-right">
									<button type="button" class="btn btn-primary btn-sm">백업하기</button>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
								      <table id="example1" class="table table-bordered table-striped">
								        <thead>
											<tr>
												<th rowspan="2" scope="col" >백업 일자</th>
												<th colspan="2" scope="col" >백업 파일 명</th>
											</tr>
											<tr>
												<th scope="col">DB</th>
												<th scope="col">프로그램</th>
											</tr>
										</thead>
								        <tbody>
								        	<tr>
												<td>2017-11-28</td>
												<td>20171120121737_mysql_2</td>
												<td>20171120121244_prog_2</td>
											</tr>
											<tr>
												<td>2017-09-10</td>
												<td>20170910141011_mysql_1</td>
												<td>20170910141011_prog_1</td>
											</tr>
										</tbody>
								      </table>
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
//<![CDATA[
    var queryString = "${searchVO.query}";

	/* 글 등록 화면 function */
	function fn_goRegist() {
		location.href="mngrSiteRegist.do";
	}
	/* 글 수정 화면 function */
	function fn_goView(id) {
		location.href="selectSiteView.do?" + ItgJs.fn_replaceQueryString(queryString, "id", id);
	}
//]]>
</script>