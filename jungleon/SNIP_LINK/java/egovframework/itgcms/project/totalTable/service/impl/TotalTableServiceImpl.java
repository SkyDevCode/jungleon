package egovframework.itgcms.project.totalTable.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.project.rent.service.RentVO;
import egovframework.itgcms.project.totalTable.service.TotalTableService;
import egovframework.itgcms.project.totalTable.service.TotalTbSearchVO;
import egovframework.itgcms.project.totalTable.service.TotalTbVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("totalTableService")
public class TotalTableServiceImpl implements TotalTableService {

	@Resource(name="totalTableMapper")
	TotalTableMapper totalTableMapper;

	@Override
	public String insertTotalTbData(TotalTbVO totalTbVO) throws SQLException {

		String bsIdx = totalTableMapper.selectTotalTbMaxIdx();
		totalTbVO.setBsIdx(bsIdx);
		int result = totalTableMapper.insertTotalTbData(totalTbVO);
		if(result < 1) {
			return null;
		}
		return bsIdx;
	}

	@Override
	public List<TotalTbVO> selectTotalTbList(TotalTbSearchVO searchVO) throws SQLException {

		return totalTableMapper.selectTotalTbList(searchVO);
	}

	@Override
	public int selectTotalTbListTotCnt(TotalTbSearchVO searchVO) throws SQLException {

		return totalTableMapper.selectTotalTbListTotCnt(searchVO);
	}

	@Override
	public TotalTbVO selectTotalTbView(TotalTbSearchVO searchVO) throws SQLException {

		return totalTableMapper.selectTotalTbView(searchVO);
	}

	@Override
	public int updateTotalTbView(TotalTbVO totalTbVO) throws SQLException {

		return totalTableMapper.updateTotalTbView(totalTbVO);
	}

	@Override
	public int deleteTotalTbView(TotalTbVO totalTbVO) throws SQLException {

		return totalTableMapper.deleteTotalTbView(totalTbVO);
	}

	@Override
	public int deleteTotalTbMulti(TotalTbSearchVO searchVO) throws SQLException {

		int cnt = 0;
		for(int i = 0; i < searchVO.getChkId().length; i++) {
			TotalTbVO vo = new TotalTbVO();
			vo.setBsIdx(searchVO.getChkId()[i]);
			vo.setDelid(CommUtil.getMngrMemId());
			int result = totalTableMapper.deleteTotalTbView(vo);
			if(result < 1) {
				throw new SQLException("삭제된 데이터가 없습니다 : bsIdx:" + vo.getBsIdx());
			}
			cnt ++;
		}
		return cnt;
	}

	@Override
	public List<TotalTbVO> selectTotalTbListAll(TotalTbSearchVO searchVO) throws SQLException {
		return totalTableMapper.selectTotalTbListAll(searchVO);
	}

	@Override
	public List<EgovMap> selectMenuSubListByPcode(String id) throws SQLException {
		return totalTableMapper.selectMenuSubListByPcode(id);
	}



}
