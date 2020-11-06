<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<%
/**
 * @파일명 : userApplyConsultView.jsp
 * @파일정보 : 방산정책연구센터 > 자문단소개 > 자문신청 조회
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2020. 04. 02. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
%>
<div class="content-title">중점추진방향</div>
                <div class="img-wrap mt30">
                    <img src="/resource/templete/cms1/src/img/sub/vision01.png" alt="'성남산업진흥원을 통해 부패방지 및 깨끗한 공직풍토 조성을 위하여 다음과 같이 클린 신고센터를 운영합니다.' 운영목적 : 진흥원 임직원의 부패 행위에 대한 의견수렴 공간을 마련하여 고객의 애로 및 고충사항을 해결하고 진흥원 임직원의 청렴도를 강화하기 위함입니다. / 공익부패행위 신고 : 부패행위란 공직자 등이 지위 또는 권한을 남용하거나 법령을 위반하여 자기 또는 제3자의 이익을 도모하는 행위 등을 말합니다. / 갑질신고센터 : 공직자 갑질행위란 계약 상대방, 인허가 신청자 등을 상대함에 있어 권한을 남용하거나, 직위를 남용하여 부당한 지시 또는 사적 심부름·편의제공 등 사적 노무 제공을 요구하는 행위 등을 말합니다." class="n_mobile">
                    <img src="/resource/templete/cms1/src/img/sub/vision01_m.png" alt="'성남산업진흥원을 통해 부패방지 및 깨끗한 공직풍토 조성을 위하여 다음과 같이 클린 신고센터를 운영합니다.' 운영목적 : 진흥원 임직원의 부패 행위에 대한 의견수렴 공간을 마련하여 고객의 애로 및 고충사항을 해결하고 진흥원 임직원의 청렴도를 강화하기 위함입니다. / 공익부패행위 신고 : 부패행위란 공직자 등이 지위 또는 권한을 남용하거나 법령을 위반하여 자기 또는 제3자의 이익을 도모하는 행위 등을 말합니다. / 갑질신고센터 : 공직자 갑질행위란 계약 상대방, 인허가 신청자 등을 상대함에 있어 권한을 남용하거나, 직위를 남용하여 부당한 지시 또는 사적 심부름·편의제공 등 사적 노무 제공을 요구하는 행위 등을 말합니다." class="v_mobile clean_img_1">
                </div>

                <div class="content-title">신고절차</div>
                <div class="img-wrap mt30">
                    <img src="/resource/templete/cms1/src/img/sub/clean02.png" alt="1. 신고(신고인) : 작성 후 등록 2. 접수처리 : 접수 후 담당부서 확인 3. 회신 : 신고인에게 처리결과 알림" class="n_mobile">
                    <img src="/resource/templete/cms1/src/img/sub/clean02_m.png" alt="1. 신고(신고인) : 작성 후 등록 2. 접수처리 : 접수 후 담당부서 확인 3. 회신 : 신고인에게 처리결과 알림" class="v_mobile clean_img_2">
                </div>

                <div class="gray-box type2 samll-check_list mt30">
                    <div class="title">
                        담당자 연락처
                    </div>
                    <div class="content">
                        <ul class="list-dot type2">
                            <li>원장 : Tel. 031-782-3001</li>
                            <li>윤리경영담당관 : 감사관 전형조 Tel. 031-782-3006</li>
                            <li>윤리경영담당자 : 선임 백관열 Tel. 031-782-3021</li>
                        </ul>
                    </div>
                </div>
 <div class="btn-wrap text-c">
                    <a href="javascript:chkInfo();" class="btn btn-blue btn-link" title="새창 열림">신고하기</a>
                </div>
	<style>
#hidden
{
width:1px;
height:1px;
border:0;
}
</style>
<c:if test="${not empty userSessionVO}">
		<iframe id="hidden" title="내용 없음" name="hiddenifr" src="https://www.snip.or.kr/iframe.jsp">
</iframe>
</c:if>
<script type="text/javascript">
var pop = null;
function chkInfo() {
	if ('${status}'=='YES') {
		var child = "new_win";
		var wd = 800;
		var he = 660;

		// 듀얼 모니터 기준
		var le = (screen.availWidth - wd) / 2;
		if( window.screenLeft < 0){
		le += window.screen.width*-1;
		}
		else if ( window.screenLeft > window.screen.width ){
		le += window.screen.width;
		}

		var tp = (screen.availHeight - he) / 2 - 10;

		var url="https://www.snip.or.kr/iframe3.jsp";

		var option = "resizable=no, scrollbars=1, status=no, location=no, derectories=no, width="+wd+", height=" + he + ", left="+le+", top="+tp +", screenX="+le ;
		if(pop){
			if(pop.closed){
				pop = window.open(url, child, option);
			}else{
				if(url == pop.location){
					pop.focus();
					return;
				}else{
					pop.close();
					pop = window.open(url, child, option);
				}
			}
		}else{
			pop = window.open(url, child, option);
		}
		child = pop;
	}else if ('${status}'=='NO1') {
		alert('${msg}');
		location.href='https://www.snip.or.kr/SNIP/contents/snipLogin.do';
	}else{
		alert('${msg}');
	}
			}

</script>