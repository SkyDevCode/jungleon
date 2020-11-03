package egovframework.itgcms.module.organization.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.module.organization.service.OrganizationService;
import egovframework.itgcms.module.organization.service.impl.OrganizationMapper;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @파일명 : OrganizationController.java
 * @파일정보 : 조직관리 컨트롤러
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @jyl 2017. 10. 16. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class OrganizationController {

	/** OrganizationService */
	@Resource(name = "organizationService")
	private OrganizationService organizationService;

	/** mngrCodeService */
    @Resource(name = "mngrCodeService")
    private MngrCodeService mngrCodeService;

    /** OrganizationMapper */
	@Resource(name="organizationMapper")
	private OrganizationMapper organizationMapper;

	private static final Logger logger = LogManager.getLogger(OrganizationController.class);

	/* 조직및 사무 관리자 조회(컨텐츠관리메뉴)
	@RequestMapping(value = "/_mngr_/module/mngrOrganization.do")
	public String mngrOrganization(@ModelAttribute("searchVO") DefaultVO searchVO,  ModelMap model,
			HttpServletRequest request,	HttpServletResponse response, HttpSession session, MngrCodeVO mngrCodeVO) throws IOException, SQLException, RuntimeException {
		model.addAttribute("menuCode", CommUtil.isNull(request.getParameter("menuCode"),""));

		if("view".equals(searchVO.getSchM())){
			return organizationService.mngrGetStaffView(searchVO, model, request, response);
		}else if("regist".equals(searchVO.getSchM())){
			return organizationService.mngrStaffRegist(searchVO, model, request, response);
		}else if("proc".equals(searchVO.getSchM())){

			if("REGIST".equals(searchVO.getAct())){

				return organizationService.InsertStaffProc(searchVO, model, request, response);

			}else if("UPDATE".equals(searchVO.getAct())){
				return organizationService.mngrStaffInfoUpdateProc(searchVO, model, request, response);
			}else if("CHANGE".equals(searchVO.getAct())){
				return organizationService.mngrStaffOrderChangeProc(searchVO, model, request, response);
			}else if("chkDelete".equals(searchVO.getAct())){
				return organizationService.mngrStaffChkDelProc(searchVO, model, request, response);
			}else if("excelDown".equals(searchVO.getAct())){
				return organizationService.mngrStaffListExcel(searchVO, request, model);
			}

		}

		else {
			 return organizationService.mngrGetStaffList(searchVO, model, request, response);
		}
		return organizationService.mngrGetStaffList(searchVO, model, request, response);
	}*/




	/* 조직및 사무 사용자 조회
	@RequestMapping(value = "/{root}/module/organization.do")
	public String organization(@ModelAttribute("searchVO") DefaultVO searchVO,  ModelMap model,
			HttpServletRequest request,	HttpServletResponse response, HttpSession session, MngrCodeVO mngrCodeVO) throws IOException, SQLException, RuntimeException {


		if("searchView".equals(searchVO.getSchM())){
			직원정보 검색
			return organizationService.userGetStaffList(searchVO, model, request, response);
		} else {
			조직도
			 return organizationService.userGetOrganizationInfo(searchVO, model, request, response, session);
		}
	}*/




	/* 조직도관리 설정 조회
	@RequestMapping(value = "/_mngr_/module/mngrOrganChart.do")
	public String mngrOrganChart(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {


		String returnPage = "itgcms/global/module/organization/mngrOrganChart";

		MngrCodeVO mngrCodeVO = new MngrCodeVO();
		mngrCodeVO.setId("group");
		List<MngrCodeVO> resultList = organizationService.mngrManagerCodeListRecursive(mngrCodeVO);
		List<MngrCodeVO> groupList = new ArrayList();

		for(int i=0; i < resultList.size(); i++){
		MngrCodeVO codeVO = resultList.get(i);
		groupList.add(codeVO);
			if(codeVO.getChildCodeList().size() > 0){

				List groupList2 = organizationService.recursiveGroupCode(codeVO.getChildCodeList(), model);
				groupList.addAll(groupList2);
			}
		}
		model.addAttribute("groupList", groupList);

		EgovMap organChartInfo =  organizationService.selectMngrOrganChartInfo(searchVO);
		model.addAttribute("organChartInfo", organChartInfo);


		return returnPage;
	}*/

	/* 조직도관리 설정 수정 프로세스
	@RequestMapping(value = "/_mngr_/module/mngrOrganChartUpdateProc.do")
	public String mngrOrganChartUpdateProc(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model, HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String a = null;
		EgovMap egovMap = CommUtil.getParameterEMap(request);

		int columnCnt = Integer.parseInt(request.getParameter("columnCnt"));
		if(columnCnt == 1){
			egovMap.put("columnNm2", "");
			egovMap.put("columnNm3", "");
		}else if(columnCnt == 2){
			egovMap.put("columnNm3", "");
		}

		int result = organizationService.updateMngrOrganChartInfoProc(egovMap);
		if(result <= 0) {
			result = organizationService.insertMngrOrganChartInfoProc(egovMap);
		}


    	String title = "";
    	String msg = "";
    	String script="";

		if(result == 1){title = "완료";	msg = "수정 되었습니다."; script=  "location.href='mngrOrganChart.do'";}
		else{title = "오류";msg = "수정이 완료되지 않았습니다."; script=  "location.href='mngrOrganChart.do'";}

		return CommUtil.doComplete(model,title , msg,script);


	}*/
}
