package egovframework.itgcms.module.contract.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.module.contract.service.ContractSearchVO;
import egovframework.itgcms.module.contract.service.ContractService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * @파일명 : MngrMemeberConfigController.java
 * @파일정보 : 회원 설정 관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2017. 5. 15. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class ContractController {

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	@Resource(name="contractService")
	private ContractService contractService;

	private static final Logger logger = LogManager.getLogger(ContractController.class);

	@RequestMapping(value = "/_mngr_/contract/contract_list.do")
	public String selectMngrGetContractList(@ModelAttribute("searchVO") ContractSearchVO contractSearchVO, ModelMap model) throws IOException, SQLException, RuntimeException {

		contractSearchVO.setPageUnit(Integer.parseInt(contractSearchVO.getViewCount()));//viewCount
		contractSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

		int page = Integer.parseInt(contractSearchVO.getPage());
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(contractSearchVO.getPageUnit());
		paginationInfo.setPageSize(contractSearchVO.getPageSize());

		contractSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		contractSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		contractSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		int totCnt = contractService.contractTotCnt(contractSearchVO);
		List<ContractSearchVO> resultList = contractService.selectMngrGetContractList(contractSearchVO);
		model.addAttribute("resultList", resultList);

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

		return "itgcms/global/module/contract/syscontract_list";
	}


	@RequestMapping(value = "/_mngr_/contract/contract_input.do")
	public String mngrRegistContactContents(@ModelAttribute("searchVO") ContractSearchVO contractSearchVO) throws IOException, SQLException, RuntimeException{
		contractSearchVO.setAct("REGIST");
		return "itgcms/global/module/contract/syscontract_view";
	}

	@RequestMapping(value = "/_mngr_/contract/contract_view.do")
	public String selectContractObj(@ModelAttribute("searchVO")  ContractSearchVO contractSearchVO) throws IOException, SQLException, RuntimeException {
		contractSearchVO.setAct("UPDATE");
		contractService.selectContractObj(contractSearchVO);
		return "itgcms/global/module/contract/syscontract_view";
	}

	@RequestMapping(value = "/_mngr_/contract/contract_proc.do")
	public String contractUpdateProc(@ModelAttribute("searchVO")  ContractSearchVO contractSearchVO, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException{

		String result = CommUtil.doComplete(model, "완료", "알수 없는 오류가 발생하였습니다. 다시 시도 해주십시오.", "location.href = '/_mngr_/contract/contract_view.do?"+contractSearchVO.getQuery()+"'");
		MngrSessionVO mngrSessionVo = CommUtil.getMngrSessionVO();
		String mngrId = mngrSessionVo.getId();
		contractSearchVO.setContents(CommUtil.decodeHTMLTagFilter(contractSearchVO.getContents()));

		if ("UPDATE".equalsIgnoreCase(contractSearchVO.getAct())) {
			// update
			contractSearchVO.setUpdMemId(mngrId);
			contractService.updateContract(contractSearchVO);
			result = CommUtil.doComplete(model, "완료", "성공적으로 수정 되었습니다.", "location.href = '/_mngr_/contract/contract_view.do?"+contractSearchVO.getQuery()+"'");
		} else {
			// insert
			contractSearchVO.setRegMemId(mngrId);
			contractService.insertContract(contractSearchVO);
			result = CommUtil.doComplete(model, "완료", "성공적으로 등록 되었습니다.", "location.href = '/_mngr_/contract/contract_list.do'");
		}

		return result;
	}

	@RequestMapping(value="/_mngr_/contract/contract_delete_proc.do")
	public String contractDelProc(@ModelAttribute("searchVO")  ContractSearchVO contractSearchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws IOException, SQLException, RuntimeException{
		String result = CommUtil.doComplete(model, "완료", "알수 없는 오류가 발생하였습니다. 다시 시도 해주십시오.", "location.href = '/_mngr_/contract/contract_list.do?"+contractSearchVO.getQuery()+"'");

		MngrSessionVO mngrSessionVo = CommUtil.getMngrSessionVO();
		String mngrId = mngrSessionVo.getId();
		String delNoDesc = request.getParameter("nos");

		int delRows = 0;

		contractSearchVO.setDelMemId(mngrId);
		if (delNoDesc == null) {
			delRows = contractService.deleteContract(contractSearchVO);
			result = CommUtil.doComplete(model, "완료", "성공적으로 삭제 되었습니다.", "location.href = '/_mngr_/contract/contract_list.do?"+contractSearchVO.getQuery()+"'");
		} else {
			delRows = contractService.deleteContractList(contractSearchVO, delNoDesc);
			result = CommUtil.doComplete(model, "완료", String.valueOf(delRows)+"개의 데이터가 성공적으로 삭제 되었습니다.", "location.href = '/_mngr_/contract/contract_list.do?"+contractSearchVO.getQuery()+"'");
		}

		return result;
	}

	@RequestMapping(value = "/_mngr_/module/{menuCode}_view_contract.do")
	public String contractView(ModelMap model, @PathVariable String menuCode, HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		model.addAttribute("contractList", contractService.selectMngrGetContractList());
		model.addAttribute("menuCode", menuCode);
		return "itgcms/global/module/contract/mngcontract_view";
	}

	@RequestMapping(value="/_mngr_/module/{menuCode}_comm_contractListByMenu.ajax")
	@ResponseBody
	public EgovMap contractListByMenu(@PathVariable String menuCode, @RequestParam HashMap<String,Object> paramMap) throws IOException, SQLException, RuntimeException {

		List<ContractSearchVO> contractResultList = null;

		EgovMap newParamMap = new EgovMap();
		for(Map.Entry<String, Object> entry : paramMap.entrySet()) {
		   newParamMap.put(entry.getKey(), entry.getValue());
		}

    	EgovMap contractInfo = contractService.getMenuContractInfo(newParamMap);
    	String contractNo = "";
    	if(contractInfo != null){
    		contractNo = CommUtil.isNull(contractInfo.get("contractNo"), "");
    		newParamMap.put("contractDesc", contractNo.split(","));
    		contractResultList = contractService.mngrGetContractListByContractDesc(newParamMap);
    	}

    	EgovMap listMap = new EgovMap();
    	listMap.put("contractResultList", contractResultList);
    	listMap.put("contractNo", contractNo);
    	listMap.put("menuCode", menuCode);

		return listMap;
	}



	@RequestMapping(value="/_mngr_/module/{menuCode}_edit_contract_proc.ajax")
	public void contractRegistAjax(ModelMap model, @PathVariable String menuCode, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		String result = "0";
		String message = "데이터 저장 중 오류가 발생했습니다. 다시 시도해 주세요";

		// 입력값 체크
			if("".equals(CommUtil.isNull(request.getParameter("contractNo"), ""))){
				result = "3";
				message = "약관을 선택 해 주세요.";
			}else { //입력값 정상
		    	EgovMap egovMap = new EgovMap();
		    	egovMap.put("menuCode", request.getParameter("menuCode"));
		    	egovMap.put("progIdx", CommUtil.isNull(request.getParameter("progIdx"),"7"));
		    	egovMap.put("contractNo", request.getParameter("contractNo"));
		    	egovMap.put("opt", CommUtil.isNull(request.getParameter("opt"), "one"));

				int resultCnt = contractService.setMenuContractInfo(egovMap);
				if(resultCnt > 0){
					result = "1";
					message = "등록 되었습니다.";
				}else{
					result = "2";
					message = "등록에 실패하였습니다. 관리자에게 문의해주세요";
				}

			}

		String json = "{\"result\" : "+result+", \"message\" : \""+message+"\"}";
		CommUtil.printWriter(json, response);
	}

	@RequestMapping(value = "/{root}/module/{menuCode}_contract.do")
	public String userContractView(@PathVariable String root, @PathVariable String menuCode, ModelMap model,	HttpServletRequest request,	HttpServletResponse response) throws IOException, SQLException, RuntimeException {

		List<ContractSearchVO> resultList = new ArrayList();
		ContractSearchVO contractSearchVO = new ContractSearchVO();

    	//String menuCode = request.getParameter("menuCode");
    	String progIdx = request.getParameter("progIdx");
    	String returnPage = "itgcms/global/module/contract/usrcontract_view";
    	String opt = "";

		if(!CommUtil.isExistSite(root)) return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
    	EgovMap egovMap = new EgovMap();
    	egovMap.put("menuCode", menuCode);
    	egovMap.put("progIdx", progIdx);

    	egovMap = contractService.getMenuContractInfo(egovMap);

    	if(egovMap != null){

    		egovMap.put("contractDesc", egovMap.get("contractNo").toString().split(","));

        	contractService.mngrGetContractListByContractDesc(egovMap);
        	model.addAttribute("menuCode", menuCode);
        	model.addAttribute("progIdx", progIdx);
        	model.addAttribute("result", egovMap);
        	model.addAttribute("contractList", contractService.selectMngrGetContractList());
        	model.addAttribute("contractResultList", contractService.mngrGetContractListByContractDesc(egovMap));
    	}else{
    		CommUtil.doComplete(model, "오류", "페이지 정보가 올바르지 않습니다", "history.back();");
    	}

		model.addAttribute("resultList", resultList);
		return returnPage;
	}
}
