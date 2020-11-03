package egovframework.itgcms.module.serch.web;


import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.UserSessionVO;
import egovframework.itgcms.core.board.service.BoardSearchVO;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigVO;
import egovframework.itgcms.core.menu.service.MngrMenuService;
import egovframework.itgcms.core.menu.service.MngrMenuVO;
import egovframework.itgcms.core.site.service.MngrSiteSearchVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.module.common.service.CommonModuleService;
import egovframework.itgcms.module.serch.service.SearchService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({"/{root}/module/*"})
public class SearchController {
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;
	@Resource(name = "searchService")
	private SearchService searchService;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession session;

	/** MngrMenuService */
	@Resource(name = "mngrMenuService")
	private MngrMenuService mngrMenuService;

	@RequestMapping({"{menuCode}_kTotalSearch.do"})
	public String _kTotalSearch(@PathVariable String root, @ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO,
			ModelMap model,@RequestParam(value="schFld",defaultValue="all") String schFld, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		MngrBoardconfigVO mngrBoardconfigVO = new MngrBoardconfigVO();
		if (!CommUtil.isExistSite(root)) {
			return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
		} else {
			SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(root);
			String searchCnd = siteconfigVO.getTotalSearch();
			List<MngrSiteVO> siteList = new ArrayList();
			model.addAttribute("schFld", schFld);
			if ("all".equals(searchCnd)) {
				siteList = this.mngrSiteService.selectMngrSiteList();
			} else {
				MngrSiteSearchVO mngrSiteSearchVO = new MngrSiteSearchVO();
				mngrSiteSearchVO.setId(root);
				MngrSiteVO MngrSiteVO = this.mngrSiteService.selectSiteView(mngrSiteSearchVO);
				((List) siteList).add(MngrSiteVO);
			}

			boardSearchVO.setSchSiteList((List) siteList);
			String returnPage = "itgcms/global/module/common/totalSearch";
			return this.searchService.searchAll(model, mngrBoardconfigVO, boardSearchVO, this.request, response,
					returnPage);
		}
	}
	@RequestMapping({"{menuCode}_kTotalSearchDetail.do"})
	public String kTotalSearchDetail(@PathVariable String root, @ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO,
			ModelMap model, HttpServletResponse response,
			@RequestParam Map map) throws IOException, SQLException, RuntimeException {
		String returnPage = "itgcms/global/module/common/totalSearchDetail";
		if (!CommUtil.isExistSite(root)) {
			return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
		}
		ItgMap itgMap = new ItgMap();
		itgMap.putAll(map);
		return searchService.searchDetail(model,itgMap,boardSearchVO,returnPage);
	}

	@RequestMapping({"{menuCode}_view_kTotalSearch.do"})
	public String mngrTotalSearch(@PathVariable String root, ModelMap model, HttpServletRequest request,
			HttpSession session, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String siteCode = CommUtil.getManagerSiteCode(request);
		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		model.addAttribute("siteconfigVO", siteconfigVO);
		return "itgcms/global/module/common/mngrTotalSearch_view";
	}

}