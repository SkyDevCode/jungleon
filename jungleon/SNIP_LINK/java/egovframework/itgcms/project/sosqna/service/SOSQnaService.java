package egovframework.itgcms.project.sosqna.service;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface SOSQnaService {

	int selectSOSQnaListTotCnt(DefaultVO searchVO) throws SQLException;

	List<SOSQnaVO> selectSOSQnaList(DefaultVO searchVO) throws SQLException;

	SOSQnaVO selectSOSQnaView(DefaultVO searchVO) throws SQLException;

	List<SOSQnaVO> selectSOSQnaViewPrevNext(DefaultVO searchVO) throws SQLException;

	List<EgovMap> selectCoFileList(String fileSeq) throws SQLException;

}
