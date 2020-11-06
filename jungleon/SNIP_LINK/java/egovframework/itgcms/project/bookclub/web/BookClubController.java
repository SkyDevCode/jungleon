package egovframework.itgcms.project.bookclub.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.EmailException;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.itgcms.project.totalTable.service.TotalTbSearchVO;
import egovframework.itgcms.project.totalTable.service.TotalTbVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.JsonUtil;

@Controller
public class BookClubController {


	@RequestMapping(value = "{menuCode}_chkLoginEbook.ajax")
	@ResponseBody
	public String chkLoginEbook(@PathVariable String menuCode,
						@ModelAttribute("searchVO") MemberVO memberVO,
						HttpServletRequest request,
						HttpServletResponse response,
						ModelMap model) throws Exception {

		ItgMap resultMap = new ItgMap();

		if (!"".equals(CommUtil.isNull(CommUtil.getUserMemId(), ""))) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		Gson gson = new Gson();

		return gson.toJson(resultMap);
	}

	@RequestMapping(value = "/{siteCode}/module/{menuCode}_pr_kybFrm.do")
	public String kybFrm(@PathVariable String siteCode,
						@PathVariable String menuCode,
						ModelMap model) throws IOException, SQLException, RuntimeException {


		System.out.println("tet ");

		return "itgcms/project/bookclub/PR_kybFrm";
	}

}

