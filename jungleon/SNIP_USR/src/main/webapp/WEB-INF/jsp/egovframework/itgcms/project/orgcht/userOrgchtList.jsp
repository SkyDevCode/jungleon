<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%@ taglib prefix="ora" uri="/WEB-INF/tlds/CustomTagSelectCodeList.tld" %>
<%
/**
 * @파일명 : userOrgchtList.jsp
 * @파일정보 : 진흥원소개 > SNIP 안내 > 조직도
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @hsk1218 2020. 04. 17. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>

<div class="login-tit">
    <p>각 조직을 클릭하시면 담당자 업무 및 연락처를 보실 수 있습니다. </p>
</div>
 <div class="organa_box">
	<ul>
		<li class="dept_director"><button class="dept top-level non-event">이사장</button>
			<ul>
				<li><button class="dept one-level type1 non-event">이사회</button></li>
				<li><button class="dept one-level type2 non-event">감사</button></li>
				<li class="dept_director type2">
					<button type="button" class="dept one-level type3" onclick="fn_goView('group01')">원장</button>
					<ul class="tree-level__list">
						<li class="dept_comptroller"><button type="button" class="dept one-level__comptroller" onclick="fn_goView('group02')">감사관</button></li>
						<li class="tree-level__list01">
							<button type="button" class="dept two-level__01" onclick="fn_goView('group03')">기획경영본부</button>
							<ul>
								<li><button type="button" class="dept tree-level" onclick="fn_goView('group05')">외부자원유치단</button></li>
								<li><button type="button" class="dept tree-level" onclick="fn_goView('group07')">정책연구부</button></li>
								<li><button type="button" class="dept tree-level" onclick="fn_goView('group08')">경영기획부</button></li>
								<li><button type="button" class="dept tree-level" onclick="fn_goView('group09')">경영지원부</button></li>
								<li><button type="button" class="dept tree-level" onclick="fn_goView('group10')">사업지원부</button></li>
							</ul>
						</li>
						<li class="tree-level__list02">
							<button type="button" class="dept two-level__02" onclick="fn_goView('group04')">사업추진본부</button>
							<ul class="tree-level__list02">
								<li><button type="button" class="dept tree-level" onclick="fn_goView('group14')">기업성장부</button></li>
								<li><button type="button" class="dept tree-level" onclick="fn_goView('group15')">창업성장부</button></li>
								<li class="type2">
									<button type="button" class="dept tree-level__head" onclick="fn_goView('group06')">미래기술사업단</button>
									<ul class="tree-level__list02">
										<li><button class="dept tree-level" onclick="fn_goView('group11')">ICT산업부</button></li>
										<li><button class="dept tree-level" onclick="fn_goView('group12')">바이오헬스산업부</button></li>
										<li><button class="dept tree-level" onclick="fn_goView('group13')">콘텐츠산업부</button></li>
									</ul>
								</li>
							</ul>
						</li>
					</ul>
				</li>
			</ul>
		</li>
	</ul>
	<%-- <img src="/resource/templete/${siteconfigVO.tempCode }/src/img/sub/img_org.png" alt="" border="0" usemap="#Map">
	<map name="Map">
		<area shape="rect" coords="419,182,659,243" href="#none" onclick="fn_goView('group01')" alt="원장">
		<area shape="rect" coords="842,274,1079,335" href="#none" onclick="fn_goView('group02')" alt="감사관">
		<area shape="rect" coords="181,427,420,489" href="#none" onclick="fn_goView('group03')" alt="기획경영본부">
		<area shape="rect" coords="2,548,239,609" href="#none" onclick="fn_goView('group05')" alt="외부자원유치단">
		<area shape="rect" coords="360,792,599,853" href="#none" onclick="fn_goView('group07')" alt="정책연구부">
		<area shape="rect" coords="360,883,599,943" href="#none" onclick="fn_goView('group08')" alt="경영기획부">
		<area shape="rect" coords="360,972,599,1033" href="#none" onclick="fn_goView('group09')" alt="경영지원부">
		<area shape="rect" coords="360,1063,599,1123" href="#none" onclick="fn_goView('group10')" alt="사업지원부">
		<area shape="rect" coords="662,427,901,489" href="#none" onclick="fn_goView('group04')" alt="사업추진본부">
		<area shape="rect" coords="841,547,1080,609" href="#none" onclick="fn_goView('group14')" alt="기업성장부">
		<area shape="rect" coords="841,637,1080,699" href="#none" onclick="fn_goView('group15')" alt="창업성장부">
		<area shape="rect" coords="840,727,1079,789" href="#none" onclick="fn_goView('group06')" alt="미래기술사업단">
		<area shape="rect" coords="841,817,1080,879" href="#none" onclick="fn_goView('group11')" alt="ICT 산업부">
		<area shape="rect" coords="841,907,1080,969" href="#none" onclick="fn_goView('group12')" alt="바이오헬스산업부">
		<area shape="rect" coords="841,997,1080,1059" href="#none" onclick="fn_goView('group13')" alt="콘텐츠산업부">
	</map>
	<img src="/resource/templete/${siteconfigVO.tempCode }/src/img/sub/img_org_m.png" alt="" usemap="#Map2">
	<map name="Map2">
		<area shape="rect" coords="0,383,240,452" href="#none" onclick="fn_goView('group01')" alt="원장">
		<area shape="rect" coords="170,510,410,579" href="#none" onclick="fn_goView('group02')" alt="감사관">
		<area shape="rect" coords="170,638,410,707" href="#none" onclick="fn_goView('group03')" alt="기획경영본부">
		<area shape="rect" coords="271,747,511,816" href="#none" onclick="fn_goView('group05')" alt="외부자원유치단">
		<area shape="rect" coords="271,839,511,908" href="#none" onclick="fn_goView('group07')" alt="정책연구부">
		<area shape="rect" coords="272,933,512,1002" href="#none" onclick="fn_goView('group08')" alt="경영기획부">
		<area shape="rect" coords="272,1025,512,1094" href="#none" onclick="fn_goView('group09')" alt="경영지원부">
		<area shape="rect" coords="272,1118,512,1187" href="#none" onclick="fn_goView('group10')" alt="사업지원부">
		<area shape="rect" coords="170,1247,410,1316" href="#none" onclick="fn_goView('group04')" alt="사업추진본부">
		<area shape="rect" coords="271,1356,511,1425" href="#none" onclick="fn_goView('group14')" alt="기업성장부">
		<area shape="rect" coords="271,1448,511,1517" href="#none" onclick="fn_goView('group15')" alt="창업성장부">
		<area shape="rect" coords="272,1542,512,1611" href="#none" onclick="fn_goView('group06')" alt="미래기술사업단">
		<area shape="rect" coords="271,1635,511,1704" href="#none" onclick="fn_goView('group11')" alt="ICT산업부">
		<area shape="rect" coords="270,1727,510,1796" href="#none" onclick="fn_goView('group12')" alt="바이오헬스산업부">
		<area shape="rect" coords="272,1821,512,1890" href="#none" onclick="fn_goView('group13')" alt="콘텐츠산업부">
	</map> --%>
</div>
 <div class="part-detailinfo">
     <div class="ora_text">
         * 상단의 부서명을 선택하시면 부서별 상세내용을 확인하실 수 있습니다.
     </div>
     <!-- 게시판리스트 -->
     <!-- board_top -->
     <div class="board_top">
<%--          <form name="listForm" id="listForm" method="get" onsubmit="fn_search(); return false;">
			<input type="hidden" name="schId" value="${searchMap.schId }" />
			<input type="hidden" name="page" value="1" />
 --%>             <fieldset>
                 <legend>게시판 검색폼</legend>
                 <div class="inner">
                     <label for="schFld" class="blind">검색조건</label>
                     <select name="schFld" id="schFld" class="select_box" title="검색어 조건선택">
                        <option value="0" ${ufn:selected(searchMap.schFld, '0') }>전체</option>
						<option value="1" ${ufn:selected(searchMap.schFld, '1') }>이름</option>
						<option value="2" ${ufn:selected(searchMap.schFld, '2') }>부서명</option>
                     </select>
                     <label for="schStr1" class="blind">검색어</label>
                     <input type="text" name="schStr1" id="schStr1" class="search_txt" title="검색어 입력" placeholder="검색어를 입력해주세요">
                     <button type="button" class="search" onclick="fn_search()"><span class="ir-text">검색</span></button>
                 </div>
             </fieldset>
		<%-- </form> --%>
     </div>
     <!-- //board_top -->
     <div class="sub_page_tit2">부서별 담당업무 및 직원정보
     </div>
     <dl class="orgn-part_info" id="orgchtDept"></dl>
     <table class="table part-info" id="orgchtMng"> </table>
</div>

<script type="text/javascript">
function fn_search() {
  	var $schStr = $("#schStr1").val();
	var $schFld = $("#schFld").val();

    $.ajax({
	       url          : "/snip/module/Introduce32_orgchtSchMng_view.do",
	       type      	: "get",
	       data			: {	"schStr" : $schStr,
  							"schFld" : $schFld
	    	   				},
	       dataType		: "html",

	       success   	: function(data) {
	    	   $("#orgchtDept").children().hide();
	    	   $("#orgchtMng").html(data);
	       }
    });

}

/* 글 조회 화면 function */
function fn_goView(id) {
	orgchtDept_view(id);
	orgchtMng_view(id);

}

var orgchtDept_view = function(id) {
	 $.ajax({
	       url          : "/snip/module/Introduce32_orgchtDept_view.do",
	       type      	: "get",
	       data			: {"schId" : id},
	       dataType		: "html",

	       success   	: function(data) {
	    	   $("#orgchtDept").html(data);

	           var y = "#orgchtDept";
	           if (!$(y).size()) {
	               return;
	           }
	           var ofset = $(y).offset().top;
	           var h = 0;
	           if (matchMedia("screen and (min-width: 1241px)").matches) {
	               h = $(".header__wrap").height();
	           } else {
	               h = $(".header__wrap").height() * 2;
	           }
	           var topy = ofset - h;
	           $(window).scrollTop(topy);
	       }
	    });

}

var orgchtMng_view = function(id) {
	 $.ajax({
	       url          : "/snip/module/Introduce32_orgchtMng_view.do",
	       type      	: "get",
	       data			: {"schId" : id},
	       dataType		: "html",

	       success   	: function(data) {
	    	   $("#orgchtMng").html(data);
	       }
	    })
}

</script>
