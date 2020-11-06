package egovframework.itgcms.user.member.web;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.core.ipCountry.service.IpCountryService;
import egovframework.itgcms.core.joinformconfig.service.MngrJoinFormConfigSearchVO;
import egovframework.itgcms.core.joinformconfig.service.MngrJoinFormConfigService;
import egovframework.itgcms.core.member.service.MemberExtVO;
import egovframework.itgcms.core.member.service.MemberService;
import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.project.cominfo.service.CominfoService;
import egovframework.itgcms.project.cominfo.service.CominfoVO;
import egovframework.itgcms.util.CommUtil;

@Controller
@RequestMapping("/{root}/module/*")
public class MemberInfoController {

	@Resource(name="memberService")
	private MemberService memberService;

	@Resource(name="joinFormConfigService")
	private MngrJoinFormConfigService joinFormConfigService;

	@Resource(name="mngrCodeService")
	private MngrCodeService mngrCodeService;

	@Resource(name="ipCountryService")
	private IpCountryService ipCountryService;

	@Resource(name="cominfoService")
	private CominfoService cominfoService;

	@Resource
	private JavaMailSender javaMailSender;


	private static final Logger logger = LogManager.getLogger(MemberInfoController.class);

	@RequestMapping(value="{menuCode}_memberinfoMain.do")
	public String memberInfoPage(@PathVariable("root") String root, ModelMap model, HttpServletRequest request,HttpSession session, @ModelAttribute("memberInfo") MemberVO memberInfo) throws IOException, SQLException, RuntimeException{

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(root);
		String loginPageUrl = "/"+root+"/contents/"+siteconfigVO.getLoginMenuCode()+".do"; //TODO 로그인페이지 수정

		if (!CommUtil.isExistSite(root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		String userId = CommUtil.getUserMemId();
		if (userId == null || "".equals(userId)) return CommUtil.doComplete(model, "오류", "로그인 되어 있지 않습니다. 로그인 한 후 시도해주세요", "location.href='"+loginPageUrl+"';");

		memberInfo.setId(userId);
		memberInfo = memberService.selectMember(memberInfo);

		MngrCodeVO codeVO = new  MngrCodeVO();

		codeVO.setSchCode("career1");
		List<MngrCodeVO> career1 = mngrCodeService.getMngrCodeList(codeVO);

		codeVO.setSchCode("career2");
		List<MngrCodeVO> career2 = mngrCodeService.getMngrCodeList(codeVO);

		model.addAttribute("groupCode", career1);
		model.addAttribute("codeCode", career2);
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("joinForm", joinFormConfigService.mngrGetJoinFormBySiteCode(root, null));

		return "itgcms/user/member/memberInfo";
	}


	@RequestMapping(value="{menuCode}_update_memberinfo.do", method=RequestMethod.POST)
	public String modifyMemberInfoProc(@PathVariable("root") String root, ModelMap model, HttpServletRequest request, @ModelAttribute("memberVO") MemberVO memberVO) throws IOException, SQLException, RuntimeException{

		if ("".equals(CommUtil.isNull(memberVO.getId(), ""))) {
			return CommUtil.doComplete(model, "오류", "로그인 정보가 정확하지 않습니다. \\n로그아웃을 한 후 다시 시도해주세요.", "history.back();");
		}

		memberVO.setRegSiteCode(root);
		// 아이디, 이름, 비밀번호, 비밀번호확인, 이메일, 부서

		MngrJoinFormConfigSearchVO joinForm = joinFormConfigService.mngrGetJoinFormBySiteCode(root, null);

		if ("1".equals(joinForm.getPhone())) {
			if ("".equals(memberVO.getPhone1()) || "".equals(memberVO.getPhone2()) || "".equals(memberVO.getPhone3())) {
				return CommUtil.doComplete(model, "오류", "전화번호는 필수 입력사항 입니다.", "history.back();");
			}
		}
		memberVO.setPhone(memberVO.getPhone1().concat("-").concat(memberVO.getPhone2()).concat("-").concat(memberVO.getPhone3()));


		if ("1".equals(joinForm.getMobile())) {
			if ("".equals(memberVO.getMobile1()) || "".equals(memberVO.getMobile2()) || "".equals(memberVO.getMobile3())) {
				return CommUtil.doComplete(model, "오류", "휴대폰 번호는 필수 입력사항 입니다.", "history.back();");
			}
		}
		memberVO.setMobile(memberVO.getMobile1().concat("-").concat(memberVO.getMobile2()).concat("-").concat(memberVO.getMobile3()));

		if ("1".equals(joinForm.getEmail())) {
			if ("".equals(memberVO.getEmail1()) || "".equals(memberVO.getEmail2())) {
				return CommUtil.doComplete(model, "오류", "이메일은 필수 입력사항 입니다.", "history.back();");
			}
		}
		memberVO.setEmail(memberVO.getEmail1().concat("@").concat(memberVO.getEmail2()));


		if ("1".equals(joinForm.getAddress())) {
			if (!"".equals(memberVO.getNewPost())) {
				if ("".equals(memberVO.getNewAddr1()) || "".equals(memberVO.getNewAddr2())) {
					return CommUtil.doComplete(model, "오류", "주소는 필수 입력사항 입니다.", "history.back();");
				}
			} else if (!"".equals(memberVO.getOldPost())) {
				if ("".equals(memberVO.getOldAddr1()) || "".equals(memberVO.getOldAddr2())) {
					return CommUtil.doComplete(model, "오류", "주소는 필수 입력사항 입니다.", "history.back();");
				}
			} else {
				return CommUtil.doComplete(model, "오류", "주소는 필수 입력사항 입니다.", "history.back();");
			}
		}


		if ("1".equals(memberVO.getFax())) {
			if ("".equals(memberVO.getFax1()) || "".equals(memberVO.getFax2()) || "".equals(memberVO.getFax3())) {
				return CommUtil.doComplete(model, "오류", "팩스는 필수 입력사항 입니다.", "history.back();");
			}
		}
		memberVO.setFax(memberVO.getFax1().concat("-").concat(memberVO.getFax2()).concat("-").concat(memberVO.getFax3()));

		if ("".equals(memberVO.getPosition())) {
			return CommUtil.doComplete(model, "오류", "직급은 필수 입력사항 입니다.", "history.back();");
		}


		if ("".equals(CommUtil.isNull(memberVO.getSmsYn(), ""))) {
			memberVO.setSmsYn("N");
		}
		if ("".equals(CommUtil.isNull(memberVO.getEmailYn(), ""))) {
			memberVO.setEmailYn("N");
		}
		if ("".equals(CommUtil.isNull(memberVO.getInfoOpenYn(), ""))) {
			memberVO.setInfoOpenYn("N");
		}

		String ip = request.getRemoteAddr();
		memberVO.setUpdIp(ip);
		memberVO.setUpdId(memberVO.getId());
		memberService.updateMember(memberVO);
		return CommUtil.doComplete(model, "성공", "사용자 정보를 성공적으로 수정하였습니다.", "location.href ='/"+root+"/contents/"+root+"MyInfo.do';");
	}



	@RequestMapping(value="{menuCode}_passChange.do")
	public String memberPasswordPage(@PathVariable("root") String root, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException{

		String loginPageUrl = "/"+root+"/contents/"+root+"Login.do"; //TODO 로그인페이지 수정

		if (!CommUtil.isExistSite(root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");

		String userId = CommUtil.getUserMemId();
		if (userId == null || "".equals(userId)) return CommUtil.doComplete(model, "오류", "로그인 되어 있지 않습니다. 로그인 한 후 시도해주세요", "location.href='"+loginPageUrl+"';");


		model.addAttribute("userId", userId);
		model.addAttribute("siteCode", root);

		return "itgcms/user/member/passwordMain";
	}



	@RequestMapping(value="{menuCode}_updatePassword.ajax")
	@ResponseBody
	public Map<String, String> updateMemberPassword(@PathVariable("root") String root, @RequestParam("curPass") String currentPass,
			@RequestParam("pass1") String pass1, @RequestParam("pass2") String pass2, @RequestParam("id") String id, HttpServletRequest request) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("code", "500");
		resultMap.put("msg", "알 수 없는 오류가 발생하였습니다.\n로그아웃 한 후 다시 시도해주세요.");
		resultMap.put("url", "");

		String sessionId = CommUtil.getUserMemId();

		if (sessionId == null || "".equals(sessionId) ||
				id == null || "".equals(id) ||
					!sessionId.equals(id)) {

			resultMap.put("code", "401");
			resultMap.put("msg", "접속 정보와 사용자 정보가 일치하지 않습니다. \n로그아웃 한 후 다시 시도해주세요.");
			resultMap.put("url", "/"+root+"/login/logout.do");

			return resultMap;
		}

 		MemberVO memberVO = new MemberVO();
		memberVO.setId(id);
		memberVO.setPass(CommUtil.hexSha256(currentPass));

		if(memberService.selectMember(memberVO) == null) {

			resultMap.put("code", "403");
			resultMap.put("msg", "현재 비밀번호가 틀렸습니다.");

			return resultMap;
		}

		if (!pass1.equals(pass2)) {

			resultMap.put("code", "403");
			resultMap.put("msg", "변경할 비밀번호와 비밀번호 확인이 동일하지 않습니다.");

			return resultMap;
		}

		if (currentPass.equals(pass1)) {
			resultMap.put("code", "403");
			resultMap.put("msg", "현재 비밀번호와 동일한 비밀번호로는 바꿀 수 없습니다.");

			return resultMap;
		}

		memberVO.setPass(CommUtil.hexSha256(pass1));
		memberVO.setUpdId(id);
		memberVO.setUpdIp(request.getRemoteAddr());
		if (memberService.updateMemberPassword(memberVO) == 1) {

			resultMap.put("code", "200");
			resultMap.put("msg", "비밀번호를 성공적으로 변경하였습니다.\n\n확인을 누르면 로그아웃 됩니다. 변경한 비밀번호로 다시 로그인해주세요.");

		}


		return resultMap;
	}


	@RequestMapping(value="{menuCode}_findMyInfo.do")
	public String findMemberInfoPage(HttpServletRequest request, @PathVariable("root") String root, ModelMap model) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException, EmailException{

		String returnPage = "itgcms/user/member/findMemberInfo";

		MemberExtVO member = new MemberExtVO();

		String sch =  CommUtil.isNull(request.getParameter("sch"), "");
		String siteCode = CommUtil.isNull(request.getParameter("siteCode"),"");
		if ("id".equals(sch)) {
			String memName = CommUtil.isNull(request.getParameter("name"), "");
			String comNm = CommUtil.isNull(request.getParameter("comNm"), "");
			String busiRegNo =  CommUtil.isNull(request.getParameter("busiRegNo"), "");
			String memEmail =  CommUtil.isNull(request.getParameter("email"), "");
			String type =  CommUtil.isNull(request.getParameter("idtype"), "");
			if("C".equals(type)) { //기업회원
				if ("".equals(comNm)) {
					return CommUtil.doComplete(model, "오류", "회사명을 입력하세요.", "location.href='/"+siteCode+"/contents/find.do'");
				}

				if ("".equals(busiRegNo)) {
					return CommUtil.doComplete(model, "오류", "사업자등록번호를 입력하세요.", "location.href='/"+siteCode+"/contents/find.do'");
				}
				CominfoVO cominfoVO = new CominfoVO();
				cominfoVO.setComNm(comNm);
				cominfoVO.setBusiRegNo(busiRegNo);

				member = (MemberExtVO)cominfoService.selectMember4FindID(cominfoVO);

				if (member == null) {
					return CommUtil.doComplete(model, "오류", "입력한 회사명과 사업자등록번호에 맞는 회원이 존재하지 않습니다.", "location.href='/"+siteCode+"/contents/find.do'");
				}

			} else {
				if ("".equals(memName)) {
					return CommUtil.doComplete(model, "오류", "이름을 입력하세요.", "location.href='/"+siteCode+"/contents/find.do'");
				}

				if ("".equals(memEmail)) {
					return CommUtil.doComplete(model, "오류", "이름을 입력하세요.", "location.href='/"+siteCode+"/contents/find.do'");
				}

				member = new MemberExtVO();
				member.setName(memName);
				member.setEmail(memEmail);
				member.setType(type);

				member = (MemberExtVO)memberService.selectMember(member);

				if (member == null) {
					return CommUtil.doComplete(model, "오류", "입력한 이름과 이메일에 맞는 회원이 존재하지 않습니다.", "location.href='/"+siteCode+"/contents/find.do'");
				}

			}

			if(!"mem_normal".equals(member.getStatus())) {
				MngrCodeVO codeVO = new MngrCodeVO();
				codeVO.setSchCode("memstatuscd");
				List<MngrCodeVO> codeList = mngrCodeService.getMngrCodeList(codeVO);
				for (MngrCodeVO code : codeList) {
					if (code.getCcode().equals(member.getStatus())) {
						return CommUtil.doComplete(model, "오류", code.getCname().concat(" 된 회원입니다."), "location.href='/"+siteCode+"/contents/find.do'");
					}
				}
			}

			model.addAttribute("memId", member.getId());
			model.addAttribute("regDt", member.getRegDt());
			returnPage = "itgcms/user/member/findIdResult";

		} else if("sendMail".equals(sch)) {
			String pwdAnswer =  CommUtil.isNull(request.getParameter("pwdAnswer"), "");
			String id =  CommUtil.isNull(request.getParameter("id"), "");
			String email = CommUtil.isNull(request.getParameter("email"), "");
			String url = request.getRequestURL().toString();

			member.setSchOpt1(url);
			member.setId(id);
			member.setPwdAnswer(pwdAnswer);

			member = (MemberExtVO)cominfoService.selectMemberChecPwdQuest(member);
			if(member == null) {
				return CommUtil.doComplete(model, "오류", "답변이 일치하지 않습니다.", "history.back()");
			}
			String pass = CommUtil.getRandomString(10);
			member.setPass(pass);

			//임시비밀번호로 비밀번호변경코드
			//memberService.updateMemberTemporaryPass(member);

			// 임시비밀번호로 비밀번호 변경
			cominfoService.updateMemberTemporaryPassword(member);

			// 메일수신 폼을 활용해  수정예정
			String msg = "";
			String domainURL = "https://www.snip.or.kr";

			msg += "<div class='mail_form' style='position:relative;width: 600px;margin:0 auto; border: 2px solid #696b73;background: #fff url(" + domainURL + "/resource/templete/cms1/src/img/sub/mail2_bg.png) no-repeat;background-size:100% 100%;letter-spacing: -1px;word-spacing: -1px;'>";
			msg += "<div class='mail_cont' style='padding-top:20px;padding-bottom: 50px;text-align: center;'>";
			msg += "<p></p>";
			msg += "<strong style='font-size:24px;'><span style='color:#5bb1e2;'>임시비밀번호</span>가 전달되었습니다.</strong>";
			msg += "<p style='font-size:18px;font-weight:700;'>";
			msg += "<p style='font-size:18px;font-weight:700;'><span>임시비밀번호</span> : <span>";
			msg += pass;
			msg += "</span></p>";
			msg += "<p style='margin-top:40px;font-size:15px;font-weight:700;padding:0 165px;'>※ 사용자 본인이 직접 요청하지 않으셨다면 하단의 연락처로 문의 주시기 바랍니다.</p>";
			msg += "<p style='position:absolute;left:50%;transform: translate(-50%);'>성남산업진흥원 031-782-3000</p></div>";
			msg += "</div>";

			//이메일 임시비밀번호전송 코드
 			try{
 				sendCertificationCode("[성남산업진흥원] 임시비밀번호 발송", msg, email);
			}catch(Exception e){
				return CommUtil.doComplete(model, "오류", "메일 전송시 오류가 발생되었습니다.", "history.back()");
			}

			returnPage = CommUtil.doComplete(model, "성공", email + " 이메일로 임시비밀번호가 발급되었습니다.", "location.href='/"+siteCode+"/contents/"+CommUtil.getSiteconfigVO(siteCode).getLoginMenuCode()+".do'");
		}

		model.addAttribute("siteCode", root);
		return returnPage;
	}
	@RequestMapping(value="{menuCode}_findPwd.do")
	public String findPwd(HttpServletRequest request, @PathVariable("root") String root, @PathVariable("menuCode") String menuCode, ModelMap model) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException, EmailException{

		String findId = request.getParameter("findId");
		String sch =  CommUtil.isNull(request.getParameter("sch"), "");
		String siteCode = CommUtil.isNull(request.getParameter("siteCode"),"");
		String memId =  CommUtil.isNull(request.getParameter("mem_id"), "");
		String comId =  CommUtil.isNull(request.getParameter("com_id"), "");
		String memName = CommUtil.isNull(request.getParameter("name"), "");
		String comNm = CommUtil.isNull(request.getParameter("comNm"), "");
		String busiRegNo =  CommUtil.isNull(request.getParameter("busiRegNo"), "");
		String memEmail =  CommUtil.isNull(request.getParameter("email"), "");
		String type =  CommUtil.isNull(request.getParameter("pwdtype"), "");

		model.addAttribute("findId", findId);
		String returnPage = "itgcms/user/member/findPwdStep1";
		if ("pass".equals(sch)) {
			MemberExtVO member = new MemberExtVO();

			if("C".equals(type)) { //기업회원

				if ("".equals(comId)) {
					return CommUtil.doComplete(model, "오류", "아이디를 입력하세요.", "history.back();");
				}
				if ("".equals(comNm)) {
					return CommUtil.doComplete(model, "오류", "회사명을 입력하세요.", "history.back();");
				}

				if ("".equals(busiRegNo)) {
					return CommUtil.doComplete(model, "오류", "사업자등록번호를 입력하세요.", "history.back();");
				}
				CominfoVO cominfoVO = new CominfoVO();
				cominfoVO.setId(comId);
				cominfoVO.setComNm(comNm);
				cominfoVO.setBusiRegNo(busiRegNo);

				member = (MemberExtVO)cominfoService.selectMember4FindID(cominfoVO);

				if (member == null) {
					return CommUtil.doComplete(model, "오류", "입력한 회사명과 사업자등록번호에 맞는 회원이 존재하지 않습니다.", "history.back();");
				}

			} else {
				if ("".equals(memId)) {
					return CommUtil.doComplete(model, "오류", "아이디를 입력하세요.", "history.back();");
				}
				if ("".equals(memName)) {
					return CommUtil.doComplete(model, "오류", "이름을 입력하세요.", "history.back();");
				}

				if ("".equals(memEmail)) {
					return CommUtil.doComplete(model, "오류", "이름을 입력하세요.", "history.back();");
				}

				member = new MemberExtVO();
				member.setName(memName);
				member.setEmail(memEmail);
				member.setId(memId);

				member = (MemberExtVO)memberService.selectMember(member);

				if (member == null) {
					return CommUtil.doComplete(model, "오류", "입력한 이름과 이메일, 아이디에 맞는 회원이 존재하지 않습니다.", "history.back();");
				}
			}
			MngrCodeVO mngrCodeVO= new MngrCodeVO();
			mngrCodeVO = new MngrCodeVO();
			mngrCodeVO.setSchCode("V015");//패스워드 질문
			model.addAttribute("pwdQuest", mngrCodeService.getMngrCodeList(mngrCodeVO));

			model.addAttribute("result", member);
			returnPage = "itgcms/user/member/findPwdResult";
		}
		return returnPage;
	}

	private void sendCertificationCode(String Info, String msg, String sendMailAddr) {

		MimeMessage mimeMessage = javaMailSender.createMimeMessage();

		try {
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
			mimeMessage.setContent(msg, "text/html;charset=utf-8");
			helper.setFrom("snip@snip.or.kr");
			helper.setTo(sendMailAddr);
			helper.setSubject(Info);
			javaMailSender.send(mimeMessage);

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
