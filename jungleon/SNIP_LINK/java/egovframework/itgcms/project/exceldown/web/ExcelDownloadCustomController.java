package egovframework.itgcms.project.exceldown.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.project.exceldown.service.ExcelDownloadCustomService;
import egovframework.itgcms.project.totalTable.service.TotalTbVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.ExcelDownloadView;

@Controller
public class ExcelDownloadCustomController {

	@Autowired
	ExcelDownloadCustomService excelDownloadCustomService;

	// 사업공고
	@RequestMapping(value="/exceldownload/module/{menuCode}_bsnsPblanc_{bbsBcId}.do")
	public ModelAndView selectMngrBsnsPblancExcelDown(@PathVariable String menuCode,
			@PathVariable("bbsBcId") String bbsBcId, ModelMap model,
			HttpServletRequest request) throws IOException, SQLException {

		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);
		Map paramMap = CommUtil.getParameterMap(request);

		List<ItgMap> resultList = excelDownloadCustomService.selectMngrBsnsPblancData(bbsBcId);

		paramMap.put("dataList", resultList);
		paramMap.put("totalNum", resultList.size());
		mav.addObject("data", paramMap);

		//다운로드에 사용되어질 엑셀파일 템플릿
		mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrBsnsPblancData");
		//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
		mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "사업공고-" + CommUtil.getDatePattern("yyyy-MM-dd"));
		return mav;
	}


	// 지원사업
	@RequestMapping(value="/exceldownload/module/{menuCode}_spBussiness_{bbsBcId}.do")
	public ModelAndView selectMngrSpBussinessExcelDown(@PathVariable String menuCode,
			@PathVariable("bbsBcId") String bbsBcId, ModelMap model,
			HttpServletRequest request) throws IOException, SQLException{

		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);
		Map paramMap = CommUtil.getParameterMap(request);
		List<ItgMap> resultList;

		switch(menuCode) {
		 	case "Business21" : // 지원사업_접수중
		 		resultList = excelDownloadCustomService.selectMngrSpBussinessIngData(bbsBcId);
				mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrSpBussinessData");
				//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
				mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "지원사업_접수중인-" + CommUtil.getDatePattern("yyyy-MM-dd"));
	            break;
	        case "Business22" : // 지원사업_접수마감
	        	resultList = excelDownloadCustomService.selectMngrSpBussinessEndData(bbsBcId);
				mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrSpBussinessData");
				//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
				mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "지원사업_접수마감인-" + CommUtil.getDatePattern("yyyy-MM-dd"));
				break;
	        case "Business31" : // 비즈니스센터_접수중
	        	resultList = excelDownloadCustomService.selectMngrSpBussinessIngData(bbsBcId);
				mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrBsnsCtApplyData");
				//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
				mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "비즈니스센터_접수중인-" + CommUtil.getDatePattern("yyyy-MM-dd"));
				break;
	        case "Business32" : // 비즈니스센터_접수마감
	        	resultList = excelDownloadCustomService.selectMngrSpBussinessEndData(bbsBcId);
				mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrBsnsCtApplyData");
				//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
				mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "비즈니스센터_접수마감인-" + CommUtil.getDatePattern("yyyy-MM-dd"));
				break;
	        default : // 공실예상센터
	        	resultList = excelDownloadCustomService.selectMngrEmptyData(bbsBcId);
				mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrEmptyRoomData");
				//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
				mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "공실예상센터-" + CommUtil.getDatePattern("yyyy-MM-dd"));
		}

		paramMap.put("dataList", resultList);
		paramMap.put("totalNum", resultList.size());
		mav.addObject("data", paramMap);


		return mav;
	}

	// 경영공시
		@RequestMapping(value="/exceldownload/module/{menuCode}_maPuNoti_{bbsBcId}.do")
		public ModelAndView selectMngrMaPuNotiExcelDown(@PathVariable String menuCode,
				@PathVariable("bbsBcId") String bbsBcId, ModelMap model,
				HttpServletRequest request) throws IOException, SQLException{

			ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);
			Map paramMap = CommUtil.getParameterMap(request);

			List<ItgMap> resultList = excelDownloadCustomService.selectMngrMaPuNotiData(bbsBcId);

			paramMap.put("dataList", resultList);
			paramMap.put("totalNum", resultList.size());
			mav.addObject("data", paramMap);

			//다운로드에 사용되어질 엑셀파일 템플릿
			mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrMaPuNotiData");
			//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
			mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "경영공시-" + CommUtil.getDatePattern("yyyy-MM-dd"));
			return mav;
		}

}