package egovframework.itgcms.link.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.itgcms.common.ItgMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("linkMapper")
public interface LinkMapper {
	List<Map<String, Object>> selectLinkList(HashMap<String, Object> param) throws IOException, SQLException;

	List<Map<String, Object>> selectCalendarList(HashMap<String, Object> param) throws IOException, SQLException;

	List<Map<String, Object>> selectCalendarBdList(HashMap<String, Object> param) throws IOException, SQLException;

	ItgMap selectFileVO(HashMap<String, Object> param) throws IOException, SQLException;

	void updateBoardUpdateProc(ItgMap gMap) throws IOException, SQLException;


}
