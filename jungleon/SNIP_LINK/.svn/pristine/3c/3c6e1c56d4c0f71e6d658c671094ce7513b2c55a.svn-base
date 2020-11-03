package egovframework.itgcms.user.member.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.user.member.service.CleanAccuseVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("cleanAccuseMapper")
public interface CleanAccuseMapper {

	int selectCleanAccuseListTotCnt(DefaultVO searchVO) throws SQLException ;

	List<CleanAccuseVO> selectCleanAccuseList(DefaultVO searchVO) throws SQLException ;

	CleanAccuseVO selectCleanAccuseView(DefaultVO searchVO) throws SQLException ;

	List<EgovMap> selectCleanAccuseViewPrevNext(DefaultVO searchVO) throws SQLException ;


}
