package egovframework.itgcms.user.member.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("gonggoReqMapper")
public interface GonggoReqMapper {

	public int selectGoggoReqListTotCnt(DefaultVO searchVO) throws SQLException ;

	public List<EgovMap> selectGoggoReqList(DefaultVO searchVO) throws SQLException ;

	public List<EgovMap> selectYearList(DefaultVO searchVO)  throws SQLException ;

	public int selectGoggoListTotCnt(DefaultVO searchVO) throws SQLException ;
	public int selectGoggoListTotCnt2(DefaultVO searchVO) throws SQLException ;
	public int selectGoggoListTotCnt3(DefaultVO searchVO) throws SQLException ;

	public List<EgovMap> selectGoggoList(DefaultVO searchVO) throws SQLException ;
	public List<EgovMap> selectGonggoViewPrevNext(DefaultVO searchVO) throws SQLException ;
	public EgovMap selectGoggoView(DefaultVO searchVO) throws SQLException ;
	public int gonggoViewCntIncrease(DefaultVO searchVO) throws SQLException ;


}
