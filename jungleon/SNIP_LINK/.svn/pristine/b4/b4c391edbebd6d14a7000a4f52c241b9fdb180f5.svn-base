package egovframework.itgcms.user.member.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.user.member.service.CleanAccuseService;
import egovframework.itgcms.user.member.service.CleanAccuseVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("cleanAccuseService")
public class CleanAccuseServiceImpl implements CleanAccuseService{

	@Resource(name="cleanAccuseMapper")
	CleanAccuseMapper cleanAccuseMapper;
	
	@Override
	public int selectCleanAccuseListTotCnt(DefaultVO searchVO) throws SQLException {
		return cleanAccuseMapper.selectCleanAccuseListTotCnt(searchVO);
	}

	@Override
	public List<CleanAccuseVO> selectCleanAccuseList(DefaultVO searchVO) throws SQLException {
		return cleanAccuseMapper.selectCleanAccuseList(searchVO);
	}

	@Override
	
	public CleanAccuseVO selectCleanAccuseView(DefaultVO searchVO) throws SQLException {
		return cleanAccuseMapper.selectCleanAccuseView(searchVO);
	}

	@Override
	public List<EgovMap> selectCleanAccuseViewPrevNext(DefaultVO searchVO) throws SQLException {
		return cleanAccuseMapper.selectCleanAccuseViewPrevNext(searchVO);
	}

	
}
