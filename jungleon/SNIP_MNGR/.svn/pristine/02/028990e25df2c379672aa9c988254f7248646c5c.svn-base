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
						<div class="caution-box" style="margin-bottom:40px;">
						    <h4 class="caution-title" style="color:#d54e21;font-size:20px;">확인</h4>
						    <ol class="caution-content">
						    	<li>접근할 수 없는 IP가 되면, "웹 페이지를 찾을 수 없습니다." 라는 메시지가 적힌 페이지로 보내져, 접근이 불가능하게 됩니다.</li>
						    	<li>IP목록을 입력하실 때, 형식을 지키지 않으면 시스템에 문제가 발생할 수 있습니다.
						    		<ul>
						   				<li>- 단일 IP 예시 : 198.120.14.1</li>
						   				<li>- IP 범위 예시 : 198.120.14.1-198.121.15.3 혹은 198.120.</li>
						   				<li>- 조건 구분은 ,(콤마)로 작성해야 합니다. (예시 : 198.120.14.1, 198.120., 198.120.14.1-198.121.15.3)</li>
						   			</ul>
						    	</li>
						    	<li>
						   			아래 표의 구분은 다음과 같습니다.
						   			<ul>
						   				<li>- 사용 안함 : 차단도, 허용도 사용하지 않는 상태로 IP를 확인하지 않습니다.</li>
						   				<li>- 목록 차단 : IP목록에 작성한 IP는 사용자 페이지에 접근할 수 없습니다.</li>
						   				<li>- 목록 허용 : IP목록에 작성한 IP만 접근 가능하며, 그 외의 IP는 접근할 수 없습니다.</li>
						   			</ul>
						    	</li>
						    </ol>
						</div>
						<table class="table table-bordered tp2 tac">
							<colgroup>
								<col style="width:15%;"/>
								<col style="width:150px;"/>
								<col />
								<col style="width:180px;"/>
							</colgroup>
							<thead>
								<tr>
									<th>사이트명</th>
									<th>구분</th>
									<th>IP 목록</th>
									<th>&nbsp;</th>
								</tr>
							</thead>
							<c:forEach items="${resultList}" var="result">
								<form id="${result.siteCode}_form" name="${result.siteCode}_form">
									<tr id="${result.siteCode}_tr">
										<td>
											${result.siteName}
											<input type="hidden" name="siteCode" value="${result.siteCode}"/>
										</td>
										<td>
											<select name="ipDescType" id="${result.siteCode}_type" class="form-control">
												<option value="0" <c:out value="${result.ipDescType==0?'selected': ''}"/>>사용 안함</option>
												<option value="1" <c:out value="${result.ipDescType==1?'selected': ''}"/>>목록 차단</option>
												<option value="2" <c:out value="${result.ipDescType==2?'selected': ''}"/>>목록 허용</option>
											</select>
										</td>
										<td>
											<%--IP 목록 입력 시 ip 형식 유효성 체크를 위해  validator.js의 validate-ip 적용--%>
											<textarea rows="2" class="form-control" id="${result.siteCode}_newDesc" name="ipDesc" style="resize:none;">${result.ipDesc}</textarea>
											<input type="hidden" id="${result.siteCode}_orgDesc" value="${result.ipDesc}"/>
										</td>
										<td class="tac">
											<span>
												<button type="button" class="btn btn-default" onclick="fn_resetIPDesc('${result.siteCode}', ${result.ipDescType})">원래대로</button>
												<button type="button" class="btn btn-primary" onclick="fn_saveDesc('${result.siteCode}_form')">저장</button>
											</span>
										</td>
									</tr>
								</form>
							</c:forEach>
						</table>
			</div><!-- /.box-body -->
		</div><!-- /.box -->
	</div><!-- /.col -->
</div><!-- /.row -->
<script type="text/javascript">
//<![CDATA[
function fn_resetIPDesc(siteCode, descType){
	$("#"+siteCode+"_newDesc").val($("#"+siteCode+"_orgDesc").val());
	$("#"+siteCode+"_type").children().removeAttr("selected").filter("[value='"+descType+"']").attr("selected", "selected");
}

function fn_saveDesc(fromId){
	var frm = document.getElementById(fromId);
	frm.ipDesc.value = $.trim(frm.ipDesc.value);
	if(Validator.validate(frm)){
		$.ajax({
			url : 'ip_edit_proc.ajax',
			data : $(frm).serialize(),
			type : "POST",
			success : function(data){
				if(data.status === "success") {
					alert(data.msg);
				} else {
					alert(data.msg+"\n 에러 상태 : "+data.status);
				}
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
}
//]]>
</script>
