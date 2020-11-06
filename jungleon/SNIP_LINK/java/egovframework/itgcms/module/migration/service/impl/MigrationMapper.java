package egovframework.itgcms.module.migration.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.ItgMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명 : MigrationMapper.java
 * @파일정보 : 마이그레이션용 interface
 * @수정이력
 * @수정자    수정일       수정내용
 * @------- ------------ ----------------
 * @bluej  2018.12.13 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 3.0.7 Copyright (C) ITGOOD All right reserved.
 */

@Mapper("migrationMapper")
public interface MigrationMapper {


	List<?> getManagerList(ItgMap paramMap)throws SQLException;

	int putMember(ItgMap paramMap)throws SQLException;
	int putManagerSite(ItgMap paramMap)throws SQLException;

	int putBoard(ItgMap paramMap)throws SQLException;

	int putFileInfo(ItgMap paramMap)throws SQLException;
}
