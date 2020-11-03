package egovframework.itgcms.mngr.menu.web;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.board.service.BoardService;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigSearchVO;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigService;
import egovframework.itgcms.core.menu.service.MngrMenuSatisfactionSearchVO;
import egovframework.itgcms.core.menu.service.MngrMenuSatisfactionVO;
import egovframework.itgcms.core.menu.service.MngrMenuSearchVO;
import egovframework.itgcms.core.menu.service.MngrMenuService;
import egovframework.itgcms.core.menu.service.MngrMenuVO;
import egovframework.itgcms.core.program.service.MngrProgramSearchVO;
import egovframework.itgcms.core.program.service.MngrProgramService;
import egovframework.itgcms.core.site.service.MngrSiteSearchVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.module.socialmedia.service.SocialmediaService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.JsonUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * @파일명 : MngrMenuController.java
 * @파일정보 : 메뉴/컨텐츠관리 컨트롤러
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
public class MngrMenuController {

	/** MngrMenuService */
	@Resource(name = "mngrMenuService")
	private MngrMenuService mngrMenuService;

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	/** MngrProgramService */
	@Resource(name = "mngrProgramService")
	private MngrProgramService mngrProgramService;

	/** MngrBoardconfigService */
	@Resource(name = "mngrBoardconfigService")
	private MngrBoardconfigService mngrBoardconfigService;

	/** boardService */
	@Resource(name = "boardService")
	private BoardService boardService;

	/** boardService */
	@Resource(name = "socialmediaService")
	private SocialmediaService socialmediaService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	private static final Logger logger = LogManager.getLogger(MngrMenuController.class);
	private static final int MAIN_PAGE_CONTENTS_MAX_LENGTH = 4;


