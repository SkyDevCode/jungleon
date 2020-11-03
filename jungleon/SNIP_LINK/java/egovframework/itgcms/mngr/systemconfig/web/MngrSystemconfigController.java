package egovframework.itgcms.mngr.systemconfig.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.managerlog.service.MngrManagerLogService;
import egovframework.itgcms.core.managerlog.service.MngrManagerLogVO;
import egovframework.itgcms.core.site.service.MngrSiteSearchVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.core.slides.service.MngrSlidesService;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.core.systemconfig.service.SystemconfigVO;
import egovframework.itgcms.core.templeteconfig.service.TempleteconfigService;
import egovframework.itgcms.module.socialmedia.service.SocialMediaKeyVO;
import egovframework.itgcms.module.socialmedia.service.SocialmediaService;
import egovframework.itgcms.util.CommUtil;

/**
 * @파일명 : MngrSystemconfigController.java
 * @파일정보 : 시스템 환경설정 관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2016. 2. 22. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class MngrSystemconfigController {

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	/** TempleteconfigService */
	@Resource(name = "templeteconfigService")
	private TempleteconfigService templeteconfigService;

	/** MngrSlidesService */
	@Resource(name = "mngrSlidesService")
	private MngrSlidesService mngrSlidesService;

	@Resource(name="socialmediaService")
	private SocialmediaService socialmediaService;

	/** MngrAuthorityService */
	@Resource(name = "mngrManagerLogService")
	private MngrManagerLogService mngrManagerLogService;

	private static final Logger logger = LogManager.getLogger(MngrSystemconfigController.class);

	@RequestMapping(value = "/_mngr_/systemconfig/basic_view.do")
	public String mngrSystemconfigView(HttpServletRequest request, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException {

		//model.addAttribute("mngrSessionVO", CommUtil.getMngrSessionVO());
		model.addAttribute("systemconfigVO", CommUtil.getSystemconfigVO());
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());

		return "itgcms/mngr/systemconfig/basic_view";
	}

	@RequestMapping(value = "/_mngr_/systemconfig/basic_edit_proc.do")
	public String mngrSystemconfigEditProc(@ModelAttribute("systemconfigVO") SystemconfigVO systemconfigVO, final MultipartHttpServletRequest multiRequest , ModelMap model) throws IOException, SQLException, RuntimeException {

		SystemconfigVO oldSystemconfigVO = CommUtil.getSystemconfigVO();

		if(CommUtil.empty(systemconfigVO.getDomainAddr())) systemconfigVO.setDomainAddr(oldSystemconfigVO.getDomainAddr());
		if(CommUtil.empty(systemconfigVO.getDefaultSite())) systemconfigVO.setDefaultSite(oldSystemconfigVO.getDefaultSite());

		CommUtil.setFileObject(systemconfigVO, "systemconfig");

		return CommUtil.doComplete(model, "완료", "저장이 완료되었습니다.", "location.href='basic_view.do';");
	}

	@RequestMapping(value = "/_mngr_/systemconfig/site_view.do")
	public String mngrSiteconfigView(HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		MngrSiteSearchVO mngrSiteSearchVO = new MngrSiteSearchVO();
		mngrSiteSearchVO.setId(siteCode);
		MngrSiteVO mngrSiteVO =  mngrSiteService.getSiteView(mngrSiteSearchVO);

		List<?> templeteList = templeteconfigService.getTempleteconfigList(mngrSiteSearchVO);

		ItgMap paramVO = new ItgMap();
		paramVO.put("useyn", "Y");
		paramVO.put("siteCode", siteCode);
		List<ItgMap> slidesList = mngrSlidesService.getMngrSlidesList(paramVO);

		model.addAttribute("siteCode", siteCode);
		socialmediaService.getSocialMediaUsingKeys(model);
		List<ItgMap> smkeyList = socialmediaService.selectSocialMediaKeys(paramVO);
		model.addAttribute("smkeyList", smkeyList);
		model.addAttribute("mngrSiteVO", mngrSiteVO);
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());
		model.addAttribute("slidesList", slidesList);
		model.addAttribute("templeteList", templeteList);
		model.addAttribute("siteconfigVO", CommUtil.getSiteconfigVO(siteCode));

		return "itgcms/mngr/systemconfig/site_view";
	}

	@RequestMapping(value = "/_mngr_/systemconfig/site_edit_proc.do")
	public String mngrSiteconfigEditProc(@ModelAttribute("siteconfigVO") SiteconfigVO siteconfigVO, final MultipartHttpServletRequest multiRequest, ModelMap model) throws IOException, SQLException, RuntimeException {
		String siteCode = CommUtil.isNull(multiRequest.getParameter("siteCode"), "");
		if("".equals(siteCode)){
			return CommUtil.doComplete(model, "오류", "사이트 정보가 올바르지 않습니다.", "history.back();");
		}

		String oldUnderConstrImg = CommUtil.isNull(multiRequest.getParameter("oldUnderConstrImg"), "");

		if("1".equals(siteconfigVO.getUnderConstr())){
			// 메인 이미지 파일첨부여부와 이미지인지만 확인
			if("".equals(oldUnderConstrImg)){
				String errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "underConstrImg", "", true, "required");
				if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
			}else{
				String errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "underConstrImg", "", true, "");
				if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
			}
		}

		try {

			//파일첨부처리
			if("1".equals(siteconfigVO.getUnderConstr())){
				HashMap hmFile = CommUtil.fileUpload(multiRequest.getFileMap(), "underConstrImg", "system");

				if(hmFile == null){
					siteconfigVO.setUnderConstrImg(oldUnderConstrImg);
				}else{
					siteconfigVO.setUnderConstrImg((String)hmFile.get("F_SAVENAME"));
				}
			}else{
				siteconfigVO.setUnderConstrImg(oldUnderConstrImg);
			}

		} catch (IndexOutOfBoundsException | NullPointerException e) {
			return CommUtil.doComplete(model, "오류", "점검중 이미지 첨부 중 오류가 발생하였습니다. \\n다시 시도해주세요.", "history.back();");
		}

		if("2".equals(siteconfigVO.getSiteLogogubun())){
			// 메인 이미지 파일첨부여부와 이미지인지만 확인
			if("".equals(siteconfigVO.getOldsiteLogo())){
				String errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "siteLogo", "", true, "required");
				if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
			}else{
				String errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 10240000, "siteLogo", "", true, "");
				if(!"".equals(errMsg)){return CommUtil.doComplete(model, "오류", errMsg, "history.back();");}
			}
		}

		try {
			String[] boardNames = multiRequest.getParameterValues("mainPageBoard");
			String[] boardLimit = multiRequest.getParameterValues("mainPageBoardLimit");


			SiteconfigVO originConf = CommUtil.getSiteconfigVO(siteCode);

			// 실제 Data 를 가지고 와서 확인 한번 필요
			Map<String, String[]> tmpMap = originConf.getRecentBoardMap();

			String[] boardDesc = new String[boardNames != null ? boardNames.length : 0];
			for (int i = 0; i < boardDesc.length ; i++) {
				boardDesc[i] = boardNames[i].concat("/").concat(boardLimit[i]);
			}

			if (tmpMap == null) {
				tmpMap = new HashMap<>();
			}

			tmpMap.put(siteconfigVO.getTempCode(), boardDesc);
			siteconfigVO.setRecentBoardMap(tmpMap);

		} catch (IndexOutOfBoundsException | NullPointerException e) {
			return CommUtil.doComplete(model, "오류", "메인페이지 게시판 설정에 문제가 있습니다. \\n창을 새로고침한 후 다시 시도해주세요.", "history.back();");
		}

		try {

			//파일첨부처리
			if("2".equals(siteconfigVO.getSiteLogogubun())){
				HashMap hmFile = CommUtil.fileUpload(multiRequest.getFileMap(), "siteLogo", "system");

				if(hmFile == null){
					siteconfigVO.setSiteLogo(siteconfigVO.getOldsiteLogo());
				}else{
					siteconfigVO.setSiteLogo((String)hmFile.get("F_SAVENAME"));
				}
			}else{
				siteconfigVO.setSiteLogo(siteconfigVO.getOldsiteLogo());
			}

		} catch (IndexOutOfBoundsException | NullPointerException e) {
			return CommUtil.doComplete(model, "오류", "로고이미지 첨부 중 오류가 발생하였습니다. \\n다시 시도해주세요.", "history.back();");
		}


		socialmediaService.markAccessible(multiRequest, siteCode);

		String[] arrUserSnsShareYn = multiRequest.getParameterValues("userSnsShareYn");
		String userSnsShareYn = CommUtil.arrayToString(arrUserSnsShareYn);
		userSnsShareYn = userSnsShareYn.substring(1, userSnsShareYn.length()-1);
		siteconfigVO.setUserSnsShareYn(userSnsShareYn);

		SiteconfigVO oldSiteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		//로그인설정값 유지
		siteconfigVO.setLoginMenuCode(oldSiteconfigVO.getLoginMenuCode());
		siteconfigVO.setMemSessionTime(oldSiteconfigVO.getMemSessionTime());
		siteconfigVO.setLoginRtType(oldSiteconfigVO.getLoginRtType());
		siteconfigVO.setLoginRtMenuCode(oldSiteconfigVO.getLoginRtMenuCode());
		//사이트맵설정값 유지
		siteconfigVO.setSitemapMenuCode(oldSiteconfigVO.getSitemapMenuCode());
		//통합검색설정값 유지
		siteconfigVO.setTotalSearchMenuCode(oldSiteconfigVO.getTotalSearchMenuCode());
		//회원가입설정값 유지
		siteconfigVO.setMemberRegMenuCode(oldSiteconfigVO.getMemberRegMenuCode());
		//아이디 비밀번호 찾기 설정값 유지
		siteconfigVO.setFindIdPwdMenuCode(oldSiteconfigVO.getFindIdPwdMenuCode());
		//비밀번호 변경 설정값 유지
		siteconfigVO.setPassChangeMenuCode(oldSiteconfigVO.getPassChangeMenuCode());

		CommUtil.setFileObject(siteconfigVO, "siteconfig", siteCode);

		return CommUtil.doComplete(model, "완료", "저장이 완료되었습니다.", "location.href='site_view.do?siteCode="+siteCode+"';");
	}


}