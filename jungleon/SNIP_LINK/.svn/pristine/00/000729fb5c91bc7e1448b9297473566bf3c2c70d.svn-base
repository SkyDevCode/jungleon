package egovframework.itgcms.module.real.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.ItgMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
@Mapper("realDbMapper")
public interface RealDbMapper {

	public ItgMap getEnc(ItgMap params) throws SQLException;
	public ItgMap getmemInfo(ItgMap params) throws SQLException;
	public List<ItgMap> getmemList(ItgMap paramMap)throws SQLException;
	public ItgMap getConcernList(ItgMap paramMap)throws SQLException;
	public List<?> getBoardList(ItgMap paramMap)throws SQLException;
	public List<?> getFileInfoList(ItgMap paramMap)throws SQLException;
	ItgMap memberPossible(ItgMap params);
	int memberInsert(ItgMap params);
	int personInsert(ItgMap params);
	int memberUpdate(ItgMap params);
	int downloadIncrease(ItgMap params);
}