	/**
	 * 메뉴관리
	 * @param mngrMenuSearchVO
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/menu/menu_list.do")
	public String mngrMenuMain(@ModelAttribute("searchVO") MngrMenuSearchVO mngrMenuSearchVO,
			ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		MngrSiteSearchVO mngrSiteSearchVO = new MngrSiteSearchVO();
		mngrSiteSearchVO.setId(siteCode);
		MngrSiteVO mngrSiteVO =  mngrSiteService.getSiteView(mngrSiteSearchVO);

		model.addAttribute("mngrSiteVO", mngrSiteVO);
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());
		return "itgcms/mngr/menu/menu_list";
	}

	/**
	 * 메뉴 목록 ajax , 관리자, 사용자 공용
	 * @param pcode
	 * @param response
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/common/menu/menu_comm_list.ajax")
	public void selectMngrTreeSubList(@RequestParam HashMap<String,String> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String pcode = CommUtil.isNull(paramMap.get("pcode"), "0");
		EgovMap eMap = new EgovMap();
		eMap.put("pcode", pcode);
		eMap.put("siteCode", paramMap.get("siteCode"));
		eMap.put("mngId", CommUtil.getMngrMemId());

		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();

		if(!"99".equals(mngrSessionVO.getMngAuth())) eMap.put("isMenu", paramMap.get("url"));

		List<MngrMenuVO> result = mngrMenuService.selectMngrTreeSubList(eMap);

		String json = "[";
		for(int i = 0; i < result.size(); i++){
			MngrMenuVO menuVO = result.get(i);
			json += "{"
					+ "\"id\": \"" + menuVO.getMenuCode() + "\" "
					+ ",\"name\": \"" + menuVO.getMenuName() + "\" "
					+ ",\"pId\": \"" + menuVO.getMenuPcode() + "\" "
					+ ",\"depth\": \"" + menuVO.getMenuDepth() + "\" "
					+ ",\"useType\": \"" + menuVO.getMenuUsetype() + "\" "
					+ "}" ;
			if(i < result.size() - 1){
				json += ",";
			}
		}
		json += "]";
		CommUtil.printWriter(json, response);
	}

	/**
	 * 메뉴 목록 ajax , 관리자, 사용자 공용 3.0.7
	 * @param pcode
	 * @param response
	 * @throws IOException, SQLException, RuntimeException
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/common/comm_treemenu_list.ajax")
	public void commTreemenuList(String pmenu, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		ItgMap paramMap = CommUtil.getParameterEMap(request);
		paramMap.put("siteCode", CommUtil.isNull(pmenu, ""));
		paramMap.put("mngId", CommUtil.getMngrMemId());

		List<ItgMap> menulist = mngrMenuService.commTreemenuList(paramMap);
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		resultList.addAll((Collection<? extends Map<String, Object>>) menulist);
		String json = JsonUtil.getJsonStringFromList(resultList);
		logger.info("################################# JSON : "+json);
		CommUtil.printWriter(json, response);
	}

	@RequestMapping(value="/_mngr_/menu/menu_edit.ajax")
	public String mngrMenuRegist(@ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		MngrMenuVO result = mngrMenuService.selectMngrMenuRegistAjax(mngrMenuVO);
		if("REGIST".equals(mngrMenuVO.getAct())){
			model.addAttribute("result2",result); // 등록시에는 입력항목들에 데이터가 없어야 하는데, 입력항복에 기본으로 result. 으로 돼있어서 result2를 만들어서 입력항목에 값이 안들어가게함
		}else{
			model.addAttribute("result",result);
			String shortUrl = CommUtil.getMneuShortUrl(result);
			model.addAttribute("shortUrlCode", shortUrl);
		}
		model.addAttribute("programList", mngrProgramService.mngrProgramListAjax(new MngrProgramSearchVO()));
		model.addAttribute("boardList", mngrBoardconfigService.mngrBoardconfigListAjax(new MngrBoardconfigSearchVO()));
		model.addAttribute("searchVO", mngrMenuVO);

		//전체 메뉴 가져오기
		MngrMenuVO tmpMenuVO = new MngrMenuVO();
		tmpMenuVO.setId(mngrMenuVO.getId());
		tmpMenuVO.setSchFld("mngr");
		model.addAttribute("subMenuList", mngrMenuService.mngrMenuSubList(tmpMenuVO));

		return "itgcms/mngr/menu/menu_edit_ajax";
	}

	@RequestMapping(value = "/_mngr_/menu/menu_comm_dupleCheck.ajax")
	public void mngrMenuDupleCheck(@ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		int cnt = mngrMenuService.mngrMenuDupleCheck(mngrMenuVO);

		CommUtil.printWriter("{\"result\":"+cnt+"}", response);
	}

	@RequestMapping(value = "/_mngr_/menu/menu_edit_proc.ajax")
	public void mngrMenuRegistUpdateAjax(@ModelAttribute("searchVO") MngrMenuVO mngrMenuVO, HttpServletResponse response, HttpServletRequest request) throws IOException, SQLException, RuntimeException {
		String result = "0";
		String message = "데이터 저장 중 오류가 발생했습니다. 다시 시도해 주세요";

		String menuType =  CommUtil.isNull(mngrMenuVO.getMenuType(), "");

		mngrMenuVO.setSiteCode(CommUtil.strSplitGet(mngrMenuVO.getMenuPfullcode(), "1"));
		if("0".equals(menuType)){
			mngrMenuVO.setMenuSubType(mngrMenuVO.getSubMenuList());
		}else if("2".equals(menuType)){
			mngrMenuVO.setMenuSubType(mngrMenuVO.getProgramList());
		}else if("3".equals(menuType)){
			mngrMenuVO.setMenuSubType(mngrMenuVO.getBoardList());
		}

		if("REGIST".equals(mngrMenuVO.getAct())){
			/*
			 * 등록 모드
			 */
			// 입력값 체크
			if("".equals(CommUtil.isNull(mngrMenuVO.getMenuCode(), ""))){
				result = "3";
				message = "메뉴코드를 입력 해 주세요.";
			} else if("".equals(CommUtil.isNull(mngrMenuVO.getMenuName(), ""))){
				result = "3";
				message = "메뉴이름을 입력 해 주세요.";
			} else if(("2".equals(menuType)|| "3".equals(menuType)) && "".equals(CommUtil.isNull(mngrMenuVO.getMenuUrl(), ""))) {
					result = "3";
					message = "사용자 링크주소을 입력 해 주세요.";
			} else if(("2".equals(menuType)|| "3".equals(menuType)) && "".equals(CommUtil.isNull(mngrMenuVO.getMenuMngurl(), ""))) {
					result = "3";
					message = "관리 링크주소을 입력 해 주세요.";
			/*} else if("".equals(CommUtil.isNull(mngrMenuVO.getMenuNavi(), ""))){
				result = "3";
				message = "메뉴 네비게이션을 입력 해 주세요.";*/
			}else { //입력값 정상
				int resultCnt = mngrMenuService.mngrMenuDupleCheck(mngrMenuVO); //메뉴코드 중복 검사
				if(resultCnt > 0){
					result = "2";
					message = "메뉴코드가 중복 되었습니다. 확인 후 다시 시도해 주세요";
				}else{
					// 메뉴코드 정상
					mngrMenuVO.setRegmemid(CommUtil.getMngrMemId());
					mngrMenuService.insertMngrMenuProc(mngrMenuVO);
					result = "1";
					message = "등록 되었습니다.";
				}
			}
		}else if("UPDATE".equals(mngrMenuVO.getAct())){
			/*
			 * 수정 모드
			 */
			if("".equals(CommUtil.isNull(mngrMenuVO.getId(), ""))){
				result = "3";
				message = "메뉴코드 정보가 없습니다. 확인 후 다시 시도해 주세요.";
			} else if("".equals(CommUtil.isNull(mngrMenuVO.getMenuName(), ""))){
				result = "3";
				message = "메뉴이름을 입력 해 주세요.";
			} else if(("2".equals(menuType)|| "3".equals(menuType)) && "".equals(CommUtil.isNull(mngrMenuVO.getMenuUrl(), ""))) {
				result = "3";
				message = "사용자 링크주소을 입력 해 주세요.";
			} else if(("2".equals(menuType)|| "3".equals(menuType)) && "".equals(CommUtil.isNull(mngrMenuVO.getMenuMngurl(), ""))) {
				result = "3";
				message = "관리 링크주소을 입력 해 주세요.";
			/*} else if("".equals(CommUtil.isNull(mngrMenuVO.getMenuNavi(), ""))){
				result = "3";
				message = "메뉴 네비게이션을 입력 해 주세요.";*/
			}else { //입력값 정상
				mngrMenuVO.setUpdmemid(CommUtil.getMngrMemId());
				result = mngrMenuService.updateMngrMenuProc(mngrMenuVO);
				result = "1";
				message = "수정 되었습니다.";
			}
		}

		if("1".equals(result)) {
			String createResult = mngMenuCreateFile(mngrMenuVO.getSiteCode());
		}

		String json = "{\"result\" : "+result+", \"message\" : \""+message+"\"}";
		CommUtil.printWriter(json, response);
	}

	@RequestMapping(value = "/_mngr_/menu/menu_delete_proc.ajax")
	public void deleteMngrMenuRegistAjax(@ModelAttribute("searchVO") MngrMenuVO mngrMenuVO, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		mngrMenuVO.setDelmemid(CommUtil.getMngrMemId());

		String result = "0";
		int subCount = mngrMenuService.mngrMenuSubCount(mngrMenuVO);
		if(subCount == 0){
			mngrMenuVO.setDelmemid(CommUtil.getMngrMemId());
			mngrMenuService.deleteMngrMenuRegistAjax(mngrMenuVO);
			result = "1";
		}else{
			result = "2"; // 메뉴에 포함된 하위메뉴가 있어서 삭제 할 수 없습니다.\n하위메뉴를 먼저 삭제 해 주세요.
		}
		String json = "{\"result\" : "+result+", \"message\" : \""+result+"\"}";
		CommUtil.printWriter(json, response);
	}

	@RequestMapping(value="/_mngr_/menu/menu_edit_updown.ajax")
	public void mngrCodeSwap(@ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		String result = "0";
		result = mngrMenuService.mngrMenuSwap(mngrMenuVO);
		CommUtil.printWriter("{\"result\" : "+result+"}", response);
	}

	@RequestMapping(value="/_mngr_/menu/menu_edit_move.ajax")
	public void mngrMenuMove(@ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		String result = "0"; //알수없는 오류
		mngrMenuVO.setId(mngrMenuVO.getTargetCode()); //대상 메뉴의 정보를 가져오기 위해 id에 코드 설정.
		MngrMenuVO targetMenuVO = mngrMenuService.selectMngrMenuRegistAjax(mngrMenuVO); // 대상메뉴 정보
		mngrMenuVO.setId(mngrMenuVO.getOriginalCode()); //원본(이동할)메뉴 정보를 가져오기 위해 id에 코드 설정
		MngrMenuVO originalMenuVO = mngrMenuService.selectMngrMenuRegistAjax(mngrMenuVO);// 원본(이동할)메뉴 정보
		if(targetMenuVO == null){
			result = "2"; //대상 메뉴 정보가 없습니다.
		} else if(originalMenuVO == null){
			result = "3"; //원본 메뉴 정보가 없습니다.
		} else if("1".equals(originalMenuVO.getMenuDepth())){
			//원본메뉴가 1depth 인지 확인해서 처리
			result = "4"; //최상위 메뉴는 이동 할 수 없습니다.
		}else{

			// 1. 원본메뉴의 pcode를 대상메뉴 코드로 설정
			// 2. 원본메뉴의 order는 pcode 가 대상메뉴 코드인 것들의 max() +1
			originalMenuVO.setMenuPcode(targetMenuVO.getMenuCode()); //mngrMenuVO.getTargetCode() 와 같다.

			//fullcode, fullname 업데이트를 위한 설정
			//1. oldpfullname, oldpfullcode 에 pfullcode, pfullname을 입력
			originalMenuVO.setMenuOldpfullname(originalMenuVO.getMenuPfullname());
			originalMenuVO.setMenuOldpfullcode(originalMenuVO.getMenuPfullcode());
			//2. pfullcode, pfullname 에  대상메뉴의 pfullcode, pfullname 저장
			originalMenuVO.setMenuPfullname(targetMenuVO.getMenuPfullname());
			originalMenuVO.setMenuPfullcode(targetMenuVO.getMenuPfullcode());

			originalMenuVO.setMenuMoveDepth(
					(Integer.parseInt(targetMenuVO.getMenuDepth() ) + 1) // 이동할 코드의 뎁스 + 1, 하위로 들어가니까 1이 더해져 야 함
					- Integer.parseInt(originalMenuVO.getMenuDepth() )
					);
			originalMenuVO.setSiteCode(CommUtil.strSplitGet(originalMenuVO.getMenuPfullcode(), "1"));
			mngrMenuService.mngrMenuMove(originalMenuVO);
			result = "1"; //메뉴가 이동 되었습니다.
		}
		CommUtil.printWriter("{\"result\" : "+result+"}", response);
	}

	/* #################################################################################
	 자동 include 파일 생성
	- GNB 영역(탬플릿 파일 a, b, c, d 공통)
	include_web_GNB : web은 사이트 코드

	- LNB 영역(탬플릿 a)
	inlclude_web_A_LEFT_ 대메뉴코드

	- LNB 영역(탬플릿 b,c)
	include_web_LEFT_대메뉴코드
	include_web_MLEFT_대메뉴코드(모바일용)

	- LNB 영역(탬플릿 d) 없음.

	##################################################################################### */
	@RequestMapping(value="/_mngr_/menu/menu_edit_create.ajax")
	public ModelAndView  mngMenuCreateFile2(@ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {

		ModelAndView mav = new ModelAndView("jsonView");

		String result = "0"; //알수없는 오류

		if("".equals(CommUtil.isNull(mngrMenuVO.getId(), ""))){
			result = "2"; // 선택된 최상위 메뉴 정보가 없습니다.
		}else{
		  // 재귀호출로 메뉴 리스트 만들기
			//String path = CommUtil.getContextRoot() + System.getProperty("file.separator") + "WEB-INF/jsp/egovframework/itgcms/user/template/include/";

			//전체 메뉴 가져오기
			mngrMenuVO.setId(mngrMenuVO.getId());
			mngrMenuVO.setMinDepth("1");
			List resultList = mngrMenuService.mngrMenuListRecursive(mngrMenuVO);

			String path = CommUtil.getFileRoot(mngrMenuVO.getSiteCode()) + System.getProperty("file.separator") + "user/include/";

			CommUtil.setFileObject(resultList, "menulist", mngrMenuVO.getSiteCode(), "user/include/");

			/*
			 * 성남 메뉴 정리
			 * GNB : recursiveGNB_TYPE_A
			 * LEFT : LEFT TPYE_B
			 * SITEMAP : sitemap
			 * 전체메뉴 대신 sitemap 사용.
			 */

			// 2020-04-20 woonne 성남산업진흥원 커스터마이징 함
			//GNB 파일 생성 ** 성남산업진흥원 GNB 메뉴

			String strResult = recursiveGNB_TYPE_A(resultList, mngrMenuVO.getId(), 0, "GNB", 1, 5);

			// 2020-05-25 hsk1218 성남산업진흥원 영문 사이트맵 제외
			if ("eng".equals(mngrMenuVO.getSiteCode())) {
				strResult = "<ul class=\"gnb_depth1\" id=\"gnb\">" +  strResult +
							"</ul>";
			} else {
				strResult = "<ul class=\"gnb_depth1\" id=\"gnb\">" +  strResult +
							"<li class=\"open_all_menu_wrap\">\r\n" +
							"							<div class=\"open_all_menu\">\r\n" +
							"								<a href=\"/SNIP/contents/sitemap.do\"><span>사이트맵</span></a>\r\n" +
							"							</div>\r\n" +
							"						</li>" +
							"</ul>";
			}

			CommUtil.createJspFile(path, "Include_A_GNB.jsp", strResult, mngrMenuVO.getSiteCode());

			//GNB TYPE B 파일 생성 ** 성남산업진흥원 전체메뉴
			String strResultB = recursiveGNB_TYPE_B(resultList, mngrMenuVO.getId(), 0, "GNB", 1, 5,"");
			strResultB = "<ul class=\"all_menu_depth1 clfx\">" +  strResultB + "</ul>";
			CommUtil.createJspFile(path, "Include_B_GNB.jsp", strResultB, mngrMenuVO.getSiteCode());

			//GNB TYPE C 생성
			String strResultC = recursiveGNB_TYPE_C(resultList, mngrMenuVO.getId(), 0, "GNB", 1, 3,"");
			strResultC = "<ul class=\"st_g_l dp1\">" +  strResultC + "</ul>";

			CommUtil.createJspFile(path, "Include_C_GNB.jsp", strResultC, mngrMenuVO.getSiteCode());

	    	//SNB  TYPE A 파일 생성
	    	// 재귀함수 호출 없이 바로 생성함.
	    	for(int i = 0; i < resultList.size(); i++){
	    		MngrMenuVO menuVO = (MngrMenuVO)resultList.get(i);
	    		String str = "";
	    			String head = "\n\t\t<li class=\"dp\">\n";
	    			head += "<a href=\"#\">"+menuVO.getMenuName()+"</a>";
	    			head += "<div class=\"dp2_w\">";
	    			head += "<ul class=\"dp2\">";
	    			String body = "";
	    	    	for(int k = 0; k < resultList.size(); k++){
	    	    		MngrMenuVO tmpMenuVO = (MngrMenuVO)resultList.get(k);
	    	    		if("0".equals(tmpMenuVO.getMenuUsetype())){
	    	    			String idName = "id=\"SNB_"+tmpMenuVO.getMenuCode()+"\"";
	    	    			body += "<li>"+getMenuLink(tmpMenuVO, mngrMenuVO.getId(), idName)+"</li>";
	    	    		}
	    	    	}
	    	    	String tail = "</ul></div></li>";

	    	    	String depth1 = head + body + tail;

	    	    	body = "";
	    	    	head = "<li class=\"dp\">\n";
	    	    	head += "<a href=\"#\" id=\"\"></a>";
	    	    	head += "<div class=\"dp2_w\">";
	    	    	head += "<ul class=\"dp2\">";
	    	    	for(int j = 0; j < menuVO.getMngrMenuList().size(); j++){
    	    			MngrMenuVO tmpSubMenuVO = (MngrMenuVO)menuVO.getMngrMenuList().get(j);
    	    			String idName = "id=\"SNB_"+tmpSubMenuVO.getMenuCode()+"\"";
    	    			body += "<li>"+getMenuLink(tmpSubMenuVO, mngrMenuVO.getId(), idName)+"</li>";
    	    		}
	    	    	tail = "</ul></div></li>";
	    	    	String depth2 =head + body + tail;
	    			str = "<ul class=\"lnb_l\"><li class=\"home\"><a href=\"/\" class=\"ico home\"><span class=\"blind\">첫화면</span></a></li>" + depth1 + depth2 + "</ul>";
		    	//CommUtil.createJspFile(path, "Include_" + mngrMenuVO.getId() + "_A_LEFT" + "_" + menuVO.getMenuCode() + ".jsp", str);
		    	CommUtil.createJspFile(path, "Include_A_LEFT" + "_" + menuVO.getMenuCode() + ".jsp", str,  mngrMenuVO.getSiteCode());

		    		for(int j = 0; j < menuVO.getMngrMenuList().size(); j++){
		    			MngrMenuVO tmpSubMenuVO = (MngrMenuVO)menuVO.getMngrMenuList().get(j);

		    			if(tmpSubMenuVO.getMngrMenuList().size() > 0){

		    				String body3 = "";

		    				for(int k = 0; k < tmpSubMenuVO.getMngrMenuList().size(); k++){
	    	    				MngrMenuVO tmpSub2MenuVO = (MngrMenuVO)tmpSubMenuVO.getMngrMenuList().get(k);
	    	    				String idName3 = "id=\"SNB_"+tmpSub2MenuVO.getMenuCode()+"\"";
	    	    				body3 += "<li>"+getMenuLink(tmpSub2MenuVO, mngrMenuVO.getId(), idName3)+"</li>";
	    	    			}
		    				String depth3 = head + body3 + tail;

		    				str = "<ul class=\"lnb_l\"><li class=\"home\"><a href=\"/\" class=\"ico home\"><span class=\"blind\">첫화면</span></a></li>" + depth1 + depth2 + depth3 + "</ul>";
		    		    	//CommUtil.createJspFile(path, "Include_" + mngrMenuVO.getId() + "_A_LEFT" + "_" + tmpSubMenuVO.getMenuCode() + ".jsp", str);
		    		    	CommUtil.createJspFile(path, "Include_A_LEFT" + "_" + tmpSubMenuVO.getMenuCode() + ".jsp", str,  mngrMenuVO.getSiteCode());
		    			}
		    		}
	    	}

	    	//성남산업진흥원 4Depth TAB 메뉴 : t_menu 데이터 상 4Depth 메뉴의 menu_depth 는 5이다.
	    	//
	    	printSNIPTab(resultList, mngrMenuVO.getId(), 0, "TAB", 4, path);

	    	//SNB TYPE B 파일 생성 성남 LEFT
	    	for(int i = 0; i < resultList.size(); i++){
	    		MngrMenuVO menuVO = (MngrMenuVO)resultList.get(i);
	    		String str = "";
	    		if(menuVO.getMngrMenuList() != null){
					str = recursiveSNB_TYPE_B(menuVO.getMngrMenuList(), mngrMenuVO.getId(),0, "SNB", 2, 3);
				}
	    		/*if(!"".equals(str)){
	    			// str = "<h2>"+menuVO.getMenuName().replaceAll("&", "&amp;")+"</h2><nav><ul class=\"lnb\">" + str + "</ul></nav>";
	    			str = "<div class=\"inner\">"
	    					+ "<strong class=\"sub_page_tit\">"
	    						+menuVO.getMenuName().replaceAll("&", "&amp;")
	    					+"</strong>\n"
    					+ "</div>\n"
    					+ "<div class=\"sub-tab__menu on\">\r\n"
	    					+ "<div class=\"sub-tab__menu_inner\">"
	    						+ "<ul>"
	    						+ str
	    						+ "</ul>"
	    					+ "</div>"
    					+ "</div>"
	    			;
	    		}*/
	    		if(!"".equals(str)){
    			// str = "<h2>"+menuVO.getMenuName().replaceAll("&", "&amp;")+"</h2><nav><ul class=\"lnb\">" + str + "</ul></nav>";
    			str = "<div class=\"inner\">"
    					+ "<strong class=\"sub_page_tit\">"
    						+menuVO.getMenuName().replaceAll("&", "&amp;")
    					+"</strong>\n"
					+ "</div>\n"
					+ "<div class=\"sub-tab__menu\">\r\n"
    					+ "<div class=\"sub-tab__menu_inner\">"
    						+ "<ul>"
    						+ str
    						+ "</ul>"
    					+ "</div>"
					+ "</div>"
    			;
	    		}
		    	//depth2
		    	//CommUtil.createJspFile(path, "Include_" + mngrMenuVO.getId() + "_B_LEFT" + "_" + menuVO.getMenuCode() + ".jsp", str);
		    	CommUtil.createJspFile(path, "Include_B_LEFT" + "_" + menuVO.getMenuCode() + ".jsp", str,  mngrMenuVO.getSiteCode());
	    	}

	    	//SNB TYPE B 모바일용 파일 생성
	    	for(int i = 0; i < resultList.size(); i++){
	    		MngrMenuVO menuVO = (MngrMenuVO)resultList.get(i);
	    		String str = "";
	    		if(menuVO.getMngrMenuList() != null){
	    			str = recursiveSNB_TYPE_B(menuVO.getMngrMenuList(), mngrMenuVO.getId(),0, "SNB_M", 2, 3);
	    		}
	    		if(!"".equals(str)){
	    			// str = "<h2>"+menuVO.getMenuName().replaceAll("&", "&amp;")+"</h2><nav><ul class=\"lnb\">" + str + "</ul></nav>";
	    			str = "<ul class=\"lnb_l\">" + str + "</ul>";
	    		}
	    		//depth2
	    		//CommUtil.createJspFile(path, "Include_" + mngrMenuVO.getId() + "_B_LEFT" + "_Mobile_" + menuVO.getMenuCode() + ".jsp", str);
	    		CommUtil.createJspFile(path, "Include_B_LEFT" + "_Mobile_" + menuVO.getMenuCode() + ".jsp", str, mngrMenuVO.getSiteCode());
	    	}

	    	// 사이트맵 파일 생성
	    	//GNB 파일 생성
	    	strResult = recursiveSitemap(resultList, mngrMenuVO.getId(), 0, "SITEMAP", 1, 4);
			strResult = "<ul class=\"sitemap-alllist\">" +  strResult + "</ul>";
	    	//CommUtil.createJspFile(path, "Include_" + mngrMenuVO.getId() + "_SITEMAP.jsp", strResult);
	    	CommUtil.createJspFile(path, "Include_SITEMAP.jsp", strResult, mngrMenuVO.getSiteCode());

			result = "1";
			//resultList.clear();
			mngrMenuVO = null;
		}

		mav.addObject("result","1");
		mav.setViewName("jsonView");

		return mav;
	}

	// 4 depth Tab 메뉴  생성
	private void printSNIPTab(List<MngrMenuVO> result, String siteCode, int count, String type, int targetDepth, String path ) {
		String depth = "";
		for(int i = 0;i < result.size(); i++){
			MngrMenuVO menuVO = result.get(i);
			depth = menuVO.getMenuDepth();

			String str = "";
			if(Integer.valueOf(depth) == targetDepth){
				if(menuVO.getMngrMenuList().size() > 0) {
					List<MngrMenuVO> tabList = menuVO.getMngrMenuList();
					str = "<div class=\"clfx sub-tab__4dep_list\">\n";
					for(int j = 0; j < tabList.size(); j++ ) {
						MngrMenuVO tmpMenuVO = tabList.get(j);
						String idName = "id=\""+type+"_"+tmpMenuVO.getMenuCode()+"\"";
						str += "<div class=\"menu\" " + idName + ">" + getMenuLink(tmpMenuVO, siteCode, "") + "</div>\n";

					}
					str += "</div>";
				}
				try {
					CommUtil.createJspFile(path, "Include_A_"+type+"_"+menuVO.getMenuCode()+".jsp", str, siteCode);
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				if(menuVO.getMngrMenuList() != null){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)
					printSNIPTab(menuVO.getMngrMenuList(), siteCode, ++count, type, targetDepth, path);
				}
			}
		}
	}

	/**
	 * 메뉴 만족도
	 * @param mngrMenuSatisfactionSearchVO
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/menu/satisfaction_list.do")
	public String mngrMenuSatisfaction(@ModelAttribute("mngrMenuSatisfactionSearchVO") MngrMenuSatisfactionSearchVO mngrMenuSatisfactionSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		List<MngrSiteVO> siteList = mngrSiteService.getMngrSiteList();

		if("".equals(CommUtil.isNull(mngrMenuSatisfactionSearchVO.getSchSitecode(), ""))) mngrMenuSatisfactionSearchVO.setSchSitecode(CommUtil.getDefaultSiteCode());

		List resultList = mngrMenuService.selectMngrMenuSatisfactionList(mngrMenuSatisfactionSearchVO);

		model.addAttribute("searchVO", mngrMenuSatisfactionSearchVO);
		model.addAttribute("siteList", siteList);
		model.addAttribute("resultList", resultList);

		return "itgcms/mngr/menu/satisfaction_list";
	}

	/**
	 * 메뉴 만족도 의견
	 * @param mngrMenuSatisfactionSearchVO
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/menu/satisfaction_comm_opinion.ajax")
	public ModelAndView mngrMenuSatisfactionView(@ModelAttribute("mngrMenuSatisfactionSearchVO") MngrMenuSatisfactionSearchVO mngrMenuSatisfactionSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		List resultList = mngrMenuService.selectMngrMenuSatisfactionListByMenuCode(mngrMenuSatisfactionSearchVO);
		//System.out.println(resultList);
		HashMap hm = new HashMap();
		hm.put("result", resultList);
		//System.out.println(hm);
		return new ModelAndView("jsonView",hm);
	}

	@SuppressWarnings("unchecked")
	private String recursive(List<MngrMenuVO> result, String siteCode, int count, String type, int sDepth, int eDepth){
		String str = "";
		int nowCount = count;
		String depth = "";
		for(int i = 0;i < result.size(); i++){
			MngrMenuVO menuVO = result.get(i);
			depth = menuVO.getMenuDepth();
			/*if("2".equals(depth) && "GNB".equals(type) && !"0".equals(menuVO.getMenuUsetype())){
				continue;//GNB메뉴 생성시 대메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
			}*/
			if(!"0".equals(menuVO.getMenuUsetype())){
				continue;//전체 메뉴 생성시 메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
			}
			String className = "";//css class 적용을 위한 설정
			String idName = ""; //left메뉴 선택표시를 위한 아이디설정
 			if(i == 0){
				className = "{{LI_FIRST}}";
			}else if( i == result.size() - 1){
				className = "{{LI_LAST}}";
			}else{
				className = "{{LI_LIST}}";
			}

 			if("SITEMAP".equals(type)){
 				if((i+1) != 0 && (i+1) % 4 == 0){
 					className = "{{LI_LAST}}";
 				}else{
 					className = "{{LI_LIST}}";
 				}
 			}

			idName = "id=\""+type+"_"+menuVO.getMenuCode()+"\"";

			str += "<li class=\""+className+"\">\n";
			if("SITEMAP".equals(type) && "2".equals(depth)){
				str += "<h3 class=\"tit\">"+menuVO.getMenuName()+"</h3>";
			}else{
				str += getMenuLink(menuVO, siteCode, idName);
			}

			if(menuVO.getMngrMenuList() != null){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)
					if(Integer.valueOf(menuVO.getMenuDepth()) >= sDepth  && Integer.valueOf(menuVO.getMenuDepth()) <= eDepth){
						if(menuVO.getMngrMenuList().size() > 0)
							str += recursive(menuVO.getMngrMenuList(), siteCode, ++count, type, sDepth, eDepth);
					}
			}
			str += "</li>\n";
		}
		if(nowCount > 0){//처음엔 ul이 필요없음.(코딩에 의한 설정)
			/*str = "<ul class=\"{{UL_DEPTH"+depth+"}}\">\n" + str + "</ul>\n";*/

			String dp = "";
			if(!"".equals(depth)) dp = String.valueOf(Integer.parseInt(depth) - 1);
				if("SITEMAP".equals(type)){
					if("2".equals(dp)){
						str = "<ul class=\"sitemapSub\">\n" + str + "</ul>\n";
					}else if("3".equals(dp)){
						str = "<ul class=\"sitemapDp3\">\n" + str + "</ul>\n";
					}

				}else{
					str = "<ul class=\"dp"+dp+"\">\n" + str + "</ul>\n";
				}
		}
		return str;
	}

	private String getDeptTab(String depth) {
		String str = "";
		switch(depth) {
		case "10" :  str += "\t";
		case "9" :   str += "\t";
		case "8" :   str += "\t";
		case "7" :   str += "\t";
		case "6" :   str += "\t";
		case "5" :   str += "\t";
		case "4" :   str += "\t";
		case "3" :   str += "\t";
		case "2" :   str += "\t";
		}
		return str;
	}
	/**
	 * GNB 인클루드 파일 생성 재귀함수
	 * @param result
	 * @param siteCode
	 * @param count
	 * @param type
	 * @param sDepth
	 * @param eDepth
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String recursiveGNB_TYPE_A(List<MngrMenuVO> result, String siteCode, int count, String type, int sDepth, int eDepth){
		String str = "";
		int nowCount = count;
		String depth = "";
		// depth 1은 사이트 코드
		// depth 2는 대메뉴, 3 중메뉴, 4 소메뉴

		//depth 별 class.
		int depth1cnt = 0;
		for(int i = 0;i < result.size(); i++){
			MngrMenuVO menuVO = result.get(i);
			depth = menuVO.getMenuDepth();
/*			if("2".equals(depth) && "GNB".equals(type) && !"0".equals(menuVO.getMenuUsetype())){
				continue;//GNB메뉴 생성시 대메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
			}*/
			/*if(!"0".equals(menuVO.getMenuUsetype())){
				continue;//메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
			}*/
			if("2".equals(depth)) depth1cnt ++;


			String idName = ""; //left메뉴 선택표시를 위한 아이디설정

			idName = "id=\""+type+"_"+menuVO.getMenuCode()+"\"";

			//대메뉴(2 depth) 일때만 li에 class적용
			if("2".equals(depth)) {
				if(!"0".equals(menuVO.getMenuUsetype())){
					str += "\n" + getDeptTab(depth) + "<li class=\"gnb_depth1_item gnb_depth1_item" + depth1cnt + " v_tablet \">" + getDeptTab(depth) + "\t\n";
				}else{
					str += "\n" + getDeptTab(depth) + "<li class=\"gnb_depth1_item gnb_depth1_item" + depth1cnt + "\">" + getDeptTab(depth) + "\t\n";
				}
			}
			else str += "\n" + getDeptTab(depth) + "<li>" + getDeptTab(depth) + "\t\n";

			str += getMenuLink(menuVO, siteCode, idName);

			if("2".equals(depth)) {

				str += "\n							<div class=\"gnb_depth2_item gnb_depth2_item" + depth1cnt + "\">";
				str += "\n								<div>";
				str += "\n									<div class=\"gnb_depth2_inner\">";
				str += "\n										<div class=\"sgnb_title_txt\">";
				str += "\n											<span class=\"title\">" + menuVO.getMenuName() + "</span>";
				str += "\n											<p>";
				str += "\n												" + menuVO.getMenuMemo().replaceAll("\n", "<br />") ;
				str += "\n											</p>";
				str += "\n										</div>";
			}


			if(menuVO.getMngrMenuList() != null){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)
				if(Integer.valueOf(menuVO.getMenuDepth()) >= sDepth  && Integer.valueOf(menuVO.getMenuDepth()) <= eDepth){
					if(menuVO.getMngrMenuList().size() > 0 /* && !"Guidance".equals(menuVO.getMenuPcode())*/) // 하위 메뉴가 있으면 재귀호출. (사업안내는 2depth까지만 출력)
						str += recursiveGNB_TYPE_A(menuVO.getMngrMenuList(), siteCode, ++count, type, sDepth, eDepth);
				}
			}
			if("2".equals(depth)) {
				str += "							</div>\n";
				str += "						</div>\n";
				str += "					</div>\n";
			}

			str += "\n" + getDeptTab(depth) + "</li>\n";
		}
		if(nowCount > 0){//처음엔 ul이 필요없음.(코딩에 의한 설정)
			// 서브의 첫번째 메뉴에서 ul을 만들기때문에 depth-1해야 함.
			str = "\n" + getDeptTab(depth) + "<ul>\n" + str + "</ul>\n";

			if("3".equals(depth)) {
				str = "\n" + getDeptTab(depth) + "<div class=\"gnb_depth2_list\">" + str + "</div>";
			} else if("4".equals(depth)) {
				str = "\n" + getDeptTab(depth) + "<div class=\"gnb_dep3_list\">" + str + "</div>";
			} else if("5".equals(depth)) {
				str = "\n" + getDeptTab(depth) + "<div class=\"gnb_dep4_list\">" + str + "</div>";
			} else if("6".equals(depth)) {
				str = "\n" + getDeptTab(depth) + "<div class=\"gnb_dep5_list\">" + str + "</div>";

			}
		}
		return str;
	}

	/**
	 * GNB 인클루드 파일 생성 재귀함수
	 * @param result
	 * @param siteCode
	 * @param count
	 * @param type
	 * @param sDepth
	 * @param eDepth
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String recursiveGNB_TYPE_B(List<MngrMenuVO> result, String siteCode, int count, String type, int sDepth, int eDepth, String menuName){
		String str = "";
		int nowCount = count;
		String depth = "";
		// depth 1은 사이트 코드
		// depth 2는 대메뉴, 3 중메뉴, 4 소메뉴

		int depth1cnt = 0;
		for(int i = 0;i < result.size(); i++){
			MngrMenuVO menuVO = result.get(i);
			depth = menuVO.getMenuDepth();
			/*if("2".equals(depth) && "GNB".equals(type) && !"0".equals(menuVO.getMenuUsetype())){
				continue;//GNB메뉴 생성시 대메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
			}*/
			if(!"0".equals(menuVO.getMenuUsetype())){
				continue;//메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
			}
			if("2".equals(depth)) depth1cnt ++;

			String idName = ""; //left메뉴 선택표시를 위한 아이디설정

			idName = "id=\""+type+"_"+menuVO.getMenuCode()+"\"";

			//대메뉴(2 depth) 일때만 li에 class적용
			if("2".equals(depth)) { //대메뉴는 li class추가, 링크없이 h2 태그
				str += "\n" + getDeptTab(depth) + "<li class=\"all_menu_depth1_item all_menu_depth1_item" + depth1cnt + "\">" + getDeptTab(depth) + "\t\n";
				str += "<h2 class=\"depth1\">" + menuVO.getMenuName() + "</h2>";
			} else {
				str += "\n" + getDeptTab(depth) + "<li>" + getDeptTab(depth) + "\t\n";
				str += getMenuLink(menuVO, siteCode, idName);
			}


			if(menuVO.getMngrMenuList() != null){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)
				if(Integer.valueOf(menuVO.getMenuDepth()) >= sDepth  && Integer.valueOf(menuVO.getMenuDepth()) <= eDepth){
					if(menuVO.getMngrMenuList().size() > 0)

						str += recursiveGNB_TYPE_B(menuVO.getMngrMenuList(), siteCode, ++count, type, sDepth, eDepth, menuVO.getMenuName());
				}
			}
			str += "\n\t</li>\n";
		}
		if(nowCount > 0){//처음엔 ul이 필요없음.(코딩에 의한 설정)
			// 서브의 첫번째 메뉴에서 ul을 만들기때문에 depth-1해야 함.
			str = "\n" + getDeptTab(depth) + "<ul>\n" + str + "</ul>\n";

			if("3".equals(depth)) {
				str = "\n" + getDeptTab(depth) + "<div class=\"all_menu_depth2_list\">" + str + "</div>";
			} else if("4".equals(depth)) {
				str = "\n" + getDeptTab(depth) + "<div class=\"all_menu_dep3_list\">" + str + "</div>";
			} else if("5".equals(depth)) {
				str = "\n" + getDeptTab(depth) + "<div class=\"all_menu_dep4_list\">" + str + "</div>";
			} else if("6".equals(depth)) {
				str = "\n" + getDeptTab(depth) + "<div class=\"all_menu_dep5_list\">" + str + "</div>";

			}
		}
		return str;
	}

	/**
	 * GNB 인클루드 파일 생성 재귀함수
	 * @param result
	 * @param siteCode
	 * @param count
	 * @param type
	 * @param sDepth
	 * @param eDepth
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String recursiveGNB_TYPE_C(List<MngrMenuVO> result, String siteCode, int count, String type, int sDepth, int eDepth, String menuName){
		String str = "";
		int nowCount = count;
		String depth = "";
		// depth 1은 사이트 코드
		// depth 2는 대메뉴, 3 중메뉴, 4 소메뉴
		for(int i = 0;i < result.size(); i++){
			MngrMenuVO menuVO = result.get(i);
			depth = menuVO.getMenuDepth();

			if(!"0".equals(menuVO.getMenuUsetype())){
				continue;//메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
			}
			String idName = ""; //left메뉴 선택표시를 위한 아이디설정

			idName = "id=\""+type+"_"+menuVO.getMenuCode()+"\"";
			int menu = count+1;
			if("2".equals(depth)) str += "\n\t<li class=\"menu"+menu+"\">\n\t\t";
			else str += "\n\t<li>\n\t\t";

			str += getMenuLink(menuVO, siteCode, idName);

			if(menuVO.getMngrMenuList() != null){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)
				if(Integer.valueOf(menuVO.getMenuDepth()) >= sDepth  && Integer.valueOf(menuVO.getMenuDepth()) <= eDepth){
					if(menuVO.getMngrMenuList().size() > 0)
						str += recursiveGNB_TYPE_C(menuVO.getMngrMenuList(), siteCode, ++count, type, sDepth, eDepth, menuVO.getMenuName());
				}
			}
			str += "\n\t</li>\n";
		}
		if(nowCount > 0){//처음엔 ul이 필요없음.(코딩에 의한 설정)
			// 서브의 첫번째 메뉴에서 ul을 만들기때문에 depth-1해야 함.
			String dp = "";
			if(!"".equals(depth)) dp = String.valueOf(Integer.parseInt(depth) - 1);
			String tmpStr = "<li class=\"first\">"+menuName+"</li>";
			if("2".equals(dp)) str = "\n<ul class=\"dp"+dp+"\">\n" + tmpStr + str + "</ul>\n";
			else str = "\n<ul class=\"dp"+dp+"\">\n" + str + "</ul>\n";
		}
		return str;
	}

	/**
	 * SNB(LNB) 타입 B 인클루드 재귀호출
	 * @param result
	 * @param siteCode
	 * @param count
	 * @param type
	 * @param sDepth
	 * @param eDepth
	 * @return
	 */
	/*@SuppressWarnings("unchecked")
	private String recursiveSNB_TYPE_B(List<MngrMenuVO> result, String siteCode, int count, String type, int sDepth, int eDepth){
		String str = "";
		int nowCount = count;
		String depth = "";
		for(int i = 0;i < result.size(); i++){
			MngrMenuVO menuVO = result.get(i);
			depth = menuVO.getMenuDepth();

			if(!"0".equals(menuVO.getMenuUsetype())){
				continue;//메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
			}

			String idName = ""; //left메뉴 선택표시를 위한 아이디설정
 			idName = "id=\""+type+"_"+menuVO.getMenuCode()+"\"";

			if(menuVO.getMngrMenuList() != null && menuVO.getMngrMenuList().size() > 0){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)
				str += "<li>\n";
				str += getMenuLink(menuVO, siteCode, idName);
					if(Integer.valueOf(menuVO.getMenuDepth()) >= sDepth  && Integer.valueOf(menuVO.getMenuDepth()) <= eDepth){
						if(menuVO.getMngrMenuList().size() > 0)
							str += recursiveSNB_TYPE_B(menuVO.getMngrMenuList(), siteCode, ++count, type, sDepth, eDepth);
					}
			}else{
				str += "<li>\n";
				str += getMenuLink(menuVO, siteCode, idName);
			}
			str += "</li>\n";
		}
		if(nowCount > 0){//처음엔 ul이 필요없음.(코딩에 의한 설정)
			str = "<ul class=\"{{UL_DEPTH"+depth+"}}\">\n" + str + "</ul>\n";

			String dp = "";
			if(!"".equals(depth)) dp = String.valueOf(Integer.parseInt(depth) - 2);
			if("2".equals(dp) || "3".equals(dp)){
				str = "\n<ul class=\"dp"+dp+"\">\n" + str + "</ul>\n";
				if("2".equals(dp)) {
					str = "<div class=\"sub-tab__smenu\">" + str + "</div>";
				}
			}else{
				str = "\n<ul0>\n" + str + "</ul>\n";
			}
		}
		return str;
	}*/
	@SuppressWarnings("unchecked")
	private String recursiveSNB_TYPE_B(List<MngrMenuVO> result, String siteCode, int count, String type, int sDepth, int eDepth){
		String str = "";
		int nowCount = count;
		String depth = "";
		for(int i = 0;i < result.size(); i++){
			MngrMenuVO menuVO = result.get(i);
			depth = menuVO.getMenuDepth();

			if(!"0".equals(menuVO.getMenuUsetype())){
				continue;//메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
			}

			String idName = ""; //left메뉴 선택표시를 위한 아이디설정
 			idName = "id=\""+type+"_"+menuVO.getMenuCode()+"\"";

			if(menuVO.getMngrMenuList() != null && menuVO.getMngrMenuList().size() > 0){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)

				if ("3".equals(depth)) {
					str += "<li>\n";
				} else if ("4".equals(depth)) {
					str += "<div class=\"dep5_menu\">\n";
				}

				str += getMenuLink(menuVO, siteCode, idName);
					if(Integer.valueOf(menuVO.getMenuDepth()) >= sDepth  && Integer.valueOf(menuVO.getMenuDepth()) <= eDepth){
						if(menuVO.getMngrMenuList().size() > 0)
							str += recursiveSNB_TYPE_B(menuVO.getMngrMenuList(), siteCode, ++count, type, sDepth, eDepth);
					}
			}else{
				if ("3".equals(depth)) {
					str += "<li>\n";
				} else if ("4".equals(depth)) {
					str += "<div class=\"dep5_menu\">\n";
				}
				str += getMenuLink(menuVO, siteCode, idName);
			}

			if ("3".equals(depth)) {
				str += "</li>\n";
			} else if ("4".equals(depth)) {
				str += "</div>\n";
			}
		}
		if(nowCount > 0){//처음엔 ul이 필요없음.(코딩에 의한 설정)

			if("4".equals(depth)){
				str = "<div class=\"sub-tab__smenu\"><div class=\"slide\"><div class=\"depth5Menu_list\">" + str +"</div></div></div>";
			}
		}

		return str;
	}


	/**
	 * 사이트맵 인클루드 재귀 함수
	 * @param result
	 * @param siteCode
	 * @param count
	 * @param type
	 * @param sDepth
	 * @param eDepth
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String recursiveSitemap(List<MngrMenuVO> result, String siteCode, int count, String type, int sDepth, int eDepth){
		String str = "";
		int nowCount = count;
		String depth = "";
		for(int i = 0;i < result.size(); i++){
			MngrMenuVO menuVO = result.get(i);
			depth = menuVO.getMenuDepth();


			if(!"0".equals(menuVO.getMenuUsetype())  ){
				// 회원서비스, 공동프로그램이 아닌 메뉴만 제거 함.
				if(!"Service".equals(menuVO.getMenuCode()) && !"total-search".equals(menuVO.getMenuCode()))
					continue;//메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
			}


			String className = "";//css class 적용을 위한 설정
			String idName = ""; //left메뉴 선택표시를 위한 아이디설정

			idName = "id=\""+type+"_"+menuVO.getMenuCode()+"\"";

			str += "<li>\n";
			if("2".equals(depth)){
				str += "<h3>"+menuVO.getMenuName()+"</h3>";
			}else{
				str += getMenuLink(menuVO, siteCode, idName);
			}

			if(menuVO.getMngrMenuList() != null){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)
					if(Integer.valueOf(menuVO.getMenuDepth()) >= sDepth  && Integer.valueOf(menuVO.getMenuDepth()) <= eDepth){
//						if(menuVO.getMngrMenuList().size() > 0 && !"Guidance".equals(menuVO.getMenuPcode())) // 하위 메뉴가 있으면 재귀호출. (사업안내는 2depth까지만 출력)
						if(menuVO.getMngrMenuList().size() > 0) // 하위 메뉴가 있으면 재귀호출. (사업안내는 2depth까지만 출력)
							str += recursiveSitemap(menuVO.getMngrMenuList(), siteCode, ++count, type, sDepth, eDepth);
					}
			}
			str += "</li>\n";
		}
		if(nowCount > 0){//처음엔 ul이 필요없음.(코딩에 의한 설정)
			String dp = "";
			if(!"".equals(depth)) dp = String.valueOf(Integer.parseInt(depth) - 1);
			if("2".equals(dp)){
				str = "<ul class=\"depth2__list\">\n" + str + "</ul>\n";
			}else if("3".equals(dp)){
				str = "<ul class=\"depth3__list\">\n" + str + "</ul>\n";
			}else if("4".equals(dp)){
				str = "<ul class=\"depth4_list\">\n" + str + "</ul>\n";
			}
		}
		return str;
	}

	private String getMenuLink(MngrMenuVO menuVO, String siteCode, String idName){
		String url = "#none"; //구분값이 0,1,2,3,4,7 가 아니면 링크 없음.(5:컨텐츠없음,6:리비전컨텐츠)
		String str = "";
		// 메뉴타입에 따른 링크 구분
		//0 폴더, 4 링크 menuVO.getMenuUrl 로 링크
		if("0".equals(menuVO.getMenuType())
			|| "4".equals(menuVO.getMenuType())
				){
			url = menuVO.getMenuUrl();
		}else if("1".equals(menuVO.getMenuType()) //CMS /web/contents/코드로 링크
				|| "2".equals(menuVO.getMenuType()) //프로그램 /web/contents/코드로 링크
				|| "3".equals(menuVO.getMenuType()) //게시판 /web/contents/코드로 링크
				//||  "7".equals(menuVO.getMenuType()) // 인클루드링크 /web/contents/코드로 링크 - 3.07주소체계변경으로 인한 미사용처리
				){
			url = "/" + siteCode+"/contents/"+menuVO.getMenuCode()+".do";
		}
		if("".equals(url)) url = "#none";
		String className = ""; //모바일에서 서브목록이 있으면 a태그에 class all_menu_dep3_open 추가
		/*if(("3".equals(menuVO.getMenuDepth()) || "4".equals(menuVO.getMenuDepth())) && menuVO.getSubMenuList() != null && menuVO.getMngrMenuList().size() > 0) {
			int tmpDepth = Integer.parseInt(menuVO.getMenuDepth());
			//if(!"Guidance".equals(menuVO.getMenuPcode()))
			className = "class=\"gnb_dep" + tmpDepth + "_open\"";
		}*/

		if(("3".equals(menuVO.getMenuDepth())) && menuVO.getSubMenuList() != null && menuVO.getMngrMenuList().size() > 0) {
		int tmpDepth = Integer.parseInt(menuVO.getMenuDepth());
		//if(!"Guidance".equals(menuVO.getMenuPcode()))
		className = "class=\"gnb_dep" + tmpDepth + "_open\"";
		}


		if("0".equals(menuVO.getMenuShowtype())){
			if (url.contains("Business54")||url.contains("mypage-qna")||url.contains("mypage-clean")||url.contains("notice35")) {
				str += "<a href='"+url+"' "+idName+" "+className+">";
			}else{
				str += "<a href='"+url+"' "+idName+" "+className+">";
			}

		}else if("1".equals(menuVO.getMenuShowtype())){
			str += "<a href='"+url+"' target='_blank' title='"+menuVO.getMenuName()+" 바로가기 [새창으로 열림]' "+idName+" "+className+">";
		}else if("2".equals(menuVO.getMenuShowtype())){
			str += "<a href='#none' onclick='fnObj.modalOpen(\""+url+"\");return false;' "+idName+" "+className+">";
		}
		// woonee 2020-04-23 메뉴상2, 3depth(table은 3,4)  a태그의 텍스트에 span적용
		if("3".equals( menuVO.getMenuDepth() ) || "4".equals( menuVO.getMenuDepth() ) ) {
			str += "<span>" + menuVO.getMenuName().replaceAll("&", "&amp;") + "</span>";
		} else {
			str += menuVO.getMenuName().replaceAll("&", "&amp;") ;
		}
		str += "</a>";

		return str;
	}

	@RequestMapping(value="/_mngr_/contents/{menuCode}_view.do")
	public String contentsView(@PathVariable("menuCode") String menuCode, @ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		MngrMenuVO result = mngrMenuService.mngrMenuContentsView(mngrMenuVO);
		//mngrMenuVO.setMenuCode(mngrMenuVO.getId());
    	mngrMenuVO.setRegmemid(((MngrSessionVO)request.getSession().getAttribute("mngrSessionVO")).getId());

		String revision = request.getParameter("revision");
		if (revision != null && !"".equals(revision)) {
			result = mngrMenuService.selectRevisionByIdx(revision, menuCode);
			result.setMenuType("revision");
			model.addAttribute("isRevision", true);
		}

		MngrMenuVO tempSaved = mngrMenuService.getTemporarySaved(mngrMenuVO);
		model.addAttribute("tempSaved", tempSaved);
		model.addAttribute("result", result);
		model.addAttribute("menuCode", mngrMenuVO.getMenuCode());

		return "itgcms/mngr/menu/mngcontents_view_edit";
	}

	@RequestMapping(value="/_mngr_/menu/{menuCode}_comm_defaultView.do")
	public String mngrContentsView(@ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		MngrMenuVO result = mngrMenuService.mngrMenuContentsView(mngrMenuVO);
		model.addAttribute("result",result);
		return "itgcms/mngr/menu/mngcontents_view_nomng";
	}

	@RequestMapping(value="/_mngr_/contents/{menuCode}_input_proc.do")
	public String contentsInputProc(@ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {

		mngrMenuVO.setDelyn("N");
		mngrMenuVO.setRegmemid(CommUtil.getMngrMemId());
		mngrMenuVO.setMenuContents(CommUtil.decodeHTMLTagFilter(mngrMenuVO.getMenuContents()));
		mngrMenuService.insertMenuContentsProc(mngrMenuVO);
		return CommUtil.doComplete(model, "완료", "저장되었습니다.", "location.href='/_mngr_/contents/" + mngrMenuVO.getMenuCode() + "_view.do'");
	}

	@RequestMapping(value="/_mngr_/contents/{menuCode}_edit_proc.do")
	public String contentsEditProc(@ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {

		mngrMenuVO.setDelyn("N");
		mngrMenuVO.setRegmemid(CommUtil.getMngrMemId());
		mngrMenuVO.setMenuContents(CommUtil.decodeHTMLTagFilter(mngrMenuVO.getMenuContents()));
		mngrMenuService.insertMenuContentsProc(mngrMenuVO);
		return CommUtil.doComplete(model, "완료", "저장되었습니다.", "location.href='/_mngr_/contents/" + mngrMenuVO.getMenuCode() + "_view.do'");
	}


	@RequestMapping(value="/_mngr_/menu/{menuCode}_comm_mngrMenuTree.ajax")
	@ResponseBody
	public List<ItgMap> mngrMenuTreeList(HttpSession session, @RequestParam(value="siteCode", required=false) String siteCode)    throws IOException, SQLException, RuntimeException {
		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		String mngId = mngrSessionVO.getId();
		ItgMap param = new ItgMap();
		param.put("mngId", mngId);
		param.put("siteCode", siteCode);

		List<ItgMap> result = null;
		if(!mngrSessionVO.getMngAuth().equals("99")){
			result = mngrMenuService.mngrMenuTreeList(param);
		}else {
			result = mngrMenuService.commTreemenuList(param);
		}
		return result;
	}


	@RequestMapping(value = "/_mngr_/contents/{menuCode}_delete_revision_proc.do")
	public String mngrDeleteContentsRevision(@ModelAttribute("searchVO") MngrMenuVO searchVO, @PathVariable("menuCode") String menuCode, ModelMap model, HttpServletRequest request, HttpSession session) throws IOException, SQLException, RuntimeException {

		String[] delIdxArr = request.getParameterValues("chkId");
		searchVO.setRegmemid(CommUtil.getMngrMemId());
		searchVO.setMenuCode(menuCode);
		searchVO.setDelIdxArr(delIdxArr);

		mngrMenuService.deleteRevision(searchVO, delIdxArr);

		return CommUtil.doComplete(model, "완료", "성공적으로 삭제 되었습니다.", "location.href='/_mngr_/contents/"+ menuCode + "_list_revision.do?" + searchVO.getQuery()+ "'");
	}


    @RequestMapping(value="/common/sendSatis.do")
    public ModelAndView sendSatis(@ModelAttribute("mngrMenuSatisfactionVO") MngrMenuSatisfactionVO mngrMenuSatisfactionVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException{
    	HashMap<String,String> hm = new HashMap<String,String>();

    	mngrMenuSatisfactionVO.setId(CommUtil.getUserMemId());
    	mngrMenuSatisfactionVO.setIp(CommUtil.getClientIP(request));

    	MngrMenuSatisfactionVO resultMenuSatisfactionVO = mngrMenuService.selectMngrMenuSatisfactionView(mngrMenuSatisfactionVO);
    	hm.put("result", "0");
    	hm.put("message", "이미 해당 페이지 만족도에 의견을 남기셨습니다.");
    	if(resultMenuSatisfactionVO == null){
    		mngrMenuService.insertMngrMenuSatisfaction(mngrMenuSatisfactionVO);
    		hm.put("result", "1");
    		hm.put("message", "의견을 남겨주셔서 감사합니다.");
    	}
		return new ModelAndView("jsonView", hm);
    }

    @RequestMapping(value="/_mngr_/contents/contents_comm_temporarySave_proc.do")
    @ResponseBody
    public Map<String, Object> contentsTemporarySaveProc(@ModelAttribute("mngrMenuVO") MngrMenuVO mngrMenuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

    	Map<String, Object> resultMap = new HashMap<>();

    	mngrMenuVO.setDelyn("T");
		mngrMenuVO.setRegmemid(CommUtil.getMngrMemId());
		mngrMenuVO.setMenuContents(CommUtil.decodeHTMLTagFilter(mngrMenuVO.getMenuContents()));

		mngrMenuService.mngrInsertMenuTempContents(mngrMenuVO);

    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	resultMap.put("date", formatter.format(new Date()));
    	resultMap.put("contents", mngrMenuVO.getMenuContents());

    	return resultMap;
    }

    @RequestMapping(value="/_mngr_/contents/{menuCode}_list_revision.do")
    public String revisionListPage(@PathVariable("menuCode") String menuCode, @ModelAttribute("searchVO") MngrMenuVO searchVO, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException {

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
		searchVO.setId("");
		searchVO.setRegmemid((CommUtil.getMngrSessionVO()).getId());

		int totCnt = mngrMenuService.mngrCountRevisionList(searchVO);
		List<MngrMenuVO> revisionList = mngrMenuService.selectRevisionList(searchVO);

		for (MngrMenuVO vo : revisionList) {
			vo.setMenuMemo(vo.getMenuMemo().replaceAll("\\n", " ").replaceAll("\\r", ""));
		}
		searchVO.setId(searchVO.getMenuCode());
		String currentNum = mngrMenuService.mngrMenuContentsView(searchVO).getId();
		String returnScript = "";
		if ("redir".equals(currentNum)) {
			returnScript = "location.href='/_mngr_/contents/"+menuCode+"_view.do'";
			return CommUtil.doComplete(model, "데이터없음", "리비전 데이터가 없습니다.",returnScript);
		}

		model.addAttribute("resultList", revisionList);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("currentNum", currentNum);
		model.addAttribute("schStr", searchVO.getSchStr());
		model.addAttribute("menuCode", searchVO.getMenuCode());
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

    	return "itgcms/mngr/menu/mngcontents_list_revision";
    }

    @RequestMapping(value="/{root}/contents/{code}_view_preview.do")
    public String revisionPreview(HttpSession session, ModelMap model, @PathVariable("code") String code, @ModelAttribute MngrMenuVO menuVO) throws IOException, SQLException, RuntimeException{

    	menuVO.setRegmemid(((MngrSessionVO) session.getAttribute("mngrSessionVO")).getId());

    	try {
    		Integer.parseInt(code);
    		model.addAttribute("result", mngrMenuService.selectRevisionByIdx(code, "").getMenuContents());
    	}catch(NumberFormatException e) {
    		menuVO.setMenuCode(code);
        	model.addAttribute("result", mngrMenuService.getTemporarySaved(menuVO).getMenuContents());
    	}

    	return "itgcms/mngr/menu/mngcontents_view_revision";
    }

	public String  mngMenuCreateFile(String siteCode)    throws IOException, SQLException, RuntimeException {

		String result = "";

		return result;
	}

	@RequestMapping(value = "/_mngr_/menu/menu_comm_changeMngSite_proc.do")
	public String menuChangeMngSite(@RequestParam Map<String, Object> currSiteMap, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException {

		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		mngrSessionVO.setSiteChangeYn("Y");
		mngrSessionVO.setCurrSiteCode(CommUtil.isNull(currSiteMap.get("siteCode"), ""));
		mngrSessionVO.setCurrSiteName(CommUtil.isNull(currSiteMap.get("siteName"), ""));

		return "redirect:/_mngr_/main/index.do";

	}

}
