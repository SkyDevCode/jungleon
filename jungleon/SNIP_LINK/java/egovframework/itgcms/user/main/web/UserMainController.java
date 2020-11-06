package egovframework.itgcms.user.main.web;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.board.service.BoardSearchVO;
import egovframework.itgcms.core.board.service.BoardService;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigVO;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.core.menu.service.MngrMenuService;
import egovframework.itgcms.core.menu.service.MngrMenuVO;
import egovframework.itgcms.core.popup.service.MngrPopupSearchVO;
import egovframework.itgcms.core.popup.service.MngrPopupService;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.slides.service.MngrSlidesService;
import egovframework.itgcms.core.stats.service.MngrCountVO;
import egovframework.itgcms.core.stats.service.MngrStatsService;
import egovframework.itgcms.core.stats.service.MngrStatsVO;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.core.systemconfig.service.SystemconfigVO;
import egovframework.itgcms.module.socialmedia.service.SocialmediaService;
import egovframework.itgcms.project.totalTable.service.TotalTableService;
import egovframework.itgcms.project.totalTable.service.TotalTbSearchVO;
import egovframework.itgcms.project.totalTable.service.TotalTbVO;
import egovframework.itgcms.user.main.service.MainBsnsVO;
import egovframework.itgcms.user.main.service.UserMainService;
import egovframework.itgcms.user.member.service.GonggoReqService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.NaverBlogRss;
import egovframework.itgcms.util.TwitterRss;
import egovframework.itgcms.util.YoutubePlayList;



