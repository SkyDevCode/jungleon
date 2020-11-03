package egovframework.itgcms.project.sosqna.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.project.sosqna.service.SOSQnaVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("sosQnaMapper")
public interface SOSQnaMapper {

	int selectSOSQnaListTotCnt(DefaultVO searchVO) throws SQLException ;

	List<SOSQnaVO> selectSOSQnaList(DefaultVO searchVO) throws SQLException ;

	SOSQnaVO selectSOSQnaView(DefaultVO searchVO) throws SQLException ;

	List<SOSQnaVO> selectSOSQnaViewPrevNext(DefaultVO searchVO) throws SQLException ;

	List<EgovMap> selectCoFileList(String fileSeq) throws SQLException ;
}
