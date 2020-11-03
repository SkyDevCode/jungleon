package egovframework.itgcms.mngr.boardconfig.web;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigSearchVO;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigService;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigVO;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * @파일명 : MngrBoardconfigController.java
 * @파일정보 : 게시판 등록 관리
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
public class MngrBoardconfigController {


	/** MngrBoardconfigService */
	@Resource(name = "mngrBoardconfigService")
	private MngrBoardconfigService mngrBoardconfigService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** mngrCodeService */
    @Resource(name = "mngrCodeService")
    private MngrCodeService mngrCodeService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;


	private static final Logger logger = LogManager.getLogger(MngrBoardconfigController.class);

	/**
	 * 글 목록을 조회한다. (paging)
	 * @param mngrBoardconfigSearchVO - 조회할 정보가 담긴 PopopSearchVO
	 * @param model
	 * @return "itgcms/mngr/boardconfig/_mngr_boardconfigList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/boardconfig/boardconfig_list.do")
	public String selectMngrBoardconfigList(@ModelAttribute("searchVO") MngrBoardconfigSearchVO mngrBoardconfigSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrBoardconfigSearchVO.setPageUnit(Integer.parseInt(mngrBoardconfigSearchVO.getViewCount()));//viewCount
		mngrBoardconfigSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrBoardconfigSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrBoardconfigSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrBoardconfigSearchVO.getPageSize());

		mngrBoardconfigSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrBoardconfigSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrBoardconfigSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> resultList = mngrBoardconfigService.selectMngrBoardconfigList(mngrBoardconfigSearchVO);
		model.addAttribute("resultList", resultList);
		int totCnt = mngrBoardconfigService.mngrBoardconfigListTotCnt(mngrBoardconfigSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		//System.out.println(paginationInfo);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("skinResult", getSkinList("hashmap"));
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

		//관리자 권한목록을 hashmap으로 변환
		List<HashMap> mngrAuthList = getMngrAuthList();
		HashMap<String,String> hmMngrAuth = new HashMap();
		for(HashMap tmp : mngrAuthList){
			hmMngrAuth.put((String)tmp.get("code"), (String)tmp.get("name"));
		}
		model.addAttribute("hmMngrAuth", hmMngrAuth);

		//관리자 Regist권한목록을 hashmap으로 변환
		List<HashMap> mngrRegistAuthList = getMngrRegistAuthList();
		HashMap<String,String> hmMngrRegistAuth = new HashMap();
		for(HashMap tmp : mngrRegistAuthList){
			hmMngrRegistAuth.put((String)tmp.get("code"), (String)tmp.get("name"));
		}
		model.addAttribute("hmMngrRegistAuth", hmMngrRegistAuth);

		//사용자 권한목록을 hashmap으로 변환
		List<HashMap> userAuthList = getUserAuthList();
		HashMap<String,String> hmUserAuth = new HashMap();
		for(HashMap tmp : userAuthList){
			hmUserAuth.put((String)tmp.get("code"), (String)tmp.get("name"));
		}
		model.addAttribute("hmUserAuth", hmUserAuth);

		//사용자 Regist권한목록을 hashmap으로 변환
		List<HashMap> userRegistAuthList = getUserRegistAuthList();
		HashMap<String,String> hmUserRegistAuth = new HashMap();
		for(HashMap tmp : userRegistAuthList){
			hmUserRegistAuth.put((String)tmp.get("code"), (String)tmp.get("name"));
		}
		model.addAttribute("hmUserRegistAuth", hmUserRegistAuth);

		//사용자 Delete권한목록을 hashmap으로 변환
		List<HashMap> userDeleteAuthList = getUserDeleteAuthList();
		HashMap<String,String> hmUserDeleteAuth = new HashMap();
		for(HashMap tmp : userDeleteAuthList){
			hmUserDeleteAuth.put((String)tmp.get("code"), (String)tmp.get("name"));
		}
		model.addAttribute("hmUserDeleteAuth", hmUserDeleteAuth);

		return "itgcms/mngr/boardconfig/boardconfig_list";
	}

	@RequestMapping(value = "/_mngr_/boardconfig/boardconfig_list_ajax.ajax")
	public String mngrBoardconfigListAjax(@ModelAttribute("searchVO") MngrBoardconfigSearchVO mngrBoardconfigSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrBoardconfigSearchVO.setPageUnit(Integer.parseInt(mngrBoardconfigSearchVO.getViewCount()));//viewCount
		mngrBoardconfigSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrBoardconfigSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrBoardconfigSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrBoardconfigSearchVO.getPageSize());

		mngrBoardconfigSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrBoardconfigSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrBoardconfigSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> resultList = mngrBoardconfigService.selectMngrBoardconfigList(mngrBoardconfigSearchVO);
		model.addAttribute("resultList", resultList);
		int totCnt = mngrBoardconfigService.mngrBoardconfigListTotCnt(mngrBoardconfigSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("skinResult", getSkinList("hashmap"));
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
		return "itgcms/mngr/boardconfig/boardconfig_list_ajax";
	}

	/**
	 * 등록 페이지
	 * @param mngrBoardconfigSearchVO
	 * @param model
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/boardconfig/boardconfig_input.do")
	public String mngrBoardconfigRegist(@ModelAttribute("searchVO") MngrBoardconfigSearchVO mngrBoardconfigSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrBoardconfigSearchVO.setAct("REGIST");

		MngrBoardconfigVO result = new MngrBoardconfigVO();
		result.setBcViewcount("10"); //게시판목록갯수 디폴트로 10 설정함
		model.addAttribute("result", result);
		model.addAttribute("searchVO", mngrBoardconfigSearchVO);
		model.addAttribute("skinList", getSkinList("list"));
		model.addAttribute("mngrAuthList", getMngrAuthList());
		model.addAttribute("userAuthList", getUserAuthList());
		model.addAttribute("mngrRegistAuthList", getMngrRegistAuthList());
		model.addAttribute("userRegistAuthList", getUserRegistAuthList());
		model.addAttribute("userDeleteAuthList", getUserDeleteAuthList());

		return "itgcms/mngr/boardconfig/boardconfig_edit";
	}

	/**
	 * 게시판 아이디 중복 여부(ajax)
	 * @param mngrBoardconfigSearchVO
	 * @param model
	 * @param response
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/boardconfig/boardconfig_comm_chkId.ajax")
	public void mngrBoardconfigCheckId(@ModelAttribute("searchVO") MngrBoardconfigSearchVO mngrBoardconfigSearchVO, ModelMap model, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String result = "0";
		String message = "알수없는 오류가 발생했습니다. 다시 시도해 주세요.";
		if(!"".equals(CommUtil.isNull(mngrBoardconfigSearchVO.getId(), ""))){
			int resultCount = mngrBoardconfigService.mngrBoardconfigCheckId(mngrBoardconfigSearchVO);
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

	/**
	 * 수정 페이지
	 * @param mngrBoardconfigSearchVO
	 * @param model
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/boardconfig/boardconfig_edit.do")
	public String selectMngrBoardconfigView(@ModelAttribute("searchVO") MngrBoardconfigSearchVO mngrBoardconfigSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrBoardconfigSearchVO.setAct("UPDATE");

		model.addAttribute("result", mngrBoardconfigService.selectMngrBoardconfigView(mngrBoardconfigSearchVO));
		model.addAttribute("searchVO", mngrBoardconfigSearchVO);
		model.addAttribute("skinList", getSkinList("list"));
		model.addAttribute("mngrAuthList", getMngrAuthList());
		model.addAttribute("userAuthList", getUserAuthList());
		model.addAttribute("mngrRegistAuthList", getMngrRegistAuthList());
		model.addAttribute("userRegistAuthList", getUserRegistAuthList());
		model.addAttribute("userDeleteAuthList", getUserDeleteAuthList());

		return "itgcms/mngr/boardconfig/boardconfig_edit";
	}

	/**
	 * 등록 페이지의 저장 처리
	 * @param mngrBoardconfigSearchVO
	 * @param model
	 * @param boardconfigVO
	 * @param request
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/boardconfig/boardconfig_input_proc.do")
	public String insertMngrBoardconfigProc(@ModelAttribute("searchVO") MngrBoardconfigSearchVO mngrBoardconfigSearchVO, ModelMap model, MngrBoardconfigVO boardconfigVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException {
		//입력 값 유효 체크
		// 게시판 아이디, 이름,스킨, 목록갯수,목록권한,뷰조회권한,등록권한,답변권한,기본페이지
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcId()  , "")	)) return CommUtil.doComplete(model, "오류", "게시판 아이디를  입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcName()  , "")	)) return CommUtil.doComplete(model, "오류", "게시판 이름을 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcSkin()  , "")	)) return CommUtil.doComplete(model, "오류", "게시판  스킨을 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcViewcount()  , "")	)) return CommUtil.doComplete(model, "오류", "목록 갯수를 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcList()  , "")	)) return CommUtil.doComplete(model, "오류", "목록권한을 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcView()  , "")	)) return CommUtil.doComplete(model, "오류", "뷰 조회권한을 선택 해 주세요.", "history.back();");
		//if("".equals( CommUtil.isNull(  boardconfigVO.getBcRegist()  , "")	)) return CommUtil.doComplete(model, "오류", "등록권한을 선택 해 주세요.", "history.back();");
		//if("".equals( CommUtil.isNull(  boardconfigVO.getBcUpdate()  , "")	)) return CommUtil.doComplete(model, "오류", "수정권한을 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcReply()  , "")	)) return CommUtil.doComplete(model, "오류", "답변권한을 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcReplyyn()  , "")	)) return CommUtil.doComplete(model, "오류", "답변사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcFileyn()  , "")	)) return CommUtil.doComplete(model, "오류", "첨부파일사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcSecretyn()  , "")	)) return CommUtil.doComplete(model, "오류", "비밀글사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcNoticeyn()  , "")	)) return CommUtil.doComplete(model, "오류", "공지글사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcGroupyn()  , "")	)) return CommUtil.doComplete(model, "오류", "카테고리사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcEditoryn()  , "")	)) return CommUtil.doComplete(model, "오류", "에디터사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcPrevnextyn()  , "")	)) return CommUtil.doComplete(model, "오류", "이전/다음글사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcDefaultpage()  , "")	)) return CommUtil.doComplete(model, "오류", "기본페이지를 입력 해 주세요.", "history.back();");

		if("Y".equals(boardconfigVO.getBcFileyn())){
			if("".equals( CommUtil.isNull(  boardconfigVO.getBcFilecount()  , "")	)) return CommUtil.doComplete(model, "오류", "첨부파일 갯수를 선택 해 주세요.", "history.back();");
			if("".equals( CommUtil.isNull(  boardconfigVO.getBcFilesize()  , "")	)) return CommUtil.doComplete(model, "오류", "첨부파일 용량제한을 선택 해 주세요.", "history.back();");
		}
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcFilecount()  , "")	)) {boardconfigVO.setBcFilecount("0");}
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcFilesize()  , "")	)) {boardconfigVO.setBcFilesize("0");}

		//게시판 아이디 첫글자 영문 체크
    	if(!CommUtil.regEx("^[a-zA-Z]", boardconfigVO.getBcId())) return CommUtil.doComplete(model, "오류", "게시판 아이디 첫글자는 영문자로 입력 해 주세요.", "history.back();");
    	if(CommUtil.regEx("[^a-zA-Z0-9_]", boardconfigVO.getBcId())) return CommUtil.doComplete(model, "오류", "게시판 아이디는 영문, 숫자, _ 만 입력 가능합니다.", "history.back();");

    	//게시판 아이디 중복 검사
    	mngrBoardconfigSearchVO.setId(boardconfigVO.getBcId());
    	int resultCount = mngrBoardconfigService.mngrBoardconfigCheckId(mngrBoardconfigSearchVO);
		if(resultCount > 0) return CommUtil.doComplete(model, "오류", "중복된 게시판 아이디 입니다. 확인 후 다시 시도하세요." , "history.back();");

		//게시판 카테고리에 코드를 만들어 놓는다. 사용여부와 상관없이 만들어 놓음.
		MngrCodeVO mngrCodeVO = new MngrCodeVO();
		mngrCodeVO.setSchCode("board");//설치시 게시판카테고리용 코드관리가 등록돼있음
		mngrCodeVO.setCcode("_" + boardconfigVO.getBcId());//게시판 카테고리 코드는 앞에 _를 붙인다.
		mngrCodeVO.setCname(boardconfigVO.getBcName());
		mngrCodeVO.setRegmemid(CommUtil.getMngrMemId());
		mngrCodeService.regCode(mngrCodeVO);

    	boardconfigVO.setRegmemid(CommUtil.getMngrMemId());
    	boardconfigVO.setBcExtcolumninfo(CommUtil.decodeHTMLTagFilter(boardconfigVO.getBcExtcolumninfo()));
    	mngrBoardconfigService.insertMngrBoardconfigProc(boardconfigVO);

		return CommUtil.doComplete(model, "완료", "등록 되었습니다.", "location.href='boardconfig_list.do?"+mngrBoardconfigSearchVO.getQuery()+"'");
	}

	/**
	 * 수정페이지 저장 처리
	 * @param mngrBoardconfigSearchVO
	 * @param model
	 * @param boardconfigVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/boardconfig/boardconfig_edit_proc.do")
	public String updateMngrBoardconfigProc(@ModelAttribute("searchVO") MngrBoardconfigSearchVO mngrBoardconfigSearchVO, ModelMap model, MngrBoardconfigVO boardconfigVO) throws IOException, SQLException, RuntimeException {
		//입력 값 유효 체크
		// 게시판 아이디, 이름,스킨, 목록갯수,목록권한,뷰조회권한,등록권한,답변권한,기본페이지
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcName()  , "")	)) return CommUtil.doComplete(model, "오류", "게시판 이름을 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcSkin()  , "")	)) return CommUtil.doComplete(model, "오류", "게시판  스킨을 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcViewcount()  , "")	)) return CommUtil.doComplete(model, "오류", "목록 갯수를 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcList()  , "")	)) return CommUtil.doComplete(model, "오류", "목록권한을 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcView()  , "")	)) return CommUtil.doComplete(model, "오류", "뷰 조회권한을 선택 해 주세요.", "history.back();");
		//if("".equals( CommUtil.isNull(  boardconfigVO.getBcRegist()  , "")	)) return CommUtil.doComplete(model, "오류", "등록권한을 선택 해 주세요.", "history.back();");
		//if("".equals( CommUtil.isNull(  boardconfigVO.getBcUpdate()  , "")	)) return CommUtil.doComplete(model, "오류", "수정권한을 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcReply()  , "")	)) return CommUtil.doComplete(model, "오류", "답변권한을 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcReplyyn()  , "")	)) return CommUtil.doComplete(model, "오류", "답변사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcFileyn()  , "")	)) return CommUtil.doComplete(model, "오류", "첨부파일사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcSecretyn()  , "")	)) return CommUtil.doComplete(model, "오류", "비밀글사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcNoticeyn()  , "")	)) return CommUtil.doComplete(model, "오류", "공지글사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcGroupyn()  , "")	)) return CommUtil.doComplete(model, "오류", "카테고리사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcEditoryn()  , "")	)) return CommUtil.doComplete(model, "오류", "에디터사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcPrevnextyn()  , "")	)) return CommUtil.doComplete(model, "오류", "이전/다음글사용여부를 선택 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcDefaultpage()  , "")	)) return CommUtil.doComplete(model, "오류", "기본페이지를 입력 해 주세요.", "history.back();");

		if("Y".equals(boardconfigVO.getBcFileyn())){
			if("".equals( CommUtil.isNull(  boardconfigVO.getBcFilecount()  , "")	)) return CommUtil.doComplete(model, "오류", "첨부파일 갯수를 선택 해 주세요.", "history.back();");
			if("".equals( CommUtil.isNull(  boardconfigVO.getBcFilesize()  , "")	)) return CommUtil.doComplete(model, "오류", "첨부파일 용량제한을 선택 해 주세요.", "history.back();");
		}
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcFilecount()  , "")	)) {boardconfigVO.setBcFilecount("0");}
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcFilesize()  , "")	)) {boardconfigVO.setBcFilesize("0");}

		if("".equals( CommUtil.isNull(  boardconfigVO.getBcRegist()  , "")	)) {boardconfigVO.setBcRegist("900");}
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcUpdate()  , "")	)) {boardconfigVO.setBcUpdate("900");}
		if("".equals( CommUtil.isNull(  boardconfigVO.getBcReply()  , "")	)) {boardconfigVO.setBcReply("900");}

		boardconfigVO.setUpdmemid(CommUtil.getMngrMemId());
		boardconfigVO.setBcExtcolumninfo(CommUtil.decodeHTMLTagFilter(boardconfigVO.getBcExtcolumninfo()));
		mngrBoardconfigService.updateMngrBoardconfigProc(boardconfigVO); /** impl에서 코드관리의 게시판명도 수정되도록 처리 */

