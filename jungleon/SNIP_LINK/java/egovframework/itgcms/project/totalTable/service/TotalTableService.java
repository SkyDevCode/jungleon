package egovframework.itgcms.project.totalTable.service;

import java.sql.SQLException;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface TotalTableService {

	String insertTotalTbData(TotalTbVO totalTbVO) throws SQLException;

	List<TotalTbVO> selectTotalTbList(TotalTbSearchVO searchVO) throws SQLException;

	int selectTotalTbListTotCnt(TotalTbSearchVO searchVO) throws SQLException;

	TotalTbVO selectTotalTbView(TotalTbSearchVO searchVO) throws SQLException;

	int updateTotalTbView(TotalTbVO totalTbVO) throws SQLException;

	int deleteTotalTbView(TotalTbVO totalTbVO) throws SQLException;

	int deleteTotalTbMulti(TotalTbSearchVO searchVO) throws SQLException;

	List<TotalTbVO> selectTotalTbListAll(TotalTbSearchVO searchVO) throws SQLException;

	List<EgovMap> selectMenuSubListByPcode(String id) throws SQLException;

}
