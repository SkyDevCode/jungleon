<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />

	<script type="text/javascript">
	//<[[!CDATA[
	$(document).ready(function(){
		//iCheck for checkbox and radio inputs
		$('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
			checkboxClass: 'icheckbox_minimal-red',
			radioClass: 'iradio_minimal-red',
			increaseArea: '20%' // optional
		});

		//Flat red color scheme for iCheck
		$('input[type="checkbox"].minimal, input[type="radio"].flat-green').iCheck({
			checkboxClass: 'icheckbox_flat-green',
			radioClass: 'iradio_flat-green',
			increaseArea: '20%' // optional
		});

		$('.iradio_minimal-red ~label').css("margin","0 10px 0 5px");
		$('.iradio_flat-green ~label').css("margin","0 10px 0 5px");

		$(".select2").select2();
	});
	//]]>
		/**
		 * <a href="#">링크</a>
		 * 위와 같은 형태로 된 링크를 '#'동작이 먹지 않게 막는다.
		 */
		$(document).delegate("a[href='#']","click",function(event){
			event.preventDefault();
		});
	</script>

	<footer class="main-footer">
		<div class="pull-right hidden-xs">
			<b>Version</b> 3.05
		</div>
		<strong>Copyright &copy; 2014-<fmt:formatDate pattern="yyyy" value="${now}" />&nbsp;<a href="http://www.itgood.co.kr/">ITGOOD</a>.</strong> All rights reserved.
	</footer>
</div><!-- ./wrapper -->

<div id="loadingLayer" style="position: fixed; display: block; width: 100%; background-color: rgba(0,0,0,0.6); z-index: 9999; top: 0; left: 0;"></div>