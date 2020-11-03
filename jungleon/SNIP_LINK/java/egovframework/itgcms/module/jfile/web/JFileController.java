/*
 * eGovFrame JFile
 * Copyright The eGovFrame Open Community (http://open.egovframe.go.kr)).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @author 정호열 커미터(표준프레임워크 오픈커뮤니티 리더)
 */
package egovframework.itgcms.module.jfile.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovBasicLogger;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.module.jfile.GlobalVariables;
import egovframework.itgcms.module.jfile.JProperties;
import egovframework.itgcms.module.jfile.service.JFile;
import egovframework.itgcms.module.jfile.service.JFileDetails;
import egovframework.itgcms.module.jfile.service.JFileService;
import egovframework.itgcms.module.jfile.service.impl.JFileVO;
import egovframework.itgcms.module.jfile.session.SessionUploadChecker;
import egovframework.itgcms.module.jfile.utils.DateUtils;
import egovframework.itgcms.module.jfile.view.JSonView;
import egovframework.itgcms.module.jfile.view.JfileDownloadView;
import egovframework.itgcms.util.CommUtil;

@Controller
public class JFileController {

	private static final Logger LOGGER = LoggerFactory.getLogger(JFileController.class);

	@Resource(name="multipartResolver")
	private MultipartResolver multipartResolver;

	/** JFileService */
	@Resource(name = "jFileService")
	private JFileService jFileService;

	@RequestMapping("/afile/fileuploadForm.do")
	public String fileuploadForm(HttpServletRequest request, ModelMap model) {
		ItgMap paramMap = CommUtil.getParameterEMap(request);

		/*for(int i = 0 ; i < paramMap.size(); i++){
			//System.out.println("#### paramMap : "+paramMap.get(i)+":"+paramMap.getValue(i));
		}*/
		model.addAllAttributes(paramMap);

		return "itgcms/global/module/jfile/fileuploadForm";
	}
	@RequestMapping("/afile/filedownForm.do")
	public String filedownloadForm(HttpServletRequest request, ModelMap model) {
		ItgMap paramMap = CommUtil.getParameterEMap(request);

		/*for(int i = 0 ; i < paramMap.size(); i++){
			//System.out.println(paramMap.get(i)+":"+paramMap.getValue(i));
		}*/
		model.addAllAttributes(paramMap);

		return "itgcms/global/module/jfile/filedownForm";
	}
	@RequestMapping("/jfile/jfileuploadForm.do")
	public String jfileuploadForm() {
		return "itgcms/global/module/jfile/jfileuploadForm";
	}

	/**
	 * 파일 ID를 읽어온다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/readFileId.do")
	public ModelAndView readFileId(JFileVO fileVO, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);

		try {
			String fileId = jFileService.getFileId(fileVO.getFileId(), request.getParameterValues("fileSeq"));
			modelAndView.addObject("fileId", fileId);
			SessionUploadChecker.check(request, fileId);
		} catch(RuntimeException e) {
			modelAndView.addObject("fileId", "errorFileId");
//			try {
//				response.sendError(GlovalVariables.Error.SYSTEM_ERROR, "");
//			} catch (IOException e1) {
//				e1.printStackTrace();
//			}
		}
		return modelAndView;
	}

	@RequestMapping("/jfile/uploadingCheck.do")
	public ModelAndView uploadingCheck(@ModelAttribute JFileVO fileVO, HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		modelAndView.addObject("hasFileId", SessionUploadChecker.isContainsKey(request, fileVO.getFileId()));
		modelAndView.addObject("maxInactiveInterval", request.getSession().getMaxInactiveInterval());
		LOGGER.debug("\nlastAccessTime : " + DateUtils.getDateString(request.getSession().getLastAccessedTime(), "yyyy.MM.dd HH:mm:ss"));
		return modelAndView;
	}

	/**
	 * 파일 업로드 실행
	 * @param fileVo
	 * @param request
	 * @return
	 */
	@RequestMapping("/jfile/processUpload.do")
	public ModelAndView processUpload(@ModelAttribute JFileVO fileVo, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		if(multipartResolver.isMultipart(request)) {
			final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

			Collection<MultipartFile> values = multiRequest.getFileMap().values();
			boolean exceedFileNameLength = isExceedFileNameLength(values);
			if (exceedFileNameLength) {
				try {
					response.sendError(GlobalVariables.Error.FILE_LENGTH_ERROR, "");
				} catch (IOException e) {
					EgovBasicLogger.debug("Reponse send error", e);
				}
			} else {
				try {
					jFileService.upload(values, fileVo, multiRequest);
				} finally {
					SessionUploadChecker.unCheck(request, fileVo.getFileId());
				}
			}

		}

		return modelAndView;
	}

