package egovframework.itgcms.module.survey.web;

import java.io.IOException;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.module.survey.service.SurveyAnswerResult;
import egovframework.itgcms.module.survey.service.SurveyService;
import egovframework.itgcms.module.survey.service.SurveyVO;
import egovframework.itgcms.util.CommUtil;

@Controller
public class SurveyController {

	@Resource(name="surveyService")
	private SurveyService surveyService;

	// private	static final String TEST_MEM_ID = "TESTER2";

	@RequestMapping(value="/{siteCode}/module/{svIdx}/surveyView.do")
	public String surveyFormView(@PathVariable("siteCode") String siteCode, @PathVariable("svIdx") String svIdx, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		DefaultVO searchVO = new DefaultVO();
		searchVO.setSchId(svIdx);
		searchVO.setLogMemid(EgovProperties.getProperty("cms.surevy.memberIdTemp"));

		SurveyVO result = surveyService.getSurveyInfo(searchVO);

		if (result == null) return CommUtil.doComplete(model, "오류", "요청하신 설문이 존재하지 않습니다. \\n다시 시도해주세요.", "window.close();");
		if (result.isSvExpired()) return CommUtil.doComplete(model, "오류", "해당 설문은 조사 기간이 종료되었습니다.", "window.close();");
		if (result.getSaNum()>0) return CommUtil.doComplete(model, "오류", "해당 설문에 이미 참여하셨습니다.", "window.close();");

		if (!"Y".equalsIgnoreCase(result.getUseyn())) return CommUtil.doComplete(model, "오류", "해당 설문은 현재 답변을 수집하지 않고 있습니다.\\n관리자에게 문의하세요.", "window.close();");

		model.addAttribute("survey", result);
		model.addAttribute("siteCode", siteCode);
		model.addAttribute("act", "userForm");
		model.addAttribute("pageTitle", "[설문조사] "+result.getSvTitle());

		return "itgcms/global/module/survey/surveyView";
	}


	/*@RequestMapping(value="/{siteCode}/module/userAnswerSurveyProc.do")@PathVariable("siteCode") String siteCode,*/
	@RequestMapping(value="/module/userAnswerSurveyProc.do")
	public String answerSurveyProc( ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		SurveyAnswerResult result = surveyService.answerSurvey(request, request.getParameter("memberId"));

		String retrunVal = CommUtil.doComplete(model, "오류", "알 수 없는 오류가 발생하였습니다.\\nError Code : Controller Error", "location.href='"+request.getHeader("referer")+"';");

		if (result.equals(SurveyAnswerResult.SUCCESS)) {
			retrunVal = CommUtil.doComplete(model, "성공", "성공적으로 제출하였습니다.", "location.href='"+request.getHeader("referer").substring(0, request.getHeader("referer").indexOf("?"))+"';");
		} else if (result.equals(SurveyAnswerResult.FAIL_ALEADY_ANSWERED)) {
			retrunVal = CommUtil.doComplete(model, "실패", "이미 해당 설문에 참여하였습니다.", "location.href='"+request.getHeader("referer").substring(0, request.getHeader("referer").indexOf("?"))+"';");
		} else if (result.equals(SurveyAnswerResult.FAIL_SURVEY_EXPIRED)) {
			retrunVal = CommUtil.doComplete(model, "실패", "해당 설문은 이미 답변 기간이 마감되었습니다.", "location.href='"+request.getHeader("referer").substring(0, request.getHeader("referer").indexOf("?"))+"';");
		} else if (result.equals(SurveyAnswerResult.FAIL_SURVEY_NOTFOUND)) {
			retrunVal = CommUtil.doComplete(model, "실패", "해당 설문을 찾을 수 없습니다.\n다시 시도해보세요.", "location.href='"+request.getHeader("referer").substring(0, request.getHeader("referer").indexOf("?"))+"';");
		} /*else if (result.equals(SurveyAnswerResult.FAIL_NULLPOINT_MEMBER_ID)) {
			retrunVal = CommUtil.doComplete(model, "실패", "로그인한 후 다시 시도해보세요.", "window.close();");
		}*/ else if (result.equals(SurveyAnswerResult.FAIL_PARAMETER_VALIDATE)) {
			retrunVal = CommUtil.doComplete(model, "실패", "필수 문항 중 누락된 답변이 존재합니다.\n다시 시도해주세요.","location.href='"+request.getHeader("referer")+"';");
		}

		return retrunVal;
	}

}
