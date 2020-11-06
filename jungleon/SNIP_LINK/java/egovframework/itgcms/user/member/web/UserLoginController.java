package egovframework.itgcms.user.member.web;

import java.io.IOException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.sql.SQLException;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import egovframework.itgcms.core.member.service.MemberService;
import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.itgcms.core.menu.service.MngrMenuService;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.module.real.service.RealDbService;
import egovframework.itgcms.project.cominfo.service.CominfoService;
import egovframework.itgcms.util.AES256Cipher2;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;

/**
 * @파일명 : UserLoginController.java
 * @파일정보 : 회원 로그인 관리
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
public class UserLoginController {

	/** MngrMenuService */
	@Resource(name = "mngrMenuService")
	private MngrMenuService mngrMenuService;

	/** MemberService */
	@Resource(name = "memberService")
	private MemberService memberService;

	@Autowired
	private HttpServletRequest request;

	@Autowired
	private HttpSession session;
	@Resource(name = "realDbService")
	private RealDbService realDbService;
	@Resource(name = "cominfoService")
	private CominfoService cominfoService;

	private static final Logger logger = LogManager.getLogger(UserLoginController.class);

	@RequestMapping(value = "{menuCode}_userlogin.do")
	public String webLogin(@PathVariable String root, ModelMap model, HttpServletResponse response) throws IOException, SQLException, RuntimeException, ParseException {

		String code = CommUtil.isNull(request.getParameter("code"),"");

		if(CommUtil.empty(code)) code = "in";

		String savedId = "";
		for (Cookie ck : request.getCookies()){
			if ("cms_userId".equals(ck.getName())) {
				savedId = ck.getValue();
			}
		}
		model.addAttribute("ckUserId", savedId);

		if (!CommUtil.isExistSite(root)) {
			return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
		}

		if ("out".equals(code)) {
			session.setAttribute("userSessionVO", null);
			session.setAttribute("hash", null);
			return CommUtil.doComplete(model, "로그아웃", "정상적으로 로그아웃 되었습니다. 이용해 주셔서 감사합니다.", "location.href='/"+root+"/main/index.do'");
		} else {
			if (!"".equals(CommUtil.isNull(CommUtil.getUserMemId(), ""))) {
				return CommUtil.doComplete(model, "오류", "이미 로그인 되어 있습니다.", "location.href='/"+root+"/main/index.do'");
			}else{

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
			}
		}
		return "itgcms/user/login/log" + code ;
	}

	 public static String replace(String s, char sub, char with) {
	        if (s == null) {
	            return s;
	        }
	        if (sub == with) return s;

	        char[] str = s.toCharArray();
	        for ( int i = 0 ; i < str.length ; i++ ) {
	            if (str[i] == sub) {
	                str[i] = with;
	            }
	        }
	        return new String(str);
	    }
	 public static String replace(String text, String repl, String with) {
	        return replace(text, repl, with, -1);
	    }
	 public static String replace(String text, String repl, String with, int max) {
	        if (text == null || repl == null || with == null || repl.length() == 0 || max == 0) {
	            return text;
	        }
	        if (repl.equals(with)) return text;

	        StringBuffer buf = new StringBuffer(text.length());
	        int start = 0, end = 0;
	        while ( (end = text.indexOf(repl, start)) != -1 ) {
	            buf.append(text.substring(start, end)).append(with);
	            start = end + repl.length();

	            if (--max == 0) {
	                break;
	            }
	        }
	        buf.append(text.substring(start));
	        return buf.toString();
	    }

	/**
	 * 로그인처리
	 * @param memberVO
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "{menuCode}_loginProc.ajax", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> webLoginProc(@PathVariable String root, @ModelAttribute("searchVO") MemberVO memberVO, HttpServletRequest request, HttpServletResponse response) throws SQLException {

		SiteconfigVO siteConf =  CommUtil.getSiteconfigVO(root);
		String possible="Y";
	     /* RSA 복화화 */
        PrivateKey privateKey = (PrivateKey) session.getAttribute("_RSA_KEY_");  //로그인전에 세션에 저장된 개인키를 가져온다.
        if (privateKey == null) {
        	possible="N";
		}
        try
        {
            //암호화처리된 사용자계정정보를 복호화 처리한다.
        	memberVO.setId( CustomUtil.RSAdecrypt( privateKey, memberVO.getId() ) );
            memberVO.setPass( CustomUtil.RSAdecrypt(privateKey, memberVO.getPass()) );
        }catch(Exception e){
        }
		HashMap<String, Object> json = memberService.updateMemberLogin(memberVO, root, siteConf);
		try {
			String url = request.getRequestURL().toString();
			memberVO.setSchOpt5(url);
			realDbService.updatePassAsis2Tobe(memberVO);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String result = "";
    	try{
    		String str=memberVO.getId()+"---"+memberVO.getPass();
    		result = AES256Cipher2.AES_Encode(str, "RiNo!@3ey^160909");
    		result = replace(result, "+", "8B24C5B9F1174CA885DC28DF4820FB41");
    		json.put("hash", result);
    		session.setAttribute("hash", result);
    	}catch(Exception e){
        }

		if ("1".equals(request.getParameter("userId_cookie"))) {
			if ("2".equals(json.get("result"))) {
				Cookie userIdCk = new Cookie("cms_userId", memberVO.getId());
				userIdCk.setPath("/");
				userIdCk.setMaxAge(60*60*24*10);
				response.addCookie(userIdCk);
			}
		} else {
			Cookie userIdCk = new Cookie("cms_userId", memberVO.getId());
			userIdCk.setPath("/");
			userIdCk.setMaxAge(60*60*24*10);
			response.addCookie(userIdCk);
		}

		//TODO result 1이면 성공. type정보 세션 저장.
		if("2".equals(json.get("result"))) {
			HashMap<String, Object> memComInfo = cominfoService.selectMemberJoinCompanyInfo(memberVO.getId());

			if(memComInfo != null) {
				session.setAttribute("busiRegNo", memComInfo.get("BUSIREGNO"));
				session.setAttribute("memType", memComInfo.get("MEMTYPE"));

			}
		}
		return json;


	}

}
