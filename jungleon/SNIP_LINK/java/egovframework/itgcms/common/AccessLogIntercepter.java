/**
  * @Class Name : AccessLoginIntercepter.java
  * @Description : 권한, 접근제한, 로그등록 을 위한 controller 인터셉터
  *   수정일           수정자                   수정내용
  *  -------------------------------------------------------------
  *  2013. 6. 4.       woonee             최초 생성
  *
  */
package egovframework.itgcms.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.main.service.MngrMainService;
import egovframework.itgcms.core.main.service.MngrManagerMenuVO;
import egovframework.itgcms.core.managerlog.service.MngrManagerLogService;
import egovframework.itgcms.core.managerlog.service.MngrManagerLogVO;
import egovframework.itgcms.core.menu.service.MngrMenuService;
import egovframework.itgcms.core.menu.service.MngrMenuVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.module.menuAuth.service.MenuAuthService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class AccessLogIntercepter extends HandlerInterceptorAdapter {

	public Logger LOGGER = Logger.getLogger(this.getClass());

	/** MngrMenuService */
	@Resource(name = "mngrMenuService")
	private MngrMenuService mngrMenuService;

	/** MngrMainService */
	@Resource(name = "mngrMainService")
	private MngrMainService mngrMainService;

    /** MenuAuthService */
	@Resource(name = "menuAuthService")
	private MenuAuthService menuAuthService;

	/** mngrManagerLogService */
	@Resource(name = "mngrManagerLogService")
	private MngrManagerLogService mngrManagerLogService;

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	@SuppressWarnings("unused")
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		LOGGER.info("interceptor start !!");

		//스프링 기본 옵션에 의해 광범위 Exception 강제 적용 필수
		String requestURI = CommUtil.isNull(request.getRequestURI(), "");

		if(requestURI.startsWith(request.getContextPath() + "/_mngr_/")){
			String[] arrUrl = requestURI.split("\\.")[0].split("/");
			// 로그인 시 에는 통과하도록
			if (arrUrl[arrUrl.length - 1].substring(0,5).equals("login")) {
				return true;
			}else if(arrUrl[arrUrl.length - 1].startsWith("logout")) {
				return true;
			}

			HttpSession tmpSession = request.getSession();
			MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();

			if(mngrSessionVO == null){
				ModelAndView modelAndView = new ModelAndView("/comm/message/message");
				HashMap<String, String> message = new HashMap<String, String>();
				message.put("title","오류");
				message.put("msg","로그인 후 이용 가능합니다.");
				message.put("script","location.href='"+request.getContextPath()+"/_mngr_/main/login.do'");
				modelAndView.addObject("message", message);
				throw new ModelAndViewDefiningException(modelAndView);
			}

			/**
			 * 	URL 구칙에 따라 권한을 체크한다.
			 * 1. common 으로 시작하는 것은 체크하지 않는다.
			 * 2. 프로세스 중 comm 이 들어가면 체크하지 않는다.
			 * 3. 1,2를 제외한 모든 URL은 권한체크를 한다.
			 *     리스트:list, 등록:input, 수정:edit, 상세:view, 답글:reply, 다운로드:down, 업로드:upload, 출력:print
			 *     슈퍼(총괄)관리자는 권한체크를 하지 않는다.
			 */
			if(!"99".equals(mngrSessionVO.getMngAuth())){ //슈퍼관리자 체크

				String chkUrlStr = arrUrl[arrUrl.length - 1];
				String[] chkUrl = chkUrlStr.split("_");

				String jobSort = chkUrl[0];
				String authChkUrl = "/";
				for(int i=1; i < arrUrl.length-1; i++) {
					authChkUrl += arrUrl[i] + "/";
				}
				authChkUrl += jobSort;

				List<MngrManagerMenuVO> mngSiteMenuList = mngrSessionVO.getMngSysMenuList();


				if (arrUrl[1].equals("common") || arrUrl[1].equals("jfile")) {
					return true;
				}else if (chkUrl[0].equals("index")) {
					return true;
				}else if (chkUrl.length > 1 && chkUrl[1].equals("comm")) {
					return true;
				}else if(CommUtil.notEmpty(mngSiteMenuList)) {
					boolean sysMenuCheck = sysMenuCheck(mngSiteMenuList, chkUrlStr);

					if(sysMenuCheck) return sysMenuCheck;
				}else { // 메뉴권한을 가져와서 해당 권한이 있는지 체크한다.

					boolean auth = false;

					HashMap<String,Object> commandMap = new HashMap<String,Object>();
					commandMap.put("mng_id", CommUtil.getMngrMemId());
					commandMap.put("authChkUrl", authChkUrl);

					// 해당 메뉴 권한 가져오기 구현 중.....
					EgovMap authInfo = mngrSessionVO.getMngMenuAuth(chkUrl[0]);


					if(authInfo != null) {
						String authAct = chkUrl[1];

						if("list".equals(authAct) && "Y".equals(authInfo.get("authR"))) {
							auth = true;
						}
						else if("input".equals(authAct) && "Y".equals(authInfo.get("authC"))) {
							auth = true;
						}
						else if("edit".equals(authAct) && "Y".equals(authInfo.get("authU"))) {
							auth = true;
						}
						else if("view".equals(authAct) && "Y".equals(authInfo.get("authR"))) {
							auth = true;
						}
						else if("reply".equals(authAct) && "Y".equals(authInfo.get("authC"))) {
							auth = true;
						}
						else if("down".equals(authAct) && "Y".equals(authInfo.get("authR"))) {
							auth = true;
						}
						else if("upload".equals(authAct) && "Y".equals(authInfo.get("authU"))) {
							auth = true;
						}
						else if("print".equals(authAct) && "Y".equals(authInfo.get("authR"))) {
							auth = true;
						}
						else if("proc".equals(authAct)) {
							String mode = request.getParameter("mode") == null ? "" : request.getParameter("mode");
							LOGGER.info(mode);
							if (mode.equals("insert")) {
								if ("Y".equals(authInfo.get("authC")))
									auth = true;
							} else if (mode.equals("update")) {
								if ("Y".equals(authInfo.get("authU")))
									auth = true;
							} else if (mode.equals("delete")) {
								if ("Y".equals(authInfo.get("authD")))
									auth = true;
							} else if (mode.equals("reply")) {
								if ("Y".equals(authInfo.get("authC")))
									auth = true;
							}
						}
					}

					LOGGER.info(auth);

					if (!auth) {
						LOGGER.info("해당 메뉴에 대한 권한이 없습니다.");

						PrintWriter writer=response.getWriter();
						response.setCharacterEncoding("UTF-8");
						response.setContentType("text/html; charset=UTF-8");
						if(requestURI.contains("ajax")) {
							writer.println("401");
						}else if(!requestURI.contains("popup")) {
							writer.println("<script type='text/javascript'>alert('해당 권한이 없습니다.'); history.go(-1);</script>");
						}else {
							writer.println("<script type='text/javascript'>self.close();</script>");
						}
						writer.flush();
						writer.close();

						return false;
					}
				}
			}
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView mv) throws Exception
	{
		/**
		 * 레이아웃 구성을 위해 권한에 해당되는 메뉴목록을 가져온다.
		 */

		// 요청 URL
		String url = request.getRequestURI();
		// 관리자 메뉴 목록을 가져와서 뷰에 던져준다.
		if(url.startsWith(request.getContextPath() + "/_mngr_/")) {
			String[] arrUrl = url.split("\\.")[0].split("/");
			// 로그인 시 에는 통과하도록
			if (!arrUrl[arrUrl.length - 1].equals("login") && !arrUrl[arrUrl.length - 1].equals("logout")) {
				if (!url.contains("Proc") && !url.contains("proc") && /*!url.contains("popup") && */!url.contains("ajax")) {

					HttpSession session = request.getSession();
					MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
					String currSiteCode = mngrSessionVO.getCurrSiteCode();

					/* 페이지가 바뀔때마다 사이트리스트를 불러옴 */
					List<MngrSiteVO> siteList = mngrSiteService.selectMngrSiteList();
					if("99".equals(mngrSessionVO.getMngAuth())){
						mngrSessionVO.setMngSiteList(siteList); //전체 사이트 리스트(최고관리자)
					}else{
						List<MngrSiteVO> siteMapList = new ArrayList<MngrSiteVO>();
						for (int i = 0; i < siteList.size(); i++) {
							if(CommUtil.strInArrChk(mngrSessionVO.getSiteCode(), siteList.get(i).getSiteCode())){
								siteMapList.add(siteList.get(i));
							}
						}
						mngrSessionVO.setMngSiteList(siteMapList); //본인 권한 사이트 리스트
					}

					// 메뉴리스트 생성 (메뉴리스트값이 없거나 사이트가 변경되었을때)
					if((CommUtil.empty(mngrSessionVO.getMngSysMenuList()) && CommUtil.empty(mngrSessionVO.getMngMenuList())) || mngrSessionVO.getSiteChangeYn().equals("Y")) {

						// 현재 사이트코드가 없을때 사이트리스트의 첫번째 사이트코드로 지정
						if(currSiteCode.equals("")) {
							List<MngrSiteVO> mngSiteList = mngrSessionVO.getMngSiteList();
							mngrSessionVO.setCurrSiteCode(mngSiteList.get(0).getSiteCode());
							mngrSessionVO.setCurrSiteName(mngSiteList.get(0).getSiteName());
							currSiteCode = mngSiteList.get(0).getSiteCode();
						}

						if(currSiteCode.equals("SYSTEM")) { //시스템메뉴 생성
							MngrManagerMenuVO mngrManagerMenuVO = new MngrManagerMenuVO();
							mngrManagerMenuVO.setSchStr(mngrSessionVO.getMngAuth());
							mngrManagerMenuVO.setSchLicenseType(mngrSessionVO.getLicenseType());
							mngrManagerMenuVO.setId("sysmenu");
							mngrManagerMenuVO.setMinDepth("3");
							List<MngrManagerMenuVO> mngSysMenuList = mngrMainService.mngrManagerMenuListRecursive(mngrManagerMenuVO);
							mngrSessionVO.setMngSysMenuList(mngSysMenuList);
						}else { //사용자 메뉴 생성

							//권한리스트가져오기
							if(!"99".equals(mngrSessionVO.getMngAuth())){ //슈퍼관리자 체크
								ItgMap paramMap = new ItgMap();
								paramMap.put("schOpt1", "T");
								paramMap.put("schSiteCode", currSiteCode);
								paramMap.put("schMngId", mngrSessionVO.getId());
								List<?> authList = menuAuthService.getMenuAuthItemList(paramMap);
								if(authList.size() > 0) {

									String menuCodeStr = "";
									//권한리스트에서 메뉴코드만추출
									for(int i=0;i<authList.size();i++) {
										ItgMap tempMap =  (ItgMap)authList.get(i);
										if(i>0) menuCodeStr += ",";
										menuCodeStr += "'"+(String) tempMap.get("menuCode")+"'";
									}

									//권한리스트를 세션에 담기
									mngrSessionVO.setMngMenuAuthList((List<ItgMap>) authList);

									MngrMenuVO mngrMenuVO = new MngrMenuVO();
									mngrMenuVO.setId(currSiteCode);
									mngrMenuVO.setMinDepth("1");
									mngrMenuVO.setSchOpt1(menuCodeStr);
									List<MngrMenuVO> mngMenuList = mngrMenuService.mngrMenuListRecursive(mngrMenuVO);
									mngrSessionVO.setMngMenuList(mngMenuList);

								}else {
									mngrSessionVO.setMngMenuList(new ArrayList());
								}
							}else {
								MngrMenuVO mngrMenuVO = new MngrMenuVO();
								mngrMenuVO.setId(currSiteCode);
								mngrMenuVO.setMinDepth("1");
								List<MngrMenuVO> mngMenuList = mngrMenuService.mngrMenuListRecursive(mngrMenuVO);
								mngrSessionVO.setMngMenuList(mngMenuList);
							}

							//사이트관리메뉴
							MngrManagerMenuVO mngrManagerMenuVO = new MngrManagerMenuVO();
							mngrManagerMenuVO.setSchStr(mngrSessionVO.getMngAuth());
							mngrManagerMenuVO.setSchLicenseType(mngrSessionVO.getLicenseType());
							mngrManagerMenuVO.setId("sitemenu");
							mngrManagerMenuVO.setMinDepth("3");
							List<MngrManagerMenuVO> mngSiteMenuList = mngrMainService.mngrManagerMenuListRecursive(mngrManagerMenuVO);
							mngrSessionVO.setMngSysMenuList(mngSiteMenuList);

						}

						mngrSessionVO.setSiteChangeYn("");
					}

					mv.addObject("mngrSessionVO", mngrSessionVO);
					mv.addObject("systemconfigVO", CommUtil.getSystemconfigVO());

					String[] jobUrl = arrUrl[arrUrl.length-1].split("_");
					String jobSort = jobUrl[0];
					String chkUrl = "/";
					for(int i=1; i < arrUrl.length-1; i++) {
						chkUrl += arrUrl[i] + "/";
					}
					chkUrl += jobSort;

					if(currSiteCode.equals("SYSTEM")) {
						List<MngrManagerMenuVO> sysmenuList = mngrSessionVO.getMngSysMenuList();
						if(sysmenuList != null) sysMenuRecursive(sysmenuList, mv, chkUrl,"");
					}else {
						List<MngrMenuVO> menuList = mngrSessionVO.getMngMenuList();
						int result = menuRecursive(menuList, mv, chkUrl);

						if(result == 0) {
							List<MngrManagerMenuVO> sysmenuList = mngrSessionVO.getMngSysMenuList();
							sysMenuRecursive(sysmenuList, mv, chkUrl,"");
						}
					}


				}
				insertManagerLog(request,response,handler);
			}
		}
		LOGGER.info("interceptor complete !!");
	}


	public void sysMenuRecursive(List<MngrManagerMenuVO> menuList, ModelAndView mv, String chkUrl, String menuPfullcode) throws Exception{
		String menuUrl = "";
		//String tempcode = "";
		//if(CommUtil.notEmpty(menuPfullcode)) tempcode = menuPfullcode+">";
		for(MngrManagerMenuVO mvo :  menuList) {
			if(mv.getModel().get("urlInfo") != null) return;
			String tempcode = menuPfullcode+">"+mvo.getMenuCode().toUpperCase();
			if(mvo.getMngrManagerMenuList() == null || mvo.getMngrManagerMenuList().isEmpty()) {
				menuUrl = "/_mngr_/" + CommUtil.isNull(mvo.getMenuUrl(), "");
				if (menuUrl.contains(chkUrl)) { //현재 요청한 url과 비교하여 메뉴정보 저장(시스템메뉴)
					mvo.setMenuPfullcode(tempcode);
					mv.addObject("sysmenu", "1");
					mv.addObject("urlInfo", mvo);
					return;
				}
			}else {
				sysMenuRecursive(mvo.getMngrManagerMenuList(), mv, chkUrl,tempcode);
			}
		}

	}

	public int menuRecursive(List<MngrMenuVO> menuList, ModelAndView mv, String chkUrl) throws Exception{

		String menuUrl = "";
		for(MngrMenuVO mvo :  menuList) {
			if(mv.getModel().get("urlInfo") != null) return 0;
			if(mvo.getMngrMenuList() == null || mvo.getMngrMenuList().isEmpty()) {
				menuUrl = CommUtil.isNull(mvo.getMenuMngurl(), "");
				if (menuUrl.contains(chkUrl)) { //현재 요청한 url과 비교하여 메뉴정보 저장(사이트메뉴)
					mv.addObject("sysmenu", "0");
					mv.addObject("urlInfo", mvo);
					return 1;
				}
			}else {
				menuRecursive(mvo.getMngrMenuList(), mv, chkUrl);
			}
		}
		return 0;
	}


	private void insertManagerLog(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException, SQLException{

		/*
		 * 관리자 로그 기록이 필요한 컨트롤러 체크
		 * itgcms 패키지의 모든 web 컨트롤러
		 * 해당 AOP의 결과값을 제대로 리턴 받기 위해서는 해당 JoinPoint에 HttpServletResponse를 파라미터에 포함시켜야함.
		 * 로그기록을 위한 메소드 규칙
		 * 1. 기능에 따라 View, Edit, Insert, Delete가 포함되어야 함.
		 * 2. 처리로직은 "proc"이 포함되어야 함.
		 * 기본적으로 ServiceImpl에 대한 로그가 우선이며(별도처리 : MngrManagerLogAOP에서 처리됨),
		 * MngrManagerLogAOP와 별도로 컨트롤러 단에서 로그 기록이 필요한 경우에 한하여 이 메소드를 이용할 것.
		*/

		HandlerMethod handlermethod = (HandlerMethod)handler;

		String methodName = handlermethod.getMethod().getName();
		String className = handlermethod.getMethod().getDeclaringClass().getName();
		String logType = "";

		String regex = "(";
		regex += "MngrSystemconfigController";
		//컨트롤러추가 시 아래 형식으로 계속 추가하면 됨.
		//regex += "|MngrSystemconfigController";
		regex += ")";

		Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(className);

		if(matcher.find()){
		    if(methodName.contains("View")) logType = "R";
		    else if(methodName.contains("Edit")) logType = "U";
		    else if(methodName.contains("Insert")) logType = "C";
		    else if(methodName.contains("Delete")) logType = "D";

			String url = request.getRequestURL().toString();
			if(url != null && request.getQueryString() != null){
				url += "?" + request.getQueryString();
			}

			String referer = request.getHeader("REFERER");

			if(!(referer.contains("proc") && logType == "R")) {
				MngrManagerLogVO mngrManagerLogVO = new MngrManagerLogVO();
				mngrManagerLogVO.setMlogClass(className);
				mngrManagerLogVO.setMlogMethod(methodName);
				mngrManagerLogVO.setMlogType(logType);
				mngrManagerLogVO.setMngId(CommUtil.getMngrMemId());
				mngrManagerLogVO.setMngName(CommUtil.getMngrSessionVO().getName());
				mngrManagerLogVO.setMlogIp(CommUtil.getClientIP(request));
				mngrManagerLogVO.setMlogReferer(referer);
				mngrManagerLogVO.setMlogUrl(url);

				mngrManagerLogService.mngrManagerLogInsert(mngrManagerLogVO);
			}
		}
	}

	public boolean sysMenuCheck(List<MngrManagerMenuVO> menuList, String chkUrlStr) throws Exception{
		boolean returnflag = false;
		for(MngrManagerMenuVO tempVO : menuList) {
			String[] tempSysUrl = tempVO.getMenuUrl().split("\\.")[0].split("/");

			if(chkUrlStr.equals(tempSysUrl[tempSysUrl.length - 1])) returnflag = true;
			else if(tempVO.getMngrManagerMenuList() != null) returnflag = sysMenuCheck(tempVO.getMngrManagerMenuList(), chkUrlStr);

			if(returnflag) break;
		}

		return returnflag;
	}
}
