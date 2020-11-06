package egovframework.itgcms.mngr.program.web;

import java.io.IOException;
import java.sql.SQLException;
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
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.menu.service.MngrMenuService;
import egovframework.itgcms.core.program.service.MngrProgramSearchVO;
import egovframework.itgcms.core.program.service.MngrProgramService;
import egovframework.itgcms.core.program.service.MngrProgramVO;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명 : MngrProgramController.java
 * @파일정보 : 프로그램 등록 관리
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
public class MngrProgramController {


	/** MngrProgramService */
	@Resource(name = "mngrProgramService")
	private MngrProgramService mngrProgramService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** mngrCodeService */
    @Resource(name = "mngrCodeService")
    private MngrCodeService mngrCodeService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/** MngrMenuService */
	@Resource(name = "mngrMenuService")
	private MngrMenuService mngrMenuService;

	private static final Logger logger = LogManager.getLogger(MngrProgramController.class);

	/**
	 * 글 목록을 조회한다. (paging)
	 * @param mngrProgramSearchVO - 조회할 정보가 담긴 PopopSearchVO
	 * @param model
	 * @return "itgcms/mngr/program/_mngr_programList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/program/prog_list.do")
	public String selectMngrProgramList(@ModelAttribute("searchVO") MngrProgramSearchVO mngrProgramSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrProgramSearchVO.setPageUnit(Integer.parseInt(mngrProgramSearchVO.getViewCount()));//viewCount
		mngrProgramSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrProgramSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrProgramSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrProgramSearchVO.getPageSize());

		mngrProgramSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrProgramSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrProgramSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> resultList = mngrProgramService.selectMngrProgramList(mngrProgramSearchVO);
		model.addAttribute("resultList", resultList);
		int totCnt = mngrProgramService.mngrProgramListTotCnt(mngrProgramSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
		return "itgcms/mngr/program/prog_list";
	}

	/**
	 * 등록 페이지
	 * @param mngrProgramSearchVO
	 * @param model
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/program/prog_input.do")
	public String mngrProgramRegist(@ModelAttribute("searchVO") MngrProgramSearchVO mngrProgramSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrProgramSearchVO.setAct("REGIST");

		MngrProgramVO result = new MngrProgramVO();
		model.addAttribute("result", result);
		model.addAttribute("searchVO", mngrProgramSearchVO);
		return "itgcms/mngr/program/prog_edit";
	}

	/**
	 * 수정 페이지
	 * @param mngrProgramSearchVO
	 * @param model
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/program/prog_edit.do")
	public String selectMngrProgramView(@ModelAttribute("searchVO") MngrProgramSearchVO mngrProgramSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrProgramSearchVO.setAct("UPDATE");

		model.addAttribute("result", mngrProgramService.selectMngrProgramView(mngrProgramSearchVO));
		model.addAttribute("searchVO", mngrProgramSearchVO);
		return "itgcms/mngr/program/prog_edit";
	}

	/**
	 * 등록 페이지의 저장 처리
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @param request
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/program/prog_input_proc.do")
	public String insertMngrProgramProc(@ModelAttribute("searchVO") MngrProgramSearchVO mngrProgramSearchVO, ModelMap model, MngrProgramVO programVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException {
		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  programVO.getProgName()  , "")	)) return CommUtil.doComplete(model, "오류", "프로그램 명을  입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  programVO.getProgUserurl()  , "")	)) return CommUtil.doComplete(model, "오류", "사용자 URL을 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  programVO.getProgMngrurl()  , "")	)) return CommUtil.doComplete(model, "오류", "관리자 URL을 입력 해 주세요.", "history.back();");

    	mngrProgramService.insertMngrProgramProc(programVO);

		return CommUtil.doComplete(model, "완료", "등록 되었습니다.", "location.href='prog_list.do?"+mngrProgramSearchVO.getQuery()+"'");
	}

	/**
	 * 수정페이지 저장 처리
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/program/prog_edit_proc.do")
	public String updateMngrProgramProc(@ModelAttribute("searchVO") MngrProgramSearchVO mngrProgramSearchVO, ModelMap model, MngrProgramVO programVO) throws IOException, SQLException, RuntimeException {
		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  programVO.getProgName()  , "")	)) return CommUtil.doComplete(model, "오류", "프로그램 명을  입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  programVO.getProgUserurl()  , "")	)) return CommUtil.doComplete(model, "오류", "사용자 URL을 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  programVO.getProgMngrurl()  , "")	)) return CommUtil.doComplete(model, "오류", "관리자 URL을 입력 해 주세요.", "history.back();");

		mngrProgramService.updateMngrProgramProc(programVO);

		return CommUtil.doComplete(model, "완료", "수정 되었습니다.", "location.href='prog_edit.do?"+mngrProgramSearchVO.getQuery()+"'");
	}

	/**
	 * 삭제 처리 페이지
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/program/prog_delete_proc.do")
	public String deleteMngrProgramProc(@ModelAttribute("searchVO") MngrProgramSearchVO mngrProgramSearchVO, ModelMap model, MngrProgramVO programVO) throws IOException, SQLException, RuntimeException {
		mngrProgramService.deleteMngrProgramProc(programVO);
		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='prog_list.do?"+mngrProgramSearchVO.getQuery()+"'");
	}

	/**
	 * 목록(Ajax)
	 * @param mngrProgramSearchVO
	 * @param response
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/program/prog_comm_list.ajax")
	public void mngrProgramListAjax(@ModelAttribute("searchVO") MngrProgramSearchVO mngrProgramSearchVO, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		mngrProgramSearchVO.setPageUnit(10);//viewCount
		mngrProgramSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrProgramSearchVO.getPage());
		//** paging setting *//*
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrProgramSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrProgramSearchVO.getPageSize());

		mngrProgramSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrProgramSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrProgramSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> result = mngrProgramService.selectMngrProgramList(mngrProgramSearchVO);
		int totCnt = mngrProgramService.mngrProgramListTotCnt(mngrProgramSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);

		String json = "{\"total\":\""+paginationInfo.getTotalRecordCount()+"\",\"currentPage\":\""+paginationInfo.getCurrentPageNo()+"\", \"totalPage\":\""+paginationInfo.getTotalPageCount()+"\",\"result\":  [";
		for(int i = 0; i < result.size(); i++){
			MngrProgramVO program = (MngrProgramVO)result.get(i);
			json += String.format("{\"progIdx\":\"%s\",\"progName\":\"%s\",\"progUserurl\":\"%s\",\"progMngrurl\":\"%s\"}", program.getProgIdx(), program.getProgName(), program.getProgUserurl(), program.getProgMngrurl());
			if(i < result.size() - 1){
				json += ",";
			}
		}
		json += "]}";
		CommUtil.printWriter(json, response);
	}
}
