package egovframework.itgcms.project.rent.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.project.rent.service.RentEnum.FACILITY;
import egovframework.itgcms.project.rent.service.RentEnum.RENT_CUSTOMER;
import egovframework.itgcms.project.rent.service.RentEnum.RENT_EQUIPMENT;
import egovframework.itgcms.project.rent.service.RentEnum.RENT_MEET;
import egovframework.itgcms.project.rent.service.RentSearchVO;
import egovframework.itgcms.project.rent.service.RentService;
import egovframework.itgcms.project.rent.service.RentVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class RentController {

	@Autowired
	RentService rentService;

	@Autowired
	MngrCodeService mngrCodeService;

	/********************** S:사용자 **********************/
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_rentList.do")
	public String selectUserRentList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") RentSearchVO searchVO,  HttpSession session) throws IOException, SQLException {

    	if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");

    	if("list".equals(searchVO.getSchM())) {

    		/** 오늘 날짜 */
    		EgovMap paramMap = new EgovMap();
    		paramMap.put("today", CommUtil.getDatePattern("yyyy-MM-dd"));

    		List<RentVO> resultList = rentService.selectRentListWhereReserveDate(paramMap);
    		model.addAttribute("resultList", resultList);

			return "itgcms/project/rent/userRentList";
		} else if("regist".equals(searchVO.getSchM())) {

			// 코로나
			String currentPageUrl = "/" + siteCode + "/contents/Business4.do";
			return CommUtil.doCompleteConfirm(model, "오류", "수도권 중심 코로나19 집단감염에 따라 외부대관을 잠정 중단합니다. \\n\\n"
					+ "중단기간 :  ~ 별도 공지시까지\\n\\n"
					+ "대상시설 : 킨스타워 (대강당, 회의실), 제1비즈니스센터(중회의실)",
					"location.href='" + currentPageUrl + "'", "history.back();");

			//로그인 체크
			/*if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
				String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
				return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
						"location.href='" + loginPageUrl + "'", "history.back();");
			}
			Calendar cal = Calendar.getInstance();
			model.addAttribute("year", cal.get(Calendar.YEAR));
			model.addAttribute("month", CommUtil.getZeroPlus(cal.get(Calendar.MONTH) + 1));
			model.addAttribute("date", CommUtil.getZeroPlus(cal.get(Calendar.DAY_OF_MONTH)));
			model.addAttribute("facility", FACILITY.values());
			model.addAttribute("equipment", RENT_EQUIPMENT.values());
			return "itgcms/project/rent/userRentRegist";*/
		} else if("step2".equals(searchVO.getSchM())) { // 대관신청 상세정보 입력
			//로그인 체크
			if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
				String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
				return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
						"location.href='" + loginPageUrl + "'", "history.back();");
			}
			String rIdx = (String)session.getAttribute("rIdx");
			if(rIdx == null) {
				return CommUtil.doComplete(model, "오류", "대관 예약 신정 정보가 없습니다. 다시 시도해 주세요.", "history.back();");
			}
			model.addAttribute("custType", RENT_CUSTOMER.values());
			model.addAttribute("meetType", RENT_MEET.values());
			return "itgcms/project/rent/userRentRegistStep2";
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
	}




	@RequestMapping(value = "/{siteCode}/module/{menuCode}_userRentRegistProc.do")
	public String updateUserRentRegistProc(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") RentSearchVO searchVO, @ModelAttribute("rentVO") RentVO rentVO, HttpSession session) throws IOException, SQLException {

		//로그인 체크
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
		HashMap<String, String> resultMap = checkRentValidation(rentVO.getrFacility(), rentVO.getrEquipment(), rentVO.getrReserveDt()
				, rentVO.getrReserveTm(), rentVO.getYear(), rentVO.getMonth());
		if(!"1".equals(resultMap.get("result"))) {
			return CommUtil.doComplete(model, "오류", resultMap.get("message"), "history.back();");
		}
		rentVO.setrReserveDt(String.format("%s-%s-%s", rentVO.getYear(), rentVO.getMonth(), rentVO.getrReserveDt()));
		rentVO.setrCharge(resultMap.get("charge"));
		rentVO.setrId(CommUtil.getUserMemId());
		rentVO.setRegid(CommUtil.getUserMemId());

		String rIdx= rentService.insertRentReserveData(rentVO);
		if(rIdx != null && !"".equals(rIdx)) {
			session.setAttribute("rIdx", rIdx);
			String returnUrl = "/" + siteCode + "/contents/" + menuCode + ".do?schM=step2";
			return CommUtil.doComplete(model, "완료", "대관 예약 신청이 완료되었습니다. 상세정보 입력 페이지로 이동합니다.", "location.href='"+returnUrl+"'");
		} else {
			return CommUtil.doComplete(model, "오류", "대관 에약 신청 저장 중 오류가 발생했습니다. 확인 후 다시 시도해 주세요.", "history.back();");
		}
	}

	@RequestMapping(value = "/{siteCode}/module/{menuCode}_userRentRegistStep2Proc.do")
	public String updateUserRentRegistStep2Proc(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model, MultipartHttpServletRequest multiRequest  ,
			@ModelAttribute("searchVO") RentSearchVO searchVO, @ModelAttribute("rentVO") RentVO rentVO, HttpSession session) throws IOException, SQLException {

		//로그인 체크
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
		String rIdx = (String)session.getAttribute("rIdx");
		if(rIdx == null) {
			return CommUtil.doComplete(model, "오류", "대관 예약 신정 정보가 없습니다. 다시 시도해 주세요.", "history.back();");
		}
		/*
		if("".equals(CommUtil.isNull(rentVO.getrName(), ""))) return CommUtil.doComplete(model, "오류", "담당자명을 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrTel(), ""))) return CommUtil.doComplete(model, "오류", "연락처를 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrEmail(), ""))) return CommUtil.doComplete(model, "오류", "에미일 주소를 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrAddr(), ""))) return CommUtil.doComplete(model, "오류", "소재지를 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrComName(), ""))) return CommUtil.doComplete(model, "오류", "회사명/단체명을 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrPersonNum(), ""))) return CommUtil.doComplete(model, "오류", "인원을 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrCarry(), ""))) return CommUtil.doComplete(model, "오류", "반입물품을 입력해 주세요.", "history.back();");
*/
		rentVO.setrIdx(rIdx);
		rentVO.setrId(CommUtil.getUserMemId());
		rentVO.setUpdid(CommUtil.getUserMemId());
		int result = rentService.updateRent(rentVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "대관 예약 신정이 내용이 없습니다.", "history.back();");
		}
		session.setAttribute("rIdx", null);
		return CommUtil.doComplete(model, "성공", "대관 예약 신정이 완료 되었습니다.", "location.href='/"+siteCode+"/contents/" + menuCode + ".do'");
	}


	@RequestMapping(value="/{siteCode}/module/{menuCode}_userPrintCalendar.ajax")
	public String  userPrintCalendar(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			HttpServletRequest request) throws IOException, SQLException{
		String regist = CommUtil.isNull(request.getParameter("regist"), "");

		Calendar cal = Calendar.getInstance();
		String schYear = request.getParameter("year");
		String schMonth = request.getParameter("month");
		if(!"".equals(CommUtil.isNull(schYear, "")) &&
			!"".equals(CommUtil.isNull(schMonth, ""))
				) {
			//파라메터 년,월이 있으면 Calendar에 파라메터로 설정
			cal.set(Calendar.YEAR, Integer.parseInt(schYear));
			cal.set(Calendar.MONTH, Integer.parseInt(schMonth) - 1 );
		}

		/**** S:  달력 출력을 위한 변수 설정 */
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int date = cal.get(Calendar.DAY_OF_MONTH);
		// 검색 년월의 1일 요일
		cal.set(Calendar.DATE, 1);
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		//마지막날 구하기. 검색년월의 다음달 1일 설정하고, 하루이전날로 설정하면 검색년월 말일이 됨.
		cal.set(year, month, 1);
		cal.add(Calendar.DATE, -1);
		int lastDayOfMonth = cal.get(Calendar.DATE);

		//마지막날의 요일. 검색년, 월의 마지막날로 설정.
		cal.set(year, month - 1, lastDayOfMonth);
		int dayOfWeekLastDay = cal.get(Calendar.DAY_OF_WEEK);

		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("date", date);
		model.addAttribute("dayOfWeek", dayOfWeek);
		model.addAttribute("lastDayOfMonth", lastDayOfMonth);
		model.addAttribute("dayOfWeekLastDay", dayOfWeekLastDay);

		//prev 버튼.
		cal.set(year, month - 2, 1);
		model.addAttribute("prevYear", cal.get(Calendar.YEAR));
		model.addAttribute("prevMonth", cal.get(Calendar.MONTH) + 1);
		//next 버튼.
		cal.set(year, month, 1);
		model.addAttribute("nextYear", cal.get(Calendar.YEAR));
		model.addAttribute("nextMonth", cal.get(Calendar.MONTH) + 1);
		/***  E: 달력 출력을 위한 변수 설정 */

		String schFacility = request.getParameter("schFacility");
		/** 신청건 조회 */
		EgovMap paramMap = new EgovMap();
		paramMap.put("year", String.valueOf(year));
		paramMap.put("month", String.valueOf(CommUtil.getZeroPlus(month)));
		paramMap.put("schFacility", request.getParameter("schFacility"));
		if("".equals(regist)) {
			List<EgovMap> resultList = rentService.selectRentCountGroupByDay(paramMap);
			EgovMap resultMap = new EgovMap();
			for(EgovMap map : resultList) {
				resultMap.put((String)map.get("dt"), map.get("cnt"));
			}
			model.addAttribute("result", resultMap);
		} else if("Regist".equals(regist)){
			//신청하기의 날짜리스트는 설정
			List<EgovMap> dateList = new ArrayList<EgovMap>();
			for(int d = 1; d <= lastDayOfMonth; d++) {
				EgovMap map = new EgovMap();
				cal.set(year, month-1, d);
				int week = cal.get(Calendar.DAY_OF_WEEK);
				String disabled = "";
				if(CommUtil.dateDiff(String.format("%d-%02d-%02d", year, month, d)) < 0) {
					disabled = "disabled";
				}
				if("3".equals(schFacility)) { // 제1비즈니스센터는 주말 예약 안됨.
					if(week == 1 || week == 7) {
						disabled = "disabled";
					}
					if(!"".equals(CustomUtil.getHoliday(String.format("%02d%02d", month, d)))) {
						disabled = "disabled";
					}
				}
				map.put("year", cal.get(Calendar.YEAR));
				map.put("month", cal.get(Calendar.MONTH) + 1);
				map.put("date", d);
				map.put("week", week);
				map.put("disabled", disabled);
				dateList.add(map);
			}
			model.addAttribute("dateList", dateList);
		}

		return "itgcms/project/rent/userPrintCalendar" + regist;
	}
	/**
	 * 선택한 날짜에 해당하는 대관신청 리스트
	 * @param siteCode
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@ResponseBody
	@RequestMapping(value="/{siteCode}/module/{menuCode}_userRentReserveData.ajax")
	public ModelMap  selectUserRentReserveData(@PathVariable String siteCode,  @PathVariable String menuCode, ModelMap model,
			HttpServletRequest request) throws IOException, SQLException{

		model = new ModelMap();
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		EgovMap paramMap = new EgovMap();
		paramMap.put("today", String.format("%s-%s-%s", year, month, day));

		try {
			List<RentVO> resultList = rentService.selectRentListWhereReserveDate(paramMap);
			model.addAttribute("year", year);
			model.addAttribute("month", month);
			model.addAttribute("day", day);
			model.addAttribute("today", String.format("%s-%s-%s", year, month, day));
			model.addAttribute("data", resultList);
			model.addAttribute("result","1");
		}catch(Exception e) {
			model.addAttribute("result","0");
			model.addAttribute("message", "조회중 오류가 발생했습니다.");
		}
		return model;
	}

	@RequestMapping(value="/{siteCode}/module/{menuCode}_userPrintTimeList.ajax")
	public String  selectUserPrintTimeList(@PathVariable String siteCode,  @PathVariable String menuCode, ModelMap model,
			HttpServletRequest request) throws IOException, SQLException{

		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = request.getParameter("date");
		String schFacility = request.getParameter("schFacility");

		// 예약된 시간목록
		HashMap<String, String> timeMap =  getReservedTimeList(rentService, year, month, date, schFacility);

		// 대관장소 별 시간 목록.
		String[] timeList = getTimeList(year, month, date, schFacility).split(",");
		List<HashMap<String, String>> resultTimeList = new ArrayList<HashMap<String, String> >();
		for(int i = 0; i < timeList.length; i++) {
			HashMap<String, String>  map = new HashMap<String, String>();
			map.put("time", timeList[i]);
			String disabled = "";
			if(timeMap.containsKey("T"+timeList[i])) {
				disabled = "disabled";
			}
			map.put("disabled", disabled);
			resultTimeList.add(map);
		}
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("date", date);
		model.addAttribute("resultTimeList", resultTimeList);

		return "itgcms/project/rent/userPrintTimeList";
	}

	@ResponseBody
	@RequestMapping(value="/{siteCode}/module/{menuCode}_userRentCalculate.ajax")
	public ModelMap  selectUserRentCaculate(@PathVariable String siteCode, @PathVariable String menuCode,
			HttpServletRequest request) throws IOException, SQLException{

		ModelMap model = new ModelMap();
		String rFacility = CommUtil.isNull( request.getParameter("rFacility"), "");
		String rEquipment = CommUtil.isNull( request.getParameter("rEquipment"), "");
		String rReserveDt = CommUtil.isNull( request.getParameter("rReserveDt"), "");
		String rReserveTm = CommUtil.isNull( request.getParameter("rReserveTm"), "");
		String year = CommUtil.isNull( request.getParameter("year"), "");
		String month = CommUtil.isNull( request.getParameter("month"), "");

		HashMap<String, String> resultMap = checkRentValidation(rFacility, rEquipment, rReserveDt, rReserveTm, year, month);
		model.addAttribute("message", resultMap.get("message"));
		model.addAttribute("result", resultMap.get("result"));
		if(!"".equals(CommUtil.isNull(resultMap.get("charge"), ""))) {
			model.addAttribute("charge", String.format(Locale.KOREA, "%,d", Integer.parseInt(resultMap.get("charge"))));
		}

		return model;
	}
	private HashMap<String, String> checkRentValidation(String rFacility, String rEquipment, String rReserveDt, String rReserveTm, String year, String month) throws SQLException {
		HashMap<String, String> resultMap = new HashMap<String, String>();
		if("".equals(rFacility)) { resultMap.put("message", "대관장소를 선택 해 주세요."); resultMap.put("result","0"); return resultMap;}
		else if("".equals(rReserveDt)) { resultMap.put("message", "예약날짜를 선택 해 주세요."); resultMap.put("result","0"); return resultMap;}
		else if("".equals(rReserveTm)) { resultMap.put("message", "예약시간을 선택 해 주세요."); resultMap.put("result","0"); return resultMap;}
		else if("".equals(year)) { resultMap.put("message", "선택된 년도 정보가 없습니다."); resultMap.put("result","0"); return resultMap;}
		else if("".equals(month)) { resultMap.put("message", "선택된 월 정보가 없습니다."); resultMap.put("result","0"); return resultMap;}

		String[] arrTime = rReserveTm.split(",");
		int first = Integer.parseInt(arrTime[0]);
		int last = Integer.parseInt(arrTime[arrTime.length - 1]);
		if(arrTime.length < 2 || (last - first != arrTime.length -1) ) {
			resultMap.put("message", "예약시간은 최소 2시간, 연속으로 선택해 주세요.");
			resultMap.put("result", "0");
			return resultMap;
		}

		EgovMap paramMap = new EgovMap();
		paramMap.put("schFacility", rFacility);
		paramMap.put("today", String.format("%s-%s-%s", year, month, rReserveDt));
		paramMap.put("rReserveTm", "(" + StringUtils.join(arrTime, "|") + ")");

		List<RentVO> resultList = rentService.selectRentReserveTime(paramMap);
		if(resultList.size() > 0) {
			resultMap.put("message", "이미 예약된 시간을 선택했습니다. 예약시간을 다시 선택 해 주세요.");
			resultMap.put("result", "2");
			return resultMap;
		}

		//대관장소 별 예약 시간 목록
		String timeList = getTimeList(year, month, rReserveDt, rFacility);
		if(timeList.indexOf(rReserveTm) == -1) {
			resultMap.put("message","예약할 수 없는 시간을 선택했습니다. 예약시간을 다시 선택 해 주세요.("+rReserveTm+")");
			resultMap.put("result", "2");
			return resultMap;
		}

		resultMap.put("result", "1");
		resultMap.put("charge", String.valueOf(getCharge(year, month, rReserveDt, rFacility, arrTime, rEquipment)));
		return resultMap;
	}
	private int getCharge(String year, String month, String date, String schFacility, String[] arrReserveTime, String rEquipment) {
		int charge = 0;
		if("3".equals(schFacility)) return 0;
		//******** S: 장소 비용 계산 *******/
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(year),  Integer.parseInt(month) - 1, Integer.parseInt(date));
		int week = cal.get(Calendar.DAY_OF_WEEK);
		boolean weekend = false;
		weekend = (week == 1 || week == 7)? true: false;
		if(!"".equals(CustomUtil.getHoliday(month+date))) {
			weekend = true;
		}
		//  기본, 추가금, 할인적용 이용시간, 할인금.
		int[][] facPriceTable = {
			{200000, 50000, 9, 150000}, // 대강당. 주중
			{300000, 75000, 9, 225000}, // 대강당. 주말
			{50000, 25000, 9, 25000}, // 회의실. 주중
			{100000, 40000, 9, 80000} // 회의실. 주말
		};
		int index = ("1".equals(schFacility)) ? 0 : 2;
		if(weekend) index ++;
		int facRentCharge = 0;
		if("09".equals(arrReserveTime[0])) { // 09시부터 예약인지.
			facRentCharge = facPriceTable[index][0] + (arrReserveTime.length - 2) * facPriceTable[index][1]; //총가격 (기본가격 + 시간갯수 -2(기본빼고) * 추가금)
			if(arrReserveTime.length >= facPriceTable[index][2]) { // 9시간 예약하면 할인 적용
				facRentCharge = facRentCharge - facPriceTable[index][3];//할인 적용
			}
		} else {
			facRentCharge = facPriceTable[index][0] + (arrReserveTime.length - 2) * facPriceTable[index][1]; //총가격 (기본가격 + 시간갯수 -2(기본빼고) * 추가금)
		}
		charge += facRentCharge;

		// 부가세포함(20.06.09)
		int facRentTax = facRentCharge * 10 / 100;
		charge += facRentTax;

		//******** E: 장소 비용 계산 *******/
		//******** S: 장비 비용 계산 *******/
		int equipRentChage = 0;
		//  기본, 추가금, 할인적용 이용시간, 할인금액, 최대금액.
		// 장비는 기준시간 이상이면 동일금액임. 시작시간은 의미 없음
		int[][] equipPriceTable = {
				{20000, 10000, 9, 10000, 100000}, // 냉난방. 주중
				{20000, 10000, 9, 10000, 80000}, // 냉난방. 주말
				{20000, 10000, 5, 10000, 40000}, // 마이크&빔프로젝터. 주중
				{20000, 10000, 5, 10000, 40000} // 마이크&빔프로젝터. 주말
			};

		if(!"".equals(rEquipment)) {
			String[] arrEquip = rEquipment.split(",");
			for(int i = 0; i < arrEquip.length; i++) {
				int equip01 = 0;
				index = ("1".equals(arrEquip[i]))? 0 : 2; //1은 냉난방 0주중,1주말 2마이크주중, 3마이크 주말
				if(weekend) index ++;//주말,공휴일은 다음 배열
				equip01 = equipPriceTable[index][0] + (arrReserveTime.length - 2) * equipPriceTable[index][1]; // 기본금 +( 시간 -1 * 추가금)
				if(arrReserveTime.length >= equipPriceTable[index][2]) { // 9시간 예약하면 할인 적용
					equip01 = equip01 - equipPriceTable[index][3];//할인 적용
				}
				if(equip01 > equipPriceTable[index][4]) equip01 = equipPriceTable[index][4]; // 최대금액 이상이면 최대금액으로 설정.
				equipRentChage += equip01;
			}
		}
		//******** E: 장비 비용 계산 *******/
		charge += equipRentChage;

		// 부가세포함(20.06.09)
		int equipRentTax = equipRentChage * 10 / 100;
		charge += equipRentTax;

		return charge;

		/* 초안 기준표
		9:00~22:00 기준
		사용 시간	대관 시간			 대강당 	 회의실(한빛이룸) 	 냉난방 	 마이크&빔프로젝터
		2시간		9:00	~	10:00	200,000원	 50,000원	 20,000원	20,000원
			    10:00	~	11:00
		3시간		11:00	~	12:00	250,000원	 75,000원	 30,000원	30,000원
		4시간		12:00	~	13:00	300,000원	100,000원	 40,000원	40,000원
		5시간		13:00	~	14:00	350,000원	125,000원	 50,000원	40,000원
		6시간		14:00	~	15:00	400,000원	150,000원	 60,000원	40,000원
		7시간		15:00	~	16:00	450,000원	175,000원	 70,000원	40,000원
		8시간		16:00	~	17:00	500,000원	200,000원	 80,000원	40,000원
		9시간		17:00	~	18:00	400,000원	200,000원	 80,000원	40,000원
		10시간	18:00	~	19:00	450,000원	225,000원	 90,000원	40,000원
		11시간	19:00	~	20:00	500,000원	250,000원	100,000원	40,000원
		12시간	20:00	~	21:00	550,000원	275,000원	100,000원	40,000원
		13시간	21:00	~	22:00	600,000원	300,000원	100,000원	40,000원


		10:00~22:00 기준
		사용 시간	대관 시간			 대강당 	 회의실(한빛이룸) 	 냉난방 	 마이크&빔프로젝터
		2시간		10:00	~	11:00	200,000원	 50,000원	 20,000원	20,000원
			    11:00	~	12:00
		3시간		12:00	~	13:00	250,000원	 75,000원	 30,000원	30,000원
		4시간		13:00	~	14:00	300,000원	100,000원	 40,000원	40,000원
		5시간		14:00	~	15:00	350,000원	125,000원	 50,000원	40,000원
		6시간		15:00	~	16:00	400,000원	150,000원	 60,000원	40,000원
		7시간		16:00	~	17:00	450,000원	175,000원	 70,000원	40,000원
		8시간		17:00	~	18:00	500,000원	200,000원	 80,000원	40,000원
		9시간		18:00	~	19:00	550,000원	225,000원	 80,000원	40,000원
		10시간	19:00	~	20:00	600,000원	250,000원	 90,000원	40,000원
		11시간	20:00	~	21:00	650,000원	275,000원	100,000원	40,000원
		12시간	21:00	~	22:00	700,000원	300,000원	100,000원	40,000원


		*/
		// 1
		// 평일 기본 두시간 200,000 추가 50,000
		// 09시부터 17 : 400,000, 18:450,000, 19:500,000, 20:550,000, 21:600,000
		// [0] 09이고 length 9 보다 크면 할인.(-150,000)
		// [0] 09아니면 200,000 + length -2 * 50,000
	}
	/**
	 * 예약장소 별 예약가능 시간 목록을 String Array return.
	 * @param year
	 * @param month
	 * @param date
	 * @param schFacility
	 * @return
	 */
	private String getTimeList(String year, String month, String date, String schFacility) {
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(year), Integer.parseInt(month) - 1, Integer.parseInt(date));
		int week = cal.get(Calendar.DAY_OF_WEEK);

		String[][] timeTable = {
					{"1", "week", "09,10,11,12,13,14,15,16,17,18,19,20,21"} // 킨스타워 대강당, 주중
					,{"1", "weekend", "09,10,11,12,13,14,15,16,17"} // 킨스타워 대강당 주말,휴일
					,{"2", "week", "09,10,11,12,13,14,15,16,17,18,19,20,21"} // 킨스타워 회의실 주중
					,{"2", "weekend", "09,10,11,12,13,14,15,16,17"} // 킨스타워 회의실 주말,휴일
					,{"3", "week", "09,10,11,12,13,14,15,16,17"} // 제1비즈니스 회의실 주중
					,{"3", "weekend", ""} // 제1비즈니스 회의실 주말,휴일 예약 불가.
				};

		String weekName = "week";
		if(week == 1 || week == 7 || !"".equals( CustomUtil.getHoliday(month+date))) {
			weekName = "weekend";
		}

		for(int i = 0; i < timeTable.length; i++) {
			if(schFacility.equals(timeTable[i][0]) && weekName.equals(timeTable[i][1])) {
				return timeTable[i][2];
			}
		}
		return "";
	}

	private HashMap<String, String> getReservedTimeList(RentService rentService, String year, String month, String date, String schFacility) throws SQLException{
		EgovMap paramMap = new EgovMap();
		paramMap.put("schFacility", schFacility);
		paramMap.put("today", String.format("%s-%s-%s", year, month, date));

		List<RentVO> resultList = rentService.selectRentReserveTime(paramMap);

		HashMap<String, String> timeMap = new HashMap<String, String> ();
		for(int i = 0; i < resultList.size(); i++) {
			RentVO tmpVO = resultList.get(i);
			if(tmpVO != null && !"".equals(tmpVO.getrReserveTm())) {
				String[] arrReserveTm = tmpVO.getrReserveTm().split(",");
				int first = Integer.parseInt(arrReserveTm[0]);
				int last = Integer.parseInt(arrReserveTm[arrReserveTm.length - 1]);
				if(arrReserveTm.length < 2 || (last - first != arrReserveTm.length -1) ) {
					continue;
				}
				for(int k = 0; k < arrReserveTm.length; k++) {
					timeMap.put("T" + arrReserveTm[k], arrReserveTm[k]);
				}
			}
		}
		return timeMap;
	}

    /********************** E:사용자 **********************/

    /********************** S:관리자 **********************/
	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrRentList.do")
	public String selectMngrRentList(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") RentSearchVO searchVO) throws IOException, SQLException{

		if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");
		if("list".equals(searchVO.getSchM())) {
			/** paging setting */
			int totCnt = rentService.selectRentListTotCnt(searchVO);
			// pagesize, viewcount => searchVO에 설정
			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

			List<RentVO> resultList = rentService.selectRentList(searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

			MngrCodeVO mngrCodeVO = new MngrCodeVO();
			mngrCodeVO.setSchCode("rent01");
			model.addAttribute("statusCodeList", mngrCodeService.getMngrCodeList(mngrCodeVO));

			model.addAttribute("resultList", resultList);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/rent/mngrRentList";
		} else if("view".equals(searchVO.getSchM())) {
			RentVO result = rentService.selectRentView(searchVO);
			if(result == null) {
				return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
			}

			MngrCodeVO mngrCodeVO = new MngrCodeVO();
			mngrCodeVO.setSchCode("rent01");
			model.addAttribute("statusCodeList", mngrCodeService.getMngrCodeList(mngrCodeVO));

			model.addAttribute("result", result);
			model.addAttribute("facility", FACILITY.values());
			model.addAttribute("customerList", RENT_CUSTOMER.values());
			model.addAttribute("meetList", RENT_MEET.values());
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/rent/mngrRentView";
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
	}
	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrRentListExcelDown.do")
	public ModelAndView selectMngrRentListExceDown(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") RentSearchVO searchVO, HttpServletRequest request) throws IOException, SQLException{

		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);

		searchVO.setExcelDown("Y");
		List<RentVO> resultList = rentService.selectRentList(searchVO);

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dataList", resultList);

		//엑셀 템플릿에 넘겨줄 데이타
		mav.addObject("data", paramMap);

		//다운로드에 사용되어질 엑셀파일 템플릿
		mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrRentListExcel");
		//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
		mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "상품정보-" + CommUtil.getDatePattern("yyyy-MM-dd"));

		return mav;
	}


	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrRentUpdateProc.do")
	public String updateMngrRentProc(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") RentSearchVO searchVO, @ModelAttribute("rentVO") RentVO rentVO, MultipartHttpServletRequest multiRequest   ) throws IOException, SQLException{

		if("".equals(CommUtil.isNull(rentVO.getrName(), ""))) return CommUtil.doComplete(model, "오류", "담당자명을 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrTel(), ""))) return CommUtil.doComplete(model, "오류", "연락처를 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrEmail(), ""))) return CommUtil.doComplete(model, "오류", "에미일 주소를 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrAddr(), ""))) return CommUtil.doComplete(model, "오류", "소재지를 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrComName(), ""))) return CommUtil.doComplete(model, "오류", "회사명/단체명을 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrPersonNum(), ""))) return CommUtil.doComplete(model, "오류", "인원을 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrCarry(), ""))) return CommUtil.doComplete(model, "오류", "반입물품을 입력해 주세요.", "history.back();");

		else if("".equals(CommUtil.isNull(rentVO.getrFacility(), ""))) return CommUtil.doComplete(model, "오류", "대관장소를 선택 해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrEquipment(), ""))) return CommUtil.doComplete(model, "오류", "장비를 선택해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrReserveDt(), ""))) return CommUtil.doComplete(model, "오류", "예약 날짜를 선택해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(rentVO.getrReserveTm(), ""))) return CommUtil.doComplete(model, "오류", "예약 시간을 선택해 주세요.", "history.back();");


		rentVO.setrIdx(searchVO.getSchId());
		rentVO.setUpdid(CommUtil.getMngrMemId());
		int result = rentService.updateRent(rentVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "수정 내용이 없습니다.", "history.back();");
		}
		searchVO.setSchM("list");
		return CommUtil.doComplete(model, "성공", "정상적으로 수정처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_mngrRentList.do?" + searchVO.getQuery()+ "'");
	}

	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrRentUpdateStatusProc.do")
	public String updateMngrRentUpdateStatusProc(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") RentSearchVO searchVO, @ModelAttribute("rentVO") RentVO rentVO) throws IOException, SQLException{

		if("".equals(CommUtil.isNull(rentVO.getrStatus(), ""))) return CommUtil.doComplete(model, "오류", "처리상태를 선택해 주세요.", "history.back();");


		rentVO.setrIdx(searchVO.getSchId());
		rentVO.setUpdid(CommUtil.getMngrMemId());
		int result = rentService.updateRentStatus(rentVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "수정 내용이 없습니다.", "history.back();");
		}
		searchVO.setSchM("view");
		return CommUtil.doComplete(model, "성공", "정상적으로 수정처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_mngrRentList.do?" + searchVO.getQuery()+ "'");
	}



	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrRentDeleteProc.do")
	public String deleteMngrRentDeleteProc(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") RentSearchVO searchVO, @ModelAttribute("rentVO") RentVO rentVO  ) throws IOException, SQLException{

		rentVO.setrIdx(searchVO.getSchId());
		rentVO.setDelid(CommUtil.getMngrMemId());
		int result = rentService.deleteRentProc(rentVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "삭제 내용이 없습니다.", "history.back();");
		}
		searchVO.setSchM("list");
		return CommUtil.doComplete(model, "성공", "정상적으로 삭제처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_mngrRentList.do?" + searchVO.getQuery()+ "'");
	}
	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrRentMultiDeleteProc.do")
	public String deleteMngrRentMultiDeleteProc(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") RentSearchVO searchVO, @ModelAttribute("rentVO") RentVO rentVO  ) throws IOException, SQLException{

		if(searchVO.getChkId() == null || searchVO.getChkId().length == 0) {
			return CommUtil.doComplete(model, "오류", "삭제할 게시물을 선택해 주세요.", "history.back();");
		}

		int result = rentService.deleteRentMultiProc(searchVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "삭제중 오류가 발생했습니다 .확인 후 다시 시도해 주세요.", "history.back();");
		}
		searchVO.setSchM("list");
		return CommUtil.doComplete(model, "성공", "정상적으로 삭제처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_mngrRentList.do?" + searchVO.getQuery()+ "'");
	}

    /********************** E:관리자 **********************/
}