	private boolean isExceedFileNameLength(Collection<MultipartFile> values) {

		if(values != null) {
			for(MultipartFile mfile : values) {
				if(mfile.getOriginalFilename().length() > 99) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * 파일 업로드 실행
	 * @param fileVo
	 * @param request
	 * @return
	 */
	@RequestMapping("/afile/fileUpload.do")
	/*@ResponseBody*/
	public ModelAndView fileUpload(@ModelAttribute JFileVO fileVo, MultipartHttpServletRequest multiRequest, HttpServletResponse response)  throws IOException, SQLException, RuntimeException {

		ModelAndView mav = new ModelAndView("jsonView");

		int result = 0;
		ItgMap resultMap = new ItgMap();
		ItgMap paramMap = CommUtil.getParameterEMap(multiRequest);
		String fileName = CommUtil.isNull(paramMap.get("fileName"), "");
		String fileIdName = CommUtil.isNull(paramMap.get("fileIdName"), "");
		//System.out.println("fileIdName : "+fileIdName);
		String fileId = CommUtil.isNull(paramMap.get(fileIdName), "");
		//System.out.println("fileId : "+fileId);
		String maxFileSize = CommUtil.isNull(paramMap.get("maxFileSize"), ""+(10*1024*1024));//10MB
		String accept = CommUtil.isNull(paramMap.get("accept"), "all");//모든파일
		//파일아이디가 있으면 기존 파일아이디로 등록
		if("".equals(fileId)){
			//파일아이디가 없으면 새로운 파일아이디로 등록
			fileId = CommUtil.getDatePattern("yyMMddssSSS")+CommUtil.getRandomString(5);
		}
		fileVo.setFileId(fileId);
		String errMsg = CommUtil.fileUploadBeforeCheckforJfile(multiRequest.getFileMap(), Integer.parseInt(maxFileSize)*(1024*1024), fileName, accept, "required");
		//System.out.println(errMsg);
		if(!"".equals(errMsg)){ resultMap.put("error", true); resultMap.put("result", result); resultMap.put("resultMsg", errMsg); mav.addObject("data",resultMap); return mav;}

		try {
//
			Collection<MultipartFile> values = multiRequest.getFileMap().values();
			boolean exceedFileNameLength = isExceedFileNameLength(values);
			if (exceedFileNameLength) {
				try {
					response.sendError(GlobalVariables.Error.FILE_LENGTH_ERROR, "");
				} catch (IOException e) {
					EgovBasicLogger.debug("Reponse send error", e);
					result = 0;
				}
			} else {
				try {
					jFileService.upload(values, fileVo, multiRequest);
					resultMap.put("fileId", fileId);
					resultMap.put("fileName", fileVo.getFileName());
					resultMap.put("fileMask", fileVo.getFileMask());
					resultMap.put("fileSize", fileVo.getFileSize());
					resultMap.put("fileIdx", fileVo.getFileIdx());
					resultMap.put("ext", fileVo.getExtension());
					resultMap.put("isImage", fileVo.isImage());
					resultMap.put("downloadCount", 0);
					resultMap.put("downloadPath", "/afile/fileDownload/"+CommUtil.getEncstrFromNum(fileVo.getFileIdx()));
					resultMap.put("removePath", "/afile/fileRemove/"+CommUtil.getEncstrFromNum(fileVo.getFileIdx()));
					result = 1;
				} finally {
					SessionUploadChecker.unCheck(multiRequest, fileVo.getFileId());
				}
			}
		} catch (IndexOutOfBoundsException | NullPointerException e){
			if("".equals(errMsg))	errMsg = "오류가 발생하였습니다.";
			result = 0;
		}

		resultMap.put("result", result);
		resultMap.put("resultMsg", errMsg);

		mav.addObject("data",resultMap);

		return mav;
	}

	/**
	 * 파일업로드가 완료된 후 처리 작업을 수행한다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/afterProcessUploadCompleted.do")
	public ModelAndView afterProcessUploadCompleted(JFileVO fileVO, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		try {
			jFileService.executeAfterUploadCompleted(fileVO.getFileId());
			SessionUploadChecker.unCheck(request, fileVO.getFileId());
		} catch (RuntimeException e) {
			try {
				response.sendError(GlobalVariables.Error.SYSTEM_ERROR, "");
			} catch (IOException e1) {
				EgovBasicLogger.debug("Reponse send error", e1);
			}
		}
		return modelAndView;
	}

	/**
	 * 파일 아이디로 첨부파일 목록을 읽어온다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/readFiles.do")
	public ModelAndView readFiles(JFileVO fileVO) {
		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		List<JFileDetails> fileList= jFileService.getAttachFiles(fileVO.getFileId());
		modelAndView.addObject("fileList", fileList);
		return modelAndView;
	}

	/**
	 *
	 */
	@RequestMapping("/jfile/jfiledownloadForm.do")
	public String jfiledownloadForm() {
		return "itgcms/global/module/jfile/jfiledownloadForm";
	}


	/**
	 * 파일 아이디로 첨부파일 목록을 읽어온다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/readDownloadFiles.do")
	public ModelAndView readDownloadFiles(JFileVO fileVO) {
		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		modelAndView.addObject("fileList", jFileService.getAttachFiles(fileVO.getFileId()));
		return modelAndView;
	}

	/**
	 * 파일을 다운로드 받는다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/readDownloadFile.do")
	public ModelAndView readDownloadFile(JFileVO fileVO) {
		JFile downloadFile = jFileService.getFile(fileVO.getFileId(), fileVO.getFileSeq(), fileVO.getUseSecurity());
		// 다운로드 카운트를 증가 시킨다.
		jFileService.updateAttachFileDownloadCountBySequence(fileVO.getFileId(), fileVO.getFileSeq());
        return new ModelAndView(JfileDownloadView.NAME, JfileDownloadView.MODELNAME, downloadFile);
	}

	/**
	 * 멀티 업로드된 모든 파일을 zip로 압축하여 다운로드 받는다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/downloadAll.do")
	public ModelAndView downloadAll(JFileVO fileVO) {
		JFile[] downloadZipFile = jFileService.getFiles(fileVO.getFileId(), fileVO.getUseSecurity());
		jFileService.updateAttachFileDownloadCountByFileId(fileVO.getFileId());
		return new ModelAndView(JfileDownloadView.NAME, JfileDownloadView.MODELNAME, downloadZipFile);
	}

	/**
	 * 이미지 파일일 경우 미리보기를 한다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/preview.do")
	public ModelAndView preview(JFileVO fileVO) {
		JFileDetails prevFileVO = null;
		prevFileVO = jFileService.getAttachFile(fileVO.getFileId(), fileVO.getFileSeq());

		JFile previewFile = prevFileVO.isImage() ?
				jFileService.getFileBySequence(fileVO.getFileId(), fileVO.getFileSeq(), fileVO.getUseSecurity()) : new JFile(getNoImagePath());
		return new ModelAndView(JfileDownloadView.NAME, JfileDownloadView.MODELNAME, previewFile);
	}

	/**
	 * 이미지 경로를 읽어온다.
	 * @return
	 */
	private String getNoImagePath() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		return request.getSession().getServletContext().getRealPath("/") + JProperties.getString(GlobalVariables.DEFAULT_NO_IMAGE_APP_PATH_KEY);
	}



	@RequestMapping(value = "/afile/fileList.do")
	@ResponseBody
	public List fileList(JFileVO fileVO, HttpServletRequest request, ModelMap model) throws IOException, SQLException, RuntimeException {

		List<ItgMap> returnList = new ArrayList();
		ItgMap returnMap = new ItgMap();
		int result = 0;

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		String fileId = CommUtil.isNull(paramMap.get("fileId"), "");

		String errMsg = "";
		if("".equals(fileId)){ return returnList;}
		try {
			// 파일 리스트가져오기
			//List<ItgMap> fileList = itgFileService.selectAttachFileList(paramMap);
			List<JFileDetails> fileList= jFileService.getAttachFiles(fileVO.getFileId());
			// 파일 첨부 처리 결과
			for(JFileDetails fileVo : fileList){
				returnMap = new ItgMap();
				returnMap.put("result", 1);
				returnMap.put("resultMsg", "성공");
				returnMap.put("fileId", fileId);
				returnMap.put("fileName", fileVo.getFileName());
				returnMap.put("fileMask", fileVo.getFileMask());
				returnMap.put("fileSize", fileVo.getFileSize());
				returnMap.put("fileIdx", fileVo.getFileIdx());
				returnMap.put("ext", fileVo.getExtension());
				returnMap.put("isImage", fileVo.isImage());
				returnMap.put("downloadCount", fileVo.getDownloadCount());
				returnMap.put("downloadPath", "/afile/fileDownload/"+CommUtil.getEncstrFromNum(fileVo.getFileIdx()));
				returnMap.put("removePath", "/afile/fileRemove/"+CommUtil.getEncstrFromNum(fileVo.getFileIdx()));
				returnList.add(returnMap);
			};

		} catch (IndexOutOfBoundsException | NullPointerException e){

		}
		return returnList;
	}

	@RequestMapping(value = "/afile/fileSwap.do")
	@ResponseBody
	public ItgMap fileSwap(ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		ItgMap returnMap = new ItgMap();
		ItgMap paramMap = CommUtil.getParameterEMap(request);
		int result = 0;
		try {
			// 파일 SWAP 처리
			result = jFileService.swapAttachFile(paramMap);

			// 파일 SWAP 처리 결과
			returnMap.put("result", result);

		} catch (IOException | SQLException e){
			returnMap.put("result", result);
		}
		return returnMap;
	}

	/**
	 * 파일을 다운로드 받는다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping(value = "/afile/fileDownload/{idx}")
	public ModelAndView fileDownload(@PathVariable String idx,JFileVO fileVO) {
		String fileIdx = CommUtil.getNumFromEncstr(idx);
		JFile downloadFile = jFileService.getFilebyIdx(fileIdx, fileVO.getUseSecurity());
        return new ModelAndView(JfileDownloadView.NAME, JfileDownloadView.MODELNAME, downloadFile);
	}

	/**
	 * 파일을 삭제 한다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping(value = "/afile/fileRemove/{idx}", method=RequestMethod.POST)
	@ResponseBody
	public ItgMap fileRemove(@PathVariable String idx, ModelMap model, HttpServletRequest request, HttpServletResponse response)    throws IOException, SQLException, RuntimeException {
		ItgMap returnMap = new ItgMap();
		int result = 0;
		// 파일 삭제처리

		String fileIdx = CommUtil.getNumFromEncstr(idx);
		result = jFileService.removeAttachFileByIdx(fileIdx);

		// 파일 삭제처리 결과
		returnMap.put("result", result);
		return returnMap;
	}

	/**
	 * 파일 인덱스를 세팅 한다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping(value = "/afile/fileIdxApply.do", method = RequestMethod.POST)
	@ResponseBody
	public ItgMap fileIdxApply(//ModelMap model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="fileIdxs[]", required=false) String[] fileIdxs,
			@RequestParam(value="delIdxs[]", required=false) String[] delIdxs
			)    throws IOException, SQLException, RuntimeException {

		ItgMap returnMap = new ItgMap();
		ItgMap paramMap = new ItgMap();

		int result = 0;
		paramMap.put("fileIdxs", fileIdxs);
		paramMap.put("delIdxs", delIdxs);
		result = jFileService.updateAttachFileDeleteYnByIdx(paramMap);

		returnMap.put("result", result);
		return returnMap;
	}

	/**
	 * 파일 미리보기 화면
	 * @param fileVO
	 * @return
	 */
	@RequestMapping(value = "/afile/preview/{idx}", method = RequestMethod.GET)
	public ModelAndView previewImage(@PathVariable String idx, JFileVO fileVO) {
		JFileDetails prevFileVO = null;

		prevFileVO = jFileService.getAttachFile(idx);

		JFile previewFile = prevFileVO.isImage() ?
				jFileService.getFileBySequence(prevFileVO.getFileId(), prevFileVO.getFileSeq(), prevFileVO.getUseSecurity()) : new JFile(getNoImagePath());
		return new ModelAndView(JfileDownloadView.NAME, JfileDownloadView.MODELNAME, previewFile);
	}

	@RequestMapping(value="/jFile/readAssociationImages.do")
	public ModelAndView readAssociationImages(JFileVO fileVO){
		List<JFileDetails> resultList = jFileService.getAttachFiles(fileVO.getFileId());
		JFile downloadFile = null;
		ModelAndView result = new ModelAndView();
		int list = Integer.parseInt(fileVO.getFileSeq());
		for (int i = 0; i < list; i++) {
			downloadFile = jFileService.getFilebyIdx(resultList.get(list-1).getFileIdx(), fileVO.getUseSecurity());
			result = new ModelAndView(JfileDownloadView.NAME, JfileDownloadView.MODELNAME, downloadFile);
		}
		return result;
	}

}