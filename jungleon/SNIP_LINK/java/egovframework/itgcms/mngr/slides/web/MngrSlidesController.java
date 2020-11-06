package egovframework.itgcms.mngr.slides.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.site.service.MngrSiteSearchVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.core.slides.service.MngrSlidesService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;


/**
 * @파일명 : MngrSlidesController.java
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
public class MngrSlidesController {

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/** MngrSlidesService */
	@Resource(name = "mngrSlidesService")
	private MngrSlidesService mngrSlidesService;

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	private static final Logger logger = LogManager.getLogger(MngrSlidesController.class);

	/**
	 * 슬라이드 셋 목록을 조회한다. (paging)
	 * @param request - 조회할 정보가 담긴 PopopSearchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/slides/slides_list.do")
	public String selectMngrSlidesList(@RequestParam HashMap<String,String> paramMap, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		/* S:사이트코드 설정*/
		paramMap.put("siteCode", siteCode);

		/* E:사이트코드 설정*/

		MngrSiteSearchVO mngrSiteSearchVO = new MngrSiteSearchVO();
		mngrSiteSearchVO.setId(siteCode);
		MngrSiteVO mngrSiteVO =  mngrSiteService.getSiteView(mngrSiteSearchVO);

		ItgMap searchVO = new ItgMap();
		searchVO.putAll(paramMap);
		searchVO.replace("slidesIdx", "");
		searchVO.replace("useyn", "");

		List<ItgMap> slidesList = mngrSlidesService.selectMngrSlidesList(searchVO);
		//List<ItgMap> resultList = new ArrayList();
		int totCnt = mngrSlidesService.mngrSlidesListTotCnt(searchVO);

		for(int i=0;i<totCnt;i++){

			ItgMap itemParamVO = new ItgMap();
			itemParamVO.put("slidesIdx", slidesList.get(i).get("slidesIdx"));
			slidesList.get(i).put("itemList", mngrSlidesService.mngrSlideItemList(itemParamVO));

		}

		model.addAttribute("mngrSiteVO", mngrSiteVO);
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("resultList", slidesList);
		model.addAttribute("listNo", totCnt);

		return "itgcms/mngr/slides/slides_list";
	}

	/**
	 * 슬라이드 셋 등록 페이지
	 * @param request
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/slides/slides_input.do")
	public String mngrSlidesRegist(HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		ItgMap searchVO = new ItgMap();
		searchVO.put("act", "REGIST");
		model.addAttribute("searchVO", searchVO);

		return "itgcms/mngr/slides/slides_view";
	}

	/**
	 * 슬라이드 셋 수정/조회 페이지
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */

	@RequestMapping(value = "/_mngr_/slides/slides_view.do")
	public String mngrSlidesView(@RequestParam HashMap<String,String> map, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		ItgMap searchVO = new ItgMap();
		searchVO.putAll(map);
		searchVO.put("act", "UPDATE");

		ItgMap result = mngrSlidesService.selectMngrSlides(searchVO);

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("result", result);

		return "itgcms/mngr/slides/slides_view";
	}

	/**
	 * 슬라이드 셋의 저장 처리
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/slides/slides_input_proc.do")
	public String insertMngrSlidesProc(@RequestParam HashMap<String,String> map, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		ItgMap paramVO = new ItgMap();
		paramVO.putAll(map);

		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  paramVO.get("slidesName")  , "")	)) return CommUtil.doComplete(model, "오류", "슬라이드 셋 이름을 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("slidesCode")  , "")	)) return CommUtil.doComplete(model, "오류", "슬라이드 셋 코드를 입력 해 주세요.", "history.back();");

		paramVO.put("slidesType", "slide"); //슬라이드 셋 타입 고정(추후업데이트 예정 슬라이드기본, 이미지 등)
		paramVO.put("regmemid", CommUtil.getMngrMemId());

		mngrSlidesService.insertMngrSlidesProc(paramVO);

		return CommUtil.doComplete(model, "완료", "등록 되었습니다.", "location.href='slides_list.do'");
	}

	/**
	 * 슬라이드 셋 수정 처리
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/slides/slides_edit_proc.do")
	public String updateMngrSlidesProc(@RequestParam HashMap<String,String> map, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		ItgMap paramVO = new ItgMap();
		paramVO.putAll(map);

		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  paramVO.get("slidesIdx")  , "")	)) return CommUtil.doComplete(model, "오류", "템플릿 정보가 올바르지 않습니다.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("slidesName")  , "")	)) return CommUtil.doComplete(model, "오류", "템플릿 이름을 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("slidesCode")  , "")	)) return CommUtil.doComplete(model, "오류", "템플릿 코드를 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("useyn")  , "")	)) return CommUtil.doComplete(model, "오류", "사용여부를 입력 해 주세요.", "history.back();");

		paramVO.put("slidesType", "slide"); //슬라이드 셋 타입 고정(추후업데이트 예정 슬라이드기본, 이미지 등)
		paramVO.put("updmemid", CommUtil.getMngrMemId());

		mngrSlidesService.updateMngrSlidesProc(paramVO);

		return CommUtil.doComplete(model, "완료", "수정 되었습니다.", "location.href='slides_list.do'");
	}

	/**
	 * 슬라이드 셋 삭제 처리
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/slides/slides_delete_proc.do")
	public String deleteMngrSlidesProc(@RequestParam HashMap<String,String> map, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		ItgMap paramVO = new ItgMap();
		paramVO.putAll(map);

		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  paramVO.get("slidesIdx")  , "")	)) return CommUtil.doComplete(model, "오류", "템플릿 정보가 올바르지 않습니다.", "history.back();");

		paramVO.put("delmemid", CommUtil.getMngrMemId());

		mngrSlidesService.deleteMngrSlidesProc(paramVO);

		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='slides_list.do'");
	}


	/**
	 * 슬라이드 아이템 등록 페이지
	 * @param request
	 * @param model
	 * @return "itgcms/mngr/slides/mngrSlideItemRegist"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/slides/slides_input_item.do")
	public String mngrSlideItemRegist(@RequestParam HashMap<String,String> map, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		ItgMap searchVO = new ItgMap();
		searchVO.putAll(map);
		searchVO.put("act", "REGIST");
		model.addAttribute("searchVO", searchVO);

		return "itgcms/mngr/slides/slides_input_item";
	}

	/**
	 * 슬라이드 아이템 수정/조회 페이지
	 * @param map
	 * @param model
	 * @param request
	 * @return "itgcms/mngr/slides/mngrSlideItemRegist"
	 * @throws IOException, SQLException, RuntimeException
	 */

	@RequestMapping(value = "/_mngr_/slides/slides_view_item.do")
	public String mngrSlideItemView(@RequestParam HashMap<String,String> map, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		ItgMap searchVO = new ItgMap();
		searchVO.putAll(map);
		searchVO.put("act", "UPDATE");

		if("".equals( CommUtil.isNull(  searchVO.get("slitemIdx")  , "")	)) return CommUtil.doComplete(model, "오류", "슬라이드 아이템 정보가 올바르지 않습니다.", "history.back();");

		ItgMap result = mngrSlidesService.selectMngrSlideItem(searchVO);

		searchVO.put("slidesIdx", result.get("slidesIdx"));
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("result", result);

		return "itgcms/mngr/slides/slides_input_item";
	}

	/**
	 * 슬라이드 아이템의 저장 처리
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/slides/slides_input_item_proc.do")
	public String insertSlideItemProc(final MultipartHttpServletRequest multiRequest, @RequestParam HashMap<String,String> map, ModelMap model) throws IOException, SQLException, RuntimeException {

		ItgMap paramVO = new ItgMap();
		paramVO.putAll(map);

		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  paramVO.get("slidesIdx")  , "")	)) return CommUtil.doComplete(model, "오류", "슬라이드 셋 정보가 올바르지 않습니다.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("slitemTitle")  , "")	)) return CommUtil.doComplete(model, "오류", "제목을 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("useyn")  , "")	)) return CommUtil.doComplete(model, "오류", "사용여부를 입력 해 주세요.", "history.back();");

		// 메인 이미지 파일첨부여부와 이미지인지만 확인
		String errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "slitemImg", "", true, "required");
		if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
		if("".equals( CommUtil.isNull(  paramVO.get("slitemImgalt")  , "")	)) return CommUtil.doComplete(model, "오류", "메인이미지 대체텍스트를 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("slitemLinkgubun")  , "")	)){ return CommUtil.doComplete(model, "오류", "링크구분을 입력 해 주세요.", "history.back();");}
		else if(!"0".equals( CommUtil.isNull(  paramVO.get("slitemLinkgubun")  , ""))){
			// 링크이미지 컨트롤러에서는 파일첨부여부와 이미지인지만 확인
			errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "slitemLinktimg", "", true, "");
			errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "slitemLinksimg", "", true, "");
			if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
			if("".equals( CommUtil.isNull(  paramVO.get("slitemLinkurl")  , "")	)) return CommUtil.doComplete(model, "오류", "링크주소를 입력 해 주세요.", "history.back();");
		}

		if("".equals( CommUtil.isNull(  paramVO.get("slitemOrder")  , "")	)) return CommUtil.doComplete(model, "오류", "순서를 입력 해 주세요.", "history.back();");

		paramVO.put("slidesType", "slide"); //슬라이드 셋 타입 고정(추후업데이트 예정 슬라이드기본, 이미지 등)
		paramVO.put("regmemid", CommUtil.getMngrMemId());

		//impl 에서 데이터 저장 및 파일 첨부 처리
		mngrSlidesService.insertSlideItemProc(paramVO, multiRequest); //로직처리는 impl에서(transaction)

		return CommUtil.doCompleteUrl(model, "완료", "등록 되었습니다.", "slides_list.do");
	}

	/**
	 * 슬라이드 아이템 수정 처리
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/slides/slides_update_item_proc.do")
	public String updateMngrSlideItemProc(final MultipartHttpServletRequest multiRequest, @RequestParam HashMap<String,String> map, ModelMap model) throws IOException, SQLException, RuntimeException {

		ItgMap paramVO = new ItgMap();
		paramVO.putAll(map);

		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  paramVO.get("slitemIdx")  , "")	)) return CommUtil.doComplete(model, "오류", "슬라이드 아이템 정보가 올바르지 않습니다.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("slitemTitle")  , "")	)) return CommUtil.doComplete(model, "오류", "제목을 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("useyn")  , "")	)) return CommUtil.doComplete(model, "오류", "사용여부를 입력 해 주세요.", "history.back();");
		// 메인 이미지 파일첨부여부와 이미지인지만 확인
		String errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "slitemImg", "", true, "");
		if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
		if("".equals( CommUtil.isNull(  paramVO.get("slitemImgalt")  , "")	)) return CommUtil.doComplete(model, "오류", "메인이미지 대체텍스트를 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("slitemLinkgubun")  , "")	)){ return CommUtil.doComplete(model, "오류", "링크구분을 입력 해 주세요.", "history.back();");}
		else if(!"0".equals( CommUtil.isNull(  paramVO.get("slitemLinkgubun")  , ""))){
			// 링크이미지 컨트롤러에서는 파일첨부여부와 이미지인지만 확인
			errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "slitemLinktimg", "", true, "");
			errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "slitemLinksimg", "", true, "");
			if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
			if("".equals( CommUtil.isNull(  paramVO.get("slitemLinkurl")  , "")	)) return CommUtil.doComplete(model, "오류", "링크주소를 입력 해 주세요.", "history.back();");
		}

		paramVO.put("updmemid", CommUtil.getMngrMemId());

		mngrSlidesService.updateMngrSlideItemProc(paramVO, multiRequest);

		return CommUtil.doCompleteUrl(model, "완료", "수정 되었습니다.", "slides_view_item.do");
	}

	/**
	 * 슬라이드 아이템 삭제 처리
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/slides/slides_delete_item_proc.do")
	public String deleteMngrSlideItemProc(@RequestParam HashMap<String,String> map, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		ItgMap paramVO = new ItgMap();
		paramVO.putAll(map);

		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  paramVO.get("slitemIdx")  , "")	)) return CommUtil.doComplete(model, "오류", "아이템 정보가 올바르지 않습니다.", "history.back();");

		paramVO.put("delmemid", CommUtil.getMngrMemId());

		mngrSlidesService.deleteMngrSlideItemProc(paramVO);

		return CommUtil.doCompleteUrl(model, "완료", "삭제 되었습니다.", "slides_list.do");
	}
}
