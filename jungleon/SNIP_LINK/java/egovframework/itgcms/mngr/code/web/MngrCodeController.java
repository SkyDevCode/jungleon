package egovframework.itgcms.mngr.code.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.util.CommUtil;

/**
 * @파일명 : MngrCodeController.java
 * @파일정보 : 코드 등록 관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 9. 4. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 3.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class MngrCodeController {

    /** mngrCodeService */
    @Resource(name = "mngrCodeService")
    private MngrCodeService mngrCodeService;

    private static final Logger logger = LogManager.getLogger(MngrCodeController.class);

	/**
	 * 관리자 코드관리 메인 화면
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value="/_mngr_/code/code_list.do")
    public String mngrCodeMain(ModelMap model, HttpServletRequest request)    throws IOException, SQLException, RuntimeException {
		return "itgcms/mngr/code/code_list";
	}


	/**
	 * 코드 목록 Ajax 용 데이터
	 * @param mngrMngrCodeVO
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value="/common/code/code_comm_list.ajax")
	public void treeCodeList(@ModelAttribute("mngrCodeVO") MngrCodeVO mngrCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session)    throws IOException, SQLException, RuntimeException {
		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		if(mngrSessionVO != null) {
			logger.info("##################### mngrSessionVO.getMngAuth() : "+mngrSessionVO.getMngAuth());
			if(!"99".equals(CommUtil.isNull(mngrSessionVO.getMngAuth(), "00"))) {
				mngrCodeVO.setCauth("00");
			}else {
				mngrCodeVO.setCauth("99");
			}
		}else {
			mngrCodeVO.setCauth("00");
		}
		List<MngrCodeVO> result = mngrCodeService.selectMngrCodeList(mngrCodeVO);
		String json = "[";
		for(int i = 0; i < result.size(); i++){
			MngrCodeVO tmpCodeVO = (MngrCodeVO) result.get(i);
			json += "{"
					+ "\"id\": \"" + tmpCodeVO.getCcode() + "\" "
					+ ",\"name\": \"" + tmpCodeVO.getCname() + "\" "
					+ ",\"pId\": \"" + tmpCodeVO.getCpcode() + "\" "
					+ ",\"tId\": \"" + tmpCodeVO.getCcode() + "\" "
					+ ",\"depth\": \"" + tmpCodeVO.getCdepth() + "\" "
					+ "}" ;
			if(i < result.size() - 1){
				json += ",";
			}
		}
		json += "]";
		CommUtil.printWriter(json, response);
	}


	/**
	 * 코드를 등록한다.
	 * @param mngrCodeVO
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value="/_mngr_/code/code_edit.ajax")
	public String mngrCodeRegist(@ModelAttribute("mngrCodeVO") MngrCodeVO mngrCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session)    throws IOException, SQLException, RuntimeException {
		model.addAttribute("mngrSessionVO", CommUtil.getMngrSessionVO());
		model.addAttribute("result", mngrCodeService.selectMngrCodeInfoAjax(mngrCodeVO));
		model.addAttribute("searchVO", mngrCodeVO);
		return "itgcms/mngr/code/code_edit";
	}

	/**
	 * 코드 중복체크
	 * @param mngrCodeVO
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value="/_mngr_/code/code_comm_dupleCheck.ajax")
	public void mngrCodeDupleCheck(@ModelAttribute("mngrCodeVO") MngrCodeVO mngrCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		int resultCnt = mngrCodeService.mngrCodeDupleCheck(mngrCodeVO);
		String json = "{\"result\" : "+resultCnt+"}";
		CommUtil.printWriter(json, response);
	}

	/**
	 * 코드 등록/수정 처리
	 * @param mngrCodeVO
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value="/_mngr_/code/code_edit_proc.ajax")
	public void mngrCodeRegistUpdateAjax(@ModelAttribute("mngrCodeVO") MngrCodeVO mngrCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		String result = "0";
		String message = "데이터 저장 중 오류가 발생했습니다. 다시 시도해 주세요";

		if("REGIST".equals(mngrCodeVO.getAct())){
			/*
			 * 등록 모드
			 */
			// 입력값 체크
			if("".equals(CommUtil.isNull(mngrCodeVO.getCcode(), ""))){
				result = "3";
				message = "코드를 입력 해 주세요.";
			} else if("".equals(CommUtil.isNull(mngrCodeVO.getCname(), ""))){
				result = "3";
				message = "코드이름을 입력 해 주세요.";
			}else { //입력값 정상
				int resultCnt = mngrCodeService.mngrCodeDupleCheck(mngrCodeVO); //코드 중복 검사
				if(resultCnt > 0){
					result = "2";
					message = "코드가 중복 되었습니다. 확인 후 다시 시도해 주세요";
				}else{
					// 코드 정상
					mngrCodeVO.setRegmemid(CommUtil.getMngrMemId());
					mngrCodeService.insertCode(mngrCodeVO);
					result = "1";
					message = "등록 되었습니다.";
				}
			}

		}else if("UPDATE".equals(mngrCodeVO.getAct())){
			/*
			 * 수정 모드
			 */
			if("".equals(CommUtil.isNull(mngrCodeVO.getSchCode(), ""))){
				result = "3";
				message = "코드정보가 없습니다. 확인 후 다시 시도해 주세요.";
			} else if("".equals(CommUtil.isNull(mngrCodeVO.getCname(), ""))){
				result = "3";
				message = "코드이름을 입력 해 주세요.";
			}else { //입력값 정상
				mngrCodeVO.setUpdmemid(CommUtil.getMngrMemId());
				mngrCodeService.updateMngrCode(mngrCodeVO);
				result = "1";
				message = "수정 되었습니다.";
			}
		}
		String json = "{\"result\" : "+result+", \"message\" : \""+message+"\"}";
		CommUtil.printWriter(json, response);
	}

	/**
	 * 코드 삭제
	 * @param mngrCodeVO
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value="/_mngr_/code/code_delete_proc.ajax")
	public void mngrCodeRegistDeleteAjax(@ModelAttribute("mngrCodeVO") MngrCodeVO mngrCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		MngrCodeVO tmpCodeVO = mngrCodeService.selectMngrCodeInfoAjax(mngrCodeVO);
		String result = "0";
		if(tmpCodeVO.getSubtree() > 0){
			result = "2";
		}else{
			mngrCodeVO.setDelmemid(CommUtil.getMngrMemId());
			mngrCodeService.deleteMngrCodeAjax(mngrCodeVO);
			result = "1";
		}
		String json = "{\"result\" : "+result+"}";
		CommUtil.printWriter(json, response);
	}

	/**
	 * 코드 순서변경
	 * @param mngrCodeVO
	 * @param model
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@RequestMapping(value="/_mngr_/code/code_edit_updown.ajax")
	public void mngrCodeSwap(@ModelAttribute("mngrCodeVO") MngrCodeVO mngrCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		String result = "0";
		result = mngrCodeService.mngrCodeSwap(mngrCodeVO);
		String json = "{\"result\" : "+result+"}";
		CommUtil.printWriter(json, response);
	}

	/*@RequestMapping(value="/_mngr_/code/mngrCodeChngDefaultAjax.ajax")
	public void mngrCodeChngDefaultAjax(@ModelAttribute("mngrCodeVO") MngrCodeVO mngrCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		int result = 0;
		mngrCodeVO.setUpdmemid(CommUtil.getMngrMemId());
		result = mngrCodeService.modMngrCodeChngDefaultAjax(mngrCodeVO);
		String json = "{\"result\" : "+result+"}";
		CommUtil.printWriter(json, response);
	}*/

}

