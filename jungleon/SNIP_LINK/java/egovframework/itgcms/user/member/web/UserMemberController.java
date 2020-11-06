package egovframework.itgcms.user.member.web;

import java.io.IOException;
import java.lang.reflect.Array;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MemberType;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.core.ipCountry.service.IpCountryService;
import egovframework.itgcms.core.ipCountry.service.IpCountryVO;
import egovframework.itgcms.core.joinformconfig.service.MngrJoinFormConfigSearchVO;
import egovframework.itgcms.core.joinformconfig.service.MngrJoinFormConfigService;
import egovframework.itgcms.core.member.service.MemberExtService;
import egovframework.itgcms.core.member.service.MemberExtVO;
import egovframework.itgcms.core.member.service.MemberService;
import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.itgcms.core.menu.service.MngrMenuService;
import egovframework.itgcms.module.contract.service.ContractService;
import egovframework.itgcms.module.real.service.RealDbService;
import egovframework.itgcms.project.cominfo.service.CominfoService;
import egovframework.itgcms.project.cominfo.service.CominfoVO;
import egovframework.itgcms.user.member.service.MemberBizBean;
import egovframework.itgcms.util.AES256Cipher2;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import net.sf.uadetector.ReadableUserAgent;
import net.sf.uadetector.UserAgentStringParser;
import net.sf.uadetector.service.UADetectorServiceFactory;


