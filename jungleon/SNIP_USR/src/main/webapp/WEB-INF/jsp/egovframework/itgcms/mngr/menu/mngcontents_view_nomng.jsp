<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/tlds/egovfn.tld"%>
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-body">
<div class="error-content" style="margin: auto; max-width:500px; min-height:500px;">
  <p style="text-align:center;margin-top:200px;"><img src="/resource/common_adm/img/error-msg.png" alt="오류 메세지"></p>
  <h3>관리자 페이지 사용안함</h3>
  <p>이 메뉴는 관리자 페이지가 사용되지 않는 메뉴입니다.</p>
  <p>메뉴타입 : ${ufn:deCode(result.menuType, '0,폴더,2,프로그램,4,외부링크', '컨텐츠없음')}</p>
</div>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->