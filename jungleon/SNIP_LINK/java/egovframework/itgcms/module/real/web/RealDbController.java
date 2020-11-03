package egovframework.itgcms.module.real.web;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.module.real.service.RealDbService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class RealDbController {
	@Resource(name = "realDbService")
	private RealDbService realDbService;




	@ResponseBody
	@RequestMapping(value = "/web/real/usertest.ajax")
	public Map<String, Object> userPreview(HttpServletRequest request
			, HttpServletResponse response, Model model
			) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException{

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		realDbService.getmemList(paramMap);
		EgovMap returnMap = new EgovMap();

		return returnMap;
	}
	@ResponseBody
	@RequestMapping(value = "/web/real/normal.ajax")
	public Map<String, Object> normal(HttpServletRequest request
			, HttpServletResponse response, Model model
			) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException{

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		realDbService.migrationBoard2(paramMap);

		EgovMap returnMap = new EgovMap();


		return returnMap;
	}
	@ResponseBody
	@RequestMapping(value = "/web/real/imgBbs.ajax")
	public Map<String, Object> imgBbs(HttpServletRequest request
			, HttpServletResponse response, Model model
			) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException{

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		realDbService.migrationImgBoard(paramMap);

		EgovMap returnMap = new EgovMap();


		return returnMap;
	}
	@ResponseBody
	@RequestMapping(value = "/web/real/downCntUpdate.ajax")
	public Map<String, Object> downCntUpdate(HttpServletRequest request
			, HttpServletResponse response, Model model
			) throws IOException, SQLException, RuntimeException, NoSuchAlgorithmException{

		ItgMap paramMap = CommUtil.getParameterEMap(request);
		realDbService.downloadIncrease(paramMap);

		EgovMap returnMap = new EgovMap();


		return returnMap;
	}






}
