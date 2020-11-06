package egovframework.itgcms.project.rent.service;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface RentService {

	int selectRentListTotCnt(RentSearchVO searchVO) throws SQLException;

	List<RentVO> selectRentList(RentSearchVO searchVO) throws SQLException;

	RentVO selectRentView(RentSearchVO searchVO) throws SQLException;

	int deleteRentProc(RentVO rentVO) throws SQLException;
	
	int deleteRentMultiProc(RentSearchVO searchVO) throws SQLException;

	int updateRent(RentVO rentVO) throws SQLException;

	int updateRentStatus(RentVO rentVO) throws SQLException;

	List<EgovMap> selectRentCountGroupByDay(EgovMap paramMap) throws SQLException;

	List<RentVO> selectRentListWhereReserveDate(EgovMap paramMap) throws SQLException;

	List<RentVO> selectRentReserveTime(EgovMap paramMap) throws SQLException;

	String insertRentReserveData(RentVO rentVO) throws SQLException;


}