		return CommUtil.doComplete(model, "완료", "수정 되었습니다.", "location.href='boardconfig_edit.do?"+mngrBoardconfigSearchVO.getQuery()+"'");
	}

	/**
	 * 삭제 처리 페이지
	 * @param mngrBoardconfigSearchVO
	 * @param model
	 * @param boardconfigVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/boardconfig/boardconfig_delete_proc.do")
	public String deleteMngrBoardconfigProc(@ModelAttribute("searchVO") MngrBoardconfigSearchVO mngrBoardconfigSearchVO, ModelMap model, MngrBoardconfigVO boardconfigVO) throws IOException, SQLException, RuntimeException {
		boardconfigVO.setDelmemid(CommUtil.getMngrMemId());
		mngrBoardconfigService.deleteMngrBoardconfigProc(boardconfigVO);
		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='boardconfig_list.do?"+mngrBoardconfigSearchVO.getQuery()+"'");
	}

	/**
	 * 삭제 처리 페이지 : 다중삭제(목록페이지에서 다중선택 후 삭제)
	 * @param mngrBoardconfigSearchVO
	 * @param model
	 * @param boardconfigVO
	 * @param request
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/boardconfig/boardconfig_delete_chkProc.do")
	public String deleteMngrBoardconfigChkProc(@ModelAttribute("searchVO") MngrBoardconfigSearchVO mngrBoardconfigSearchVO, ModelMap model, MngrBoardconfigVO boardconfigVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException {
		boardconfigVO.setDelmemid(CommUtil.getMngrMemId());
		mngrBoardconfigService.deleteMngrBoardconfigChkProc(boardconfigVO);
		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='boardconfig_list.do?"+mngrBoardconfigSearchVO.getQuery()+"'");
	}

	/**
	 * 게시판 목록(Ajax)
	 * @param mngrBoardconfigSearchVO
	 * @param response
	 * @throws IOException, SQLException, RuntimeException
	 */
	/*@RequestMapping(value = "/_mngr_/boardconfig/mngrBoardconfigListAjax.ajax")
	public void mngrBoardconfigListAjax(@ModelAttribute("searchVO") MngrBoardconfigSearchVO mngrBoardconfigSearchVO, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		mngrBoardconfigSearchVO.setPageUnit(10);//viewCount
		mngrBoardconfigSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrBoardconfigSearchVO.getPage());
		//** paging setting *//*
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrBoardconfigSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrBoardconfigSearchVO.getPageSize());

		mngrBoardconfigSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrBoardconfigSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrBoardconfigSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> result = mngrBoardconfigService.selectMngrBoardconfigList(mngrBoardconfigSearchVO);
		int totCnt = mngrBoardconfigService.mngrBoardconfigListTotCnt(mngrBoardconfigSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);

		String json = "{\"total\":\""+paginationInfo.getTotalRecordCount()+"\",\"currentPage\":\""+paginationInfo.getCurrentPageNo()+"\", \"totalPage\":\""+paginationInfo.getTotalPageCount()+"\",\"result\":  [";
		for(int i = 0; i < result.size(); i++){
			MngrBoardconfigVO boardconfig = (MngrBoardconfigVO)result.get(i);
			json += String.format("{\"bcId\":\"%s\",\"bcName\":\"%s\",\"bcSkin\":\"%s\"}", boardconfig.getBcId(), boardconfig.getBcName(), boardconfig.getBcSkin());
			if(i < result.size() - 1){
				json += ",";
			}

		}
		json += "]}";
		CommUtil.printWriter(json, response);
	}*/

	/**
	 * 카테고리 등록(코드 등록 서비스를 사용하지만, 코드를 자동 생성 한다)
	 * @param mngrCodeVO
	 * @param response
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/boardconfig/boardconfig_input_category.ajax")
	public void mngrBoardconfigCategoryRegist(MngrCodeVO mngrCodeVO, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		String result = "0";
		if("".equals( CommUtil.isNull(  mngrCodeVO.getSchCode() , "")	)){ // 게시판코드  free
			result = "2";
		}else if("".equals( CommUtil.isNull(  mngrCodeVO.getCpcode() , "")	)) { //부모코드 _free
			result = "3";
		}else if("".equals( CommUtil.isNull(  mngrCodeVO.getCname() , "")	)) { //코드명 구분
			result = "4";
		}else{
			String newCode = mngrCodeVO.getCpcode();
			MngrCodeVO tmpCodeVO = mngrCodeService.mngrCodeMaxCode(mngrCodeVO);
			if(tmpCodeVO == null || tmpCodeVO.getCcode() == null){
				newCode = newCode + "01";
			}else{
				String tmpCode = tmpCodeVO.getCcode().replaceAll(newCode, "");
				newCode =  mngrCodeVO.getCpcode() + CommUtil.getZeroPlus(Integer.valueOf(tmpCode) + 1);
			}
			mngrCodeVO.setRegmemid(CommUtil.getMngrMemId());
			mngrCodeVO.setCcode(newCode);
			mngrCodeVO.setSchCode(mngrCodeVO.getCpcode()); // 저장시에 부모코드는 schCode값을 저장한다.
			mngrCodeService.insertCode(mngrCodeVO);

			result = "1";
		}

		CommUtil.printWriter("{\"result\":\""+result+"\"}", response);
	}

	public Object getSkinList(String returnType){
		String path = CommUtil.getContextRoot() + System.getProperty("file.separator")
				+ "WEB-INF"  + System.getProperty("file.separator")
				+ "jsp"  + System.getProperty("file.separator")
				+ "egovframework"  + System.getProperty("file.separator")
				+ "itgcms"  + System.getProperty("file.separator")
				+ "global"  + System.getProperty("file.separator")
				+ "board"  + System.getProperty("file.separator")
				+ "skin";
		path = CommUtil.getFilePathReplace(path);
		java.io.File f = new java.io.File(path);
		java.io.File []folder = f.listFiles();

		List<HashMap<String, String>> skinList = new java.util.ArrayList<HashMap<String,String>>();
		HashMap<String, String> result = new HashMap<String, String>();

		int count = 0;
		for(int i = 0;i < folder.length; i++){
			if(folder[i].isDirectory()){
				String tmpPath = path + System.getProperty("file.separator") + folder[i].getName();
				tmpPath = CommUtil.getFilePathReplace(tmpPath);
				java.io.File skinFile[] =( new java.io.File(tmpPath)).listFiles();
				boolean hasSkinFile = false;
				boolean hasTitleFile = false;
				String title = "";
				for(int j = 0; j < skinFile.length; j++){
					String filename = skinFile[j].getName();
					if(CommUtil.regEx("(user|_mngr_)_"+folder[i].getName()+"_.*\\.jsp", filename)){
						hasSkinFile = true;
					}
					if(filename.indexOf(".") == -1){
						hasTitleFile = true;
						title = skinFile[j].getName();
					}
				}
				if(hasSkinFile && hasTitleFile){
					// resulstType List
					HashMap<String, String> hm = new HashMap<String, String>();
					hm.put("code", folder[i].getName());
					hm.put("name", title);
					skinList.add(count, hm);

					// resultType hashmap
					result.put(folder[i].getName(), title);
				}
			}
		}

		return ("list".equals(returnType)? skinList : result);
	}

	/*
	 * 사용자:비회원 100
	 * 사용자:회원 200
	 * 사용자:작성자 210
	 * 사용자:권한없음 900
	 *
	 * 관리자:부서 300
	 * 관리자:작성자 310
	 * 관리자:관리자 900
	 */
	public List getUserAuthList(){
		HashMap hm = new HashMap();
		List<HashMap> authList = new java.util.ArrayList();
		hm = new HashMap();
		hm.put("name", "사용자:비회원");
		hm.put("code", "100");
		authList.add(0, hm);

		hm = new HashMap();
		hm.put("name", "사용자:회원");
		hm.put("code", "200");
		authList.add(1, hm);

		hm = new HashMap();
		hm.put("name", "사용자:작성자");
		hm.put("code", "210");
		authList.add(2, hm);

		hm = new HashMap();
		hm.put("name", "권한없음");
		hm.put("code", "900");
		authList.add(3, hm);

		return authList;
	}
	public List getUserRegistAuthList(){
		HashMap hm = new HashMap();
		List<HashMap> authList = new java.util.ArrayList();
		hm = new HashMap();
		hm.put("name", "사용자:비회원");
		hm.put("code", "100");
		authList.add(0, hm);

		hm = new HashMap();
		hm.put("name", "사용자:회원");
		hm.put("code", "200");
		authList.add(1, hm);

		hm = new HashMap();
		hm.put("name", "권한없음");
		hm.put("code", "900");
		authList.add(2, hm);

		return authList;
	}
	public List getUserDeleteAuthList(){
		HashMap hm = new HashMap();
		List<HashMap> authList = new java.util.ArrayList();

		hm = new HashMap();
		hm.put("name", "사용자:비회원");
		hm.put("code", "100");
		authList.add(0, hm);

		hm = new HashMap();
		hm.put("name", "사용자:회원");
		hm.put("code", "200");
		authList.add(1, hm);

		hm = new HashMap();
		hm.put("name", "사용자:작성자");
		hm.put("code", "210");
		authList.add(2, hm);

		hm = new HashMap();
		hm.put("name", "권한없음");
		hm.put("code", "900");
		authList.add(3, hm);

		return authList;
	}
	public List getMngrAuthList(){
		HashMap hm = new HashMap();
		List<HashMap> authList = new java.util.ArrayList();
		hm = new HashMap();
		hm.put("name", "관리자:전체");
		hm.put("code", "200");
		authList.add(0, hm);

		/*hm = new HashMap();
		hm.put("name", "관리자:부서");
		hm.put("code", "300");
		authList.add(1, hm);*/

		hm = new HashMap();
		hm.put("name", "관리자:작성자");
		hm.put("code", "310");
		authList.add(1, hm);

		hm = new HashMap();
		hm.put("name", "관리자:통합관리자");
		hm.put("code", "900");
		authList.add(2, hm);
		return authList;
	}
	public List getMngrRegistAuthList(){
		HashMap hm = new HashMap();
		List<HashMap> authList = new java.util.ArrayList();
		hm = new HashMap();
		hm.put("name", "관리자:전체");
		hm.put("code", "200");
		authList.add(0, hm);

		hm = new HashMap();
		hm.put("name", "관리자:통합관리자");
		hm.put("code", "900");
		authList.add(1, hm);
		return authList;
	}
}
