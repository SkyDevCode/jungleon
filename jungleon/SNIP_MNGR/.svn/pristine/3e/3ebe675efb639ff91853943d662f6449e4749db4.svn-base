<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="commentSection" class="comment_wrap" style="width: 100%;">
	<p class="comment_total">댓글 <span class="blind">총</span><span class="num">0</span></p>
		<div class="textarea_wrap">
			<p class='tit'>댓글</p>
			<div class="inner">
				<textarea id="commentContents" title="댓글달기"></textarea>
				<span class="btn_wrap">
					<button type="button" class="btn btn_enroll" onclick="registComment('regist')">등록</button>
				</span>
			</div>
		</div>
	<c:if test="${sessionScope.userSessionVO.id != null || sessionScope.mngrSessionVO != null}">
		<c:if test="${boardAuthVO.regist eq true}">
		</c:if>
	</c:if>
	<div id="commentList"  class="comment_lst" style="width: 100%;"></div>
</div>

<script>
	var bdIdx = ${boardMap.bdIdx};
	<c:if test="${sessionScope.userSessionVO.id != null || sessionScope.mngrSessionVO != null}">
		var loginId = "${sessionScope.userSessionVO.id}";
		var loginNm = "${sessionScope.userSessionVO.name}";
		<c:if test="${sessionScope.mngrSessionVO != null}">
			loginId = "${sessionScope.mngrSessionVO.id}";
			loginNm = "${sessionScope.mngrSessionVO.name}";
		</c:if>

		function registComment(act, reIdx, reComId) {

			var content = "";

			if (act == "regist") {
				content =  $("#commentContents").val();
				if ("" === content) {
					alert("댓글을 입력한 후 시도하세요.");
					return false;
				}
				$.ajax({
					url : '/comment/com/${boardMap.bdIdx}.do',
					type : "POST",
					data : {
						id : loginId,
						content : content
					},
					success : function(data){
						if (data <= 0) {
							alert("정상적인 데이터가 아닙니다. 창을 새로고침 후에 다시 시도해보세요.");
						} else {
							//reqCommentListData(data);
							reqCommentListData(1);
							$("#commentContents").val("");
						}
					},
					error : function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			} else if (act == "recom") {
				content =  $("#recommentContent").val();
				if ("" === content) {
					alert("댓글을 입력한 후 시도하세요.");
					return false;
				}
				$.ajax({
					url : "/comment/com/${boardMap.bdIdx}/"+reIdx+".do",
					type : "POST",
					data : {
						id : loginId,
						content : content,
						recomId : reComId
					},
					success : function(data){
						if (data <= 0) {
							alert("정상적인 데이터가 아닙니다. 창을 새로고침 후에 다시 시도해보세요.");
						} else {
							reqCommentListData($("#comActPage").html());
							$("#commentContents").val("");
						}
					},
					error : function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			} else {

				content =  $("#recommentContent").val();
				if ("" === content) {
					alert("댓글을 입력한 후 시도하세요.");
					return false;
				}
				$.ajax({
					url : "/comment/com/mod/"+reIdx+".do",
					type : "POST",
					data : {
						id : loginId,
						content : content
					},
					success : function(data){
						if (data <= 0) {
							alert("정상적인 데이터가 아닙니다. 창을 새로고침 후에 다시 시도해보세요.");
						} else {
							reqCommentListData($("#comActPage").html());
							$("#commentContents").val("");
						}
					},
					error : function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});


			}
		}

		function deleteComment(cIdx, regId){
			if (loginId == regId) {
				if(confirm("삭제하시겠습니까?")) {
					$.ajax({
						url : "/comment/com/del"+cIdx+".do",
						type : "post",
						data : {
							id : loginId,
							regId : regId
						},
						success : function(data){
							switch (data) {
							case 1: reqCommentListData($("#comActPage").html());
								break;
							case 0 : alert("삭제할 수 없는 글입니다.");
								break;
							default : alert("새로고침 한 후 다시 시도해주세요");
								break;
							}
						},
						error : function(request,status,error){
							alert("새로고침 한 후 다시 시도해주세요");
						}
					});
				}
			} else {
				alert("자신의 댓글만 삭제할 수 있습니다.");
			}
		}


		function modifyComment(cIdx, regMemId) {
			//if (loginId === regMemId) {
				recommentForm(cIdx, regMemId, cIdx, $("#comment_"+cIdx).find(".cContents").html());
			//}

		}


		function recommentForm(cidx, regMemId, cReidx, str){

			var act = "modify";
			if (!str) {str = ""; act="recom";}

			var recommentHtml = "<tr id='recommentForm' class='recomment_bx'>";
			if(act=="recom"){
				recommentHtml += 	"<td>"+
										"<div class='textarea_wrap'><p class='tit'>댓글</p><div class='inner'>"+
											"<textarea id='recommentContent' title='댓글달기'></textarea>"+
									        	"<span class='btn_wrap'>"+
									          		"<button type='button' class='btn btn_enroll' onclick='registComment(\""+act+"\", "+cReidx+", \""+regMemId+"\")'>등록"+
											   		"</button>"+
									        	"</span>"+
									        "</div></div>"+
											"</td>"
								 "</tr>";
			}
			else{
				recommentHtml +=
										"<td>"+
											"<div class='textarea_wrap'><p class='tit'>댓글 수정</p><div class='inner'>"+
												"<textarea id='recommentContent' title='댓글달기''></textarea>"+
									        	"<span class='btn_wrap'>"+
									          		"<button type='button' class='btn btn_enroll' onclick='registComment(\""+act+"\", "+cReidx+", \""+regMemId+"\")'>수정"+
											   		"</button>"+
									        	"</span>"+
									        "</div></div>"+
											"</td>"
										 "</tr>";
			}
			$("#recommentForm").remove();
			$("#comment_"+cidx).after(recommentHtml);
			if (str!="") {
				$("#recommentContent").val(str);
			}
		}

		function buildCommentListTableHTML(list) {

			var html = "<table class='table table-bordered tp2' style='width: 100%;'>"+
							"<colgroup>"+
								"<col />"+
							"</colgroup>";

			if (list != null) {
				for (var i = 0; i < list.length; i++) {
					var com = list[i];
					if (com.cWriter === "") {
						com.cWriter = "이름 없음";
					}
					if (com.cReIdx==com.cidx) {
						html += "<tr id='comment_"+com.cidx+"' class='comment_bx'>";
										if (com.regMemId == loginId) {
											//$.format.date(com.regDt, "dd/MM/yyyy");
											var date=new Date(com.regDt);
											html += "<td class='commentContents'><span class='comment_writer'>"+com.cWriter+"</span> <span class='cContents'>"+com.cContents+"</span> <span class='comment_date'>"+date.toMyString()+"</span>"+
													"<div class='btn_wrap btn_comment'>"+
														"<button class='btn btn-primary btn-xs' onclick='recommentForm("+com.cidx+", \""+com.regMemId+"\", "+com.cReIdx+",)'>댓글</button> "+
														"<button class='btn btn-info btn-xs' onclick='modifyComment("+com.cidx+", \""+com.regMemId+"\")'>수정</button> "+
														"<button class='btn btn-danger btn-xs' onclick='deleteComment("+com.cidx+", \""+com.regMemId+"\")'>삭제</button>"+
													"</div></td>";
										}
										else{
											html += "<td class='commentContents'><span class='comment_writer'>"+com.cWriter+"</span> <span class='cContents'>"+com.cContents+"</span> <span class='comment_date'>"+com.regDt+"</span>"+
													"<div class='btn_wrap btn_comment'>"+
											<c:if test="${boardAuthVO.reply eq true}">
														"<button class='btn btn-primary btn-xs' onclick='recommentForm("+com.cidx+", \""+com.regMemId+"\", "+com.cReIdx+",)'>댓글</button> "+
											</c:if>
										<c:if test="${sessionScope.mngrSessionVO != null}">
											<c:if test="${boardAuthVO.update eq true}">
														"<button class='btn btn-info btn-xs' onclick='modifyComment("+com.cidx+", \""+com.regMemId+"\")'>수정</button> "+
											</c:if>
											<c:if test="${boardAuthVO.delete eq true}">
														"<button class='btn btn-danger btn-xs' onclick='deleteComment("+com.cidx+", \""+com.regMemId+"\")'>삭제</button>"+
											</c:if>
										</c:if>
													"</div></td>";
										}

									html += "</tr>";

					}
					else {
						html += "<tr id='comment_"+com.cidx+"' class='comment_bx depth'>"+
									"<td class='commentContents'><span class='ico_dep'>└</span><span class='comment_writer'>"+com.cWriter+"</span> <span class='cContents'>"+com.cContents+"</span> <span class='comment_date'>"+com.regDt+"</span>"+
									"<div class='btn_wrap btn_comment'>"
										//댓글에 대한 댓글 기능 제거
										//+"<button class='btn btn-primary btn-xs' onclick='recommentForm("+com.cidx+", \""+com.regMemId+"\", "+com.cReIdx+",)'>댓글c</button> ";
										if (com.regMemId == loginId) {
											html += "<button class='btn btn-info btn-xs' onclick='modifyComment("+com.cidx+", \""+com.regMemId+"\")'>수정</button> "+
													"<button class='btn btn-danger btn-xs' onclick='deleteComment("+com.cidx+", \""+com.regMemId+"\")'>삭제</button>";
										} else {
										<c:if test="${sessionScope.mngrSessionVO != null}">
											<c:if test="${boardAuthVO.update eq true}">
											html +=	"<button class='btn btn-info btn-xs' onclick='modifyComment("+com.cidx+", \""+com.regMemId+"\")'>수정</button> ";
											</c:if>
											<c:if test="${boardAuthVO.delete eq true}">
											html += "<button class='btn btn-danger btn-xs' onclick='deleteComment("+com.cidx+", \""+com.regMemId+"\")'>삭제</button>";
											</c:if>
										</c:if>
										}
							html +="</div></td>"+
								"</tr>";
					}
				}
			}

/* 			if (list == null || list.length == 0) {
				html += "<tr><th colspan='3'>등록된 댓글이 존재하지 않습니다.</th></tr>";
			} */

			html += "</table>";

			return html;
		}
	</c:if>
	<c:if test="${sessionScope.userSessionVO.id == null && sessionScope.mngrSessionVO == null}">
		function registComment() {
			alert("로그인이 필요합니다.");
		}

		function buildCommentListTableHTML(list) {

			var html = "<table  style='width: 100%;'>";

			if (list != null) {
				for (var i = 0; i < list.length; i++) {
					var com = list[i];
					if (com.cWriter === "") {
						com.cWriter = "이름 없음";
					}
					if (com.cReIdx==com.cidx) {
						html += "<tr id='comment_"+com.cidx+"' class='comment_bx'>"+
									"<td><span class='comment_writer'>"+com.cWriter+"</span> <span class='cContents'>"+com.cContents+"</span> <span class='comment_date'>"+com.regDt+"</span></td>"+
								"</tr>";
					} else {
						html += "<tr id='comment_"+com.cidx+"' class='comment_bx depth'>"+
									"<td><span class='ico_dep'>└</span><span class='comment_writer'>"+com.cWriter+"</span> <span class='cContents'>"+com.cContents+"</span> <span class='comment_date'>"+com.regDt+"</span></td>"+
								"</tr>";
					}
				}
			}

/* 			if (list == null || list.length == 0) {
				html += "<tr><th colspan='3'>등록된 댓글이 존재하지 않습니다.</th></tr>";
			} */

			html += "</table>";

			return html;
		}
	</c:if>

	function buildPagenateHTML(pageInfo){

		var pageHtml = "<div class='pagingWrap' style='text-align:center;'>";

		if (pageInfo.totalPageCount > pageInfo.pageSize) {
				pageHtml += "<a class='btn prevAll' href='javascript:reqCommentListData("+pageInfo.firstPageNo+")'><span class='blind'>처음으로</span></a>";
			if (pageInfo.firstPageNoOnPageList > pageInfo.pageSize) {
				pageHtml += "<a class='btn prev' href='javascript:reqCommentListData("+(pageInfo.firstPageNoOnPageList-1)+")'><span class='blind'>이전</span></a>";
			}else{
				pageHtml += "<a class='btn prev' href='javascript:reqCommentListData("+pageInfo.firstPageNo+")'><span class='blind'>이전</span></a>";
			}
		}

		for (var i = pageInfo.firstPageNoOnPageList; i <= pageInfo.lastPageNoOnPageList ; i++) {
			console.log("i : "+i);
			console.log("currentPage : "+pageInfo.currentPageNo);
			if (i == pageInfo.currentPageNo) {
				pageHtml += "<strong class='on' id='comActPage'>"+i+"</strong>";

			} else {
				pageHtml += "<a href='javascript:reqCommentListData("+i+")'>"+i+"</a>";
			}
		}

		if (pageInfo.totalPageCount > pageInfo.pageSize) {
				console.log("firstPageNoOnPageList : "+pageInfo.firstPageNoOnPageList);
				console.log("pageSize : "+pageInfo.pageSize);
				console.log("lastPageNo : "+pageInfo.lastPageNo);
			if (pageInfo.lastPageNoOnPageList < pageInfo.totalPageCount) {
				pageHtml += "<a class='btn next' href='javascript:reqCommentListData("+(pageInfo.firstPageNoOnPageList+pageInfo.pageSize)+")'><span class='blind'>다음</span></a>";
			}else{
				pageHtml += "<a class='btn next' href='javascript:reqCommentListData("+pageInfo.lastPageNo+")'><span class='blind'>다음</span></a>";
			}
				pageHtml += "<a class='btn nextAll' href='javascript:reqCommentListData("+pageInfo.lastPageNo+")'><span class='blind'>끝으로</span></a>";
		}

		return pageHtml+"</div>";
	}


	function reqCommentListData(page) {

		var html = "";
		if (!page) {page = 1;}
		$.ajax({
			url : "/comment/list/${boardMap.bdIdx}/"+page+".do",
			type : "GET",
			async : false,
			success : function(data){
				console.log(data.pageInfo);
				if(data != null) $(".comment_total .num").text(data.pageInfo.totalRecordCount);
				if (data.list != null && data.list.length > 0) {
					html = buildCommentListTableHTML(data.list);
					if (data.pageInfo.lastPageNo > 1) {
						html += buildPagenateHTML(data.pageInfo);
					}
					$("#commentList").show();
				}else{
					$("#commentList").hide();
				}
			},
			error : function(request,status,error){
				html = "<tr><th>댓글을 불러오는데 실패하였습니다. 새로고침 해주세요.</th></tr>";
			}
		});
		$("#commentList").empty().html(html);
	}


	$(function(){
		reqCommentListData(1);
	});


</script>