/**
 * @파일명 : UserMemberController.java
 * @파일정보 : 회원 등록 관리
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
@RequestMapping("/{root}/module/*")
public class UserMemberController {

	/** MngrMenuService */
	@Resource(name = "mngrMenuService")
	private MngrMenuService mngrMenuService;

	/** MngrCodeService */
	@Resource(name = "mngrCodeService")
	private MngrCodeService mngrCodeService;

	/** MemberService */
	@Resource(name = "memberService")
	private MemberService memberService;

	/** MemberExtService */
	@Resource(name = "memberExtService")
	private MemberExtService memberExtService;

	@Resource(name = "ipCountryService")
	private IpCountryService ipCountryService;

	@Resource(name="joinFormConfigService")
	private MngrJoinFormConfigService joinFormConfigSerivce;

	@Resource(name="mngrCodeService")
	private MngrCodeService codeService;
	@Resource(name="contractService")
	private ContractService contractService;
	@Autowired
	private HttpServletRequest request;
	@Resource(name = "realDbService")
	private RealDbService realDbService;
	@Resource(name="cominfoService")
	private CominfoService cominfoService;

	private static final Logger logger = LogManager.getLogger(UserMemberController.class);

	@RequestMapping(value = "{menuCode}_memberRegist.do")
	public String webMemReg(@PathVariable String root,@PathVariable String menuCode, HttpSession session, ModelMap model, HttpServletResponse response) throws IOException, SQLException, RuntimeException, EmailException {

		if (!CommUtil.isExistSite(root))
			return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		String stp = CommUtil.isNull(request.getParameter("stp"), "Step00");

		String memType = request.getParameter("type");

		//MngrJoinFormConfigSearchVO joinForm = joinFormConfigSerivce.mngrGetJoinFormBySiteCode(root, null);
		//model.addAttribute("joinForm", joinForm);

		String returnPage = "itgcms/user/member/";
		if(memType != null && "C".equals(memType) && "Step03".equals(stp)) {
			returnPage += "comemRegist";
		} else {
			returnPage += "memberRegist";
		}
		// 일반/기업회원 agree, step01, step02 complete 공통
		// step03 분기됨.

		//가입 단계 확인
		switch (stp) {
			case "Step00":
				stp = "Step00";
				break;
			case "Step01":
				stp = "Step01";

				break;
			case "Step02":
				stp = "Step02";

				break;
			case "Step03":
				stp = "Step03";

				break;
			case "complete":
				stp = "complete";

				break;
			case "agree":
				stp = "Agree";

				break;
			default :
				return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
		}
		 if("Step00".equals(stp)){
			 // 개인/기업 선택 화면. 로직 없음
		} else if ("agree".equals(stp)) {
			if("".equals(CommUtil.isNull(memType, ""))) {
				return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
			}
		} else if ("Step01".equals(stp)) {

			/*
			// 약관 관리
				String progIdx = request.getParameter("progIdx");

				EgovMap egovMap = new EgovMap();
				egovMap.put("menuCode", menuCode);
				egovMap.put("progIdx", progIdx);
				egovMap = contractService.getMenuContractInfo(egovMap);

				if(egovMap != null&&egovMap.get("contractNo")!=null){

					egovMap.put("contractDesc", egovMap.get("contractNo").toString().split(","));

			    	contractService.mngrGetContractListByContractDesc(egovMap);
			    	model.addAttribute("menuCode", menuCode);
			    	model.addAttribute("progIdx", progIdx);
			    	model.addAttribute("result", egovMap);
			    	model.addAttribute("contractList", contractService.selectMngrGetContractList());
			    	model.addAttribute("contractResultList", contractService.mngrGetContractListByContractDesc(egovMap));
			    	model.addAttribute("contractResultListSize", contractService.mngrGetContractListByContractDesc(egovMap).size());
				}else{
					CommUtil.doComplete(model, "오류", "페이지 정보가 올바르지 않습니다", "history.back();");
				}
				*/

				NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

				String sSiteCode = "BR288";			// NICE로부터 부여받은 사이트 코드
				String sSitePassword = "Mw0TgexgXupV";		// NICE로부터 부여받은 사이트 패스워드

				String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
				                                                	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
				sRequestNumber = niceCheck.getRequestNO(sSiteCode);
				session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

				String sAuthType = "M";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서

				String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
				String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지

				String sGender = ""; 			//없으면 기본 선택 값, 0 : 여자, 1 : 남자

				// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
				//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
				String sReturnUrl =CommUtil.getCurrentUrl(request)+"/"+root+"/contents/registration.do?type="+memType+"&stp=Step02";      // 성공시 이동될 URL
				String sErrorUrl = CommUtil.getCurrentUrl(request)+"/"+root+"/contents/registration.do?type="+memType+"&stp=Cert";          // 실패시 이동될 URL

				// 입력될 plain 데이타를 만든다.
				String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
				                    "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
				                    "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
				                    "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
				                    "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
				                    "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
				                    "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize +
									"6:GENDER" + sGender.getBytes().length + ":" + sGender;

				String sMessage = "";
				String sEncData = "";

				int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
				if( iReturn == 0 )
				{
				    sEncData = niceCheck.getCipherData();
				}
				else if( iReturn == -1)
				{
				    sMessage = "암호화 시스템 에러입니다.";
				}
				else if( iReturn == -2)
				{
				    sMessage = "암호화 처리오류입니다.";
				}
				else if( iReturn == -3)
				{
				    sMessage = "암호화 데이터 오류입니다.";
				}
				else if( iReturn == -9)
				{
				    sMessage = "입력 데이터 오류입니다.";
				}
				else
				{
				    sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
				}
			   model.addAttribute("sEncData",sEncData);

			}else if ("Cert".equals(stp)) {
				// 본인인증 실패
				return CommUtil.doComplete(model, "오류", "본인인증 오류가 발생했습니다. 다시 시도해 주세요.", "history.back();");
		}else if ("Step02".equals(stp)) {
			   NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

			    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

			    String sSiteCode = "BR288";				// NICE로부터 부여받은 사이트 코드
			    String sSitePassword = "Mw0TgexgXupV";			// NICE로부터 부여받은 사이트 패스워드

			    String sCipherTime = "";			// 복호화한 시간
			    String sRequestNumber = "";			// 요청 번호
			    String sResponseNumber = "";		// 인증 고유번호
			    String sAuthType = "";				// 인증 수단
			    String sName = "";					// 성명
			    String sDupInfo = "";				// 중복가입 확인값 (DI_64 byte)
			    String sConnInfo = "";				// 연계정보 확인값 (CI_88 byte)
			    String sBirthDate = "";				// 생년월일(YYYYMMDD)
			    String sGender = "";				// 성별
			    String sNationalInfo = "";			// 내/외국인정보 (개발가이드 참조)
				String sMobileNo = "";				// 휴대폰번호
				String sMobileCo = "";				// 통신사
			    String sMessage = "";
			    String sPlainData = "";

			    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

			    if( iReturn == 0 )
			    {
			        sPlainData = niceCheck.getPlainData();
			        sCipherTime = niceCheck.getCipherDateTime();

			        // 데이타를 추출합니다.
			        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

			        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
			        sResponseNumber = (String)mapresult.get("RES_SEQ");
			        sAuthType		= (String)mapresult.get("AUTH_TYPE");
			        sName			= (String)mapresult.get("NAME");
					//sName			= (String)mapresult.get("UTF8_NAME"); //charset utf8 사용시 주석 해제 후 사용
			        sBirthDate		= (String)mapresult.get("BIRTHDATE");
			        sGender			= (String)mapresult.get("GENDER");
			        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
			        sDupInfo		= (String)mapresult.get("DI");
			        sConnInfo		= (String)mapresult.get("CI");
			        sMobileNo		= (String)mapresult.get("MOBILE_NO");
			        sMobileCo		= (String)mapresult.get("MOBILE_CO");

			        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
			        if(!sRequestNumber.equals(session_sRequestNumber))
			        {
			            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
			            sResponseNumber = "";
			            sAuthType = "";
			        }
			    }
			    else if( iReturn == -1)
			    {
			        sMessage = "복호화 시스템 에러입니다.";
			    }
			    else if( iReturn == -4)
			    {
			        sMessage = "복호화 처리오류입니다.";
			    }
			    else if( iReturn == -5)
			    {
			        sMessage = "복호화 해쉬 오류입니다.";
			    }
			    else if( iReturn == -6)
			    {
			        sMessage = "복호화 데이터 오류입니다.";
			    }
			    else if( iReturn == -9)
			    {
			        sMessage = "입력 데이터 오류입니다.";
			    }
			    else if( iReturn == -12)
			    {
			        sMessage = "사이트 패스워드 오류입니다.";
			    }
			    else
			    {
			        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
			    }
			    if(!"".equals(sMessage)) {
			    	return CommUtil.doComplete(model, "오류", sMessage, "self.close();");
			    }
			    MemberVO memberVO = new MemberExtVO();
			    memberVO.setDi(sDupInfo);
				ItgMap paramMap = new ItgMap();
				paramMap.put("di", sDupInfo);
				ItgMap resultMap = realDbService.memberPossible(paramMap);
			    //DI 중복체크해서 중복가입 방지.
			    if(memberVO != null) {
			    	if (Integer.parseInt(resultMap.get("cnt1")+"")>0&&Integer.parseInt(resultMap.get("cnt2")+"")>0) {
			    		return CommUtil.doComplete(model, "오류", "이미 가입된 사용자입니다. 확인 후 다시 시도해 주세요.", "self.close();");
					}
			    }
			    memberVO = memberService.selectMemberView(memberVO);
			    Map<String, String> certInfo = new HashMap<String, String>();

			    certInfo.put("name", sName);
			    certInfo.put("birth",sBirthDate);
			    certInfo.put("sex",	("1".equals(CommUtil.isNull(sGender, "")))?"M":"F" );
			    certInfo.put("di",sDupInfo);
			    certInfo.put("ci",sConnInfo);
			    certInfo.put("mobile",sMobileNo);
			    session.setAttribute("certInfo", certInfo);
		}else if("Step03".equals(stp)){
			if(!CommUtil.regEx("(N|C)", memType)) { //일반회원 N, 기업회원 C 아닌경우
				return CommUtil.doComplete(model, "오류", "정상적인 회원구분이 아닙니다.", "history.back();");
			}

			Map<String, String> certInfo = (HashMap<String, String>)session.getAttribute("certInfo");
			if(certInfo == null || certInfo.get("name") == null || certInfo.get("di") == null) {
				return CommUtil.doComplete(model, "오류", "본인인증 정보가 없습니다. 확인 후 다시 시도 해 주세요.", "history.back();");
			}

			session.setAttribute("certInfo", certInfo);

			MngrCodeVO mngrCodeVO = new MngrCodeVO();
			mngrCodeVO.setSchCode("V015");//패스워드 질문
			model.addAttribute("pwdQuest", mngrCodeService.getMngrCodeList(mngrCodeVO));

			mngrCodeVO.setSchCode("V073");//관심사업
			model.addAttribute("concerns", mngrCodeService.getMngrCodeList(mngrCodeVO));

			mngrCodeVO.setSchCode("V007");//주소.
			model.addAttribute("addr", mngrCodeService.getMngrCodeList(mngrCodeVO));


		}else if("complete".equals(stp)){
			session.setAttribute("certInfo", null);
		}
		model.addAttribute("memType", memType);
		model.addAttribute("siteCode", root);
		return returnPage + stp;
	}

	/**
	 * 가입 단계별 이전 페이지 주소
	 * @param referer
	 * @param oriUri
	 * @return
	 */
	private boolean isRegistReferer(String referer, String oriUri, HttpServletResponse response) {
		if (referer == null || "".equals(referer)) {
			return false;
		}

		String[] separator = referer.split("/");
		String uri = separator[separator.length - 1];

		if (!oriUri.equals(uri)) {
			return false;
		}
		return true;
	}

	/**
	 * 아이디 중복 검사
	 * @param searchVO
	 * @return
	 */
	@RequestMapping(value = "{menuCode}_checkId.ajax", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> webMemberCheckId(@PathVariable String root, @ModelAttribute("searchVO") MemberVO searchVO, HttpServletResponse response) {
		HashMap<String, Object> json = memberService.getMemberIdDuplCheck(searchVO);
		return json;
	}
	/**
	 * 아이디 중복 검사
	 * @param searchVO
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "{menuCode}_checkbusiRegNo.ajax", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> checkbusiRegNo(@PathVariable String root, @ModelAttribute("searchVO") CominfoVO searchVO, HttpServletResponse response) throws SQLException {
		HashMap<String, Object> json = cominfoService.checkbusiRegNo(searchVO);
		return json;
	}

	/**
	 * 닉네임 중복검사 ajax
	 * @param searchVO
	 * @return
	 */
	@RequestMapping(value = "{menuCode}_checkNickName.ajax", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> webMemberCheckNickName(@PathVariable String root, @ModelAttribute("searchVO") MemberVO searchVO, HttpServletResponse response) {
		HashMap<String, Object> json = memberService.getMemberNickNameDuplCheck(searchVO);
		return json;
	}
	/**
	 * email 중복 검사
	 * @param searchVO
	 * @return
	 */
	@RequestMapping(value = "{menuCode}_checkEmail.ajax", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> checkEmail(@PathVariable String root, @ModelAttribute("searchVO") MemberVO searchVO, HttpServletResponse response) {
		HashMap<String, Object> json = memberService.getMemberEmailDuplCheck(searchVO);
		return json;
	}
	/**
	 * 캅차 입력 값 확인
	 * @param root
	 * @param searchVO
	 * @return
	 */
	@RequestMapping(value = "{menuCode}_checkCaptcha.ajax", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> webMemberCheckCaptcha(@PathVariable String root, @ModelAttribute("searchVO") MemberVO searchVO, HttpSession session, HttpServletResponse response) {
		HashMap<String, Object> json = new HashMap<>();
		json.put("result", "0");
		json.put("message", "알수없는 오류가 발생했습니다. 다시 시도해 주세요.");

		if ("".equals(CommUtil.isNull(searchVO.getCaptcha(), ""))) {
			return json;
		}

		String answer = (String) session.getAttribute("CMS_CAPTCHA");
		if (searchVO.getCaptcha().equals(answer)) {
			json.put("result", "1");
			json.put("message", "자동입력방지 문자가 일치합니다.");
		}
		else {
			json.put("result", "2");
			json.put("message", "자동입력방지 문자가 일치하지 않습니다.");
		}

		return json;
	}

	/**
	 * 회원등록 처리
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_input_proc.do", method = RequestMethod.POST)
	public String webMemberRegistProc(@PathVariable String root, @ModelAttribute("memberVO") MemberExtVO memberVO, HttpSession session,
			@ModelAttribute("cominfoVO") CominfoVO cominfoVO,
	                                  ModelMap model, RedirectAttributes redirectAttributes, HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		memberVO.setRegSiteCode(root);
		// 아이디, 이름, 비밀번호, 비밀번호확인, 이메일, 부서

		if ("".equals(CommUtil.isNull(memberVO.getId(), "")))
			return CommUtil.doComplete(model, "오류", "아이디를 입력 해 주세요.", "history.back();");
		if ("".equals(CommUtil.isNull(memberVO.getPass(), "")))
			return CommUtil.doComplete(model, "오류", "비밀번호를 입력 해 주세요.", "history.back();");
		if ("".equals(CommUtil.isNull(memberVO.getPass2(), "")))
			return CommUtil.doComplete(model, "오류", "비밀번호 확인을 입력 해 주세요.", "history.back();");


		//아이디 첫글자 영문 체크
		if (!CommUtil.regEx("^[a-zA-Z]", memberVO.getId()))
			return CommUtil.doComplete(model, "오류", "아이디 첫글자는 영문자로 입력 해 주세요.", "history.back();");
		if (CommUtil.regEx("[^a-zA-Z0-9_]", memberVO.getId()))
			return CommUtil.doComplete(model, "오류", "아이디는 영문, 숫자, _ 만 입력 가능합니다.", "history.back();");
		if (memberVO.getId().length() < 4 || memberVO.getId().length() > 12)
			return CommUtil.doComplete(model, "오류", "아이디는 4 ~ 12자 이내로 입력 해 주세요.", "history.back();");

		//아이디 중복 검사
		MemberVO checkIdVO = new MemberVO();
		checkIdVO.setId(memberVO.getId());
		int resultIdCount = memberService.mSelectMemberCnt(checkIdVO);
		if (resultIdCount > 0)
			return CommUtil.doComplete(model, "오류", "중복된 아이디 입니다. 확인 후 다시 시도하세요.", "history.back();");


		//비밀번호 체크
		if (!(CommUtil.regEx("[0-9]", memberVO.getPass()) &&
			CommUtil.regEx("[a-zA-Z]", memberVO.getPass2()) &&
			memberVO.getPass().length() >= 10))
			return CommUtil.doComplete(model, "오류", "비밀번호는 영문 + 숫자 조합으로 10자 이상 입력 해 주세요.", "history.back();");

		if (!memberVO.getPass().equals(memberVO.getPass2()))
			return CommUtil.doComplete(model, "오류", "비밀번호와 비밀번호 확인이 일치하지 않습니다.", "history.back();");

		if ("".equals(CommUtil.isNull(memberVO.getEmailYn(), ""))) {
			memberVO.setEmailYn("N");
		}

		@SuppressWarnings("unchecked")
		Map<String, String> certInfo = (HashMap<String, String>)session.getAttribute("certInfo");
		if("".equals(CommUtil.isNull(certInfo.get("name"), ""))) {
			return CommUtil.doComplete(model, "오류", "본인인증 정보가 없습니다. 확인 후 다시 시도 해 주세요", "history.back();");
		}

		String ip = request.getRemoteAddr();
		IpCountryVO ipCountryVO = ipCountryService.getCountryNameAndCode(ip);
		memberVO.setRegIp(ip);
		memberVO.setRegCountryCd(ipCountryVO.getCountryCode());
		memberVO.setRegCountryName(ipCountryVO.getCountryName());

		UserAgentStringParser parser = UADetectorServiceFactory.getResourceModuleParser();
		ReadableUserAgent uai = parser.parse(request.getHeader("User-Agent"));
		memberVO.setRegBrowser(uai.getName());
		memberVO.setRegBrowserIcon(uai.getIcon());
		memberVO.setRegOs(uai.getOperatingSystem().getName());
		memberVO.setRegOsIcon(uai.getOperatingSystem().getIcon());


		//본인인증 세션정보 저장
		memberVO.setName(certInfo.get("name"));
		memberVO.setBirth(String.format("%s-%s-%s", certInfo.get("birth").substring(0, 4), certInfo.get("birth").substring(4, 6), certInfo.get("birth").substring(6, 8)  ));

		memberVO.setMobile(CustomUtil.getMobileAddHyphen(certInfo.get("mobile")));
		memberVO.setDi(certInfo.get("di"));
		memberVO.setCi(certInfo.get("di"));

		//비밀번호 암호화
		try {
			memberVO.setSchOpt5(memberVO.getPass());
			memberVO.setPass(CommUtil.hexSha256(memberVO.getPass()));
		} catch (IOException e1) {
			logger.error("예외 상황 발생");
		} catch (NoSuchAlgorithmException e2) {
			logger.error("예외 상황 발생");
		}
		String url = request.getRequestURL().toString();
		memberVO.setSchOpt1(url);
		memberVO.setRegId(memberVO.getId());

		// 자동가입여부에 따라 승인/대기 처리.
		MngrJoinFormConfigSearchVO joinForm = joinFormConfigSerivce.mngrGetJoinFormBySiteCode(root, null);
		if(joinForm == null ||  joinForm.getUseJoinwait() == 0) {
			memberVO.setStatus("mem_normal");
		} else {
			memberVO.setStatus("mem_wait");
		}

		if("C".equals(memberVO.getType())) {
			if("".equals(CommUtil.isNull(cominfoVO.getBusiRegNo(), ""))) {
				return CommUtil.doComplete(model, "오류", "사업자 등록번호를 확인 해 주세요.", "history.back();");
			}
			if (cominfoVO.getAddr01().indexOf("수정구") > -1 ) cominfoVO.setAreaCd("V007000001");
	        else if (cominfoVO.getAddr01().indexOf("중원구") > -1 ) cominfoVO.setAreaCd("V007000002");
	        else if (cominfoVO.getAddr01().indexOf("분당구") > -1 ) cominfoVO.setAreaCd("V007000003");
	        else cominfoVO.setAreaCd("V007000004");

			memberVO.setAreaCd(cominfoVO.getAreaCd());

			// company 정보와 t_member 정보를 insert함.
			cominfoService.insertCominfo(memberVO, cominfoVO);

		} else {
			memberVO.setSex(certInfo.get("sex")); // 20200720 woonee 개인사용자는 인증정보, 기업은 사용자에게 입력 받음.
			cominfoService.insertMemberRegist(memberVO);
		}

/*		//가입 메일 전송
		try {
			CommUtil.sendMail("itgood@itgood.co.kr", "아이티굿" , memberVO.getEmail(), memberVO.getName(), "가입감사 제목", "가입감사 내용");
		}
		catch (EmailException e) {
			logger.error("예외 상황 발생");
		}*/

		redirectAttributes.addAttribute("stp", "complete");

		return "redirect:/"+root+"/contents/registration.do";
	}

	@RequestMapping(value = "{menuCode}_memberEdit.do")
	public String memberEdit(@PathVariable String root, @PathVariable String menuCode, ModelMap model, @ModelAttribute("member") MemberVO memberVO, HttpServletRequest request) throws IOException, SQLException, Exception {
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + root + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}

		/*
		 * 수정페이지 접속시 비밀번호 확인.
		 * memberVO pass 데이터 없으면 패스워드 확인 페이지로.
		 */
		if("".equals(CommUtil.isNull(memberVO.getPass(), ""))) {
			return "itgcms/user/member/userMemberEditCheck";
		} else {
			String encUserPass = CommUtil.hexSha256(memberVO.getPass());
			memberVO = memberService.selectMemberView( new MemberVO() {
				@Override
				public String getId() {
					return CommUtil.getUserMemId();
				}
			}
					);
			if (memberVO == null) {
				return CommUtil.doComplete(model, "오류", "회원정보가 없습니다. 확인 후 다시 시도하세요.", "location.href='/"+root+"/main/index.do'");
			}
			if(!encUserPass.equals(memberVO.getPass())){
				return CommUtil.doComplete(model, "오류", "패스워드가 일치하지 않습니다..", "history.back();");
			}
		}


		MngrCodeVO mngrCodeVO = new MngrCodeVO();
		mngrCodeVO.setSchCode("V015");//패스워드 질문
		model.addAttribute("pwdQuest", mngrCodeService.getMngrCodeList(mngrCodeVO));

		mngrCodeVO.setSchCode("V073");//관심사업
		model.addAttribute("concerns", mngrCodeService.getMngrCodeList(mngrCodeVO));

		mngrCodeVO.setSchCode("V007");//주소.
		model.addAttribute("addr", mngrCodeService.getMngrCodeList(mngrCodeVO));

		//일반회원
		if("N".equals(memberVO.getType())) {
			model.addAttribute("memberVO", memberVO);
			return "itgcms/user/member/userMemberEdit";

		} else if("C".equals(memberVO.getType())) {//기업회원
			CominfoVO cominfo = cominfoService.selectCominfoViewById(new CominfoVO() {
												public String getId() {
													return CommUtil.getUserMemId();
												}
											});
			if (cominfo == null) {
				return CommUtil.doComplete(model, "오류", "기업 정보가 없습니다. 확인 후 다시 시도하세요.", "location.href='/"+root+"/main/index.do'");
			}
			model.addAttribute("memberVO", memberVO);
			model.addAttribute("cominfo", cominfo);
			return "itgcms/user/member/userComMemberEdit";

		}
		return CommUtil.doComplete(model, "오류", "회원 구분 정보가 일치하지 않습니다.", "location.href='/"+root+"/main/index.do'");
	}


	/**
	 * 회워정보 수정 처리
	 * @param root
	 * @param memberVO
	 * @param session
	 * @param cominfoVO
	 * @param model
	 * @param redirectAttributes
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "{menuCode}_update_proc.do", method = RequestMethod.POST)
	public String webMemberUpdateProc(@PathVariable String root, @ModelAttribute("memberVO") MemberExtVO memberVO, HttpSession session,
			@ModelAttribute("cominfoVO") CominfoVO cominfoVO,  ModelMap model, RedirectAttributes redirectAttributes, HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		// 로그인 체크
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + root + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
		MemberVO memberInfo = memberService.selectMemberView( new MemberVO() {
																@Override
																public String getId() {
																	return CommUtil.getUserMemId();
																}
															}
														);
		if (memberInfo == null) {
			return CommUtil.doComplete(model, "오류", "회원정보가 없습니다. 확인 후 다시 시도하세요.", "location.href='/"+root+"/main/index.do'");
		}

		// 입력 오류 체크
		if ("".equals(CommUtil.isNull(memberVO.getPass(), "")) && !"".equals(CommUtil.isNull(memberVO.getPass2(), "")))
			return CommUtil.doComplete(model, "오류", "비밀번호를 입력 해 주세요.", "history.back();");
		if (!"".equals(CommUtil.isNull(memberVO.getPass(), "")) && "".equals(CommUtil.isNull(memberVO.getPass2(), "")))
			return CommUtil.doComplete(model, "오류", "비밀번호 확인을 입력 해 주세요.", "history.back();");

		// 비밀번호 입력했을때만 확인.
		if (!"".equals(CommUtil.isNull(memberVO.getPass(), "")) && !"".equals(CommUtil.isNull(memberVO.getPass2(), ""))) {
			//비밀번호 체크
			if (!(CommUtil.regEx("[0-9]", memberVO.getPass()) &&
					CommUtil.regEx("[a-zA-Z]", memberVO.getPass2()) &&
					memberVO.getPass().length() >= 10))
				return CommUtil.doComplete(model, "오류", "비밀번호는 영문 + 숫자 조합으로 10자 이상 입력 해 주세요.", "history.back();");

			if (!memberVO.getPass().equals(memberVO.getPass2()))
				return CommUtil.doComplete(model, "오류", "비밀번호와 비밀번호 확인이 일치하지 않습니다.", "history.back();");
			//비밀번호 암호화
			try {
				memberVO.setSchOpt5(memberVO.getPass());
				memberVO.setPass(CommUtil.hexSha256(memberVO.getPass()));
			} catch (IOException e1) {
				logger.error("예외 상황 발생");
			} catch (NoSuchAlgorithmException e2) {
				logger.error("예외 상황 발생");
			}
		}

		if ("".equals(CommUtil.isNull(memberVO.getEmailYn(), ""))) {
			memberVO.setEmailYn("N");
		}
		String url = request.getRequestURL().toString();
		memberVO.setSchOpt1(url);
		memberVO.setId(CommUtil.getUserMemId());
		memberVO.setUpdId(CommUtil.getUserMemId());

		if("C".equals(memberInfo.getType())) {
			if (cominfoVO.getAddr01().indexOf("수정구") > -1 ) cominfoVO.setAreaCd("V007000001");
	        else if (cominfoVO.getAddr01().indexOf("중원구") > -1 ) cominfoVO.setAreaCd("V007000002");
	        else if (cominfoVO.getAddr01().indexOf("분당구") > -1 ) cominfoVO.setAreaCd("V007000003");
	        else cominfoVO.setAreaCd("V007000004");

			memberVO.setAreaCd(cominfoVO.getAreaCd());

			cominfoVO.setId(CommUtil.getUserMemId());
			cominfoVO.setModId(CommUtil.getUserMemId());
			// company 정보와 t_member 정보를 insert함.
			cominfoService.updateCominfo(memberVO, cominfoVO);

		} else {
			cominfoService.updatetMemberRegist(memberVO);
		}

		return CommUtil.doComplete(model, "완료", "정상적으로 저장되었습니다.", "location.href='/" + root + "/contents/member-view.do'");
	}

	/**
	 * 회원정보(조회)
	 * @param root
	 * @param menuCode
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws Exception
	 */
	@RequestMapping(value = "{menuCode}_memberView.do")
	public String memberView(@PathVariable String root, @PathVariable String menuCode, ModelMap model, HttpServletRequest request) throws IOException, SQLException, Exception {

		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + root + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}

		MemberVO memberVO = memberService.selectMemberView( new MemberVO() {
																@Override
																public String getId() {
																	return CommUtil.getUserMemId();
																}
															}
														);
		if (memberVO == null) {
			return CommUtil.doComplete(model, "오류", "회원정보가 없습니다. 확인 후 다시 시도하세요.", "location.href='/"+root+"/main/index.do'");
		}

		MngrCodeVO mngrCodeVO = new MngrCodeVO();
		mngrCodeVO.setSchCode("V073");//관심사업
		List<MngrCodeVO> concernsList = mngrCodeService.getMngrCodeList(mngrCodeVO);

		Map<String, String> concernsMap = new HashMap<String, String>();
		for(MngrCodeVO code : concernsList) {
			concernsMap.put(code.getCcode(), code.getCname());
		}
		model.addAttribute("concernsMap", concernsMap);

		if("N".equals(memberVO.getType())) {
			model.addAttribute("memberVO", memberVO);
			return "itgcms/user/member/userMemberView";
		} else if("C".equals(memberVO.getType())) {
			CominfoVO cominfo = cominfoService.selectCominfoViewById(new CominfoVO() {
												public String getId() {
													return CommUtil.getUserMemId();
												}
											});
			if (cominfo == null) {
				return CommUtil.doComplete(model, "오류", "기업 정보가 없습니다. 확인 후 다시 시도하세요.", "location.href='/"+root+"/main/index.do'");
			}
			model.addAttribute("memberVO", memberVO);
			model.addAttribute("cominfo", cominfo);
			return "itgcms/user/member/userComMemberView";

		}
		return CommUtil.doComplete(model, "오류", "회원 구분 정보가 일치하지 않습니다.", "location.href='/"+root+"/main/index.do'");
	}
	/**
	 * 회원탈퇴 화면(일반/기업 공통)
	 * @param root
	 * @param menuCode
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws Exception
	 */
	@RequestMapping(value = "{menuCode}_withdrawal.do")
	public String memberWithdrawal(@PathVariable String root, @PathVariable String menuCode, ModelMap model, HttpServletRequest request) throws IOException, SQLException, Exception {

		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + root + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
		return "itgcms/user/member/userMemberWithdrawal";
	}
	/**
	 * 회원탈퇴 처리 (일반/기업 공통)
	 * @param root
	 * @param menuCode
	 * @param memberVO
	 * @param model
	 * @param session
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws Exception
	 */
	@RequestMapping(value = "{menuCode}_withdrawalProc.do")
	public String memberWithdrawalProc(@PathVariable String root, @PathVariable String menuCode, @ModelAttribute("memberVO") MemberExtVO memberVO, ModelMap model, HttpSession session) throws IOException, SQLException, Exception {
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + root + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}

		if("".equals(CommUtil.isNull(memberVO.getPass(), ""))) { return CommUtil.doComplete(model, "오류", "비밀번호를 입력 해 주세요", "history.back();");}

		MemberVO memInfo = memberService.selectMemberView( new MemberVO() {
																	@Override
																	public String getId() {
																		return CommUtil.getUserMemId();
																	}
																}
															);
		if(memInfo == null) {
			return CommUtil.doComplete(model, "오류", "회원정보가 없습니다. 확인 후 다시 시도해 주세요.", "history.back()");
		}

		if( !CommUtil.hexSha256(memberVO.getPass()).equals(memInfo.getPass())) {
			return CommUtil.doComplete(model, "오류", "아이디와 비밀번호를 확인 후 다시 시도해 주세요.", "history.back()");
		}

		memberVO.setDelId(CommUtil.getUserMemId());
		memberVO.setDelIp(CommUtil.getClientIP(request));
		if("C".equals(memInfo.getType())) {

		cominfoService.updateDeleteCominfoWithMemberByID(memberVO, new CominfoVO() {
															@Override
															public String getId() {
																return CommUtil.getUserMemId();
															}
													});
		} else {
			memberService.deleteMemberProc(memberVO);
		}

		session.setAttribute("userSessionVO", null);
		return CommUtil.doComplete(model, "완료", "탈퇴 처리가 완료되었습니다. 이용해 주셔서 감사합니다. ", "location.href='/"+root+"/main/index.do'");
	}
	public String requestReplace (String paramValue, String gubun) {

        String result = "";

        if (paramValue != null) {

        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");

        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}

        	result = paramValue;

        }
        return result;
  }
	@RequestMapping(value = "open_loginForm.do", method = {RequestMethod.GET})
	public String loginFormJungle(HttpServletRequest request, ModelMap model) {
		String returnUri = request.getParameter("return_url");
		if (isEmpty(returnUri) || returnUri.indexOf("https://www.jungleon.or.kr") == -1
				&& returnUri.indexOf("https://m.jungleon.or.kr") == -1
				&& returnUri.indexOf("http://www.jungleon.anymobi.kr") == -1) {
			returnUri = "http://www.jungleon.or.kr";
		}

		model.addAttribute("returnUri", returnUri);
		request.getSession().setAttribute("RETURN_URI_JUNGLE", returnUri);
		return "itgcms/user/login/ER_loginForm";
	}
	@RequestMapping(value = {"ER_loginAction.do"}, method = {RequestMethod.POST})
	public String loginActionJungle(@RequestParam Map<String, Object> params, ModelMap model) throws NoSuchAlgorithmException, IOException {
		MemberVO memberVO = new MemberVO();
		memberVO.setId(params.get("id")+"");
		memberVO.setPass(CommUtil.hexSha256(params.get("pwd")+""));
		MemberVO result =memberService.selectMember(memberVO);
		if(result == null) {
			model.addAttribute("message", "회원 정보가 없습니다.\\n\\n아이디와 비밀번호를 확인하세요");
			return "itgcms/user/login/NR_alertAndBack";
		}else{
			MemberBizBean bizBean = new MemberBizBean();
			/**/
			bizBean.setId(result.getId());
			bizBean.setMemTpCd("C".equals(result.getType())?"V013000002":"V013000001");
			model.addAttribute("dataBean", bizBean);
			return "itgcms/user/login/ER_loginAction";
		}

	}

	  public static boolean isEmpty(Object object) {

	        if (object == null) {
	            return true;
	        }

	        if (object instanceof String) {
	            String str = (String) object;
	            return str.length() == 0;
	        }

	        if (object instanceof Collection) {
	            Collection collection = (Collection) object;
	            return collection.size() == 0;
	        }

	        if (object.getClass().isArray()) {
	            try {
	                if (Array.getLength(object) == 0) {
	                    return true;
	                }
	            } catch (Exception e) {
	                // do nothing
	            }
	        }

	        return false;
	    }
	@ResponseBody
	@RequestMapping(value = "chkInfo.ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> chkInfo(@RequestParam Map<String, Object> params,
			HttpServletResponse response) throws IOException, SQLException, RuntimeException {
		Map<String, Object> map = new HashMap<String, Object>();
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			map.put("status", "NO1");
			map.put("msg", "로그인이 필요한 서비스입니다.");
			return map;
		}else{
			if ("kb".equals(params.get("whichOne"))) {
				String encryptUid = null;

				try {
					encryptUid = CommUtil.getUserMemId().replaceAll("[^\\da-zA-Z]", "");
				} catch (Exception var6) {
					;
				}
				map.put("encryptUid", encryptUid);
				map.put("status", "YES");
				return map;
			}else if ("ceo".equals(params.get("whichOne"))) {
				MemberExtVO memberVO = cominfoService.selectMemberInfo( new MemberVO() {
					@Override
					public String getId() {
						return CommUtil.getUserMemId();
					}
				});/* 관외기업도 들어갈수 있도록 수정
				if ("V007000004".equals(memberVO.getAreaCd())||memberVO.getAreaCd()==null||memberVO.getAreaCd()=="") {
					map.put("status", "NO2");
					map.put("msg", "성남시 관내 기업회원 및 개인회원에게만 제공되는 서비스입니다. 로그인 후 이용바랍니다");
					return map;
				}else{*/
					String str = CommUtil.getUserMemId();
					String result = "";

					try{
						result = AES256Cipher2.AES_Encode(str, "wwwsniporkrsnips");
					}catch(Exception e){
					}
					map.put("p_u", result);
					map.put("status", "YES");
					return map;
				/*}*/
			}else if ("clean".equals(params.get("whichOne"))) {
				if(!CustomUtil.checkMemberType(MemberType.Company)) {//개인
					map.put("status", "YES");
					return map;
				}else{
					map.put("status", "NO2");
					map.put("msg", "개인 회원만 이용 가능합니다.");
					return map;
				}
			}else{

				if(!CustomUtil.checkMemberType(MemberType.Company)) {//개인
					map.put("status", "NO2");
					map.put("msg", "관내 기업회원만 이용 가능합니다.");
					return map;
				}else{
					MemberExtVO memberVO = cominfoService.selectMemberInfo( new MemberVO() {
						@Override
						public String getId() {
							return CommUtil.getUserMemId();
						}
					});
					if ("V007000004".equals(memberVO.getAreaCd())||memberVO.getAreaCd()==null||memberVO.getAreaCd()=="") {
						map.put("status", "NO2");
						map.put("msg", "관내기업회원만 이용 가능합니다.");
						return map;
					}else{
						map.put("status", "YES");
						return map;
					}
				}
			}
		}
	}

}
