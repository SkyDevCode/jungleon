package egovframework.itgcms.project.rent.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.project.rent.service.RentSearchVO;
import egovframework.itgcms.project.rent.service.RentVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("rentMapper")
public interface RentMapper {

	int selectRentListTotCnt(RentSearchVO searchVO) throws SQLException;

	List<RentVO> selectRentList(RentSearchVO searchVO) throws SQLException;

	RentVO selectRentView(RentSearchVO searchVO) throws SQLException;

	int deleteRentProc(RentVO vo)  throws SQLException;

	int updateRent(RentVO rentVO) throws SQLException;

	int updateRentStatus(RentVO rentVO) throws SQLException;

	List<EgovMap> selectRentCountGroupByDay(EgovMap paramMap) throws SQLException;

	List<RentVO> selectRentListWhereReserveDate(EgovMap paramMap)  throws SQLException;

	List<RentVO> selectRentReserveTime(EgovMap paramMap) throws SQLException;

	int insertRentReserveData(RentVO rentVO) throws SQLException;

	String selectRentMaxIdx() throws SQLException;


}