/**
 * @파일명 : UserMainController.java
 * @파일정보 : 사용자 메인
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2015. 3. 27. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class UserMainController {

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	@Resource(name="gonggoReqService")
	GonggoReqService gonggoReqService;
	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	/** MngrMenuService */
	@Resource(name = "mngrMenuService")
	private MngrMenuService mngrMenuService;

	/** BoardService */
	@Resource(name = "boardService")
	private BoardService boardService;

	/** MngrPopupService */
	@Resource(name = "mngrPopupService")
	private MngrPopupService mngrPopupService;

	/** MngrSiteService */
	@Resource(name = "mngrStatsService")
	private MngrStatsService mngrStatsService;

	/** MngrSlidesService */
	@Resource(name = "mngrSlidesService")
	private MngrSlidesService mngrSlidesService;

	/** socialmediaService */
	@Resource(name="socialmediaService")
	private SocialmediaService socialmediaService;

	/** userMainService */
	@Resource(name="userMainService")
	private UserMainService userMainService;

	/** totalTableService */
	@Resource(name="totalTableService")
	private TotalTableService totalTableService;

	/** mngrCodeService */
	@Resource(name="mngrCodeService")
	private MngrCodeService mngrCodeService;



	private static final Logger logger = LogManager.getLogger(UserMainController.class);


	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(ModelMap model, HttpServletRequest request, HttpSession session, HttpServletResponse response ) throws IOException, SQLException, RuntimeException {

		SystemconfigVO systemconfigVO = CommUtil.getSystemconfigVO();

		String siteGubun = systemconfigVO.getSiteGubun(); // 사이트구분 1.서브디렉토리방식, 2.서브도메인방식
		String domainAddr = systemconfigVO.getDomainAddr();
		String rootCode = "";
		String returnUrl = "";
		String defaultUrl = "/"+CommUtil.getDefaultSiteCode()+"/main/index.do";
		if("2".equals(siteGubun)){
			//rootCode = (request.getRequestURL()).toString().split("//")[1].split("[.]")[0];
			rootCode = (request.getRequestURL()).toString().split("//")[1];

			if(rootCode.indexOf(domainAddr) < 0){
				returnUrl =  CommUtil.doCompleteUrl(model, "알림", "도메인 주소가 올바르지 않습니다. 메인 사이트로 이동합니다.", defaultUrl);
			}else if(rootCode.indexOf(domainAddr) == 0){
				returnUrl =  "redirect:"+defaultUrl;
			}else{
				rootCode = rootCode.substring(0, rootCode.indexOf(domainAddr)-1);
				if("www".equals(rootCode)){
					returnUrl =  "redirect:"+defaultUrl;
				}else{
					if(CommUtil.isExistSite(rootCode)) {
						returnUrl =  "redirect:/"+rootCode+"/main/index.do";
					}else{
						returnUrl =  CommUtil.doCompleteUrl(model, "알림", "사이트 설정이 올바르지 않습니다. 기본 사이트로 이동합니다.", defaultUrl);
					}
				}
			}
		}else{
			returnUrl = "redirect:"+defaultUrl;
		}

		return returnUrl;
	}

	@RequestMapping(value = "/{root}", method = RequestMethod.GET)
	public String home2(@PathVariable String root, ModelMap model, HttpServletRequest request, HttpSession session, HttpServletResponse response ) throws IOException, SQLException, RuntimeException {

/*		String site = CommUtil.isNull(CommUtil.getSiteFile(), "web");
		site = site.replaceAll("\\n", "");
		site = "(" + site + ")";*/
		if ("index".equals(root)) {
			root="SNIP";
		}
		if (!CommUtil.isExistSite(root)) {
			return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
		}

		String returnUrl = "redirect:/"+root+"/main/index.do";

		return returnUrl;
	}

	/** ########### 짧은 URL 접속 메인 ########### */
	@RequestMapping(value = "/s/{shortUrl}", method = RequestMethod.GET)
	public String shortUrlMain(@PathVariable String shortUrl, ModelMap model, HttpServletRequest request, HttpSession session, HttpServletResponse response ) throws IOException, SQLException, RuntimeException {

		int[] indexArr = CommUtil.getMenuIndex(shortUrl);

		MngrMenuVO mngrMenuVO = new MngrMenuVO();
		mngrMenuVO.setSchId(""+indexArr[0]);
		mngrMenuVO = mngrMenuService.getMngrMenuView(mngrMenuVO);

		if (CommUtil.empty(mngrMenuVO)) {
			return CommUtil.doComplete(model, "오류", "해당 페이지가 삭제되었거나 잘못된 주소입니다.", "history.back();");
		}

		String returnUrl = "redirect:/"+mngrMenuVO.getSiteCode()+"/contents/"+mngrMenuVO.getMenuCode()+".do";

		if(indexArr.length == 2){
			if("3".equals(mngrMenuVO.getMenuType()))	returnUrl+="?uid=view_"+indexArr[1];//게시판접속을 위한 파라메터 정보 추가
			//if("3".equals(mngrMenuVO.getMenuType()))	returnUrl+="?schM=view&id="+indexArr[1];//관리자페이지 임시적용
		}

		return returnUrl;
	}

	/*@RequestMapping(value = "/{root}/main/index.do")
	public void mainIndexCrawl(@PathVariable String root, ModelMap model, HttpServletRequest request, HttpSession session, HttpServletResponse response ) throws IOException, SQLException, RuntimeException, ParseException {
		response.sendRedirect("/mainIndexCrawl.jsp");
	}
	*/
	@RequestMapping(value = "/{root}/main/index.do")
	public String mainIndex(@PathVariable String root, ModelMap model, HttpServletRequest request, HttpSession session, HttpServletResponse response ) throws IOException, SQLException, RuntimeException, ParseException {

		MngrStatsVO mngrStatsVO = new MngrStatsVO();
		MngrCountVO mngrCountVO = new MngrCountVO();

		if(!CommUtil.isExistSite(root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(root);
/*
		String[] mainPageBoardDescs = siteconfigVO.getRecentBoardByTempCode(siteconfigVO.getTempCode());

		//메인페이지 게시판 가져오기
		List<MainBoardVO> mainPageBoard = new ArrayList<>();
		String[] tmp;
		MainBoardVO board;
		if (mainPageBoardDescs!= null && mainPageBoardDescs.length != 0) {
			for (String desc : mainPageBoardDescs) {
				board = new MainBoardVO();
				tmp = desc.split("/");
				board = boardService.latestBbsMenuSchBcid(tmp[0], root);
				if (board != null) {
					board.setTempCode(siteconfigVO.getTempCode());
					board.setBoardList(cc);
					board.setAnchorHref("/".concat(root).concat("/").concat("contents").concat("/").concat(board.getAnchorHref()).concat(".do"));

					mainPageBoard.add(board);
				}

			}
		}

		model.addAttribute("mainPageBoard", mainPageBoard);
*/
		//section0 슬라이드셋
		ItgMap paramVO = new ItgMap();
		paramVO.put("slidesIdx", CommUtil.isNull(siteconfigVO.getSlidesIdx(),"0"));
		paramVO.put("useyn", "Y");
		List<ItgMap> slidesItemList = mngrSlidesService.mngrSlideItemList(paramVO);
		model.addAttribute("slidesItemList", slidesItemList);


		BoardSearchVO boardSearchVO = new BoardSearchVO();

		//사업공고	공지사항 입찰공고
		//Business1 notice11 notice12


//		사업공고 bsnsPblanc
//		공지사항 notice
//		입찰공고 opBidding
		if("SNIP".equals(root)){


			DefaultVO searchVO=new DefaultVO();
			searchVO.setFirstIndex(0);
			searchVO.setLastIndex(4);
			searchVO.setSchOpt5("ing");
			List boardList = gonggoReqService.selectGoggoList(searchVO);
			boardSearchVO.setFirstIndex(0);
			boardSearchVO.setLastIndex(1);
			boardSearchVO.setSchBcid("notice");
			boardList.addAll(boardService.selectBoardMainList(boardSearchVO));
			boardSearchVO.setFirstIndex(0);
			boardSearchVO.setLastIndex(1);
			boardSearchVO.setSchBcid("opBidding");
			boardList.addAll(boardService.selectBoardMainList(boardSearchVO));

			model.addAttribute("boardList", boardList);

			boardSearchVO.setFirstIndex(0);
			boardSearchVO.setLastIndex(6);
			boardSearchVO.setSchBcid("snipMarks");
			List newBoardList = boardService.selectBoardMainList(boardSearchVO);
			model.addAttribute("newBoardList", newBoardList);

			MngrPopupSearchVO mngrPopupSearchVO = new MngrPopupSearchVO();
			mngrPopupSearchVO.setSchPopupType("1"); //팝업존
			mngrPopupSearchVO.setFirstIndex(0);
			mngrPopupSearchVO.setLastIndex(8);
			mngrPopupSearchVO.setSchActive("Y");
			mngrPopupSearchVO.setOrdBy("asc");
			mngrPopupSearchVO.setOrdFld("popup_order");
			mngrPopupSearchVO.setSchSitecode(root); // 사이트코드 추가
			List popupzoneList = mngrPopupService.getMngrPopupList(mngrPopupSearchVO);

			model.addAttribute("popupzoneList", popupzoneList);


			// 사업안내

			TotalTbSearchVO totalSearchVO = new TotalTbSearchVO();
			totalSearchVO.setOrdFld("a.gp_name");
			totalSearchVO.setOrdBy("asc");
			totalSearchVO.setAct("totalTb"); //성장단계 필수
			totalSearchVO.setSchOpt1(CommUtil.getDatePattern("yyyy"));
			totalSearchVO.setSchOpt2("1"); //성장단계 1:창업 아이템 사업화  2:생존과 성장  3:혁신성장  4:도약*글로벌 진출
			List<TotalTbVO> totalTB_1 = totalTableService.selectTotalTbListAll(totalSearchVO);
			model.addAttribute("totalTB_1", totalTB_1);

			totalSearchVO = new TotalTbSearchVO();
			totalSearchVO.setOrdFld("a.gp_name");
			totalSearchVO.setOrdBy("asc");
			totalSearchVO.setAct("totalTb"); //성장단계 필수
			totalSearchVO.setSchOpt1(CommUtil.getDatePattern("yyyy"));
			totalSearchVO.setSchOpt2("2"); //성장단계 1:창업 아이템 사업화  2:생존과 성장  3:혁신성장  4:도약*글로벌 진출
			List<TotalTbVO> totalTB_2 = totalTableService.selectTotalTbListAll(totalSearchVO);
			model.addAttribute("totalTB_2", totalTB_2);

			totalSearchVO = new TotalTbSearchVO();
			totalSearchVO.setOrdFld("a.gp_name");
			totalSearchVO.setOrdBy("asc");
			totalSearchVO.setAct("totalTb"); //성장단계 필수
			totalSearchVO.setSchOpt1(CommUtil.getDatePattern("yyyy"));
			totalSearchVO.setSchOpt2("3"); //성장단계 1:창업 아이템 사업화  2:생존과 성장  3:혁신성장  4:도약*글로벌 진출
			List<TotalTbVO> totalTB_3 = totalTableService.selectTotalTbListAll(totalSearchVO);
			model.addAttribute("totalTB_3", totalTB_3);

			totalSearchVO = new TotalTbSearchVO();
			totalSearchVO.setOrdFld("a.gp_name");
			totalSearchVO.setOrdBy("asc");
			totalSearchVO.setAct("totalTb"); //성장단계 필수
			totalSearchVO.setSchOpt1(CommUtil.getDatePattern("yyyy"));
			totalSearchVO.setSchOpt2("4"); //성장단계 1:창업 아이템 사업화  2:생존과 성장  3:혁신성장  4:도약*글로벌 진출
			List<TotalTbVO> totalTB_4 = totalTableService.selectTotalTbListAll(totalSearchVO);
			model.addAttribute("totalTB_4", totalTB_4);

			MngrCodeVO mngrCodeVO = new MngrCodeVO();
			mngrCodeVO.setSchCode("section01");
			model.addAttribute("gpNameCodeList", mngrCodeService.getMngrCodeList(mngrCodeVO));

			//메인 네이버 블로그 rss 정보 가져오기
			NaverBlogRss naverBlogRss = new NaverBlogRss();
			model.addAttribute("naverBlog", naverBlogRss.getPosts());

			//메인 트위터 블로그 rss 정보 가져오기
			TwitterRss twitterRss = new TwitterRss();
			model.addAttribute("twitterRss", twitterRss.getPosts());

			//메인 유투브 블로그 rss 정보 가져오기
			/*YoutubePlayList youtubePlayList = new YoutubePlayList();
			model.addAttribute("youtubePlayList", youtubePlayList.getPosts());*/
		}

		// 영문 Startup
		if("eng".equals(root)){
	/*		boardSearchVO.setSchBcid("programsSnip1");
			List selectBsnsSuList = userMainService.selectBsnsList(boardSearchVO);
			model.addAttribute("bsnsBsnsSuList", selectBsnsSuList);

			boardSearchVO.setSchBcid("programsSnip6");
			List selectBsnsCeList = userMainService.selectBsnsList(boardSearchVO);
			model.addAttribute("bsnsBsnsCeList", selectBsnsCeList);*/

			String[] bcIdArr = null;
			bcIdArr = new String[] { "engStartup", "engRd", "engTech",
									 "engInvest", "engScaleup", "engCooper"};

			if ( bcIdArr != null ){
				for (String bcId : bcIdArr) {
					MainBsnsVO bsnsVO = new MainBsnsVO();
					boardSearchVO.setSchBcid(bcId);
					bsnsVO.setBoardList(userMainService.selectBsnsList(boardSearchVO));

					model.addAttribute(bcId, bsnsVO);
				}
			}
		}

/*
		// 팝업존, 팝업창, 배너 /WEB-INF/config/cms/config_popup.xml 파일에 팝업존, 팝업창, 배너 구분 설정 확인 1.팝업존, 2.팝업창, 3.배너

		mngrPopupSearchVO.setSchPopupType("2"); //팝업창
		List popupWinList = mngrPopupService.getMngrPopupList(mngrPopupSearchVO);

		mngrPopupSearchVO.setSchPopupType("3"); //배너
		//mngrPopupSearchVO.setFirstIndex(0);
		//mngrPopupSearchVO.setLastIndex(1000);
		List popupBannerList = mngrPopupService.getMngrPopupList(mngrPopupSearchVO);

		model.addAttribute("popupWinList", popupWinList);
		model.addAttribute("popupBannerList", popupBannerList);
*/
		/**S : 카운트처리**/
		//접속자 정보 조회
		mngrStatsVO = CommUtil.getLogInfo(request,CommUtil.isUserLogin(), root);

		if(mngrStatsVO != null){

	    	//쿠키 꺼내옴
			Cookie[] cookies = request.getCookies() ;
			String MAIN_CNT_UP = "";
			if(cookies != null){
		        for(int i=0; i < cookies.length; i++){
			        Cookie c = cookies[i] ;
			        if(("MAIN_CNT_UP_"+root).equals(c.getName())) {
			        	MAIN_CNT_UP = c.getValue();
			        }
			    }
			}

	    	//쿠키에서 카운트 증가 처리가 되었는지 여부 체크
	    	if("".equals(MAIN_CNT_UP)) {
	    		//존재하지 않으면 쿠키에 메인카운트 플래그 저장
	    		logger.debug("************ 메인 카운트 증가처리 ************");
	    	    Cookie c = new Cookie("MAIN_CNT_UP_"+root, "Y") ; // 메인카운트 플래그 추가
	    	    c.setComment(URLEncoder.encode("메인카운트증가플래그", "UTF-8")) ; // 쿠키에 설명을 추가한다
	    	    c.setMaxAge(60*30) ;//30분. 쿠키 유효기간을 설정한다. 초단위
	    	    response.addCookie(c) ;// 응답헤더에 쿠키를 추가한다.


				//로그 데이터 저장
				int result = mngrStatsService.mngrStatsInsert(mngrStatsVO);

				/*S: 날짜별 카운트 처리 */
				SimpleDateFormat dfh = new SimpleDateFormat("yyyy-MM-dd-HH");
				Calendar cal = Calendar.getInstance();
				cal.add(cal.HOUR_OF_DAY, +1);
				String today = dfh.format(cal.getTime());
				String Date[] =today.split("-");
				String dateOption[] ={"HOUR","DAY","MONTH","YEAR"};
				int upcnt = 0;
				mngrCountVO.setSiteCode(root);

				for(int i=0;i<4;i++){
					logger.debug("************ 기준날짜 : "+Date[0]+"-"+Date[1]+"-"+Date[2]+"-"+Date[3]);

					mngrCountVO.setCntOption(dateOption[i]);
					mngrCountVO.setCntYear(Date[0]);
					mngrCountVO.setCntMonth(Date[1]);
					mngrCountVO.setCntDay(Date[2]);
					mngrCountVO.setCntHour(Date[3]);
					upcnt = mngrStatsService.mngrDateCountUpdate(mngrCountVO);
					logger.debug("************ DATE_COUNT 결과 upcnt : "+upcnt);
					if(upcnt==0){
						mngrCountVO.setEtc(Date[0]+"-"+Date[1]+"-"+Date[2]+" "+Date[3]);
						mngrStatsService.mngrDateCountInsert(mngrCountVO);
					}
					Date[3-i]="00";
				}
				/*E: 날짜별 카운트 처리 */

				/*S: 옵션별 카운트 처리 */
				mngrCountVO = new MngrCountVO();//초기화

				Date = today.split("-");

				mngrCountVO.setCntYear(Date[0]);
				mngrCountVO.setCntMonth(Date[1]);
				mngrCountVO.setCntDay(Date[2]);
				mngrCountVO.setCntHour(Date[3]);
				mngrCountVO.setSiteCode(root);

				upcnt = 0;//초기화
				String optOption[] ={"DEVICE","OS","BROWSER","SEARCHENGINE","IP"};
				//장치정보 DEVICE
				mngrCountVO.setCntOption(optOption[0]);
				mngrCountVO.setCntName(CommUtil.isNull(mngrStatsVO.getClDeviceKind(), ""));
				if(!"".equals(mngrCountVO.getCntName())){
					//logger.debug("************ DEVICE mngrCountVO.getCntName() : "+mngrCountVO.getCntName());
					upcnt = mngrStatsService.mngrOptionCountUpdate(mngrCountVO);
					logger.debug("************ DEVICE 결과 upcnt : "+upcnt);
					if(upcnt==0){
						mngrStatsService.mngrOptionCountInsert(mngrCountVO);
					}
				}

				//운영체제 OS
				mngrCountVO.setCntOption(optOption[1]);
				mngrCountVO.setCntName(CommUtil.isNull(mngrStatsVO.getClOs(), ""));
				if(!"".equals(mngrCountVO.getCntName())){
					//logger.debug("************ OS mngrCountVO.getCntName() : "+mngrCountVO.getCntName());
					upcnt = mngrStatsService.mngrOptionCountUpdate(mngrCountVO);
					logger.debug("************ OS 결과 upcnt : "+upcnt);
					if(upcnt==0){
						mngrStatsService.mngrOptionCountInsert(mngrCountVO);
					}
				}

				//접속브라우저 BROWSER
				mngrCountVO.setCntOption(optOption[2]);
				mngrCountVO.setCntName(CommUtil.isNull(mngrStatsVO.getClBrowser(), ""));
				if(!"".equals(mngrCountVO.getCntName())){
					//logger.debug("************ BROWSER mngrCountVO.getCntName() : "+mngrCountVO.getCntName());
					upcnt = mngrStatsService.mngrOptionCountUpdate(mngrCountVO);
					logger.debug("************ BROWSER 결과 upcnt : "+upcnt);
					if(upcnt==0){
						mngrStatsService.mngrOptionCountInsert(mngrCountVO);
					}
				}

				//유입경로 검색엔진 SEARCHENGINE
				mngrCountVO.setCntOption(optOption[3]);
				mngrCountVO.setCntName(CommUtil.isNull(mngrStatsVO.getClSearchEngine(), ""));
				if(!"".equals(mngrCountVO.getCntName())){
					//logger.debug("************ SEARCHENGINE mngrCountVO.getCntName() : "+mngrCountVO.getCntName());
					upcnt = mngrStatsService.mngrOptionCountUpdate(mngrCountVO);
					logger.debug("************ SEARCHENGINE 결과 upcnt : "+upcnt);
					if(upcnt==0){
						mngrStatsService.mngrOptionCountInsert(mngrCountVO);
					}
				}

				//아이피V4 IP
				mngrCountVO.setCntOption(optOption[4]);
				mngrCountVO.setCntName(CommUtil.isNull(mngrStatsVO.getClIp(), ""));
				if(!"".equals(mngrCountVO.getCntName())){
					//logger.debug("************ DEVICE mngrCountVO.getCntName() : "+mngrCountVO.getCntName());
					upcnt = mngrStatsService.mngrOptionCountUpdate(mngrCountVO);
					logger.debug("************ IP 결과 upcnt : "+upcnt);
					if(upcnt==0){
						mngrStatsService.mngrOptionCountInsert(mngrCountVO);
					}
				}
				/*E: 옵션별 카운트 처리 */

	    	}else{
	    		logger.debug("************ 메인 카운트 증가 쿠키 존재함 ************");
	    	}
		}
		/** E : 카운트처리**/

		model.addAttribute("isMobile", CommUtil.isMobile(request));
		model.addAttribute("siteCode", root);
		model.addAttribute("siteconfigVO", siteconfigVO);
		model.addAttribute("snsconfigVO", CommUtil.getSiteconfigVO(root,"snsconfig"));

		return "itgcms/user/template/"+siteconfigVO.getTempCode()+"/main";
	}


	@RequestMapping(value = "/{root}/popContents.do")
	public String userPopContents(@PathVariable String root, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, SQLException, RuntimeException {

		if(!CommUtil.isExistSite(root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "self.close();");
		String url = CommUtil.isNull(request.getParameter("url"), "");
		String opt1 = CommUtil.isNull(request.getParameter("opt1"), "");
		String opt2 = CommUtil.isNull(request.getParameter("opt2"), "");
		String opt3 = CommUtil.isNull(request.getParameter("opt3"), "");
		String opt4 = CommUtil.isNull(request.getParameter("opt4"), "");
		String title = CommUtil.isNull(request.getParameter("title"), opt2);
		if(CommUtil.empty(url)) return CommUtil.doComplete(model, "오류", "URL 정보가 없습니다", "self.close();");


		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(root);

		String currentUrl = request.getRequestURL().toString();
		String encodeopt = new String(opt2.getBytes("iso-8859-1"),"UTF-8");
		opt2=encodeopt;
		model.addAttribute("isMobile", CommUtil.isMobile(request));
		model.addAttribute("siteCode", root);
		model.addAttribute("currentUrl", currentUrl);
		model.addAttribute("contentsUrl", url);
		model.addAttribute("title", title);
		model.addAttribute("opt1", opt1);
		model.addAttribute("opt2", opt2);
		model.addAttribute("opt3", opt3);
		model.addAttribute("opt4", opt4);
		model.addAttribute("siteconfigVO", siteconfigVO);
		if(opt4.equals("mngr")) {
			return "itgcms/mngr/menu/popWin";
		}else {
			return "itgcms/user/template/"+ siteconfigVO.getTempCode()+"/popWin";
		}
	}

	@RequestMapping(value = "/{root}/contents/{code}.do")
	public String userMain(@PathVariable String root, @PathVariable String code, ModelMap model,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, SQLException, RuntimeException {

		if(!CommUtil.isExistSite(root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

/*		String noticeId = request.getParameter("notice");
		if (noticeId != null && !"".equals(noticeId)) {
			Map<String, String> resultMap = boardService.redirectNoticePage(noticeId, root);
			if(resultMap == null) {
				resultMap = boardService.redirectNoticePage(noticeId, null);
			}
			return "redirect:/"+root+"/contents/"+noticeId+".do?schM=view&id="+CommUtil.isNull(request.getParameter("id"), "");
		}*/
		/*S: 카운트 처리 */

    	//쿠키 꺼내옴
		Cookie[] cookies = request.getCookies();
		String MENU_NAME = code+"_CNT_UP";
		String MENU_NAME_VAL = "";
		if(cookies != null){
	        for(int i=0; i < cookies.length; i++){
		        Cookie c = cookies[i] ;
		        if(MENU_NAME.equals(c.getName())) {
		        	MENU_NAME_VAL = c.getValue();
		        }
		    }
		}
		//쿠키에서 카운트 증가 처리가 되었는지 여부 체크
    	if("".equals(MENU_NAME_VAL)) {
    		//존재하지 않으면 쿠키에 메인카운트 플래그 저장
    		logger.debug("************ 메뉴별 카운트 증가처리 ************");
    	    Cookie c = new Cookie(MENU_NAME, "Y") ; // 메인카운트 플래그 추가
    	    c.setComment(URLEncoder.encode("메뉴별카운트증가플래그", "UTF-8")) ; // 쿠키에 설명을 추가한다
    	    c.setMaxAge(60*30) ;//30분. 쿠키 유효기간을 설정한다. 초단위
    	    response.addCookie(c) ;// 응답헤더에 쿠키를 추가한다.
    	    MENU_NAME_VAL = c.getValue();

    		/*S: 메뉴별 카운트 처리 */
    		MngrCountVO mngrCountVO = new MngrCountVO();
    		SimpleDateFormat dfh         = new SimpleDateFormat("yyyy-MM-dd");
    		Calendar cal = Calendar.getInstance();
    		cal.add(cal.HOUR_OF_DAY, +1);
    		String today = dfh.format(cal.getTime());
    		String Date[] =today.split("-");
    		String dateOption[] ={"TOTAL","YEAR","MONTH","DAY"};
    		int upcnt = 0;

    		mngrCountVO.setCntName(code);
    		mngrCountVO.setSiteCode(root);
    		for(int i=0;i<4;i++){

    			mngrCountVO.setCntOption(dateOption[i]);
    			switch (i){
    				case 1:	mngrCountVO.setCntYear(Date[0]);break;
    				case 2:mngrCountVO.setCntMonth(Date[1]);break;
    				case 3:mngrCountVO.setCntDay(Date[2]);break;
    			}
    			upcnt = mngrStatsService.mngrMenuCountUpdate(mngrCountVO);
    			logger.debug("************ MENU_COUNT 결과 upcnt : "+upcnt+", value : "+code+"-"+Date[0]+"-"+Date[1]+"-"+Date[2]);
    			if(upcnt==0){
    				mngrCountVO.setEtc(code+"-"+Date[0]+"-"+Date[1]+"-"+Date[2]);
    				mngrStatsService.mngrMenuCountInsert(mngrCountVO);
    			}
    		}
    		/*E: 메뉴별 카운트 처리 */
    	}else{
    		logger.debug("************ 메뉴별 카운트 중복 ************");
    	}

    	/*E: 카운트 처리 */


		MngrMenuVO paramMenuVO = new MngrMenuVO();
		paramMenuVO.setId(code);

		MngrMenuVO menuVO = mngrMenuService.selectMngrMenuView(paramMenuVO);

		/*
		 * 고정된 프로그램을 메뉴 등록 없이 사용 할 경우.
		*/
		if(menuVO == null){
			menuVO = new MngrMenuVO();
			menuVO.setId(code); //코드저장
			if("memberRegist".equals(code)){//회원가입
				menuVO.setMenuUrl("/"+root+"/member/memberRegist.do");
				menuVO.setMenuType("99"); //메뉴
				menuVO.setMenuName("회원가입");
				menuVO.setMenuPfullname(">홈페이지>회원관리>회원가입");
				menuVO.setMenuPfullcode(">"+root+">member>memberRegist");
				menuVO.setMenuChargeuseyn("N");
				menuVO.setMenuResearchuseyn("N");
				menuVO.setMenuQruseyn("N");
				String stp = CommUtil.isNull(request.getParameter("stp"), "Step01");
				if("Step01".equals(stp)){

				} else if("Step02".equals(stp)){
				} else if("Step03".equals(stp)){
				} else if("complete".equals(stp)){

				}
			}
		}else{
			if (menuVO.getMngrManagerVO()==null) {
			}else{
				if (menuVO.getMngrManagerVO().getMngEmail()!=null) {
					menuVO.getMngrManagerVO().setMngEmail(CommUtil.seedDec256(menuVO.getMngrManagerVO().getMngEmail()));
				}
			}
		}

		if(menuVO.getMenuDepth().equals("5")){
			paramMenuVO.setId(menuVO.getMenuPcode());
			List<MngrMenuVO> tabMenuList = mngrMenuService.mngrMenuSubList(paramMenuVO);
			model.addAttribute("tabMenuList", tabMenuList);
		}


		if ("1".equals(menuVO.getMenuType())) {
			menuVO.setId(code);
			MngrMenuVO tmp = mngrMenuService.mngrMenuContentsView(menuVO);
			if (tmp == null) {
				menuVO.setMenuContents("");
			} else {
				menuVO.setMenuContents( mngrMenuService.mngrMenuContentsView(menuVO).getMenuContents());
			}

		}


		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(root);

		// 팝업존, 팝업창, 배너 /WEB-INF/config/cms/config_popup.xml 파일에 팝업존, 팝업창, 배너 구분 설정 확인 1.팝업존, 2.팝업창, 3.배너
		MngrPopupSearchVO mngrPopupSearchVO = new MngrPopupSearchVO();
		mngrPopupSearchVO.setSchPopupType("3"); //배너
		mngrPopupSearchVO.setFirstIndex(0);
		mngrPopupSearchVO.setLastIndex(1000);
		mngrPopupSearchVO.setSchActive("Y");
		mngrPopupSearchVO.setOrdBy("asc");
		mngrPopupSearchVO.setOrdFld("popup_order");
		mngrPopupSearchVO.setSchSitecode(root); // 사이트코드 추가

		List popupBannerList = mngrPopupService.selectMngrPopupList(mngrPopupSearchVO);

		String currentUrl = request.getRequestURL().toString();

		if("3".equals(menuVO.getMenuType())){
			String tempSchM = CommUtil.isNull(request.getParameter("schM"), "");
			if("view".equals(tempSchM)){
				String tempId = CommUtil.isNull(request.getParameter("id"), "");
				currentUrl+="?uid="+tempSchM+"_"+tempId;
			}
		}

		model.addAttribute("isMobile", CommUtil.isMobile(request));
		model.addAttribute("popupBannerList", popupBannerList);
		model.addAttribute("siteCode", root);
		model.addAttribute("currentUrl", currentUrl);
		model.addAttribute("menuVO", menuVO);
		model.addAttribute("code", code);
		model.addAttribute("siteconfigVO", siteconfigVO);
		model.addAttribute("snsconfigVO", CommUtil.getSiteconfigVO(root,"snsconfig"));

		/*소셜미디어 키 리스트*/
		ItgMap paramMap = new ItgMap();
		paramMap.put("siteCode", root);
		List<ItgMap> list = socialmediaService.selectSocialMediaKeys(paramMap);
		if (list != null) {
			for (ItgMap vo : list){
				model.addAttribute((String)vo.get("smName"), vo);
			}
		}

		return "itgcms/user/template/"+ siteconfigVO.getTempCode()+"/sub";
	}

	@RequestMapping(value = "/{root}/contents/rss/{code}.do", method=RequestMethod.GET)
	public String returnRSSFile(@PathVariable String root, @PathVariable String code, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, SQLException, RuntimeException {

		if(!CommUtil.isExistSite(root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		MngrBoardconfigVO bc = boardService.getBoardconfigViewByMenuCode(code);

		if ("N".equals(bc.getBcRSS())) {
			return CommUtil.doComplete(model, "오류", "해당 게시판은 RSS를 제공하지 않습니다.", "history.back();");
		}

		String urlPreFix = request.getRequestURL().toString();

		urlPreFix = urlPreFix.substring(0, urlPreFix.indexOf(root)).concat(root).concat("/contents/").concat(code).concat(".do");


		MngrMenuVO menuInfo = new MngrMenuVO();
		menuInfo.setId(code);
		menuInfo = mngrMenuService.selectMngrMenuView(menuInfo);



		model.addAttribute("boardTitle", menuInfo.getMenuName());
		model.addAttribute("pullName", menuInfo.getMenuPfullname());

		model.addAttribute("urlPreFix", urlPreFix);
		model.addAttribute("feedList", boardService.getBoardList(root, code));

		return "boardRssBuilder";
	}

	/*
	 * cron : CronTab에서의 설정과 같이 cron="0/10 * * * * ?" 과 같은 설정
	 * cron="0 0 6 * * ?" // 매일 6시에 실시
	 * cron="0 0,30 * * * ?" // 매시 정각, 30분에 실시
	 *
	 *
	 * fixedDelay : 이전에 실행된 Task의 종료시간으로 부터 정의된 시간만큼 지난 후 Task를 실행한다.(밀리세컨드 단위)
	 * fixedRate : 이전에 실행된 Task의 시작시간으로 부터 정의된 시간만큼 지난 후 Task를 실행한다.(밀리세컨드 단위)
	 * */
/*	@Scheduled(cron="0 0 0 * * ?")
	public void updateDormantAccount() throws Exception {
		 TODO

	}*/
	/*
	 * 사용자:비회원 100
	 * 사용자:회원 200
	 * 사용자:작성자 210
	 * 사용자:권한없음 900
	 *
	 */
	public List getUserAuthList(){
		HashMap hm = new HashMap();
		List<HashMap> authList = new java.util.ArrayList();
		hm = new HashMap();
		hm.put("name", "사용자:비회원");
		hm.put("code", "100");
		authList.add(0, hm);

		hm = new HashMap();
		hm.put("name", "사용자:회원");
		hm.put("code", "200");
		authList.add(1, hm);

		hm = new HashMap();
		hm.put("name", "사용자:작성자");
		hm.put("code", "210");
		authList.add(2, hm);

		hm = new HashMap();
		hm.put("name", "권한없음");
		hm.put("code", "900");
		authList.add(3, hm);

		return authList;
	}

	@RequestMapping(value = "/{root}/main/section2.ajax")
	public String userMainSection2(@PathVariable String root, ModelMap model) throws IOException, SQLException, RuntimeException {

		return "itgcms/user/main/mainSection2";
	}
	@RequestMapping(value = "/{root}/main/section3.ajax")
	public String userMainSection3(@PathVariable String root, ModelMap model) throws IOException, SQLException, RuntimeException {

		return "itgcms/user/main/mainSection3";
	}
	@RequestMapping(value = "/{root}/main/section4.ajax")
	public String userMainSection4(@PathVariable String root, ModelMap model) throws IOException, SQLException, RuntimeException {

		return "itgcms/user/main/mainSection4";
	}
	@RequestMapping(value = "/{root}/main/section5.ajax")
	public String userMainSection5(@PathVariable String root, ModelMap model) throws IOException, SQLException, RuntimeException {

		return "itgcms/user/main/mainSection5";
	}
}
