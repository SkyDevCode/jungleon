package egovframework.itgcms.module.comember.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.module.comember.service.ComemberService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * @파일명 : ComemberController.java
 * @파일정보 : 기업회원관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 9. 4. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class ComemberController {

	/** ComemberService */
	@Resource(name = "comemberService")
	private ComemberService comemberService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

    /** mngrCodeService */
    @Resource(name = "mngrCodeService")
    private MngrCodeService mngrCodeService;

	private static final Logger logger = LogManager.getLogger(ComemberController.class);

	/**
	 * 기업회원 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/comember/comember_list.do")
	public String mngrComemberList(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		String returnPage = "itgcms/global/module/comember/comember_list";
		String menuCode = request.getParameter("menuCode");
		String progIdx = request.getParameter("progIdx");


		searchVO.setPageUnit(Integer.parseInt(searchVO.getViewCount()));//viewCount
		searchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(searchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<EgovMap> resultList = comemberService.mngrGetComemberList(searchVO);


		model.addAttribute("resultList", resultList);
		int totCnt = comemberService.mngrGetComemberListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

		return returnPage;
	}

	/**
	 * 기업회원 수정/조회
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/comember/comember_edit.do")
	public String mngrComemberView(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		//String menuCode = request.getParameter("menuCode");
		//String progIdx = request.getParameter("progIdx");

		EgovMap result = comemberService.mngrGetComemberInfo(searchVO);

    	String returnPage = "itgcms/global/module/comember/comember_edit";
    	searchVO.setAct("UPDATE");

    	model.addAttribute("result", result);

		return returnPage;
	}

	/**
	 * 기업회원 등록
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/comember/comember_input.do")
	public String mngrComemberRegist(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

    	String returnPage = "itgcms/global/module/comember/comember_edit";
    	searchVO.setAct("REGIST");

    	return returnPage;
	}

	/**
	 * 기업회원 등록 프로세스
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/comember/comember_input_proc.do")
	public String mngrInsertComemberProc(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		EgovMap egovMap = CommUtil.getParameterEMap(request);
    	egovMap.put("logMemid", CommUtil.getMngrMemId());
    	egovMap.put("comemStatus", "0");

    	String title = "";
    	String msg = "";
    	String script="";

    	if("Y".equals(egovMap.get("namePass")) && "Y".equals(egovMap.get("comNoPass")))
    	{
    		int result = comemberService.mngrInsertComemberProc(egovMap);
    		if(result == 1){title = "완료";	msg = "등록 되었습니다."; script=  "location.href='comember_list.do'";}
    		else{title = "오류";msg = "등록이 완료되지 않았습니다."; script=  "location.href='comember_list.do'";}
		}else{
    		title = "오류";	msg = "등록 정보에 문제가 발견되었습니다. 다시 입력해 주세요."; script=  "history.back();";
		}
		return CommUtil.doComplete(model,title , msg,script);
	}

	/**
	 * 기업회원 수정 프로세스
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/comember/comember_edit_proc.do")
	public ModelAndView mngrUpdateComemberProc(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		HashMap<String,Object> returnMap = new HashMap<String,Object>();

		EgovMap egovMap = CommUtil.getParameterEMap(request);
    	egovMap.put("logMemid", CommUtil.getMngrMemId());

    	int result = comemberService.mngrUpdateComemberProc(egovMap);


		returnMap.put("resultCode", result);
		returnMap.put("resultMsg", "정상적으로 처리되었습니다.");

    	return new ModelAndView("jsonView", returnMap);
	}

	/**
	 * 기업회원 탈퇴 프로세스
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/comember/comember_delete_proc.do")
	public String mngrDropComemberProc(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		EgovMap egovMap = new EgovMap();
    	egovMap.put("logMemid", CommUtil.getMngrMemId());
    	egovMap.put("schId", searchVO.getSchId());
    	egovMap.put("comemStatus", "com_status_2");

    	int result = comemberService.mngrUpdateComemberProc(egovMap);

    	if(result > 0){return CommUtil.doCompleteUrl(model,"완료" , "정상적으로 처리되었습니다.", "/_mngr_/comember/comember_edit.do");}
		else{return CommUtil.doComplete(model,"오류" , "탈퇴가 처리되지 않았습니다.","history.back();");}
	}

	/**
	 * 기업회원 선택 삭제 프로세스
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/comember/comember_delete_chkProc.do")
	public String mngrChkDelComemberProc(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

    	searchVO.setLogMemid(CommUtil.getMngrMemId());
    	comemberService.mngrChkDelComemberProc(searchVO);

		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='comember_list.do'");
	}

	/**
	 * 기업회원 선택 승인 프로세스
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/comember/comember_edit_chkConfirm.do")
	public String mngrChkConfirmComemberProc(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		searchVO.setLogMemid(CommUtil.getMngrMemId());
		comemberService.mngrChkConfirmComemberProc(searchVO);

		return CommUtil.doCompleteUrl(model, "완료", "승인 되었습니다.", "comember_list.do");
	}

	/**
	 * 기업회원 목록을 엑셀 다운로드 한다.
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="/_mngr_/excel/mngrComemberListExcel.do")
	public ModelAndView mngrComemberListExcel(@ModelAttribute("searchVO") DefaultVO searchVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);

    	searchVO.setExcelDown("excel");
    	searchVO.setSchOpt1("");
    	List<EgovMap> resultList = comemberService.mngrGetComemberList(searchVO);

    	HashMap paramMap = new HashMap();

		paramMap.put("dataList", resultList);

		//엑셀 템플릿에 넘겨줄 데이타
		mav.addObject("data", paramMap);

		//다운로드에 사용되어질 엑셀파일 템플릿
		mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, CommUtil.getExcelTemplateName(request, "mngr"));
		//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
		mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "기업회원 리스트-" + CommUtil.getDatePattern("yyyy-MM-dd"));

		return mav;
	}

	/**
	 * ===================
	 * 여기서 부터 사용자/관리자 공통 페이지
	 * ===================
	 */
	/**
	 * 기업회원 사업자번호 조회 프로세스
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/{root}/module/mngrComemberComnoChkAjax.do")
	public ModelAndView mngrComemberComnoChkAjax(@PathVariable String root, @ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		HashMap<String,Object> returnMap = new HashMap<String,Object>();
		String resultCode = "";
		/*EgovMap egovMap = CommUtil.getParameterEMap(request,"comemComno");
    	egovMap.put("logMemid", CommUtil.getMngrMemId());*/
		searchVO.setSchOpt1("ComnoChkAjax");
    	int result = comemberService.mngrComemberComnoChkAjax(searchVO);

		returnMap.put("resultCode", result);

    	return new ModelAndView("jsonView", returnMap);
	}

	/**
	 * 기업회원 기업명 조회 프로세스
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/{root}/module/mngrComemberConameChkAjax.do")
	public ModelAndView mngrComemberConameChkAjax(@PathVariable String root, @ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		HashMap<String,Object> returnMap = new HashMap<String,Object>();

		searchVO.setSchOpt1("ConameChkAjax");
		int result = comemberService.mngrComemberConameChkAjax(searchVO);

		returnMap.put("resultCode", result);

		return new ModelAndView("jsonView", returnMap);
	}

	@RequestMapping(value="/{root}/module/findCompany.do")
	@ResponseBody
	public EgovMap findComemberListAjax(@RequestParam(value="searchStr") String searchStr) throws IOException, SQLException, RuntimeException {

		DefaultVO searchVO = new DefaultVO();
		EgovMap resultMap = new EgovMap();

		searchVO.setExcelDown("excel");
		searchVO.setSchFld("3");
		searchVO.setSchStr(searchStr);

		List<EgovMap> comList = comemberService.mngrGetComemberList(searchVO);

		resultMap.put("comList", comList);
		resultMap.put("size", comList.size());

		return resultMap;
	}

	/**
	 * 기업회원 사업자번호 조회 프로세스
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/{root}/module/comemberComnoChkAjax.do")
	public ModelAndView comemberComnoChkAjax(@PathVariable String root, @ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		HashMap<String,Object> returnMap = new HashMap<String,Object>();
		String resultCode = "";
		/*EgovMap egovMap = CommUtil.getParameterEMap(request,"comemComno");
    	egovMap.put("logMemid", CommUtil.getMngrMemId());*/
		searchVO.setSchOpt1("ComnoChkAjax");
    	int result = comemberService.mngrComemberComnoChkAjax(searchVO);

		returnMap.put("resultCode", result);

    	return new ModelAndView("jsonView", returnMap);
	}

	/**
	 * 기업회원 기업명 조회 프로세스
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/{root}/module/comemberConameChkAjax.do")
	public ModelAndView comemberConameChkAjax(@PathVariable String root, @ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		HashMap<String,Object> returnMap = new HashMap<String,Object>();

		searchVO.setSchOpt1("ConameChkAjax");
		int result = comemberService.mngrComemberConameChkAjax(searchVO);

		returnMap.put("resultCode", result);

		return new ModelAndView("jsonView", returnMap);
	}

	@RequestMapping(value = "/{root}/module/insertComemberProc.do")
	public String insertComemberProc(@PathVariable String root, @ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		EgovMap egovMap = CommUtil.getParameterEMap(request);
    	/*egovMap.put("logMemid", CommUtil.getMngrMemId());*/
    	egovMap.put("comemStatus", "0");

    	String title = "";
    	String msg = "";
    	String script="";

    	model.addAttribute("stp", "complete");
    	model.addAttribute("type", "comem");

    	if("Y".equals(egovMap.get("namePass")) && "Y".equals(egovMap.get("comNoPass"))) {

    		int result = comemberService.mngrInsertComemberProc(egovMap);

    		if(result == 1){
    			return "redirect:/"+root+"/contents/"+root+"MemberRegist.do";
    		} else {
    			title = "오류";
    			msg = "등록이 완료되지 않았습니다.";
    			script= "history.back();";
    		}

		}else{
    		title = "오류";
    		msg = "등록 정보에 문제가 발견되었습니다. 다시 입력해 주세요.";
    		script= "history.back();";
		}

		 return CommUtil.doComplete(model,title , msg,script);
	}

}
