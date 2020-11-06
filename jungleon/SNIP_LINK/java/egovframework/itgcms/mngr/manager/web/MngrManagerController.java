package egovframework.itgcms.mngr.manager.web;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.core.manager.service.MngrManagerLoginLogSearchVO;
import egovframework.itgcms.core.manager.service.MngrManagerLoginLogVO;
import egovframework.itgcms.core.manager.service.MngrManagerSearchVO;
import egovframework.itgcms.core.manager.service.MngrManagerService;
import egovframework.itgcms.core.manager.service.MngrManagerVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * @파일명 : MngrManagerController.java
 * @파일정보 : 관리자 등록 관리
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
public class MngrManagerController {

	/** MngrManagerService */
	@Resource(name = "mngrManagerService")
	private MngrManagerService mngrManagerService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** mngrCodeService */
    @Resource(name = "mngrCodeService")
    private MngrCodeService mngrCodeService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;


	private static final Logger logger = LogManager.getLogger(MngrManagerController.class);

	/**
	 * 글 목록을 조회한다. (paging)
	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 PopopSearchVO
	 * @param model
	 * @return "itgcms/mngr/manager/_mngr_managerList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/manager/manager_list.do")
	public String mngrManagerList(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrManagerSearchVO.setPageUnit(Integer.parseInt(mngrManagerSearchVO.getViewCount()));//viewCount
		mngrManagerSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrManagerSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrManagerSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrManagerSearchVO.getPageSize());

		mngrManagerSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrManagerSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrManagerSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> resultList = mngrManagerService.selectMngrManagerList(mngrManagerSearchVO);
		model.addAttribute("resultList", resultList);
		int totCnt = mngrManagerService.mngrManagerListTotCnt(mngrManagerSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
		return "itgcms/mngr/manager/manager_list";
	}

	@RequestMapping(value = "/_mngr_/manager/manager_input.do")
	public String mngrManagerRegist(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException {
		mngrManagerSearchVO.setAct("REGIST");
		mngrManagerSearchVO.setIsMyInfo("N");
		MngrManagerVO managerVO = new MngrManagerVO();
		model.addAttribute("result", managerVO);
		MngrCodeVO codeVO = new MngrCodeVO();
		codeVO.setSchCode("group"); //부서목록
		model.addAttribute("groupList", mngrCodeService.getMngrCodeList(codeVO));
		codeVO.setSchCode("position"); //직위목록
		model.addAttribute("positionList", mngrCodeService.getMngrCodeList(codeVO));
		codeVO.setSchCode("mngrAuth"); //관리자등급목록
		codeVO.setCauth("99");
		List<MngrCodeVO> mngrAuthList = mngrCodeService.getMngrCodeList(codeVO);
		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		for(int i=0; i < mngrAuthList.size(); i++){
			MngrCodeVO authCodeVO = mngrAuthList.get(i);
			if(Integer.parseInt(authCodeVO.getEtc1()) > Integer.parseInt(mngrSessionVO.getMngAuth())){
			mngrAuthList.remove(i);
			}
		}

		model.addAttribute("mngrAuthList", mngrAuthList);
		model.addAttribute("searchVO", mngrManagerSearchVO);
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());

		return "itgcms/mngr/manager/manager_edit";
	}

	@RequestMapping(value = "/_mngr_/manager/manager_comm_checkId.ajax")
	public void mngrManagerCheckId(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String result = "0";
		String message = "알수없는 오류가 발생했습니다. 다시 시도해 주세요.";
		if(!"".equals(CommUtil.isNull(mngrManagerSearchVO.getId(), ""))){
			int resultCount = mngrManagerService.mngrManagerCheckId(mngrManagerSearchVO);

			if(resultCount > 0 ){
				result = "2";
				message = "중복된 아이디 입니다.";
			}else{
				result = "1";
				message = "사용 가능한 아이디 입니다.";
			}
		}
		String json = "{\"result\" : "+result+", \"message\" : \""+message+"\"}";
		CommUtil.printWriter(json, response);
	}

	@RequestMapping(value = "/_mngr_/manager/manager_edit.do")
	public String mngrManagerView(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException {
		mngrManagerSearchVO.setAct("UPDATE");
		if(mngrManagerSearchVO.getIsMyInfo()==""){
			mngrManagerSearchVO.setIsMyInfo("Y");
		}
		MngrCodeVO codeVO = new MngrCodeVO();
		codeVO.setSchCode("group"); //부서목록
		model.addAttribute("groupList", mngrCodeService.getMngrCodeList(codeVO));
		codeVO.setSchCode("position"); //직위목록
		model.addAttribute("positionList", mngrCodeService.getMngrCodeList(codeVO));
		codeVO.setSchCode("mngrAuth"); //관리자등급목록
		codeVO.setCauth("99");
		List<MngrCodeVO> mngrAuthList = mngrCodeService.getMngrCodeList(codeVO);
		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		for(int i=0; i < mngrAuthList.size(); i++){
			MngrCodeVO authCodeVO = mngrAuthList.get(i);
			if(Integer.parseInt(authCodeVO.getEtc1()) > Integer.parseInt(mngrSessionVO.getMngAuth())){
			mngrAuthList.remove(i);
			}
		}

		MngrManagerVO result = mngrManagerService.mngrManagerView(mngrManagerSearchVO);
		List<MngrSiteVO> siteList = mngrSiteService.selectMngrSiteList();

		//담당 사이트
		List<EgovMap> eMapList = new ArrayList<EgovMap>();

		//담당사이트 체크해서 리스트로 담기.
		for (int i = 0; i < siteList.size(); i++) {
			EgovMap eMap = new EgovMap();
			if(CommUtil.strInArrChk(result.getSiteCode(), siteList.get(i).getSiteCode())){
				eMap.put("siteCode", siteList.get(i).getSiteCode());
				eMap.put("siteName", siteList.get(i).getSiteName());
				eMapList.add(eMap);
			}
		}

		model.addAttribute("mngrAuthList", mngrAuthList);
		model.addAttribute("result", result);
		model.addAttribute("searchVO", mngrManagerSearchVO);
		model.addAttribute("siteList", siteList);
		model.addAttribute("mngSiteList", eMapList);

		return "itgcms/mngr/manager/manager_edit";
	}

	@RequestMapping(value = "/_mngr_/manager/manager_input_proc.do")
	public String insertMngrManagerProc(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, ModelMap model, MngrManagerVO managerVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException {

		//입력 값 유효 체크
		// 아이디, 이름, 비밀번호, 비밀번호확인, 이메일, 부서
		if("".equals( CommUtil.isNull(  managerVO.getMngId()  , "")	)) return CommUtil.doComplete(model, "오류", "아이디를  입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  managerVO.getMngPass()  , "")	)) return CommUtil.doComplete(model, "오류", "비밀번호를  입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  managerVO.getMngPass2()  , "")	)) return CommUtil.doComplete(model, "오류", "비밀번호 확인을  입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  managerVO.getMngEmail()  , "")	)) return CommUtil.doComplete(model, "오류", "이메일주소를  입력 해 주세요.", "history.back();");
		//if("".equals( CommUtil.isNull(  managerVO.getGroupCode()  , "")	)) return CommUtil.doComplete(model, "오류", "부서를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  managerVO.getMngWork()  , "")	)) return CommUtil.doComplete(model, "오류", "담당업무를  입력 해 주세요.", "history.back();");

		// 메뉴권한이 0(직접선택)인 경우 메뉴선택한 갯수 확인
		if("0".equals(CommUtil.isNull( managerVO.getMngRole(), "" )) && "".equals( CommUtil.isNull( managerVO.getMenuCodes(), "" ) )) return CommUtil.doComplete(model, "오류", "메뉴권한의 메뉴를 선택 해 주세요.", "history.back();");

		//아이디 첫글자 영문 체크
    	if(!CommUtil.regEx("^[a-zA-Z]", managerVO.getMngId())) return CommUtil.doComplete(model, "오류", "아이디 첫글자는 영문자로 입력 해 주세요.", "history.back();");
    	if(CommUtil.regEx("[^a-zA-Z0-9_]", managerVO.getMngId())) return CommUtil.doComplete(model, "오류", "아이디는 영문, 숫자, _ 만 입력 가능합니다.", "history.back();");
    	if(managerVO.getMngId().length() < 4 || managerVO.getMngId().length() > 12) return CommUtil.doComplete(model, "오류", "아이디는 4 ~ 12자 이내로 입력 해 주세요.", "history.back();");

    	//아이디 중복 검사
    	mngrManagerSearchVO.setId(managerVO.getMngId());
    	int resultCount = mngrManagerService.mngrManagerCheckId(mngrManagerSearchVO);

		if(resultCount > 0) return CommUtil.doComplete(model, "오류", "중복된 아이디 입니다. 확인 후 다시 시도하세요." , "history.back();");

    	//비밀번호 체크
		if(!managerVO.getMngPass().equals(managerVO.getMngPass2()))  return CommUtil.doComplete(model, "오류", "비밀번호와 비밀번호 확인이 일치하지 않습니다.", "history.back();");
		String spStr = "[*+$|?()_{}\\^\\[\\]!#%&@`:;\\-=.<>,~'\"\\\\|]";
    	if(!(CommUtil.regEx("[0-9]", managerVO.getMngPass()) && CommUtil.regEx("[a-zA-Z]", managerVO.getMngPass2()) &&CommUtil.regEx(spStr, managerVO.getMngPass()) && managerVO.getMngPass2().length() >=9))  return CommUtil.doComplete(model, "오류", "비밀번호는 영문, 숫자, 특수문자 조합으로 9자 이상 입력 해 주세요.", "history.back();");

    	//이메일 형식
    	if(!CommUtil.isEmail( managerVO.getMngEmail()))  return CommUtil.doComplete(model, "오류", "올바른 이메일 형식이 아닙니다. 확인 후 다시 시도해주세요.", "history.back();");

    	//비밀번호 암호화
    	//managerVO.setMngPass(CommUtil.getPass(managerVO.getMngPass()));
    	managerVO.setMngPass(CommUtil.hexSha256(managerVO.getMngPass()));

    	managerVO.setRegmemid(CommUtil.getMngrMemId());
    	mngrManagerService.insertMngrManagerProc(managerVO);

		return CommUtil.doComplete(model, "완료", "등록 되었습니다.", "location.href='manager_list.do?"+mngrManagerSearchVO.getQuery()+"'");
	}

	@RequestMapping(value = "/_mngr_/manager/manager_edit_proc.do")
	public String mngrManagerUpdateProc(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, ModelMap model, MngrManagerVO managerVO) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException {

		//입력 값 유효 체크
		// 이메일, 부서
		if("".equals( CommUtil.isNull(  managerVO.getMngEmail()  , "")	)) return CommUtil.doComplete(model, "오류", "이메일주소를  입력 해 주세요.", "history.back();");
//		if("".equals( CommUtil.isNull(  managerVO.getGroupCode()  , "")	)) return CommUtil.doComplete(model, "오류", "부서를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  managerVO.getMngWork()  , "")	)) return CommUtil.doComplete(model, "오류", "담당업무를  입력 해 주세요.", "history.back();");

		//컨텐츠권한이 0(직접선택)인 경우 메뉴선택한 갯수 확인
		if ("N".equals(mngrManagerSearchVO.getIsMyInfo())) {
			if("0".equals(CommUtil.isNull( managerVO.getMngRole(), "" )) && "".equals( CommUtil.isNull( managerVO.getMenuCodes(), "" ) )) return CommUtil.doComplete(model, "오류", "컨텐츠권한의 메뉴를 선택 해 주세요.", "history.back();");
		}

		//비밀번호 체크
		if(!"".equals( managerVO.getMngPass())){
			if(!managerVO.getMngPass().equals(managerVO.getMngPass2()))  return CommUtil.doComplete(model, "오류", "비밀번호와 비밀번호 확인이 일치하지 않습니다.", "history.back();");
			String spStr = "[*+$|?()_{}\\^\\[\\]!#%&@`:;\\-=.<>,~'\"\\\\|]";
	    	if(!(CommUtil.regEx("[0-9]", managerVO.getMngPass()) && CommUtil.regEx("[a-zA-Z]", managerVO.getMngPass2()) &&CommUtil.regEx(spStr, managerVO.getMngPass()) && managerVO.getMngPass2().length() >=9))  return CommUtil.doComplete(model, "오류", "비밀번호는 영문, 숫자, 특수문자 조합으로 9자 이상 입력 해 주세요.", "history.back();");

	    	//비밀번호 암호화
	    	//managerVO.setMngPass(CommUtil.getPass(managerVO.getMngPass()));
	    	managerVO.setMngPass(CommUtil.hexSha256(managerVO.getMngPass()));
		}
		managerVO.setUpdmemid(CommUtil.getMngrMemId());

		mngrManagerService.updateMngrManagerUpdateProc(managerVO);

		return CommUtil.doComplete(model, "완료", "수정 되었습니다.", "location.href='manager_edit.do?"+mngrManagerSearchVO.getQuery()+"'");
	}

	@RequestMapping(value = "/_mngr_/manager/manager_delete_proc.do")
	public String deleteMngrManagerProc(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, ModelMap model, MngrManagerVO managerVO) throws IOException, SQLException, RuntimeException {
		managerVO.setDelmemid(CommUtil.getMngrMemId());
		mngrManagerService.deleteMngrManagerProc(managerVO);
		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='manager_list.do?"+mngrManagerSearchVO.getQuery()+"'");

	}

	@RequestMapping(value = "/_mngr_/manager/manager_delete_chkProc.do")
	public String deleteMngrManagerChkProc(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, ModelMap model, MngrManagerVO managerVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException {
		managerVO.setDelmemid(CommUtil.getMngrMemId());
		mngrManagerService.deleteMngrManagerChkProc(managerVO);
		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='manager_list.do?"+mngrManagerSearchVO.getQuery()+"'");
	}

	@RequestMapping(value = "/_mngr_/manager/manager_edit_pass.do")
	public String mngrManagerInitPass(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, ModelMap model, MngrManagerVO managerVO) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException {
		managerVO.setUpdmemid(CommUtil.getMngrMemId());
		managerVO.setMngPass(CommUtil.hexSha256(managerVO.getId()));
		mngrManagerService.mngrManagerInitPass(managerVO);
		return CommUtil.doComplete(model, "완료", "비밀번호가 초기화 되었습니다.", "location.href='manager_edit.do?"+mngrManagerSearchVO.getQuery()+"'");

	}

	@RequestMapping(value = "/_mngr_/manager/manager_list.ajax")
	public void mngrManagerListAjax(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		mngrManagerSearchVO.setPageUnit(10);//viewCount
		mngrManagerSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrManagerSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrManagerSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrManagerSearchVO.getPageSize());

		mngrManagerSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrManagerSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrManagerSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> result = mngrManagerService.mMngrManagerList(mngrManagerSearchVO);
		int totCnt = mngrManagerService.mngrManagerListTotCnt(mngrManagerSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);

		String json = "{\"total\":\""+paginationInfo.getTotalRecordCount()+"\",\"currentPage\":\""+paginationInfo.getCurrentPageNo()+"\", \"totalPage\":\""+paginationInfo.getTotalPageCount()+"\",\"result\":  [";
		for(int i = 0; i < result.size(); i++){
			MngrManagerVO manager = (MngrManagerVO)result.get(i);
			json += String.format("{\"mngId\":\"%s\",\"mngName\":\"%s\",\"groupCodeName\":\"%s\",\"mngRole\":\"%s\",\"mngRoleName\":\"%s\",\"mngPower\":\"%s\",\"mngPowerName\":\"%s\"}",
								manager.getMngId(),
								manager.getMngName(),
								manager.getGroupCodeName(),
								manager.getMngRole(),
								manager.getMngRoleName(),
								manager.getMngPower(),
								manager.getMngPowerName()
								);
			if(i < result.size() - 1){
				json += ",";
			}

		}
		json += "]}";
		CommUtil.printWriter(json, response);
	}

	@RequestMapping(value = "/_mngr_/manager/mngrManagerAuthListAjax.do")
	public ModelAndView mngrManagerAuthListAjax(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String mngRole = CommUtil.isNull(request.getParameter("mngRole"), "");
		List<?> result = mngrManagerService.mngrManagerAuthListAjax(mngRole);
		HashMap hm = new HashMap();
		hm.put("result", result);
		return new ModelAndView("jsonView", hm);
	}

	@RequestMapping(value = "/_mngr_/manager/mngrManagerAuthPowerListAjax.do")
	public ModelAndView mngrManagerAuthPowerListAjax(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String powerIdx = CommUtil.isNull(request.getParameter("powerIdx"), "");
		List<?> result = mngrManagerService.mngrManagerAuthPowerListAjax(powerIdx);
		HashMap hm = new HashMap();
		hm.put("result", result);
		return new ModelAndView("jsonView", hm);
	}

	private HashMap getConfig(String type) throws IOException, SQLException, RuntimeException {
		HashMap hm = CommUtil.getConfigFromXml("manager", type);
		if(hm == null) throw new RuntimeException("관리자 type 오류");
		return hm;
	}

	//* ########### 로그인 로그 ########### */
	@RequestMapping(value = "/_mngr_/manager/loginLog_list.do")
	public String selectMngrManagerLoginLogList(@ModelAttribute("searchVO") MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		//기본 검색기간 시작일,종료일 설정
		if("".equals(	CommUtil.isNull(	mngrManagerLoginLogSearchVO.getSchSdt() , "" ) )){
			mngrManagerLoginLogSearchVO.setSchSdt(CommUtil.getDatePattern("yyyy-MM-") + "01");
		}
		if("".equals(	CommUtil.isNull(	mngrManagerLoginLogSearchVO.getSchEdt() , "" ) )){
			mngrManagerLoginLogSearchVO.setSchEdt(CommUtil.getDatePattern("yyyy-MM-dd"));
		}

		mngrManagerLoginLogSearchVO.setPageUnit(Integer.parseInt(mngrManagerLoginLogSearchVO.getViewCount()));//viewCount
		mngrManagerLoginLogSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrManagerLoginLogSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrManagerLoginLogSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrManagerLoginLogSearchVO.getPageSize());

		mngrManagerLoginLogSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrManagerLoginLogSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrManagerLoginLogSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<MngrManagerLoginLogVO> result = mngrManagerService.selectMngrManagerLoginLogList(mngrManagerLoginLogSearchVO);
		model.addAttribute("resultList", result);
		int totCnt = mngrManagerService.mngrManagerLoginLogListTotCnt(mngrManagerLoginLogSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);

		List<MngrSiteVO> siteList = mngrSiteService.getMngrSiteList();

		model.addAttribute("siteList", siteList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
		return "itgcms/mngr/manager/loginLog_list";
	}

	@RequestMapping(value = "/_mngr_/manager/loginLog_list.ajax")
	public ModelAndView mngrManagerLoginLogAjax(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String log_id = CommUtil.isNull(request.getParameter("log_id"), "");
		List<MngrManagerLoginLogVO> result = mngrManagerService.mngrManagerLoginLogAjax(log_id);
		HashMap hm = new HashMap();
		hm.put("result", result);
		return new ModelAndView("jsonView", hm);
	}

	@RequestMapping(value="/_mngr_/excel/mngrManagerLoginLogListExcel.do")
	public ModelAndView mngrManagerLoginLogListExcel(@ModelAttribute("searchVO") MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);

		mngrManagerLoginLogSearchVO.setPageUnit(Integer.parseInt(mngrManagerLoginLogSearchVO.getViewCount()));//viewCount
		mngrManagerLoginLogSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrManagerLoginLogSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrManagerLoginLogSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrManagerLoginLogSearchVO.getPageSize());

		mngrManagerLoginLogSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrManagerLoginLogSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrManagerLoginLogSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		mngrManagerLoginLogSearchVO.setExcelDown("excel");

		List<?> resultList = mngrManagerService.selectMngrManagerLoginLogList(mngrManagerLoginLogSearchVO);
		HashMap paramMap = new HashMap();

		//페이징 제외

		paramMap.put("schSdt", mngrManagerLoginLogSearchVO.getSchSdt());
		paramMap.put("schEdt", mngrManagerLoginLogSearchVO.getSchEdt());
		paramMap.put("dataList", resultList);

		//엑셀 템플릿에 넘겨줄 데이타
		mav.addObject("data", paramMap);

		//다운로드에 사용되어질 엑셀파일 템플릿
		mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, CommUtil.getExcelTemplateName(request, "mngr"));
		//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
		mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "회원로그인로그_" + CommUtil.getDatePattern("yyyy-MM-dd"));

		return mav;

	}

	@RequestMapping(value = "/_mngr_/manager/manager_delete_loginLog.do")
	public String mngrManagerLoginLogDel(@ModelAttribute("searchVO") MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrManagerService.deleteMngrManagerLoginLogProc(mngrManagerLoginLogSearchVO);
		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='loginLog_list.do'");
	}

	/* 3.07 버전 추가*/
	@RequestMapping(value = "/_mngr_/manager/manager_list_site.ajax")
	public void managerListSiteAjax(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		mngrManagerSearchVO.setPageUnit(10);//viewCount
		mngrManagerSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrManagerSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrManagerSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrManagerSearchVO.getPageSize());

		mngrManagerSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrManagerSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrManagerSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> result = mngrManagerService.managerListBySite(mngrManagerSearchVO);
		int totCnt = mngrManagerService.managerListBySiteTotCnt(mngrManagerSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);

		String json = "{\"total\":\""+paginationInfo.getTotalRecordCount()+"\",\"currentPage\":\""+paginationInfo.getCurrentPageNo()+"\", \"totalPage\":\""+paginationInfo.getTotalPageCount()+"\",\"result\":  [";
		for(int i = 0; i < result.size(); i++){
			ItgMap manager = (ItgMap)result.get(i);
			json += String.format("{\"mngId\":\"%s\",\"mngName\":\"%s\",\"groupCodeName\":\"%s\",\"managerMenuAuthIdx\":\"%s\"}",
								manager.get("mngId"),
								manager.get("mngName"),
								CommUtil.isNull(manager.get("groupCodeName"),"없음"),
								CommUtil.isNull(manager.get("managerMenuAuthIdx"),"N")
								);
			if(i < result.size() - 1){
				json += ",";
			}

		}
		json += "]}";
		CommUtil.printWriter(json, response);
	}

}
