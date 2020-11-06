package egovframework.itgcms.project.gonggo.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MemberType;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.core.code.service.impl.MngrCodeMapper;
import egovframework.itgcms.core.member.service.MemberExtVO;
import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.itgcms.project.cominfo.service.CominfoService;
import egovframework.itgcms.project.sosqna.service.SOSQnaService;
import egovframework.itgcms.project.sosqna.service.SOSQnaVO;
import egovframework.itgcms.user.member.service.GonggoReqService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class GonggoController {

	@Resource(name="gonggoReqService")
	GonggoReqService gonggoReqService;
	@Resource(name="sosQnaService")
	SOSQnaService sosQnaService;
	@Resource(name="cominfoService")
	private CominfoService cominfoService;
	@Resource(name = "mngrCodeMapper")
	private MngrCodeMapper mngrCodeMapper;
	/********************** S:사용자 **********************/
    @RequestMapping(value = "/{siteCode}/module/{menuCode}_GonggoList.do")
	public String GonggoList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") DefaultVO searchVO, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException, SQLException {

    	//메뉴 접근 권한 확인.
    /*	if(CommUtil.getUserSessionVO() == null){
    		return CommUtil.doComplete(model, "오류", "로그인하신 후 이용하실 수 있습니다.", "location.href='/" + siteCode + "/main/index.do';");
    	}*/
    	//기업 회원만 이용가능함.
		/*if(!CustomUtil.checkMemberType(MemberType.Company)) {
			return CommUtil.doComplete(model, "오류", "관내 기업회원만 이용 가능합니다", "location.href='/" + siteCode + "/main/index.do';");
		}else{
			MemberExtVO memberVO = cominfoService.selectMemberInfo( new MemberVO() {
				@Override
				public String getId() {
					return CommUtil.getUserMemId();
				}
			});
			if ("V007000004".equals(memberVO.getAreaCd())||memberVO.getAreaCd()==null||memberVO.getAreaCd()=="") {
				return CommUtil.doComplete(model, "오류", "관내 기업회원만 이용 가능합니다", "location.href='/" + siteCode + "/main/index.do';");
			}
		}*/
		if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");


		searchVO.setSchMemid(CommUtil.getUserMemId());
		if("list".equals(searchVO.getSchM())) {

			/** paging setting */
 			int totCnt = gonggoReqService.selectGoggoListTotCnt(searchVO);

 			// pagesize, viewcount => searchVO에 설정
 			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

 			List<EgovMap> resultList = gonggoReqService.selectGoggoList(searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링


			model.addAttribute("resultList", resultList);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/gonggo/userGonggoList";
		} else if("view".equals(searchVO.getSchM())) {

			gonggoReqService.gonggoViewCntIncrease(searchVO);
			EgovMap result = gonggoReqService.selectGoggoView(searchVO);
			List<EgovMap> prevnextVO = gonggoReqService.selectGonggoViewPrevNext(searchVO);

			List<EgovMap> userFileList = new ArrayList<EgovMap>();
			//사용자 등록 첨부
			int fileId = !"".equals(CommUtil.isNull(result.get("fileseq"), ""))?Integer.parseInt(result.get("fileseq")+"") : -1;
			if(fileId> 0 ) userFileList = sosQnaService.selectCoFileList(result.get("fileseq")+"");
			if (userFileList.size()>0) {
				for (int j = 0; j < userFileList.size(); j++) {
					EgovMap file = (EgovMap) userFileList.get(j);

					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
						path = path.substring(0, path.length()-1);
					}
					userFileList.get(j).put("path1", path+"/"+file.get("fileNm"));
					userFileList.get(j).put("path2", file.get("fileNm")+"."+file.get("extension"));
				}
			}
			model.addAttribute("result", result);
			model.addAttribute("prevnextVO", prevnextVO);
			model.addAttribute("userFileList", userFileList);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/gonggo/userGonggoView";
		}else if("login".equals(searchVO.getSchM())) {
			if(CommUtil.getUserSessionVO() == null){
	    		return CommUtil.doComplete(model, "오류", "로그인하신 후 이용하실 수 있습니다.", "location.href='/SNIP/contents/snipLogin.do';");
	    	}
			return "itgcms/project/gonggo/userGonggoView";
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
	}
    @RequestMapping(value = "/{siteCode}/module/{menuCode}_Gonggo{schOpt5}List.do")
    public String GonggoIngList(@PathVariable String siteCode, @PathVariable String menuCode,@PathVariable String schOpt5, ModelMap model,
    		@ModelAttribute("searchVO") DefaultVO searchVO, HttpSession session) throws IOException, SQLException {

    	if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");

    	searchVO.setSchOpt5(schOpt5);
    	searchVO.setEtc2("");
    	searchVO.setSchMemid(CommUtil.getUserMemId());
    	if("list".equals(searchVO.getSchM())) {
    		MngrCodeVO mngrCodeVO = new MngrCodeVO();
			mngrCodeVO.setSchCode("supportBig");
			model.addAttribute("codeList", mngrCodeMapper.selectMngrCodeList(mngrCodeVO));
			if (searchVO.getSchOpt4()!=null&&searchVO.getSchOpt4()!="") {
				if (!"s".equals(searchVO.getSchOpt4())) {
					searchVO.setSchOpt4(searchVO.getSchOpt4().substring(1,3));
				}else{
					searchVO.setSchOpt4("");
				}
			}
    		/** paging setting */
			int totCnt =0;
			if("end".equals(searchVO.getSchOpt5())){
				totCnt = gonggoReqService.selectGoggoListTotCnt2(searchVO)-gonggoReqService.selectGoggoListTotCnt(searchVO);
			}else if ("fdaegi".equals(searchVO.getSchOpt5())) {
				totCnt = gonggoReqService.selectGoggoListTotCnt3(searchVO);
			}else{
				totCnt = gonggoReqService.selectGoggoListTotCnt(searchVO);
			}

    		// pagesize, viewcount => searchVO에 설정
    		PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

    		List<EgovMap> resultList = gonggoReqService.selectGoggoList(searchVO);
    		model.addAttribute("paginationInfo", paginationInfo);
    		model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링


    		model.addAttribute("resultList", resultList);
    		model.addAttribute("searchVO", searchVO);
    		return "itgcms/project/gonggo/userGonggoIngEndList";
    	} else if("view".equals(searchVO.getSchM())) {
    		gonggoReqService.gonggoViewCntIncrease(searchVO);
    		EgovMap result = gonggoReqService.selectGoggoView(searchVO);
    		List<EgovMap> prevnextVO = gonggoReqService.selectGonggoViewPrevNext(searchVO);
    		List<EgovMap> userFileList = new ArrayList<EgovMap>();
    		//사용자 등록 첨부
    		int fileId = !"".equals(CommUtil.isNull(result.get("fileseq"), ""))?Integer.parseInt(result.get("fileseq")+"") : -1;
    		if(fileId> 0 ) userFileList = sosQnaService.selectCoFileList(result.get("fileseq")+"");
    		if (userFileList.size()>0) {
    			for (int j = 0; j < userFileList.size(); j++) {
    				EgovMap file = (EgovMap) userFileList.get(j);

    				String str2 = file.get("filePath")+"";
    				String[] strarr=str2.split("\\\\");
    				String path="";
    				for (int k = 1; k < strarr.length-1; k++) {
    					path+=strarr[k]+"/";
    				}
    				if (path.charAt(path.length()-1)=='/'){
    					path = path.substring(0, path.length()-1);
    				}
    				userFileList.get(j).put("path1", path+"/"+file.get("fileNm"));
    				userFileList.get(j).put("path2", file.get("fileNm")+"."+file.get("extension"));
    			}
    		}
    		model.addAttribute("result", result);
    		model.addAttribute("prevnextVO", prevnextVO);
    		model.addAttribute("userFileList", userFileList);
    		model.addAttribute("searchVO", searchVO);
    		return "itgcms/project/gonggo/userGonggoIngEndView";
    	}else if("login".equals(searchVO.getSchM())) {
    		if(CommUtil.getUserSessionVO() == null){
    			return CommUtil.doComplete(model, "오류", "로그인하신 후 이용하실 수 있습니다.", "location.href='/SNIP/contents/snipLogin.do';");
    		}
    		return "itgcms/project/gonggo/userGonggoView";
    	}
    	return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
    }
    @RequestMapping(value = "/{siteCode}/module/{menuCode}_Center{schOpt5}List.do")
    public String CenterIngList(@PathVariable String siteCode, @PathVariable String menuCode,@PathVariable String schOpt5, ModelMap model,
    		@ModelAttribute("searchVO") DefaultVO searchVO, HttpSession session) throws IOException, SQLException {

    	if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");

    	searchVO.setSchOpt5(schOpt5);
    	searchVO.setEtc2("center");
    	searchVO.setSchMemid(CommUtil.getUserMemId());
    	if("list".equals(searchVO.getSchM())) {
    		MngrCodeVO mngrCodeVO = new MngrCodeVO();
    		mngrCodeVO.setSchCode("centerCode");
    		List<MngrCodeVO> codeList= mngrCodeMapper.selectMngrCodeList(mngrCodeVO);
    		model.addAttribute("codeList",codeList);
    		if (searchVO.getSchOpt3()!=null&&searchVO.getSchOpt3()!="") {
    			for (MngrCodeVO mngrCodeVO2 : codeList) {
    				if (searchVO.getSchOpt3().equals(mngrCodeVO2.getCcode())) {
    					searchVO.setSchOpt3(mngrCodeVO2.getEtc1());
					}
				}
    		}else{
    			String chkidStr="";
    			for (MngrCodeVO mngrCodeVO2 : codeList) {
    				chkidStr+=mngrCodeVO2.getEtc1()+",";
				}
    			searchVO.setChkId(chkidStr.split(","));
    			searchVO.setSchOpt3("");
    		}
    		/** paging setting */
    		int totCnt =0;
			if("end".equals(searchVO.getSchOpt5())){
				totCnt = gonggoReqService.selectGoggoListTotCnt2(searchVO)-gonggoReqService.selectGoggoListTotCnt(searchVO);
			}else{
				totCnt = gonggoReqService.selectGoggoListTotCnt(searchVO);
			}

    		// pagesize, viewcount => searchVO에 설정
    		PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

    		List<EgovMap> resultList = gonggoReqService.selectGoggoList(searchVO);
    		model.addAttribute("paginationInfo", paginationInfo);
    		model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링


    		model.addAttribute("resultList", resultList);
    		model.addAttribute("searchVO", searchVO);
    		return "itgcms/project/gonggo/userCenterIngEndList";
    	} else if("view".equals(searchVO.getSchM())) {


    		gonggoReqService.gonggoViewCntIncrease(searchVO);
    		MngrCodeVO mngrCodeVO = new MngrCodeVO();
    		mngrCodeVO.setSchCode("centerCode");
    		List<MngrCodeVO> codeList= mngrCodeMapper.selectMngrCodeList(mngrCodeVO);
    		model.addAttribute("codeList",codeList);
    		if (searchVO.getSchOpt3()!=null&&searchVO.getSchOpt3()!="") {
    			for (MngrCodeVO mngrCodeVO2 : codeList) {
    				if (searchVO.getSchOpt3().equals(mngrCodeVO2.getCcode())) {
    					searchVO.setSchOpt3(mngrCodeVO2.getEtc1());
					}
				}
    		}else{
    			String chkidStr="";
    			for (MngrCodeVO mngrCodeVO2 : codeList) {
    				chkidStr+=mngrCodeVO2.getEtc1()+",";
				}
    			searchVO.setChkId(chkidStr.split(","));
    			searchVO.setSchOpt3("");
    		}
    		EgovMap result = gonggoReqService.selectGoggoView(searchVO);
    		List<EgovMap> prevnextVO = gonggoReqService.selectGonggoViewPrevNext(searchVO);
    		List<EgovMap> userFileList = new ArrayList<EgovMap>();
    		//사용자 등록 첨부
    		int fileId = !"".equals(CommUtil.isNull(result.get("fileseq"), ""))?Integer.parseInt(result.get("fileseq")+"") : -1;
    		if(fileId> 0 ) userFileList = sosQnaService.selectCoFileList(result.get("fileseq")+"");
    		if (userFileList.size()>0) {
    			for (int j = 0; j < userFileList.size(); j++) {
    				EgovMap file = (EgovMap) userFileList.get(j);

    				String str2 = file.get("filePath")+"";
    				String[] strarr=str2.split("\\\\");
    				String path="";
    				for (int k = 1; k < strarr.length-1; k++) {
    					path+=strarr[k]+"/";
    				}
    				if (path.charAt(path.length()-1)=='/'){
    					path = path.substring(0, path.length()-1);
    				}
    				userFileList.get(j).put("path1", path+"/"+file.get("fileNm"));
    				userFileList.get(j).put("path2", file.get("fileNm")+"."+file.get("extension"));
    			}
    		}
    		model.addAttribute("result", result);
    		model.addAttribute("prevnextVO", prevnextVO);
    		model.addAttribute("userFileList", userFileList);
    		model.addAttribute("searchVO", searchVO);
    		return "itgcms/project/gonggo/userGonggoIngEndView";
    	}else if("login".equals(searchVO.getSchM())) {
    		if(CommUtil.getUserSessionVO() == null){
    			return CommUtil.doComplete(model, "오류", "로그인하신 후 이용하실 수 있습니다.", "location.href='/SNIP/contents/snipLogin.do';");
    		}
    		return "itgcms/project/gonggo/userCenterView";
    	}
    	return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
    }
}
