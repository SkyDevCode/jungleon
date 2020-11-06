package egovframework.itgcms.mngr.main.web;

import java.io.IOException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.CubeSessionManager;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.common.StartupHousekeeper;
import egovframework.itgcms.core.board.service.BoardService;
import egovframework.itgcms.core.main.service.MngrMainService;
import egovframework.itgcms.core.manager.service.MngrManagerLoginLogVO;
import egovframework.itgcms.core.manager.service.MngrManagerService;
import egovframework.itgcms.core.manager.service.MngrManagerVO;
import egovframework.itgcms.core.member.service.MemberService;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.core.stats.service.MngrCountVO;
import egovframework.itgcms.core.stats.service.MngrStatsService;
import egovframework.itgcms.core.systemconfig.service.SystemconfigVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;


/**
 * @파일명 : MngrMainController.java
 * @파일정보 : 관리자 메인
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
public class MngrMainController {


	/** MngrMainService */
	@Resource(name = "mngrMainService")
	private MngrMainService mngrMainService;

	/** mngrManagerService */
	@Resource(name = "mngrManagerService")
	protected MngrManagerService mngrManagerService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/** MemberService */
	@Resource(name = "memberService")
	private MemberService memberService;

	/** MngrSiteService */
	@Resource(name = "mngrStatsService")
	private MngrStatsService mngrStatsService;

	/** BoardService */
	@Resource(name = "boardService")
	private BoardService boardService;

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	private final Logger LOGGER = LogManager.getLogger(this.getClass());

	@RequestMapping(value = "/_mngr_/main/index.do")
	public String mngrMainIndex(HttpServletRequest request, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException {

		String currSiteCode = CommUtil.getMngrSessionVO().getCurrSiteCode();

		String schSiteCode = currSiteCode;
		if(currSiteCode.equals("SYSTEM"))  schSiteCode = "all";

		LOGGER.debug("########################################################" + currSiteCode  + "#################################################");

		/* 대쉬보드 데이터 조회 */
		// 1. 신규 회원
		int memberRegistCount =  memberService.getMemberRegistCount();

		LOGGER.debug("########################################################" + memberRegistCount  + "#################################################");


		// 2. 오늘 방문자 수
		String yyyy = CommUtil.getDatePattern("yyyy");
		String mm = CommUtil.getDatePattern("MM");
		String dd = CommUtil.getDatePattern("dd");

		MngrCountVO paramCountVO = new MngrCountVO();
		paramCountVO.setSchSitecode(schSiteCode);
		paramCountVO.setCntOption("DAY");
		paramCountVO.setCntYear(	yyyy );
		paramCountVO.setCntMonth(	mm );
		paramCountVO.setCntDay(		dd );
		paramCountVO.setSchDate(	yyyy+"-"+mm+"-"+dd);
		int todayVisitCount = mngrStatsService.getTodayVisitCount(paramCountVO);

		// 3. 이번달 접속 수
		paramCountVO = new MngrCountVO();
		paramCountVO.setSchSitecode(schSiteCode);
		paramCountVO.setCntOption("MONTH");
		paramCountVO.setCntYear(	yyyy );
		paramCountVO.setCntMonth(	mm );
		paramCountVO.setCntDay(		dd );
		paramCountVO.setSchDate(	yyyy+"-"+mm+"-"+dd);
		int monthVisitCount = mngrStatsService.getTodayVisitCount(paramCountVO);

		// 4. 전체 접속 수
		paramCountVO = new MngrCountVO();
		paramCountVO.setSchSitecode(schSiteCode);
		paramCountVO.setCntOption("YEAR_GROUP");
		paramCountVO.setCntYear(	yyyy );
		paramCountVO.setCntMonth(	mm );
		paramCountVO.setCntDay(		dd );
		paramCountVO.setSchDate(	yyyy+"-"+mm+"-"+dd);
		int totalVisitCount = mngrStatsService.getTodayVisitCount(paramCountVO);


		//사용자 입력 게시판 가져오기
/*		BoardSearchVO boardSearchVO = new BoardSearchVO();
		boardSearchVO.setSchBcid("request"); //QNA.
		boardSearchVO.setFirstIndex(0);
		boardSearchVO.setLastIndex(5);*/

		// QNA 목록
	/*	List boardList = boardService.selectBoardMainList(boardSearchVO);
		model.addAttribute("boardList", boardList);*/

		// 1주일 접속 이력
		paramCountVO = new MngrCountVO();
		paramCountVO.setCntOption("DAY");
		paramCountVO.setStartDate(CommUtil.dateAdd(CommUtil.getDatePattern("yyyy-MM-dd"), -30));
		paramCountVO.setEndDate(CommUtil.getDatePattern("yyyy-MM-dd"));
		paramCountVO.setSiteCode(schSiteCode);

		Calendar calendar = Calendar.getInstance();
		Date endDate = new Date(calendar.getTimeInMillis()+60*60*24*1000);//1일 추가

		SimpleDateFormat dateStr = new SimpleDateFormat("yyyy-MM-dd");
		paramCountVO.setEndDate(dateStr.format(endDate));

		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH)-30);
		Date startDate = new Date(calendar.getTimeInMillis());
		paramCountVO.setStartDate(dateStr.format(startDate));

		List<MngrCountVO> resultList = mngrStatsService.mngrTermCountListforMain(paramCountVO);

		// 브라우저 별 접속 (도넛)
		paramCountVO = new MngrCountVO();
		paramCountVO.setCntOption("BROWSER");
		paramCountVO.setSiteCode(schSiteCode);
		List<MngrCountVO> resultBrowserList = mngrStatsService.selectMngrOptionCountList(paramCountVO);

		// 디바이스 별 접속 (도넛)
		paramCountVO = new MngrCountVO();
		paramCountVO.setCntOption("DEVICE");
		paramCountVO.setSiteCode(schSiteCode);
		List<MngrCountVO> resultDeviceList = mngrStatsService.selectMngrOptionCountList(paramCountVO);

		model.addAttribute("resultList", resultList);

		List<ItgMap> recentBoardList = boardService.getBoardList(schSiteCode, null, 5);

		model.addAttribute("recentlyBoard", recentBoardList);

		model.addAttribute("memberRegistCount", memberRegistCount);
		model.addAttribute("todayVisitCount", todayVisitCount);
		model.addAttribute("monthVisitCount", monthVisitCount);
		model.addAttribute("totalVisitCount", totalVisitCount);
		model.addAttribute("resultBrowserList", resultBrowserList);
		model.addAttribute("resultDeviceList", resultDeviceList);
		model.addAttribute("systemconfigVO", CommUtil.getSystemconfigVO());

		return "itgcms/mngr/main/mngrMainIndex";
	}

	@RequestMapping(value = "/_mngr_/main/login.do")
	public String mngrMainLogin(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		model.addAttribute("systemconfigVO", CommUtil.getSystemconfigVO());
		model.addAttribute("referer", CommUtil.isNull(request.getHeader("REFERER"), ""));
		HttpSession session = request.getSession();
		try{
			KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(1024);
			KeyPair keyPair = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();

			session.setAttribute("_RSA_KEY_", privateKey);   //세션에 RSA 개인키를 세션에 저장한다.
			//공개키를 문자열로 변환하여 script RSA 라이브러리에 넘겨준다
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);

			model.addAttribute("RSAModulus", publicKeyModulus);
			model.addAttribute("RSAExponent", publicKeyExponent);

		}catch(Exception e){
		}
		//return "mngr/main/mngrMainLogin";
		return "itgcms/mngr/main/mngrMainLogin";
	}


	/**
	 * SNB(LNB) 타입 B 인클루드 재귀호출
	 * @param list
	 * @param siteCode
	 * @param count
	 * @param type
	 * @param sDepth
	 * @param eDepth
	 * @return
	 */
