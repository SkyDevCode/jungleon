package egovframework.itgcms.mngr.authority.web;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.main.service.MngrMainService;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * @파일명 : MngrAuthorityController.java
 * @파일정보 : 컨텐츠 권한 관리
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 9. 4. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Controller
public class MngrAuthorityController {

	/** mngrMainService */
    @Resource(name = "mngrMainService")
    private MngrMainService mngrMainService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** mngrCodeService */
    @Resource(name = "mngrCodeService")
    private MngrCodeService mngrCodeService;

    /** MngrSiteService */
	@Resource(name = "mngrSiteService")
	private MngrSiteService mngrSiteService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;


	private static final Logger logger = LogManager.getLogger(MngrAuthorityController.class);

}
