package egovframework.itgcms.core.member.service.impl;

import java.sql.SQLException;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.core.member.service.MemberExtService;
import egovframework.itgcms.core.member.service.MemberVO;

@Service("memberExtService")
public class MemberExtServiceImpl implements MemberExtService {

	@Resource(name="memberExtMapper")
	MemberExtMapper memberExtMapper;	
	
	@Override
	public MemberVO selectMemberExtViewByDI(MemberVO paramVO) throws SQLException {
		return memberExtMapper.selectMemberExtViewByDI(paramVO);
	}

	
}
