package egovframework.itgcms.mngr.member.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.util.CommUtil;

/**
 * @파일명 : MngrMemLoginConfigController.java
 * @파일정보 : 회원 로그인 설정 관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 5. 15. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
@RequestMapping("/_mngr_/module/*")
public class MngrMemLoginConfigController {

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	@RequestMapping(value = "/{menuCode}_view_loginConfig.do")
	public String mngrLoginConfigMain(@PathVariable("menuCode") String menuCode, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		String siteCode = CommUtil.getManagerSiteCode(request);

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);

		Map<String, String> resultMap = new HashMap<String, String>();

		resultMap.put("sessionTime", String.valueOf(siteconfigVO.getMemSessionTime() >= 300 && siteconfigVO.getMemSessionTime() <= 600 ? siteconfigVO.getMemSessionTime() : 600 ));
		resultMap.put("returnType", String.valueOf(siteconfigVO.getLoginRtType()));
		resultMap.put("returnMenu", String.valueOf(siteconfigVO.getLoginRtMenuCode()));

		model.addAttribute("siteCode", siteCode);
		model.addAllAttributes(resultMap);

		return "itgcms/mngr/member/loginConfig_view";
	}


	@RequestMapping(value = "/{menuCode}_edit_loginConfig_proc", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> mngrLoginConfigProc (
			@PathVariable("menuCode") String menuCode,
			@RequestParam(value="siteCode", required=false) String siteCode,
			@RequestParam(value="sessionTime", required=false) int sessionTime, @RequestParam(value="returnType", required=false) int returnType,
			@RequestParam(value="returnMenu", required=false) String returnMenu, HttpServletRequest request) {

		Map<String, String> result = new HashMap<>();
		result.put("status", "error_Start");
		result.put("msg", "알 수 없는 오류가 발생하였습니다. \n창을 새로고침한 후 다시 시도하십시오.");

		if (siteCode == null || "".equals(siteCode)) {
			result.put("status", "error_SiteCode Empty");
			return result;
		}

		if (sessionTime< 300 || sessionTime > 600) {
			result.put("status", "error_SessionTime Over");
			result.put("msg", "로그인 유효 시간이 300~600 사이 값이 아닙니다.");
			return result;
		}

		switch (returnType) {
		case 0:
		case 1:
			break;
		case 2:
			if (returnMenu == null || "".equals(returnMenu)) {
				result.put("status", "error_menuCode Empty");
				result.put("msg", "리턴할 메뉴를 선택하셔야합니다.");
				return result;
			}
			break;
		default:
			result.put("status", "error_returnType Over");
			return result;
		}

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(siteCode);
		siteconfigVO.setLoginMenuCode(menuCode);
		siteconfigVO.setMemSessionTime(sessionTime);
		siteconfigVO.setLoginRtType(returnType);
		if (returnType==2) {
			siteconfigVO.setLoginRtMenuCode(returnMenu);
		}
		result.put("status", "success");
		result.put("msg", "성공적으로 수정하였습니다.");
		CommUtil.setFileObject(siteconfigVO, "siteconfig", siteCode);

		return result;
	}
}
