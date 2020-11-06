<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path1 = (String) request.getParameter("path1");
	String path2 = (String) request.getParameter("path2");

%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
var p1="<%=path1%>";
var p2="<%=path2%>";
$.ajax({
	type : "post"
	, url : "/web/link/userPreview2.ajax"
	, data : { "path1":p1,"path2" : p2  }
    , cache: false
	, dataType : "json"
	, async: false
	, success : function(data){
		var mask = data.fileMaskExt;

		/* 로컬서버
		window.open("http://localhost/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); */

	 	/* 운영서버 */
		location.href="/data/skin/doc.html?fn="+mask+"&rs=/data/html/";
		 	/* 개발서버 */
		 	/* window.open("http://snip.sitegood.co.kr/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); */

	}
	, error : function(jqXHR,textStatus,e){
		alert("문서변환 중 오류가 발생하였습니다. 관리자에게 문의해 주세요.");
		return;
	}
});
</script>