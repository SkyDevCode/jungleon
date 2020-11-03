package egovframework.itgcms.project.totalTable.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.project.totalTable.service.TotalTbSearchVO;
import egovframework.itgcms.project.totalTable.service.TotalTbVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("totalTableMapper")
public interface TotalTableMapper {

	int insertTotalTbData(TotalTbVO totalTbVO)  throws SQLException;

	String selectTotalTbMaxIdx() throws SQLException;

	List<TotalTbVO> selectTotalTbList(TotalTbSearchVO searchVO) throws SQLException;

	int selectTotalTbListTotCnt(TotalTbSearchVO searchVO) throws SQLException;

	TotalTbVO selectTotalTbView(TotalTbSearchVO searchVO) throws SQLException;

	int updateTotalTbView(TotalTbVO totalTbVO) throws SQLException;

	int deleteTotalTbView(TotalTbVO totalTbVO) throws SQLException;

	int deleteTotalTbMulti(TotalTbVO vo) throws SQLException;

	List<TotalTbVO> selectTotalTbListAll(TotalTbSearchVO searchVO) throws SQLException;

	List<EgovMap> selectMenuSubListByPcode(String id) throws SQLException;

}
