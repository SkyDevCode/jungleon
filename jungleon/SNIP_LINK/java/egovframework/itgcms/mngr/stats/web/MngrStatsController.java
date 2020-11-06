package egovframework.itgcms.mngr.stats.web;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.ipCountry.service.IpCountryService;
import egovframework.itgcms.core.menu.service.MngrMenuService;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.stats.service.MngrCountVO;
import egovframework.itgcms.core.stats.service.MngrStatsService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @파일명 : MngrStatsController.java
 * @파일정보 : 통계관리 컨트롤러
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * bluejick 2016. 3. 27. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class MngrStatsController {

	/** MngrSiteService */
	@Resource(name = "mngrStatsService")
	private MngrStatsService mngrStatsService;

	/** MngrMenuService */
	@Resource(name = "mngrMenuService")
	private MngrMenuService mngrMenuService;

	@Resource(name = "ipCountryService")
	private IpCountryService ipCountryService;

	@Resource(name="mngrSiteService")
	private MngrSiteService mngrSiteService;

	private static final Logger logger = LogManager.getLogger(MngrStatsController.class);

	/**
	 * 날짜별 접속통계
	 * @param paramCountVO
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/stats/statsDate_view.do")
	public String mngrStatsDateView(@ModelAttribute("searchVO") MngrCountVO paramCountVO, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		if("".equals(paramCountVO.getSchOption())){
			paramCountVO.setSchOption("DAY_M");
		}

		if ("".equals(paramCountVO.getSiteCode())) {
			paramCountVO.setSiteCode("all");
		}

		//String schDate = CommUtil.getDatePattern("yyyy-MM-dd hh");

		String schDate = CommUtil.isNull(paramCountVO.getSchDate(), "");
		if("".equals(schDate)){
			schDate = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		String date = CommUtil.getDateforStat(schDate, paramCountVO.getSchOption());
		String dateArr[] = date.split("-");
		if("HOUR".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("HOUR");
			paramCountVO.setCntYear(dateArr[0]);
			paramCountVO.setCntMonth(dateArr[1]);
			paramCountVO.setCntDay(dateArr[2]);
			paramCountVO.setSchDate(dateArr[0]+"-"+dateArr[1]+"-"+dateArr[2]);
		/*}else if("DAY_W".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("DAY");
			paramCountVO.setCntYear(dateArr[0]);
			paramCountVO.setCntMonth(dateArr[1]);*/
		}else if("DAY_M".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("DAY");
			paramCountVO.setCntYear(dateArr[0]);
			paramCountVO.setCntMonth(dateArr[1]);
			paramCountVO.setSchDate(dateArr[0]+"-"+dateArr[1]);

			// 해당 월의 마지막 날을 구한다.
			Calendar cal = Calendar.getInstance();
			/*
			 * Calendar 객체의 월은 0부터 시작 (0:1월, 1:2월....)
			 * 특정 월의 0일을 구하면,
			 * 이전 월의 말일을 가지게 됨.
			*/
			cal.set(Integer.parseInt(paramCountVO.getCntYear()), Integer.parseInt(paramCountVO.getCntMonth()), 0);
			model.addAttribute("maxDayOfMonth", cal.get(Calendar.DAY_OF_MONTH));
		}else if("MONTH".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("MONTH");
			paramCountVO.setCntYear(dateArr[0]);
			paramCountVO.setSchDate(dateArr[0]);
		}else if("YEAR".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("YEAR");
		}

		List<MngrCountVO> resultList = mngrStatsService.selectMngrDateCountList(paramCountVO);

		model.addAttribute("siteList", mngrSiteService.getMngrSiteList());
		model.addAttribute("searchSite", paramCountVO.getSiteCode());
		model.addAttribute("resultList", resultList);
		return "itgcms/mngr/stats/statsDate_view";
	}

	/**
	 * 기간별 접속통계
	 * @param paramCountVO
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/stats/statsTerm_view.do")
	public String mngrStatsTermView(@ModelAttribute("searchVO") MngrCountVO paramCountVO, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		if("".equals(paramCountVO.getSchOption())){
			paramCountVO.setSchOption("DAY_M");
		}

		if ("".equals(paramCountVO.getSiteCode())) {
			paramCountVO.setSiteCode("all");
		}

		String schDateFrom = CommUtil.isNull(paramCountVO.getSchDateFrom(), "");
		if("".equals(schDateFrom)){
			schDateFrom = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		String schDateEnd = CommUtil.isNull(paramCountVO.getSchDateEnd(), "");
		if("".equals(schDateEnd)){
			schDateEnd = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		String dateFrom = CommUtil.getDateforStat(schDateFrom, paramCountVO.getSchOption());
		String dateEnd = CommUtil.getDateforStat(schDateEnd, paramCountVO.getSchOption());

		paramCountVO.setSchDateFrom(dateFrom);
		paramCountVO.setSchDateEnd(dateEnd);

		String dateFromArr[] = dateFrom.split("-");
		String dateEndArr[] = dateEnd.split("-");

		if("HOUR".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("HOUR");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]+"-"+dateFromArr[2]);

			int lastDate = Integer.parseInt(dateEndArr[2])+1;
			String lastDateStr = "";
			if(lastDate<10){
				lastDateStr += "0"+lastDate;
			}else{
				lastDateStr += lastDate;
			}
			paramCountVO.setEndDate(dateEndArr[0]+"-"+dateEndArr[1]+"-"+lastDateStr);
		}else if("DAY_M".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("DAY");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]);
			int lastDate = Integer.parseInt(dateEndArr[1])+1;
			if(lastDate > 12) {
				dateEndArr[0] = String.valueOf(Integer.parseInt(dateEndArr[0])+1);
				lastDate = 1;
			}
			String lastDateStr = "";
			if(lastDate<10){
				lastDateStr += "0"+lastDate;
			}else{
				lastDateStr += lastDate;
			}
			paramCountVO.setEndDate(dateEndArr[0]+"-"+lastDateStr);
		} else if("DAY_W".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("DAY");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]);
			int lastDate = Integer.parseInt(dateEndArr[1])+1;
			if(lastDate > 12) {
				dateEndArr[0] = String.valueOf(Integer.parseInt(dateEndArr[0])+1);
				lastDate = 1;
			}
			String lastDateStr = "";
			if(lastDate<10){
				lastDateStr += "0"+lastDate;
			}else{
				lastDateStr += lastDate;
			}
			paramCountVO.setEndDate(dateEndArr[0]+"-"+lastDateStr);
		}else if("MONTH".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("MONTH");
			paramCountVO.setStartDate(dateFromArr[0]);
			int lastDate = Integer.parseInt(dateEndArr[0])+1;
			String lastDateStr = "";
			if(lastDate<10){
				lastDateStr += "0"+lastDate;
			}else{
				lastDateStr += lastDate;
			}
			paramCountVO.setEndDate(lastDateStr);
		}else if("YEAR".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("YEAR");
			paramCountVO.setStartDate(dateFromArr[0]);
			String lastDateStr =""+(Integer.parseInt(dateEndArr[0])+1);
			paramCountVO.setEndDate(lastDateStr);
		}

		logger.debug("***** StartDate : "+paramCountVO.getStartDate()+", EndDate : "+paramCountVO.getEndDate());
		List<MngrCountVO> resultList = mngrStatsService.selectMngrTermCountList(paramCountVO);

		model.addAttribute("siteList", mngrSiteService.getMngrSiteList());
		model.addAttribute("searchSite", paramCountVO.getSiteCode());
		model.addAttribute("resultList", resultList);

		return "itgcms/mngr/stats/statsTerm_view";
	}

	/**
	 * 옵션별 접속통계
	 * @param paramCountVO
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/stats/statsOpt_view.do")
	public String mngrStatsOptView(@ModelAttribute("searchVO") MngrCountVO paramCountVO, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		//"DEVICE","OS","BROWSER","SEARCHENGINE"

		if ("".equals(paramCountVO.getSiteCode())) {
			paramCountVO.setSiteCode("all");
		}

		if("".equals(paramCountVO.getSchOption())){
			paramCountVO.setSchOption("BROWSER");
		}

		paramCountVO.setCntOption(paramCountVO.getSchOption());

		List<MngrCountVO> resultList = mngrStatsService.selectMngrOptionCountList(paramCountVO);

		model.addAttribute("siteList", mngrSiteService.getMngrSiteList());
		model.addAttribute("searchSite", paramCountVO.getSiteCode());
		model.addAttribute("resultList", resultList);

		return "itgcms/mngr/stats/statsOpt_view";
	}

	/**
	 * 메뉴별 접속통계
	 * @param paramCountVO
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/stats/statsMenu_view.do")
	public String mngrStatsMenuView(@ModelAttribute("searchVO") MngrCountVO paramCountVO, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		if ("".equals(paramCountVO.getSiteCode())) {
			paramCountVO.setSiteCode("all");
		}

		String schDateFrom = CommUtil.isNull(paramCountVO.getSchDateFrom(), "");
		if("".equals(schDateFrom)){
			schDateFrom = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		String schDateEnd = CommUtil.isNull(paramCountVO.getSchDateEnd(), "");
		if("".equals(schDateEnd)){
			schDateEnd = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		String dateFrom ="";
		String dateEnd = "";

		if("DAY".equals(paramCountVO.getSchOption())){
			dateFrom = CommUtil.getDateforStat(schDateFrom, "HOUR");
			dateEnd = CommUtil.getDateforStat(schDateEnd, "HOUR");
		}else if("MONTH".equals(paramCountVO.getSchOption())){
			dateFrom = CommUtil.getDateforStat(schDateFrom, "DAY_M");
			dateEnd = CommUtil.getDateforStat(schDateEnd, "DAY_M");
		}else if("YEAR".equals(paramCountVO.getSchOption())){
			dateFrom = CommUtil.getDateforStat(schDateFrom, "MONTH");
			dateEnd = CommUtil.getDateforStat(schDateEnd, "MONTH");
		}else {
			paramCountVO.setSchOption("DAY");
			dateFrom = CommUtil.getDateforStat(schDateFrom, "HOUR");
			dateEnd = CommUtil.getDateforStat(schDateEnd, "HOUR");
		}

		paramCountVO.setSchDateFrom(dateFrom);
		paramCountVO.setSchDateEnd(dateEnd);

		String dateFromArr[] = dateFrom.split("-");
		String dateEndArr[] = dateEnd.split("-");

		logger.debug("***** dateFrom : "+dateFrom+", dateEnd : "+dateEnd);

		if("DAY".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("DAY");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]+"-"+dateFromArr[2]);
			paramCountVO.setEndDate(dateEndArr[0]+"-"+dateEndArr[1]+"-"+dateEndArr[2]);
		}else if("MONTH".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("MONTH");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]);
			int lastDate = Integer.parseInt(dateEndArr[1])+1;
			if(lastDate > 12) {
				dateEndArr[0] = String.valueOf(Integer.parseInt(dateEndArr[0])+1);
				lastDate = 1;
			}
			String lastDateStr = "";
			if(lastDate<10){
				lastDateStr += "0"+lastDate;
			}else{
				lastDateStr += lastDate;
			}
			paramCountVO.setEndDate(dateEndArr[0]+"-"+lastDateStr);
		}else if("YEAR".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("YEAR");
			paramCountVO.setStartDate(dateFromArr[0]);
			int lastDate = Integer.parseInt(dateEndArr[0])+1;
			String lastDateStr = ""+lastDate;
			paramCountVO.setEndDate(lastDateStr);
		}

		logger.debug("***** StartDate : "+paramCountVO.getStartDate()+", EndDate : "+paramCountVO.getEndDate());
		List<MngrCountVO> resultList = mngrStatsService.selectMngrMenuCountList(paramCountVO);

		model.addAttribute("siteList", mngrSiteService.getMngrSiteList());
		model.addAttribute("searchSite", paramCountVO.getSiteCode());
		model.addAttribute("resultList", resultList);

		return "itgcms/mngr/stats/statsMenu_view";
	}

	/**
	 * 게시판 통계
	 * @param siteCode
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/stats/statsBbs_view.do")
	public String mngrStateBoardView(@RequestParam(value="siteCode", required = false) String siteCode, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		if (siteCode == null || "".equals("siteCode")) {
			siteCode = CommUtil.getDefaultSiteCode();
		}

		List<ItgMap> resultList = mngrStatsService.selectMngrBoardStats(siteCode);

		model.addAttribute("resultList", resultList);
		model.addAttribute("siteList", mngrSiteService.getMngrSiteList());
		model.addAttribute("searchSite", siteCode);

		return "itgcms/mngr/stats/statsBbs_view";
	}

	/*@RequestMapping(value = "/_mngr_/stats/userAgent.do")
	public String userAgent(@ModelAttribute("searchVO") MngrStatsVO mngrStatsVO, ModelMap model, HttpServletRequest request, HttpSession session) throws IOException, SQLException, RuntimeException, ParseException {

		//테스트용 로그데이터리스트
		//List<MngrStatsVO> resultList = mngrStatsService.mngrStatsList(mngrStatsVO);

		//logger.debug("resultList size : "+resultList.size());
		mngrStatsVO = CommUtil.getLogInfo(request,CommUtil.isUserLogin(), "");

		logger.debug("clAgent : "+mngrStatsVO.getClAgent());
		logger.debug("clOs  : "+mngrStatsVO.getClOs());
		logger.debug("clBrowser  : "+mngrStatsVO.getClBrowser());
		logger.debug("clKeyword  : "+mngrStatsVO.getClKeyword());
		logger.debug("clReferer : "+mngrStatsVO.getClReferer());
		logger.debug("clIp  : "+mngrStatsVO.getClIp());
		logger.debug("clLanguages : "+mngrStatsVO.getClLanguage());

		return "itgcms/mngr/stats/agent";
	}
*/
	/*@RequestMapping(value = "/_mngr_/stats/mngrStatsAgeView.do")
	public String mngrStateAgeView(@ModelAttribute("searchVO") MngrCountVO paramCountVO, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		if("".equals(paramCountVO.getSchOption())){
			paramCountVO.setSchOption("DAY_M");
		}
		if ("".equals(paramCountVO.getSiteCode())) {
			paramCountVO.setSiteCode("all");
		}

		String schDateFrom = CommUtil.isNull(paramCountVO.getSchDateFrom(), "");
		if("".equals(schDateFrom)){
			schDateFrom = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		String schDateEnd = CommUtil.isNull(paramCountVO.getSchDateEnd(), "");
		if("".equals(schDateEnd)){
			schDateEnd = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		paramCountVO.setSchDateFrom(schDateFrom);
		paramCountVO.setSchDateEnd(schDateEnd);

		String dateFromArr[] = paramCountVO.getSchDateFrom().split("-");
		String dateEndArr[] = paramCountVO.getSchDateEnd().split("-");

		if("DAY_M".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("DAY");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]+"-"+dateFromArr[2]);
			int lastDate = Integer.parseInt(dateEndArr[2])+1;
			String lastDateStr = "";
			if(lastDate<10){
				lastDateStr += "0"+lastDate;
			}else{
				lastDateStr += lastDate;
			}
			paramCountVO.setEndDate(dateEndArr[0]+"-"+dateEndArr[1]+"-"+lastDateStr);
		} else if("MONTH".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("MONTH");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]);
			int lastDate = Integer.parseInt(dateEndArr[1])+1;
			String lastDateStr = "";
			if(lastDate<10){
				lastDateStr += "0"+lastDate;
			}else{
				lastDateStr += lastDate;
			}
			paramCountVO.setEndDate(dateEndArr[0]+"-"+lastDateStr);
		}else if("YEAR".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("YEAR");
			paramCountVO.setStartDate(dateFromArr[0]);
			String lastDateStr =""+(Integer.parseInt(dateEndArr[0])+1);
			paramCountVO.setEndDate(lastDateStr);
		}

		logger.debug("***** StartDate : "+paramCountVO.getStartDate()+", EndDate : "+paramCountVO.getEndDate());
		List<ItgMap> resultList = mngrStatsService.selectMngrStatsAgeList(paramCountVO);

		model.addAttribute("siteList", mngrSiteService.getMngrSiteList());
		model.addAttribute("searchSite", paramCountVO.getSiteCode());
		model.addAttribute("resultList", resultList);

		return "itgcms/mngr/stats/mngrStatsAgeView";
	}
*/
	@RequestMapping(value = "/_mngr_/stats/snsCount_comm_proc.do")
	@ResponseBody
	public void snsCount(HttpServletRequest request, @RequestParam(value = "currentUrl", required = false) String cntUrl,
		@RequestParam(value = "smName", required = false) String cntSmName, @RequestParam(value = "siteCode", required = false) String siteCode,
		@RequestParam(value = "menuCode", required = false) String cntName) throws IOException, SQLException, RuntimeException{

		EgovMap egovMap = CommUtil.getParameterEMap(request);
		SimpleDateFormat dfh = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(cal.HOUR_OF_DAY, +1);
		String today = dfh.format(cal.getTime());
		String Date[] =today.split("-");
		String dateOption[] ={"TOTAL","YEAR","MONTH","DAY"};
		int upcnt = 0;

		egovMap.put("cntName", cntName);
		egovMap.put("siteCode", siteCode);
		egovMap.put("cntSmName", cntSmName);
		egovMap.put("cntUrl", cntUrl);
		egovMap.put("cntYear", "0000");
		egovMap.put("cntMonth", "00");
		egovMap.put("cntDay", "00");

		for(int i=0;i<4;i++){
			egovMap.put("cntOption", dateOption[i]);

			switch (i){
				case 1:	egovMap.put("cntYear", Date[0]);break;
				case 2: egovMap.put("cntMonth", Date[1]);break;
				case 3: egovMap.put("cntDay", Date[2]);break;
			}
			upcnt = mngrStatsService.mngrSnsCountUpdate(egovMap);

			if(upcnt==0){
				egovMap.put("etc", Date[0]+"-"+Date[1]+"-"+Date[2]);
				mngrStatsService.mngrSnsCountInsert(egovMap);
			}
		}
	 }

	@RequestMapping("/_mngr_/stats/statsSocial_view.do" )
	public String mngrStatsSocialView(@ModelAttribute("searchVO") MngrCountVO paramCountVO, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		if ("".equals(paramCountVO.getSiteCode())) {
			paramCountVO.setSiteCode("all");
		}

		String schDateFrom = CommUtil.isNull(paramCountVO.getSchDateFrom(), "");
		if("".equals(schDateFrom)){
			schDateFrom = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		String schDateEnd = CommUtil.isNull(paramCountVO.getSchDateEnd(), "");
		if("".equals(schDateEnd)){
			schDateEnd = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		String dateFrom ="";
		String dateEnd = "";

		if("DAY".equals(paramCountVO.getSchOption())){
			dateFrom = CommUtil.getDateforStat(schDateFrom, "HOUR");
			dateEnd = CommUtil.getDateforStat(schDateEnd, "HOUR");
		}else if("MONTH".equals(paramCountVO.getSchOption())){
			dateFrom = CommUtil.getDateforStat(schDateFrom, "DAY_M");
			dateEnd = CommUtil.getDateforStat(schDateEnd, "DAY_M");
		}else if("YEAR".equals(paramCountVO.getSchOption())){
			dateFrom = CommUtil.getDateforStat(schDateFrom, "MONTH");
			dateEnd = CommUtil.getDateforStat(schDateEnd, "MONTH");
		}else {
			paramCountVO.setSchOption("TOTAL");

		}

		paramCountVO.setSchDateFrom(dateFrom);
		paramCountVO.setSchDateEnd(dateEnd);

		String dateFromArr[] = dateFrom.split("-");
		String dateEndArr[] = dateEnd.split("-");

		logger.debug("***** dateFrom : "+dateFrom+", dateEnd : "+dateEnd);
		paramCountVO.setCntOption("TOTAL");
		if("DAY".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("DAY");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]+"-"+dateFromArr[2]);
			paramCountVO.setEndDate(dateEndArr[0]+"-"+dateEndArr[1]+"-"+dateEndArr[2]);
		}else if("MONTH".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("MONTH");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]);
			int lastDate = Integer.parseInt(dateEndArr[1])+1;
			if(lastDate > 12) {
				dateEndArr[0] = String.valueOf(Integer.parseInt(dateEndArr[0])+1);
				lastDate = 1;
			}
			String lastDateStr = "";
			if(lastDate<10){
				lastDateStr += "0"+lastDate;
			}else{
				lastDateStr += lastDate;
			}
			paramCountVO.setEndDate(dateEndArr[0]+"-"+lastDateStr);
		}else if("YEAR".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("YEAR");
			paramCountVO.setStartDate(dateFromArr[0]);
			int lastDate = Integer.parseInt(dateEndArr[0])+1;
			String lastDateStr = ""+lastDate;
			paramCountVO.setEndDate(lastDateStr);
		}

		logger.debug("***** StartDate : "+paramCountVO.getStartDate()+", EndDate : "+paramCountVO.getEndDate());
		List<EgovMap> resultList = mngrStatsService.selectMngrSnsCountList(paramCountVO);

		model.addAttribute("siteList", mngrSiteService.getMngrSiteList());
		model.addAttribute("searchSite", paramCountVO.getSiteCode());
		model.addAttribute("resultList", resultList);

		return "itgcms/mngr/stats/statsSocial_view";
	}

	@RequestMapping(value = "/_mngr_/stats/popupCount_comm_proc.do")
	@ResponseBody
	public void popupCount(HttpServletRequest request, @RequestParam(value = "popIdx", required = true) String popIdx,
		@RequestParam(value = "siteCode", required = true) String siteCode) throws IOException, SQLException, RuntimeException{

		EgovMap egovMap = CommUtil.getParameterEMap(request);
		SimpleDateFormat dfh = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(cal.HOUR_OF_DAY, +1);
		String today = dfh.format(cal.getTime());
		String Date[] =today.split("-");
		String dateOption[] ={"TOTAL","YEAR","MONTH","DAY"};
		int upcnt = 0;

		egovMap.put("popIdx", popIdx);
		egovMap.put("siteCode", siteCode);
		egovMap.put("cntYear", "0000");
		egovMap.put("cntMonth", "00");
		egovMap.put("cntDay", "00");

		for(int i=0;i<4;i++){
			egovMap.put("cntOption", dateOption[i]);

			switch (i){
				case 1:	egovMap.put("cntYear", Date[0]);break;
				case 2: egovMap.put("cntMonth", Date[1]);break;
				case 3: egovMap.put("cntDay", Date[2]);break;
			}
			upcnt = mngrStatsService.mngrPopupCountUpdate(egovMap);

			if(upcnt==0){
				egovMap.put("etc", Date[0]+"-"+Date[1]+"-"+Date[2]);
				mngrStatsService.mngrPopupCountInsert(egovMap);
			}
		}
	 }

	@RequestMapping("/_mngr_/stats/statsPopup_view.do")
	public String mngrStatsPopupView(@ModelAttribute("searchVO") MngrCountVO paramCountVO, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		if ("".equals(paramCountVO.getSiteCode())) {
			paramCountVO.setSiteCode("all");
		}

		String schDateFrom = CommUtil.isNull(paramCountVO.getSchDateFrom(), "");
		if("".equals(schDateFrom)){
			schDateFrom = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		String schDateEnd = CommUtil.isNull(paramCountVO.getSchDateEnd(), "");
		if("".equals(schDateEnd)){
			schDateEnd = CommUtil.getDatePattern("yyyy-MM-dd");
		}

		String dateFrom ="";
		String dateEnd = "";

		if("DAY".equals(paramCountVO.getSchOption())){
			dateFrom = CommUtil.getDateforStat(schDateFrom, "HOUR");
			dateEnd = CommUtil.getDateforStat(schDateEnd, "HOUR");
		}else if("MONTH".equals(paramCountVO.getSchOption())){
			dateFrom = CommUtil.getDateforStat(schDateFrom, "DAY_M");
			dateEnd = CommUtil.getDateforStat(schDateEnd, "DAY_M");
		}else if("YEAR".equals(paramCountVO.getSchOption())){
			dateFrom = CommUtil.getDateforStat(schDateFrom, "MONTH");
			dateEnd = CommUtil.getDateforStat(schDateEnd, "MONTH");
		}else {
			paramCountVO.setSchOption("TOTAL");

		}

		paramCountVO.setSchDateFrom(dateFrom);
		paramCountVO.setSchDateEnd(dateEnd);

		String dateFromArr[] = dateFrom.split("-");
		String dateEndArr[] = dateEnd.split("-");

		logger.debug("***** dateFrom : "+dateFrom+", dateEnd : "+dateEnd);
		paramCountVO.setCntOption("TOTAL");
		if("DAY".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("DAY");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]+"-"+dateFromArr[2]);
			paramCountVO.setEndDate(dateEndArr[0]+"-"+dateEndArr[1]+"-"+dateEndArr[2]);
		}else if("MONTH".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("MONTH");
			paramCountVO.setStartDate(dateFromArr[0]+"-"+dateFromArr[1]);
			int lastDate = Integer.parseInt(dateEndArr[1])+1;
			if(lastDate > 12) {
				dateEndArr[0] = String.valueOf(Integer.parseInt(dateEndArr[0])+1);
				lastDate = 1;
			}
			String lastDateStr = "";
			if(lastDate<10){
				lastDateStr += "0"+lastDate;
			}else{
				lastDateStr += lastDate;
			}
			paramCountVO.setEndDate(dateEndArr[0]+"-"+lastDateStr);
		}else if("YEAR".equals(paramCountVO.getSchOption())){
			paramCountVO.setCntOption("YEAR");
			paramCountVO.setStartDate(dateFromArr[0]);
			int lastDate = Integer.parseInt(dateEndArr[0])+1;
			String lastDateStr = ""+lastDate;
			paramCountVO.setEndDate(lastDateStr);
		}

		logger.debug("***** StartDate : "+paramCountVO.getStartDate()+", EndDate : "+paramCountVO.getEndDate());
		List<EgovMap> resultList = mngrStatsService.selectMngrPopupCountList(paramCountVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("siteList", mngrSiteService.getMngrSiteList());
		model.addAttribute("searchSite", paramCountVO.getSiteCode());

		return "itgcms/mngr/stats/statsPopup_view";
	}
}
