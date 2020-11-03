package egovframework.itgcms.link.web;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.link.service.LinkService;
import egovframework.itgcms.module.jfile.service.impl.JFileVO;
import egovframework.itgcms.util.ConvertToHtml;

@Controller
public class LinkController {

	@Resource(name = "linkService")
	private LinkService linkService;


	@ResponseBody
	@RequestMapping(value = "/web/link/userPreview.ajax")
	public Object userPreview(HttpServletRequest request
			, HttpServletResponse response, Model model
			, @RequestParam HashMap<String, Object> param
			,@ModelAttribute JFileVO fileVo
			) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException{

		ItgMap result = linkService.selectFileVO(param);


		String fileMask = (String)result.get("fileMask");

		String str = (String)result.get("fileName");
		String[] extension = str.split("\\.");
		String ext = "";
		if (extension.length>2) {
			ext = extension[extension.length-1];
		}else{
			ext = extension[1];
		}


		String fileMaskExt = fileMask + "." + ext;
		String fileFolder = (String)result.get("fileFolder");
		ConvertToHtml cvt = new ConvertToHtml();

		/* 실서버 */
		String outputPath = "F:/SNIP_WEB/WEB_DATA/SNIP/html/";
		int outputValue = cvt.convertToHtml("F:/SNIP_WEB/WEB_DATA/SNIP/COMMON/jfile/"+fileFolder+"/"+fileMask, outputPath, fileMaskExt);

		/*개발서버*/
		/*String outputPath = "D:/WEB_DATA/DEV/SNIP/html/";
		int outputValue = cvt.convertToHtml("D:/WEB_DATA/DEV/SNIP/COMMON/jfile/"+fileFolder+"/"+fileMask, outputPath, fileMaskExt);*/

		/*로컬서버
		String outputPath = "D:/CUBE307/work/snip/SNIP_LINK/webapp/data/html/";
		int outputValue = cvt.convertToHtml("D:/CUBE307/work/snip/SNIP_LINK/webapp/data/COMMON/jfile/"+fileFolder+"/"+fileMask, outputPath, fileMaskExt);*/

		result.put("fileMaskExt", fileMaskExt);

		return result;
	}
	@ResponseBody
	@RequestMapping(value = "/web/link/userPreview2.ajax")
	public Object userPreview2(HttpServletRequest request
			, HttpServletResponse response, Model model
			, @RequestParam HashMap<String, Object> param
			,@ModelAttribute JFileVO fileVo
			) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException{

		ItgMap result =new ItgMap();


		ConvertToHtml cvt = new ConvertToHtml();

		/* 실서버 */
		String outputPath = "F:/SNIP_WEB/WEB_DATA/SNIP/html/";
		int outputValue = cvt.convertToHtml("F:/SNIP_WEB/WEB_DATA/SNIP/COMMON/gallery/"+param.get("path1"), outputPath, param.get("path2")+"");
		/*개발서버*/
		/*String outputPath = "D:/WEB_DATA/DEV/SNIP/html/";
		int outputValue = cvt.convertToHtml("D:/WEB_DATA/DEV/SNIP/COMMON/jfile/"+fileFolder+"/"+fileMask, outputPath, fileMaskExt);*/

		/*로컬서버
		String outputPath = "D:/CUBE307/work/snip/SNIP_LINK/webapp/data/html/";
		int outputValue = cvt.convertToHtml("D:/CUBE307/work/snip/SNIP_LINK/webapp/data/COMMON/gallery/"+param.get("path1"), outputPath, param.get("path2")+"");*/

		result.put("fileMaskExt", param.get("path2"));

		return result;
	}
	/*@ResponseBody
	@RequestMapping({"/web/link/userPreview.ajax"})
	public Object userPreview(HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam HashMap<String, Object> param, @ModelAttribute JFileVO fileVo)
			throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException {
		ItgMap result = this.linkService.selectFileVO(param);
		String fileMask = (String) result.get("fileMask");
		String fileName = (String) result.get("fileName");
		String str = (String) result.get("fileName");
		String[] extension = str.split("\\.");
		String ext = extension[1];
		String fileMaskExt = fileMask + "." + ext;
		String fileFolder = (String) result.get("fileFolder");
		ConvertToHtml cvt = new ConvertToHtml();
		String outputPath = "F:/SNIP_WEB/WEB_DATA/SNIP/html/";
		cvt.convertToHtml("F:/SNIP_WEB/WEB_DATA/SNIP/COMMON/jfile/" + fileFolder + "/" + fileMask, outputPath,
				fileMaskExt);
		result.put("fileMaskExt", fileMaskExt);
		return result;
	}
	@ResponseBody
	@RequestMapping({"/web/link/userPreview2.ajax"})
	public Object userPreview2(HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam HashMap<String, Object> param, @ModelAttribute JFileVO fileVo)
					throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException {
		ItgMap result = new ItgMap();

		ConvertToHtml cvt = new ConvertToHtml();
		String outputPath = "F:/SNIP_WEB/WEB_DATA/SNIP/html/";
		cvt.convertToHtml("F:/SNIP_WEB/WEB_DATA/SNIP/COMMON/gallery/"+param.get("path1"), outputPath, param.get("path2")+"");
		result.put("fileMaskExt",  param.get("path2"));
		return result;
	}*/

}
