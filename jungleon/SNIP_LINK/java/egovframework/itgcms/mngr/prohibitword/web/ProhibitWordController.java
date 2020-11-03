package egovframework.itgcms.mngr.prohibitword.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.itgcms.util.CommUtil;

/**
 * @파일명 : ProhibitWordController.java
 * @파일정보 : 금지어 관리
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
public class ProhibitWordController {

	@RequestMapping("/_mngr_/prohibitword/prohibitWord_edit.do")
	public String mngrProhibitWordMain(Model model){
		model.addAttribute("prohibitDesc", CommUtil.getProhibitRegEx());
		return "itgcms/mngr/prohibitword/prohibitWord_edit";
	}

	@RequestMapping("/_mngr_/prohibitword/prohibitWord_edit_proc.ajax")
	@ResponseBody
	public Map<String, String> mngrProhibitWordProc(@RequestParam("words") String words, HttpServletRequest request, Model model){

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("status", "error_start");
		resultMap.put("msg", "알수 없는 오류가 발생하였습니다. ");

		while (words.startsWith("|")) {
			words = words.substring(1);
		}

		while (words.endsWith("|")) {
			words = words.substring(0, words.lastIndexOf("|"));
		}

		if ("1".equals(CommUtil.setFileObject(words, "prohibitDesc"))){
			resultMap.put("status", "success");
			resultMap.put("msg", "성공적으로 저장되었습니다.");
		} else {
			resultMap.put("status", "error_setFile");
			resultMap.put("msg", "금지어를 저장하는 도중 오류가 발생하였습니다. \n잠시후에 다시 시도해주세요.");
		}

		return resultMap;
	}
}
