package egovframework.itgcms.module.board.web;


import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.board.service.BoardAuthVO;
import egovframework.itgcms.core.board.service.BoardSearchVO;
import egovframework.itgcms.core.board.service.BoardService;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigService;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigVO;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.manager.service.MngrManagerService;
import egovframework.itgcms.module.board.web.service.BdArticleService;
import egovframework.itgcms.module.jfile.service.JFileDetails;
import egovframework.itgcms.module.jfile.service.JFileService;
import egovframework.itgcms.module.jfile.service.impl.JFileVO;
import egovframework.itgcms.module.socialmedia.service.SocialmediaService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.itgcms.util.JsonUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


/**
 * @파일명 : BoardController.java
 * @파일정보 : 게시판 컨텐츠 관리
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
public class BoardController {


	/** SpBussinessService *//*
	@Resource(name = "spBussinessService")
	private SpBussinessService spBussinessService;*/

	/** BoardconfigService */
	@Resource(name = "mngrBoardconfigService")
	private MngrBoardconfigService mngrBoardconfigService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** mngrCodeService */
    @Resource(name = "mngrCodeService")
    private MngrCodeService mngrCodeService;

	/** mngrCodeService */
    @Resource(name = "mngrManagerService")
    private MngrManagerService mngrManagerService;

    /** socialmediaService */
    @Resource(name="socialmediaService")
    private SocialmediaService socialmediaService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	@Autowired
	private JFileService jfileService;

	/** BoardService */
	@Resource(name = "boardService")
	private BoardService boardService;

	/** BdArticleService */
	@Resource(name = "bdArticleService")
	private BdArticleService bdArticleService;


	private static final Logger LOGGER = LogManager.getLogger(BoardController.class);



	/**
	 * 게시판 목록 페이지 조회
	 * @param root
	 * @param bcid
	 * @param boardSearchVO
	 * @param boardMap
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 * @throws NoSuchAlgorithmException
	 */
	@RequestMapping(value = "/{root}/board/{menuCode}_list_{bcid}.do")
	public String boardList(@PathVariable String root,
						@PathVariable String menuCode,
						@PathVariable String bcid,
						@ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO,
						@ModelAttribute("boardMap") ItgMap boardMap,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException {
		boardMap = CommUtil.getParameterEMap(request);

		if(!CommUtil.regEx("(user|_mngr_)", root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		/*게시판 환경설정 조회*/
		MngrBoardconfigVO mngrBoardconfigVO = new MngrBoardconfigVO();
		mngrBoardconfigVO.setId(bcid);
    	mngrBoardconfigVO = mngrBoardconfigService.selectMngrBoardconfigView(mngrBoardconfigVO);
    	if(mngrBoardconfigVO == null){
    		return CommUtil.doComplete(model, "오류", "게시판 정보가 없습니다. 다시 시도하세요.", "history.back();   ");
    	}

		/*로그인 유저 정보*/
    	String userId = "";
    	String groupCode = "";
    	String mngAuth = "";
    	String siteCode = "";

    	if("user".equals(root)){
    		siteCode 	= CommUtil.isNull(request.getParameter("siteCode"),"");
    		userId 		= (CommUtil.getUserSessionVO() == null)? "" : CommUtil.getUserSessionVO().getId();
    	}else{
    		siteCode 	= (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getCurrSiteCode();
    		userId 		= (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getId();
    		groupCode 	= (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getGroup();
    		mngAuth 	= (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getMngAuth();
    	}

    	/* 사용자 게시판 접근 제어 S #######################################################################
    	 *  MngrBoardController.java > getUserAuthList 메소드에서 권한 확인
    	 *  비회원 100 / 회원 200 / 작성자 210 / 권한없음 900
    	 ####################################################################### */
    	BoardAuthVO boardAuthVO = new BoardAuthVO();
    	if("user".equals(root)){// 사용자 영역 접근

    		boardAuthVO = setUserAuth(mngrBoardconfigVO, userId, "");

    		//목록 권한 체크
    		if(mngrBoardconfigVO.getBcList().startsWith("2") && !CommUtil.isUserLogin()) {
    			String loginPageUrl = "/"+siteCode+"/contents/"+CommUtil.getSiteconfigVO(siteCode).getLoginMenuCode()+".do"; //TODO 로그인페이지 수정
    			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?", "location.href='"+loginPageUrl+"'", "history.back();");
    		}

    		if(!boardAuthVO.isList()) return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");

    	}else{ // 관리자 영역 접근 (권한관리에서 따로 설정 예정)
    		if(!"99".equals(mngAuth)) {
    			EgovMap authInfo = CommUtil.getMngrSessionVO().getMngMenuAuth(menuCode);
    			boardAuthVO.setDelete("Y".equals(authInfo.get("authD")));
    			boardAuthVO.setList("Y".equals(authInfo.get("authR")));
    			boardAuthVO.setRegist("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setReply("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setUpdate("Y".equals(authInfo.get("authU")));
    			boardAuthVO.setView("Y".equals(authInfo.get("authR")));
    		}else {
    			boardAuthVO.setDelete(true);
    			boardAuthVO.setList(true);
    			boardAuthVO.setRegist(true);
    			boardAuthVO.setReply(true);
    			boardAuthVO.setUpdate(true);
    			boardAuthVO.setView(true);
    		}
    	}
    	/* 사용자 게시판 접근 제어 E ####################################################################### */

 		boolean isMobile = CommUtil.isMobile(request);

		model.addAttribute("menuCode", menuCode);
		model.addAttribute("siteCode", siteCode);
		model.addAttribute("isMobile", isMobile);
		model.addAttribute("bcid", bcid);
		model.addAttribute("boardAuthVO", boardAuthVO);

		//지원사업
		mngrBoardconfigVO.setBcKoglyn(menuCode);

    	/* 검색조건 값 설정  S*/
    	boardSearchVO.setSiteCode(siteCode);
    	boardSearchVO.setSchM(CommUtil.isNull(boardSearchVO.getSchM(), mngrBoardconfigVO.getBcDefaultpage()));
    	boardSearchVO.setSchBcid(bcid); // 게시판 아이디
    	boardSearchVO.setRoot(root); // 사용영역(사용자, 관리자 : user, _mngr_)
    	boardSearchVO.setMngrBoardconfigVO(mngrBoardconfigVO);
    	boardSearchVO.setSchRegmemid(userId);
    	boardSearchVO.setSchGroupCode(groupCode);
    	boardSearchVO.setSchMngAuth(mngAuth);

    	boardMap.put("schBcid",bcid);//게시판아이디
    	boardMap.put("root",root); // 사용영역(사용자, 관리자 : user, _mngr_)
    	boardMap.put("mngrBoardconfigVO",mngrBoardconfigVO);
    	boardMap.put("schRegmemid",userId);
    	boardMap.put("schGroupCode",groupCode);
    	boardMap.put("schMngAuth",mngAuth);

    	String returnPage = "";
		returnPage = getReturnPage(mngrBoardconfigVO.getBcSkin(), boardSearchVO.getRoot(), "list");
		return boardService.selectBoardList(model, mngrBoardconfigVO, boardSearchVO, boardMap, request, response, returnPage);
	}


	/**
	 * 게시판 등록 페이지 조회
	 * @param root
	 * @param bcid
	 * @param boardSearchVO
	 * @param boardMap
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 * @throws NoSuchAlgorithmException
	 */
	@RequestMapping(value = "/{root}/board/{menuCode}_input_{bcid}.do")
	public String boardInput(@PathVariable String root,
						@PathVariable String menuCode,
						@PathVariable String bcid,
						@ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException, ParseException{


		if(!CommUtil.regEx("(user|_mngr_)", root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		/*게시판 환경설정 조회*/
		MngrBoardconfigVO mngrBoardconfigVO = new MngrBoardconfigVO();
		mngrBoardconfigVO.setId(bcid);
    	mngrBoardconfigVO = mngrBoardconfigService.selectMngrBoardconfigView(mngrBoardconfigVO);
    	if(mngrBoardconfigVO == null){
    		return CommUtil.doComplete(model, "오류", "게시판 정보가 없습니다. 다시 시도하세요.", "history.back();   ");
    	}

    	/*로그인 유저 정보*/
    	String userId = "";
    	String groupCode = "";
    	String mngAuth = "";

    	if("user".equals(root)){
    		userId = (CommUtil.getUserSessionVO() == null)? "" : CommUtil.getUserSessionVO().getId();
    	}else{
    		userId = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getId();
    		groupCode = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getGroup();
    		mngAuth = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getMngAuth();
    	}

    	/* 사용자 게시판 접근 제어 S #######################################################################
    	 *  MngrBoardController.java > getUserAuthList 메소드에서 권한 확인
    	 *  비회원 100 / 회원 200 / 작성자 210 / 권한없음 900
    	 ####################################################################### */
    	BoardAuthVO boardAuthVO = new BoardAuthVO();
    	String siteCode = CommUtil.isNull(request.getParameter("siteCode"),"");

    	if("user".equals(root)){// 사용자 영역 접근

    		boardAuthVO = setUserAuth(mngrBoardconfigVO, userId, "");

    		//글쓰기 권한 설정
    		if(mngrBoardconfigVO.getBcRegist().startsWith("2") && !CommUtil.isUserLogin()) {
    			String loginPageUrl = "/"+siteCode+"/contents/"+CommUtil.getSiteconfigVO(siteCode).getLoginMenuCode()+".do"; //TODO 로그인페이지 수정
    			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?", "location.href='"+loginPageUrl+"'", "history.back();");
    		}

    		if(!boardAuthVO.isRegist()) return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");

    	}else{ // 관리자 영역 접근 (권한관리에서 따로 설정 예정)
    		if(!"99".equals(mngAuth)) {
    			EgovMap authInfo = CommUtil.getMngrSessionVO().getMngMenuAuth(menuCode);
    			boardAuthVO.setDelete("Y".equals(authInfo.get("authD")));
    			boardAuthVO.setList("Y".equals(authInfo.get("authR")));
    			boardAuthVO.setRegist("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setReply("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setUpdate("Y".equals(authInfo.get("authU")));
    			boardAuthVO.setView("Y".equals(authInfo.get("authR")));
    		}else {
    			boardAuthVO.setDelete(true);
    			boardAuthVO.setList(true);
    			boardAuthVO.setRegist(true);
    			boardAuthVO.setReply(true);
    			boardAuthVO.setUpdate(true);
    			boardAuthVO.setView(true);
    		}
    	}
    	/* 사용자 게시판 접근 제어 E ####################################################################### */

 		boolean isMobile = CommUtil.isMobile(request);

 		model.addAttribute("menuCode", menuCode);
		model.addAttribute("siteCode", siteCode);
		model.addAttribute("isMobile", isMobile);
		model.addAttribute("bcid", bcid);
		model.addAttribute("boardAuthVO", boardAuthVO);

    	/* 검색조건 값 설정  S*/
    	boardSearchVO.setSiteCode(siteCode);
    	boardSearchVO.setSchM(CommUtil.isNull(boardSearchVO.getSchM(), mngrBoardconfigVO.getBcDefaultpage()));
    	boardSearchVO.setSchBcid(bcid); // 게시판 아이디
    	boardSearchVO.setRoot(root); // 사용영역(사용자, 관리자 : user, _mngr_)
    	boardSearchVO.setMngrBoardconfigVO(mngrBoardconfigVO);
    	boardSearchVO.setSchRegmemid(userId);
    	boardSearchVO.setSchGroupCode(groupCode);
    	boardSearchVO.setSchMngAuth(mngAuth);

    	//socialmediaService.getSocialMediaUsingKeys(model);

    	String returnPage = "";
    	returnPage = getReturnPage(mngrBoardconfigVO.getBcSkin(), boardSearchVO.getRoot(), "user".equals(root)?"regist":"view");//등록페이지, 관리자는 view를 공통으로 사용함
    	return boardService.selectBoardRegist(model, mngrBoardconfigVO, boardSearchVO, request, response, returnPage); //"itgcms/global/board/board";

	}


	/**
	 * 게시판 상세 페이지 조회
	 * @param root
	 * @param bcid
	 * @param boardSearchVO
	 * @param boardMap
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 * @throws NoSuchAlgorithmException
	 */
	@RequestMapping(value = "/{root}/board/{menuCode}_view_{bcid}.do")
	public String boardView(@PathVariable String root,
						@PathVariable String menuCode,
						@PathVariable String bcid,
						@ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO,
						@ModelAttribute("boardMap") ItgMap boardMap,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException, ParseException  {
		boardMap = CommUtil.getParameterEMap(request);

		if(!CommUtil.regEx("(user|_mngr_)", root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		/*게시판 환경설정 조회*/
		MngrBoardconfigVO mngrBoardconfigVO = new MngrBoardconfigVO();
		mngrBoardconfigVO.setId(bcid);
    	mngrBoardconfigVO = mngrBoardconfigService.selectMngrBoardconfigView(mngrBoardconfigVO);
    	if(mngrBoardconfigVO == null){
    		return CommUtil.doComplete(model, "오류", "게시판 정보가 없습니다. 다시 시도하세요.", "history.back();   ");
    	}

		/* 게시글 등록정보 */
    	String boardId ="";   //게시글 아이디
    	String regMemId = ""; //게시글 등록자 아이디
    	String ownId = ""; //게시글 연관 아이디(답변글 조회 권한을 위한 추가)
    	String isSecret = ""; //게시글 비밀글 YN
    	String bdPasswd = ""; //게시글 비밀번호

		boardId = CommUtil.isNull(boardSearchVO.getId(), "");

    	if(!"".equals(boardId)){

    		boardSearchVO.setSchBcid(bcid); // 게시판 아이디
    		ItgMap boardRegInfo= boardService.getBoardRegInfo(boardSearchVO);

    		if(boardRegInfo == null){
    			return CommUtil.doComplete(model, "오류", "데이터가 없습니다. 이미 삭제되었거나 잘못된 접속경로입니다.", "history.back()");
    		}
    		regMemId = CommUtil.isNull(boardRegInfo.get("regmemid"), "");
    		ownId = CommUtil.isNull(boardRegInfo.get("ownId"), "");
    		isSecret = CommUtil.isNull(boardRegInfo.get("bdSecret"), "");
    		bdPasswd = CommUtil.isNull(boardRegInfo.get("bdPasswd"), "");
    	}

    	/*로그인 유저 정보*/
		String userId = "";
    	String groupCode = "";
    	String mngAuth = "";

    	if("user".equals(root)){
    		userId = (CommUtil.getUserSessionVO() == null)? "" : CommUtil.getUserSessionVO().getId();
    	}else{
    		userId = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getId();
    		groupCode = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getGroup();
    		mngAuth = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getMngAuth();
    	}

    	/* 사용자 게시판 접근 제어 S #######################################################################
    	 *  MngrBoardController.java > getUserAuthList 메소드에서 권한 확인
		 *  비회원 100 / 회원 200 / 작성자 210 / 권한없음 900
    	 ####################################################################### */
    	BoardAuthVO boardAuthVO = new BoardAuthVO();
    	String siteCode = CommUtil.isNull(request.getParameter("siteCode"),"");

    	if("user".equals(root)){// 사용자 영역 접근

    		boardAuthVO = setUserAuth(mngrBoardconfigVO, userId, ownId);

    		//조회 권한 설정
    		if("200".equals(mngrBoardconfigVO.getBcView()) && !CommUtil.isUserLogin()){
    			String loginPageUrl = "/"+siteCode+"/contents/"+CommUtil.getSiteconfigVO(siteCode).getLoginMenuCode()+".do"; //TODO 로그인페이지 수정
				return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?", "location.href='"+loginPageUrl+"'", "history.back();");
			}

    		if(!boardAuthVO.isView()) return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");

    	}else{ // 관리자 영역 접근 (권한관리에서 따로 설정 예정)
    		if(!"99".equals(mngAuth)) {
    			EgovMap authInfo = CommUtil.getMngrSessionVO().getMngMenuAuth(menuCode);
    			boardAuthVO.setDelete("Y".equals(authInfo.get("authD")));
    			boardAuthVO.setList("Y".equals(authInfo.get("authR")));
    			boardAuthVO.setRegist("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setReply("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setUpdate("Y".equals(authInfo.get("authU")));
    			boardAuthVO.setView("Y".equals(authInfo.get("authR")));
    		}else {
    			boardAuthVO.setDelete(true);
    			boardAuthVO.setList(true);
    			boardAuthVO.setRegist(true);
    			boardAuthVO.setReply(true);
    			boardAuthVO.setUpdate(true);
    			boardAuthVO.setView(true);
    		}
    	}
    	/* 사용자 게시판 접근 제어 E ####################################################################### */

    	boolean isMobile = CommUtil.isMobile(request);

		model.addAttribute("menuCode", menuCode);
		model.addAttribute("siteCode", siteCode);
		model.addAttribute("isMobile", isMobile);
		model.addAttribute("bcid", bcid);
		model.addAttribute("boardAuthVO", boardAuthVO);

		boardSearchVO.setRoot(root); // 사용영역(사용자, 관리자 : user, _mngr_)
		boardSearchVO.setMngrBoardconfigVO(mngrBoardconfigVO);
		boardSearchVO.setSchRegmemid(userId);
		boardSearchVO.setSchGroupCode(groupCode);
		boardSearchVO.setSchMngAuth(mngAuth);

		/* 검색조건 값 설정  S*/
    	boardSearchVO.setSiteCode(siteCode);
    	if("faq".equals(mngrBoardconfigVO.getBcSkin()) && "user".equals(root)){
    		boardSearchVO.setSchM("list");
    	}else {
    		boardSearchVO.setSchM(CommUtil.isNull(boardSearchVO.getSchM(), mngrBoardconfigVO.getBcDefaultpage()));
    	}

    	/*비밀글 처리 */
    	if ("user".equals(boardSearchVO.getRoot())) {

    		//비밀글에 대한 처리(해당 정보가 있는 경우)
    		if("Y".equals(isSecret) && !"".equals(bdPasswd)) {
    			//비밀글이고, 패스워드가 있는 경우, 비로그인 사용자가 쓴 글.
    			if(!CommUtil.hexSha256(CommUtil.isNull(boardMap.get("schSecritPw"),"")).equals(bdPasswd)) {
    				//비밀글의 패스워드가 입력된 패스워드와 다른 경우.
    				model.addAttribute("searchVO", boardSearchVO);
    				return "itgcms/global/board/user_check_pass";
    			}

    		} else if ("Y".equals(isSecret) && "".equals(bdPasswd)) {
    			// 비밀글이고, 패스워드가 없는 경우, 즉 로그인 사용자가 쓴 글.
    			if (!userId.equals(regMemId)) {
    				//글쓴이와 현재 로그인 사용자가 다른경우.
    				return CommUtil.doComplete(model, "오류", "접근 권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
    			}
    		}

    	}

    	boardMap.put("schBcid",bcid);//게시판아이디
    	boardMap.put("root",root); // 사용영역(사용자, 관리자 : user, _mngr_)
    	boardMap.put("mngrBoardconfigVO",mngrBoardconfigVO);
    	boardMap.put("schRegmemid",userId);
    	boardMap.put("schGroupCode",groupCode);
    	boardMap.put("schMngAuth",mngAuth);

		/*첨부파일 리스트*/
		ItgMap fileBoardMap = (ItgMap)model.get("boardMap");
		String fileId = CommUtil.isNull(fileBoardMap.get("fileId"), "");
		if(!"".equals(fileId)) {
			List<JFileVO> fileList = new ArrayList<>();
			List<JFileDetails> tempList= jfileService.getAttachFiles(fileId);
			for (JFileDetails fileVO : tempList) {
				if (fileVO instanceof JFileVO) {
					if("N".equals(CommUtil.isNull(((JFileVO)fileVO).getDeleteYn(), ""))) {

					}
				}
			}
			model.put("fileList", jfileService.getAttachFiles(fileId));
		}

    	String returnPage = getReturnPage(mngrBoardconfigVO.getBcSkin(), boardSearchVO.getRoot(), "view");

		String strReturnValue = boardService.selectBoardView(model, mngrBoardconfigVO, boardSearchVO, boardMap, request, response, returnPage); //"itgcms/global/board/board";
		boardService.modIncreaseReadnum(boardSearchVO); //조회수 증가
   		return strReturnValue;

	}


	/**
	 * 공지사항 상세 페이지 조회
	 * @param root
	 * @param bcid
	 * @param boardSearchVO
	 * @param boardMap
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 * @throws NoSuchAlgorithmException
	 */
	@RequestMapping(value = "/{root}/board/{menuCode}_view_{bcid}_notice.do")
	public String boardViewNotice(@PathVariable String root,
						@PathVariable String menuCode,
						@PathVariable String bcid,
						@ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO,
						@ModelAttribute("boardMap") ItgMap boardMap,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException, ParseException  {
		boardMap = CommUtil.getParameterEMap(request);

		if(!CommUtil.regEx("(user|_mngr_)", root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		String noticeId = request.getParameter("notice");

		/*게시판 환경설정 조회*/
		MngrBoardconfigVO mngrBoardconfigVO = new MngrBoardconfigVO();
		mngrBoardconfigVO.setId(bcid);
    	mngrBoardconfigVO = mngrBoardconfigService.selectMngrBoardconfigView(mngrBoardconfigVO);
    	if(mngrBoardconfigVO == null){
    		return CommUtil.doComplete(model, "오류", "게시판 정보가 없습니다. 다시 시도하세요.", "history.back();   ");
    	}

    	/*로그인 유저 정보*/
		String userId = "";
		String ownId = ""; //게시글 연관 아이디(답변글 조회 권한을 위한 추가)
    	String groupCode = "";
    	String mngAuth = "";

    	if("user".equals(root)){
    		userId = (CommUtil.getUserSessionVO() == null)? "" : CommUtil.getUserSessionVO().getId();
    	}else{
    		userId = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getId();
    		groupCode = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getGroup();
    		mngAuth = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getMngAuth();
    	}

    	/* 사용자 게시판 접근 제어 S #######################################################################
    	 *  MngrBoardController.java > getUserAuthList 메소드에서 권한 확인
		 *  비회원 100 / 회원 200 / 작성자 210 / 권한없음 900
    	 ####################################################################### */
    	BoardAuthVO boardAuthVO = new BoardAuthVO();
    	String siteCode = CommUtil.isNull(request.getParameter("siteCode"),"");

    	if("user".equals(root)){// 사용자 영역 접근

    		boardAuthVO = setUserAuth(mngrBoardconfigVO, userId, ownId);
    		boardAuthVO.setDelete(false);
    		boardAuthVO.setUpdate(false);

    	}else{ // 관리자 영역 접근 (권한관리에서 따로 설정 예정)
    		if(!"99".equals(mngAuth)) {
    			EgovMap authInfo = CommUtil.getMngrSessionVO().getMngMenuAuth(menuCode);
    			boardAuthVO.setDelete("Y".equals(authInfo.get("authD")));
    			boardAuthVO.setList("Y".equals(authInfo.get("authR")));
    			boardAuthVO.setRegist("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setReply("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setUpdate("Y".equals(authInfo.get("authU")));
    			boardAuthVO.setView("Y".equals(authInfo.get("authR")));
    		}else {
    			boardAuthVO.setDelete(true);
    			boardAuthVO.setList(true);
    			boardAuthVO.setRegist(true);
    			boardAuthVO.setReply(true);
    			boardAuthVO.setUpdate(true);
    			boardAuthVO.setView(true);
    		}

    	}
    	/* 사용자 게시판 접근 제어 E ####################################################################### */

    	boolean isMobile = CommUtil.isMobile(request);

		model.addAttribute("menuCode", menuCode);
		model.addAttribute("siteCode", siteCode);
		model.addAttribute("isMobile", isMobile);
		model.addAttribute("bcid", bcid);
		model.addAttribute("boardAuthVO", boardAuthVO);

		boardSearchVO.setRoot(root); // 사용영역(사용자, 관리자 : user, _mngr_)
		boardSearchVO.setMngrBoardconfigVO(mngrBoardconfigVO);
		boardSearchVO.setSchRegmemid(userId);
		boardSearchVO.setSchGroupCode(groupCode);
		boardSearchVO.setSchMngAuth(mngAuth);

		/* 검색조건 값 설정  S*/
    	boardSearchVO.setSiteCode(siteCode);
    	if("faq".equals(mngrBoardconfigVO.getBcSkin()) && "user".equals(root)){
    		boardSearchVO.setSchM("list");
    	}else {
    		boardSearchVO.setSchM(CommUtil.isNull(boardSearchVO.getSchM(), mngrBoardconfigVO.getBcDefaultpage()));
    	}

    	boardMap.put("schBcid",bcid);//게시판아이디
    	boardMap.put("root",root); // 사용영역(사용자, 관리자 : user, _mngr_)
    	boardMap.put("mngrBoardconfigVO",mngrBoardconfigVO);
    	boardMap.put("schRegmemid",userId);
    	boardMap.put("schGroupCode",groupCode);
    	boardMap.put("schMngAuth",mngAuth);

		/*첨부파일 리스트*/
		ItgMap fileBoardMap = (ItgMap)model.get("boardMap");
		String fileId = CommUtil.isNull(fileBoardMap.get("fileId"), "");
		if(!"".equals(fileId)) {
			List<JFileVO> fileList = new ArrayList<>();
			List<JFileDetails> tempList= jfileService.getAttachFiles(fileId);
			for (JFileDetails fileVO : tempList) {
				if (fileVO instanceof JFileVO) {
					if("N".equals(CommUtil.isNull(((JFileVO)fileVO).getDeleteYn(), ""))) {

					}
				}
			}
			model.put("fileList", jfileService.getAttachFiles(fileId));
		}

    	String returnPage = getReturnPage("notice", boardSearchVO.getRoot(), "view");

		String strReturnValue = boardService.selectBoardView(model, mngrBoardconfigVO, boardSearchVO, boardMap, request, response, returnPage); //"itgcms/global/board/board";
		boardService.modIncreaseReadnum(boardSearchVO); //조회수 증가
   		return strReturnValue;

	}

	/**
	 * 게시판 수정페이지 조회
	 * @param root
	 * @param bcid
	 * @param boardSearchVO
	 * @param boardMap
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 * @throws NoSuchAlgorithmException
	 */
	@RequestMapping(value = "/{root}/board/{menuCode}_edit_{bcid}.do")
	public String boardEdit(@PathVariable String root,
						@PathVariable String menuCode,
						@PathVariable String bcid,
						@ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO,
						@ModelAttribute("boardMap") ItgMap boardMap,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException, ParseException  {
		boardMap = CommUtil.getParameterEMap(request);

		if(!CommUtil.regEx("(user|_mngr_)", root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		/*게시판 환경설정 조회*/
		MngrBoardconfigVO mngrBoardconfigVO = new MngrBoardconfigVO();
		mngrBoardconfigVO.setId(bcid);
    	mngrBoardconfigVO = mngrBoardconfigService.selectMngrBoardconfigView(mngrBoardconfigVO);
    	if(mngrBoardconfigVO == null){
    		return CommUtil.doComplete(model, "오류", "게시판 정보가 없습니다. 다시 시도하세요.", "history.back();   ");
    	}

		/* 게시글 등록정보 */
    	String boardId ="";   //게시글 아이디
    	String regMemId = ""; //게시글 등록자 아이디
    	String ownId = ""; //게시글 연관 아이디(답변글 조회 권한을 위한 추가)
    	String isSecret = ""; //게시글 비밀글 YN
    	String bdPasswd = ""; //게시글 비밀번호

    	boardId = CommUtil.isNull(boardSearchVO.getId(), "");
    	if(!"".equals(boardId)){
    		boardSearchVO.setSchBcid(bcid); // 게시판 아이디
    		ItgMap boardRegInfo= boardService.getBoardRegInfo(boardSearchVO);
    		if(boardRegInfo == null){
    			return CommUtil.doComplete(model, "오류", "데이터가 없습니다. 이미 삭제되었거나 잘못된 접속경로입니다.", "history.back()");
    		}

    		regMemId = CommUtil.isNull(boardRegInfo.get("regmemid"), "");
    		ownId 	 = CommUtil.isNull(boardRegInfo.get("ownId"), "");
    		isSecret = CommUtil.isNull(boardRegInfo.get("bdSecret"), "");
    		bdPasswd = CommUtil.isNull(boardRegInfo.get("bdPasswd"), "");
    	}

    	/*로그인 유저 정보*/
		String userId = "";
    	String groupCode = "";
    	String mngAuth = "";

    	if("user".equals(root)){
    		userId = (CommUtil.getUserSessionVO() == null)? "" : CommUtil.getUserSessionVO().getId();
    	}else{
    		userId = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getId();
    		groupCode = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getGroup();
    		mngAuth = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getMngAuth();
    	}

    	/* 사용자 게시판 접근 제어 S #######################################################################
    	 *  MngrBoardController.java > getUserAuthList 메소드에서 권한 확인
		 *  비회원 100 / 회원 200 / 작성자 210 / 권한없음 900
    	 ####################################################################### */
    	BoardAuthVO boardAuthVO = new BoardAuthVO();
    	String siteCode = CommUtil.isNull(request.getParameter("siteCode"),"");

    	if("user".equals(root)){// 사용자 영역 접근

    		boardAuthVO = setUserAuth(mngrBoardconfigVO, userId, ownId);

    		//수정 권한 체크
    		if("200".equals(mngrBoardconfigVO.getBcUpdate()) && !CommUtil.isUserLogin()){
    			String loginPageUrl = "/"+siteCode+"/contents/"+CommUtil.getSiteconfigVO(siteCode).getLoginMenuCode()+".do"; //TODO 로그인페이지 수정
				return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?", "location.href='"+loginPageUrl+"'", "history.back();");
			}

    		if(!boardAuthVO.isUpdate()) return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");

    	}else{ // 관리자 영역 접근 (권한관리에서 따로 설정 예정)
    		if(!"99".equals(mngAuth)) {
    			EgovMap authInfo = CommUtil.getMngrSessionVO().getMngMenuAuth(menuCode);
    			boardAuthVO.setDelete("Y".equals(authInfo.get("authD")));
    			boardAuthVO.setList("Y".equals(authInfo.get("authR")));
    			boardAuthVO.setRegist("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setReply("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setUpdate("Y".equals(authInfo.get("authU")));
    			boardAuthVO.setView("Y".equals(authInfo.get("authR")));
    		}else {
    			boardAuthVO.setDelete(true);
    			boardAuthVO.setList(true);
    			boardAuthVO.setRegist(true);
    			boardAuthVO.setReply(true);
    			boardAuthVO.setUpdate(true);
    			boardAuthVO.setView(true);
    		}
    	}
    	/* 사용자 게시판 접근 제어 E ####################################################################### */

    	boolean isMobile = CommUtil.isMobile(request);

		model.addAttribute("menuCode", menuCode);
		model.addAttribute("siteCode", siteCode);
		model.addAttribute("isMobile", isMobile);
		model.addAttribute("bcid", bcid);
		model.addAttribute("boardAuthVO", boardAuthVO);

		/* 검색조건 값 설정  S*/
    	boardSearchVO.setSiteCode(siteCode);
    	boardSearchVO.setSchM(CommUtil.isNull(boardSearchVO.getSchM(), mngrBoardconfigVO.getBcDefaultpage()));
    	boardSearchVO.setRoot(root); // 사용영역(사용자, 관리자 : user, _mngr_)
    	boardSearchVO.setMngrBoardconfigVO(mngrBoardconfigVO);
    	boardSearchVO.setSchRegmemid(userId);
    	boardSearchVO.setSchGroupCode(groupCode);
    	boardSearchVO.setSchMngAuth(mngAuth);

    	boardMap.put("schBcid",bcid);//게시판아이디
    	boardMap.put("root",root); // 사용영역(사용자, 관리자 : user, _mngr_)
    	boardMap.put("mngrBoardconfigVO",mngrBoardconfigVO);
    	boardMap.put("schRegmemid",userId);
    	boardMap.put("schGroupCode",groupCode);
    	boardMap.put("schMngAuth",mngAuth);

    	/*비밀글 처리 */
		if ("user".equals(boardSearchVO.getRoot())) {
			if(!"".equals(bdPasswd)) {//비로그인 사용자가 쓴 글에 대한 처리
				if(!CommUtil.hexSha256(CommUtil.isNull(boardMap.get("schSecritPw"),"")).equals(bdPasswd)) {
					//비밀글의 패스워드가 입력된 패스워드와 다른 경우.
    				model.addAttribute("searchVO", boardSearchVO);
					return "itgcms/global/board/user_check_pass";
				}
			} else if ("Y".equals(isSecret) && "".equals(bdPasswd)) {// 비밀글이고, 패스워드가 없는 경우, 즉 로그인 사용자가 쓴 글.
				if (!userId.equals(regMemId)) {
					//글쓴이와 현재 로그인 사용자가 다른경우.
					return CommUtil.doComplete(model, "오류", "접근 권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
				}
			}

		}

		/*첨부파일 리스트*/
		ItgMap fileBoardMap = (ItgMap)model.get("boardMap");
		String fileId = CommUtil.isNull(fileBoardMap.get("fileId"), "");
		if(!"".equals(fileId)) {
			List<JFileVO> fileList = new ArrayList<>();
			List<JFileDetails> tempList= jfileService.getAttachFiles(fileId);
			for (JFileDetails fileVO : tempList) {
				if (fileVO instanceof JFileVO) {
					if("N".equals(CommUtil.isNull(((JFileVO)fileVO).getDeleteYn(), ""))) {

					}
				}
			}
			model.put("fileList", jfileService.getAttachFiles(fileId));
		}

    	String returnPage = getReturnPage(mngrBoardconfigVO.getBcSkin(), boardSearchVO.getRoot(), "user".equals(root)?"regist":"view"); //등록페이지, 관리자는 view를 공통으로 사용함
		String strReturnValue = boardService.selectBoardView(model, mngrBoardconfigVO, boardSearchVO, boardMap, request, response, returnPage); //"itgcms/global/board/board";
		boardService.modIncreaseReadnum(boardSearchVO); //조회수 증가
   		return strReturnValue;

	}


	/**
	 * 게시판 답편등록 페이지 조회
	 * @param root
	 * @param bcid
	 * @param boardSearchVO
	 * @param boardMap
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 * @throws NoSuchAlgorithmException
	 */
	@RequestMapping(value = "/{root}/board/{menuCode}_reply_{bcid}.do")
	public String boardReply(@PathVariable String root,
						@PathVariable String bcid,
						@PathVariable String menuCode,
						@ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException {

		if(!CommUtil.regEx("(user|_mngr_)", root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		/*게시판 환경설정 조회*/
		MngrBoardconfigVO mngrBoardconfigVO = new MngrBoardconfigVO();
		mngrBoardconfigVO.setId(bcid);
    	mngrBoardconfigVO = mngrBoardconfigService.selectMngrBoardconfigView(mngrBoardconfigVO);
    	if(mngrBoardconfigVO == null){
    		return CommUtil.doComplete(model, "오류", "게시판 정보가 없습니다. 다시 시도하세요.", "history.back();   ");
    	}

		/*로그인 유저 정보*/
    	String userId = "";
    	String groupCode = "";
    	String mngAuth = "";

    	if("user".equals(root)){
    		userId = (CommUtil.getUserSessionVO() == null)? "" : CommUtil.getUserSessionVO().getId();
    	}else{
    		userId = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getId();
    		groupCode = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getGroup();
    		mngAuth = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getMngAuth();
    	}

    	/* 사용자 게시판 접근 제어 S #######################################################################
    	 *  MngrBoardController.java > getUserAuthList 메소드에서 권한 확인
		 *  비회원 100 / 회원 200 / 작성자 210 / 권한없음 900
    	 ####################################################################### */
    	BoardAuthVO boardAuthVO = new BoardAuthVO();
    	String siteCode = CommUtil.isNull(request.getParameter("siteCode"),"");

    	if("user".equals(root)){// 사용자 영역 접근

    		//답변 권한 설정
    		boardAuthVO = setUserAuth(mngrBoardconfigVO, userId, "");

    		//답변 권한 체크
    		if(mngrBoardconfigVO.getBcReply().startsWith("2") && !CommUtil.isUserLogin()) {
    			String loginPageUrl = "/"+siteCode+"/contents/"+CommUtil.getSiteconfigVO(siteCode).getLoginMenuCode()+".do"; //TODO 로그인페이지 수정
    			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?", "location.href='"+loginPageUrl+"'", "history.back();");
    		}

    		if(!boardAuthVO.isReply()) return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");

    	}else{ // 관리자 영역 접근 (권한관리에서 따로 설정 예정)
    		if(!"99".equals(mngAuth)) {
    			EgovMap authInfo = CommUtil.getMngrSessionVO().getMngMenuAuth(menuCode);
    			boardAuthVO.setDelete("Y".equals(authInfo.get("authD")));
    			boardAuthVO.setList("Y".equals(authInfo.get("authR")));
    			boardAuthVO.setRegist("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setReply("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setUpdate("Y".equals(authInfo.get("authU")));
    			boardAuthVO.setView("Y".equals(authInfo.get("authR")));
    		}else {
    			boardAuthVO.setDelete(true);
    			boardAuthVO.setList(true);
    			boardAuthVO.setRegist(true);
    			boardAuthVO.setReply(true);
    			boardAuthVO.setUpdate(true);
    			boardAuthVO.setView(true);
    		}
    	}
    	/* 사용자 게시판 접근 제어 E ####################################################################### */

 		boolean isMobile = CommUtil.isMobile(request);

		model.addAttribute("menuCode", menuCode);
		model.addAttribute("siteCode", siteCode);
		model.addAttribute("isMobile", isMobile);
		model.addAttribute("bcid", bcid);
		model.addAttribute("boardAuthVO", boardAuthVO);

    	/* 검색조건 값 설정  S*/
    	boardSearchVO.setSiteCode(siteCode);
    	boardSearchVO.setSchM(CommUtil.isNull(boardSearchVO.getSchM(), mngrBoardconfigVO.getBcDefaultpage()));
    	boardSearchVO.setSchBcid(bcid); // 게시판 아이디
    	boardSearchVO.setRoot(root); // 사용영역(사용자, 관리자 : user, _mngr_)
    	boardSearchVO.setMngrBoardconfigVO(mngrBoardconfigVO);
    	boardSearchVO.setSchRegmemid(userId);
    	boardSearchVO.setSchGroupCode(groupCode);
    	boardSearchVO.setSchMngAuth(mngAuth);

    	String returnPage = getReturnPage(mngrBoardconfigVO.getBcSkin(), boardSearchVO.getRoot(), "user".equals(root)?"regist":"view"); //등록페이지, 관리자는 view를 공통으로 사용함
		return boardService.selectBoardReply(model, mngrBoardconfigVO, boardSearchVO, request, response, returnPage); //"itgcms/global/board/board";

	}


	/**
	 * 게시판 등록/수정/답변/삭제 프로세스
	 * @param root
	 * @param bcid
	 * @param boardSearchVO
	 * @param boardMap
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 * @throws NoSuchAlgorithmException
	 */
	@RequestMapping(value = "/{root}/board/{menuCode}_proc_{bcid}.do")
	public String boardProc(@PathVariable String root,
						@PathVariable String menuCode,
						@PathVariable String bcid,
						@ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO,
						@ModelAttribute("boardMap") ItgMap boardMap,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException, ParseException {
		boardMap = CommUtil.getParameterEMap(request);

		if(!CommUtil.regEx("(user|_mngr_)", root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		/*게시판 환경설정 조회*/
		MngrBoardconfigVO mngrBoardconfigVO = new MngrBoardconfigVO();
		mngrBoardconfigVO.setId(bcid);
    	mngrBoardconfigVO = mngrBoardconfigService.selectMngrBoardconfigView(mngrBoardconfigVO);
    	if(mngrBoardconfigVO == null){
    		return CommUtil.doComplete(model, "오류", "게시판 정보가 없습니다. 다시 시도하세요.", "history.back();   ");
    	}

		/*로그인 유저 정보*/
    	String userId = "";
    	String groupCode = "";
    	String mngAuth = "";
    	String siteCode = "";

    	if("user".equals(root)){
    		userId = (CommUtil.getUserSessionVO() == null)? "" : CommUtil.getUserSessionVO().getId();
    		siteCode = CommUtil.isNull(request.getParameter("siteCode"),"");
    	}else{
    		userId = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getId();
    		groupCode = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getGroup();
    		mngAuth = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getMngAuth();
    		siteCode =  CommUtil.getManagerSiteCode(request);
    	}

    	BoardAuthVO boardAuthVO = new BoardAuthVO();
    	if("user".equals(root)){// 사용자 영역 접근
    		//답변 권한 설정
    		boardAuthVO = setUserAuth(mngrBoardconfigVO, userId, "");

    	}else{ // 관리자 영역 접근 (권한관리에서 따로 설정 예정)
    		if(!"99".equals(mngAuth)) {
    			EgovMap authInfo = CommUtil.getMngrSessionVO().getMngMenuAuth(menuCode);
    			boardAuthVO.setDelete("Y".equals(authInfo.get("authD")));
    			boardAuthVO.setList("Y".equals(authInfo.get("authR")));
    			boardAuthVO.setRegist("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setReply("Y".equals(authInfo.get("authC")));
    			boardAuthVO.setUpdate("Y".equals(authInfo.get("authU")));
    			boardAuthVO.setView("Y".equals(authInfo.get("authR")));
    		}else {
    			boardAuthVO.setDelete(true);
    			boardAuthVO.setList(true);
    			boardAuthVO.setRegist(true);
    			boardAuthVO.setReply(true);
    			boardAuthVO.setUpdate(true);
    			boardAuthVO.setView(true);
    		}
    	}



    	/* 검색조건 값 설정  S*/
    	boardSearchVO.setSiteCode(siteCode);
    	boardSearchVO.setSchM(CommUtil.isNull(boardSearchVO.getSchM(), mngrBoardconfigVO.getBcDefaultpage()));
    	boardSearchVO.setSchBcid(bcid); // 게시판 아이디
    	boardSearchVO.setRoot(root); // 사용영역(사용자, 관리자 : user, _mngr_)
    	boardSearchVO.setMngrBoardconfigVO(mngrBoardconfigVO);
    	boardSearchVO.setSchRegmemid(userId);
    	boardSearchVO.setSchGroupCode(groupCode);
    	boardSearchVO.setSchMngAuth(mngAuth);

    	boardMap.put("schBcid",bcid);//게시판아이디
    	boardMap.put("root",root); // 사용영역(사용자, 관리자 : user, _mngr_)
    	boardMap.put("mngrBoardconfigVO",mngrBoardconfigVO);
    	boardMap.put("schRegmemid",userId);
    	boardMap.put("schGroupCode",groupCode);
    	boardMap.put("schMngAuth",mngAuth);
    	//socialmediaService.getSocialMediaUsingKeys(model);

    	/* 기본값 세팅 */
    	boardMap.put("bdSecret",		CommUtil.isNull(boardMap.get("bdSecret")		, "N"));//비밀글여부
    	boardMap.put("bdNotice",		CommUtil.isNull(boardMap.get("bdNotice")		, "0"));//공지여부
    	boardMap.put("bdUseyn",			CommUtil.isNull(boardMap.get("bdUseyn")			, "Y"));//사용여부
    	boardMap.put("bdKogluseyn",		CommUtil.isNull(boardMap.get("bdKogluseyn")		, "N"));//공공누리사용여부
    	boardMap.put("bdNoticeTermyn",	CommUtil.isNull(boardMap.get("bdNoticeTermyn")	, "N"));//공지기간사용여부
    	boardMap.put("bdUseTermyn",		CommUtil.isNull(boardMap.get("bdUseTermyn")		, "N"));//게시기간사용여부
    	boardMap.put("howUpload",		CommUtil.isNull(boardMap.get("howUpload")		, "0"));//동영상업로드방식

    	boardMap.put("howUpload",		CommUtil.isNull(boardMap.get("howUpload")		, "0"));//동영상업로드방식



    	String returnPage = "";

    	String mode = CommUtil.isNull(request.getParameter("mode"),"");

    	String loginPageUrl = "/"+siteCode+"/contents/"+CommUtil.getSiteconfigVO(siteCode).getLoginMenuCode()+".do"; //TODO 로그인페이지 수정

    	String ownId = ""; //게시글 연관 아이디

    	//권한체크
    	if("update".equals(mode)) if(!boardAuthVO.isUpdate()) return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
   		if("insert".equals(mode)) if(!boardAuthVO.isRegist()) return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
		if("reply".equals(mode))  if(!boardAuthVO.isReply())  return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
		if("delete".equals(mode)) if(!boardAuthVO.isDelete()) return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");

    	if("user".equals(root)){
	    	if("update".equals(mode) || "delete".equals(mode)){

	        	if(!"".equals(boardSearchVO.getId())){
	        		ItgMap boardRegInfo= boardService.getBoardRegInfo(boardSearchVO);
	        		if(boardRegInfo == null){
	        			return CommUtil.doComplete(model, "오류", "데이터가 없습니다. 이미 삭제되었거나 잘못된 접속경로입니다.", "history.back()");
	        		}
	        		String checkPassStr = CommUtil.isNull(boardMap.get("bdPasswd"),CommUtil.isNull(boardMap.get("schSecritPw"),""));
	        		String bdPasswd = CommUtil.isNull(boardRegInfo.get("bdPasswd"),"");
	        		//패스워드가 있는 경우, 비로그인 사용자가 쓴 글.
	        		if(!"".equals(bdPasswd)) {
	        			//비밀글의 패스워드가 입력된 패스워드와 다른 경우.
	        			if(CommUtil.empty(checkPassStr)){
	        				return "itgcms/global/board/user_check_pass";
	        			}else if(!CommUtil.hexSha256(checkPassStr).equals(bdPasswd)) {
	        				return CommUtil.doComplete(model, "오류", "패스워드가 일치하지 않습니다.", "history.back()");
	        			}
	        		}
	        		ownId = CommUtil.isNull(boardRegInfo.get("ownId"),"");
	        	}else {
	        		return CommUtil.doComplete(model, "오류", "데이터가 없습니다. 이미 삭제되었거나 잘못된 접속경로입니다.", "history.back()");
	        	}
	    	}
    	}

    	if("insert".equals(mode)){

    		if("user".equals(root)){

    			//글쓰기 권한 설정
    			if(!"100".equals(mngrBoardconfigVO.getBcRegist())){
	    			if(mngrBoardconfigVO.getBcRegist().startsWith("2")){
	    				if(!CommUtil.isUserLogin()) {
	    					return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?", "location.href='"+loginPageUrl+"'", "history.back();");
	    				}
	    			}else {
	    				return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
	    			}
    			}
    		}

			/* ########################################################################
			 * 게시판이 커스텀게시판일 경우 커스텀컬럼(에디터) 데이터 검증
			 * ######################################################################## */
			if("2".equals(mngrBoardconfigVO.getBcType())){
				String resultString = validationCustomColumn(mngrBoardconfigVO, boardMap, model);
				if(CommUtil.notEmpty(resultString)) return resultString;
			}



    		// 등록프로스세스 처리
			String msg = boardService.insertBoardRegistProc(model, mngrBoardconfigVO, boardSearchVO, boardMap, request, response, returnPage);

			// 진흥원소식지
			if ("bpNews".equals(bcid)) {
				boardMap.put("arIdx", CustomUtil.idMake("E"));
				String msg2 = bdArticleService.insertArticleRegistProc(boardMap);

				if(!"".equals(msg2)){
					return CommUtil.doComplete(model, "오류", msg, "history.back();");
				}
			}

			if(!"".equals(msg)){
				return CommUtil.doComplete(model, "오류", msg, "history.back();");
			}

			/*게시판글 외부사이트 포스팅*/
			// boardService.postingSocailMedia(boardMap, boardSearchVO, request);

			String returnScript = "";
			if("user".equals(root)){
				//returnScript = "location.href='?'";
				returnScript = "location.href='/"+siteCode+"/contents/"+menuCode+".do'";
			}else{
				returnScript = "location.href='/_mngr_/board/"+menuCode+"_list_"+bcid+".do'";
			}
			return CommUtil.doComplete(model, "완료", "등록이 완료 되었습니다.",returnScript);


		}else if("update".equals(mode)){

			if("user".equals(root)){

		    	//조회 권한 설정
				if(!"100".equals(mngrBoardconfigVO.getBcUpdate())){
					if("200".equals(mngrBoardconfigVO.getBcUpdate())){
						if(!CommUtil.isUserLogin()) {
							return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?", "location.href='"+loginPageUrl+"'", "history.back();");
						}
					}else if("210".equals(mngrBoardconfigVO.getBcUpdate())){
						if(!userId.equals(ownId)){
							return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
						}
					}else {
						return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
					}
				}
    		}

			/* ########################################################################
			 * 게시판이 커스텀게시판일 경우 커스텀컬럼(에디터) 데이터 검증
			 * ######################################################################## */
			if("2".equals(mngrBoardconfigVO.getBcType())){
				String resultString = validationCustomColumn(mngrBoardconfigVO, boardMap, model);
				if(CommUtil.notEmpty(resultString)) return resultString;
			}

			// 수정프로스세스 처리
			String msg = boardService.updateBoardUpdateProc(model, mngrBoardconfigVO, boardSearchVO, boardMap, request, response, returnPage); //"itgcms/global/board/board";
			if(!"".equals(msg)){
				return CommUtil.doComplete(model, "오류", msg, "history.back();");
			}

			String returnScript = "";
			if("user".equals(root)){
				returnScript = "location.href='/"+siteCode+"/contents/"+menuCode+".do?"+boardSearchVO.getQuery()+"'";
			}else{
				returnScript = "location.href='/_mngr_/board/"+menuCode+"_view_"+bcid+".do?"+boardSearchVO.getQuery()+"'";
			}
			return CommUtil.doComplete(model, "완료", "수정이 완료 되었습니다.",returnScript);


		}else if("reply".equals(mode)){
			if("user".equals(root)){

				//답변 권한 설정
	    		if(!"100".equals(mngrBoardconfigVO.getBcReply())){
					if(mngrBoardconfigVO.getBcReply().startsWith("2")){
						if(!CommUtil.isUserLogin()) {
							return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?", "location.href='"+loginPageUrl+"'", "history.back();");
						}
					}else {
						return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
					}
	    		}
    		}

    		// 답변프로스세스 처리
			String msg = boardService.insertBoardReplyProc(model, mngrBoardconfigVO, boardSearchVO, boardMap, request, response, returnPage);
			if(!"".equals(msg)){
				return CommUtil.doComplete(model, "오류", msg, "history.back();");
			}

			String returnScript = "";
			if("user".equals(root)){
				returnScript = "location.href='/"+siteCode+"/contents/"+menuCode+".do'";
			}else{
				returnScript = "location.href='/_mngr_/board/"+menuCode+"_list_"+bcid+".do'";
			}
			return CommUtil.doComplete(model, "완료", "답변이 완료 되었습니다.", returnScript); //목록으로 이동

		}else if("delete".equals(mode)){

			if("user".equals(root)){

		    	//삭제(수정) 권한 체크
				if(!"100".equals(mngrBoardconfigVO.getBcUpdate())){
					if("200".equals(mngrBoardconfigVO.getBcUpdate())){
						if(!CommUtil.isUserLogin()) {
							return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?", "location.href='"+loginPageUrl+"'", "history.back();");
						}
					}else if("210".equals(mngrBoardconfigVO.getBcUpdate())){
						if(!userId.equals(ownId)){
							return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
						}
					}else {
						return CommUtil.doComplete(model, "오류", "권한이 없습니다. 관리자에게 문의해주세요.", "history.back();");
					}
				}
    		}

			String[] chkId = request.getParameterValues("chkId");
			String msg = "";
			if(chkId == null){
				msg = boardService.updateBoardDeleteProc(model, mngrBoardconfigVO, boardSearchVO, request, response, returnPage);
			}else { //선택삭제
				msg = boardService.updateBoardChkDelProc(model, mngrBoardconfigVO, boardSearchVO, request, response, returnPage); //"itgcms/global/board/board";
			}
			if(!"".equals(msg)){
				return CommUtil.doComplete(model, "오류", msg, "history.back();");
			}

			boardSearchVO.setSchM("list");
			boardSearchVO.setId("");

			String returnScript = "";
			if("user".equals(root)){
				returnScript = "location.href='/"+siteCode+"/contents/"+menuCode+".do?"+boardSearchVO.getQuery()+"'";
			}else{
				returnScript = "location.href='/_mngr_/board/"+menuCode+"_list_"+bcid+".do?"+boardSearchVO.getQuery()+"'";
			}

			return CommUtil.doComplete(model, "완료", "삭제가 완료 되었습니다.", returnScript);

		}else {
			return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
		}


	}

	public String validationCustomColumn(MngrBoardconfigVO mngrBoardconfigVO, ItgMap boardMap, ModelMap model) throws ParseException {
		List<ItgMap> lobDataList = new ArrayList();
		JSONArray jArray = JsonUtil.getJsonArrayFromString(mngrBoardconfigVO.getBcExtcolumninfo());
		for(int i=0;i<jArray.size();i++) {
			JSONObject customColumn = (JSONObject)jArray.get(i);
			String bdContents = CommUtil.isNull(boardMap.get(customColumn.get("code")),CommUtil.isNull(boardMap.get(customColumn.get("code")+"LOB"),""));
			if("Y".equals(CommUtil.isNull(customColumn.get("required"),"N"))) {
				if(CommUtil.empty(bdContents)) {
					if("bdThumb".equals(customColumn.get("code"))) {
						//썸네일 검증
					}else {
						return CommUtil.doComplete(model, "오류", customColumn.get("name")+"이(가) 누락되었습니다.", "history.back();");
					}
				}
			}
			if("columnType03".equals(CommUtil.isNull(customColumn.get("type"),""))) {
				ItgMap paramMap = new ItgMap();
				paramMap.put("bdIdx", boardMap.get("id"));
				paramMap.put("blColumn", customColumn.get("code"));
				paramMap.put("blContents", CommUtil.decodeHTMLTagFilter(bdContents));
				lobDataList.add(paramMap);
			}
		}
		boardMap.put("lobDataList",lobDataList);
		return "";
	}

	/*private String getReturnPage(MngrBoardconfigVO mngrBoardconfigVO, BoardSearchVO boardSearchVO, String page){*/
	private String getReturnPage(String skin, String root, String page){
		String returnPage = "itgcms/global/board/skin/"
				+ skin
				+ "/"
				+ root
				+ "_"
				+ skin
				+ "_" + page  ;
		return returnPage;
	}

	/**
	 * 달력페이지 반환
	 * @return "itgcms/global/board/skin/calendar/userCalendar"
	 * @exception Exception
	 */
	@RequestMapping(value = "/{root}/board/{menuCode}_comm_{bcid}_getCalendar.ajax")
	public String userCalendar(@PathVariable String root, @PathVariable String menuCode, @PathVariable String bcid, BoardSearchVO boardSearchVO, ModelMap model,
			HttpServletRequest request,	HttpServletResponse response) throws Exception {

		String returnPage = "itgcms/global/board/skin/calendar/userCalendar";

		ItgMap itgMap = CommUtil.getParameterEMap(request);

    	int action = 0;  // incoming request for moving calendar up(1) down(0) for month
    	int currYear = 0; // if it is not retrieved from incoming URL (month=) then it is set to current year
    	int currMonth = 0; // same as year

    	Calendar c = Calendar.getInstance(); //현재의 날짜를 사용
    	Calendar cal = Calendar.getInstance(); //실제 보여질 날짜를 세팅

		if (CommUtil.empty(boardSearchVO.getAct())){ // 액션값이 없으면 현재 날짜로 파라메터 세팅
			currMonth = c.get(c.MONTH);
			currYear = c.get(c.YEAR);
			cal.set(currYear, currMonth, 1);
		} else {
			if (!CommUtil.empty(boardSearchVO.getAct())) // 이전달, 혹은 다음달 버튼을 통해 들어온 경우
			{
				currMonth = Integer.parseInt(boardSearchVO.getSchOpt2())-1; //검색 달을 조회
				currYear = Integer.parseInt(boardSearchVO.getSchOpt1());  //검색 년도를 조회

				if (Integer.parseInt(boardSearchVO.getAct()) == 0 ){ // 다음달
					cal.set(currYear, currMonth ,1);
					cal.add(cal.MONTH, -1);
					currMonth = cal.get(cal.MONTH);
					currYear = cal.get(cal.YEAR);
				}else if (Integer.parseInt(boardSearchVO.getAct()) == 1 ){ // 이전달
					cal.set(currYear, currMonth, 1);
					cal.add(cal.MONTH, 1);
					currMonth = cal.get(cal.MONTH);
					currYear = cal.get(cal.YEAR);
				}else {
					String schMonth = request.getParameter("schMonth");
					currYear = Integer.parseInt(schMonth.split("-")[0]);
					currMonth = Integer.parseInt(schMonth.split("-")[1]);
					cal.set(currYear, currMonth ,1);
					cal.add(cal.MONTH, -1);
					currMonth = cal.get(cal.MONTH);
					currYear = cal.get(cal.YEAR);
				}
			}
		}

		int weekCount = cal.getActualMaximum(cal.WEEK_OF_MONTH); //그 달이 몇주가 있는가
		int firstYoil = cal.get(cal.DAY_OF_WEEK); //그 달 첫째날의 요일

		int todayCalDay = c.get(c.DAY_OF_MONTH); //오늘 날짜(몇일)
		int todayCalMonth = c.get(c.MONTH); //현재의 월
		int todayCalYear = c.get(c.YEAR); //현재의 년

		int setCalMonth = cal.get(cal.MONTH); //세팅된 월
		int setCalYear = cal.get(cal.YEAR); //세팅된 년

		String yearString = Integer.toString(currYear);
		String monthString = getMonthName(currMonth);

		model.addAttribute("todayCalDay", todayCalDay);
		model.addAttribute("todayCalMonth", todayCalMonth);
		model.addAttribute("todayCalYear", todayCalYear);
		model.addAttribute("setCalMonth", setCalMonth);
		model.addAttribute("setCalYear", setCalYear);

		model.addAttribute("weekCount", weekCount); //현재 위치한 춸의 몇주가 있는지
		model.addAttribute("firstYoil", firstYoil); //현재 위치한 첫날의 요일
		model.addAttribute("currYear", currYear); //현재 위치한 연도
		model.addAttribute("currMonth", currMonth); //현재 위치한 월

		model.addAttribute("yearString", yearString); //달력 상단에서 표시하기 위해 사용
		model.addAttribute("monthString", monthString); //달력 상단에서 표시하기 위해 사용

		itgMap.put("yearmonth", yearString+monthString);
		itgMap.put("yearString", yearString);
		itgMap.put("monthString", monthString);
		itgMap.put("currYear", currYear);
		itgMap.put("currMonth", currMonth+1);

		int lasyDay = 0;                                       //마지막 날짜 변수
		cal.set(currYear,currMonth,1);                        //Calendar에서는 1월이 0이므로 우리가 사용하는 월에서 -1 해줘야 합니다.
		lasyDay = cal.getActualMaximum(Calendar.DATE);

		String nowDate = CommUtil.getDatePattern("yyyyMMdd");

		itgMap.put("allSdate", yearString+monthString+"01");
		itgMap.put("allEdate", yearString+monthString+lasyDay);
		itgMap.put("nowDate", nowDate.substring(6, 8));
		model.addAttribute("reqParam", itgMap);

		// 게시판 리스트를 불러오기 위한 설정
		boardSearchVO.setSchM("calendar");
		boardSearchVO.setSchOpt1(yearString);
		boardSearchVO.setSchOpt2(monthString);

		ItgMap boardMap = new ItgMap();

		// 게시판 리스트 model로 담아오기
		boardList(root, menuCode, bcid, boardSearchVO, boardMap, model, request, response);

	return returnPage;
	}

    public String getMonthName (int monthNumber) { // This method is used to quickly return the proper name of a month

		String strReturn = "";
		switch (monthNumber)
		{
			//페이지 뷰부분에서 이미지처리하기 위해 월이름을 지정함
			case 0:	strReturn = "01"; 	break;
			case 1:	strReturn = "02";	break;
			case 2:	strReturn = "03";	break;
			case 3:	strReturn = "04";	break;
			case 4:	strReturn = "05";	break;
			case 5:	strReturn = "06";	break;
			case 6:	strReturn = "07";	break;
			case 7:	strReturn = "08";	break;
			case 8:	strReturn = "09";	break;
			case 9:	strReturn = "10";	break;
			case 10:strReturn = "11";	break;
			case 11:strReturn = "12";	break;
		}
		return strReturn;
    }

    public BoardAuthVO setUserAuth(MngrBoardconfigVO mngrBoardconfigVO, String userId, String ownId) {

    	BoardAuthVO boardAuthVO = new BoardAuthVO();

    	//목록 권한 설정
		if("100".equals(mngrBoardconfigVO.getBcList())){
			boardAuthVO.setList(true);
		}else if(mngrBoardconfigVO.getBcList().startsWith("2") && CommUtil.isUserLogin()){
			boardAuthVO.setList(true);
		}

		//조회 권한 설정
		if("100".equals(mngrBoardconfigVO.getBcView())){
			boardAuthVO.setView(true);
		}else if("200".equals(mngrBoardconfigVO.getBcView()) && CommUtil.isUserLogin()){
			boardAuthVO.setView(true);
		}else if("210".equals(mngrBoardconfigVO.getBcView()) && userId.equals(ownId)){
			boardAuthVO.setView(true);
		}

		//등록 권한 설정
		if("100".equals(mngrBoardconfigVO.getBcRegist())){
			boardAuthVO.setRegist(true);
		}else if(mngrBoardconfigVO.getBcRegist().startsWith("2") && CommUtil.isUserLogin()){
			boardAuthVO.setRegist(true);
		}

		//수정(삭제) 권한 설정
		if("100".equals(mngrBoardconfigVO.getBcUpdate())){
			boardAuthVO.setUpdate(true);
		}else if("200".equals(mngrBoardconfigVO.getBcUpdate()) && CommUtil.isUserLogin()){
			boardAuthVO.setUpdate(true);
		}else if("210".equals(mngrBoardconfigVO.getBcUpdate()) && userId.equals(ownId)){
			boardAuthVO.setUpdate(true);
		}

		//답변 권한 설정
		if("100".equals(mngrBoardconfigVO.getBcReply())){
			boardAuthVO.setReply(true);
		}else if(mngrBoardconfigVO.getBcReply().startsWith("2") && CommUtil.isUserLogin()){
			boardAuthVO.setReply(true);
		}

		return boardAuthVO;
    }
}
