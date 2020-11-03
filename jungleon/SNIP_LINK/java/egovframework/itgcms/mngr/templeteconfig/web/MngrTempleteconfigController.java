package egovframework.itgcms.mngr.templeteconfig.web;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.itgcms.core.site.service.MngrSiteSearchVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.core.templeteconfig.service.TempleteconfigService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @파일명 : MngrTempleteconfigController.java
 * @파일정보 : 템플릿 설정 관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 4. 04. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class MngrTempleteconfigController {

	/** TempleteconfigService */
	@Resource(name = "templeteconfigService")
	private TempleteconfigService templeteconfigService;

	/** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	private static final Logger logger = LogManager.getLogger(MngrTempleteconfigController.class);

	/**
	 * 탬플릿 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/templeteconfig/templete_list.do")
	public String mngrTempleteconfigList(HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		/* S:사이트코드 설정*/
		String siteCode = CommUtil.getManagerSiteCode(request);
		if(CommUtil.empty(siteCode)) return CommUtil.doComplete(model, "", "관리 권한을 가진 사이트가 없습니다.", "history.back();");
		/* E:사이트코드 설정*/

		EgovMap paramMap = CommUtil.getParameterEMap(request);
		paramMap.put("siteCode", siteCode);

		List<?> resultList = templeteconfigService.selectMyTempleteconfigList(paramMap);
		int totCnt = templeteconfigService.myTempleteconfigListTotCnt(paramMap);

		MngrSiteSearchVO mngrSiteSearchVO = new MngrSiteSearchVO();
		mngrSiteSearchVO.setId(siteCode);
		MngrSiteVO mngrSiteVO =  mngrSiteService.getSiteView(mngrSiteSearchVO);

		model.addAttribute("mngrSiteVO", mngrSiteVO);
		model.addAttribute("siteList", mngrSiteService.selectMngrSiteList());
		model.addAttribute("resultList", resultList);
		model.addAttribute("listNo", totCnt);
		model.addAttribute("templeteResult", getTempleteList("hashmap"));

		return "itgcms/mngr/templeteconfig/templete_list";
	}

	/**
	 * 등록 페이지
	 * @param mngrProgramSearchVO
	 * @param model
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/templeteconfig/templete_input.do")
	public String mngrTempleteconfigRegist(HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {
		EgovMap searchVO = CommUtil.getParameterEMap(request);
		searchVO.put("act", "REGIST");
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("templeteList", getTempleteList("list"));

		return "itgcms/mngr/templeteconfig/templete_edit";
	}

	/**
	 * 수정/조회 페이지
	 * @param mngrProgramSearchVO
	 * @param model
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/templeteconfig/templete_edit.do")
	public String mngrTempleteconfigView(@RequestParam HashMap<String,String> map, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		EgovMap searchVO = new EgovMap();
		searchVO.putAll(map);
		searchVO.put("act", "UPDATE");

		EgovMap result = templeteconfigService.selectGetTempleteconfig(searchVO);

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("result", result);
		model.addAttribute("templeteList", getTempleteList("list"));

		return "itgcms/mngr/templeteconfig/templete_edit";
	}

	/**
	 * 등록 페이지의 저장 처리
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @param request
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/templeteconfig/templete_input_proc.do")
	public String insertTempleteconfigProc(HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		EgovMap paramVO = CommUtil.getParameterEMap(request);

		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  paramVO.get("tempName")  , "")	)) return CommUtil.doComplete(model, "오류", "템플릿 이름을 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("tempCode")  , "")	)) return CommUtil.doComplete(model, "오류", "템플릿 코드를 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("recentBdCnt")  , "")	)) return CommUtil.doComplete(model, "오류", "최근글 영역 개수를 입력 해 주세요.", "history.back();");

		paramVO.put("regmemid", CommUtil.getMngrMemId());
		templeteconfigService.insertTempleteconfigProc(paramVO);

		//return CommUtil.doComplete(model, "완료", "등록 되었습니다.", "location.href='templete_list.do'");
		return CommUtil.doCompleteUrl(model, "완료", "등록 되었습니다.", "templete_list.do");
	}

	/**
	 * 수정페이지 저장 처리
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/templeteconfig/templete_edit_proc.do")
	public String updateTempleteconfigProc(HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		EgovMap paramVO = CommUtil.getParameterEMap(request);

		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  paramVO.get("tempIdx")  , "")	)) return CommUtil.doComplete(model, "오류", "템플릿 정보가 올바르지 않습니다.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("tempName")  , "")	)) return CommUtil.doComplete(model, "오류", "템플릿 이름을 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("tempCode")  , "")	)) return CommUtil.doComplete(model, "오류", "템플릿 코드를 입력 해 주세요.", "history.back();");
		if("".equals( CommUtil.isNull(  paramVO.get("recentBdCnt")  , "")	)) return CommUtil.doComplete(model, "오류", "최근글 영역 개수를 입력 해 주세요.", "history.back();");

		paramVO.put("updmemid", CommUtil.getMngrMemId());
		templeteconfigService.updateTempleteconfigProc(paramVO);

		//return CommUtil.doComplete(model, "완료", "수정 되었습니다.", "location.href='templete_list.do'");
		return CommUtil.doCompleteUrl(model, "완료", "수정 되었습니다.", "templete_list.do");
	}

	/**
	 * 삭제페이지 저장 처리
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/_mngr_/templeteconfig/templete_delete_proc.do")
//	public String deleteTempleteconfigProc(@RequestParam HashMap<String,String> map, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {
	public String deleteTempleteconfigProc(HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

/*		EgovMap paramVO = new EgovMap();
		paramVO.putAll(map);*/
		EgovMap paramVO = CommUtil.getParameterEMap(request);

		//입력 값 유효 체크
		if("".equals( CommUtil.isNull(  paramVO.get("tempIdx")  , "")	)) return CommUtil.doComplete(model, "오류", "템플릿 정보가 올바르지 않습니다.", "history.back();");

		paramVO.put("delmemid", CommUtil.getMngrMemId());
		templeteconfigService.deleteTempleteconfigProc(paramVO);

		//return CommUtil.doComplete(model, "완료", "삭제 되었습니다.", "location.href='templete_list.do'");
		return CommUtil.doCompleteUrl(model, "완료", "삭제 되었습니다.", "templete_list.do");
	}

	public Object getTempleteList(String returnType){
		String path = CommUtil.getContextRoot() + System.getProperty("file.separator")
				+ "resource"  + System.getProperty("file.separator")
				+ "templete";
		path = CommUtil.getFilePathReplace(path);
		java.io.File f = new java.io.File(path);
		java.io.File []folder = f.listFiles();

		List<HashMap<String, String>> templeteList = new java.util.ArrayList<HashMap<String,String>>();
		HashMap<String, String> result = new HashMap<String, String>();

		int count = 0;
		for(int i = 0;i < folder.length; i++){
			if(folder[i].isDirectory()){
				String tmpPath = path + System.getProperty("file.separator") + folder[i].getName();
				tmpPath = CommUtil.getFilePathReplace(tmpPath);
				java.io.File skinFile[] =( new java.io.File(tmpPath)).listFiles();
				boolean hasConfigFile = false;
				HashMap<String, String> tmpmap = new HashMap<String, String>();
				for(int j = 0; j < skinFile.length; j++){
					String filename = skinFile[j].getName();
					if(filename.indexOf("config.cfg") != -1){
						hasConfigFile = true;
						FileReader filereader = null;
						BufferedReader bufReader = null;
						try {
							filereader = new FileReader(skinFile[j]);
							bufReader = new BufferedReader(filereader);
							String line = "";
				            while((line = bufReader.readLine()) != null){
				                //System.out.println(line);
				                line = line.trim();
				                if(!line.startsWith("#") && line.split("=").length == 2) tmpmap.put(line.split("=")[0].trim(), line.split("=")[1].trim());
				            }
				            bufReader.close();
						} catch (FileNotFoundException e) {
							logger.error("getTempleteList FileNotFoundException 발생");
							if(filereader != null)
								try {
									filereader.close();
								} catch (IOException e1) {
									logger.error("getTempleteList filereader close IOException 발생");
								}
						} catch (IOException e) {
							logger.error("getTempleteList IOException 발생");
							if(bufReader != null)
								try {
									bufReader.close();
								} catch (IOException e1) {
									logger.error("getTempleteList bufReader close IOException 발생");
								}
						}
					}
				}
				if(hasConfigFile){
					// resulstType List
					HashMap<String, String> hm = new HashMap<String, String>();
					hm.putAll(tmpmap);
					hm.put("code", folder[i].getName());
					templeteList.add(count, hm);

					// resultType hashmap
					result.put(folder[i].getName(), tmpmap.get("title"));
				}
			}
		}

		return ("list".equals(returnType)? templeteList : result);
	}
}