package egovframework.itgcms.mngr.managerlog.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.core.managerlog.service.MngrManagerLogSearchVO;
import egovframework.itgcms.core.managerlog.service.MngrManagerLogService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * @파일명 : MngrManagerLogController.java
 * @파일정보 : 관리자 로그 관리
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
public class MngrManagerLogController {

	/** MngrManagerService */
	@Resource(name = "mngrManagerLogService")
	private MngrManagerLogService mngrManagerLogService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;


	private static final Logger logger = LogManager.getLogger(MngrManagerLogController.class);

	@RequestMapping(value = "/_mngr_/managerlog/manager_list_log.do")
	public String selectMngrManagerLogList(@ModelAttribute("searchVO") MngrManagerLogSearchVO mngrManagerLogSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {

		//기본 검색기간 시작일,종료일 설정
		if("".equals(	CommUtil.isNull(	mngrManagerLogSearchVO.getSchSdt() , "" ) )){
			mngrManagerLogSearchVO.setSchSdt(CommUtil.getDatePattern("yyyy-MM-") + "01");
		}
		if("".equals(	CommUtil.isNull(	mngrManagerLogSearchVO.getSchEdt() , "" ) )){
			mngrManagerLogSearchVO.setSchEdt(CommUtil.getDatePattern("yyyy-MM-dd"));
		}

		mngrManagerLogSearchVO.setPageUnit(Integer.parseInt(mngrManagerLogSearchVO.getViewCount()));//viewCount
		mngrManagerLogSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrManagerLogSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrManagerLogSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrManagerLogSearchVO.getPageSize());

		mngrManagerLogSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrManagerLogSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrManagerLogSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> resultList = mngrManagerLogService.selectMngrManagerLogList(mngrManagerLogSearchVO);
		model.addAttribute("resultList", resultList);
		int totCnt = mngrManagerLogService.mngrManagerLogListTotCnt(mngrManagerLogSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
		return "itgcms/mngr/managerlog/manager_list_log";
	}

	@RequestMapping(value="/_mngr_/common/managerlog/mngrManagerLogListExcel.do")
	public ModelAndView mngrManagerLogListExcel(@ModelAttribute("searchVO") MngrManagerLogSearchVO mngrManagerLogSearchVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);

		mngrManagerLogSearchVO.setPageUnit(Integer.parseInt(mngrManagerLogSearchVO.getViewCount()));//viewCount
		mngrManagerLogSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrManagerLogSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrManagerLogSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrManagerLogSearchVO.getPageSize());

		mngrManagerLogSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrManagerLogSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrManagerLogSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		mngrManagerLogSearchVO.setExcelDown("excel");

		List<?> resultList = mngrManagerLogService.selectMngrManagerLogList(mngrManagerLogSearchVO);

		HashMap paramMap = new HashMap();

		//페이징 제외

		paramMap.put("schSdt", mngrManagerLogSearchVO.getSchSdt());
		paramMap.put("schEdt", mngrManagerLogSearchVO.getSchEdt());
		paramMap.put("dataList", resultList);

		//엑셀 템플릿에 넘겨줄 데이타
		mav.addObject("data", paramMap);

		//다운로드에 사용되어질 엑셀파일 템플릿
		mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, CommUtil.getExcelTemplateName(request, "mngr"));
		//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
		mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "관리자로그-" + CommUtil.getDatePattern("yyyy-MM-dd"));

		return mav;

	}

	@RequestMapping(value = "/_mngr_/managerlog/manager_delete_log.do")
	public String mngrManagerLogDel(@ModelAttribute("searchVO") MngrManagerLogSearchVO mngrManagerSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrManagerLogService.deleteMngrManagerLogProc(mngrManagerSearchVO);
		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='manager_list_log.do'");
	}
}
