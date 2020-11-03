package egovframework.itgcms.user.member.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.terracotta.agent.repkg.de.schlichtherle.io.File;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.MemberType;
import egovframework.itgcms.project.product.service.ProductSearchVO;
import egovframework.itgcms.project.product.service.ProductService;
import egovframework.itgcms.project.product.service.ProductVO;
import egovframework.itgcms.project.rent.service.RentEnum.FACILITY;
import egovframework.itgcms.project.rent.service.RentEnum.RENT_CUSTOMER;
import egovframework.itgcms.project.rent.service.RentEnum.RENT_MEET;
import egovframework.itgcms.project.rent.service.RentSearchVO;
import egovframework.itgcms.project.rent.service.RentService;
import egovframework.itgcms.project.rent.service.RentVO;
import egovframework.itgcms.project.sosqna.service.SOSQnaService;
import egovframework.itgcms.project.sosqna.service.SOSQnaVO;
import egovframework.itgcms.user.member.service.CleanAccuseService;
import egovframework.itgcms.user.member.service.CleanAccuseVO;
import egovframework.itgcms.user.member.service.GonggoReqService;
import egovframework.itgcms.user.member.service.MyQnaService;
import egovframework.itgcms.user.member.service.MyQnaVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class UserMypageController {

	@Resource(name="productService")
	private ProductService productService;

	@Resource(name="rentService")
	private RentService rentService;

	@Resource(name="cleanAccuseService")
	private CleanAccuseService cleanAccuseService;

	@Resource(name="myQnaService")
	private MyQnaService myQnaService;

	@Resource(name="sosQnaService")
	SOSQnaService sosQnaService;

	@Resource(name="gonggoReqService")
	GonggoReqService gonggoReqService;

	@Autowired
	private HttpSession session;


	/************************** S:제품정보관리 **********************************/

	/**
	 * 마이페이지 > 제품정보관리 목록 , 조회, 수정, 삭제
	 * @param siteCode
	 * @param menuCode
	 * @param model
	 * @param searchVO
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_mypageProductList.do")
	public String selectUserMypageProductList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") ProductSearchVO searchVO) throws IOException, SQLException {

		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
		//기업 회원만 이용가능함.
		if(!CustomUtil.checkMemberType(MemberType.Company)) {
			return CommUtil.doComplete(model, "오류", "기업회원만 이용 가능합니다", "history.back()");
		}

    	if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");
    	String schBusiRegNo = CommUtil.isNull(session.getAttribute("busiRegNo"), "");
    	searchVO.setSchBusiRegNo(schBusiRegNo);
    	searchVO.setQueryMode("MYPAGE");
    	if("list".equals(searchVO.getSchM())) {
			/** paging setting */
			int totCnt = productService.selectProductListTotCnt(searchVO);
			searchVO.setViewCount("6");
			// pagesize, viewcount => searchVO에 설정
			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

			List<ProductVO> resultList = productService.selectProductList(searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링


			model.addAttribute("resultList", resultList);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/user/member/mypageProductList";
		} else if("view".equals(searchVO.getSchM())) {
			ProductVO result = productService.selectProductView(searchVO);

			if(result == null) {
				return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
			}
			model.addAttribute("result", result);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/user/member/mypageProductView";
		} else if("update".equals(searchVO.getSchM())) {
			ProductVO result = productService.selectProductView(searchVO);

			if(result == null) {
				return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
			}

			//UNSPSC 1Depth 조회
			EgovMap paramMap = new EgovMap();
			paramMap.put("depth", "1");
			paramMap.put("unCd", "95000000");
			List<EgovMap> unspscList = productService.selectUnspscSearch(paramMap);

			model.addAttribute("unspscList", unspscList);

			model.addAttribute("result", result);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/user/member/mypageProductUpdate";
		} else if("delete".equals(searchVO.getSchM())) {

			ProductVO productVO = productService.selectProductView(searchVO);

			if(productVO == null) {
				return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
			}

			int result = productService.deleteProductProc(productVO);
			if(result < 1) {
				return CommUtil.doComplete(model, "실패", "삭제된 데이터가 없습니다. 확인 후 다시 시도해 주세요.", "history.back();");
			}
			//DB데이터 삭제 후 파일 삭제
			String productPath  = String.format("%s%s%s", CommUtil.getFileRoot(""), File.separator, "erp");
			String[] arrFiles = {
							productVO.getPrdImgPath01(),
							productVO.getPrdImgPath02(),
							productVO.getPrdImgPath03(),
							productVO.getPrdThumbPath01(),
							productVO.getPrdVideoPath01(),
						};
			for(String file : arrFiles) {
				if(!"".equals(file)) {
					System.out.println(productPath + file);
					CommUtil.deleteFile(productPath + file);
				}
			}

			searchVO.setSchM("list");
			String query = searchVO.getQuery();
			return CommUtil.doComplete(model, "성공", "삭제가 완료되었습니다.", "location.href='?"+query+"'");
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속해 주세요.", "history.back();");
	}


	/**
	 * 마이페이지 > 제품정보관리 등록 화면
	 * @param siteCode
	 * @param menuCode
	 * @param model
	 * @param searchVO
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_mypageProductRegist.do")
	public String selectUserMypageProductRegist(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") ProductSearchVO searchVO) throws IOException, SQLException {
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
		//기업 회원만 이용가능함.
				if(!CustomUtil.checkMemberType(MemberType.Company)) {
					return CommUtil.doComplete(model, "오류", "기업회원만 이용 가능합니다", "history.back()");
				}
		//UNSPSC 1Depth 조회
		EgovMap paramMap = new EgovMap();
		paramMap.put("depth", "1");
		paramMap.put("unCd", "95000000");
		List<EgovMap> unspscList = productService.selectUnspscSearch(paramMap);

		model.addAttribute("unspscList", unspscList);
		return "itgcms/user/member/mypageProductRegist";
	}

	/** 마이페이지 > 제품정보관리 등록 처리
	 * @param siteCode
	 * @param menuCode
	 * @param model
	 * @param searchVO
	 * @param productVO
	 * @param multiRequest
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_mypageProductRegistProc.do")
	public String selectUserMypageProductRegistProc(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") ProductSearchVO searchVO, @ModelAttribute("productVO") ProductVO productVO, MultipartHttpServletRequest multiRequest) throws IOException, SQLException {
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
		//기업 회원만 이용가능함.
				if(!CustomUtil.checkMemberType(MemberType.Company)) {
					return CommUtil.doComplete(model, "오류", "기업회원만 이용 가능합니다", "history.back()");
				}
		String busiRegNo = (String)session.getAttribute("busiRegNo");
		if("".equals(CommUtil.isNull(busiRegNo, ""))) {
			return CommUtil.doComplete(model, "오류", "로그인 정보가 없습니다. 확인 후 다시 시도해 주세요.", "history.back();");
		}

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

		productVO.setRegId(CommUtil.getUserMemId());
		productVO.setBusiRegNo(busiRegNo);

		int result = productService.insertProduct(productVO);

		return CommUtil.doComplete(model, "정상", "등록이 완료되었습니다.", "location.href='/"+siteCode+"/contents/myproduct-list.do'");
	}

	/**
	 * 마이페이지 > 제품정보관리 수정 처리
	 * @param siteCode
	 * @param menuCode
	 * @param model
	 * @param searchVO
	 * @param productVO
	 * @param multiRequest
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_mypageProductUpdateProc.do")
	public String selectUserMypageProductUpdateProc(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") ProductSearchVO searchVO, @ModelAttribute("productVO") ProductVO productVO, MultipartHttpServletRequest multiRequest) throws IOException, SQLException {
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
		//기업 회원만 이용가능함.
				if(!CustomUtil.checkMemberType(MemberType.Company)) {
					return CommUtil.doComplete(model, "오류", "기업회원만 이용 가능합니다", "history.back()");
				}
		String busiRegNo = (String)session.getAttribute("busiRegNo");
		if("".equals(CommUtil.isNull(busiRegNo, ""))) {
			return CommUtil.doComplete(model, "오류", "로그인 정보가 없습니다. 확인 후 다시 시도해 주세요.", "history.back();");
		}

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
		productVO.setModId(CommUtil.getUserMemId());
		productVO.setBusiRegNo(busiRegNo);

		int result = productService.updateProduct(productVO);

		searchVO.setSchM("view");
		String query = searchVO.getQuery();
		return CommUtil.doComplete(model, "정상", "수정이 완료되었습니다.", "location.href='/"+siteCode+"/contents/myproduct-list.do?"+query+"'");
	}

	/************************** E:제품정보관리 **********************************/



	/************************** S:대관신청관리 **********************************/

	@RequestMapping(value = "/{siteCode}/module/{menuCode}_mypageRentList.do")
	public String selectUserMypageRentList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") RentSearchVO searchVO) throws IOException, SQLException {
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
    	if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");

    	searchVO.setQueryMode("MYPAGE"); //사용자인경우 로그인 ID정보만 조회.
    	searchVO.setSchMemid(CommUtil.getUserMemId());

    	if("list".equals(searchVO.getSchM())) {
    		/** paging setting */
			int totCnt = rentService.selectRentListTotCnt(searchVO);
			// pagesize, viewcount => searchVO에 설정
			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

			List<RentVO> resultList = rentService.selectRentList(searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

			// schmemid는 초기화.
			searchVO.setSchMemid("");
			model.addAttribute("resultList", resultList);
			model.addAttribute("searchVO", searchVO);

    		return "itgcms/user/member/mypageRentList";
    	} else if("view".equals(searchVO.getSchM())) {
    		RentVO result = rentService.selectRentView(searchVO);
			if(result == null) {
				return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
			}

//			// schmemid는 초기화.
			searchVO.setSchMemid("");
			model.addAttribute("result", result);
			model.addAttribute("facility", FACILITY.values());
			model.addAttribute("customerList", RENT_CUSTOMER.values());
			model.addAttribute("meetList", RENT_MEET.values());
			model.addAttribute("searchVO", searchVO);
			return "itgcms/user/member/mypageRentView";
    	}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
	}

	/************************** E:대관신청관리 **********************************/

	/************************** S:Q&A 내역조회 **********************************/
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_mypageQnaList.do")
	public String selectUserMypageQanList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") DefaultVO searchVO) throws IOException, SQLException {
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
		if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");

		searchVO.setSchMemid(CommUtil.getUserMemId());
		if("list".equals(searchVO.getSchM())) {
			//기업회원 : C
			if (CustomUtil.checkMemberType(MemberType.Company))
			{
				/** paging setting */
	 			int totCnt = sosQnaService.selectSOSQnaListTotCnt(searchVO);

	 			// pagesize, viewcount => searchVO에 설정
	 			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

	 			List<SOSQnaVO> resultList = sosQnaService.selectSOSQnaList(searchVO);
				model.addAttribute("paginationInfo", paginationInfo);
				model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
				searchVO.setSchMemid("");
				model.addAttribute("resultList", resultList);
				model.addAttribute("searchVO", searchVO);

	//			return "itgcms/user/member/mypageQnaList";
				return "itgcms/project/sosqna/userSOSQnaList";//사업신청SOS현장기동대나의 상담내역(Q&A) list 페이지 공유

			}
			else
			{ // 일반회원 : N
				/** paging setting */
				int totCnt = myQnaService.selectMyQnaListTotCnt(searchVO);
				// pagesize, viewcount => searchVO에 설정
				PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

				List<MyQnaVO> resultList = myQnaService.selectMyQnaList(searchVO);

				model.addAttribute("paginationInfo", paginationInfo);
				model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
				// schmemid는 초기화.
				searchVO.setSchMemid("");
				model.addAttribute("resultList", resultList);
				model.addAttribute("searchVO", searchVO);
				if(!CustomUtil.checkMemberType(MemberType.Company)) {//개인

					model.addAttribute("status", "YES");
				}else{
					model.addAttribute("status", "NO2");
					model.addAttribute("msg", "개인 회원만 이용 가능합니다.");
				}
				return "itgcms/user/member/mypageMyQnaList";
			}

		} else if("view".equals(searchVO.getSchM())) {
			//기업회원 : C
			if (CustomUtil.checkMemberType(MemberType.Company))
			{
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
//				fileId = !"".equals(CommUtil.isNull(result.getMgrFileSeq(), ""))?Integer.parseInt(result.getMgrFileSeq()) : -1;
//				if(fileId> 0 ) mgrFileList = sosQnaService.selectCoFileList(result.getMgrFileSeq());

				searchVO.setSchMemid("");
				model.addAttribute("result", result);
				model.addAttribute("userFileList", userFileList);
				model.addAttribute("mgrFileList", mgrFileList);
				model.addAttribute("prevnextVO", prevnextVO);
				model.addAttribute("searchVO", searchVO);
				//return "itgcms/user/member/mypageQnaView";
				return "itgcms/project/sosqna/userSOSQnaView"; //사업신청SOS현장기동대나의 상담내역(Q&A) view 페이지 공유
			}
			else
			{ // 일반회원 : N
				MyQnaVO result = myQnaService.selectMyQnaView(searchVO);
				if(result == null) {
					return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
				}

				List<EgovMap> prevNext = myQnaService.selectMyQnaViewPrevNext(searchVO);

				// schmemid는 초기화.
				searchVO.setSchMemid("");
				model.addAttribute("result", result);
				model.addAttribute("prevNext", prevNext);
				model.addAttribute("searchVO", searchVO);
				return "itgcms/user/member/mypageMyQnaView";

			}
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
	}
	/************************** E:Q&A 내역조회 **********************************/

	/************************** S:사업신청관리 **********************************/
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_mypageBizReqList.do")
	public String selectUserMypageBizReqList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") DefaultVO searchVO, HttpSession session) throws IOException, SQLException {

		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
    	if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");

    	//기업 회원만 이용가능함.
		if(!CustomUtil.checkMemberType(MemberType.Company)) {
		}
		String busiRegNo = (String)session.getAttribute("busiRegNo");
		if("".equals(CommUtil.isNull(searchVO.getSchOpt2(),""))) {
			searchVO.setSchOpt2(CommUtil.getDatePattern("yyyy")); //기본 현재년도
		}
		searchVO.setSchOpt1(CommUtil.getUserMemId());

		/** paging setting */
		int totCnt = gonggoReqService.selectGoggoReqListTotCnt(searchVO);
		// pagesize, viewcount => searchVO에 설정
		PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

		List<EgovMap> yearList = gonggoReqService.selectYearList(searchVO);
		List<EgovMap> resultList = gonggoReqService.selectGoggoReqList(searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링
		searchVO.setSchOpt1(""); //사업자번호 노출 안되게 삭제
		model.addAttribute("yearList", yearList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", searchVO);


		return "itgcms/user/member/mypageBizReqList";
	}
	/************************** E:사업신청관리 **********************************/

	/************************** S:클린신고센터 **********************************/
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_mypageCleanAccuseList.do")
	public String selectUserMypageCleanAccuseList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model,
			@ModelAttribute("searchVO") DefaultVO searchVO) throws IOException, SQLException {
		if (!CommUtil.isUserLogin() || CommUtil.getUserSessionVO() == null || "".equals(CommUtil.getUserMemId())) {
			String loginPageUrl = "/" + siteCode + "/contents/snipLogin.do";
			return CommUtil.doCompleteConfirm(model, "오류", "로그인이 필요한 서비스입니다. \\n로그인 페이지로 이동하시겠습니까?",
					"location.href='" + loginPageUrl + "'", "history.back();");
		}
		if(searchVO.getSchM() == null || "".equals(searchVO.getSchM())) searchVO.setSchM("list");

		searchVO.setSchMemid(CommUtil.getUserMemId());
		if("list".equals(searchVO.getSchM())) {
			/** paging setting */
			int totCnt = cleanAccuseService.selectCleanAccuseListTotCnt(searchVO);
			// pagesize, viewcount => searchVO에 설정
			PaginationInfo paginationInfo = CustomUtil.getPagenation(searchVO, totCnt);

			List<CleanAccuseVO> resultList = cleanAccuseService.selectCleanAccuseList(searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((Integer.parseInt(searchVO.getPage()) - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

			// schmemid는 초기화.
			searchVO.setSchMemid("");
			model.addAttribute("resultList", resultList);
			model.addAttribute("searchVO", searchVO);
			if(!CustomUtil.checkMemberType(MemberType.Company)) {//개인

				model.addAttribute("status", "YES");
			}else{
				model.addAttribute("status", "NO2");
				model.addAttribute("msg", "개인 회원만 이용 가능합니다.");
			}
			return "itgcms/user/member/mypageCleanAccuseList";
		} else if("view".equals(searchVO.getSchM())) {
			CleanAccuseVO result = cleanAccuseService.selectCleanAccuseView(searchVO);
			if(result == null) {
				return CommUtil.doComplete(model, "오류", "조회된 데이터가 없습니다.", "history.back();");
			}

			List<EgovMap> prevNext = cleanAccuseService.selectCleanAccuseViewPrevNext(searchVO);

			// schmemid는 초기화.
			searchVO.setSchMemid("");
			model.addAttribute("result", result);
			model.addAttribute("prevNext", prevNext);
			model.addAttribute("searchVO", searchVO);
			return "itgcms/user/member/mypageCleanAccuseView";
		}
		return CommUtil.doComplete(model, "오류", "정상적인 경로로 접속 해 주세요", "history.back();");
	}
	/************************** E:클린신고센터 **********************************/


}