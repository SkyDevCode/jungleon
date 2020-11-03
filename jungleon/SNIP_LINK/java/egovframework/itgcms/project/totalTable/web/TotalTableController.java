package egovframework.itgcms.project.totalTable.web;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.EmailException;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.project.totalTable.service.TotalTableService;
import egovframework.itgcms.project.totalTable.service.TotalTbEnum.TOTALTB_GRSTEP;
import egovframework.itgcms.project.totalTable.service.TotalTbSearchVO;
import egovframework.itgcms.project.totalTable.service.TotalTbVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class TotalTableController {

	@Autowired
	TotalTableService totalTableService;

	@Autowired
	MngrCodeService mngrCodeService;


    /********************** S:관리자 **********************/
	@RequestMapping(value="/_mngr_/module/{menuCode}_list_totalTb.do")
	public String selectMngrTotalTbList(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") TotalTbSearchVO searchVO) throws IOException, SQLException{

		int totCnt = totalTableService.selectTotalTbListTotCnt(searchVO);

		PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

		List<TotalTbVO> resultList = totalTableService.selectTotalTbList(searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", searchVO);

		return "itgcms/project/totaltable/mngrTotalTbList";
	}


	/**
	 * 등록 페이지 조회
	 */
	@RequestMapping(value = "/_mngr_/module/{menuCode}_regist_totalTb.do")
	public String selectMngrTotalTbRegist(
						@PathVariable String menuCode,
						@ModelAttribute("searchVO") TotalTbSearchVO searchVO,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException, ParseException  {
		searchVO.setAct("regist");
		MngrCodeVO mngrCodeVO = new MngrCodeVO();
		mngrCodeVO.setSchCode("section01");
		model.addAttribute("gpNameCodeList", mngrCodeService.getMngrCodeList(mngrCodeVO));
		mngrCodeVO.setSchCode("totalgroup");
		model.addAttribute("cgNameCodeList", mngrCodeService.getMngrCodeList(mngrCodeVO));
		model.addAttribute("grstep", TOTALTB_GRSTEP.values());
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("menuDepth1List", totalTableService.selectMenuSubListByPcode("SNIP"));

//   		return "itgcms/project/totaltable/mngrTotalTbRegist"; //등록/수정페이지 공통으로 사용
   		return "itgcms/project/totaltable/mngrTotalTbView";

	}


	/**
	 * 등록
	 */
	@RequestMapping(value = "/_mngr_/module/{menuCode}_proc_totalTb.do")
	public String mngrTotalTbProc (
						@PathVariable String menuCode,
						@ModelAttribute("searchVO") TotalTbSearchVO searchVO,
						@ModelAttribute("totalTbVO") TotalTbVO totalTbVO,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws SQLException {

		String userId = "";
		userId = (CommUtil.getMngrSessionVO() == null)? "" : CommUtil.getMngrSessionVO().getId();
		totalTbVO.setRegid(userId);
		String bsIdx = totalTableService.insertTotalTbData(totalTbVO);
		if(bsIdx != null && !"".equals(bsIdx)) {
			String returnScript =  "location.href='/_mngr_/module/" + menuCode + "_list_totalTb.do'";

			return CommUtil.doComplete(model, "완료", "등록이 완료 되었습니다.",returnScript);
		} else {

			return CommUtil.doComplete(model, "오류", "등록 중 오류가 발생했습니다.", "history.back();");
		}
	}
	/**
	 * 조회
	 */
	@RequestMapping(value = "/_mngr_/module/{menuCode}_view_totalTb.do")
	public String mngrTotalTbView (
						@PathVariable String menuCode,
						@ModelAttribute("searchVO") TotalTbSearchVO searchVO,
						@ModelAttribute("totalTbVO") TotalTbVO totalTbVO,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws SQLException {
		searchVO.setAct("update");
		TotalTbVO result = totalTableService.selectTotalTbView(searchVO);
		if(result == null) {

			return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
		}

		MngrCodeVO mngrCodeVO = new MngrCodeVO();

		try {
			mngrCodeVO.setSchCode("section01");
			model.addAttribute("gpNameCodeList", mngrCodeService.getMngrCodeList(mngrCodeVO));
			mngrCodeVO.setSchCode("totalgroup");
			model.addAttribute("cgNameCodeList", mngrCodeService.getMngrCodeList(mngrCodeVO));
		} catch (IOException e) {

			e.printStackTrace();
		}

		model.addAttribute("grstep", TOTALTB_GRSTEP.values());
		model.addAttribute("result", result);
		model.addAttribute("searchVO", searchVO);

		model.addAttribute("menuDepth1List", totalTableService.selectMenuSubListByPcode("SNIP"));

		return "itgcms/project/totaltable/mngrTotalTbView";

	}



	/**
	 * 수정
	 */
	@RequestMapping(value = "/_mngr_/module/{menuCode}_update_totalTb.do")
	public String mngrTotalTbUpdate (
						@PathVariable String menuCode,
						@ModelAttribute("searchVO") TotalTbSearchVO searchVO,
						@ModelAttribute("totalTbVO") TotalTbVO totalTbVO,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws SQLException {

		totalTbVO.setUpdid(CommUtil.getMngrMemId());
		int result = totalTableService.updateTotalTbView(totalTbVO);

		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "수정 내용이 없습니다.", "history.back();");
		}
		String query = searchVO.getQuery();
		return CommUtil.doComplete(model, "성공", "정상적으로 수정처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_view_totalTb.do?schId=" + totalTbVO.getBsIdx() + "&"+query+"'");

	}



	/**
	 * 삭제
	 */
	@RequestMapping(value = "/_mngr_/module/{menuCode}_delete_totalTb.do")
	public String mngrTotalTbDelete (
						@PathVariable String menuCode,
						@ModelAttribute("searchVO") TotalTbSearchVO searchVO,
						@ModelAttribute("totalTbVO") TotalTbVO totalTbVO,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws SQLException {


		totalTbVO.setDelid(CommUtil.getMngrMemId());
		int result = totalTableService.deleteTotalTbView(totalTbVO);

		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "수정 내용이 없습니다.", "history.back();");
		}

		return CommUtil.doComplete(model, "성공", "정상적으로 삭제처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_list_totalTb.do?" + "'");

	}

	/**
	 * 삭제
	 */

	@RequestMapping(value = "/_mngr_/module/{menuCode}_multiDelete_totalTb.do")
	public String mngrTotalTbMulriDelete (
						@PathVariable String menuCode,
						@ModelAttribute("searchVO") TotalTbSearchVO searchVO,
						@ModelAttribute("totalTbVO") TotalTbVO totalTbVO,
						ModelMap model,
						HttpServletRequest request,
						HttpServletResponse response
						) throws SQLException {

		if(searchVO.getChkId() == null || searchVO.getChkId().length == 0) {
			return CommUtil.doComplete(model, "오류", "삭제할 게시물을 선택해 주세요.", "history.back();");
		}

		int result = totalTableService.deleteTotalTbMulti(searchVO);

		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "삭제중 오류가 발생했습니다 .확인 후 다시 시도해 주세요.", "history.back();");
		}


		return CommUtil.doComplete(model, "성공", "정상적으로 삭제처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_list_totalTb.do?" + "'");

	}

	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrTotalTbListExcelDown.do")
	public ModelAndView selectMngrTotalTbListExceDown(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") TotalTbSearchVO searchVO, HttpServletRequest request) throws IOException, SQLException{

		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);

		searchVO.setExcelDown("Y");
		List<TotalTbVO> resultList = totalTableService.selectTotalTbList(searchVO);

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dataList", resultList);

		//엑셀 템플릿에 넘겨줄 데이타
		mav.addObject("data", paramMap);

		//다운로드에 사용되어질 엑셀파일 템플릿
		mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrTotalTbListExcel");
		//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
		mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "총괄표-" + CommUtil.getDatePattern("yyyy-MM-dd"));


		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/_mngr_/module/{menuCode}_selectMenuSubList.ajax")
	public List<EgovMap> selectMenuSubList(@RequestParam String id) throws IOException, SQLException, RuntimeException {
		return totalTableService.selectMenuSubListByPcode(id);
	}

    /********************** E:관리자 **********************/
	/********************** S:사용자 **********************/

	/**
	 * @param siteCode
	 * @param menuCode
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 * @throws EmailException
	 */
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_totalTb.do")
	public String userTotalTb(@PathVariable String siteCode,@PathVariable String menuCode, @ModelAttribute("searchVO") TotalTbSearchVO searchVO, ModelMap model) throws IOException, SQLException, RuntimeException, EmailException {

		searchVO.setOrdFld("a.gp_name");
		searchVO.setOrdBy("asc");
		searchVO.setAct("totalTb"); //총괄표는 성장단계 해당이 없으면 출력 안되도록 구분 함.
		searchVO.setSchOpt1(CommUtil.getDatePattern("yyyy"));
		List<TotalTbVO> resultList = totalTableService.selectTotalTbListAll(searchVO);

		model.addAttribute("resultList", resultList);
		return "itgcms/project/totaltable/userTotalTb";
	}



	/**
	 * 부서별 사업안내
	 * @param siteCode
	 * @param menuCode
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 * @throws EmailException
	 */
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_orgBizList.do")
	public String userOrgBizList(@PathVariable String siteCode,@PathVariable String menuCode, @ModelAttribute("searchVO") TotalTbSearchVO searchVO, ModelMap model) throws IOException, SQLException, RuntimeException, EmailException {

		searchVO.setOrdFld("a.cg_name");
		searchVO.setOrdBy("asc");
		searchVO.setAct("orgBiz");
		searchVO.setSchOpt1(CommUtil.getDatePattern("yyyy"));
		List<TotalTbVO> resultList = totalTableService.selectTotalTbListAll(searchVO);
		List<MngrCodeVO> groupList = mngrCodeService.getMngrCodeList(new MngrCodeVO() {
			@Override
			public String getSchCode() {
				return "totalgroup";
			}
		});

		ArrayList<String> arrayList = new ArrayList<>();
		if (resultList.size()>0) {
			for (String string : resultList.get(0).getCgArr().split(",")) {
				arrayList.add(string);
			}
			for(int i= groupList.size()-1; i>=0; i--) {
				if(!arrayList.contains(groupList.get(i).getCcode())){
					groupList.remove(i);
				}
			}
		}
		model.addAttribute("groupList", groupList);
		model.addAttribute("resultList", resultList);
		return "itgcms/project/totaltable/orgBizList";
	}
	/********************** E:사용자 **********************/


}

