package egovframework.itgcms.project.cominfo.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.project.cominfo.service.CominfoSearchVO;
import egovframework.itgcms.project.cominfo.service.CominfoService;
import egovframework.itgcms.project.cominfo.service.CominfoVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class CominfoController {

	@Autowired
	CominfoService cominfoService;
	
	/********************** S:사용자 **********************/
    @RequestMapping(value = "/{siteCode}/module/{menuCode}_cominfoList.do")
	public String selectUserCominfoList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") CominfoSearchVO searchVO) throws IOException, SQLException {

    	if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");
    	// 성남 지역내 기업만 조회.
    	searchVO.setArrArea(CustomUtil.getSnipArea("value", true).split(","));
		if("list".equals(searchVO.getSchM())) {
			
			/** paging setting */
			int totCnt = cominfoService.selectCominfoListTotCnt(searchVO);
	
			// pagesize, viewcount => searchVO에 설정
			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);
	
			List<CominfoVO> resultList = cominfoService.selectCominfoList(searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
	
			model.addAttribute("resultList", resultList);
			model.addAttribute("areaList", CustomUtil.getSnipAreaList(true));
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/cominfo/userCominfoList";
		} else if("view".equals(searchVO.getSchM())) {
			CominfoVO result = cominfoService.selectCominfoView(searchVO);
			List<EgovMap> prevNext = cominfoService.selectCominfoViewPrevNext(searchVO);
			
			if(result == null) {
				return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
			}
			model.addAttribute("result", result);
			model.addAttribute("prevNext", prevNext);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/cominfo/userCominfoView";
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
	}
    @ResponseBody
	@RequestMapping(value="/{siteCode}/cominfo/userKsicSearch.ajax")
	public ModelMap  userKsicSearch(@PathVariable String siteCode, ModelMap model,
			@ModelAttribute("searchVO") DefaultVO searchVO) throws IOException, SQLException{
		
		model = new ModelMap();
		model.put("result", "1");
		model.put("message", "");
		try {
			List<EgovMap> resultList = cominfoService.selectKsicSearch(searchVO);
			model.put("data", resultList);
		}catch(Exception e) {
			model.put("result", "2");
			model.put("message", "데이터 조회 중 오류가 발생했습니다. 확인 후 다시 시도해 주세요");
		}
		
		return model;
	}
    /********************** E:사용자 **********************/
    
    /********************** S:관리자 **********************/
	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrCominfoList.do")
	public String selectMngrCominfoList(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") CominfoSearchVO searchVO) throws IOException, SQLException{

		searchVO.setRoot("_mngr_");
		if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");
		if("list".equals(searchVO.getSchM())) {
			/** paging setting */
			int totCnt = cominfoService.selectCominfoListTotCnt(searchVO);
	
			// pagesize, viewcount => searchVO에 설정
			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);
	
			List<CominfoVO> resultList = cominfoService.selectCominfoList(searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
	
			model.addAttribute("resultList", resultList);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/cominfo/mngrCominfoList";
		} else if("excel".equals(searchVO.getSchM())) {
			searchVO.setExcelDown("Y");
			List<CominfoVO> resultList = cominfoService.selectCominfoList(searchVO);
			
		} else if("view".equals(searchVO.getSchM())) {
			CominfoVO result = cominfoService.selectCominfoView(searchVO);
			if(result == null) {
				return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
			}
			model.addAttribute("result", result);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/cominfo/mngrCominfoView";
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
	}
	
	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrCominfoListExcelDown.do")
	public ModelAndView selectMngrCominfoListExceDown(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") CominfoSearchVO searchVO, HttpServletRequest request) throws IOException, SQLException{
		
		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);
		
		searchVO.setExcelDown("Y");
		List<CominfoVO> resultList = cominfoService.selectCominfoList(searchVO);
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dataList", resultList);

		//엑셀 템플릿에 넘겨줄 데이타
		mav.addObject("data", paramMap);

		//다운로드에 사용되어질 엑셀파일 템플릿
		mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrCominfoListExcel");
		//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
		mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "기업정보-" + CommUtil.getDatePattern("yyyy-MM-dd"));

		return mav;
	}
	
	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrCominfoUpdateProc.do")
	public String updateMngrCominfoProc(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") CominfoSearchVO searchVO, @ModelAttribute("cominfoVO") CominfoVO cominfoVO  ) throws IOException, SQLException{
		
		if("".equals(CommUtil.isNull(cominfoVO.getComNm(), ""))) return CommUtil.doComplete(model, "오류", "회사명을 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(cominfoVO.getZip(), ""))) return CommUtil.doComplete(model, "오류", "우편번호를 검색해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(cominfoVO.getAddr01(), ""))) return CommUtil.doComplete(model, "오류", "주소를 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(cominfoVO.getAddr02(), ""))) return CommUtil.doComplete(model, "오류", "상세 주소를 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(cominfoVO.getUnCd(), ""))) return CommUtil.doComplete(model, "오류", "산업분류를 선택해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(cominfoVO.getOfficeTel01(), ""))) return CommUtil.doComplete(model, "오류", "회사 전화번호 국번을 선택해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(cominfoVO.getOfficeTel02(), ""))) return CommUtil.doComplete(model, "오류", "회사 전화번호 앞자리를 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(cominfoVO.getOfficeTel03(), ""))) return CommUtil.doComplete(model, "오류", "회사 전화번호 뒷자리를 입력해 주세요.", "history.back();");
		
		// 주소로 지역 설정.
		cominfoVO.setAreaCd(CustomUtil.getSnipAddress2AreaCD(cominfoVO.getAddr01()));
		
		cominfoVO.setBusiRegNo(searchVO.getSchId());
		cominfoVO.setModId(CommUtil.getMngrMemId());
		int result = cominfoService.updateCominfo(cominfoVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "수정 내용이 없습니다.", "history.back();");
		}
		searchVO.setSchM("list");
		return CommUtil.doComplete(model, "성공", "정상적으로 수정처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_mngrCominfoList.do?" + searchVO.getQuery()+ "'");
	}
	
	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrCominfoDeleteProc.do")
	public String deleteMngrCominfoDeleteProc(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") CominfoSearchVO searchVO, @ModelAttribute("cominfoVO") CominfoVO cominfoVO  ) throws IOException, SQLException{
		
		cominfoVO.setBusiRegNo(searchVO.getSchId());
		cominfoVO.setModId(CommUtil.getMngrMemId());
		int result = cominfoService.deleteCominfoProc(cominfoVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "삭제 내용이 없습니다.", "history.back();");
		}
		searchVO.setSchM("list");
		return CommUtil.doComplete(model, "성공", "정상적으로 삭제처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_mngrCominfoList.do?" + searchVO.getQuery()+ "'");
	}
	
	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrCominfoMultiDeleteProc.do")
	public String deleteMngrCominfoMultiDeleteProc(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") CominfoSearchVO searchVO, @ModelAttribute("cominfoVO") CominfoVO cominfoVO  ) throws IOException, SQLException{
		
		if(searchVO.getChkId() == null || searchVO.getChkId().length == 0) {
			return CommUtil.doComplete(model, "오류", "삭제할 게시물을 선택해 주세요.", "history.back();");
		}
		
		int result = cominfoService.deleteCominfoMultiProc(searchVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "삭제중 오류가 발생했습니다 .확인 후 다시 시도해 주세요.", "history.back();");
		}
		searchVO.setSchM("list");
		return CommUtil.doComplete(model, "성공", "정상적으로 삭제처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_mngrCominfoList.do?" + searchVO.getQuery()+ "'");
	}
	
	@ResponseBody
	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrKsicSearch.ajax")
	public ModelMap  selectMngrKsicSearch(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") DefaultVO searchVO) throws IOException, SQLException{
		
		model = new ModelMap();
		model.put("result", "1");
		model.put("message", "");
		try {
			List<EgovMap> resultList = cominfoService.selectKsicSearch(searchVO);
			model.put("data", resultList);
		}catch(Exception e) {
			model.put("result", "2");
			model.put("message", "데이터 조회 중 오류가 발생했습니다. 확인 후 다시 시도해 주세요");
		}
		
		return model;
	}
    /********************** E:관리자 **********************/
}
