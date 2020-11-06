package egovframework.itgcms.project.newsletter.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.EmailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.project.newsletter.service.NewsletterService;
import egovframework.itgcms.project.totalTable.service.TotalTbSearchVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class NewsletterController {

	@Autowired
	NewsletterService newsletterService;


	@RequestMapping(value="/_mngr_/module/{menuCode}_list_newsletter.do")
	public String selectMngrNewsletterList(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") DefaultVO searchVO,
			HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException{

		ItgMap itgMap = CommUtil.getParameterEMap(request);

		if ("regist".equals(itgMap.get("schM"))) {

			return "itgcms/project/newsletter/mngrNewsletterRegist";
		} else if ("update".equals(itgMap.get("schM"))) {

			ItgMap result = newsletterService.selectNewsletterView(itgMap);
			List<ItgMap> resultArticleList = newsletterService.selectNewsletterArticleView(itgMap);

			int arSjCount = resultArticleList.size();
			if (arSjCount == 0) {
				arSjCount = 1;
			} else {
				arSjCount = arSjCount + 1;
			}

			searchVO.setAct("UPDATE");
			model.addAttribute("result", result);
			model.addAttribute("resultArticleList", resultArticleList);
			model.addAttribute("resultListSize", arSjCount);
			model.addAttribute("menuCode", menuCode);
			return "itgcms/project/newsletter/mngrNewsletterRegist";
		}

		searchVO.setPageUnit(3);
		searchVO.setPageSize(10);

		int page = Integer.parseInt(searchVO.getPage());

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<ItgMap> resultList = newsletterService.selectNewsletterList(searchVO);
		List<ItgMap> resultArticleList = newsletterService.selectNewsletterArticleList(searchVO);

		int resultCnt = newsletterService.selectMngrNewsletterCnt(searchVO);

		paginationInfo.setTotalRecordCount(resultCnt);

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (resultCnt - ((page - 1) * paginationInfo.getRecordCountPerPage())));
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultArticleList", resultArticleList);

		model.addAttribute("menuCode", menuCode);

		return "itgcms/project/newsletter/mngrNewsletterList";
	}

	/**
	 * 등록
	 */
	@RequestMapping(value="/_mngr_/module/{menuCode}_proc_newsletter.do")
	public String mngrNewsletterProc (
						@PathVariable String menuCode,
						ModelMap model,
						MultipartHttpServletRequest multiRequest,
						HttpServletRequest request,
						HttpServletResponse response
						) throws IOException, SQLException  {

		ItgMap itgMap = CommUtil.getParameterEMap(request);
		itgMap.put("regmemid", CommUtil.getMngrMemId());

		String returnPage = CommUtil.doComplete(model, "오류", "등록중 오류가 발생했으니 잠시 후 다시 시도해주세요.", "history.back();");

		//썸네일 등록
		String nlThumb1Img = "";
		HashMap hmFile = CommUtil.fileUpload(multiRequest.getFileMap(), "nlThumb1", "newsletter", "", "");
		if(hmFile != null) {
			nlThumb1Img = CommUtil.isNull(hmFile.get("F_SAVENAME"), "");
		}

		itgMap.put("nlThumb1", nlThumb1Img);
		// 멀티 첨부파일
		itgMap.put("fileRelateId", CommUtil.isNull(itgMap.get("fileId"), ""));


		if(newsletterService.insertNewsletterProc(itgMap) > 0){

			returnPage = CommUtil.doComplete(model, "성공", "정상적으로 등록되었습니다.", "location.href='/_mngr_/module/"+menuCode+"_list_newsletter.do'");
		}

		return returnPage;
	}

	// 게시물 수정
	@RequestMapping(value = "/_mngr_/module/{menuCode}_update_newsletter.do")
	public String updateMngrNewsletter(  @PathVariable String menuCode
						          , ModelMap model
						          , @ModelAttribute("searchVO") DefaultVO searchVO
						          , MultipartHttpServletRequest multiRequest
						          , HttpServletRequest request
						          , HttpServletResponse response) throws IOException, SQLException {

		ItgMap itgMap = CommUtil.getParameterEMap(request);

		itgMap.put("updmemid", CommUtil.getMngrMemId());
		searchVO.setAct("UPDATE");

		if("".equals(CommUtil.isNull(itgMap.get("oldNlThumb1"), ""))) {
			String errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 1024000000, "nlThumb1Img", "", true, "required"); //첨부파일체크, 용량체크
			if(!"".equals(errMsg)) {
				return CommUtil.doComplete(model, "오류", errMsg, "history.back();");
			}
		}

		itgMap.put("nlThumb1", CustomUtil.fileUploadUpdate(multiRequest, "nlThumb1", CommUtil.isNull(itgMap.get("oldNlThumb1"), ""), "newsletter"));

		// 멀티 첨부파일
		itgMap.put("fileId", CommUtil.isNull(itgMap.get("fileId"), ""));

		if(newsletterService.updateMngrNewsletter(itgMap) < 1){
			return CommUtil.doComplete(model, "오류", "수정중 오류가 발생했으니 잠시 후 다시 시도해주세요.", "history.back();");
		}

		return CommUtil.doComplete(model, "성공", "정상적으로 등록되었습니다.", "location.href='/_mngr_/module/"+menuCode+"_list_newsletter.do'");
	}


	// 게시물 삭제
	@RequestMapping(value = "/_mngr_/module/{menuCode}_delete_newsletter.do")
	public String deleteMngrNewsletter(  @PathVariable String menuCode
							 	   , ModelMap model
							 	   , HttpServletRequest request) throws IOException, SQLException {

		ItgMap itgMap = CommUtil.getParameterEMap(request);
		String result = newsletterService.deleteMngrNewsletter(itgMap);
		if(!"".equals(CommUtil.isNull(result, ""))) {
			return CommUtil.doComplete(model, "오류", result, "history.back();");
		}

		return CommUtil.doComplete(model, "성공", "정상적으로 삭제되었습니다.", "location.href='/_mngr_/module/"+menuCode+"_list_newsletter.do?'");
	}

	// 게시물 멀티삭제
	@RequestMapping(value = "/_mngr_/module/{menuCode}_multiDelete_newsletter.do")
	public String mngrNewsletterMulriDelete (						@PathVariable String menuCode,
						@ModelAttribute("searchVO") DefaultVO searchVO,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws IOException, SQLException {

		if(searchVO.getChkId() == null || searchVO.getChkId().length == 0) {
			return CommUtil.doComplete(model, "오류", "삭제할 게시물을 선택해 주세요.", "history.back();");
		}

		int result = newsletterService.deleteNewsletterMulti(searchVO);

		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "삭제중 오류가 발생했습니다 .확인 후 다시 시도해 주세요.", "history.back();");
		}


		return CommUtil.doComplete(model, "성공", "정상적으로 삭제처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_list_newsletter.do?" + "'");

	}


	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrNewsletterExcelDown.do")
	public ModelAndView selectMngrNewsletterListExceDown(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") TotalTbSearchVO searchVO, HttpServletRequest request) throws IOException, SQLException{

		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);

		searchVO.setExcelDown("Y");

		List<ItgMap> resultList = newsletterService.selectNewsletterListAll(searchVO);

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dataList", resultList);

		//엑셀 템플릿에 넘겨줄 데이타
		mav.addObject("data", paramMap);

		//다운로드에 사용되어질 엑셀파일 템플릿
		mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrNewsletterListExcel");
		//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
		mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "소식지-" + CommUtil.getDatePattern("yyyy-MM-dd"));


		return mav;
	}



    /********************** E:관리자 **********************/

	/********************** S:사용자 **********************/

	@RequestMapping(value = "/{siteCode}/module/{menuCode}_newsletter.do")
	public String userNewslettrList(@PathVariable String siteCode,
									@PathVariable String menuCode,
									@ModelAttribute("searchVO") DefaultVO searchVO,
									ModelMap model) throws IOException, SQLException, RuntimeException, EmailException {

		searchVO.setPageUnit(3);
		searchVO.setPageSize(10);

		int page = Integer.parseInt(searchVO.getPage());

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<ItgMap> resultList = newsletterService.selectNewsletterListAll(searchVO);
		//List<ItgMap> resultList = newsletterService.selectNewsletterList(searchVO);


		List<ItgMap> resultOldnewsList = newsletterService.selectOldNewsList();
		int resultCnt = newsletterService.selectMngrNewsletterCnt(searchVO);

		paginationInfo.setTotalRecordCount(resultCnt);

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (resultCnt - ((page - 1) * paginationInfo.getRecordCountPerPage())));
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultOldnewsList", resultOldnewsList);

		return "itgcms/project/newsletter/userNewsletterList";
	}

	@RequestMapping(value = "/{siteCode}/module/{menuCode}_view_newsletterArticle.ajax")
	@ResponseBody
	public ItgMap newsletterArticleAjax (
								@PathVariable String siteCode,
								@PathVariable String menuCode,
								@RequestParam("nlaIdxStr") String nlaIdxStr,
								ModelMap model, HttpServletRequest request) throws IOException, SQLException {

		ItgMap result = newsletterService.selectNewsletterOne(nlaIdxStr);

		return result;
	}

	@RequestMapping(value = "/{siteCode}/module/{menuCode}_view_newsletterArticle.do")
	public String newsletterArticleView (
								@PathVariable String siteCode,
								@PathVariable String menuCode,
								@RequestParam("nlaIdxStr") String nlaIdxStr,
								ModelMap model) throws IOException, SQLException {

		ItgMap result = newsletterService.selectNewsletterOne(nlaIdxStr);

		model.addAttribute("result", result);

		return "itgcms/project/newsletter/userNewsletterView";
	}

	/********************** E:사용자 **********************/

}

