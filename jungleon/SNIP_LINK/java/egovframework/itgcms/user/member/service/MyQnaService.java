package egovframework.itgcms.user.member.service;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface MyQnaService {

	int selectMyQnaListTotCnt(DefaultVO searchVO) throws SQLException;

	List<MyQnaVO> selectMyQnaList(DefaultVO searchVO) throws SQLException;

	MyQnaVO selectMyQnaView(DefaultVO searchVO) throws SQLException;

	List<EgovMap> selectMyQnaViewPrevNext(DefaultVO searchVO) throws SQLException;

}
