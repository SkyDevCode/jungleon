package egovframework.itgcms.mngr.popup.web;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.popup.service.MngrPopupSearchVO;
import egovframework.itgcms.core.popup.service.MngrPopupService;
import egovframework.itgcms.core.popup.service.MngrPopupVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * @파일명 : MngrPopupController.java
 * @파일정보 : 팝업 등록 관리
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
public class MngrPopupController {

	/** MngrPopupService */
	@Resource(name = "mngrPopupService")
	private MngrPopupService mngrPopupService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	private static final Logger logger = LogManager.getLogger(MngrPopupController.class);

	@RequestMapping(value = "/_mngr_/popup/popup{popupType}_comm.do")
	public String mngrPopup(@PathVariable("popupType") String popupType, @ModelAttribute("mngrPopupSearchVO") MngrPopupSearchVO mngrPopupSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {

		/**	 팝업구분(1:존, 2:창, 3:배너)	 */
		mngrPopupSearchVO.setSchPopupType(popupType);

		mngrPopupSearchVO.setSchM(CommUtil.isNull(mngrPopupSearchVO.getSchM(), "list"));
    	model.addAttribute("mngrPopupSearchVO",mngrPopupSearchVO);
    	return "itgcms/mngr/popup/popup_comm";
	}

	/**
	 * 글 목록을 조회한다. (paging)
	 * @param mngrPopupSearchVO - 조회할 정보가 담긴 PopopSearchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/popup/popup{popupType}_list.do")
	public String selectMngrPopupList(@PathVariable("popupType") String popupType, @ModelAttribute("searchVO") MngrPopupSearchVO mngrPopupSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {

		/* 팝업구분(1:존, 2:창, 3:배너)	 */
		mngrPopupSearchVO.setSchPopupType(popupType);

		/* 현재 사이트 설정*/
		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		mngrPopupSearchVO.setSchSitecode(mngrSessionVO.getCurrSiteCode());

		/** EgovPropertyService */
/*		mngrPopupSearchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		mngrPopupSearchVO.setPageSize(propertiesService.getInt("pageSize"));*/

		mngrPopupSearchVO.setPageUnit(Integer.parseInt(mngrPopupSearchVO.getViewCount()));//viewCount
		mngrPopupSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(mngrPopupSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(mngrPopupSearchVO.getPageUnit());
		paginationInfo.setPageSize(mngrPopupSearchVO.getPageSize());

		mngrPopupSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mngrPopupSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mngrPopupSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> resultList = mngrPopupService.selectMngrPopupList(mngrPopupSearchVO);
		model.addAttribute("resultList", resultList);
		int totCnt = mngrPopupService.mngrPopupListTotCnt(mngrPopupSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
		model.addAttribute("POPUP_CONFIG", getConfig(mngrPopupSearchVO.getSchPopupType()));
		model.addAttribute("popupTabList", CommUtil.getConfigFromXml("popup"));
		model.addAttribute("searchVO", mngrPopupSearchVO);

		return "itgcms/mngr/popup/popup_list";
	}

	@RequestMapping(value = "/_mngr_/popup/popup{popupType}_input.do")
	public String mngrPopupRegist(@PathVariable("popupType") String popupType, @ModelAttribute("searchVO") MngrPopupSearchVO mngrPopupSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {

		/**	 팝업구분(1:존, 2:창, 3:배너)	 */
		mngrPopupSearchVO.setSchPopupType(popupType);

		mngrPopupSearchVO.setAct("REGIST");
		MngrPopupVO popupVO = new MngrPopupVO();
		popupVO.setPopupWidth("300");
		popupVO.setPopupHeight("400");
		popupVO.setPopupSdt(CommUtil.getDatePattern("yyyy-MM-dd"));
		popupVO.setPopupEdt(CommUtil.dateAdd(CommUtil.getDatePattern("yyyy-MM-dd"), 30));
		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		List<MngrSiteVO> siteList = mngrSiteService.getMngrMySiteList(mngrSessionVO);
		model.addAttribute("siteList", siteList);
		model.addAttribute("result", popupVO);
		model.addAttribute("searchVO", mngrPopupSearchVO);
		model.addAttribute("POPUP_CONFIG",getConfig(mngrPopupSearchVO.getSchPopupType()));
		return "itgcms/mngr/popup/popup_edit";
	}

	@RequestMapping(value = "/_mngr_/popup/popup{popupType}_edit.do")
	public String selectMngrPopupView(@PathVariable("popupType") String popupType, @ModelAttribute("searchVO") MngrPopupSearchVO mngrPopupSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {

		/**	 팝업구분(1:존, 2:창, 3:배너)	 */
		mngrPopupSearchVO.setSchPopupType(popupType);

		mngrPopupSearchVO.setAct("UPDATE");
		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		List<MngrSiteVO> siteList = mngrSiteService.getMngrMySiteList(mngrSessionVO);
		model.addAttribute("siteList", siteList);
		MngrPopupVO result=mngrPopupService.selectMngrPopupView(mngrPopupSearchVO);
		result.setPopupSdt(result.getPopupSdt().substring(0, 10));
		result.setPopupEdt(result.getPopupEdt().substring(0, 10));
		model.addAttribute("result", result);
		model.addAttribute("searchVO", mngrPopupSearchVO);
		model.addAttribute("POPUP_CONFIG",getConfig(mngrPopupSearchVO.getSchPopupType()));
		return "itgcms/mngr/popup/popup_edit";
	}

	@RequestMapping(value = "/_mngr_/popup/popup{popupType}_input_proc.do")
	public String insertMngrPopupProc(@PathVariable("popupType") String popupType, final MultipartHttpServletRequest multiRequest,@ModelAttribute("searchVO") MngrPopupSearchVO mngrPopupSearchVO,@RequestParam("menuContents") String menuContents, ModelMap model, MngrPopupVO popupVO) throws IOException, SQLException, RuntimeException {

		/**	 팝업구분(1:존, 2:창, 3:배너)	 */
		mngrPopupSearchVO.setSchPopupType(popupType);

		// 컨트롤러에서는 파일첨부여부와 이미지인지만 확인
		String errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "popupImg", "", true, ""); //이미지파일체크, 용량체크
		if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
		String errMsg2 = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "popupFile", "", false, ""); //첨부파일체크, 용량체크
		if(!"".equals(errMsg2)){return CommUtil.doComplete(model, "오류", errMsg2, "history.back();");}
		String errMsg3 = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "mvFile", "", false, ""); //동영상파일체크, 용량체크
		if(!"".equals(errMsg3)){return CommUtil.doComplete(model, "오류", errMsg3, "history.back();");}

		//impl 에서 데이터 저장 및 파일 첨부 처리
		popupVO.setRegmemid(CommUtil.getMngrMemId());
		if (!"".equals(menuContents)) {
			popupVO.setEdit_contents(menuContents);
		}

		mngrPopupService.insertMngrPopupProc(popupVO, multiRequest); //로직처리는 impl에서(transaction)
		model.addAttribute("POPUP_CONFIG",getConfig(mngrPopupSearchVO.getSchPopupType()));

		return CommUtil.doComplete(model, "완료", "등록 되었습니다.", "location.href='?schPopupType="+mngrPopupSearchVO.getSchPopupType()+"'");
	}

	@RequestMapping(value = "/_mngr_/popup/popup{popupType}_edit_proc.do")
	public String updateMngrPopupProc(@PathVariable("popupType") String popupType, final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") MngrPopupSearchVO mngrPopupSearchVO,@RequestParam("menuContents") String menuContents, ModelMap model, MngrPopupVO popupVO) throws IOException, SQLException, RuntimeException {

		/**	 팝업구분(1:존, 2:창, 3:배너)	 */
		mngrPopupSearchVO.setSchPopupType(popupType);

		//첨부파일 처리
		// 1. 이미지파일인지, 용량제한에 적합한지 체크
		// 2. 수정시에는 oldFil에 값이 있을경우 첨부하지 않아도 된다.
		String errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "popupImg", "", true, ""); //이미지파일체크, 용량체크
		if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
		String errMsg2 = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "popupFile", "", false, ""); //첨부파일체크, 용량체크
		if(!"".equals(errMsg2)){return CommUtil.doComplete(model, "오류", errMsg2, "history.back();");}
		String errMsg3 = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "mvFile", "", false, ""); //동영상파일체크, 용량체크
		if(!"".equals(errMsg3)){return CommUtil.doComplete(model, "오류", errMsg3, "history.back();");}

		//impl 에서 데이터 저장 및 파일 첨부 처리
		// 데이터 저장 처리시에 첨부파일 첨부가 없으면 오류 출력 함
		popupVO.setUpdmemid(CommUtil.getMngrMemId());
		if (!"".equals(menuContents)) {
			popupVO.setEdit_contents(menuContents);
		}
		errMsg = mngrPopupService.updateMngrPopupProc(popupVO, multiRequest); //로직처리는 impl에서(transaction)
		if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
		model.addAttribute("POPUP_CONFIG",getConfig(mngrPopupSearchVO.getSchPopupType()));
		mngrPopupSearchVO.setSchM("view");
		return CommUtil.doComplete(model, "완료", "수정 되었습니다.", "location.href='?"+mngrPopupSearchVO.getQuery()+"'");
	}

	@RequestMapping(value = "/_mngr_/popup/popup{popupType}_delete_proc.do")
	public String deleteMngrPopupProc(@PathVariable("popupType") String popupType, @ModelAttribute("searchVO") MngrPopupSearchVO mngrPopupSearchVO, ModelMap model, MngrPopupVO popupVO) throws IOException, SQLException, RuntimeException {

		/**	 팝업구분(1:존, 2:창, 3:배너)	 */
		mngrPopupSearchVO.setSchPopupType(popupType);

		popupVO.setDelmemid(CommUtil.getMngrMemId());
		mngrPopupService.deleteMngrPopupProc(popupVO);
		mngrPopupSearchVO.setSchM("list");
		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='?"+mngrPopupSearchVO.getQuery()+"'");
	}

	@RequestMapping(value = "/_mngr_/popup/popup{popupType}_delete_chkProc.do")
	public String deleteMngrPopupChkProc(@PathVariable("popupType") String popupType, @ModelAttribute("searchVO") MngrPopupSearchVO mngrPopupSearchVO, ModelMap model, MngrPopupVO popupVO, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		/**	 팝업구분(1:존, 2:창, 3:배너)	 */
		mngrPopupSearchVO.setSchPopupType(popupType);

		popupVO.setDelmemid(CommUtil.getMngrMemId());
		mngrPopupService.deleteMngrPopupChkProc(popupVO);
		mngrPopupSearchVO.setSchM("list");
		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='?"+mngrPopupSearchVO.getQuery()+"'");
	}

	private HashMap getConfig(String type) throws IOException, SQLException, RuntimeException {
		HashMap hm = CommUtil.getConfigFromXml("popup", type);
		if(hm == null) throw new RuntimeException("팝업 type 오류");
		return hm;
	}
}
