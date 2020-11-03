package egovframework.itgcms.module.calendar.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * @파일명 : CalendarController.java
 * @파일정보 : 파일관리관리
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
public class CalendarController {

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

    /** mngrCodeService */
    @Resource(name = "mngrCodeService")
    private MngrCodeService mngrCodeService;

	private static final Logger logger = LogManager.getLogger(CalendarController.class);


	/**
	 * 달력페이지를 반환한다.
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/_mngr_/module/mngrCalendar{state}.do")
	public String mngrCalendarList(@PathVariable String state, @ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		String returnPage = "itgcms/global/module/calendar/mngrCalendar"+state;

		return returnPage;
	}

	/**
	 * 달력페이지를 반환한다.
	 * @param searchVO - 조회할 정보가 담긴 searchVO
	 * @param model
	 * @return "itgcms/mngr/popup/_mngr_popupList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/{root}/module/calendar.do")
	public String calendarList(@PathVariable String root, @ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		String returnPage = "itgcms/global/module/calendar/calendar";
		String menuCode = request.getParameter("menuCode");
		String progIdx = request.getParameter("progIdx");

		ItgMap itgMap = CommUtil.getParameterEMap(request);

    	int action = 0;  // incoming request for moving calendar up(1) down(0) for month
    	int currYear = 0; // if it is not retrieved from incoming URL (month=) then it is set to current year
    	int currMonth = 0; // same as year

    	Calendar c = Calendar.getInstance(); //현재의 날짜를 사용
    	Calendar cal = Calendar.getInstance(); //실제 보여질 날짜를 세팅

		if (request.getParameter("action") == null) // Check to see if we should set the year and month to the current
		{
			currMonth = c.get(c.MONTH);
			currYear = c.get(c.YEAR);
			cal.set(currYear, currMonth, 1);
		}

		else
		{
			if (!(request.getParameter("action") == null)) // Hove the calendar up or down in this if block
			{
				currMonth = Integer.parseInt(request.getParameter("month"));
				currYear = Integer.parseInt(request.getParameter("year"));

					if (Integer.parseInt( request.getParameter("action")) == 1 )
					{
						cal.set(currYear, currMonth, 1);
						cal.add(cal.MONTH, 1);
						currMonth = cal.get(cal.MONTH);
						currYear = cal.get(cal.YEAR);
					}
					else
					{
						cal.set(currYear, currMonth ,1);
						cal.add(cal.MONTH, -1);
						currMonth = cal.get(cal.MONTH);
						currYear = cal.get(cal.YEAR);
					}
			}
		}

		int weekCount = cal.getActualMaximum(cal.WEEK_OF_MONTH); //그 달이 몇주가 있는가
		int firstYoil = cal.get(cal.DAY_OF_WEEK); //그 달 첫째날의 요일

		int todayCalDay = c.get(c.DAY_OF_MONTH); //오늘 날짜(몇일)
		int todayCalMonth = c.get(c.MONTH); //현재의 월
		int todayCalYear = c.get(c.YEAR); //현재의 년

		int setCalMonth = cal.get(cal.MONTH); //세팅된 월
		int setCalYear = cal.get(cal.YEAR); //세팅된 년

		String yearString = Integer.toString(currYear);
		String monthString = getMonthName(currMonth);

		model.addAttribute("todayCalDay", todayCalDay);
		model.addAttribute("todayCalMonth", todayCalMonth);
		model.addAttribute("todayCalYear", todayCalYear);
		model.addAttribute("setCalMonth", setCalMonth);
		model.addAttribute("setCalYear", setCalYear);

//		System.out.println("오늘:"+todayCalDay);
//		System.out.println("오늘월:"+todayCalMonth);
//		System.out.println("설정월:"+setCalMonth);
//		System.out.println("yearString:"+yearString);
//		System.out.println("monthString"+monthString);

		model.addAttribute("weekCount", weekCount); //현재 위치한 춸의 몇주가 있는지
		model.addAttribute("firstYoil", firstYoil); //현재 위치한 첫날의 요일
		model.addAttribute("currYear", currYear); //현재 위치한 연도
		model.addAttribute("currMonth", currMonth); //현재 위치한 월

		model.addAttribute("yearString", yearString); //달력 상단에서 표시하기 위해 사용
		model.addAttribute("monthString", monthString); //달력 상단에서 표시하기 위해 사용

//		System.out.println(model);
//		System.out.println("이번달은 몇주가 있나:"+weekCount);
//		System.out.println("이번달 첫째날의 요일은?: "+firstYoil); //현재 선택된 달의 첫번째 날의 요일
//		System.out.println("오늘날짜의 연도: "+currYear);
//		System.out.println("오늘날짜의 몇월: "+currMonth);
//		System.out.println("년도 String: "+yearString);
//		System.out.println("월 String: "+monthString);

		itgMap.put("yearmonth", yearString+monthString);
		itgMap.put("yearString", yearString);
		itgMap.put("monthString", monthString);
		itgMap.put("currYear", currYear);
		itgMap.put("currMonth", currMonth+1);

		int lasyDay = 0;                                       //마지막 날짜 변수
		cal.set(currYear,currMonth,1);                        //Calendar에서는 1월이 0이므로 우리가 사용하는 월에서 -1 해줘야 합니다.
		lasyDay = cal.getActualMaximum(Calendar.DATE);

		String nowDate = CommUtil.getDatePattern("yyyyMMdd");

		itgMap.put("allSdate", yearString+monthString+"01");
		itgMap.put("allEdate", yearString+monthString+lasyDay);
		itgMap.put("nowDate", nowDate.substring(6, 8));
		model.addAttribute("reqParam", itgMap);

/*		if("1".equals(itgMap.get("state").toString())) {
			model.addAttribute("calendar", commService.listComm("webBusinessInfo.calendarCount", (HashMap) paramMap));
			model.addAttribute("result", commService.listComm("webBusinessInfo.calendarList", (HashMap) paramMap));
		}else{
			model.addAttribute("calendar", commService.listComm("webBusiness.calendarCount", (HashMap) paramMap));
			model.addAttribute("result", commService.listComm("webBusiness.calendarList", (HashMap) paramMap));
		}*/

		return returnPage;
	}

    public String getMonthName (int monthNumber) { // This method is used to quickly return the proper name of a month

		String strReturn = "";
		switch (monthNumber)
		{
			//페이지 뷰부분에서 이미지처리하기 위해 월이름을 지정함
			case 0:	strReturn = "01"; 	break;
			case 1:	strReturn = "02";	break;
			case 2:	strReturn = "03";	break;
			case 3:	strReturn = "04";	break;
			case 4:	strReturn = "05";	break;
			case 5:	strReturn = "06";	break;
			case 6:	strReturn = "07";	break;
			case 7:	strReturn = "08";	break;
			case 8:	strReturn = "09";	break;
			case 9:	strReturn = "10";	break;
			case 10:strReturn = "11";	break;
			case 11:strReturn = "12";	break;
		}
		return strReturn;
    }


}
