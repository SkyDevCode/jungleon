package egovframework.itgcms.mngr.member.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.menu.service.MngrMemIPManageService;
import egovframework.itgcms.core.menu.service.MngrMemIpManageVO;
import egovframework.itgcms.util.CommUtil;

/**
 * @파일명 : MngrMemIPManagementController.java
 * @파일정보 : 회원 IP 관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @ho 2017. 5. 25. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
@RequestMapping("/_mngr_/memIP/*")
public class MngrMemIPManagementController {

	@Resource(name="mngrMemIPManageService")
	private MngrMemIPManageService mngrMemIPManageService;

	@RequestMapping(value = "/ip_edit.do")
	public String mngrIPManageMain(HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {
		model.addAttribute("resultList", mngrMemIPManageService.selectMngrSiteListForIPManage(null));
		return "itgcms/mngr/memIP/ip_edit";
	}

	@RequestMapping(value = "/ip_edit_proc.ajax",  method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> mngrIPManageProc(@ModelAttribute("searchVO") MngrMemIpManageVO searchVO, HttpSession session){

		Map<String, String> result = new HashMap<>();
		result.put("status", "error unknown");
		result.put("msg", "알수 없는 오류가 발생하였습니다. /n창을 새로고침한 후 다시 시도해 주세요.");

		MngrSessionVO mngrSessionVo = CommUtil.getMngrSessionVO();
		String mngrId = mngrSessionVo.getId();

		searchVO.setUpdMemId(mngrId);
		if(mngrMemIPManageService.updateMngrIPManage(searchVO)>0){
			result.put("msg", "성공적으로 수정하였습니다.");
		} else {
			searchVO.setRegMemId(mngrId);
			mngrMemIPManageService.insertMngrIPManage(searchVO);
			result.put("msg", "성공적으로 작성하였습니다.");
		}

		result.put("status", "success");

		return result;
	}
}
