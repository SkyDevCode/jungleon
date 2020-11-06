package egovframework.itgcms.project.sosqna.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.project.sosqna.service.SOSQnaService;
import egovframework.itgcms.project.sosqna.service.SOSQnaVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("sosQnaService")
public class SOSQnaServiceImpl implements SOSQnaService{

	@Resource(name="sosQnaMapper")
	SOSQnaMapper sosQnaMapper;
	
	@Override
	public int selectSOSQnaListTotCnt(DefaultVO searchVO) throws SQLException {
		return sosQnaMapper.selectSOSQnaListTotCnt(searchVO);
	}

	@Override
	public List<SOSQnaVO> selectSOSQnaList(DefaultVO searchVO) throws SQLException {
		return sosQnaMapper.selectSOSQnaList(searchVO);
	}

	@Override
	public SOSQnaVO selectSOSQnaView(DefaultVO searchVO) throws SQLException {
		return sosQnaMapper.selectSOSQnaView(searchVO);
	}

	@Override
	public List<SOSQnaVO> selectSOSQnaViewPrevNext(DefaultVO searchVO) throws SQLException {
		return sosQnaMapper.selectSOSQnaViewPrevNext(searchVO);
	}

	@Override
	public List<EgovMap> selectCoFileList(String fileSeq) throws SQLException {
		return sosQnaMapper.selectCoFileList(fileSeq);
	}


	
	
}
