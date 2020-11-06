package egovframework.itgcms.user.member.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.user.member.service.CleanAccuseVO;
import egovframework.itgcms.user.member.service.MyQnaVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("myQnaMapper")
public interface MyQnaMapper {

	int selectMyQnaListTotCnt(DefaultVO searchVO) throws SQLException ;

	List<MyQnaVO> selectMyQnaList(DefaultVO searchVO) throws SQLException ;

	MyQnaVO selectMyQnaView(DefaultVO searchVO) throws SQLException ;

	List<EgovMap> selectMyQnaViewPrevNext(DefaultVO searchVO) throws SQLException ;

}
