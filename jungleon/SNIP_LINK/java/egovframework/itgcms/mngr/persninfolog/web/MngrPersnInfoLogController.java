package egovframework.itgcms.mngr.persninfolog.web;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.itgcms.core.persninfolog.service.MngrPersnInfoLogSearchVO;
import egovframework.itgcms.core.persninfolog.service.MngrPersnInfoLogService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명 : MngrPersnInfoLogController.java
 * @파일정보 : 개인정보 조회 로그 관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 12. 26. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class MngrPersnInfoLogController {

	/** EgovPropertyService */
	@Resource(name = "mngrPersnInfoLogService")
	protected MngrPersnInfoLogService mngrPersnInfoLogService;

	@RequestMapping(value = "/_mngr_/persnInfoLog/persnInfoLog_list.do")
	public String selectMngrPersnInfoLogList(@ModelAttribute("searchVO") MngrPersnInfoLogSearchVO mngrPersnInfoLogSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {

		//기본 검색기간 시작일,종료일 설정
		if("".equals(	CommUtil.isNull(	mngrPersnInfoLogSearchVO.getSchSdt() , "" ) )){
			mngrPersnInfoLogSearchVO.setSchSdt(CommUtil.getDatePattern("yyyy-MM-") + "01");
		}
		if("".equals(	CommUtil.isNull(	mngrPersnInfoLogSearchVO.getSchEdt() , "" ) )){
			mngrPersnInfoLogSearchVO.setSchEdt(CommUtil.getDatePattern("yyyy-MM-dd"));
		}

		mngrPersnInfoLogSearchVO.setPageUnit(Integer.parseInt(mngrPersnInfoLogSearchVO.getViewCount()));//viewCount
		mngrPersnInfoLogSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrPersnInfoLogSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrPersnInfoLogSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrPersnInfoLogSearchVO.getPageSize());

		mngrPersnInfoLogSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrPersnInfoLogSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrPersnInfoLogSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> resultList = mngrPersnInfoLogService.selectMngrPersnInfoLogList(mngrPersnInfoLogSearchVO);
		model.addAttribute("resultList", resultList);
		int totCnt = mngrPersnInfoLogService.mngrPersnInfoLogListTotCnt(mngrPersnInfoLogSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
		return "itgcms/mngr/persninfolog/persnInfoLog_list";
	}

	@RequestMapping(value="/_mngr_/common/persnInfoLog/mngrPersnInfoLogListExcel.do")
	public ModelAndView mngrPersnInfoLogListExcel(@ModelAttribute("searchVO") MngrPersnInfoLogSearchVO mngrPersnInfoLogSearchVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);

		mngrPersnInfoLogSearchVO.setPageUnit(Integer.parseInt(mngrPersnInfoLogSearchVO.getViewCount()));//viewCount
		mngrPersnInfoLogSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrPersnInfoLogSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrPersnInfoLogSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrPersnInfoLogSearchVO.getPageSize());

		mngrPersnInfoLogSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrPersnInfoLogSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrPersnInfoLogSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		mngrPersnInfoLogSearchVO.setExcelDown("excel");

		List<EgovMap> resultList = mngrPersnInfoLogService.selectMngrPersnInfoLogList(mngrPersnInfoLogSearchVO);
		List<EgovMap> dataList = new ArrayList();
		for(int i=0; i<resultList.size(); i++){
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String newInqireDate = format.format(resultList.get(i).get("inqireDate"));
			resultList.get(i).put("inqireDate", newInqireDate);
			dataList.add(resultList.get(i));
		}

		HashMap paramMap = new HashMap();

		//페이징 제외

		paramMap.put("schSdt", mngrPersnInfoLogSearchVO.getSchSdt());
		paramMap.put("schEdt", mngrPersnInfoLogSearchVO.getSchEdt());
		paramMap.put("dataList", dataList);
		paramMap.put("totalNum",resultList.size());

		//엑셀 템플릿에 넘겨줄 데이타
		mav.addObject("data", paramMap);

		//다운로드에 사용되어질 엑셀파일 템플릿
		mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, CommUtil.getExcelTemplateName(request, "mngr"));
		//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
		mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "개인정보조회로그-" + CommUtil.getDatePattern("yyyy-MM-dd"));

		return mav;

	}
	@RequestMapping(value = "/_mngr_/persnInfoLog/persnInfo_delete_log.do")
	public String mngrPersnInfoLogDel(@ModelAttribute("searchVO") MngrPersnInfoLogSearchVO mngrPersnInfoLogSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrPersnInfoLogService.deletePersnInfoLogProc(mngrPersnInfoLogSearchVO);
		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='persnInfoLog_list.do'");
	}
}
