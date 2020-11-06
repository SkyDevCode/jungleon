<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%-- S: 추가 영역 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- E: 추가 영역 --%>
<link rel="stylesheet" type="text/css" href="/resource/plugins/ax5ui/ax5ui.itg.css"/>
<script type="text/javascript" src="/resource/plugins/ax5ui/ax5core.min.js"></script>
<script type="text/javascript" src="/resource/plugins/ax5ui/ax5ui.itg.js"></script>
<script type="text/javascript" src="/resource/plugins/ax5ui/jquery-direct.js"></script>

                <h3 class="title-style_1">상세 정보</h3>
				<div class="table-list2 mypage_hall_table">
					<table>
						<caption>담당자, 신청자 ID, 연락처, 이메일, 소재지, 고객 구분, 회사명/단체명, 모임 분류, 인원, 반입 물품, 파일업로드에 대한 정보가 기재된표</caption>
						<tbody>
							<tr>
								<th scope="row">담당자</th>
								<td>
									<c:out value="${result.rName }"/>
								</td>
								<th scope="row">신청자 ID</th>
								<td><c:out value="${result.rId }" /></td>
							</tr>
							<tr>
								<th scope="row">연락처</th>
								<td>
									<c:out value="${result.rTel }"/>
								</td>
								<th scope="row">이메일</th>
								<td><c:out value="${result.rEmail }"/></td>
							</tr>
							<tr>
								<th scope="row">소재지</th>
								<td><c:out value="${result.rAddr }"/></td>
								<th scope="row">고객 구분</th>
								<td><c:out value="${result.rCustTypeName }" /></td>
							</tr>
							<tr>
								<th scope="row">회사명/단체명</th>
								<td><c:out value="${result.rComName }"/></td>
								<th scope="row">모임 분류</th>
								<td><c:out value="${result.rMeetTypeName }" /></td>
							</tr>
							<tr>
								<th scope="row">인원</th>
								<td colspan="3"><c:out value="${result.rPersonNum }"/></td>
							</tr>
							<tr>
								<th scope="row">반입 물품</th>
								<td colspan="3"><c:out value="${result.rCarry }"/></td>
							</tr>
							<tr>
								<th scope="row">파일업로드</th>
								<td colspan="3">
									<!-- <ul class="attachment_list">
										<li><a href="#">첨부파일명.hwp</a></li>
									</ul> -->
									<c:import  url="/afile/filedownForm.do">
													<c:param name="formName" value="form1" />
													<c:param name="objectId" value="upload1" />
													<c:param name="fileIdName" value="fileId" />
													<c:param name="fileIdValue" value="${result.fileId}" />
													<c:param name="fileTypes" value="all" />
													<c:param name="maxFileSize" value="50" />
													<c:param name="maxFileCount" value="5" />
													<c:param name="useSecurity" value="false" />
													<c:param name="uploadMode" value="db" />
												</c:import>
								</td>
							</tr>

						</tbody>
					</table>
				</div>

				<h3 class="title-style_1">대관 예약</h3>
				<div class="table-list2 mypage_hall_table">
					<table>
						<caption>대관 장소, 장비 선택, 예약 날짜, 예약 시간, 사용료에 대한 정보가 기재된표</caption>
						<tbody>
							<tr>
								<th scope="row">대관 장소</th>
								<td>
									<c:out value="${result.rFacilityName }" />
								</td>
								<th scope="row">장비 선택</th>
								<td>
									<c:out value="${result.rEquipmentName }" />
								</td>
							</tr>
							<tr>
								<th scope="row">예약 날짜</th>
								<td colspan="3">
									<c:out value="${result.rReserveDt }"/>
								</td>
							</tr>
							<tr>
								<th scope="row">예약 시간</th>
								<td colspan="3">
									<c:set var="arrReserveTm" value="${fn:split(result.rReserveTm , ',')}" />
									<c:forEach var="tm" items="${arrReserveTm }">
										<c:out value="${tm }"/>:00 ~ <c:out value="${tm + 1}"/>:00
									</c:forEach>
								</td>
							</tr>
							<tr>
								<th scope="row">사용료</th>
								<td colspan="3">
									<fmt:formatNumber value="${result.rCharge }" type="number" /> 원 (부가세 포함)
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<h3 class="title-style_1">접수처리 결과 </h3>
				<div class="table-list2 mypage_hall_table">
					<table>
						<caption>처리 상태에 대한 정보가 기재된표</caption>
						<tbody>
							<tr>
								<th scope="row">처리 상태</th>
								<td>
									<c:out value="${result.rStatusName }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="board-bottom_style1">
					<a href="#none" onclick="fn_goList(); return false;" class="btn list-icon">목록</a>
				</div>

				<script>
					var query = "${searchVO.query}";
					function fn_goList(){
						query = ItgJs.fn_replaceQueryString(query, "schM", "list");
						location.href = "?" + query;
					}
				</script>