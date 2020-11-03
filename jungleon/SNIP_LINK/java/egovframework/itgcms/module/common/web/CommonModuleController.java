package egovframework.itgcms.module.common.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.itgcms.core.board.service.BoardSearchVO;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigVO;
import egovframework.itgcms.core.site.service.MngrSiteSearchVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.module.common.service.CommonModuleService;
import egovframework.itgcms.util.CommUtil;


/**
 * @파일명 : CommonModuleController.java
 * @파일정보 : 시스템기본모듈
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2019. 4. 11. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
@RequestMapping(value = "/{root}/module/*")
public class CommonModuleController {

	private final Logger LOGGER = LogManager.getLogger(this.getClass());

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	/** BoardService */
	@Resource(name = "commonModuleService")
	private CommonModuleService commonModuleService;

	@Autowired
	private HttpServletRequest request;

	@Autowired
	private HttpSession session;

	/**
	 * 사이트맵
	 * @param root
	 * @param model
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	/*사용자*/
	@RequestMapping(value = "{menuCode}_sitemap.do")
	public String mainSitemap(@PathVariable String root, ModelMap model, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		if(!CommUtil.isExistSite(root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		return "itgcms/global/module/common/siteMap";
	}

	/*관리자*/
	@RequestMapping(value = "{menuCode}_view_mngrSitemap.do")
	public String mngrSitemap(@PathVariable String root, ModelMap model, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		String siteCode = CommUtil.getManagerSiteCode(request);
		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		model.addAttribute("sitemapMenuCode", siteconfigVO.getSitemapMenuCode());

		return "itgcms/global/module/common/mngrSitemap_view";
	}

	/*관리자*/
	@RequestMapping(value = "{menuCode}_edit_mngrSitemap_proc.ajax", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> mngrSitemapEditProc (
			@PathVariable("menuCode") String menuCode, HttpServletRequest request) {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);

		Map<String, String> result = new HashMap<>();
		result.put("status", "error_Start");
		result.put("msg", "알 수 없는 오류가 발생하였습니다. \n창을 새로고침한 후 다시 시도하십시오.");

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		siteconfigVO.setSitemapMenuCode(menuCode);
		result.put("status", "success");
		result.put("msg", "성공적으로 수정하였습니다.");
		CommUtil.setFileObject(siteconfigVO, "siteconfig", siteCode);

		return result;
	}

	/**
	 * 통합검색
	 * @param root
	 * @param boardSearchVO
	 * @param boardMap
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	/*사용자*/
	@RequestMapping(value = "{menuCode}_totalSearch.do")
	public String totalSearch(@PathVariable String root,
								@ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO,
								ModelMap model,
								HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		MngrBoardconfigVO mngrBoardconfigVO = new MngrBoardconfigVO();

		if(!CommUtil.isExistSite(root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(root);
    	String searchCnd = siteconfigVO.getTotalSearch(); //통합검색 옵션, 0:미사용, all:전체검색, onlyMe:해당사이트만검색

    	List<MngrSiteVO> siteList = new ArrayList();
    	if("all".equals(searchCnd)){
    		siteList = mngrSiteService.selectMngrSiteList();
    	}else{
    		MngrSiteSearchVO mngrSiteSearchVO = new MngrSiteSearchVO();
    		mngrSiteSearchVO.setId(root);
    		MngrSiteVO MngrSiteVO = mngrSiteService.selectSiteView(mngrSiteSearchVO);
    		siteList.add(MngrSiteVO);
    	}
    	boardSearchVO.setSchSiteList(siteList);

    	String returnPage = "itgcms/global/module/common/totalSearch";

		return commonModuleService.searchAll(model, mngrBoardconfigVO, boardSearchVO, request, response, returnPage);
	}

	/*관리자*/
	@RequestMapping(value = "{menuCode}_view_totalSearch.do")
	public String mngrTotalSearch(@PathVariable String root, ModelMap model, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		String siteCode = CommUtil.getManagerSiteCode(request);
		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		model.addAttribute("siteconfigVO", siteconfigVO);

		return "itgcms/global/module/common/mngrTotalSearch_view";
	}

	/*관리자*/
	@RequestMapping(value = "{menuCode}_edit_mngrTotalSearch_proc.ajax", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> mngrTotalSearchEditProc (
			@PathVariable("menuCode") String menuCode) {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);
		String totalSearch = request.getParameter("totalSearch");

		Map<String, String> result = new HashMap<>();
		result.put("status", "error_Start");
		result.put("msg", "알 수 없는 오류가 발생하였습니다. \n창을 새로고침한 후 다시 시도하십시오.");

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		siteconfigVO.setTotalSearchMenuCode(menuCode);
		siteconfigVO.setTotalSearch(totalSearch);
		CommUtil.setFileObject(siteconfigVO, "siteconfig", siteCode);
		result.put("status", "success");
		result.put("msg", "성공적으로 수정하였습니다.");

		return result;
	}
	
	/*관리자*/
	@RequestMapping(value = "{menuCode}_view_mngrFindIdPwd.do")
	public String mngrFindIdPwd(@PathVariable String root, ModelMap model, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		String siteCode = CommUtil.getManagerSiteCode(request);
		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		model.addAttribute("findIdPwdMenuCode", siteconfigVO.getFindIdPwdMenuCode());

		return "itgcms/global/module/common/mngrFindIdPwd_view";
	}
	
	/*관리자*/
	@RequestMapping(value = "{menuCode}_edit_mngrFindIdPwd_proc.ajax", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> mngrFindIdPwdProc (
			@PathVariable("menuCode") String menuCode, HttpServletRequest request) {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);

		Map<String, String> result = new HashMap<>();
		result.put("status", "error_Start");
		result.put("msg", "알 수 없는 오류가 발생하였습니다. \n창을 새로고침한 후 다시 시도하십시오.");

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		siteconfigVO.setFindIdPwdMenuCode(menuCode);
		result.put("status", "success");
		result.put("msg", "성공적으로 수정하였습니다.");
		CommUtil.setFileObject(siteconfigVO, "siteconfig", siteCode);

		return result;
	}
	
	/*관리자*/
	@RequestMapping(value = "{menuCode}_view_mngrPassChange.do")
	public String mngrPassChange(@PathVariable String root, ModelMap model, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		String siteCode = CommUtil.getManagerSiteCode(request);
		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		model.addAttribute("passChangeMenuCode", siteconfigVO.getPassChangeMenuCode());

		return "itgcms/global/module/common/mngrPassChange_view";
	}
	
	/*관리자*/
	@RequestMapping(value = "{menuCode}_edit_mngrPassChange_proc.ajax", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> mngrPassChangeProc (
			@PathVariable("menuCode") String menuCode, HttpServletRequest request) {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);

		Map<String, String> result = new HashMap<>();
		result.put("status", "error_Start");
		result.put("msg", "알 수 없는 오류가 발생하였습니다. \n창을 새로고침한 후 다시 시도하십시오.");

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		siteconfigVO.setPassChangeMenuCode(menuCode);
		result.put("status", "success");
		result.put("msg", "성공적으로 수정하였습니다.");
		CommUtil.setFileObject(siteconfigVO, "siteconfig", siteCode);

		return result;
	}
}
