package egovframework.itgcms.mngr.site.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.menu.service.MngrMenuService;
import egovframework.itgcms.core.menu.service.MngrMenuVO;
import egovframework.itgcms.core.site.service.MngrSiteSearchVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.module.socialmedia.service.SocialMediaKeyVO;
import egovframework.itgcms.module.socialmedia.service.SocialmediaService;
import egovframework.itgcms.util.CommUtil;

/**
 * @파일명 : MngrSiteController.java
 * @파일정보 : 사이트 관리
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
public class MngrSiteController {

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	/** MngrMenuService */
	@Resource(name = "mngrMenuService")
	private MngrMenuService mngrMenuService;

	@Resource(name="socialmediaService")
	private SocialmediaService socialmediaService;

	private static final Logger logger = LogManager.getLogger(MngrSiteController.class);

	/**
	 * 사이트관리 목록
	 * @param mngrSiteSearchVO
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/site/sitemng_list.do")
	public String mngrSiteMain(@ModelAttribute("searchVO") MngrSiteSearchVO mngrSiteSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		model.addAttribute("resultList", mngrSiteService.selectMngrSiteList());
		return "itgcms/mngr/site/sitemng_list";
	}

	/**
	 * 사이트관리 수정
	 * @param mngrSiteSearchVO
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/site/sitemng_edit.do")
	public String selectSiteView(@ModelAttribute("searchVO") MngrSiteSearchVO mngrSiteSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrSiteSearchVO.setAct("UPDATE");

		List<SocialMediaKeyVO> keyList = socialmediaService.getSocialMediaUsingKeys(model);

		for (SocialMediaKeyVO vo : keyList) {
			socialmediaService.getAccessToken(vo, mngrSiteSearchVO.getId());
		}

		model.addAttribute("result", mngrSiteService.selectSiteView(mngrSiteSearchVO));
		model.addAttribute("searchVO", mngrSiteSearchVO);
		return "itgcms/mngr/site/sitemng_edit";
	}


	/**
	 * 사이트관리 등록
	 * @param mngrSiteSearchVO
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/site/sitemng_input.do")
	public String mngrSiteRegist(@ModelAttribute("searchVO") MngrSiteSearchVO mngrSiteSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {
		mngrSiteSearchVO.setAct("REGIST");

		model.addAttribute("searchVO", mngrSiteSearchVO);
		return "itgcms/mngr/site/sitemng_edit";
	}

	/**
	 * 사이트관리 중복체크
	 * @param mngrSiteSearchVO
	 * @param mngrSiteVO
	 * @param model
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/site/sitemng_comm_dupleCheck.ajax")
	public void mngrSiteDupleCheck(@ModelAttribute("searchVO") MngrSiteSearchVO mngrSiteSearchVO, MngrSiteVO mngrSiteVO, ModelMap model, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		int cnt = mngrSiteService.mngrSiteDupleCheck(mngrSiteVO);
		String result= "0";
		/* 메뉴관리 코드에도 중복검사해야 함. */
			MngrMenuVO mngrMenuVO = new MngrMenuVO();
			mngrMenuVO.setMenuCode(mngrSiteVO.getSiteCode());
			mngrMenuVO.setId(mngrSiteVO.getId());
			mngrMenuVO.setAct(mngrSiteVO.getAct());

		cnt += mngrMenuService.mngrMenuDupleCheck(mngrMenuVO);

		if(cnt>0) result="1";
		else if(CommUtil.preventDefaultCode(mngrSiteVO.getSiteCode())) result="2";

		CommUtil.printWriter("{\"result\":"+result+"}", response);
	}

	/**
	 * 사이트관리 등록/수정 처리
	 * @param mngrSiteVO
	 * @param response
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/site/sitemng_edit_proc.do")
	public String insertMngrSiteProc(@ModelAttribute("searchVO") MngrSiteVO mngrSiteVO, HttpServletResponse response, ModelMap model) throws IOException, SQLException, RuntimeException {
		if("REGIST".equals(mngrSiteVO.getAct())){
			/*
			 * 등록 모드
			 */
			// 입력값 체크
			if("".equals(CommUtil.isNull(mngrSiteVO.getSiteName(), ""))) return CommUtil.doComplete(model, "오류", "사이트이름을 입력 해 주세요", "history.back();");
			if("".equals(CommUtil.isNull(mngrSiteVO.getSiteCode(), ""))) return CommUtil.doComplete(model, "오류", "사이트코드를 입력 해 주세요", "history.back();");
			if(CommUtil.preventDefaultCode(mngrSiteVO.getSiteCode())) return CommUtil.doComplete(model, "오류", "사용할 수 없는 사이트코드입니다. 다른코드를 입력 해 주세요", "history.back();");
			int resultCnt = mngrSiteService.mngrSiteDupleCheck(mngrSiteVO); //메뉴코드 중복 검사
			if(resultCnt > 0) return CommUtil.doComplete(model, "오류", "사이트코드가 중복 되었습니다. 확인 후 다시 시도해 주세요", "history.back();");

			// 메뉴코드 정상
			mngrSiteService.insertMngrSiteProc(mngrSiteVO);
			makeDbFileSiteList(); //파일을 만든다.

			List<MngrSiteVO> siteList = mngrSiteService.selectMngrSiteList();
			String tmp = "";
			String tmpNm = "";

			//전체 사이트 담기
			for (int i = 0; i < siteList.size(); i++) {
				if("".equals(tmp)) {
					tmp  += siteList.get(i).getSiteCode();
					tmpNm  += siteList.get(i).getSiteName();
				} else {
					tmp  += ","+siteList.get(i).getSiteCode();
					tmpNm  += ","+siteList.get(i).getSiteName();
				}
			}
			MngrSessionVO mngrSessionVO = new MngrSessionVO();
			mngrSessionVO.setSiteCode(tmp);
			mngrSessionVO.setSiteCodeNm(tmpNm);

			return CommUtil.doComplete(model, "완료", "등록 되었습니다.", "location.href='/_mngr_/site/sitemng_list.do';");
		}else if("UPDATE".equals(mngrSiteVO.getAct())){
			/*
			 * 수정 모드
			 */
			if("".equals(CommUtil.isNull(mngrSiteVO.getSiteName(), ""))) return CommUtil.doComplete(model, "오류", "메뉴이름을 입력 해 주세요", "history.back();");
			if("".equals(CommUtil.isNull(mngrSiteVO.getId(), ""))) return CommUtil.doComplete(model, "오류", "메뉴코드 정보가 없습니다. 확인 후 다시 시도해 주세요.", "history.back();");

			mngrSiteService.updateMngrSiteProc(mngrSiteVO);
			makeDbFileSiteList(); //파일을 만든다.

			List<MngrSiteVO> siteList = mngrSiteService.selectMngrSiteList();
			String tmp = "";
			String tmpNm = "";

			//전체 사이트 담기
			for (int i = 0; i < siteList.size(); i++) {
				if("".equals(tmp)) {
					tmp  += siteList.get(i).getSiteCode();
					tmpNm  += siteList.get(i).getSiteName();
				} else {
					tmp  += ","+siteList.get(i).getSiteCode();
					tmpNm  += ","+siteList.get(i).getSiteName();
				}
			}
			MngrSessionVO mngrSessionVO = new MngrSessionVO();
			mngrSessionVO.setSiteCode(tmp);
			mngrSessionVO.setSiteCodeNm(tmpNm);

			return CommUtil.doComplete(model, "완료", "수정 되었습니다.", "location.href='/_mngr_/site/sitemng_edit.do?id="+mngrSiteVO.getId()+"';");
		}
		return CommUtil.doComplete(model, "오류", "저장 중 오류가 발생했습니다.\\n확인 후 다시 시도하세요.", "history.back();");
	}

	/**
	 * 사이트관리 삭제처리
	 * @param mngrSiteVO
	 * @param response
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/site/sitemng_delete_proc.do")
	public String deleteSiteProc(@ModelAttribute("searchVO") MngrSiteVO mngrSiteVO, HttpServletResponse response, ModelMap model) throws IOException, SQLException, RuntimeException {

		mngrSiteService.deleteSiteProc(mngrSiteVO);
		makeDbFileSiteList(); //파일을 만든다.

		List<MngrSiteVO> siteList = mngrSiteService.selectMngrSiteList();
		String tmp = "";
		String tmpNm = "";

		//전체 사이트 담기
		for (int i = 0; i < siteList.size(); i++) {
			if("".equals(tmp)) {
				tmp  += siteList.get(i).getSiteCode();
				tmpNm  += siteList.get(i).getSiteName();
			} else {
				tmp  += ","+siteList.get(i).getSiteCode();
				tmpNm  += ","+siteList.get(i).getSiteName();
			}
		}
		MngrSessionVO mngrSessionVO = new MngrSessionVO();
		mngrSessionVO.setSiteCode(tmp);
		mngrSessionVO.setSiteCodeNm(tmpNm);

		return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='/_mngr_/site/sitemng_list.do';");
	}

	/**
	 * 사이트관리 파일 생성
	 */
	private void makeDbFileSiteList() throws IOException{
		List<MngrSiteVO> list = mngrSiteService.getMngrSiteList();
		String strList = "";
		int i = 0;
		for(MngrSiteVO siteVO : list){
			i++;
			strList += siteVO.getSiteCode();
			if(i < list.size() )
				strList += "|";
		}
		CommUtil.setSiteFile(strList);
	}
}