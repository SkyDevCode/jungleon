package egovframework.itgcms.module.migration.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.module.migration.service.MigrationService;
import egovframework.itgcms.util.CommUtil;

/**
 * @파일명 : MigrationServiceImpl.java
 * @파일정보 : 파일정보수정 MigrationServiceImpl
 * @수정이력
 * @수정자    수정일       수정내용
 * @------- ------------ ----------------
 * @bluej  2018.12.13 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 3.0.7 Copyright (C) ITGOOD All right reserved.
 */

@Service("migrationService")
public class MigrationServiceImpl implements MigrationService {

	private final Logger LOGGER = Logger.getLogger(this.getClass());

	@Resource(name="migrationMapper")
	private MigrationMapper migrationMapper;

	@Override
	public void managerSiteCodeMigration(ItgMap paramMap) throws IOException, SQLException {
		// TODO Auto-generated method stub

		paramMap.put("delyn", "N");

		List<?> managerlist = migrationMapper.getManagerList(paramMap);

		for(int i=0; i<managerlist.size(); i++) {

			ItgMap manager = (ItgMap) managerlist.get(i);
			String siteList = CommUtil.isNull(manager.get("siteCode"), "");
			if(!"".equals(siteList)) {
				String[] siteArry = siteList.split(",");
				for(String site : siteArry) {

					ItgMap siteParamMap = new ItgMap();
					siteParamMap.put("siteCode", site);
					siteParamMap.put("mngId", manager.get("mngId"));
					siteParamMap.put("siteCode", site);
					siteParamMap.put("loginId", paramMap.get("loginId"));
					migrationMapper.putManagerSite(siteParamMap);
				}
			}
		}
	}
}
