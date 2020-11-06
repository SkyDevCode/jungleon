<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
		
	<c:choose>
		<c:when test="${twitter == null}">
			alert("로그인에 실패하였습니다.");
			window.close();
		</c:when>
		<c:otherwise>
			opener.twResetAccessToken("${twitter.smAccesstoken}", "${verifier}", "Y", function(){
				alert("로그인에 성공하였습니다.");
				// window.close();
			});
						
		</c:otherwise>
	</c:choose>
		
	
</script>