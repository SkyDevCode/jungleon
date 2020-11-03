package egovframework.itgcms.user.member.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.user.member.service.GonggoReqService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("gonggoReqService")
public class GonggoReqServiceImpl implements GonggoReqService{
	@Resource(name="gonggoReqMapper")
	GonggoReqMapper gonggoReqMapper;

	@Override
	public int selectGoggoReqListTotCnt(DefaultVO searchVO) throws SQLException {
		return gonggoReqMapper.selectGoggoReqListTotCnt(searchVO);
	}

	@Override
	public List<EgovMap> selectGoggoReqList(DefaultVO searchVO) throws SQLException {
		return gonggoReqMapper.selectGoggoReqList(searchVO);
	}

	@Override
	public List<EgovMap> selectYearList(DefaultVO searchVO) throws SQLException {
		return gonggoReqMapper.selectYearList(searchVO);
	}

	@Override
	public int selectGoggoListTotCnt(DefaultVO searchVO) throws SQLException {
		return gonggoReqMapper.selectGoggoListTotCnt(searchVO);
	}

	@Override
	public List<EgovMap> selectGoggoList(DefaultVO searchVO) throws SQLException {
		return gonggoReqMapper.selectGoggoList(searchVO);
	}

	@Override
	public EgovMap selectGoggoView(DefaultVO searchVO) throws SQLException {
		return gonggoReqMapper.selectGoggoView(searchVO);
	}

	@Override
	public int gonggoViewCntIncrease(DefaultVO searchVO) throws SQLException {
		return gonggoReqMapper.gonggoViewCntIncrease(searchVO);
	}

	@Override
	public List<EgovMap> selectGonggoViewPrevNext(DefaultVO searchVO) throws SQLException {
		return gonggoReqMapper.selectGonggoViewPrevNext(searchVO);
	}

	@Override
	public int selectGoggoListTotCnt2(DefaultVO searchVO) throws SQLException {
		return gonggoReqMapper.selectGoggoListTotCnt2(searchVO);
	}

	@Override
	public int selectGoggoListTotCnt3(DefaultVO searchVO) throws SQLException {
		return gonggoReqMapper.selectGoggoListTotCnt3(searchVO);
	}


}
