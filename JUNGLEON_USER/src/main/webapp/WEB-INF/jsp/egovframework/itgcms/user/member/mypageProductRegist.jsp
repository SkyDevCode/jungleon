<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
                <form name="form1" method="post" onsubmit="fn_save(); return false;" enctype="multipart/form-data">
					<fieldset>
						<legend>제품의 기본정보와 담당자 정보를 입력받는 폼</legend>
						<h3>기본 정보 </h3>
						<div class="table-list2 corporation-info_table">
							<table>
								<caption>상품명, 상품분류, 상품 홈페이지 URL, 상품 이미지 상품 영상 첨부, 제품소개에 대한 정보를 기재하는 표</caption>
								<tbody>
									<tr>
										<th scope="row"><label for="prdNm">상품명</label> <span class="must-icon" title="필수체크 항목">*</span></th>
										<td>
											<input type="text" name="prdNm" id="prdNm" maxlength="100" class="required" title="상품명"/>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="unCd">상품분류</label> <span class="must-icon" title="필수체크 항목">*</span></th>
										<td>
											<div class="designation_area clfx">
												<input type="text" name="unCd" id="schKsicCd" readonly="readonly" title="상품분류 코드 입력란" />
												<input type="text" name="unNm" id="schKsicNm" readonly="readonly" class="product_classification_right required" title="상품분류명 입력란" />
												<a href="javascript:void(0);" class="btn_designation btn-modal-pop"  id="ksic_popup" title="분류검색 레이어팝업창으로 이동"><span>분류지정</span></a>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="homePage">상품 홈페이지 URL</label></th>
										<td>
											<input type="text" name="homePage" id="homePage" maxlength="50" class="validate-url" placeholder="입력URL 표출" />
											<p class="info_txt">※ 입력 예 : http://www.nl.go.kr</p>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="prdImg01">상품 이미지</label> <span class="must-icon" title="필수체크 항목">*</span></th>
										<td>
											<input type="file" name="prdImg01" id="prdImg01" class="required" title="상품 이미지1" />
											<input type="file" name="prdImg02" id="prdImg02"  />
											<input type="file" name="prdImg03" id="prdImg03"  />
											<ul class="info_txt_list">
												<li>※ 사이즈 (가로 : 385px, 세로 : 240px) / <span class="c-sky">최대 3개까지 가능</span></li>
												<!-- <li>※ 파일을 첨부, 삭제 후에 반드시 변경사항을 적용해야 반영됩니다. (순서변경제외) <button class="small-btn-black ">적용</button></li> -->
											</ul>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="prdVideo01">상품 영상 첨부 </label></th>
										<td>
											<input type="file" name="prdVideo01" id="prdVideo01"  />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="prdDescShort">제품소개</label> <span class="must-icon" title="필수체크 항목">*</span></th>
										<td>
											<textarea name="prdDescShort" id="prdDescShort" cols="30" rows="10" maxlength="100" class="required" title="제품소개"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<h3>담당자 정보</h3>
						<div class="table-list2 corporation-info_table mypage-product_person_tb">
							<table>
								<caption>담당자명, 전화번호, 팩스번호에 대한 정보가 기재하는 표</caption>
								<tbody>
									<tr>
										<th scope="row"><label for="charger">담당자명</label></th>
										<td>
											<input type="text" name="charger" id="charger" maxlength="20" />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="telNo">전화번호</label></th>
										<td>
											<input type="text" name="telNo" id="telNo" />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="faxNo">팩스번호</label> </th>
										<td>
											<input type="text" name="faxNo" id="faxNo" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="board-bottom_style1">
							<a href="#none" onclick="fn_save(); return false;" class="btn btn-blue">등록</a>
							<a href="/${siteCode}/contents/myproduct-list.do" class="btn btn-gray">취소</a>
						</div>
					</fieldset>
				</form>
				
				<!-- 분류검색 레이어팝업 -->
				<div class="layerpopup pop02 ksic_popup" >
					<h3 class="pop-header"><strong>분류검색</strong></h3>
					<div class="pop-content">
						<ul class="ksic_info">
							<li>성남 벤처넷은 UNSPSC(United Nation Standard Products and Service Code)기준 하에 상품을 분류합니다.</li>
						</ul>
						<form action="#">
							<fieldset>
								<legend>1차, 2차, 3차, 4차 분류별 검색하는 폼</legend>
								<table>
									<caption>1차분류, 2차분류, 3차분류, 4차분류를 선택하는 표</caption>
									<tbody>
										<tr>
											<th scope="row"><label for="unspscDepth1">1차 분류 선택</label></th>
											<td>
												<select name="unspscDepth1" id="unspscDepth1" onchange="fn_searchUnspsc(this.value, 2);">
													<option value="">선택하세요.</option>
												<c:forEach var="unspsc" items="${unspscList }">
													<option value="<c:out value="${unspsc.unCd }" />"><c:out value="${unspsc.unNm }" /></option>
												</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row"><label for="unspscDepth2">2차 분류 선택</label></th>
											<td>
												<select name="unspscDepth2" id="unspscDepth2" onchange="fn_searchUnspsc(this.value, 3);">
													<option value="">선택하세요.</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row"><label for="unspscDepth3">3차 분류 선택</label></th>
											<td>
												<select name="unspscDepth3" id="unspscDepth3" onchange="fn_searchUnspsc(this.value, 4);">
													<option value="">선택하세요.</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row"><label for="classify_4">4차 분류 선택</label></th>
											<td>
												<select name="unspscDepth4" id="unspscDepth4" onchange="fn_setUnspsc(this.value, 'unspscDepth4');">
													<option value="">선택하세요.</option>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
								<button onclick="return false;" class="btn-pop-close">
									팝업닫기
								</button>
							</fieldset>
						</form>
					</div>
				</div>
				<!-- //분류검색 레이어팝업 -->
				
				<script type="text/javascript" src="/resource/common/jquery_plugin/validation/validator.js"></script>
				<script>
				$(function(){
					$(".subcont").addClass("mypage-product_write");
				})
				
				function fn_save() {
					var frm = document.form1;
					if(Validator.validate(frm)){
						if(confirm("등록하시겠습니까?")){
							frm.action = "/${siteCode}/module/${menuCode}_mypageProductRegistProc.do" ;
							frm.submit();
						}
					}
				}
				
				function fn_searchUnspsc(unCd, depth) {
					if(unCd == "") {
						for(var i = depth; i < 5; i++){
							$("#unspscDepth" + i).empty();
							$("#unspscDepth" + i).append("<option value=''>선택하세요.</option>");
						}
						return;
					}
					// 선택 설정. 
					fn_setUnspsc(unCd, 'unspscDepth' + (depth - 1));
					var data="unCd="+unCd+"&depth="+depth;
					$.ajax({
						url: "/${siteCode}/product/userUnspscSearch.ajax",
						data: data,
						dataType: "json",
						success: function(resultData) {
							if(resultData.result == "1") {
								$("#unspscDepth" + depth).empty();
								$("#unspscDepth" + depth).append("<option value=''>선택하세요.</option>");
								for(var i = 0; i < resultData.data.length; i++ ) {
									var option = "<option value='"+resultData.data[i].unCd+"'>"+resultData.data[i].unNm+"</option>";
									$("#unspscDepth" + depth).append(option)
								}
							} else {
								alert(resultData.message);
								return;
							}
						},
						error:function(request,status,error){
							alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					})
				}
				
				function fn_setUnspsc(unCd, objId) {
					$("#schKsicCd").val(unCd);
					$("#schKsicNm").val($("#" + objId + " option:selected").text());
				}
				</script>