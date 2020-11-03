package egovframework.itgcms.project.rent.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.project.rent.service.RentSearchVO;
import egovframework.itgcms.project.rent.service.RentService;
import egovframework.itgcms.project.rent.service.RentVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("rentService")
public class RentServiceImpl implements RentService{

	@Resource(name="rentMapper")
	RentMapper rentMapper;

	@Override
	public int selectRentListTotCnt(RentSearchVO searchVO) throws SQLException {
		return rentMapper.selectRentListTotCnt(searchVO);
	}

	@Override
	public List<RentVO> selectRentList(RentSearchVO searchVO) throws SQLException {
		return rentMapper.selectRentList(searchVO);
	}

	@Override
	public RentVO selectRentView(RentSearchVO searchVO) throws SQLException {
		return rentMapper.selectRentView(searchVO);
	}

	
	
	@Override
	public int updateRent(RentVO rentVO) throws SQLException {
		return rentMapper.updateRent(rentVO);
	}
	

	@Override
	public int updateRentStatus(RentVO rentVO) throws SQLException {
		return rentMapper.updateRentStatus(rentVO);
	}

	@Override
	public int deleteRentProc(RentVO rentVO) throws SQLException {
		return rentMapper.deleteRentProc(rentVO);
	}

	@Override
	public int deleteRentMultiProc(RentSearchVO searchVO) throws SQLException {
		int cnt = 0;
		for(int i = 0; i < searchVO.getChkId().length; i++) {
			RentVO vo = new RentVO();
			vo.setrIdx(searchVO.getChkId()[i]);
			vo.setDelid(CommUtil.getMngrMemId());
			int result = rentMapper.deleteRentProc(vo);
			if(result < 1) {
				throw new SQLException("삭제된 데이터가 없습니다 : Rent rIdx:" + vo.getrIdx());
			}
			cnt ++;
		}
		return cnt;
	}

	@Override
	public List<EgovMap> selectRentCountGroupByDay(EgovMap paramMap) throws SQLException {
		return rentMapper.selectRentCountGroupByDay(paramMap);
	}

	@Override
	public List<RentVO> selectRentListWhereReserveDate(EgovMap paramMap) throws SQLException {
		return rentMapper.selectRentListWhereReserveDate(paramMap);
	}

	@Override
	public List<RentVO> selectRentReserveTime(EgovMap paramMap) throws SQLException {
		return rentMapper.selectRentReserveTime(paramMap);
	}

	@Override
	public String insertRentReserveData(RentVO rentVO) throws SQLException {
		String rIdx = rentMapper.selectRentMaxIdx();
		rentVO.setrIdx(rIdx);
		int result = rentMapper.insertRentReserveData(rentVO);
		if(result < 1) {
			return null;
		}
		return rIdx;
	}

	
}
