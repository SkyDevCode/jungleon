/**
  * @Class Name : CustomUtil.java
  * @Description : 공통 메소드
  *   수정일           수정자                   수정내용
  *  -------------------------------------------------------------
  *  2019. 5. 14.      bluejick             최초 생성
  */

package egovframework.itgcms.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.PrivateKey;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.crypto.Cipher;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.terracotta.agent.repkg.de.schlichtherle.io.File;

import com.google.gson.Gson;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MemberType;
import egovframework.itgcms.core.board.service.MainBoardVO;
import egovframework.itgcms.core.menu.service.MngrMenuVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class CustomUtil {

    public static String getMainPageBoard(List<MainBoardVO> boardList, String listType, int titleMaxLength){

    	StringBuffer returnHtml = new StringBuffer();
    	StringBuffer headHtml = new StringBuffer();
    	StringBuffer bodyHtml = new StringBuffer();
    	ItgMap boardMap;
    	String boardTypeClass = "n_l";
    	String bodyAttrTxt = "";

    	boolean h2Title = false; 		// h2 Title 사용여부
    	boolean divBtnMore = false; 	// BtnMore div 사용여부
    	boolean divBbox = false; 		// Bbox div 사용여부
    	boolean useStrong = false; 	// 첫번째 글의 강조여부 true:강조, false:강조안함
    	boolean liCont = false; 		// 리스트 contents 사용여부
    	boolean liMore = false; 		// 리스트 more 사용여부

    	/** 옵션설정 **/
    	switch (listType.toLowerCase()){

			case "t1":

				h2Title = true;
				divBbox = true;
				break;

			case "t2":

				h2Title = true;

				break;
			case "tab":

				h2Title = true;
				divBtnMore = true;
				//liCont = true;
				//liMore = true;

				break;
			default :
				break;
		}

    	/** html작성 **/

		if("tab".equalsIgnoreCase(listType)) {
			headHtml.append("<ul id=\"tabmenu\" class=\"mtab\">");
		}

    	for (int i = 0; i < boardList.size(); i++) {

    		MainBoardVO bTmp = boardList.get(i);
    		StringBuffer tempHtml = new StringBuffer();

    		if("tab".equalsIgnoreCase(listType)) { bodyAttrTxt = " id=\"tab"+(i+1)+"\""; }

    		tempHtml.append("<div class=\"latestBbs\" "+bodyAttrTxt+">");

    		try {
    			if ("gallery2".equalsIgnoreCase(bTmp.getBoardSkin())) {
    				boardTypeClass = "t_l";
    			} else if ("gallery".equalsIgnoreCase(bTmp.getBoardSkin())) {
    				boardTypeClass = "t_l";
    			} else if ("default".equalsIgnoreCase(bTmp.getBoardSkin())) {
    				boardTypeClass = "n_l";
    			}

    			if(h2Title) tempHtml.append("<h2 class=\"tit\">").append(bTmp.getBoardTitle()).append("</h2>");
    			if(divBtnMore) tempHtml.append("<div class=\"btn_more\"><a href=\"#\">더보기<span>+</span></a></div>");

    			tempHtml.append("<ul class=\"").append(boardTypeClass).append("\">");

        		for (int ii = 0 ; ii < bTmp.getBoardList().size() ; ii ++) {
        			boardMap = bTmp.getBoardList().get(ii);
        			tempHtml.append("<li>");
        			if (bTmp.getBoardSkin().startsWith("gallery")) {
        				String imgSrc = CommUtil.isNull(boardMap.get("bdSecret"),"").equalsIgnoreCase("Y") ?
        								"/resource/common/img/common/lock2.png" :
        								"/comm/download.do?f=".concat(CommUtil.getDownloadLink("", "gallery", CommUtil.getThumbFileName(CommUtil.isNull(boardMap.get("bdThumb1"),""), "B"), CommUtil.getThumbFileName(CommUtil.isNull(boardMap.get("bdThumb1"),""), "B")));
        				tempHtml.append("<a href=\"").append(bTmp.getAnchorHref()).append("?schM=view&amp;id=").append(CommUtil.isNull(boardMap.get("bdIdx"),"")).append("\">");
        				tempHtml.append("<p class=\"thumb\"><img src=\"").append(imgSrc).append("\"/></p>");
        				tempHtml.append("<p class=\"subj\">").append(CommUtil.cutString(CommUtil.getAntiHtml(CommUtil.isNull(boardMap.get("bdTitle"),""), "1"), 30, "...")).append("</p>");
        				tempHtml.append("</a>");
        				//break;
        			} else {
        				if (useStrong && ii == 0) {
       						tempHtml.append("<strong><a href=\"").append(bTmp.getAnchorHref()).append("?schM=view&amp;id=").append(CommUtil.isNull(boardMap.get("bdIdx"),"")).append("\">")
       						.append(CommUtil.cutString(CommUtil.getAntiHtml(CommUtil.isNull(boardMap.get("bdTitle"),""), "1").trim(), titleMaxLength, "...")).append("</a></strong>");
        				}else{
       						tempHtml.append("<p class=\"subj\"><a href=\"").append(bTmp.getAnchorHref()).append("?schM=view&amp;id=").append(CommUtil.isNull(boardMap.get("bdIdx"),"")).append("\">")
       								.append(CommUtil.cutString(CommUtil.getAntiHtml(CommUtil.isNull(boardMap.get("bdTitle"),""), "1").trim(), titleMaxLength, "...")).append("</a></p>");
       						tempHtml.append("<p class=\"date\">").append(CommUtil.printDatePattern(CommUtil.isNull(boardMap.get("regdt"),""), "yyyy-MM-dd")).append("</p>");
       						if(liCont) tempHtml.append("<p class=\"cont\"></p>");
       						if(liMore) tempHtml.append("<p class=\"more\"><a href=\"#\"></a></p>");
        				}
        			}
        			tempHtml.append("</li>");
        		}

        		if (bTmp.getBoardList().size()==0) {
        			tempHtml.append("<li><strong>등록된 게시글이 존재하지 않습니다.</strong></li>");
        		}

        		tempHtml.append("</ul>");
        		if(divBbox) tempHtml.append("<div class=\"bbox\"><a href=\"").append(bTmp.getAnchorHref()).append("\" class=\"more\"><span class=\"blind\">").append(bTmp.getBoardTitle()).append(" 더보기 </span></a></div>");
    		} catch (NullPointerException | IndexOutOfBoundsException e) {
    			tempHtml.append("latestBbs").append("\"><h2 class=\"tit\">&nbsp;</h2><ul class=\"n_l\"><li>게시판이 선택되지 않았습니다.</li></ul>");
    		}


    		tempHtml.append("</div>");


    		if("tab".equalsIgnoreCase(listType)) {

    			headHtml.append("<li "+ (i==0?"class=\"on\"":"")+"><a href=\"#\">"+bTmp.getBoardTitle()+"</a></li>");
    			bodyHtml.append(tempHtml.toString());

    		}else if ("t1".equalsIgnoreCase(listType)) {

    			bodyHtml.append("<li class=\"latestBbs\">");
    			bodyHtml.append("<div class=\"l t\">");
    			bodyHtml.append("	<h3>").append(bTmp.getBoardTitle()).append("</h3>");
    			bodyHtml.append("	<p>").append(bTmp.getBoardMemo()).append("</p>");
    			bodyHtml.append("	<a href=\"").append(bTmp.getAnchorHref()).append("\">더보기 &nbsp; +</a>");
    			bodyHtml.append("	<a href=\"").append(bTmp.getAnchorHref()).append("\" class=\"t0_ic\"><img src=\"/resource/templete/"+bTmp.getTempCode()+"/img/main/t0_ic1.png\" alt=\"더보기\"></a>");
    			bodyHtml.append("</div>");
    			bodyHtml.append("<div class=\"r\">");

    			bodyHtml.append(tempHtml.toString());

    			bodyHtml.append("</div>");
    			bodyHtml.append("</li>");

    		} else {
    			bodyHtml.append(tempHtml.toString());
    		}

    	}

		if("tab".equalsIgnoreCase(listType)) {
			headHtml.append("</ul>");
		}
    	returnHtml.append(headHtml);
    	returnHtml.append(bodyHtml);

    	return returnHtml.toString();
    }

	 /**
	  * 탭메뉴 링크
	 * @param msg
	 * @param script
	 * @return
	 */
	public static String getMenuTag(String siteCode, String pfullCode, String type){
		String returnTag = "";
		String[] codeArr = pfullCode.split(">");

		List menuList = (List) CommUtil.getFileObject("menulist", siteCode, "user/include/");

		returnTag = recusiveMenuA(menuList, codeArr, type);


		return returnTag;
	}

	public static String recusiveMenuA(List menuList, String[] codeArr, String type){

		String returnStr = "";
		String allmenulist = "<ul>";
		int depth = 0;
		String activeName = ""; //현재페이지를 표시하기 위한 태그
		String nextDepthStr = "";

		// depth 1은 사이트 코드
		// depth 2는 대메뉴, 3 중메뉴, 4 소메뉴
    	for(int i = 0; i < menuList.size(); i++){
    		MngrMenuVO menuVO = (MngrMenuVO)menuList.get(i);

    		if(!"0".equals(menuVO.getMenuUsetype())){
    			continue;//메뉴 표시 (menuUsetype != 0) 이면 메뉴 표출 안한다.
    		}
    		String idName = "id=\""+type+"_"+menuVO.getMenuCode()+"\"";
    		depth = Integer.parseInt(menuVO.getMenuDepth());
    		returnStr = "<li class=\"dp"+(depth-1)+"\">";

    		if(menuVO.getMenuCode().equals(codeArr[depth])) {
    			activeName = "<a href=\"javascript:;\">"+menuVO.getMenuName()+"</a>";
    			if(!menuVO.getMngrMenuList().isEmpty())	nextDepthStr = recusiveMenuA(menuVO.getMngrMenuList(), codeArr, type);

    		}
    		allmenulist += "<li>"+getMenuLink(menuVO,codeArr[1], idName)+"</li>";
    	}

    	allmenulist+="</ul>";

    	returnStr += activeName + allmenulist+"</li>"+nextDepthStr;

    	return returnStr;
	}

	private static String getMenuLink(MngrMenuVO menuVO, String siteCode, String idName){
		String url = "#none"; //구분값이 0,1,2,3,4,7 가 아니면 링크 없음.(5:컨텐츠없음,6:리비전컨텐츠)
		String str = "";
		// 메뉴타입에 따른 링크 구분
		//0 폴더, 4 링크 menuVO.getMenuUrl 로 링크
		if("0".equals(menuVO.getMenuType())
			|| "4".equals(menuVO.getMenuType())
				){
			url = menuVO.getMenuUrl();
		}else if("1".equals(menuVO.getMenuType()) //CMS /web/contents/코드로 링크
				|| "2".equals(menuVO.getMenuType()) //프로그램 /web/contents/코드로 링크
				|| "3".equals(menuVO.getMenuType()) //게시판 /web/contents/코드로 링크
				//||  "7".equals(menuVO.getMenuType()) // 인클루드링크 /web/contents/코드로 링크 - 3.07주소체계변경으로 인한 미사용처리
				){
			url = "/" + siteCode+"/contents/"+menuVO.getMenuCode()+".do";
		}
		if("".equals(url)) url = "#none";
		if("0".equals(menuVO.getMenuShowtype())){
			str += "<a href='"+url+"' "+idName+">";
		}else if("1".equals(menuVO.getMenuShowtype())){
			str += "<a href='"+url+"' target='_blank' title='"+menuVO.getMenuName()+" 바로가기 [새창으로 열림]' "+idName+">";
		}else if("2".equals(menuVO.getMenuShowtype())){
			str += "<a href='#none' onclick='fnObj.modalOpen(\""+url+"\");return false;' "+idName+">";
		}
		str += menuVO.getMenuName().replaceAll("&", "&amp;")+"</a>";
		return str;
	}

	public static PaginationInfo getPagenation(DefaultVO searchVO, int totCnt)  {
		PaginationInfo paginationInfo = new PaginationInfo();
		searchVO.setPageUnit(Integer.parseInt(searchVO.getViewCount()));//viewCount
//		searchVO.setPageSize(searchVO.getPageSize());//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)
		int page = Integer.parseInt(searchVO.getPage());

		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		paginationInfo.setTotalRecordCount(totCnt);
		return paginationInfo;
	}

	public static String getSnipErpFilePath(String path, String originalFilename) {
		if("".equals(CommUtil.isNull(path, ""))) return "";
		String[] arrPath = path.split("/");
		String folder = path.substring(0, path.lastIndexOf("/")+1);
		String filename = arrPath[arrPath.length -1];
		return CommUtil.getDownloadLink("", File.separator + "erp" + folder, filename, originalFilename);
	}

	public static String getSnipUploadPath(String path) {
		String filePath = "";
		Calendar cal = Calendar.getInstance();
		String sep = "/";
		filePath += path;
		filePath += sep + cal.get(Calendar.YEAR) + sep +( cal.get(Calendar.MONTH) + 1) + sep + cal.get(Calendar.DATE) ;
		return filePath;
	}

	public static String getSnipArea(String type, boolean isInside) {
		String strValue = "V007000001,V007000002,V007000003";
		String strText = "수정구,중원구,분당구";
		if(!isInside) {
			strValue += "V007000004";
			strText += "성남권외";
		}
		if("value".equals(type)) {
			return strValue;
		} else if("text".equals(type)) {
			return strText;
		} else {
			return "";
		}
	}

	public static List<HashMap<String, String>> getSnipAreaList(boolean isInside){
		String[] arrValues = getSnipArea("value", isInside).split(",");
		String[] arrTexts = getSnipArea("text", isInside).split(",");

		List<HashMap<String, String>> areaList = new ArrayList<HashMap<String, String>>();
		for(int i = 0; i < arrValues.length; i++) {
				HashMap<String, String> area = new HashMap<String, String>();
				area.put("value", arrValues[i]);
				area.put("text", arrTexts[i]);
				areaList.add(area);
		}

		return areaList;
	}

	public static String getSnipAddress2AreaCD(String address) {
		String result = "";
		if("".equals( CommUtil.isNull(address, ""))) return "";
		List<HashMap<String, String>> areaList = getSnipAreaList(false);
		for(int i = 0; i < areaList.size(); i++) {
			HashMap<String, String> area = areaList.get(i);
			if(area != null) {
				String value = area.get("value");
				String text = area.get("text");
				if(address.indexOf(text) > -1) {
					result = value;
					break;
				}
			}
		}
		return result;
	}

	public static String idMake(String str) {
		try {
			int count = getCount();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssSSS", new Locale("ko", "KO"));
			String formattedValue = formatter.format(new Date());
			String id = str + formattedValue + count;
			return id;
		} catch (Exception var5) {
			var5.printStackTrace();
			return str;
		}
	}

	private static synchronized int getCount() {
		int iCount = 0;
		++iCount;
		iCount = iCount < 1000 && iCount >= 100 ? iCount : 100;
		return iCount;
	}

	/**
	 * 월일(예, 01010 형식으로 파라메터 전달.
	 * 공휴일에 대당할 경우 공휴일명을 리턴.
	 * @param date(MMDD)
	 * @return
	 */
	public static String getHoliday(String date) {
		String[][] holidays = {{"0101","신정"},{"0301","삼일절"},{"0505","어린이날"},{"0606","현충일"},{"0815","광복절"},{"1003","개천절"},{"1009","한글날"},{"1225","크리스마스"}};
		if("".equals(CommUtil.isNull(date, ""))) {
			return "";
		}
		for(int i = 0; i < holidays.length; i++) {
			if(holidays[i][0].equals(date)) {
				return holidays[i][1];
			}
		}
		return "";
	}

	 /**
     * JSONArray를 List<Map>으로 리턴한다.
     * @param jsonArray
     * @return list
     */
    public static List<ItgMap> getListItgMapFromJsonArray( JSONArray jsonArray )
    {
        List<ItgMap> list = new ArrayList<ItgMap>();

        if( jsonArray != null )
        {
            int jsonSize = jsonArray.size();
            for( int i = 0; i < jsonSize; i++ )
            {
                ItgMap map = CustomUtil.getItgMapFromJsonObject( ( JSONObject ) jsonArray.get(i) );
                list.add( map );
            }
        }

        return list;
    }

    /**
     * JSONObject를 Map<String, Object>로 리턴한다.
     * @param jsonObj
     * @return map
     */
    @SuppressWarnings("unchecked")
	public static ItgMap getItgMapFromJsonObject( JSONObject jsonObj )
    {
    	ItgMap map = new ItgMap();

    	/*jsonObj.forEach((k, v) -> map.put(k, v));*/

    	Gson gson  = new Gson();
    	map = (ItgMap) gson.fromJson(jsonObj.toString(), map.getClass());

        return map;
    }

    /**
	 * string을 json 형태로 변환한다.
	 * @param map
	 * @return jsonObject
	 * @throws ParseException
	 */
	public static JSONArray getJsonArrayFromString(String jsonString) throws ParseException
	{
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( jsonString );
		JSONArray jsonArray = (JSONArray) obj;

		return jsonArray;
	}

	public static String getMobileAddHyphen(String number) {
		if("".equals(CommUtil.isNull(number, ""))) return "";
		if(number.length() == 10) {// 000-000-0000
			return String.format("%s-%s-%s", number.substring(0,3), number.substring(3,6), number.substring(6,10)) ;
		} else if(number.length() == 11) { // 000-0000-0000
			return String.format("%s-%s-%s", number.substring(0,3), number.substring(3,7), number.substring(7,11)) ;
		} else if(number.length() == 12) {
			return String.format("%s-%s-%s", number.substring(0,4), number.substring(4,8), number.substring(8,12)) ;
		} else {
			return number;
		}
	}

	public static String getHttpContents(String urlStr) {
		if("".equals(CommUtil.isNull(urlStr, ""))) return "";

		StringBuilder sb = new StringBuilder();
	    URL url;
	    InputStreamReader in = null;
	    BufferedReader reader;
	    HttpURLConnection urlConn;
		try {
			url = new URL(urlStr);
			urlConn = (HttpURLConnection) url.openConnection();
			if (urlConn.getResponseCode() < urlConn.HTTP_BAD_REQUEST) {
				in = new InputStreamReader(urlConn.getInputStream());
			} else {
				/* error from server */
				in = new InputStreamReader(urlConn.getErrorStream(), "UTF-8");
			}
			reader = new BufferedReader(in);
			String read = "";
			while((read = reader.readLine())!=null){
				sb.append(read);
				sb.append("\r\n");
			}
			reader.close();
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return sb.toString();
	}

	/**
	 * 수정페이지의 첨부파일 저장 처리.(jfile사용안함)
	 * 1. 신규 첨부가 있으면 신규 첨부 파일명으로 저장.
	 *    이전파일이 있으면 삭제(old)
	 * 2. 신규파일이 없으면
	 *    이전파일이 있을경우 이전파일명 저장.
	 *    이전파일이 없을경우 저장하지 않음.
	 * ex) CustomUtil.fileUploadUpdate(multiRequest, "idPhoto", CommUtil.isNull(itgMap.get("idPhotoOld"), ""), "consul")
	 * @param multiRequest
	 * @param newFileField : 신규 첨부파일 필드 명
	 * @param oldFileValue : old 첨부파일의 파일 이름(주의 필드명 아님)
	 * @param folder : 저장 폴더명
	 * @return
	 * @throws IOException
	 */
	public static String fileUploadUpdate(MultipartHttpServletRequest multiRequest, String newFileField, String oldFileValue, String folder) throws IOException {
		// 첨부 및 파일 교체.
		String curFilename = "";

		HashMap hmFile = CommUtil.fileUpload(multiRequest.getFileMap(), newFileField, folder, "", "");
		if(hmFile != null) { //첨부파일이 있으면 파일을 올림.
			curFilename = CommUtil.isNull(hmFile.get("F_SAVENAME"), "");
			if(!"".equals(oldFileValue)) { //이전 파일은 삭제.
				CommUtil.deleteFile(	CommUtil.getFileRoot("") + System.getProperty("file.separator")
				+ folder + System.getProperty("file.separator") + oldFileValue	);
			}
		} else if(hmFile == null && !"".equals(oldFileValue)) curFilename = oldFileValue;

		return curFilename;
	}

	public static boolean checkMemberType(MemberType memberType) {
		if(memberType == null ) {
			return false;
		}
		String memType = (String)RequestContextHolder.getRequestAttributes().getAttribute("memType", 1);
		return memberType.getCode().equals(memType);
	}
	public static String RSAdecrypt(PrivateKey privateKey, String securedValue) {

		 String decryptedValue = "";

		 try{

			Cipher cipher = Cipher.getInstance("RSA");

		   /**
			* 암호화 된 값은 byte 배열이다.
			* 이를 문자열 폼으로 전송하기 위해 16진 문자열(hex)로 변경한다.
			* 서버측에서도 값을 받을 때 hex 문자열을 받아서 이를 다시 byte 배열로 바꾼 뒤에 복호화 과정을 수행한다.
			*/
			byte[] encryptedBytes = hexToByteArray(securedValue);

			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
			decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.

		 }catch(Exception e){
		 }

		 return decryptedValue;
	}

	/**
	* 16진 문자열을 byte 배열로 변환한다.
	*/
	public static byte[] hexToByteArray(String hex) {
		if (hex == null || hex.length() % 2 != 0) {
			return new byte[]{};
		}

		byte[] bytes = new byte[hex.length() / 2];
		for (int i = 0; i < hex.length(); i += 2) {
			byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
			bytes[(int) Math.floor(i / 2)] = value;
		}
		return bytes;
	}
}
