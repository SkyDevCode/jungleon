package egovframework.itgcms.project.sosqna.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MemberType;
import egovframework.itgcms.core.member.service.MemberExtVO;
import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.itgcms.project.cominfo.service.CominfoService;
import egovframework.itgcms.project.sosqna.service.SOSQnaService;
import egovframework.itgcms.project.sosqna.service.SOSQnaVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class SOSQnaController {

	@Resource(name="sosQnaService")
	SOSQnaService sosQnaService;
	@Resource(name="cominfoService")
	private CominfoService cominfoService;
	/********************** S:사용자 **********************/
    @RequestMapping(value = "/{siteCode}/module/{menuCode}_SOSQnaList.do")
	public String selectSOSQnaList_with_login(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") DefaultVO searchVO, HttpSession session) throws IOException, SQLException {

    	//메뉴 접근 권한 확인.
    	if(CommUtil.getUserSessionVO() == null){
    		return CommUtil.doComplete(model, "오류", "로그인하신 후 이용하실 수 있습니다.", "location.href='/" + siteCode + "/contents/snipLogin.do';");
    	}
    	//기업 회원만 이용가능함.
		if(!CustomUtil.checkMemberType(MemberType.Company)) {
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
		}
		if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");


		searchVO.setSchMemid(CommUtil.getUserMemId());
		if("list".equals(searchVO.getSchM())) {

			/** paging setting */
 			int totCnt = sosQnaService.selectSOSQnaListTotCnt(searchVO);

 			// pagesize, viewcount => searchVO에 설정
 			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

 			List<SOSQnaVO> resultList = sosQnaService.selectSOSQnaList(searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링


			model.addAttribute("resultList", resultList);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/sosqna/userSOSQnaList";
		} else if("view".equals(searchVO.getSchM())) {


			SOSQnaVO result = sosQnaService.selectSOSQnaView(searchVO);

			// 이전글/다음
			List<SOSQnaVO> prevnextVO = sosQnaService.selectSOSQnaViewPrevNext(searchVO);

			List<EgovMap> userFileList = new ArrayList<EgovMap>();
			List<EgovMap> mgrFileList = new ArrayList<EgovMap>();
			//사용자 등록 첨부
			int fileId = !"".equals(CommUtil.isNull(result.getUserFileSeq(), ""))?Integer.parseInt(result.getUserFileSeq()) : -1;
			if(fileId> 0 ) userFileList = sosQnaService.selectCoFileList(result.getUserFileSeq());
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
			// 관리자 등록 첨부
//			fileId = !"".equals(CommUtil.isNull(result.getMgrFileSeq(), ""))?Integer.parseInt(result.getMgrFileSeq()) : -1;
//			if(fileId> 0 ) mgrFileList = sosQnaService.selectCoFileList(result.getMgrFileSeq());

			model.addAttribute("result", result);
			model.addAttribute("userFileList", userFileList);
			model.addAttribute("mgrFileList", mgrFileList);
			model.addAttribute("prevnextVO", prevnextVO);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/sosqna/userSOSQnaView";
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
	}
    @RequestMapping(value = "/{siteCode}/module/{menuCode}_CleanList.do")
    public String CleanList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
    		@ModelAttribute("searchVO") DefaultVO searchVO, HttpSession session) throws IOException, SQLException {

    	/*//메뉴 접근 권한 확인.
    	if(CommUtil.getUserSessionVO() == null){
    		return CommUtil.doComplete(model, "오류", "로그인하신 후 이용하실 수 있습니다.", "location.href='/" + siteCode + "/main/index.do';");
    	}
    	//기업 회원만 이용가능함.
    	if(!CustomUtil.checkMemberType(MemberType.Company)) {
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
    	}
    	if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");*/



		/** paging setting */
    	if(!CustomUtil.checkMemberType(MemberType.Company)) {//개인

			model.addAttribute("status", "YES");
		}else{
			model.addAttribute("status", "NO2");
			model.addAttribute("msg", "개인 회원만 이용 가능합니다.");
		}
		return "itgcms/project/clean/userCleanView";

    }
}
