package egovframework.itgcms.module.survey.web;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.module.survey.service.MngrSurveyService;
import egovframework.itgcms.module.survey.service.SurveyAnswerResultVO;
import egovframework.itgcms.module.survey.service.SurveyQuestionOptionVO;
import egovframework.itgcms.module.survey.service.SurveyQuestionVO;
import egovframework.itgcms.module.survey.service.SurveyService;
import egovframework.itgcms.module.survey.service.SurveyVO;
import egovframework.itgcms.module.survey.service.impl.MngrSurveyMapper;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MngrSurveyController {

	@Resource(name="mngrCodeService")
	private MngrCodeService mngrCodeService;

	@Resource(name = "mngrSurveyService")
	private MngrSurveyService mngrSurveyService;

	@Resource(name = "surveyService")
	private SurveyService surveyService;
	@Resource(name="mngrSurveyMapper")
	private MngrSurveyMapper mngrSurveyMapper;

	private static final int MAX_LENGTH_ANSWER = 1000;

	@RequestMapping(value = "/_mngr_/survey/mngrSurveyManage_list.do")
	public String mngrSurveyListPage(@ModelAttribute("searchVO") SurveyVO searchVO, HttpServletRequest request,ModelMap model) throws IOException, SQLException, RuntimeException{
		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		/* S:사이트코드 설정*/
		searchVO.setSchSitecode(siteCode);

		/* E:사이트코드 설정*/
		searchVO.setPageUnit(Integer.parseInt(searchVO.getViewCount()));//viewCount
		searchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(searchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());


		List<SurveyVO> resultList = mngrSurveyService.mngrSelectSurveyList(searchVO);
		
		model.addAttribute("resultList", resultList);
		int totCnt = mngrSurveyService.getSurveyListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage())));

		return "itgcms/global/module/survey/mngrSurveyManage_list";
	}


	@RequestMapping(value = "/_mngr_/survey/mngrSurvey_regist.do")
	public String mngrSurveyFormPage(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model) throws IOException, SQLException, RuntimeException{

		MngrCodeVO codeVO = new MngrCodeVO();

		codeVO.setSchCode("survey_qu_op");
		codeVO.setChildCodeList(mngrCodeService.getMngrCodeList(codeVO));

		for (MngrCodeVO code : codeVO.getChildCodeList()) {
			code.setSchCode(code.getCcode());
			code.setChildCodeList(mngrCodeService.getMngrCodeList(code));
			for (MngrCodeVO code2 : code.getChildCodeList()) {
				code2.setSchCode(code2.getCcode());
				code2.setChildCodeList(mngrCodeService.getMngrCodeList(code2));
			}
		}

		model.addAttribute("surveyCode", codeVO);

		if (!"".equals(CommUtil.isNull(searchVO.getSchId(), ""))) {
			// 설문조사 내용 가져오기
			SurveyVO resultVO = surveyService.getSurveyInfo(searchVO);

			if (resultVO == null) {
				return CommUtil.doComplete(model, "오류", "설문이 존재하지 않습니다. 다시 시도해주세요.", "history.back();");
			}

			model.addAttribute("surveyInfo", resultVO);

		}
		model.addAttribute("maxLength", MAX_LENGTH_ANSWER);
		return "itgcms/global/module/survey/mngrSurvey_regist";
	}


	@RequestMapping(value="/_mngr_/survey/surRegist_input_proc.do")
	public String mngrSurveyRegistProc(HttpServletRequest request, ModelMap model,
			@RequestParam("svTitle") String svTitle, @RequestParam("svStartdate") String svStartdate, @RequestParam("svEnddate") String svEnddate,
			@RequestParam("svExplain") String svExplain,@RequestParam("schSitecode") String schSitecode) throws IOException, SQLException, RuntimeException{

		SurveyVO surveyVO = new SurveyVO();
		String regmemid = CommUtil.getMngrMemId();
		surveyVO.setSvIdx(Integer.parseInt(CommUtil.isNull(request.getParameter("svIdx"), "0")));
		surveyVO.setSvTitle(HtmlUtils.htmlEscape(svTitle));
		surveyVO.setSvStartdate(Timestamp.valueOf(svStartdate.concat(" 00:00:00.000")));
		surveyVO.setSvEnddate(Timestamp.valueOf(svEnddate.concat(" 00:00:00.000")));
		surveyVO.setSvExplain(CommUtil.getRemoveScript(svExplain));
		surveyVO.setSchSitecode(schSitecode);
		surveyVO.setRegmemid(regmemid);
		surveyVO.setUseyn("svstatus02");

		String returnPage = CommUtil.doComplete(model, "오류", "모든 항목을 입력해 주세요", "history.back();");

		String[] paramSubfixArr = request.getParameterValues("paramSubfix");

		if (paramSubfixArr.length==0) return returnPage;

		List<SurveyQuestionVO> questionList = new ArrayList<>(paramSubfixArr.length);
		SurveyQuestionVO question = null;

		for (int queOrder = 0; queOrder < paramSubfixArr.length;queOrder++) {
			String paramSubfix = paramSubfixArr[queOrder];
			question = new SurveyQuestionVO();
			question.setRegmemid(regmemid);
			question.setSqOrder(queOrder);

			String queStr = CommUtil.isNull(request.getParameter("que_"+paramSubfix), "");
			if ("".equals(queStr)) return CommUtil.doComplete(model, "오류", "설문 문항은 필수로 작성해야합니다.", "history.back();");
			question.setSqQuestion(queStr.trim());  // 문항


			String anType = CommUtil.isNull(request.getParameter("anType_"+paramSubfix), "");
			if ("".equals(anType)) return CommUtil.doComplete(model, "오류", "답변 타입이 선택되지 않았습니다.", "history.back();");
			question.setSqAnswertype(anType);  // 답변 타입

			question.setSqRequired("Y");  // 필수 여부

			String sqChecklimit = CommUtil.isNull(request.getParameter("sqChecklimit_"+paramSubfix), "0");
			question.setSqChecklimit(sqChecklimit);  // 복수선택갯수

			String sqTextlimit = CommUtil.isNull(request.getParameter("maxLength_"+paramSubfix), "0");
			question.setSqTextlimit(sqTextlimit);  // 서술형 글자제한

			if ("op_descriptive".equals(anType)) {
				question.setSqTextlimit(CommUtil.isNull(request.getParameter("maxLength_"+paramSubfix), "1000"));

			} else if("op_editable_radio".equals(anType)) {
				String[] opTitleArr = request.getParameterValues("opTitle_"+paramSubfix);
				List<SurveyQuestionOptionVO> optionList = new ArrayList<>(opTitleArr.length);

				for (int i = 0; i < opTitleArr.length ; i++) {

					String opTitle = opTitleArr[i].trim();

					if ("".equals(opTitle)) {
						return CommUtil.doComplete(model, "오류", "답변이 입력되지 않았습니다.", "history.back();");
					} else {
						SurveyQuestionOptionVO option = new SurveyQuestionOptionVO();
						String optionVal = CommUtil.isNull(request.getParameter("opTitle_"+paramSubfix+"_"+String.valueOf(i)), "");
						if (!"".equals(optionVal)) {
							option.setSoValue(optionVal.trim());
						}
						option.setLogMemid(regmemid);
						option.setSoContent(opTitle);
						String soInputYn = i == opTitleArr.length-1 ? CommUtil.isNull(request.getParameter("etcRequired_"+paramSubfix), "N") : "N";
						option.setSoInputyn(soInputYn);
						option.setSoOrder(i+1);
						optionList.add(option);
					}
				}
				question.setOptionList(optionList);
			}else if("op_editable_checkbox".equals(anType)) {
				String[] opTitleArr = request.getParameterValues("opTitle_"+paramSubfix);
				List<SurveyQuestionOptionVO> optionList = new ArrayList<>(opTitleArr.length);

				for (int i = 0; i < opTitleArr.length ; i++) {

					String opTitle = opTitleArr[i].trim();

					if ("".equals(opTitle)) {
						return CommUtil.doComplete(model, "오류", "답변이 입력되지 않았습니다.", "history.back();");
					} else {
						SurveyQuestionOptionVO option = new SurveyQuestionOptionVO();
						String optionVal = CommUtil.isNull(request.getParameter("opTitle_"+paramSubfix+"_"+String.valueOf(i)), "");
						if (!"".equals(optionVal)) {
							option.setSoValue(optionVal.trim());
						}
						option.setLogMemid(regmemid);
						option.setSoContent(opTitle);
						String soInputYn = i == opTitleArr.length-1 ? CommUtil.isNull(request.getParameter("etcRequired_"+paramSubfix), "N") : "N";
						option.setSoInputyn(soInputYn);
						option.setSoOrder(i+1);
						optionList.add(option);
					}
				}
				question.setOptionList(optionList);

			}else{
				String[] opTitleArr = request.getParameterValues("opTitle_"+paramSubfix);
				List<SurveyQuestionOptionVO> optionList = new ArrayList<>(opTitleArr.length);

				for (int i = 0; i < opTitleArr.length ; i++) {

					String opTitle = opTitleArr[i].trim();

					if ("".equals(opTitle)) {
						return CommUtil.doComplete(model, "오류", "답변이 입력되지 않았습니다.", "history.back();");
					} else {
						SurveyQuestionOptionVO option = new SurveyQuestionOptionVO();
						String optionVal = CommUtil.isNull(request.getParameter("opTitle_"+paramSubfix+"_"+String.valueOf(i)), "");
						if (!"".equals(optionVal)) {
							option.setSoValue(optionVal.trim());
						}
						option.setLogMemid(regmemid);
						option.setSoContent(opTitle);
						String soInputYn = i == opTitleArr.length-1 ? CommUtil.isNull(request.getParameter("etcRequired_"+paramSubfix), "N") : "N";
						option.setSoInputyn(soInputYn);
						option.setSoOrder(i+1);
						optionList.add(option);
					}
				}
				question.setOptionList(optionList);
			}

			questionList.add(question);

		}
		surveyVO.setQuestionList(questionList);


 		int resultIdx = 0;
		String msg = "";
		if (surveyVO.getSvIdx() == 0) {
			resultIdx = mngrSurveyService.insertSurvey(surveyVO);
			msg = "설문을 성공적으로 등록하였습니다.";
		} else {
			resultIdx = mngrSurveyService.updateSurvey(surveyVO);
			msg = "설문을 성공적으로 수정하였습니다.";
		}



		return CommUtil.doComplete(model, "성공", msg,
		"location.href='/_mngr_/survey/mngrSurvey_regist.do?schId="+resultIdx+"'");
	}


	@RequestMapping(value="/_mngr_/module/surveyStat/{code}.do")
	public String mngrChangeSurveyStart(@ModelAttribute("searchVO") SurveyVO searchVO, @PathVariable("code") String code, ModelMap model) throws IOException, SQLException, RuntimeException{

		String actType = "";

		searchVO.setUseyn(code);
		searchVO.setUpdmemid(CommUtil.getMngrMemId());

		int result = 0;
		if ("svstatus01".equalsIgnoreCase(code)) {
			actType = "종료";
			result = mngrSurveyService.updateUseynSurvey(searchVO);
		} else if ("svstatus04".equalsIgnoreCase(code)) {
			actType = "시작";
			result = mngrSurveyService.updateUseynSurvey(searchVO);
		} else if ("svstatus03".equalsIgnoreCase(code)) {
			actType = "일시정지";
			result = mngrSurveyService.updateUseynSurvey(searchVO);
		}


		String returnPage = CommUtil.doComplete(model, "오류", "해당 설문을 "+actType+"하지 못했습니다. 해당 설문이 존재하지 않거나, 설문 종료일자가 지났습니다.\\n다시 한번 확인해주세요.", "location.href = '/_mngr_/survey/mngrSurveyManage_list.do?"+searchVO.getQueryString()+"'");

		if ("".equals(actType)) {
			returnPage = CommUtil.doComplete(model, "오류", "잘못된 요청입니다.\\n창을 새로고침 한 뒤 다시 시도하세요.", "location.href = '/_mngr_/survey/mngrSurveyManage_list.do?"+searchVO.getQueryString()+"'");
		}

		if (result >= 1) {
			returnPage = CommUtil.doComplete(model, "성공", "해당 설문을 "+actType+" 하였습니다.", "location.href = '/_mngr_/survey/mngrSurveyManage_list.do?"+searchVO.getQueryString()+"'");
		}

		return returnPage;
	}


	@RequestMapping(value="/_mngr_/survey/survey_delete_proc.do")
	public String mngrDeleteSurvey(@ModelAttribute("searchVO") SurveyVO searchVO, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException{
		String returnPage = CommUtil.doComplete(model, "오류", "해당 설문을 삭제하지 못했습니다. 다시 한번 확인해주세요.", "location.href = '/_mngr_/survey/mngrSurveyManage_list.do?"+searchVO.getQueryString()+"'");

		searchVO.setDelmemid(CommUtil.getMngrMemId());

		int result = mngrSurveyService.deleteSurvey(searchVO);

		if (result > 0 ) {
			returnPage = CommUtil.doComplete(model, "성공", "해당 설문을 삭제하였습니다. ", "location.href = '/_mngr_/survey/mngrSurveyManage_list.do?"+searchVO.getQueryString()+"'");
		}

		return returnPage;
	}



	@RequestMapping(value="/_mngr_/survey/survey_list_AnswerMemList.ajax", method=RequestMethod.GET)
	@ResponseBody
	public EgovMap mngrSurAnswerMemList(@RequestParam("svIdx") int svIdx,HttpServletRequest request) throws IOException, SQLException, RuntimeException{

		EgovMap result = new EgovMap();
		SurveyVO surveyVo = mngrSurveyService.mngrGetSurveyInfoByIdx(svIdx);
		result.put("svTitle", surveyVo.getSvTitle());
		result.put("answerMemList", mngrSurveyService.selectSurveyAnswerMember(svIdx));

		return result;
	}


	@RequestMapping(value="/_mngr_/survey/{svIdx}/survey_vieww_pre.do")
	public String mngrSurveyPreview(@PathVariable("svIdx") String svIdx, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		DefaultVO searchVO = new DefaultVO();
		searchVO.setSchId(svIdx);

		SurveyVO result = mngrSurveyService.selectSurveyInfo(searchVO);

		if (result == null) return CommUtil.doComplete(model, "오류", "요청하신 설문이 존재하지 않습니다. \\n다시 시도해주세요.", "window.close();");

		model.addAttribute("survey", result);
		model.addAttribute("act", "preview");
		model.addAttribute("pageTitle", result.getSvTitle()+" 미리보기");

		return "itgcms/global/module/survey/surveyView";
	}


	@RequestMapping(value="/_mngr_/survey/{svIdx}/{memId}/survey_view_answer.do")
	public String mngrSurveyAnswerView(@PathVariable("svIdx") String svIdx, @PathVariable("memId") String memId,  ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		DefaultVO searchVO = new DefaultVO();
		searchVO.setSchId(svIdx);
		searchVO.setSchMemid(memId);

		SurveyVO result = mngrSurveyService.selectSurveyInfo(searchVO);
		if (result == null) return CommUtil.doComplete(model, "오류", "해당 설문이 존재하지 않습니다.", "window.close();");
		for (SurveyQuestionVO que : result.getQuestionList()) {
			if ("op_descriptive".equals(que.getSqAnswertype())) {
				// 서술형 문항일 경우 답 배열에 담아준다.
				List<String> valueList = mngrSurveyService.getSurevyDescQuestionResult(que);
				if (valueList.size()>0) {
					que.setValueArr(valueList.toArray(new String[valueList.size()]));
				}
			}else if("op_editable_radio".equals(que.getSqAnswertype())) {
				if (que.getValue().contains("_selectEtc")) {
					String[] valuearr={que.getValue().split("_")[0]};
					que.setValueArr(valuearr);
					model.addAttribute("selectEtc", "selectEtc");
				}
			}
		}
		model.addAttribute("survey", result);
		model.addAttribute("act", "answer");
		model.addAttribute("pageTitle", memId + " 답변 내용보기");

		return "itgcms/global/module/survey/surveyView";
	}

	@ResponseBody
	@RequestMapping(value="/_mngr_/survey/{svIdx}/survey_view_result.ajax")
	public ModelAndView survStatisticsDataAjax(@PathVariable("svIdx") int svIdx, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		DefaultVO searchVO = new DefaultVO();
		searchVO.setSchId(String.valueOf(svIdx));

		String tmp = CommUtil.isNull(request.getParameter("strDt"), "");
		searchVO.setEtc1("".equals(tmp) ? tmp : tmp.concat(" 00:00"));

		tmp = CommUtil.isNull(request.getParameter("endDt"), "");
		searchVO.setEtc2("".equals(tmp) ? tmp : tmp.concat(" 23:59"));


		ModelAndView mav = new ModelAndView();

		String viewName=CommUtil.doComplete(model, "오류", "정상적인 요청이 아닙니다.", "");

		SurveyVO surveyInfo = mngrSurveyService.selectSurveyResultData(searchVO);

		if (surveyInfo == null) viewName = CommUtil.doComplete(model, "오류", "해당 설문이 존재하지 않습니다.", "");
		viewName = "itgcms/global/module/survey/surveyResult";
		mav.addObject("surveyInfo", surveyInfo);

		mav.setViewName(viewName);

		return mav;
	}

	/**
	 * 설문조사 사용자 페이지
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/global/module/eduforumapply/"
	 * @exception Exception
	 */
	@RequestMapping(value = "/{root}/module/{menuCode}_userSurveyList.do")
	public String userSurveyList(@ModelAttribute("searchVO") SurveyVO searchVO,@PathVariable String root,@PathVariable String menuCode, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("menuCode", menuCode);
		searchVO.setSchSitecode(root);
		if("surveyreg".equals(searchVO.getSchM())){
			SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(root);
			String loginPageUrl = "/"+root+"/contents/"+siteconfigVO.getLoginMenuCode()+".do"; //TODO 로그인페이지 수정
			String userId = CommUtil.getUserMemId();
			if (userId == null || "".equals(userId)) return CommUtil.doComplete(model, "오류", "로그인 되어 있지 않습니다. 로그인 한 후 시도해주세요", "location.href='"+loginPageUrl+"';");
			searchVO.setSchId(searchVO.getSvIdx()+"");

			SurveyVO result = mngrSurveyService.selectSurveyInfo(searchVO);

			if (result == null) return CommUtil.doComplete(model, "오류", "요청하신 설문이 존재하지 않습니다. \\n다시 시도해주세요.", "window.close();");
			model.addAttribute("userId", userId);
			model.addAttribute("survey", result);
			model.addAttribute("act", "preview");
			model.addAttribute("pageTitle", result.getSvTitle()+" 미리보기");
			return "itgcms/global/module/survey/user/userSurveyView";
		}else if("list".equals(searchVO.getSchM())){
			return mngrSurveyService.userSurveyList(searchVO, model, request, response);
		}else if("proc".equals(searchVO.getSchM())){
			return mngrSurveyService.surveyProc(searchVO, model, request, response);
		}else if("surveyresult".equals(searchVO.getSchM())){
			return mngrSurveyService.userResultProc(searchVO, model, request, response);
		}
		return mngrSurveyService.userSurveyList(searchVO, model, request, response);
	}
}
