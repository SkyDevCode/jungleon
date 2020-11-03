package egovframework.itgcms.module.migration.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.module.migration.service.MigrationService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @파일명 : MigrationController.java
 * @파일정보 : 파일정보수정 MigrationController
 * @수정이력
 * @수정자    수정일       수정내용
 * @------- ------------ ----------------
 * @bluej  2018.12.13 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 3.0.7 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class MigrationController {

	private final Logger LOGGER = Logger.getLogger(this.getClass());


	/** MngrManagerService */
	@Resource(name = "migrationService")
	private MigrationService migrationService;

	@RequestMapping(value = "/comm/comm_migration_306to307.ajax")
	@ResponseBody
	public EgovMap commMigration306to307(HttpServletRequest request, HttpSession session) throws IOException, SQLException, RuntimeException {


		ItgMap paramMap = CommUtil.getParameterEMap(request);
		String result = "";
		String param1 = CommUtil.isNull(paramMap.get("param1"),"");
		String param2 = CommUtil.isNull(paramMap.get("param2"),"");

		String loginId = CommUtil.isNull(CommUtil.getMngrMemId(),"itgood");
		paramMap.put("loginId", loginId);

		migrationService.managerSiteCodeMigration(paramMap);


		EgovMap returnMap = new EgovMap();

		returnMap.put("result", result);

		return returnMap;
	}

}
