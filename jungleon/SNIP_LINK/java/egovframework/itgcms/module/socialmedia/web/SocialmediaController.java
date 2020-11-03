package egovframework.itgcms.module.socialmedia.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.site.service.MngrSiteSearchVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.module.socialmedia.service.SocialMediaKeyVO;
import egovframework.itgcms.module.socialmedia.service.SocialmediaService;
import egovframework.itgcms.module.socialmedia.util.Feed;
import egovframework.itgcms.module.socialmedia.util.FeedMessage;
import egovframework.itgcms.module.socialmedia.util.RSSFeedParser;
import egovframework.itgcms.util.CommUtil;



import java.math.BigInteger;
import java.security.SecureRandom;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMethod;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.RequestToken;


/**
 * @파일명 : SocialmediaController.java
 * @파일정보 : 파일정보수정 SocialmediaController
 * @수정이력
 * @수정자    수정일       수정내용
 * @------- ------------ ----------------
 * @bluej  2019.03.28 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 3.0.7 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class SocialmediaController {

	private final Logger LOGGER = Logger.getLogger(this.getClass());

	@Resource(name="socialmediaService")
	private SocialmediaService socialmediaService;

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	/**
	 * 쇼셜미디어 키 관리 - 시스템메뉴용
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping("/_mngr_/socialKey/socialKey_edit.do")
	public String socialMediaKeyList(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException{

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		paramMap.put("siteCode", siteCode);

		MngrSiteSearchVO mngrSiteSearchVO = new MngrSiteSearchVO();
		mngrSiteSearchVO.setId(siteCode);
		MngrSiteVO mngrSiteVO =  mngrSiteService.getSiteView(mngrSiteSearchVO);

		model.addAttribute("mngrSiteVO", mngrSiteVO);
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());
//		List<SocialMediaKeyVO> resultList = socialmediaService.selectMySocialMediaKeys(eMap);
//		model.addAttribute("resultList", resultList);

		SocialMediaKeyVO searchVO = new SocialMediaKeyVO();
		searchVO.setEtc1(siteCode); //사이트코드
		searchVO.setSchOpt3("facebook");
		ItgMap fbInfo = socialmediaService.getSocialProgramSetInfo(searchVO);
		model.addAttribute("fbInfo", fbInfo);

		searchVO.setSchOpt3("twitter");
		ItgMap twInfo = socialmediaService.getSocialProgramSetInfo(searchVO);
		model.addAttribute("twInfo", twInfo);

		searchVO.setSchOpt3("naver");
		ItgMap nbInfo = socialmediaService.getSocialProgramSetInfo(searchVO);
		model.addAttribute("nbInfo", nbInfo);

		searchVO.setSchOpt3("instagram");
		ItgMap inInfo = socialmediaService.getSocialProgramSetInfo(searchVO);
		model.addAttribute("inInfo", inInfo);

		return "itgcms/global/module/socialmedia/socialKey_edit";
	}

	/**
	 * 소셜미디어 키 관리 저장 - 시스템메뉴용
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/socialKey/socialKey_edit_proc.do")
	public String mngrsocialMediaRegistProc(ModelMap model,	HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		int result = socialmediaService.updateSocialmediaProc(model, paramMap);
		model.addAttribute("siteCode", paramMap.get("siteCode"));
    	String title = "";
    	String msg = "";
    	String script="";

		if(result > 0){
			title = "완료";	msg = "저장 되었습니다."; script="location.href='socialKey_edit.do?siteCode="+paramMap.get("siteCode")+"'";
		}else{
			title = "오류";msg = "저장이 완료되지 않았습니다."; script="location.href='socialKey_edit.do?siteCode="+paramMap.get("siteCode")+"'";
		}

		return CommUtil.doComplete(model,title , msg,script);
	}

	/**
	 * 소셜 ID 체크
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@ResponseBody
	@RequestMapping(value = "/_mngr_/socialKey/socialKey_comm_check.ajax", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	public int checkSmName(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		int result = socialmediaService.checkSmName(paramMap);
		return result;
	}

	/*
	@RequestMapping("/_mngr_/socialKey/registSocialKeys.do")
	public String socialMediaKeyProc(@ModelAttribute SocialMediaKeyVO socialMediaKey, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		String mngrId = CommUtil.getMngrMemId();

		for (Object name : socialMediaKey.SOCIAL_MEDIA_MAP.keySet()) {

			String useYn = request.getParameter(name+"_useyn");
			SocialMediaKeyVO temp = new SocialMediaKeyVO();
			temp.setUpdmemid(mngrId);
			temp.setSmName((String)name);
			temp.setUseyn(useYn);
			if ("Y".equals(useYn)) {

				if (request.getParameter(name+"_appId") != null && request.getParameter(name+"_secretKey") !=null
						&& !"".equals(request.getParameter(name+"_appId")) && !"".equals(request.getParameter(name+"_secretKey"))) {
					temp.setSmAppkey(request.getParameter(name+"_appId"));
					temp.setSmSecretkey(request.getParameter(name+"_secretKey"));
					temp.setEtc1(request.getParameter(name+"_etc1"));
					temp.setEtc2(request.getParameter(name+"_etc2"));
				} else {
					return CommUtil.doComplete(model, "오류", "파라미터가 정상적이지 않습니다.", "history.back()");
				}

				if ("naver".equals(name)) {
					StringBuffer url = request.getRequestURL();
					String returnURL =  url.substring(0, url.indexOf("/socialKey"));
					returnURL = returnURL.concat("/socialKey/social_comm_naverLogin.do");
					temp.setEtc1(returnURL);
				} else if ("twitter".equals(name)) {
					StringBuffer url = request.getRequestURL();
					String returnURL =  url.substring(0, url.indexOf("/socialKey"));
					returnURL = returnURL.concat("/socialKey/social_comm_twitterLogin.do");
					temp.setEtc1(returnURL);
				}

				if(socialmediaService.updateSocialmediaKey(temp) <= 0) {
					temp.setRegmemid(mngrId);
					socialmediaService.insertSocialmediaKey(temp);
				}

			}else if ("N".equals(useYn)) {
				temp.setRegmemid(mngrId);
				temp.setDelmemid(mngrId);
				if(socialmediaService.updateSocialmediaKey(temp) <= 0) {
					socialmediaService.insertSocialmediaKey(temp);
				}

			} else if ("".equals(useYn)) {
				return CommUtil.doComplete(model, "오류", "파라미터가 정상적이지 않습니다.", "history.back()");
			} else {
				return CommUtil.doComplete(model, "오류", "파라미터가 정상적이지 않습니다.", "history.back()");
			}

		}

		return CommUtil.doComplete(model, "성공", "정상적으로 저장 되었습니다.", "document.location.href='/_mngr_/socialKey/socialMediaKey.do'");
	}

	@RequestMapping("/_mngr_/socialKey/social_comm_naverLogin.do")
	public String naverLoginRedirectPage(ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException{

		SocialMediaKeyVO smVO = new SocialMediaKeyVO();
		smVO.setSmName("naver");
		smVO.setSiteCode(null);
		smVO = socialmediaService.getSocialMediaKey(smVO);
		smVO.setSmAccesstoken(request.getParameter("code"));
		model.addAttribute("naver", smVO);

		return "itgcms/global/module/socialmedia/naverLoginResult";
	}

	@RequestMapping("/_mngr_/socialKey/social_comm_twitterLogin.do")
	public String twitterLoginRedirectPage(ModelMap model, HttpServletRequest request, HttpSession session) throws IOException, SQLException, RuntimeException{

		SocialMediaKeyVO smVO = new SocialMediaKeyVO();
		smVO.setSmName("twitter");
		smVO.setSiteCode(null);
		smVO = socialmediaService.getSocialMediaKey(smVO);

		smVO.setSmAccesstoken(request.getParameter("oauth_token"));


		model.addAttribute("twitter", smVO);
		model.addAttribute("verifier",request.getParameter("oauth_verifier"));

		return "itgcms/global/module/socialmedia/twitterLoginResult";
	}
	*/


	/**
	 * 소셜페이지 관리자용 - 프로그램모듈
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/module/{menuCode}_view_snsConfig.do")
	public String viewSnsconfig(@PathVariable String menuCode, ModelMap model, HttpServletRequest request, DefaultVO searchVO) throws IOException, SQLException, RuntimeException{

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		searchVO.setSchOpt1(menuCode);
		List<ItgMap> resultMapList = socialmediaService.getSocialProgramSet(searchVO);
		model.addAttribute("resultList", resultMapList);
		if(resultMapList.size() == 0) {
			ItgMap paramMap = new ItgMap();
			paramMap.put("siteCode", siteCode);
			List<ItgMap> resultVOList = socialmediaService.selectSocialMediaKeys(paramMap);
			model.addAttribute("resultList", resultVOList);
		}

		model.addAttribute("siteCode", siteCode);
		model.addAttribute("snsconfigVO", CommUtil.getSiteconfigVO(siteCode,"snsconfig"));
		model.addAttribute("menuCode", menuCode);
		return "itgcms/global/module/socialmedia/snsConfig_view";
	}

	@RequestMapping(value = "/_mngr_/module/{menuCode}_edit_snsConfig_proc.do")
	public String editSnsconfigProc(@PathVariable String menuCode, @ModelAttribute("siteconfigVO") SiteconfigVO snsconfigVO, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		int result = socialmediaService.updateSocialProgramSetProc(paramMap);
		if(result <= 0) {
			result = socialmediaService.insertSocialProgramProc(paramMap);
		}

		String siteCode = request.getParameter("siteCode");
		CommUtil.setFileObject(snsconfigVO, "snsconfig", siteCode);

    	String title = "";
    	String msg = "";
    	String script="";

		if(result == 1){title = "완료";	msg = "저장 되었습니다."; script=  "location.href='/_mngr_/module/"+menuCode+"_view_snsConfig.do'";}
		else{title = "오류";msg = "저장이 완료되지 않았습니다."; script=  "location.href='/_mngr_/module/"+menuCode+"_view_snsConfig.do'";}

		return CommUtil.doComplete(model,title , msg,script);
	}

	@RequestMapping(value = "/{root}/module/{menuCode}_socialhub.do")
	public String socialHub(@PathVariable String root, @PathVariable String menuCode,
								ModelMap model,
								HttpServletRequest request,
								HttpServletResponse response, DefaultVO searchVO) throws IOException, SQLException, RuntimeException {

		searchVO.setSchOpt1(menuCode);
		List<ItgMap> resultMapList = socialmediaService.getSocialProgramSet(searchVO);

		searchVO.setEtc1(root); //사이트코드

		for(ItgMap tmp:resultMapList) {

			String smName = CommUtil.isNull(tmp.get("smName"),"");
			String useyn = CommUtil.isNull(tmp.get("useyn"),"N");
			String accountId = CommUtil.isNull(tmp.get("accountId"),"");

			if("Y".equals(useyn) && CommUtil.notEmpty(smName)) {
				model.addAttribute(smName+"Info", tmp);

				if(smName.equals("naver")){
					//Naver Blog XML Parsing
					List<ItgMap> contentList = new ArrayList();
					int i=0;
					if(CommUtil.notEmpty(accountId)) {
						try {
							RSSFeedParser parser = new RSSFeedParser("http://blog.rss.naver.com/"+accountId+".xml");
							Feed feed = parser.readFeed();
							for (FeedMessage message : feed.getMessages()) {
								ItgMap myMap = new ItgMap();
								myMap.put("author", message.getAuthor());
								myMap.put("description", message.getDescription());
								myMap.put("category", message.getCategory());
								myMap.put("guid", message.getGuid());
								myMap.put("link", message.getLink());
								myMap.put("pubdate", CommUtil.convertDatePattern(message.getPubdate(), "EEE, d MMM yyyy HH:mm:ss Z", "yyyy-MM-dd"));
								myMap.put("title", message.getTitle());
								contentList.add(i++, myMap);
								if(i==10) break; //블로그 글 갯수
							}
							model.addAttribute("blogList", contentList);
						}catch(RuntimeException e) {
							model.addAttribute("nbError", "1");
						}
					}
				}
				if(smName.equals("instagram")){
					//instagram XML Parsing
					List<ItgMap> contentList2 = new ArrayList();
					int j = 0;
					if(CommUtil.notEmpty(accountId)) {
						try {
							RSSFeedParser parser = new RSSFeedParser("http://queryfeed.net/instagram?q="+accountId); //사이트죽으면 접속 안됨
							Feed feed = parser.readFeed();
							for (FeedMessage message : feed.getMessages()) {
								ItgMap myMap = new ItgMap();
								myMap.put("author", message.getAuthor());
								myMap.put("description", message.getDescription());
								myMap.put("guid", message.getGuid());
								myMap.put("link", message.getLink());
								myMap.put("enclosure", message.getEnclosure());//IG 사진 url
								myMap.put("pubdate", CommUtil.convertDatePattern(message.getPubdate(), "EEE, d MMM yyyy HH:mm:ss Z", "yyyy-MM-dd"));
								myMap.put("title", message.getTitle());
								contentList2.add(j++, myMap);
								if(j==6) break; //가져올 글 갯수
							}
						}catch(RuntimeException e) {
							model.addAttribute("inError", "1");
						}
					}
					model.addAttribute("inList", contentList2);
				}

			}

		}

		return "itgcms/global/module/socialmedia/userSocialmedia";
	}

	@RequestMapping("/_mngr_/socialKey/twitterToken.do")
	@ResponseBody
	public String getTwitterToken(HttpServletRequest request, @RequestParam("siteCode") String siteCode) throws IOException, SQLException, RuntimeException, TwitterException{

		SocialMediaKeyVO smVO = new SocialMediaKeyVO();
		smVO.setSmName("twitter");
		smVO.setSiteCode(null);
		smVO = socialmediaService.getSocialMediaKey(smVO);

		Twitter twitter = new TwitterFactory().getInstance();

		twitter.setOAuthConsumer(smVO.getSmAppkey(), smVO.getSmSecretkey());

		RequestToken requestToken = twitter.getOAuthRequestToken();

		request.getSession().setAttribute("twitToken", requestToken);
		requestToken.getAuthorizationURL();
		smVO.setEtc2(requestToken.getToken());
		smVO.setSiteCode(siteCode);
		requestToken.getTokenSecret();
		if (socialmediaService.updateAccessToken(smVO) <= 0) {
			socialmediaService.insertAccessToken(smVO);
		}

		RestTemplate rt = new RestTemplate();


		String tmp = rt.getForObject("https://api.twitter.com/oauth/authenticate?oauth_token="+requestToken.getToken(), String.class);

		return smVO.getEtc2();
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/_mngr_/socialKey/{smName}AT_comm.do")
	@ResponseBody
	public Map<String, String> requestLongLiveAccessKey(@PathVariable("smName") String smName, @RequestParam(value="siteCode") String siteCode,
			@RequestParam(value="accessToken", required=false) String accessToken, @RequestParam(value="userID", required=false) String userID,
			@RequestParam(value="accessible") String accessible) throws IOException, SQLException, RuntimeException{

		RestTemplate rt = new RestTemplate();

		StringBuffer atURL = new StringBuffer(SocialMediaKeyVO.SOCIAL_MEDIA_MAP.get(smName).getTokenUrl());

		SocialMediaKeyVO smVO = new SocialMediaKeyVO();
		smVO.setSiteCode(siteCode);
		smVO.setSmName(smName);
		smVO.setSmUserid(userID);
		smVO.setSmAccesstoken(accessToken);

		SocialMediaKeyVO keys = socialmediaService.getSocialMediaKey(smVO);

		if (keys == null) {
			smVO.setSiteCode("");
			keys = socialmediaService.getSocialMediaKey(smVO);
			smVO.setSiteCode(siteCode);
		}

		Map<String, String> rtResult = null;

		if ("Y".equals(accessible)) {

			if ("facebook".equals(smName)) {
				atURL.append("access_token=");
				atURL.append(accessToken);
				atURL.append("&fb_exchange_token=");
				atURL.append(accessToken);
				atURL.append("&client_id=");
				atURL.append(keys.getSmAppkey());
				atURL.append("&client_secret=");
				atURL.append(keys.getSmSecretkey());
				atURL.append("&grant_type=fb_exchange_token");

				rtResult = rt.getForObject(atURL.toString(), HashMap.class);

			} else if ("naver".equals(smName)) {

				if (keys == null || keys.getSmAccesstoken() == null || "".equals(keys.getSmAccesstoken())) {
					atURL.append("grant_type=authorization_code");
					atURL.append("&client_id=");
					atURL.append(keys.getSmAppkey());
					atURL.append("&client_secret=");
					atURL.append(keys.getSmSecretkey());
					atURL.append("&code=");
					atURL.append(accessToken);
					SecureRandom random = new SecureRandom();
					atURL.append("&state=");
					atURL.append(new BigInteger(130, random).toString());
				} else {
					atURL.append("grant_type=refresh_token");
					atURL.append("&refresh_token=");
					atURL.append(keys.getSmUserid());
				}


				rtResult = rt.getForObject(atURL.toString(), HashMap.class);

			} else if ("twitter".equals(smName)) {
				atURL.append("oauth_verifier=");
				atURL.append(userID);


				Map <String, String> param = new HashMap<String, String>();
				param.put("oauth_verifier", userID);
				rtResult = (Map<String, String>) rt.postForEntity(atURL.toString(), param, Map.class);
			}







			if ("facebook".equals(smName)) {
				smVO.setSmAccesstoken(rtResult.get("access_token"));
			} else if ("naver".equals(smName)) {
 				smVO.setSmAccesstoken(rtResult.get("access_token"));
 				smVO.setSmUserid(rtResult.get("refresh_token"));
			} else if ("twitter".equals(smName)) {
				smVO.setSmAccesstoken(rtResult.get("oauth_token").concat("&").concat(rtResult.get("oauth_token_secret")));
				smVO.setSmUserid(rtResult.get("user_id"));
				smVO.setEtc2(rtResult.get("screen_name"));
			}

		}


		if(socialmediaService.updateAccessToken(smVO) <= 0) {
			socialmediaService.insertAccessToken(smVO);
		}



		return rtResult;
	}
}
