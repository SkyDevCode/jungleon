package egovframework.itgcms.common;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonParser;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.itgcms.core.board.service.BoardSearchVO;
import egovframework.itgcms.core.board.service.BoardService;
import egovframework.itgcms.core.menu.service.MngrMenuService;
import egovframework.itgcms.core.popup.service.MngrPopupSearchVO;
import egovframework.itgcms.core.popup.service.MngrPopupService;
import egovframework.itgcms.core.slides.service.MngrSlidesService;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class CommonController {


	/** MngrMenuService */
	@Resource(name = "mngrMenuService")
	private MngrMenuService mngrMenuService;
	/** BoardService */
	@Resource(name = "boardService")
	private BoardService boardService;

	/** MngrSlidesService */
	@Resource(name = "mngrSlidesService")
	private MngrSlidesService mngrSlidesService;

	/** MngrPopupService */
	@Resource(name = "mngrPopupService")
	private MngrPopupService mngrPopupService;

	private static final Logger logger = LogManager.getLogger(CommonController.class);

    /**
     * 파일명과 코드로 직접 이미지를 출력함
     * f=암호화된 파일명 c=파일 인덱스
     * @param request
     * @param response
     * @throws IOException, SQLException, RuntimeException
     */
    @RequestMapping(value="/comm/download.do")
    public void download(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException{
    	String f = CommUtil.isNull(request.getParameter("f"),""); //f 구조는 index::폴더명::저장파일명::원본파일명

    	if("".equals(f) ){
    		return;
    	}

    	String []arrFile = CommUtil.getFileDec(f).split("::");
    	if(arrFile.length < 3 ){
    		return;
    	}
    	String downIndex = arrFile[0];
    	String downFolder = arrFile[1];
    	String downFileName = arrFile[2];
    	String orgFileName = arrFile[3];
    	File file = new File(CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);

    	if (!file.exists()) {
    		logger.debug(file.getAbsolutePath());
    		response.setContentType("text/html;charset=UTF-8");
    		java.io.PrintWriter out = response.getWriter();
    		out.println(CommUtil.getAlertHtml("파일이 없습니다.","history.back();"));
    		return;
    	}

    	if (!file.isFile()) {
    		logger.debug(file.getAbsolutePath());
    		response.setContentType("text/html;charset=UTF-8");
    		java.io.PrintWriter out = response.getWriter();
    		out.println(CommUtil.getAlertHtml("파일이 없습니다.","history.back();"));
    		return;
    	}


//    	if(!"".equals(c)){
//    		HashMap hmParam = new HashMap();
//    		hmParam.put("F_SAVENAME", downFileName);
//    		hmParam.put("F_IDX",c);
//    		HashMap result = commonService.selectFileuploadView(hmParam);
//    		if(result != null && !"".equals(CommUtil.isNull(result.get("F_ORGNAME"),""))){
//    			orgFileName = CommUtil.isNull(result.get("F_ORGNAME"),"");
//    		}
//    	}

    	int fSize = (int)file.length();
    	if (fSize > 0) {
    	    BufferedInputStream in = null;
    	    FileInputStream  fi = null;

    	    try {
    	    	fi = new FileInputStream(file);
    	    	in = new BufferedInputStream(fi);

//    		response.setHeader("Content-Disposition", "attachment; filename=" + ("".equals(orgFileName) ? downFileName : orgFileName)); //new String(orgFileName.getBytes("euc-kr"),"8859_1"))
    		response.setContentType("application/unknown");
    		response.setHeader("Content-Disposition", "attachment; filename=" + ("".equals(orgFileName) ? downFileName : new String(orgFileName.getBytes("euc-kr"),"8859_1")));
    		response.setContentLength(fSize);
    		FileCopyUtils.copy(in, response.getOutputStream());
    	    } finally {
	    		if (in != null) {
	    		    try {
	    		    	in.close();
	    		    } catch (IOException ignore) {
	    		    	logger.error("예외 상황 발생");
	    		    }
	    		}
		    	fi.close();
    	    }
    	    response.getOutputStream().flush();
    	    response.getOutputStream().close();
    	}
    }
    @RequestMapping(value="/comm/download2.do")
    public void download2(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException{
    	String f = CommUtil.isNull(request.getParameter("f"),""); //f 구조는 index::폴더명::저장파일명::원본파일명

    	if("".equals(f) ){
    		return;
    	}

    	String []arrFile = CommUtil.getFileDec(f).split("::");
    	if(arrFile.length < 3 ){
    		return;
    	}
    	String downFolder = arrFile[1];
    	String downFileName = arrFile[2];
    	String orgFileName = arrFile[3];
    	File file = new File(CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);

    	if (!file.exists()) {
    		logger.debug(file.getAbsolutePath());
    		response.setContentType("text/html;charset=UTF-8");
    		java.io.PrintWriter out = response.getWriter();
    		out.println(CommUtil.getAlertHtml("파일이 없습니다.","history.back();"));
    		return;
    	}

    	if (!file.isFile()) {
    		logger.debug(file.getAbsolutePath());
    		response.setContentType("text/html;charset=UTF-8");
    		java.io.PrintWriter out = response.getWriter();
    		out.println(CommUtil.getAlertHtml("파일이 없습니다.","history.back();"));
    		return;
    	}


//    	if(!"".equals(c)){
//    		HashMap hmParam = new HashMap();
//    		hmParam.put("F_SAVENAME", downFileName);
//    		hmParam.put("F_IDX",c);
//    		HashMap result = commonService.selectFileuploadView(hmParam);
//    		if(result != null && !"".equals(CommUtil.isNull(result.get("F_ORGNAME"),""))){
//    			orgFileName = CommUtil.isNull(result.get("F_ORGNAME"),"");
//    		}
//    	}

    	int fSize = (int)file.length();
    	if (fSize > 0) {
    		BufferedInputStream in = null;
    		FileInputStream  fi = null;

    		try {
    			fi = new FileInputStream(file);
    			in = new BufferedInputStream(fi);

//    		response.setHeader("Content-Disposition", "attachment; filename=" + ("".equals(orgFileName) ? downFileName : orgFileName)); //new String(orgFileName.getBytes("euc-kr"),"8859_1"))
    			response.setContentType("application/unknown");
    			response.setHeader("Content-Disposition", "attachment; filename=" + ("".equals(orgFileName) ? downFileName : new String(orgFileName.getBytes("euc-kr"),"8859_1")));
    			response.setContentLength(fSize);
    			FileCopyUtils.copy(in, response.getOutputStream());
    		} finally {
    			if (in != null) {
    				try {
    					in.close();
    				} catch (IOException ignore) {
    					logger.error("예외 상황 발생");
    				}
    			}
    			fi.close();
    		}
    		response.getOutputStream().flush();
    		response.getOutputStream().close();
    	}
    }
    /**
     * 파일명과 코드로 직접 이미지를 출력함
     * f=파일명 c=코드명(tb_ 제외)
     * @param request
     * @param response
     * @throws IOException, SQLException, RuntimeException
     */
    @RequestMapping(value="/comm/viewImage.do")
    public void viewImage(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException{
    	String f = CommUtil.isNull(request.getParameter("f"),""); //f 구조는 index::폴더명::저장파일명::원본파일명

    	if("".equals(f) ){
    		return;
    	}

    	String []arrFile = CommUtil.getFileDec(f).split("::");
    	if(arrFile.length < 3 ){
    		return;
    	}
    	String downOption = arrFile[0];
    	String downFolder = arrFile[1];
    	String downFileName = arrFile[2];
    	String orgFileName = arrFile[3];

    	if(downFileName.startsWith("/")){ downFileName = downFileName.substring(1);}
    	if("thumb".equals(orgFileName)){
    		orgFileName = downFileName;
    		if(downFileName.split("/").length == 1){
    			downFileName = CommUtil.getThumbFileName(downFileName,"B");
    		}
    	}

    	File file = new File(CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);
    	logger.debug("이미지 파일 정보 : " + CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);

    	if (!file.exists()) {
    		file = new File(CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + orgFileName);
    		if (!file.exists()) {
    			logger.debug("이미지 파일 오류1 : " + CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);
    			return ;//throw new FileNotFoundException(CommUtil.getFileRoot()+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);
    		}
    	}
    	if (!file.isFile()) {
    		file = new File(CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + orgFileName);
	    	if (!file.isFile()) {
	    		logger.debug("이미지 파일 오류2 : " + CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);
	    		return ;//throw new FileNotFoundException(CommUtil.getFileRoot()+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);
	    	}
    	}

    	int fSize = (int)file.length();
    	if (fSize > 0) {
    		BufferedInputStream in = null;
    		FileInputStream fis = null;
    		try {
    			fis = new FileInputStream(file);
    			in = new BufferedInputStream(fis);
    			//file 확장자가없으면 orgFileName에서 확장자를 가져오도록 함.
    			if(downFileName.indexOf(".") == -1) downFileName = orgFileName;
    			String ext = (downFileName.substring(downFileName.lastIndexOf(".") + 1));
        	    	String mimetype = "application/octet-stream"; //"application/x-msdownload"
        	    	if(CommUtil.regEx("(jpg|jpeg|gif|png|bmp)", ext.toLowerCase())){
        	    		mimetype = "image/"+ext.toLowerCase();
        	    	}else{
        	    		return ; //이미지 보여주는 메소드이므로 이미지가 아니면 리턴.
        	    	}
        	    	response.setBufferSize(fSize);
    		response.setContentType(mimetype);
    			response.setHeader("Content-Disposition", "attachment; filename=" + downFileName);
    			response.setContentLength(fSize);
    			FileCopyUtils.copy(in, response.getOutputStream());
    		} finally {
    			if (in != null) {
    				try {
    					in.close();
	    		    } catch (IOException ignore) {
	    		    	logger.error("예외 상황 발생");
	    		    }
    			}
    			fis.close();
    		}
    		response.getOutputStream().flush();
    		response.getOutputStream().close();
    	}
    }
    @RequestMapping(value="/comm/viewImage2.do")
    public void viewImage2(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException{
    	String f = CommUtil.isNull(request.getParameter("f"),""); //f 구조는 index::폴더명::저장파일명::원본파일명

    	if("".equals(f) ){
    		return;
    	}
    	String []arrFile = CommUtil.getFileDec(f).split("::");
    	if(arrFile.length < 3 ){
    		return;
    	}
    	String downFolder = arrFile[1];
    	String downFileName = arrFile[2];
    	String orgFileName = arrFile[2];
    	/*String downFolder = "gallery";
    	String downFileName = CommUtil.isNull(request.getParameter("f"),"");
    	String orgFileName =downFileName;*/

    	File file = new File(CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);
    	logger.debug("이미지 파일 정보 : " + CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);

    	if (!file.exists()) {
    		file = new File(CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + orgFileName);
    		if (!file.exists()) {
    			logger.debug("이미지 파일 오류1 : " + CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);
    			return ;//throw new FileNotFoundException(CommUtil.getFileRoot()+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);
    		}
    	}
    	if (!file.isFile()) {
    		file = new File(CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + orgFileName);
    		if (!file.isFile()) {
    			logger.debug("이미지 파일 오류2 : " + CommUtil.getFileRoot("")+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);
    			return ;//throw new FileNotFoundException(CommUtil.getFileRoot()+ System.getProperty("file.separator") + downFolder + System.getProperty("file.separator") + downFileName);
    		}
    	}

    	int fSize = (int)file.length();
    	if (fSize > 0) {
    		BufferedInputStream in = null;
    		FileInputStream fis = null;
    		try {
    			fis = new FileInputStream(file);
    			in = new BufferedInputStream(fis);
    			//file 확장자가없으면 orgFileName에서 확장자를 가져오도록 함.
    			if(downFileName.indexOf(".") == -1) downFileName = orgFileName;
    			String ext = "jpg";
    			String mimetype = "application/octet-stream"; //"application/x-msdownload"
    			if(CommUtil.regEx("(jpg|jpeg|gif|png|bmp)", ext.toLowerCase())){
    				mimetype = "image/"+ext.toLowerCase();
    			}else{
    				return ; //이미지 보여주는 메소드이므로 이미지가 아니면 리턴.
    			}
    			response.setBufferSize(fSize);
    			response.setContentType(mimetype);
    			response.setHeader("Content-Disposition", "attachment; filename=" + downFileName);
    			response.setContentLength(fSize);
    			FileCopyUtils.copy(in, response.getOutputStream());
    		} finally {
    			if (in != null) {
    				try {
    					in.close();
    				} catch (IOException ignore) {
    					logger.error("예외 상황 발생");
    				}
    			}
    			fis.close();
    		}
    		response.getOutputStream().flush();
    		response.getOutputStream().close();
    	}
    }

    public String readContentFrom(String textFileName) throws IOException, SQLException, RuntimeException {
        java.io.BufferedReader bufferedTextFileReader = new java.io.BufferedReader(new java.io.FileReader(textFileName));
        StringBuilder contentReceiver = new StringBuilder();

        String line = null;
        try{
            while ((line = bufferedTextFileReader.readLine()) != null) {
            	contentReceiver.append(line+"\n");
            }
        }catch(IOException e){
        	logger.error("예외 상황 발생");
        }finally{
            bufferedTextFileReader.close();
        }

        return contentReceiver.toString();
    }

    public void createFile(String textFileName, String content) throws IOException, SQLException, RuntimeException{
    	java.io.FileWriter fw = null;
    	java.io.BufferedWriter bufferedWriter = null;
        try{
        	fw = new java.io.FileWriter(textFileName);
        	bufferedWriter = new java.io.BufferedWriter(fw);
        	bufferedWriter.write(content);
        }catch(IOException e){
        	logger.error("예외 상황 발생");
        }finally{
        	bufferedWriter.close();
        	fw.close();
        }
    }

    @RequestMapping(value="/comm/sessionKeep.do")
    public void sessionKeep(HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session) throws IOException, SQLException, RuntimeException{
    	//세션 유지를 위한 가상페이지.
    	//등록 페이지에 10분마다 요청하도록함. 실제로 아무일도 하지않음.
    }

    @RequestMapping(value="/post.do")
    public void post(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, SQLException, RuntimeException{
    	String path = "c:\\post\\";
    	File folder = new File(path);
    	File []files = folder.listFiles();
    	StringBuffer sb = new StringBuffer();
    	long  z_no = 0l;
    	for(File file : files){

    		java.io.File file1 = null;
    		java.io.FileInputStream file1is = null;
    		java.io.InputStreamReader isr = null;
    		BufferedReader in = null;

    		try{
    			file1 = new java.io.File(path + file.getName());

	    		file1is = new java.io.FileInputStream(file1);
	    		isr = new java.io.InputStreamReader(file1is,"euc-kr");
	    		in = new BufferedReader(isr);

			    String s = null;
			    int i = 0;
	    		while ( (s = in.readLine()) != null ) {
	    			if(i>0){
	    				z_no++;
	    				String []str = s.split("\\|");
	    				HashMap hmParam = new HashMap();//#Z_NO#,#Z_ZIPCODE#,#Z_SIDO#,#Z_GUGUN#,#Z_UPMYUN#,#Z_ROAD#,#Z_BUILDING#,#Z_BUILDING_SUB#,#Z_DELIVER#
	    				//우편번호|우편일련번호|시도|시도영문|시군구|시군구영문|읍면|읍면영문|도로명코드|도로명|도로명영문|지하여부|건물번호본번|건물번호부번|건물관리번호|다량배달처명|시군구용건물명|법정동코드|법정동명|리|산여부|지번본번|읍면동일련번호|지번부번
	//    				135807|	022|		서울특별시|Seoul|강남구|Gangnam-gu|||116803122001|개포로|Gaepo-ro|0|303|0|1168010300106530000019474|현대1차아파트|현대1차아파트|1168010300|개포동||0|653|01|0
	    				hmParam.put("Z_NO", z_no);
	    				hmParam.put("Z_ZIPCODE", str[0]);
	    				hmParam.put("Z_SIDO", str[2]);
	    				hmParam.put("Z_GUGUN", str[4]);
	    				hmParam.put("Z_UPMYUN", str[6]);
	    				hmParam.put("Z_ROAD", str[9]);
	    				hmParam.put("Z_BUILDING", str[12]);
	    				hmParam.put("Z_BUILDING_SUB", str[13]);
	    				hmParam.put("Z_DELIVER", str[14]);
	    				//commService.insertKoh("common.insertTestZip", hmParam);
	    				//break;
	    			}
	    			i++;

	    		}
    		}catch(IOException e){
            	logger.error("예외 상황 발생");
            }finally{
            	file1is.close();
            	isr.close();
            	in.close();
            }

    	}
    }

    @RequestMapping(value="/comm/qr.do")
    public void qr(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException, WriterException{
    	//response.sendRedirect("/web/main/index.do");
    	QRCodeWriter qrCodeWriter = new QRCodeWriter();
    	String port  = "";
    	if(!"80".equals(request.getServerPort())) port = ":" + request.getServerPort();
    	String text = "MECARD:URL:" + request.getParameter("url");
    	/*
    	MECARD:N:이름;
    	ORG:회사;
    	TEL:전화;
    	EMAIL:이메일;
    	NOTE:노트(설명);
    	URL:링크주소;
    	ADR:주소;
    	*/
    	text = new String(text.getBytes("UTF-8"), "ISO-8859-1");
    	BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, 200, 200);
    	response.setContentType("image/png; charset=UTF-8");
    	response.setHeader("Content-Disposition", "filename=noename.png");
    	//out.clear();
    	//out = pageContext.pushBody();
    	MatrixToImageWriter.writeToStream(bitMatrix, "png", response.getOutputStream());
    }


	/**
	 * 슬라이드 셋 인클루드 처리
	 * @param mngrProgramSearchVO
	 * @param model
	 * @param programVO
	 * @return
	 * @throws IOException, SQLException, RuntimeException
	 */
	@RequestMapping(value = "/module/slides/userInclude_SLIDES.do")
	public ModelAndView userInclude_SLIDES(HttpServletRequest request, HttpSession session) throws IOException, SQLException, RuntimeException {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("itgcms/global/module/slides/userInclude_SLIDES");

		String root = request.getParameter("siteCode");

		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(root);

		ItgMap paramVO = new ItgMap();
		paramVO.put("slidesIdx", CommUtil.isNull(siteconfigVO.getSlidesIdx(),"0"));
		paramVO.put("useyn", "Y");
		List<ItgMap> slidesItemList = mngrSlidesService.mngrSlideItemList(paramVO);
		mav.addObject("slidesItemList", slidesItemList);

		return mav;
	}

	/**
	 * 기능 단순테스트용
	 * @param mngrProgramSearchVO
	 */
	@RequestMapping(value = "/comm/test.do")
	public String test(HttpServletRequest request, HttpSession session, ModelMap model) throws IOException, SQLException, RuntimeException {

		return "comm/tester/test";
	}

	@RequestMapping(value = "/comm/testproc.do")
	@ResponseBody
	public EgovMap testproc(HttpServletRequest request, HttpSession session) throws IOException, SQLException, RuntimeException {


		ItgMap paramMap = CommUtil.getParameterEMap(request);
		String result = "";
		String param1 = CommUtil.isNull(paramMap.get("param1"),"");
		String param2 = CommUtil.isNull(paramMap.get("param2"),"");
		if("1".equals(param1)) {
			result = CommUtil.seedEnc256(param2);
		}else if("2".equals(param1)) {
			result = CommUtil.seedDec256(param2);
		}

		EgovMap returnMap = new EgovMap();

		returnMap.put("result", result);

		return returnMap;
	}


	@RequestMapping(value = "/comm/banner.ajax")
	public String selectBannerAjax( ModelMap model) throws IOException, SQLException, RuntimeException {
		MngrPopupSearchVO mngrPopupSearchVO = new MngrPopupSearchVO();
		mngrPopupSearchVO.setSchPopupType("3"); //배너
		mngrPopupSearchVO.setFirstIndex(0);
		mngrPopupSearchVO.setLastIndex(15);
		model.addAttribute("popupBannerList", mngrPopupService.getMngrPopupList(mngrPopupSearchVO));
		return "itgcms/user/main/banner";
	}

	/**
	 * facebook access_token 유효기간이 지났을 경우 새로운 토큰을 받기위한 기능
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	@ResponseBody
	@RequestMapping(value = "/comm/getFBaccessToken.ajax")
	public String getFBaccessToken( ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {
		String user_access_token = request.getParameter("access_token");
		if("".equals(CommUtil.isNull(user_access_token, ""))) {
			return CommUtil.doComplete(model,"오류","파라메터가 누락되었습니다", "history.back();");
		}
		JSONObject data = newFBaccessToken(user_access_token);
		return (String)data.get("access_token");
	}

	/**
	 * facebook 게시물을 가져온다.
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(value = "/comm/getFB.ajax")
	public String getFB( ModelMap model)  {
		String urlStr = "https://graph.facebook.com/251986281613163/posts?fields=attachments,created_time&limit=10";
//		String urlStr = "https://graph.facebook.com/251986281613163/posts?fields=id,created_time,message_tags,message,picture";
		JSONObject json = newFBaccessToken("");
//		urlStr += "&access_token=" + json.get("access_token"); //영구키 생성으로 새로 받는 작업 안함.
		urlStr += "&access_token=EAADyXwOByjoBAMPXZClDoaqCjZB2SbAH3DXGX4xkZCWbkP59Mu9rk3rw47pxYs1phPSH4ttAKWAXDP2SmKajjZAk5Fn3ZAUVXSWvLfLOgz7LwJ6JAJvk07NbZCYzXZAwB7CNixG9BMmW7ylZCdrOEzyChiQeVlYGBLM0l1wWxOq6TDmcPZAVgPaUk";

		String data = CustomUtil.getHttpContents(urlStr);
		JSONParser parser = new JSONParser();
		try {
			Object obj = parser.parse(data);
			json = (JSONObject)obj;
		} catch (ParseException e) {
			e.printStackTrace();
		}

		ModelMap resultModel = new ModelMap();
		resultModel.addAttribute("resultList", json);

		return data;
	}


	/**
	 * facebook으로부서 access_token을 가져온다.
	 * @param user_access_token
	 * @return
	 * @throws ParseException
	 */
	private JSONObject newFBaccessToken(String user_access_token)  {
		String access_token = EgovProperties.getProperty("sns.facebookAccessToken");
		access_token = CommUtil.isNull(access_token, "EAADyXwOByjoBAD7zF9B3sL5y5T9c2SbgCIHLUd7kMBifTYczYxFogVjiQT0mZCZCXha5plW9JAZAqnz7JVct5l3MS75t085cfpeCwlT5oos3VxKWNgNsUdnLw5SZCuJy6axtIiUvsRADaaUtuAQXuriugOUv9CVs61yosY3U59S9JduA9s8r");
		user_access_token = CommUtil.isNull(user_access_token, access_token);

		String clientId = EgovProperties.getProperty("sns.facebookClientId");
		String clientSecret = EgovProperties.getProperty("sns.facebookClientSecret");
		String urlStr = "https://graph.facebook.com/oauth/access_token";
		urlStr += "?grant_type=fb_exchange_token";
		urlStr += "&client_id=" + CommUtil.isNull(clientId, "266489894652474");
		urlStr += "&client_secret=" + CommUtil.isNull(clientSecret, "bafe6771973710d63344d8faa69d2d06");
		urlStr += "&fb_exchange_token=" + user_access_token;
		String data = CustomUtil.getHttpContents(urlStr);
		JSONParser parser = new JSONParser();
		JSONObject json = new JSONObject();
		try {
			Object obj = parser.parse(data);

			json = (JSONObject)obj;
		} catch(ParseException e) {
			e.printStackTrace();
		}
		//System.out.println(data);
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/comm/increaseReadnum.ajax")
	public String increaseReadnum(@ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO, ModelMap model) throws IOException, SQLException  {

		boardService.modIncreaseReadnum(boardSearchVO); //조회수 증가

		String data = "11";
		return data;
	}

	@RequestMapping(value = "/vnet/fe/snv/main/ER_index.do", method = RequestMethod.GET)
	public String home1()  throws IOException, SQLException, RuntimeException {

		String returnUrl = "redirect:/SNIP/main/index.do";

		return returnUrl;
	}

}
