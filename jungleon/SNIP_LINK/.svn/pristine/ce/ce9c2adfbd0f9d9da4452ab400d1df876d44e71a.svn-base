package egovframework.itgcms.user.member.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.user.member.service.MyQnaService;
import egovframework.itgcms.user.member.service.MyQnaVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("myQnaService")
public class MyQnaServiceImpl implements MyQnaService
{

	@Resource(name="myQnaMapper")
	MyQnaMapper myQnaMapper;

	@Override
	public int selectMyQnaListTotCnt(DefaultVO searchVO) throws SQLException {

		return myQnaMapper.selectMyQnaListTotCnt(searchVO);
	}

	@Override
	public List<MyQnaVO> selectMyQnaList(DefaultVO searchVO) throws SQLException {

		return myQnaMapper.selectMyQnaList(searchVO);
	}

	@Override
	public MyQnaVO selectMyQnaView(DefaultVO searchVO) throws SQLException {

		return myQnaMapper.selectMyQnaView(searchVO);
	}

	@Override
	public List<EgovMap> selectMyQnaViewPrevNext(DefaultVO searchVO) throws SQLException {

		return myQnaMapper.selectMyQnaViewPrevNext(searchVO);
	}

}
