package egovframework.itgcms.module.menuAuth.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.manager.service.MngrManagerSearchVO;
import egovframework.itgcms.core.manager.service.MngrManagerService;
import egovframework.itgcms.core.manager.service.MngrManagerVO;
import egovframework.itgcms.core.site.service.MngrSiteSearchVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.module.menuAuth.service.MenuAuthService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명 : MenuAuthController.java
 * @파일정보 : 메뉴권한관리 MenuAuthController
 * @수정이력
 * @수정자    수정일       수정내용
 * @------- ------------ ----------------
 * @JANG  2018.11.07 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 3.0.7 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class MenuAuthController {

	private final Logger LOGGER = Logger.getLogger(this.getClass());

    /** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

    /** MenuAuthService */
	@Resource(name = "menuAuthService")
	private MenuAuthService menuAuthService;

	/**
	 * 메뉴권한 리스트
	 * @param model
	 * @return "itgcms/global/module/menuauth/mnauthgroup_list"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthgroup_list.do")
	public String mngrMenuauthgroupList(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model
			,HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request,"schSiteCode");
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		paramMap.put("schSiteCode", siteCode);

		int pageUnit = Integer.parseInt(CommUtil.isNull(paramMap.get("viewCount"),"10"));
		int page = Integer.parseInt(CommUtil.isNull(paramMap.get("page"),"1"));
		int pageSize = 10;

		paramMap.put("pageUnit",pageUnit);//viewCount
		paramMap.put("pageSize",pageSize);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(pageSize);

		paramMap.put("firstIndex",paginationInfo.getFirstRecordIndex());
		paramMap.put("lastIndex",paginationInfo.getLastRecordIndex());
		paramMap.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());

		List<?> resultList = menuAuthService.selectMenuAuthList(paramMap);
		int totCnt =  menuAuthService.selectMenuAuthListTotCnt(paramMap);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

		MngrSiteSearchVO mngrSiteSearchVO = new MngrSiteSearchVO();
		mngrSiteSearchVO.setId(siteCode);
		MngrSiteVO mngrSiteVO =  mngrSiteService.getSiteView(mngrSiteSearchVO);

		model.addAttribute("mngrSiteVO", mngrSiteVO);
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());
		model.addAttribute("resultList", resultList);

		return "itgcms/global/module/menuauth/mnauthgroup_list";
	}

	/**
	 * 메뉴그룹 권한관리 등록. (paging)
	 * @param model
	 * @return "itgcms/global/module/menuauth/mnauthgroup_input"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthgroup_input.do")
	public String mngrMenuauthgroupInput(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request,"schSiteCode");
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		model.addAttribute("schSiteCode", siteCode);
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());

		return "itgcms/global/module/menuauth/mnauthgroup_input";
	}

	/**
	 * 매뉴그룹 권한관리 수정. (paging)
	 * @param model
	 * @return "itgcms/global/module/menuauth/mnauthgroup_edit"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthgroup_edit.do")
	public String mngrMenuauthgroupEdit(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request,"schSiteCode");

		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		paramMap.put("schSiteCode", siteCode);
		ItgMap mngrAuth = menuAuthService.selectMenuAuthView(paramMap);

		model.addAttribute("mngrAuth", mngrAuth);
		model.addAttribute("schMenuAuthIdx", paramMap.get("schMenuAuthIdx"));
		model.addAttribute("schSiteCode", siteCode);
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());

		return "itgcms/global/module/menuauth/mnauthgroup_edit";
	}

	/**
	 * 메뉴그룹 권한등록 프로세스. (paging)
	 * @param model
	 * @return CommUtil.doComplete
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthgroup_input_proc.do")
	public String mngrMenuauthInputProc(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ItgMap paramMap = CommUtil.getParameterEMap(request);

		String siteCode = CommUtil.isNull(paramMap.get("menuAuthSitecode"), "");

		if(CommUtil.empty(paramMap.get("menuAuthName"))) return CommUtil.doComplete(model, "경고", "메뉴권한명이 누락되었습니다.", "history.back();");
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "경고", "관리 사이트코드가 누락되었습니다.", "history.back();");
		if(CommUtil.empty(paramMap.get("menuCodes"))) return CommUtil.doComplete(model, "경고", "관리 메뉴코드가 누락되었습니다.", "history.back();");

		paramMap.put("loginId", CommUtil.getMngrMemId());
		//menuAuthType - 0:개별권한, 1:메뉴권한
		paramMap.put("menuAuthType", "1");

		int count =  menuAuthService.insertMenuAuthProc(paramMap);

		if(count>0) return CommUtil.doComplete(model, "완료", "등록이 완료되었습니다.", "location.href='mnauthgroup_list.do?schSiteCode="+siteCode+"'");
		else return CommUtil.doComplete(model, "오류", "오류가 발생하였습니다.", "location.href='mnauthgroup_list.do?schSiteCode="+siteCode+"'");
	}

	/**
	 * 메뉴그룹 권한수정 프로세스. (paging)
	 * @param model
	 * @return CommUtil.doComplete
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthgroup_edit_proc.do")
	public String mngrMenuauthEditProc(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ItgMap paramMap = CommUtil.getParameterEMap(request);

		String siteCode = CommUtil.isNull(paramMap.get("menuAuthSitecode"), "");

		if(CommUtil.empty(paramMap.get("menuAuthName"))) return CommUtil.doComplete(model, "경고", "메뉴권한명이 누락되었습니다.", "history.back();");
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "경고", "관리 사이트코드가 올바르지 않습니다.", "history.back();");
		if(CommUtil.empty(paramMap.get("menuCodes"))) return CommUtil.doComplete(model, "경고", "관리 메뉴코드가 누락되었습니다.", "history.back();");

		paramMap.put("loginId", CommUtil.getMngrMemId());
		//menuAuthType - 0:개별권한, 1:메뉴권한
		paramMap.put("menuAuthType", "1");

		int count =  menuAuthService.updateMenuAuthProc(paramMap);

		if(count>0) return CommUtil.doComplete(model, "완료", "수정이 완료되었습니다.", "location.href='mnauthgroup_list.do?schSiteCode="+siteCode+"'");
		else return CommUtil.doComplete(model, "오류", "오류가 발생하였습니다.", "location.href='mnauthgroup_list.do?schSiteCode="+siteCode+"'");
	}

	/**
	 * 메뉴 개별권한 등록 프로세스. (paging)
	 * @param model
	 * @return CommUtil.doComplete
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthindiv_input_proc.do")
	public String mnauthindivInputProc(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		String siteCode = CommUtil.isNull(paramMap.get("menuAuthSitecode"), "");

		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "경고", "파라메터가 올바르지 않습니다.", "history.back();");
		if(CommUtil.empty(paramMap.get("menuCodes"))) return CommUtil.doComplete(model, "경고", "파라메터가 올바르지 않습니다.", "history.back();");

		paramMap.put("loginId", CommUtil.getMngrMemId());
		//menuAuthType - 0:개별권한, 1:메뉴권한
		paramMap.put("menuAuthType", "0");

		int count =  menuAuthService.insertMenuAuthProc(paramMap);

		if(count>0) return CommUtil.doComplete(model, "완료", "등록이 완료되었습니다.", "location.href='mnauthindividual_list.do?schSiteCode="+siteCode+"'");
		else return CommUtil.doComplete(model, "오류", "오류가 발생하였습니다.", "location.href='mnauthindividual_list.do?schSiteCode="+siteCode+"'");
	}

	/**
	 * 메뉴 개별권한 수정 프로세스. (paging)
	 * @param model
	 * @return CommUtil.doComplete
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthindiv_edit_proc.do")
	public String mnauthindivEditProc(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ItgMap paramMap = CommUtil.getParameterEMap(request);

		String siteCode = CommUtil.isNull(paramMap.get("menuAuthSitecode"), "");

		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "경고", "파라메터가 올바르지 않습니다.", "history.back();");

		paramMap.put("loginId", CommUtil.getMngrMemId());
		//menuAuthType - 0:개별권한, 1:메뉴권한
		paramMap.put("menuAuthType", "0");

		int count =  menuAuthService.updateMenuAuthProc(paramMap);

		if(count>0) return CommUtil.doComplete(model, "완료", "수정이 완료되었습니다.", "location.href='mnauthindividual_list.do?schSiteCode="+siteCode+"'");
		else return CommUtil.doComplete(model, "오류", "오류가 발생하였습니다.", "location.href='mnauthindividual_list.do?schSiteCode="+siteCode+"'");
	}

	/**
	 * 메뉴 그룹권한 삭제 프로세스. (paging)
	 * @param model
	 * @return CommUtil.doComplete
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthgroup_delete_proc.do")
	public String mnauthgroupDeleteProc(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		String siteCode = CommUtil.isNull(paramMap.get("schSiteCode"), "");
		String menuAuthIdx = CommUtil.isNull(paramMap.get("schMenuAuthIdx"), "");

		if(CommUtil.empty(menuAuthIdx)) return CommUtil.doComplete(model, "에러", "삭제 대상 권한지정이 누락되었습니다.", "location.href='mnauthgroup_list.do?schSiteCode="+siteCode+"'");
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "에러", "관리 사이트코드가 누락되었습니다.", "location.href='mnauthgroup_list.do?schSiteCode="+siteCode+"'");

		paramMap.put("menuAuthIdx", menuAuthIdx);
		paramMap.put("loginId", CommUtil.getMngrMemId());
		//menuAuthType - 0:개별권한, 1:메뉴권한
		paramMap.put("menuAuthType", "1");
		//mngId - 개별권한(0)일 경우, 권한소유관리자아이디(mngId) 필요.
		paramMap.put("mngId", "");

		int count =  menuAuthService.deleteMenuAuthProc(paramMap);

		if(count>0) return CommUtil.doComplete(model, "완료", "삭제가 완료되었습니다.", "location.href='mnauthgroup_list.do?schSiteCode="+siteCode+"'");
		else return CommUtil.doComplete(model, "오류", "오류가 발생하였습니다.", "location.href='mnauthgroup_list.do?schSiteCode="+siteCode+"'");
	}


	/**
	* 메뉴권한 리스트 가져오기
	* @param model
	* @return
	* @throws IOException, SQLException, RuntimeException
	*/
	@RequestMapping(value = "/_mngr_/menuauth/mnauth_comm_itemlist.ajax")
	public void mngrMenuauthCommAuthlist(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		/**
		 * 메뉴권한은 T_MENU_AUTH의 관리자개별권한(MENU_AUTH_TYPE = 0) 과 그룹별권한(MENU_AUTH_TYPE = 1)이 있다.
		**/

		String result = "0";
		ItgMap paramMap = CommUtil.getParameterEMap(request);
		ItgMap setResult = new ItgMap();
		ItgMap setResult2nd = new ItgMap();

		String schType = CommUtil.isNull(paramMap.get("schType"), "");
		String json = "[{";
		//String json2 = "";
		String menuAuthList = "";
		String authItemList = "";
		LOGGER.info("schType : "+schType);

		//paramMap.put("schAuthType", schAuthType);

		String schMngId = CommUtil.isNull(paramMap.get("id"), "");
		String schSiteCode = CommUtil.isNull(paramMap.get("code"), "");
		String schMenuAuthIdx = CommUtil.isNull(paramMap.get("schIdx"), "");

		LOGGER.info("schMngId : "+schMngId);
		LOGGER.info("schSiteCode : "+schSiteCode);
		LOGGER.info("schMenuAuthIdx : "+schMenuAuthIdx);

		paramMap.put("schMngId", schMngId);
		paramMap.put("schSiteCode", schSiteCode);
		paramMap.put("schMenuAuthIdx", schMenuAuthIdx);

		if("0".equals(schType) && CommUtil.empty(schMngId)) result = "5"; //파라메터 정보가 올바르지 않습니다.
		else if("0".equals(schType) && CommUtil.empty(schSiteCode)) result = "5"; //파라메터 정보가 올바르지 않습니다.
		else if("1".equals(schType) && CommUtil.empty(schMenuAuthIdx)) result = "5"; //파라메터 정보가 올바르지 않습니다.

		if("0".equals(result)) {


			if("0".equals(schType)) {
				paramMap.put("schOpt1", "T"); //개별권한조회시 최초 그룹권한과 개별권한이 통합된 권한을 조회한다.
				setResult = setMenuAuthItem(result, paramMap);
				paramMap.put("schOpt1", "G"); //개별권한조회시 최초 그룹권한과 개별권한이 통합된 권한을 조회한다.
				setResult2nd = setMenuAuthItem(CommUtil.isNull(setResult.get("result"),"0"), paramMap);

				result = CommUtil.isNull(setResult2nd.get("result"),"0");
				authItemList =  CommUtil.isNull(setResult2nd.get("authItemList"),"");
				menuAuthList =  CommUtil.isNull(setResult2nd.get("menuAuthList"),"");

				json+= "\"authItemListT\":"+CommUtil.isNull(setResult.get("authItemList"),"")+",";
				json+= "\"menuAuthListT\":"+CommUtil.isNull(setResult.get("menuAuthList"),"")+",";

			}else if("1".equals(schType)) {
				setResult = setMenuAuthItem(result, paramMap);

				result = CommUtil.isNull(setResult.get("result"),"0");
				authItemList =  CommUtil.isNull(setResult.get("authItemList"),"");
				menuAuthList =  CommUtil.isNull(setResult.get("menuAuthList"),"");

			}else {
				authItemList = "";
				menuAuthList = "[{}]";
				result = "5"; //파라메터 정보가 올바르지 않습니다.
			}
		}

		json+= "\"authItemList\":"+authItemList+",";
		json+= "\"menuAuthList\":"+menuAuthList+",";
		json+= "\"result\":\""+result+"\"";
		json += "}]";

		LOGGER.info("json : "+json);

		CommUtil.printWriter(json, response);
	}


	public ItgMap setMenuAuthItem(String result, ItgMap paramMap) throws IOException, SQLException {

		ItgMap returnMap = new ItgMap();
		String menuAuthList = "[{";
		String authItemList = "\"";

		List<?> mngrAuthItemList = menuAuthService.getMenuAuthItemList(paramMap);

		for(int i = 0; i < mngrAuthItemList.size(); i++){
			ItgMap tmpMngrAuthView = (ItgMap)mngrAuthItemList.get(i);
			authItemList += tmpMngrAuthView.get("menuCode");
			if(i < mngrAuthItemList.size() - 1){
				authItemList += "|";
			}

			String auth = "";
			if("Y".equals(CommUtil.isNull(tmpMngrAuthView.get("authR"),"N"))) auth+="R";
			if("Y".equals(CommUtil.isNull(tmpMngrAuthView.get("authC"),"N"))) auth+=",C";
			if("Y".equals(CommUtil.isNull(tmpMngrAuthView.get("authU"),"N"))) auth+=",U";
			if("Y".equals(CommUtil.isNull(tmpMngrAuthView.get("authD"),"N"))) auth+=",D";

			menuAuthList+= "\""+tmpMngrAuthView.get("menuCode")+"\":\""+auth+"\",";
		}
		authItemList += "\"";
		result = "1";
		menuAuthList += "\"length\":\""+mngrAuthItemList.size()+"\"}]";

		returnMap.put("menuAuthList", menuAuthList);
		returnMap.put("authItemList", authItemList);
		returnMap.put("result", result);

		return returnMap;
	}

	@RequestMapping(value = "/_mngr_/menuauth/mnauth_input_indvtogrp_proc.ajax")
	public void mngrMenuauthInputIndvtogrpProc(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String result = "0";
		ItgMap paramMap = CommUtil.getParameterEMap(request);

		if("".equals(CommUtil.isNull(paramMap.get("menuAuthIdx"), ""))) result = "2"; // 메뉴권한 정보가 올바르지 않습니다.
		else if("".equals(CommUtil.isNull(paramMap.get("optStr"), ""))) result = "3"; //관리자 정보가 올바르지 않습니다.
		else {
			paramMap.put("loginId", CommUtil.getMngrMemId());
			menuAuthService.insertIndividualtoMenuauthGroupProc(paramMap);
			result = "1";
		}
		CommUtil.printWriter("{\"result\":\""+result+"\"}", response);
	}

	@RequestMapping(value = "/_mngr_/menuauth/mnauth_input_indvtogrpAll_proc.ajax")
	public void mngrMenuauthInputIndvtogrpAllProc(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String result = "0";
		ItgMap paramMap = CommUtil.getParameterEMap(request,"chkId");

		if(CommUtil.empty(paramMap.get("menuAuthIdx"))) result = "2"; // 메뉴권한 정보가 올바르지 않습니다.
		else if(CommUtil.empty(paramMap.get("chkId"))) result = "3"; //관리자 정보가 올바르지 않습니다.
		else {
			paramMap.put("loginId", CommUtil.getMngrMemId());
			menuAuthService.insertIndividualtoMenuauthGroupAllProc(paramMap);
			result = "1";
		}
		CommUtil.printWriter("{\"result\":\""+result+"\"}", response);
	}

	@RequestMapping(value = "/_mngr_/menuauth/mnauth_delete_indvfromgrp_proc.ajax")
	public void mngrMenuauthDeleteIndvfromgrpProc(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String result = "0";
		ItgMap paramMap = CommUtil.getParameterEMap(request);

		if("".equals(CommUtil.isNull(paramMap.get("optStr"), ""))) result = "2"; // 메뉴권한 정보가 올바르지 않습니다.
		else {
			paramMap.put("loginId", CommUtil.getMngrMemId());
			menuAuthService.deleteIndividualfromMenuauthGroupProc(paramMap);
			result = "1";
		}
		CommUtil.printWriter("{\"result\":\""+result+"\"}", response);
	}

	/** MngrManagerService */
	@Resource(name = "mngrManagerService")
	private MngrManagerService mngrManagerService;

	/**
	 * 관리자 목록을 조회한다. (paging)
	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 PopopSearchVO
	 * @param model
	 * @return "itgcms/global/module/menuauth/mnauthindividual_list"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthindividual_list.do")
	public String mnauthindividualList(@ModelAttribute("searchVO") MngrManagerSearchVO mngrManagerSearchVO, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request,"schSiteCode");
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		mngrManagerSearchVO.setSchSitecode(siteCode);
		model.addAttribute("schSiteCode", siteCode);
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());

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


		List<?> resultList = mngrManagerService.managerListBySiteForIndividual(mngrManagerSearchVO);
		model.addAttribute("resultList", resultList);
		int totCnt = mngrManagerService.managerListBySiteForIndividualTotCnt(mngrManagerSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
		return "itgcms/global/module/menuauth/mnauthindividual_list";
	}

	/**
	 * 컨텐츠 권한 메인. (paging)
	 * @param model
	 * @return "itgcms/global/module/menuauth/mnauthindividual_input"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthindividual_input.do")
	public String mnauthindividualInput(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ItgMap paramMap = CommUtil.getParameterEMap(request);

		String siteCode = CommUtil.isNull(paramMap.get("schSiteCode"), "");
		String mngId = CommUtil.isNull(paramMap.get("schMngId"), "");

		if("".equals(siteCode)) return CommUtil.doComplete(model, "경고", "파라메터 정보가 올바르지 않습니다.", "history.back();");
		if("".equals(mngId)) return CommUtil.doComplete(model, "경고", "파라메터 정보가 올바르지 않습니다.", "history.back();");

		MngrSiteSearchVO mngrSiteSearchVO = new MngrSiteSearchVO();
		MngrManagerSearchVO mngrManagerSearchVO = new MngrManagerSearchVO();
		mngrSiteSearchVO.setId(siteCode);
		mngrManagerSearchVO.setId(mngId);

		MngrSiteVO siteInfo = 	mngrSiteService.getSiteView(mngrSiteSearchVO);
		MngrManagerVO mngrInfo = mngrManagerService.mngrManagerView(mngrManagerSearchVO);

		model.addAttribute("siteInfo", siteInfo);
		model.addAttribute("mngrInfo", mngrInfo);

		return "itgcms/global/module/menuauth/mnauthindividual_input";
	}

	/**
	 * 컨텐츠 권한 메인. (paging)
	 * @param model
	 * @return "itgcms/global/module/menuauth/mnauthindividual_edit"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/menuauth/mnauthindividual_edit.do")
	public String mnauthindividualEdit(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ItgMap paramMap = CommUtil.getParameterEMap(request);

		String siteCode = CommUtil.isNull(paramMap.get("schSiteCode"), "");
		String mngId = CommUtil.isNull(paramMap.get("schMngId"), "");

		if("".equals(siteCode)) return CommUtil.doComplete(model, "경고", "파라메터 정보가 올바르지 않습니다.", "history.back();");
		if("".equals(mngId)) return CommUtil.doComplete(model, "경고", "파라메터 정보가 올바르지 않습니다.", "history.back();");

		MngrSiteSearchVO mngrSiteSearchVO = new MngrSiteSearchVO();
		MngrManagerSearchVO mngrManagerSearchVO = new MngrManagerSearchVO();
		mngrSiteSearchVO.setId(siteCode);
		mngrManagerSearchVO.setId(mngId);

		MngrSiteVO siteInfo = 	mngrSiteService.getSiteView(mngrSiteSearchVO);
		MngrManagerVO mngrInfo = mngrManagerService.mngrManagerView(mngrManagerSearchVO);
		paramMap.put("schStr", "");
		ItgMap mngrAuth = menuAuthService.selectMenuAuthView(paramMap);

		model.addAttribute("siteInfo", siteInfo);
		model.addAttribute("mngrInfo", mngrInfo);
		model.addAttribute("mngrAuth", mngrAuth);

		return "itgcms/global/module/menuauth/mnauthindividual_edit";
	}


	@RequestMapping(value = "/_mngr_/menuauth/mnauth_comm_authlistforindiv.ajax")
	public ModelAndView mnauthCommAuthlistforindiv(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		ItgMap paramMap = CommUtil.getParameterEMap(request);
		List<?> result = menuAuthService.selectMenuAuthListForIndividual(paramMap);
		HashMap hm = new HashMap();
		hm.put("result", result);
		return new ModelAndView("jsonView", hm);
	}
}