/**	@SuppressWarnings("unchecked")
	private ItgMap recursiveMngrMenu(List<?> list, int count, String type, int sDepth, int eDepth, String mngrRoot, String mngType){
		ItgMap returnMap = new ItgMap();
		String str = "";
		String menuStr = "";
		int nowCount = count;
		String depth = "";
		for(int i = 0;i < list.size(); i++){
			MngrManagerMenuVO menuVO = (MngrManagerMenuVO) list.get(i);
			depth = menuVO.getMenuDepth();
			String idName = ""; //left메뉴 선택표시를 위한 아이디설정

			idName = "id=\""+type+"_"+menuVO.getMenuCode()+"\"";

			if(menuVO.getMngrManagerMenuList() != null && menuVO.getMngrManagerMenuList().size() > 0){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)
				str += "<li "+idName+" class=\"treeview haveSub\">\n";
				str += getMenuLink(menuVO, mngrRoot, depth);
					if(Integer.valueOf(menuVO.getMenuDepth()) >= sDepth  && Integer.valueOf(menuVO.getMenuDepth()) <= eDepth){
						if(menuVO.getMngrManagerMenuList().size() > 0)
							str += recursiveMngrMenu(menuVO.getMngrManagerMenuList(), ++count, type, sDepth, eDepth, mngrRoot, mngType);
					}
			}else{
				str += "<li "+idName+" class=\"treeview\">\n";
				str += getMenuLink(menuVO, mngrRoot, depth);
			}
			str += "</li>\n";
    		if("99".equals(mngType)) {
    			menuStr+=","+menuVO.getMenuCode().toUpperCase()+"|"+"CRUD";
    		}else {
    			menuStr+=","+menuVO.getMenuCode().toUpperCase()+"|"+"CRU";
    		}
		}
		if(nowCount > 0){//처음엔 ul이 필요없음.(코딩에 의한 설정)

			String dp = "";
			if(!"".equals(depth)) dp = String.valueOf(Integer.parseInt(depth) - 2);
			if("2".equals(dp) || "3".equals(dp)){
				str = "\n<ul class=\"treeview-menu\">\n" + str + "</ul>\n";
			}else{
				str = "\n<ul>\n" + str + "</ul>\n";
			}
		}

		returnMap.put("str", str);
		returnMap.put("menuStr", menuStr);
		return returnMap;
	}

	private String getMenuLink(MngrManagerMenuVO menuVO, String mngrRoot, String depth){
		String url = "#none"; //url에 입력된 값이 없으면 링크 없음
		String str = "";
		if(!"".equals(menuVO.getMenuUrl())){
			url = mngrRoot+menuVO.getMenuUrl()+".do";
		}
		str += "<a href='"+url+"'>";

		if("5".equals(depth)){
			str += "<i class=\"fa  fa-angle-right\"></i> <span>";
		}else{
			str += "<i class=\"fa  fa-circle-o\"></i> <span>";
		}
		str += menuVO.getMenuName().replaceAll("&", "&amp;")+"</span>";
		if(menuVO.getMngrManagerMenuList() != null && menuVO.getMngrManagerMenuList().size() > 0){//서브메뉴가 있으면
			str += "<i class=\"fa fa-angle-left pull-right\"></i>\n";
		}
		str += "</a>";
		return str;
	}
**/

	@RequestMapping(value = "/_mngr_/main/loginProc.do")
	public String mngrMainLoginProc(@ModelAttribute("managerVO") MngrManagerVO managerVO, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException {
		/* 아이디 비밀번호 입력 체크 */
		if("".equals(CommUtil.isNull(managerVO.getMngId(), ""))) return CommUtil.doComplete(model, "로그인 오류", "아이디를 입력 해 주세요.", "history.back();");
		if("".equals(CommUtil.isNull(managerVO.getMngPass(), ""))) return CommUtil.doComplete(model, "로그인 오류", "비밀번호를 입력 해 주세요.", "history.back();");

		ItgMap licenseInfo = new StartupHousekeeper().checkLicense();

		LOGGER.info("CUBE CMS 현재접속자 수 : "+CubeSessionManager.getUserCount()+"명");
		LOGGER.info("CUBE CMS 라이센스 허용 접속자 수 : "+licenseInfo.get("useCount")+"명");

		if(CubeSessionManager.getUserCount() >= Integer.parseInt(CommUtil.isNull(licenseInfo.get("useCount"),"0"))) {
			return CommUtil.doComplete(model, "로그인 오류", "허용된 동시접속자 수를 초과하였습니다.", "history.back();");
		}
		 /* RSA 복화화 */
		String possible="Y";
        PrivateKey privateKey = (PrivateKey) session.getAttribute("_RSA_KEY_");  //로그인전에 세션에 저장된 개인키를 가져온다.
        if (privateKey == null) {
        	possible="N";
		}
        try
        {
            //암호화처리된 사용자계정정보를 복호화 처리한다.
        	managerVO.setMngId( CustomUtil.RSAdecrypt( privateKey, managerVO.getMngId() ) );
        	managerVO.setMngPass( CustomUtil.RSAdecrypt(privateKey, managerVO.getMngPass()) );
        }catch(Exception e){
        }

		// 조회에 필요한 id 값 설정
		managerVO.setId(managerVO.getMngId());
		MngrManagerVO loginManagerVO;

		//우선 아이디로 회원정보 조회
		loginManagerVO = mngrManagerService.mngrManagerView(managerVO);

		// 회원정보가 없음.
		if(loginManagerVO == null){
			return CommUtil.doComplete(model, "로그인 오류", "아이디 또는 비밀번호를 확인 해 주세요.", "history.back();");
		}

		// 비밀번호 확인전에 IP 확인, IP제한 사용이고, IP목록이 있는경우 확인
		if(!"127.0.0.1".equals(request.getRemoteAddr()) && !"0:0:0:0:0:0:0:1".equals(request.getRemoteAddr())){
			if("Y".equals(loginManagerVO.getMngIpyn()) && !"".equals(loginManagerVO.getMngIp())){
				String[]ip = loginManagerVO.getMngIp().split(",");
				String userIp = request.getRemoteAddr();
				boolean access = false;
				for(int i = 0; i < ip.length; i++){
					if(ip[i].startsWith(userIp)){
						access = true;
					}
				}
				if(!access){
					return CommUtil.doComplete(model, "로그인 오류", "허용된 IP 접속이 아닙니다. 관리자에게 문의 해 주세요.\\n\\n접속 IP : " + userIp + "\\n\\n허용 IP : "+ loginManagerVO.getMngIp(), "history.back();");
				}
			}else if("Y".equals(loginManagerVO.getMngIpyn()) && "".equals(loginManagerVO.getMngIp())) {// IP제한 사용인데 목록에 값이 없으면 오류처리
				return CommUtil.doComplete(model, "로그인 오류", "허용된 IP로 접속 해 주세요.", "history.back(");
			}
		}

		int mngPassTryCnt = Integer.valueOf(CommUtil.isNull(loginManagerVO.getMngPasstrycnt(), "0"));
		// 비밀번호 오류 횟수가 5회 초과이면 로그인 못하게 함.
		if( mngPassTryCnt > 5  ){
			return CommUtil.doComplete(model, "로그인 오류", "비밀번호 오류 횟수가 5회 초과되어 로그인 할 수 없습니다.\\n관리자에게 문의 하세요.", "history.back();");
		}
		//사용자에게 입력 받은 비밀번호는 암호화 처리하고, DB에서 받아온 비밀번호는 그대로 맞는지 확인 한다.
//		if( !CommUtil.matchesPass(managerVO.getMngPass(), loginManagerVO.getMngPass() )	) {
		if( !CommUtil.hexSha256(managerVO.getMngPass()).equals(loginManagerVO.getMngPass())	) {
			//비밀번호가 일치하지 않으면 비밀번호 오류 횟수를 증가시킴
			mngPassTryCnt ++;

			// 로그인실패 횟수 저장
			managerVO.setMngPasstrycnt(String.valueOf(mngPassTryCnt));
			mngrManagerService.increaseMngPassTryCnt(managerVO);
			String msg = "아이디 또는 비밀번호 를 확인 해 주세요.\\n로그인 실패 (" + String.valueOf(mngPassTryCnt) + " / 5)";
			if(mngPassTryCnt > 5) {
				msg = "로그인 실패 횟수가 5회 초과되어 더이상 로그인 할 수 없습니다.\\n관리자에게 문의 하세요.";
			}
			return CommUtil.doComplete(model, "로그인 오류", msg, "history.back();");
		}

		//비밀번호 3개월 경과 후 비밀번호 재설정
		if("over".equals(loginManagerVO.getMngPassStatus())){
			return CommUtil.doCompleteUrl(model, "비밀번호 변경", "비밀번호 설정 후 3개월이 지나 변경이 필요합니다.", "/_mngr_/main/mngrPwdChange.do");
		}

		//로그인시 비밀번호 오류 횟수 0으로 초기화
		managerVO.setMngPasstrycnt(String.valueOf(0));
		mngrManagerService.increaseMngPassTryCnt(managerVO);

		java.util.HashMap<String, Object> hmAgent = CommUtil.getUserAgentParse(request.getHeader("User-Agent"));

		MngrManagerLoginLogVO mngrManagerLoginLogVO = new MngrManagerLoginLogVO();
		mngrManagerLoginLogVO.setLogIp(CommUtil.getClientIP(request));
		mngrManagerLoginLogVO.setLogId(loginManagerVO.getMngId());
		mngrManagerLoginLogVO.setLogAgent(request.getHeader("User-Agent"));
		mngrManagerLoginLogVO.setLogType("1");//1:관리자, 2:사용자
		mngrManagerLoginLogVO.setLogDevice((String)hmAgent.get("device"));
		mngrManagerLoginLogVO.setLogOs((String)hmAgent.get("os"));
		mngrManagerLoginLogVO.setLogBrowser((String)hmAgent.get("browser"));
		mngrManagerLoginLogVO.setLogSite("_mngr_");
		mngrManagerService.mngrManagerLoginLogInsert(mngrManagerLoginLogVO);

		MngrSessionVO mngrSessionVO = new MngrSessionVO();

		List<MngrSiteVO> siteList = mngrSiteService.selectMngrSiteList();

		if("99".equals(loginManagerVO.getMngAuth())){
			mngrSessionVO.setMngSiteList(siteList); //전체 사이트 리스트(최고관리자)

			//S
			String tmp = "";
			String tmpNm = "";

			for (int i = 0; i < siteList.size(); i++) {
				if("".equals(tmp)) {
					tmp  += siteList.get(i).getSiteCode();
					tmpNm  += siteList.get(i).getSiteName();
				} else {
					tmp  += ","+siteList.get(i).getSiteCode();
					tmpNm  += ","+siteList.get(i).getSiteName();
				}
			}

			loginManagerVO.setSiteCode(tmp);
			loginManagerVO.setSiteCodeNm(tmpNm);
			//E

			mngrSessionVO.setCurrSiteCode("SYSTEM");
			mngrSessionVO.setCurrSiteName("시스템관리");
		}else{
			List<MngrSiteVO> siteMapList = new ArrayList<MngrSiteVO>();
			for (int i = 0; i < siteList.size(); i++) {
				if(CommUtil.strInArrChk(loginManagerVO.getSiteCode(), siteList.get(i).getSiteCode())){
					siteMapList.add(siteList.get(i));
				}
			}
			mngrSessionVO.setMngSiteList(siteMapList); //본인 권한 사이트 리스트
		}

		mngrSessionVO.setId(loginManagerVO.getMngId());
		mngrSessionVO.setName(loginManagerVO.getMngName());
		mngrSessionVO.setEmail(loginManagerVO.getMngEmail());
		mngrSessionVO.setPhone(loginManagerVO.getMngPhone());
		mngrSessionVO.setGroup(loginManagerVO.getGroupCode());;
		mngrSessionVO.setPosition(loginManagerVO.getPositionCode());
		mngrSessionVO.setMngType(loginManagerVO.getMngType());
		mngrSessionVO.setMngAuth(loginManagerVO.getMngAuth());
		mngrSessionVO.setMngPower(loginManagerVO.getMngPower());
		mngrSessionVO.setMngRole(loginManagerVO.getMngRole());
		mngrSessionVO.setSiteCode(loginManagerVO.getSiteCode());
		mngrSessionVO.setSiteCodeNm(loginManagerVO.getSiteCodeNm());
		mngrSessionVO.setGroupName(loginManagerVO.getGroupCodeName());
		mngrSessionVO.setPositionName(loginManagerVO.getPositionCodeName());
		mngrSessionVO.setLicenseType(CommUtil.isNull(licenseInfo.get("cmsType"),"S"));

    	SystemconfigVO systemconfigVO = CommUtil.getSystemconfigVO();
    	if("N".equals(systemconfigVO.getMngrMultilogin())) {
    		if (CubeSessionManager.isUsing(managerVO.getMngId())) {
    			//현재로그인 사용자를 로그아웃시키는 경우
    			//return CommUtil.doComplete(model, "로그인 오류", "이미 로그인중인 아이디입니다.", "history.back();");

    			//기존로그인 사용자를 로그아웃시키고 현재 사용자를 로그인시키는 경우
    			CubeSessionManager.removeSession(managerVO.getMngId());
				session.setAttribute("mngrSessionVO", mngrSessionVO);
				session.setAttribute(managerVO.getMngId(),CubeSessionManager.getInstance());
				return CommUtil.doComplete(model, "중복로그인", "같은 아이디로 로그인된 사용자가 있으며, 기존 사용자는 로그아웃처리 합니다.", "location.href='/_mngr_/main/index.do'");
    		}
    	}
		//세션에 관리자 VO 저장
		session.setAttribute("mngrSessionVO", mngrSessionVO);
		session.setAttribute(managerVO.getMngId(),CubeSessionManager.getInstance());

		return CommUtil.doComplete(model, "로그인", "로그인 되었습니다.", "location.href='/_mngr_/main/index.do'");
	}

	@RequestMapping(value = "/_mngr_/main/logout.do")
	public String logout(ModelMap model, HttpSession session,HttpServletRequest request) throws IOException, SQLException, RuntimeException {
		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();

		if(mngrSessionVO == null){
			return CommUtil.doComplete(model, "오류", "로그인 정보가 없습니다.", "location.href='/_mngr_/main/login.do'");
		}

	   	//String path = CommUtil.getContextRoot();
	   	//path = CommUtil.getFilePathReplace(path);
		//CommUtil.deleteFile(path+System.getProperty("file.separator")+"/WEB-INF/jsp/egovframework/itgcms/mngr/_include/Include_"+mngrSessionVO.getId()+"_MENU.jsp");

		RequestContextHolder.getRequestAttributes().removeAttribute("mngrSessionVO", RequestAttributes.SCOPE_SESSION);
		session.invalidate();
		return CommUtil.doComplete(model, "로그인아웃", "", "location.href='/_mngr_/main/login.do'");
//		return CommUtil.doComplete(model, "로그인아웃", "로그아웃 되었습니다.", "location.href='/_mngr_/main/login.do'");
	}

	/**@RequestMapping(value = "/_mngr_/main/siteConfig.do")
	public String siteConfig(ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException {
		session.setAttribute("adm_type", "super");
		LOGGER.debug("로그인 처리:");
		return "mngr/main/siteConfig";
	}**/

}
