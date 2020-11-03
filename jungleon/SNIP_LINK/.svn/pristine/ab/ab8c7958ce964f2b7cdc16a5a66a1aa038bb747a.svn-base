package egovframework.itgcms.mngr.member.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.itgcms.mngr.member.service.MngrCompanyMemberService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("mngrCompanyMemberService")
public class MngrCompanyMemberServiceImpl implements MngrCompanyMemberService {

	@Resource(name="mngrCompanyMemberMapper")
	private MngrCompanyMemberMapper mngrCompanyMemberMapper;

	@Override
	public int selectCompanyMemberListTotCnt(MemberVO searchVO) throws SQLException {
		return mngrCompanyMemberMapper.selectCompanyMemberListTotCnt(searchVO);
	}

	@Override
	public List<EgovMap> selectCompanyMemberList(MemberVO searchVO) throws SQLException {
		return mngrCompanyMemberMapper.selectCompanyMemberList(searchVO);
	}
	
	
}
