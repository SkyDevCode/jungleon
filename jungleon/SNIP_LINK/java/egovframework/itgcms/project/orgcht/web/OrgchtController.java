package egovframework.itgcms.project.orgcht.web;

import java.io.IOException;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.manager.service.MngrManagerService;
import egovframework.itgcms.module.organization.service.OrganizationService;
import egovframework.itgcms.util.CommUtil;

@Controller
public class OrgchtController {

	@Autowired
	OrganizationService organizationService;

	@Resource(name = "mngrManagerService")
	private MngrManagerService mngrManagerService;


	/********************** S:사용자 **********************/
	@RequestMapping(value = "/{siteCode}/module/{menuCode}_orgchtList.do")
	public String selectUserOrgchtList(@PathVariable String siteCode, @PathVariable String menuCode, ModelMap model, HttpServletRequest request
			) throws IOException, SQLException, RuntimeException {

		return "itgcms/project/orgcht/userOrgchtList";
	}

	/**
	 * 조직도 부서 보기
	 * @param model
	 * @param request
	 * @return String
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */

	@RequestMapping(value = "/{siteCode}/module/{menuCode}_orgchtDept_view.do")
	public String selectOrgchtDeptView(@PathVariable String menuCode, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException{

		ItgMap itgMap = CommUtil.getParameterEMap(request);
		itgMap.put("schCode", itgMap.get("schId"));
		itgMap.put("memType", "USER");

		model.addAttribute("orgResult", organizationService.selectOrganizationView(itgMap));

		return "itgcms/project/orgcht/orgchtDept_view";
	}

	/**
	 * 조직도 관리자 보기
	 * @param model
	 * @param request
	 * @return String
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */

	@RequestMapping(value = "/{siteCode}/module/{menuCode}_orgchtMng_view.do")
	public String selectOrgchtMngView(@PathVariable String menuCode, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException{

		ItgMap itgMap = CommUtil.getParameterEMap(request);
		itgMap.put("schCode", itgMap.get("schId"));
		itgMap.put("memType", "USER");

		model.addAttribute("orgResult", organizationService.selectOrganizationView(itgMap));
		mngrManagerService.selOrgManager(model, itgMap);

		return "itgcms/project/orgcht/orgchtMng_view";
	}

	/**
	 * 조직도 검색 관리자 보기
	 * @param model
	 * @param request
	 * @return String
	 * @throws IOException
	 * @throws SQLException
	 * @throws RuntimeException
	 */

	@RequestMapping(value = "/{siteCode}/module/{menuCode}_orgchtSchMng_view.do")
	public String selectOrgchtSchMngView(@PathVariable String menuCode, ModelMap model, HttpServletRequest request) throws IOException, SQLException, RuntimeException{

		ItgMap itgMap = CommUtil.getParameterEMap(request);
		itgMap.put("schFld", itgMap.get("schFld"));
		itgMap.put("schStr", itgMap.get("schStr"));
		itgMap.put("memType", "USER");

		mngrManagerService.selectOrgchtSchMngView(model, itgMap);

		return "itgcms/project/orgcht/orgchtMng_view";
	}

}
