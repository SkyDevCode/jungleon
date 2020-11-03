package egovframework.itgcms.mngr.organization.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.core.manager.service.MngrManagerSearchVO;
import egovframework.itgcms.core.manager.service.MngrManagerService;
import egovframework.itgcms.core.manager.service.MngrManagerVO;
import egovframework.itgcms.core.menu.service.MngrMenuVO;
import egovframework.itgcms.module.organization.service.OrganizationService;
import egovframework.itgcms.module.organization.service.impl.OrganizationMapper;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명 : OrganizationController.java
 * @파일정보 : 조직도 관리 및 조회
 * @수정이력
 * @수정자 수정일 수정내용 @------- ------------ ----------------
 * @jyl 2017. 10. 16. 최초생성
 * @jimbae 2019. 10. 14. 국립중앙도서관에 맞춰 수정
 *         수정 @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
@RequestMapping("/_mngr_/module/")
public class MngrOrganizationController {

	@Resource(name = "organizationService")
	private OrganizationService organizationService;

	@Resource(name = "mngrManagerService")
	private MngrManagerService mngrManagerService;

	/** mngrCodeService */
    @Resource(name = "mngrCodeService")
    private MngrCodeService mngrCodeService;

	private static final Logger logger = LogManager.getLogger(MngrOrganizationController.class);

	/**
	 * 조직도 목록페이지
	 *
	 * @param model
	 * @param request
	 * @return String
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_list_organization.do")
	public String selectOrganization(@PathVariable String menuCode, ModelMap model, HttpServletRequest request)
			throws IOException, SQLException, RuntimeException {
		return "itgcms/mngr/organization/organization_list";
	}

	/**
	 * 조직도 부서목록 불러오기
	 *
	 * @param model
	 * @param request
	 * @return String
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_list_organization.ajax")
	public void selectOrganizationAjax(@PathVariable String menuCode, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		String json = organizationService.selectOrganizationList();

		CommUtil.printWriter(json, response);
	}

	/**
	 * 부서 및 부서원 정보 불러오기
	 *
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_view_organization.ajax")
	public String selectOrganizationView(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		model.addAttribute("orgResult", organizationService.selectOrganizationView(itgMap));
		mngrManagerService.selectOrgManager(model, itgMap);

		return "itgcms/mngr/organization/organization_view_ajax";
	}

	/**
	 * 조직도 부서 등록 페이지 불러오기
	 *
	 * @param orgMap
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_input_organization.ajax")
	public String inputOrganization(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		model.addAttribute("result", organizationService.selectOrganizationView(itgMap));
		model.addAttribute("searchMap", itgMap);
		return "itgcms/mngr/organization/organization_input_ajax";
	}

	/**
	 * 조직도 부서 등록 프로세스
	 *
	 * @param model
	 * @param request
	 * @param response
	 * @return String
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_input_organization_proc.ajax")
	public void inputOrganizationProc(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		String json = organizationService.insertOrganization(itgMap);
		CommUtil.printWriter(json, response);
	}

	/**
	 * 조직도 부서 수정 페이지 불러오기
	 *
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_edit_organization.ajax")
	public String updateOrganization(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		model.addAttribute("result", organizationService.selectOrganizationView(itgMap));
		model.addAttribute("searchMap", itgMap);
		return "itgcms/mngr/organization/organization_update_ajax";
	}

	/**
	 * 조직도 부서 수정 프로세스
	 *
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_edit_organization_proc.ajax")
	public void updateOrganizationProc(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		String json = organizationService.updateOrganization(itgMap);
		CommUtil.printWriter(json, response);
	}

	/**
	 * 조직도 부서 삭제 프로세스
	 *
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_delete_organization_proc.ajax")
	public void deleteOrganizationProc(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		String json = organizationService.deleteOrganization(itgMap);
		CommUtil.printWriter(json, response);
	}

	/**
	 * 조직도 구성원 수정 페이지 불러오기
	 *
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_edit_organization_member.ajax")
	public String updateOrganizationMember(@PathVariable String menuCode,
			MngrManagerSearchVO mngrManagerSearchVO,
			ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {

		MngrCodeVO codeVO = new MngrCodeVO();
		//codeVO.setSchCode("78"); //직위목록,0>programcd>cubecms>managercd>position
		codeVO.setSchCode("position");
		model.addAttribute("positionList", mngrCodeService.getMngrCodeList(codeVO));

		MngrManagerVO result = mngrManagerService.mngrManagerView(mngrManagerSearchVO);
		model.addAttribute("result", result);
		return "itgcms/mngr/organization/organization_member_update_ajax";
	}

	/**
	 * 조직도 구성원 수정 처리
	 *
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_edit_organization_member_proc.ajax")
	public void updateOrganizationMemberProc(@PathVariable String menuCode,
			MngrManagerSearchVO mngrManagerSearchVO,
			MngrManagerVO managerVO,
			ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {

		managerVO.setUpdmemid(CommUtil.getMngrMemId());
		mngrManagerService.updateManagerPartInfo(managerVO);
	}

	/**
	 * 조직도 코드 중복검사
	 *
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_comm_organization_duplCheck.ajax")
	public void commOrganizationDuplCheck(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		int resultCnt = organizationService.selectOrganizationDupl(itgMap);
		String json = "{\"result\" : " + resultCnt + "}";
		CommUtil.printWriter(json, response);
	}

	/**
	 * 부서 관리자 목록
	 *
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_list_organization_allManager.ajax")
	public void selectOrganizationManagerGroup(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		String json = mngrManagerService.selectOrgAllManagerList(itgMap);
		CommUtil.printWriter(json, response);
	}

	/**
	 * 부서 관리자 추가
	 *
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_input_organization_mngGroup.ajax")
	public void inputOrganizationMngGroup(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		int result = mngrManagerService.inputOrgMngGroup(itgMap);
		CommUtil.printWriter("{\"result\":\"" + result + "\"}", response);
	}

	/**
	 * 부서 관리자 제외
	 *
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_delete_organization_mngGroup.ajax")
	public void deleteOrganizationMngGroup(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		int result = mngrManagerService.deleteOrgMngGroup(itgMap);
		CommUtil.printWriter("{\"result\":\"" + result + "\"}", response);
	}

	/**
	 * 부서 위치 변경
	 * @param mngrMenuVO
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_edit_organization_updown.ajax")
	public void updateOrganizationUpDown(@PathVariable String menuCode, @ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		String result = "0";
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		result = organizationService.updateOrganizationUpDown(itgMap);
		CommUtil.printWriter("{\"result\" : " + result + "}", response);
	}

	/**
	 * 부서 관리자 순서변경
	 *
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_edit_organization_mngOrder.ajax")
	public void organizationUpdateMngorder(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, RuntimeException {
		ItgMap itgMap = CommUtil.getParameterEMap(request);
		int result = mngrManagerService.updateOrgMngGroupOrder(itgMap);
		CommUtil.printWriter("{\"result\":\"" + result + "\"}", response);
	}
}
