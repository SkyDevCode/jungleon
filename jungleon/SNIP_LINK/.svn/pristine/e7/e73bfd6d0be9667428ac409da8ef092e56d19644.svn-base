package egovframework.itgcms.project.product.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.project.product.service.ProductSearchVO;
import egovframework.itgcms.project.product.service.ProductVO;
import egovframework.itgcms.project.product.service.ProductSearchVO;
import egovframework.itgcms.project.product.service.ProductService;
import egovframework.itgcms.project.product.service.ProductVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ProductController {

	@Autowired
	ProductService productService;

	/********************** S:사용자 **********************/
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_productList.do")
	public String selectUserProductList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") ProductSearchVO searchVO) throws IOException, SQLException {

    	if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");

    	if("list".equals(searchVO.getSchM())) {

			/** paging setting */
			int totCnt = productService.selectProductListTotCnt(searchVO);
			searchVO.setViewCount("12");
			// pagesize, viewcount => searchVO에 설정
			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

			List<ProductVO> resultList = productService.selectProductList(searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

			//UNSPSC 1Depth 조회
			EgovMap paramMap = new EgovMap();
			paramMap.put("depth", "1");
			paramMap.put("unCd", "95000000");
			List<EgovMap> unspscList = productService.selectUnspscSearch(paramMap);

			model.addAttribute("resultList", resultList);
			model.addAttribute("areaList", CustomUtil.getSnipAreaList(true));
			model.addAttribute("unspscList", unspscList);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/product/userProductList";
		} else if("view".equals(searchVO.getSchM())) {
			ProductVO result = productService.selectProductView(searchVO);
			List<EgovMap> prevNext = productService.selectProductViewPrevNext(searchVO);

			if(result == null) {
				return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
			}
			model.addAttribute("result", result);
			model.addAttribute("prevNext", prevNext);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/product/userProductView";
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
	}

	@ResponseBody
	@RequestMapping(value="/{siteCode}/product/userUnspscSearch.ajax")
	public ModelMap  userUnspscSearch(@PathVariable String siteCode, ModelMap model,
			HttpServletRequest request) throws IOException, SQLException{

		EgovMap paramMap = new EgovMap();
		paramMap.put("unCd", request.getParameter("unCd"));
		paramMap.put("depth", request.getParameter("depth"));
		model = new ModelMap();
		model.put("result", "1");
		model.put("message", "");
		try {
			List<EgovMap> resultList = productService.selectUnspscSearch(paramMap);
			model.put("data", resultList);
		}catch(Exception e) {
			model.put("result", "2");
			model.put("message", "데이터 조회 중 오류가 발생했습니다. 확인 후 다시 시도해 주세요");
		}

		return model;
	}
    /********************** E:사용자 **********************/

    /********************** S:관리자 **********************/
	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrProductList.do")
	public String selectMngrProductList(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") ProductSearchVO searchVO) throws IOException, SQLException{

		if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");
		if("list".equals(searchVO.getSchM())) {
			/** paging setting */
			int totCnt = productService.selectProductListTotCnt(searchVO);
			searchVO.setViewCount("12");
			// pagesize, viewcount => searchVO에 설정
			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

			List<ProductVO> resultList = productService.selectProductList(searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

			model.addAttribute("resultList", resultList);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/product/mngrProductList";
		} else if("view".equals(searchVO.getSchM())) {
			ProductVO result = productService.selectProductView(searchVO);
			if(result == null) {
				return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
			}
			model.addAttribute("result", result);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/project/product/mngrProductView";
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
	}

	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrProductListExcelDown.do")
	public ModelAndView selectMngrProductListExceDown(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") ProductSearchVO searchVO, HttpServletRequest request) throws IOException, SQLException{

		ModelAndView mav = new ModelAndView(ExcelDownloadView.EXCEL_DOWN);

		searchVO.setExcelDown("Y");
		List<ProductVO> resultList = productService.selectProductList(searchVO);

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dataList", resultList);

		//엑셀 템플릿에 넘겨줄 데이타
		mav.addObject("data", paramMap);

		//다운로드에 사용되어질 엑셀파일 템플릿
		mav.addObject(ExcelDownloadView.DOWN_EXCEL_TEMPLATE, "mngr.mngrProductListExcel");
		//다운로드시 표시될 파일명 (확장자는 자동으로 xls로 지정된다.)
		mav.addObject(ExcelDownloadView.DOWN_FILE_NM, "상품정보-" + CommUtil.getDatePattern("yyyy-MM-dd"));

		return mav;
	}

	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrProductUpdateProc.do")
	public String updateMngrProductProc(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") ProductSearchVO searchVO, @ModelAttribute("productVO") ProductVO productVO, MultipartHttpServletRequest multiRequest   ) throws IOException, SQLException{

		if("".equals(CommUtil.isNull(productVO.getPrdNm(), ""))) return CommUtil.doComplete(model, "오류", "상품명을 입력해 주세요.", "history.back();");
		else if("".equals(CommUtil.isNull(productVO.getPrdDescShort(), ""))) return CommUtil.doComplete(model, "오류", "제품 소개를 입력해 주세요.", "history.back();");

		String errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 1024000000, "prdImg01", "", true, ""); //첨부파일체크, 용량체크
		if(!"".equals(errMsg))  return CommUtil.doComplete(model, "오류", "상품 이미지1 " + errMsg, "history.back();");
		errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 1024000000, "prdImg02", "", true, ""); //첨부파일체크, 용량체크
		if(!"".equals(errMsg))  return CommUtil.doComplete(model, "오류",  "상품 이미지2 " + errMsg, "history.back();");
		errMsg = CommUtil.fileUploadBeforeCheck(multiRequest.getFileMap(), 1024000000, "prdImg03", "", true, ""); //첨부파일체크, 용량체크
		if(!"".equals(errMsg))  return CommUtil.doComplete(model, "오류",  "상품 이미지3 " + errMsg, "history.back();");

		String storePath = CustomUtil.getSnipUploadPath("/upload/goods");
		HashMap imgFile01 = CommUtil.fileUpload(multiRequest.getFileMap(), "prdImg01", "/erp/" + storePath);
		if(imgFile01 != null) {
			productVO.setPrdImg01((String)imgFile01.get("F_ORGNAME"));
			productVO.setPrdImgPath01(storePath + "/" + (String)imgFile01.get("F_SAVENAME"));
		}
		HashMap imgFile02 = CommUtil.fileUpload(multiRequest.getFileMap(), "prdImg02", "/erp/" + storePath);
		if(imgFile02 != null) {
			productVO.setPrdImg02((String)imgFile02.get("F_ORGNAME"));
			productVO.setPrdImgPath02(storePath + "/" + (String)imgFile02.get("F_SAVENAME"));
		}
		HashMap imgFile03 = CommUtil.fileUpload(multiRequest.getFileMap(), "prdImg03", "/erp/" + storePath);
		if(imgFile03 != null) {
			productVO.setPrdImg03((String)imgFile03.get("F_ORGNAME"));
			productVO.setPrdImgPath03(storePath + "/" + (String)imgFile03.get("F_SAVENAME"));
		}


		HashMap video01 = CommUtil.fileUpload(multiRequest.getFileMap(), "prdVideo01", "/erp/" + storePath);
		if(video01 != null) {
			productVO.setPrdVideo01((String)video01.get("F_ORGNAME"));
			productVO.setPrdVideoPath01(storePath + "/" + (String)video01.get("F_SAVENAME"));
		}


		HashMap thumb01 = CommUtil.fileUpload(multiRequest.getFileMap(), "prdThumb01", "/erp/" + storePath);
		if(thumb01 != null) {
			productVO.setPrdThumb01((String)thumb01.get("F_ORGNAME"));
			productVO.setPrdThumbPath01(storePath + "/" + (String)thumb01.get("F_SAVENAME"));
		}




		productVO.setPrdNo(searchVO.getSchId());
		productVO.setModId(CommUtil.getMngrMemId());
		int result = productService.updateProduct(productVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "수정 내용이 없습니다.", "history.back();");
		}
		searchVO.setSchM("list");
		return CommUtil.doComplete(model, "성공", "정상적으로 수정처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_mngrProductList.do?" + searchVO.getQuery()+ "'");
	}

	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrProductDeleteProc.do")
	public String deleteMngrProductDeleteProc(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") ProductSearchVO searchVO, @ModelAttribute("productVO") ProductVO productVO  ) throws IOException, SQLException{

		productVO.setPrdNo(searchVO.getSchId());
		productVO.setModId(CommUtil.getMngrMemId());
		int result = productService.deleteProductProc(productVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "삭제 내용이 없습니다.", "history.back();");
		}
		searchVO.setSchM("list");
		return CommUtil.doComplete(model, "성공", "정상적으로 삭제처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_mngrProductList.do?" + searchVO.getQuery()+ "'");
	}

	@RequestMapping(value="/_mngr_/module/{menuCode}_mngrProductMultiDeleteProc.do")
	public String deleteMngrProductMultiDeleteProc(@PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") ProductSearchVO searchVO, @ModelAttribute("productVO") ProductVO productVO  ) throws IOException, SQLException{

		if(searchVO.getChkId() == null || searchVO.getChkId().length == 0) {
			return CommUtil.doComplete(model, "오류", "삭제할 게시물을 선택해 주세요.", "history.back();");
		}

		int result = productService.deleteProductMultiProc(searchVO);
		if(result < 1) {
			return CommUtil.doComplete(model, "오류", "삭제중 오류가 발생했습니다 .확인 후 다시 시도해 주세요.", "history.back();");
		}
		searchVO.setSchM("list");
		return CommUtil.doComplete(model, "성공", "정상적으로 삭제처리 되었습니다.", "location.href='/_mngr_/module/" + menuCode + "_mngrProductList.do?" + searchVO.getQuery()+ "'");
	}


    /********************** E:관리자 **********************/
}
