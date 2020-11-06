package egovframework.itgcms.mngr.joinformconfig.web;

import java.io.IOException;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.joinformconfig.service.MngrJoinFormConfigSearchVO;
import egovframework.itgcms.core.joinformconfig.service.MngrJoinFormConfigService;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.module.contract.service.ContractService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;


/**
 * @파일명 : MngrMemeberConfigController.java
 * @파일정보 : 회원 설정 관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 5. 15. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
@RequestMapping("/_mngr_/module/*")
public class MngrJoinFormConfigController {

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	@Resource(name="joinFormConfigService")
	private MngrJoinFormConfigService joinFormConfigSerivce;

	@Resource(name="contractService")
	private ContractService contractService;
	@Autowired
	private HttpServletRequest request;
	private static final Logger logger = LogManager.getLogger(MngrJoinFormConfigController.class);

	/**
	 * 회원 가입 폼 설정 목록을 조회한다. (paging)
	 * @param model
	 * @return "itgcms/mngr/memeberconfig/formList"
	 * @exception Exception
	 */
	/*@RequestMapping(value = "/formList.do")
	public String mngrJoinFormConfigList(@ModelAttribute("searchVO")  MngrJoinFormConfigSearchVO  mngrJoinConfigSearchVo, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrJoinConfigSearchVo.setPageUnit(Integer.parseInt(mngrJoinConfigSearchVo.getViewCount()));//viewCount
		mngrJoinConfigSearchVo.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrJoinConfigSearchVo.getPage());
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrJoinConfigSearchVo.getPageUnit());
		paginationInfo.setPageSize(mngrJoinConfigSearchVo.getPageSize());

		mngrJoinConfigSearchVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrJoinConfigSearchVo.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrJoinConfigSearchVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<MngrJoinFormConfigSearchVO> resultList = joinFormConfigSerivce.mngrJoinFormConfigList(mngrJoinConfigSearchVo);
		int totCnt = joinFormConfigSerivce.mngrJoinFormConfigTotCnt(mngrJoinConfigSearchVo);

		model.addAttribute("resultList", resultList);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage())));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVo", mngrJoinConfigSearchVo);

		return "itgcms/mngr/joinformconfig/formList";
	}*/

	@RequestMapping(value = "/{menuCode}_view_joinFormConf.do")
	public String mngrRegisteJoinFormConfig(@ModelAttribute("searchVO")  MngrJoinFormConfigSearchVO  mngrJoinConfigSearchVo, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException{

		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		String currSiteCode = mngrSessionVO.getCurrSiteCode();
		joinFormConfigSerivce.mngrGetJoinFormBySiteCode(currSiteCode, mngrJoinConfigSearchVo);

		model.addAttribute("siteCode", currSiteCode);
		model.addAttribute("contractList", contractService.selectMngrGetContractList());
		model.addAttribute("searchVO", mngrJoinConfigSearchVo);

		return "itgcms/mngr/joinformconfig/joinFormConf_view";
	}


	/**
	 * 회원 가입 폼 설정 목록을 조회한다. (paging)
	 * @param model
	 * @return "itgcms/mngr/memeberconfig/formList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/{menuCode}_edit_joinFormConf_proc.ajax", method=RequestMethod.POST)
	@ResponseBody
	public int mngrJoinFormRegist(@ModelAttribute("searchVO")  MngrJoinFormConfigSearchVO  mngrJoinConfigSearchVo,@PathVariable String menuCode, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException {
		MngrSessionVO mngrSessionVo = CommUtil.getMngrSessionVO();
		String mngrId = mngrSessionVo.getId();
		String contractDesc=mngrJoinConfigSearchVo.getContractDesc();
		String[] contNo = contractDesc.split(",");
		String progIdx = request.getParameter("progIdx");

		EgovMap paramMap = new EgovMap();
		String cintStr=CommUtil.arrayToString(contNo);//[1,2]
		paramMap.put("contractNo", cintStr.substring(1, cintStr.length()-1));
    	paramMap.put("menuCode", menuCode);
    	paramMap.put("progIdx", progIdx);
    	paramMap.put("opt", "one");
    	int result = 0;
		if (mngrJoinConfigSearchVo.getNo()>0) {
			contractService.setMenuContractInfo(paramMap);
			result = 1;
			mngrJoinConfigSearchVo.setUpdMemId(mngrId);
			joinFormConfigSerivce.mngrModifyJoinFormConfig(mngrJoinConfigSearchVo);
		} else {
			contractService.setMenuContractInfo(paramMap);
			result = 2;
			mngrJoinConfigSearchVo.setRegMemId(mngrId);
			joinFormConfigSerivce.mngrRegistJoinFormConfig(mngrJoinConfigSearchVo);
		}
		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		siteconfigVO.setMemberRegMenuCode(menuCode);
		CommUtil.setFileObject(siteconfigVO, "siteconfig", siteCode);
		return result;
	}
}
